Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E7199E80
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738101705; cv=none; b=ZO+jMnGMk86yVNxIyQz0AgeinXoJ9ast1BAmZWOsk7W494RAwxWOZZJabFyiogpbHrthdmahSYpP55qqRJameQ/qKoUEg8+thyRc3yj6NaPASA8l+NFQG0JqufSvM5IMCtwSiy4U7R6sBS2EpkwGafGJxFxrFerGexGla3aQDjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738101705; c=relaxed/simple;
	bh=2D8GolkC0PuLrb1GD9deSGeEX5FFP3REw3xvrnMGJeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=piv2iGTTgw/QJFHJkcMw8sPQ97Nqf41EPaVmMoJ2r/v84OjxFaqkdnoAh8t4Q4I0Xyz+8eic2s84Np147NoBE7mtet5gi1/7gILKvupbbeZoVGceaJmzBTP63yM15VUwGqwaSwseyIAX/VUa5rXEEQk63725klVwNiilGSchU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MM+QjX6r; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MM+QjX6r"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so12258002a91.2
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738101702; x=1738706502; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+r0dCDyhYc3gn0StHV1F+jeYy8zDhULpIVtCZAEZNMk=;
        b=MM+QjX6r2e/ujJxJ7UggEnjxLR3dc5l4hs0dwkxQlziYACF6ueaiN1d0YuSwoVrEt+
         81fWdK76xUK47VXix+ZpJRZUilnAXNVUdkKAfwOEF5leje8pn6sCFmXra29jFFlxzlnv
         RGfYdsFv9Bhz8zVgBQwmbVSso1xsG2Ju4CpfSDBq/JM7t3VaTYKhPO4/sUdizhyALE/G
         1aYiZiCxmxDQ6MhivhHwwCOmOXuV02QU7nam6sPySxfsFgVWbslMC76BS6BOoVg19QIy
         dFRI2LyeM8z3XP3aY9gJ6YTB4B90EV6WNxnTzN2777Ztv08OnkugD4NAFa8TtpwLAy7K
         EdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738101702; x=1738706502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+r0dCDyhYc3gn0StHV1F+jeYy8zDhULpIVtCZAEZNMk=;
        b=NvkTJepqlgzBMWGWMtCMJQ1/Dfm+46tjjYnvGMMyceeM8e1anQ2uKkOT3lOkNmFKFC
         nm2n4RF9zDBoTMdcoJA7M2iFBAz+F2dpT3jDQe5Pwv31iA6ShzU8u0pPT0z81wQGmRgX
         dAII4/w5qtg92Pde73exiqqcX9YM3ZWXFlG7TNIKYWCJQ1M23gzuQYANptYXIgTNNIbP
         b8xIeN5z0MlgiGhZ1d1Dlk8DTbQ8wWv4wknMd6SaSXeOKQfrz2VW7qPy8S7AOGE6QGna
         7bycblVj2vQmMpWQPcs8XsBokUtZtotVaNgWHUqXWJWg8ZCc/2obwDHAqzDFEbOMnpnw
         uwVA==
X-Gm-Message-State: AOJu0YwkCl5lj9EtfwsEJRDc6n8hO6vOeWacZ7CQ5AI3SDi7QVM2w7GL
	qrDXSIiaGKSGArA8zs9qyOFUO2zYQPq0diMBLxujpYZtETd4HQof2YWR6QJBPJrCwu3b4/XYcLK
	RkPri2RMlxzZ2EFuZcn/lWIRISYmrMlG++jG4CQrmlweZbwaFwoJJw2frd/XUNShMPhL4hZ6Akj
	2VryqsLpvLI4M9NXTUQHz8xGdCDA3mAXmjFlEaLmc=
X-Google-Smtp-Source: AGHT+IF/n0gI8x6gqQCgBvBA5G2GXvrQXxqx3Q2xI1HMwPGzmKbj0AsS5cnIwtxHILYAgvo+1TOrCQRsoTug4w==
X-Received: from pjbtb4.prod.google.com ([2002:a17:90b:53c4:b0:2ee:53fe:d0fc])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a0e:b0:2ee:b2fe:eeeb with SMTP id 98e67ed59e1d1-2f83ac66135mr736017a91.22.1738101702228;
 Tue, 28 Jan 2025 14:01:42 -0800 (PST)
Date: Tue, 28 Jan 2025 14:01:36 -0800
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <cover.1738101256.git.steadmon@google.com>
Subject: [PATCH v8 0/4] Introduce libgit-rs, a Rust wrapper around libgit.a
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
 Makefile                                  |  49 ++++++++++
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
 24 files changed, 672 insertions(+), 81 deletions(-)
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

Range-diff against v7:
1:  cd0cb9aa04 = 1:  cd0cb9aa04 common-main: split init and exit code into new files
2:  f1502b8590 ! 2:  3588a3c3fc libgit-sys: introduce Rust wrapper for libgit.a
    @@ Makefile: $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GIT
     +all:: libgit-sys
     +endif
     +
    -+contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    ++LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
    ++LIBGIT_PUB_OBJS += libgit.a
    ++LIBGIT_PUB_OBJS += reftable/libreftable.a
    ++LIBGIT_PUB_OBJS += xdiff/lib.a
    ++
    ++LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
    ++
    ++LIBGIT_HIDDEN_EXPORT = contrib/libgit-sys/hidden_symbol_export.o
    ++
    ++$(LIBGIT_PARTIAL_EXPORT): $(LIBGIT_PUB_OBJS)
     +	$(LD) -r $^ -o $@
     +
    -+contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
    ++$(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
     +	$(OBJCOPY) --localize-hidden $^ $@
     +
    -+contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
    ++contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
     +	$(AR) $(ARFLAGS) $@ $^
     
      ## contrib/libgit-sys/Cargo.lock (new) ##
    @@ contrib/libgit-sys/build.rs (new)
     
      ## contrib/libgit-sys/public_symbol_export.c (new) ##
     @@
    -+/* Shim to publicly export Git symbols. These must be renamed so that the
    ++/*
    ++ * Shim to publicly export Git symbols. These must be renamed so that the
     + * original symbols can be hidden. Renaming these with a "libgit_" prefix also
     + * avoids conflicts with other libraries such as libgit2.
     + */
3:  d67d3648d1 ! 3:  f4452fffe6 libgit-sys: also export some config_set functions
    @@ contrib/libgit-sys/public_symbol_export.c
      
      #pragma GCC visibility push(default)
      
    ++struct libgit_config_set {
    ++	struct config_set cs;
    ++};
    ++
     +struct libgit_config_set *libgit_configset_alloc(void)
     +{
    -+	struct config_set *cs = xmalloc(sizeof(struct config_set));
    -+	git_configset_init(cs);
    -+	return (struct libgit_config_set *) cs;
    ++	struct libgit_config_set *cs =
    ++			xmalloc(sizeof(struct libgit_config_set));
    ++	git_configset_init(&cs->cs);
    ++	return cs;
     +}
     +
     +void libgit_configset_free(struct libgit_config_set *cs)
     +{
    -+	git_configset_clear((struct config_set *) cs);
    -+	free((struct config_set *) cs);
    ++	git_configset_clear(&cs->cs);
    ++	free(&cs->cs);
     +}
     +
     +int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
     +{
    -+	return git_configset_add_file((struct config_set *) cs, filename);
    ++	return git_configset_add_file(&cs->cs, filename);
     +}
     +
    -+int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
    ++int libgit_configset_get_int(struct libgit_config_set *cs, const char *key,
    ++			     int *dest)
     +{
    -+	return git_configset_get_int((struct config_set *) cs, key, dest);
    ++	return git_configset_get_int(&cs->cs, key, dest);
     +}
     +
    -+int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
    ++int libgit_configset_get_string(struct libgit_config_set *cs, const char *key,
    ++				char **dest)
     +{
    -+	return git_configset_get_string((struct config_set *) cs, key, dest);
    ++	return git_configset_get_string(&cs->cs, key, dest);
     +}
     +
      const char *libgit_user_agent(void)
4:  88425bb0b1 ! 4:  ada9fc0a13 libgit: add higher-level libgit crate
    @@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
      	$(MAKE) -C t/ unit-tests
      
     -.PHONY: libgit-sys
    +-libgit-sys:
     +.PHONY: libgit-sys libgit-rs
    - libgit-sys:
    ++libgit-sys libgit-rs:
      	$(QUIET)(\
    - 		cd contrib/libgit-sys && \
    +-		cd contrib/libgit-sys && \
    ++		cd contrib/$@ && \
      		cargo build \
      	)
    -+libgit-rs:
    -+	$(QUIET)(\
    -+		cd contrib/libgit-rs && \
    -+		cargo build \
    -+	)
      ifdef INCLUDE_LIBGIT_RS
     -all:: libgit-sys
     +all:: libgit-sys libgit-rs
      endif
      
    - contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    + LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
     
      ## contrib/libgit-rs/Cargo.lock (new) ##
     @@

base-commit: 757161efcca150a9a96b312d9e780a071e601a03
-- 
2.48.1.262.g85cc9f2d1e-goog

