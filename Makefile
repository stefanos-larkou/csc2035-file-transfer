#******** DO NOT EDIT THIS FILE ********#
# make csc2035 assignment2 network project
SHELL = /bin/sh

CC ?= cc

CFLAGS := -Wall
LDFLAGS =

# may have to edit the following if not on Linux or MacOS
os := $(shell uname)
ifeq ($(os),Linux)
    CFLAGS +=-g -std=c99 -D_GNU_SOURCE
    LDFLAGS +=-lm
endif

all: clean rft_client rft_server
.PHONY: all

test: test_rft_client_util
	pkill $< || true
	./$<
.PHONY: test

clean_test: 
	-rm -f test_rft_client_util
	-rm -f test_rft_client_util.o
.PHONY: clean_test

clean: clean_test
	-rm -f rft_client
	-rm -f rft_server
	-rm -f *.o
	-rm -rf out/nm
	-rm -rf out/wt
	-rm -rf out*
.PHONY: clean

rft_client: rft_client.c rft_util.o rft_client_util.o rft_client_logging.o

rft_server: rft_server.c rft_util.o

test_rft_client_util: test_rft_client_util.c rft_util.o rft_client_util.o \
    rft_client_logging.o munit.o  



