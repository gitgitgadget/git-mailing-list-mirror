Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808971A23AE
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738187449; cv=none; b=onzE+5vOK/0gQSzTwpjPT/ee8gVcncImLUaeHfIPRESugS7i6Ha01G0FVF4NyNaInoTf2T/BifEzty1u/XwkaSid2Dj/YQE0ggBsT7meNNI3zbp7F5x49zRxdkU2RyOq709W6Chn7+v5JvHX2AoLcKt4wXmv2g7l4TQtBLp4GFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738187449; c=relaxed/simple;
	bh=tpE5noD5W4vOq6JDq+hEWyQyz05Yuk7FkxOHUrxwpD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erPY++c9tQOQFIP3yDRFPEj95ladYLCI/Mb0jjVxcoIamkgcYmPnkiYKFFegRfZoAEZjHunyjcTg/cqIn+otv325602lDdnyjCZuZcvr6e6bE5Z6UlJR1DQrWm+wxKlLBuWWU4XDdXpJTBDqC1UuBVSMSmQ23thBQPwLNqy1gOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=psjzUmKM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="psjzUmKM"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-218cf85639eso3287265ad.3
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738187447; x=1738792247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFyRL1FHeJUN5ynlIyYQNeiQrwZqElJCDT/CqLYAp8Y=;
        b=psjzUmKMdm6Q8DOO60mwVOkvbJQIErxdYq54qYkI0xCGtfo9o/ehTh7c20N9CXt2lX
         quC+hgeIyvOP8EoWuEZ3C0u25U9QcQu/j+OuqJ5fJ1uYAZcSLCFdOjRpE1ow/1Il9xer
         rbw3lQGd0IdU4qKZiQqowiyCYxylIE9kjTzTW6f+YyagsZQiDWQyx1nn5E4lOCG08lmr
         r4WGOTH86H5awUFWXQ7T4WFT/t3eu6ZPNh7gPUmTDGXwxPN/woJUfebh/7vADCbe1fZz
         92yAkxyir7yeZYGBe5106/E4okWm02hmkqsdn3xumFkM4w4FEktZG+KKSxfXmAIss9Yo
         Q2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738187447; x=1738792247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFyRL1FHeJUN5ynlIyYQNeiQrwZqElJCDT/CqLYAp8Y=;
        b=XB3iS+hyKwg+T3mp9zIR3UtZgiICuoxPGlmfsLZErN2xFYHEkrT1PUDvdDnSezg0nq
         CpEoxfe5S0YbfzgxZ+FRdQltnn7NpKIEmZ2bDFnbb5guPwCOfYpeV0dVNqt8MhvPgBFU
         3tcBNsD7m1AqMNiK8TRHaax2ku4ZMIdaRvGPjdI+dZc/cr22mQiOCXGYk9KnVug5g/Xy
         mbCNDJL8AsTwVPzdaZnPI0fa4IQ/xIR1pGHpiwzajwhaJ4/8SCdoJ9jEWcrj+ms+NSTU
         mGBvULePqjspI75bKQe8KVird29WQZfqh4P0imABeosYzIYjjUcLqC0xSIMP+8HAPbap
         aoZg==
X-Gm-Message-State: AOJu0YzrCZfOeGFAF17CoH2wrvdw2C+dgzgOefk74H6cEm05icAE0TOn
	2LvMZJ1jgcUrzqSUc4lsIWgF7iVy/nQqmLj4V3297KkE4Worz5LQjZqZrvmy8bTU+pAglLwHELV
	8MpDYpDxGj4cwxHZI6p5WZ4FDY6tnJWkEY9XuR/G2x/UvjnPLLv99bUUD4ibEuNReX9csQ45zHi
	Duh+Tc2ZrWf1rxd6C2sM+CUAbqWXQobGxp5oZNSLM=
X-Google-Smtp-Source: AGHT+IFRTPEfnCUjg+RCMHVJ8BYXgVaEVXI6ZnQU0SckzspYQnIEoODUZ2wTSWGzeB65ypHMs+csXyoZValWAw==
X-Received: from pgbbm23.prod.google.com ([2002:a65:6e97:0:b0:7fc:2b57:38f5])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4c8a:b0:1e1:d22d:cf38 with SMTP id adf61e73a8af0-1ed7a640da8mr8140859637.21.1738187446613;
 Wed, 29 Jan 2025 13:50:46 -0800 (PST)
Date: Wed, 29 Jan 2025 13:50:40 -0800
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <cover.1738187176.git.steadmon@google.com>
Subject: [PATCH v9 0/4] Introduce libgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"

This series provides two small Rust wrapper libraries around parts of
Git: "libgit-sys", which exposes a few functions from libgit.a, and
"libgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/jj-vcs/jj

There is known NEEDSWORK, but I feel that they can be addressed in
follow-up changes, rather than in this series. If you feel otherwise,
please let me know:

* Investigate alternative methods of managing symbol visibility &
  renaming.

* Figure out symbol versioning

Changes in V9:
* Properly initialize Makefile var LIBGIT_PUB_OBJS.

* Pass the correct pointer to free in libgit_configset_free().

Changes in V8:
* Define a private libgit_config_set struct to avoid excessive casting
  in public_symbol_export.c.

* Style fixes: merge some Makefile rules, limit rule line length by
  defining intermediate variables, add initial empty comment line, add
  linebreaks in function definitions.

Changes in V7:
* Moved the ConfigSet implementation in libgit-rs to a `config` module.

* Added doc comments for ConfigSet and its methods.

* Fix meson builds by adding new object files to `libgit_sources`

* Moved INCLUDE_LIBGIT_RS Makefile changes earlier in the series, so
  that we can make it optional to compile some of the libgitpub sources.
  Squashed V6 patch 5/5 into this series' patch 4/4.

* Don't publicly export FFI types in libgit-rs.

* Removed extraneous `-r` argument to $(RM) in the clean rules.

* Added TODO reminder in Cargo.toml about removing Cargo.lock once we
  hit a certain minimum supported Rust version.

* Style cleanup in public_symbol_export.c

Changes in V6:
* Rebased onto current master, since V5 was several months old.

* Move libgit-sys out of libgit-rs; while this sort of nesting is common
  in Rust crates with standalone repositories, it doesn't make as much
  sense when they're contained in the larger Git project's repo.

* Standardize the naming of some of the Makefile targets to always
  include a dash in the "-rs" or "-sys" suffixes.

* Clean up READMEs and crate descriptions in preparation for
  uploading to crates.io.

Changes in V5:
* When building with INCLUDE_LIBGIT_RS defined, add
  "-fvisibility=hidden" to CFLAGS. This allows us to manage symbol
  visibility in libgitpub.a without causing `make all` to rebuild from
  scratch due to changing CFLAGS.

* Avoid using c_int in the higher-level Rust API.

* Remove libgitpub.a and intermediate files with `make clean`.

Changes in V4:
* Drop V3 patch #3, which added wrappers around repository
  initialization and config access. These are not well-libified, and
  they are not necessary for JJ's proof-of-concept use case, so let's
  avoid exporting them for now.

* Set a minimum supported Rust version of 1.63. Autodetect whether our
  Rust version has c_int and c_char types; if not, define them
  ourselves.

* When building libgitpub.a via build.rs, set DEVELOPER=1 to catch
  additional errors at build time.

* In build.rs, use the make_cmd crate to portable select the correct
  invocation of GNU Make.

* Follow naming standards for _alloc() and _free() functions.

* Use String instead of CString in higher-level API.

* Move libgit_configset_alloc() and libgit_configset_free() out of
  upstream Git, to the libgitpub shim library.

* In libgitpub, initialize libgit_config_set structs in the _alloc()
  function rather than with a separate _init() function.

* Remove unnecessary comments in libgit-sys showing where the wrapped
  functions were originally defined.

* Fix clippy lint: don't reborrow configfile path references.

* Various typo fixes and `cargo fmt` fixes.

Changes in V3:
* Renamed cgit-rs to libgit-rs and cgit-sys to libgit-sys

* Makefile cleanup, particularly adding config.mak options that
  developers can set to run Rust builds and tests by default (Patch 6)

* Provide testdata configs for unit tests

* ConfigSet API now uses &Path instead of &str -- more ergonomic for
  Rust users to pass in and errors out if the path string isn't UTF-8

* Fixed unresolved dependency on libz in Cargo.toml


Calvin Wan (1):
  libgit: add higher-level libgit crate

Josh Steadmon (3):
  common-main: split init and exit code into new files
  libgit-sys: introduce Rust wrapper for libgit.a
  libgit-sys: also export some config_set functions

 .gitignore                                |   2 +
 Makefile                                  |  50 ++++++++++
 common-exit.c                             |  26 ++++++
 common-init.c                             |  63 +++++++++++++
 common-init.h                             |   6 ++
 common-main.c                             |  83 +----------------
 contrib/libgit-rs/Cargo.lock              |  77 ++++++++++++++++
 contrib/libgit-rs/Cargo.toml              |  17 ++++
 contrib/libgit-rs/README.md               |  13 +++
 contrib/libgit-rs/build.rs                |   4 +
 contrib/libgit-rs/src/config.rs           | 106 ++++++++++++++++++++++
 contrib/libgit-rs/src/lib.rs              |   1 +
 contrib/libgit-rs/testdata/config1        |   2 +
 contrib/libgit-rs/testdata/config2        |   2 +
 contrib/libgit-rs/testdata/config3        |   2 +
 contrib/libgit-sys/Cargo.lock             |  69 ++++++++++++++
 contrib/libgit-sys/Cargo.toml             |  19 ++++
 contrib/libgit-sys/README.md              |   4 +
 contrib/libgit-sys/build.rs               |  35 +++++++
 contrib/libgit-sys/public_symbol_export.c |  59 ++++++++++++
 contrib/libgit-sys/public_symbol_export.h |  18 ++++
 contrib/libgit-sys/src/lib.rs             |  79 ++++++++++++++++
 meson.build                               |   2 +
 t/Makefile                                |  15 +++
 24 files changed, 673 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/README.md
 create mode 100644 contrib/libgit-rs/build.rs
 create mode 100644 contrib/libgit-rs/src/config.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3
 create mode 100644 contrib/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-sys/README.md
 create mode 100644 contrib/libgit-sys/build.rs
 create mode 100644 contrib/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-sys/src/lib.rs

Range-diff against v8:
1:  cd0cb9aa04 = 1:  cd0cb9aa04 common-main: split init and exit code into new files
2:  3588a3c3fc ! 2:  8793ff64a7 libgit-sys: introduce Rust wrapper for libgit.a
    @@ Makefile: $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GIT
     +all:: libgit-sys
     +endif
     +
    -+LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
    ++LIBGIT_PUB_OBJS =
    ++LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
     +LIBGIT_PUB_OBJS += libgit.a
     +LIBGIT_PUB_OBJS += reftable/libreftable.a
     +LIBGIT_PUB_OBJS += xdiff/lib.a
3:  f4452fffe6 ! 3:  ab32bd1d07 libgit-sys: also export some config_set functions
    @@ contrib/libgit-sys/public_symbol_export.c
     +void libgit_configset_free(struct libgit_config_set *cs)
     +{
     +	git_configset_clear(&cs->cs);
    -+	free(&cs->cs);
    ++	free(cs);
     +}
     +
     +int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
4:  ada9fc0a13 ! 4:  1bf8c5392c libgit: add higher-level libgit crate
    @@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
     +all:: libgit-sys libgit-rs
      endif
      
    - LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
    + LIBGIT_PUB_OBJS =
     
      ## contrib/libgit-rs/Cargo.lock (new) ##
     @@

base-commit: 757161efcca150a9a96b312d9e780a071e601a03
-- 
2.48.1.362.g079036d154-goog

