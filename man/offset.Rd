% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/offset.R
\name{offset}
\alias{offset}
\alias{offset_N}
\alias{offset_E}
\alias{offset_S}
\alias{offset_W}
\title{Offset a bag of cells by some rows or columns.}
\usage{
offset(bag, cells, direction, n = NULL, boundary = NULL, edge = FALSE,
  include = FALSE)

offset_N(bag, cells, n = NULL, boundary = NULL, edge = FALSE,
  include = FALSE)

offset_E(bag, cells, n = NULL, boundary = NULL, edge = FALSE,
  include = FALSE)

offset_S(bag, cells, n = NULL, boundary = NULL, edge = FALSE,
  include = FALSE)

offset_W(bag, cells, n = NULL, boundary = NULL, edge = FALSE,
  include = FALSE)
}
\arguments{
\item{bag}{Data frame. The original selection, including at least the columns
'row' and 'column', which are numeric/integer vectors.}

\item{cells}{Data frame. All the cells in the sheet, among which to offset
the bag (extensions beyond existing cells will be padded with blank cells).
Must include at least the columns 'row' and 'column', as well as any columns
referred to by the boundary formula.}

\item{direction}{Character vector length 1. The direction in which to offset,
among the compass directions "N", "E", "S", "W", where "N" is north (up).}

\item{n}{Integer vector length 1, >= 0. The number of rows/cols to offset by
in the given direction.}

\item{boundary}{Formula to express a boundary condition.  `~ col <= 50` would
go up to the 50th column.  NAs are treated the same as FALSE, but with a
warning.}

\item{edge}{Logical vector length 1. Whether to require the boundary formula
to be TRUE along the entire leading edge of the bag that is being offset}

\item{include}{Logical vector length 1. Whether to include in the extension
the first cell (and its row/col of fellow cells) at which the boundary
condition is met.}
}
\description{
A bag of data cells is a data frame with at least the
columns 'row' and 'col', as well as any others that carry information about
the cells, e.g. their values.  The position of this bag may be moved across
the sheet, exchanging the cells which are included in the bag.  Non-existant
cells will be padded, so chains of offets preserve the shape of the original
bag.
}
\details{
A bag may have ragged rows or ragged cols. Gaps will be filled in,
even when n = 0.
}
\section{Functions}{
\itemize{
\item \code{offset_N}: Offset a bag of cells to the north

\item \code{offset_E}: Offset a bag of cells to the east

\item \code{offset_S}: Offset a bag of cells to the south

\item \code{offset_W}: Offset a bag of cells to the west
}}

\examples{
# Load some pivoted data
(x <- purpose$`NNW WNW`)
# Make a tidy representation
cells <- tidytable(x, rownames = FALSE, colnames = FALSE)
cells <- cells[!is.na(cells$character), ] # Introduce 'holes' in the data
# Select an L-shape with gaps
bag <- dplyr::filter(cells, row \%in\% 3:4, col \%in\% 1:2)
# Offset, notice the L has been squared-off (padded)
offset_N(bag, cells, 1)
# Select a particular cell
cell <- cells[which(cells$row == 3 & cells$col == 3), ]
# Offset the selection downwards, stopping before the NA.
offset_S(cell, cells, boundary = ~ is.na(character))
# Offset the selection right, up to and including the fifth column.
offset_E(cell, cells, boundary = ~ col == 5, include = TRUE)
# Offset the selection beyond the existing cells
offset_E(cell, cells, 15)
# This doesn't work inside formulas, because it would mean testing the
# boundary formula on every possible cell in the given direction
\dontrun{offset_E(cell, cells, boundary = ~ col == 15)}
cell <- cells[which(cells$row == 7 & cells$col \%in\% 1:2), ]
offset_N(cell, cells, boundary = ~ !is.na(character), edge = TRUE)
}
