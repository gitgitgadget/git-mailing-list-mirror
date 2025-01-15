Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FE24A7CC
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971549; cv=none; b=HxpDaTs78SMA2eYFyBrtAWjaVF3wPfICjBL0VMEhYYfUNGTxrcrcu8/IOLl0GoKi2yWIyMvBMR0x/h16BvuNvE20SKE6LDYOG6l+vhNrjGDH6Q126dCbAEFlFVSeXns2H/OqewdoqAUi0W9vLGTM6kjt8dQQ0z1ret5VJstJ5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971549; c=relaxed/simple;
	bh=HLq84VRWz2xTAgDHtVGrpChzLo5g/klOHBEI5BLmzb4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TvF0DIOMWqNPNrHcOtDvcnvY8iWk2kZ5iy6Q3r6y7h0H/yUWAkE0PiBPyxgd96beqjItvHgGuOk4FxFc6KiRfqpeXJ9WSa55M4k06xwnGkx5eWbzA0X7vOKDn2Grgz1QUwNhtY/Y619xxeTQhbUEGaJaHC4CDLAw8OFGT3KeE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJjunKV+; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJjunKV+"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29e56b740efso86861fac.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736971546; x=1737576346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnIXy4x2n1hLMyHqFgvtTMpdP3OFVUBUV+dUcC9zIfU=;
        b=oJjunKV+xPuA/CFrkrUgnwSKLV9+6o2GuWXZXiBuTncz9MBHKmuy3xf6jlsAjRYrSE
         13e+aXcnCsxpUyzFOiJS2UpyaIUbWzOQ4QEXtqq8w9teEA+sXmf+vaQ2HpBYv8PxEpdT
         r2i+DD7CZdR4csh46A/7sAok9BuJwgnkhWUPcziS8q3tyw/eJg8VTC5md2VBQQR0yMRz
         7u2Sbi+MqbEQXpnWbHy0Fn0aoCnD7hlONXC0ktxuUo8J/FQs2DhCcamM3OZfDl16+VlF
         TLk4gN9QTNziZSxU42WkHojTz8chuvQjX1zgAsTfuAtG2OVMGZEokDIC47QQNaOZ3/vZ
         VPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971546; x=1737576346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnIXy4x2n1hLMyHqFgvtTMpdP3OFVUBUV+dUcC9zIfU=;
        b=ayjCRLC0p6Hd9o+Zt4lBjMJHpI7Qtqd7hfTvKfHwVUXJWtRZ6pxBp1L7ZXREftdTkG
         udTMDQL0xWFlVZ8WrSptddsTSon3ApYduY4yE2vsA4Ls9jl3z93PXuKHEs2mdMWYx4ZB
         G9tK6aXeiVUy9LNy46OKHA/eURHzy9ItFEgsJxH2SP1zqpF5LZTXG7poxBYFVkTGiw3i
         rRHBywb6h1nTaAh68bh2cXwopwtPJxdhkxfFor8XIJBtc/IDmERt9uOrSHH//010GqYL
         WjJnt4VSyXDQAeG4xgmnT4iNBDydMHCqnE2Ekkf1XRYHrpDiwmSmBsnXqGWwDAhsaTnP
         y61A==
X-Gm-Message-State: AOJu0YzLFm671VhghwaQ5Q41nX7Px+KIwMHmjs3mgeLvyelK4VAGYYwP
	/ScwxCPz0r/8sgGdCbUZ2gBX8wiiISa/G548hVbIVWQziKYUP1GM6HMYyWLcQr+6lM0/TKBmJVT
	BKa8WmtLjniHJCnVLbG0+jEdAhIm2GYak5y42NoLACcmItqxzBt6W46HYf/XnBP8S5u/JpIjjhJ
	SFJOs0jnl9o3Pqj5kFVHwJFC8d1xdJMOF2+bRuiVk=
X-Google-Smtp-Source: AGHT+IF4so1dO51f8dO1szRr7UZ/Yk7iBVRj7BHBLanGeRgSK4+WHKatycIiKrZOjPK0+KDgtErOQGDSSfFg0A==
X-Received: from oabxa3.prod.google.com ([2002:a05:6870:7f03:b0:29e:954f:9ae])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:71c6:b0:29e:5c94:5b10 with SMTP id 586e51a60fabf-2aa06922c8cmr18139101fac.34.1736971546459;
 Wed, 15 Jan 2025 12:05:46 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:39 -0800
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <cover.1736971328.git.steadmon@google.com>
Subject: [PATCH v6 0/5] Introduce libgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com, 
	gitster@pobox.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
Content-Type: text/plain; charset="UTF-8"

Apologies for the long delay on V6; I am finally back after several
months of $DAYJOB firefighting, holidays, and sick leave. I should have
time to devote to this series again, but given the lack of feedback on
V5 I am hopeful that this will be the final iteration of this series.

This series provides two small Rust wrapper libraries around parts of
Git: "libgit-sys", which exposes a few functions from libgit.a, and
"libgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/martinvonz/jj

There is known NEEDSWORK, but I feel that they can be addressed in
follow-up changes, rather than in this series. If you feel otherwise,
please let me know:

* Investigate alternative methods of managing symbol visibility &
  renaming.

* Figure out symbol versioning

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


Calvin Wan (2):
  libgit: add higher-level libgit crate
  Makefile: add option to build and test libgit-rs and libgit-rs-sys

Josh Steadmon (3):
  common-main: split init and exit code into new files
  libgit-sys: introduce Rust wrapper for libgit.a
  libgit-sys: also export some config_set functions

 .gitignore                                |  2 +
 Makefile                                  | 44 +++++++++++
 common-exit.c                             | 26 +++++++
 common-init.c                             | 63 +++++++++++++++
 common-init.h                             |  6 ++
 common-main.c                             | 83 +-------------------
 contrib/libgit-rs/Cargo.lock              | 77 ++++++++++++++++++
 contrib/libgit-rs/Cargo.toml              | 15 ++++
 contrib/libgit-rs/README.md               | 13 ++++
 contrib/libgit-rs/build.rs                |  4 +
 contrib/libgit-rs/src/lib.rs              | 95 +++++++++++++++++++++++
 contrib/libgit-rs/testdata/config1        |  2 +
 contrib/libgit-rs/testdata/config2        |  2 +
 contrib/libgit-rs/testdata/config3        |  2 +
 contrib/libgit-sys/Cargo.lock             | 69 ++++++++++++++++
 contrib/libgit-sys/Cargo.toml             | 18 +++++
 contrib/libgit-sys/README.md              |  4 +
 contrib/libgit-sys/build.rs               | 35 +++++++++
 contrib/libgit-sys/public_symbol_export.c | 50 ++++++++++++
 contrib/libgit-sys/public_symbol_export.h | 18 +++++
 contrib/libgit-sys/src/lib.rs             | 79 +++++++++++++++++++
 t/Makefile                                | 16 ++++
 22 files changed, 642 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/README.md
 create mode 100644 contrib/libgit-rs/build.rs
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

Range-diff against v5:
1:  1ae14207f6 = 1:  ff6cd62397 common-main: split init and exit code into new files
2:  1ed010c378 ! 2:  5fc66cdb16 libgit-sys: introduce Rust wrapper for libgit.a
    @@ .gitignore: Release/
      /git.VC.db
      *.dSYM
      /contrib/buildsystems/out
    -+/contrib/libgit-rs/libgit-sys/target
    ++/contrib/libgit-sys/target
     
      ## Makefile ##
     @@ Makefile: CURL_CONFIG = curl-config
    @@ Makefile: CURL_CONFIG = curl-config
      
      export TCL_PATH TCLTK_PATH
      
    -@@ Makefile: OBJECTS += $(XDIFF_OBJS)
    - OBJECTS += $(FUZZ_OBJS)
    - OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
    +@@ Makefile: OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
      OBJECTS += $(UNIT_TEST_OBJS)
    -+OBJECTS += contrib/libgit-rs/libgit-sys/public_symbol_export.o
    + OBJECTS += $(CLAR_TEST_OBJS)
    + OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
    ++OBJECTS += contrib/libgit-sys/public_symbol_export.o
      
      ifndef NO_CURL
      	OBJECTS += http.o http-walker.o remote-curl.o
    @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
      	$(MAKE) -C Documentation/ clean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
    -+	$(RM) -r contrib/libgit-rs/libgit-sys/target
    -+	$(RM) -r contrib/libgit-rs/libgit-sys/partial_symbol_export.o
    -+	$(RM) -r contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
    -+	$(RM) -r contrib/libgit-rs/libgit-sys/libgitpub.a
    ++	$(RM) -r contrib/libgit-sys/target
    ++	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
    ++	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
    ++	$(RM) -r contrib/libgit-sys/libgitpub.a
      ifndef NO_PERL
      	$(RM) -r perl/build/
      endif
    -@@ Makefile: $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
    - build-unit-tests: $(UNIT_TEST_PROGS)
    - unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
    +@@ Makefile: $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-
    + build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
    + unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
      	$(MAKE) -C t/ unit-tests
     +
    -+contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    ++contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
     +	$(LD) -r $^ -o $@
     +
    -+contrib/libgit-rs/libgit-sys/hidden_symbol_export.o: contrib/libgit-rs/libgit-sys/partial_symbol_export.o
    ++contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
     +	$(OBJCOPY) --localize-hidden $^ $@
     +
    -+contrib/libgit-rs/libgit-sys/libgitpub.a: contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
    ++contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
     +	$(AR) $(ARFLAGS) $@ $^
     
    - ## contrib/libgit-rs/libgit-sys/Cargo.lock (new) ##
    + ## contrib/libgit-sys/Cargo.lock (new) ##
     @@
     +# This file is automatically @generated by Cargo.
     +# It is not intended for manual editing.
    @@ contrib/libgit-rs/libgit-sys/Cargo.lock (new)
     +source = "registry+https://github.com/rust-lang/crates.io-index"
     +checksum = "accd4ea62f7bb7a82fe23066fb0957d48ef677f6eeb8215f372f52e48bb32426"
     
    - ## contrib/libgit-rs/libgit-sys/Cargo.toml (new) ##
    + ## contrib/libgit-sys/Cargo.toml (new) ##
     @@
     +[package]
     +name = "libgit-sys"
    @@ contrib/libgit-rs/libgit-sys/Cargo.toml (new)
     +build = "build.rs"
     +links = "gitpub"
     +rust-version = "1.63"
    ++description = "Native bindings to a portion of libgit"
     +
     +[lib]
     +path = "src/lib.rs"
    @@ contrib/libgit-rs/libgit-sys/Cargo.toml (new)
     +autocfg = "1.4.0"
     +make-cmd = "0.1.0"
     
    - ## contrib/libgit-rs/libgit-sys/README.md (new) ##
    + ## contrib/libgit-sys/README.md (new) ##
     @@
    -+# cgit-info
    ++# libgit-sys
     +
    -+A small hacky proof-of-concept showing how to provide a Rust FFI for the Git
    -+library.
    -+
    -+## Building
    -+
    -+`cargo build` automatically builds and picks up on changes made to both
    -+the Rust wrapper and git.git code so there is no need to run `make`
    -+beforehand.
    -+
    -+## Running
    -+
    -+Assuming you don't make any changes to the Git source, you can just work from
    -+`contrib/cgit-rs` and use `cargo build` or `cargo run` as usual.
    ++A small proof-of-concept crate showing how to provide a Rust FFI to Git
    ++internals.
     
    - ## contrib/libgit-rs/libgit-sys/build.rs (new) ##
    + ## contrib/libgit-sys/build.rs (new) ##
     @@
     +use std::env;
     +use std::path::PathBuf;
    @@ contrib/libgit-rs/libgit-sys/build.rs (new)
     +    ac.emit_has_path("std::ffi::c_char");
     +
     +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
    -+    let git_root = crate_root.join("../../..");
    ++    let git_root = crate_root.join("../..");
     +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
     +
     +    let make_output = make_cmd::gnu_make()
    @@ contrib/libgit-rs/libgit-sys/build.rs (new)
     +        .current_dir(git_root.clone())
     +        .args([
     +            "CFLAGS=-fvisibility=hidden",
    -+            "contrib/libgit-rs/libgit-sys/libgitpub.a",
    ++            "contrib/libgit-sys/libgitpub.a",
     +        ])
     +        .output()
     +        .expect("Make failed to run");
    @@ contrib/libgit-rs/libgit-sys/build.rs (new)
     +    Ok(())
     +}
     
    - ## contrib/libgit-rs/libgit-sys/public_symbol_export.c (new) ##
    + ## contrib/libgit-sys/public_symbol_export.c (new) ##
     @@
     +// Shim to publicly export Git symbols. These must be renamed so that the
     +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
     +// avoids conflicts with other libraries such as libgit2.
     +
     +#include "git-compat-util.h"
    -+#include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
    ++#include "contrib/libgit-sys/public_symbol_export.h"
     +#include "version.h"
     +
     +#pragma GCC visibility push(default)
    @@ contrib/libgit-rs/libgit-sys/public_symbol_export.c (new)
     +
     +#pragma GCC visibility pop
     
    - ## contrib/libgit-rs/libgit-sys/public_symbol_export.h (new) ##
    + ## contrib/libgit-sys/public_symbol_export.h (new) ##
     @@
     +#ifndef PUBLIC_SYMBOL_EXPORT_H
     +#define PUBLIC_SYMBOL_EXPORT_H
    @@ contrib/libgit-rs/libgit-sys/public_symbol_export.h (new)
     +
     +#endif /* PUBLIC_SYMBOL_EXPORT_H */
     
    - ## contrib/libgit-rs/libgit-sys/src/lib.rs (new) ##
    + ## contrib/libgit-sys/src/lib.rs (new) ##
     @@
     +#[cfg(has_std__ffi__c_char)]
     +use std::ffi::c_char;
3:  00762b57d0 ! 3:  03f39b6c3a libgit-sys: also export some config_set functions
    @@ Commit message
         Signed-off-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Josh Steadmon <steadmon@google.com>
     
    - ## contrib/libgit-rs/libgit-sys/public_symbol_export.c ##
    + ## contrib/libgit-sys/public_symbol_export.c ##
     @@
      // avoids conflicts with other libraries such as libgit2.
      
      #include "git-compat-util.h"
     +#include "config.h"
    - #include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
    + #include "contrib/libgit-sys/public_symbol_export.h"
      #include "version.h"
      
      #pragma GCC visibility push(default)
    @@ contrib/libgit-rs/libgit-sys/public_symbol_export.c
      {
      	return git_user_agent();
     
    - ## contrib/libgit-rs/libgit-sys/public_symbol_export.h ##
    + ## contrib/libgit-sys/public_symbol_export.h ##
     @@
      #ifndef PUBLIC_SYMBOL_EXPORT_H
      #define PUBLIC_SYMBOL_EXPORT_H
    @@ contrib/libgit-rs/libgit-sys/public_symbol_export.h
      
      const char *libgit_user_agent_sanitized(void);
     
    - ## contrib/libgit-rs/libgit-sys/src/lib.rs ##
    + ## contrib/libgit-sys/src/lib.rs ##
     @@
      #[cfg(has_std__ffi__c_char)]
     -use std::ffi::c_char;
4:  4e5360931b ! 4:  65166ea0c0 libgit: add higher-level libgit crate
    @@ .gitignore: Release/
      *.dSYM
      /contrib/buildsystems/out
     +/contrib/libgit-rs/target
    - /contrib/libgit-rs/libgit-sys/target
    + /contrib/libgit-sys/target
     
      ## Makefile ##
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
      	$(MAKE) -C Documentation/ clean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
    --	$(RM) -r contrib/libgit-rs/libgit-sys/target
    -+	$(RM) -r contrib/libgit-rs/target contrib/libgit-rs/libgit-sys/target
    - 	$(RM) -r contrib/libgit-rs/libgit-sys/partial_symbol_export.o
    - 	$(RM) -r contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
    - 	$(RM) -r contrib/libgit-rs/libgit-sys/libgitpub.a
    +-	$(RM) -r contrib/libgit-sys/target
    ++	$(RM) -r contrib/libgit-rs/target contrib/libgit-sys/target
    + 	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
    + 	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
    + 	$(RM) -r contrib/libgit-sys/libgitpub.a
     
      ## contrib/libgit-rs/Cargo.lock (new) ##
     @@
    @@ contrib/libgit-rs/Cargo.toml (new)
     +path = "src/lib.rs"
     +
     +[dependencies]
    -+libgit-sys = { version = "0.1.0", path = "libgit-sys" }
    ++libgit-sys = { version = "0.1.0", path = "../libgit-sys" }
     +
     +[build-dependencies]
     +autocfg = "1.4.0"
     
    + ## contrib/libgit-rs/README.md (new) ##
    +@@
    ++# libgit-rs
    ++
    ++Proof-of-concept Git bindings for Rust.
    ++
    ++```toml
    ++[dependencies]
    ++libgit = "0.1.0"
    ++```
    ++
    ++## Rust version requirements
    ++
    ++libgit-rs should support Rust versions at least as old as the version included
    ++in Debian stable (currently 1.63).
    +
      ## contrib/libgit-rs/build.rs (new) ##
     @@
     +pub fn main() {
    @@ contrib/libgit-rs/build.rs (new)
     +    ac.emit_has_path("std::ffi::c_char");
     +}
     
    - ## contrib/libgit-rs/libgit-sys/src/lib.rs ##
    -@@
    -+use std::ffi::c_void;
    -+
    - #[cfg(has_std__ffi__c_char)]
    - use std::ffi::{c_char, c_int};
    - 
    -@@ contrib/libgit-rs/libgit-sys/src/lib.rs: pub struct libgit_config_set {
    - }
    - 
    - extern "C" {
    -+    pub fn free(ptr: *mut c_void);
    -+
    -     pub fn libgit_user_agent() -> *const c_char;
    -     pub fn libgit_user_agent_sanitized() -> *const c_char;
    - 
    -
      ## contrib/libgit-rs/src/lib.rs (new) ##
     @@
     +use std::ffi::{c_void, CStr, CString};
    @@ contrib/libgit-rs/testdata/config3 (new)
     @@
     +[trace2]
     +	eventNesting = 3
    +
    + ## contrib/libgit-sys/src/lib.rs ##
    +@@
    ++use std::ffi::c_void;
    ++
    + #[cfg(has_std__ffi__c_char)]
    + use std::ffi::{c_char, c_int};
    + 
    +@@ contrib/libgit-sys/src/lib.rs: pub struct libgit_config_set {
    + }
    + 
    + extern "C" {
    ++    pub fn free(ptr: *mut c_void);
    ++
    +     pub fn libgit_user_agent() -> *const c_char;
    +     pub fn libgit_user_agent_sanitized() -> *const c_char;
    + 
5:  15ce989de8 ! 5:  84706f0db7 Makefile: add option to build and test libgit-rs and libgit-rs-sys
    @@ Makefile: ifdef FSMONITOR_OS_SETTINGS
      ifeq ($(TCLTK_PATH),)
      NO_TCLTK = NoThanks
      endif
    -@@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS)
    - unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
    +@@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
    + unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
      	$(MAKE) -C t/ unit-tests
      
    -+.PHONY: libgitrs-sys
    -+libgitrs-sys:
    ++.PHONY: libgit-sys
    ++libgit-sys:
     +	$(QUIET)(\
    -+		cd contrib/libgit-rs/libgit-sys && \
    ++		cd contrib/libgit-sys && \
     +		cargo build \
     +	)
    -+.PHONY: libgitrs
    -+libgitrs:
    ++.PHONY: libgit-rs
    ++libgit-rs:
     +	$(QUIET)(\
     +		cd contrib/libgit-rs && \
     +		cargo build \
     +	)
     +ifdef INCLUDE_LIBGIT_RS
    -+all:: libgitrs
    ++all:: libgit-rs
     +endif
     +
    - contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    + contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
      	$(LD) -r $^ -o $@
      
     
    - ## contrib/libgit-rs/libgit-sys/build.rs ##
    -@@ contrib/libgit-rs/libgit-sys/build.rs: pub fn main() -> std::io::Result<()> {
    + ## contrib/libgit-sys/build.rs ##
    +@@ contrib/libgit-sys/build.rs: pub fn main() -> std::io::Result<()> {
              .env_remove("PROFILE")
              .current_dir(git_root.clone())
              .args([
     -            "CFLAGS=-fvisibility=hidden",
     +            "INCLUDE_LIBGIT_RS=YesPlease",
    -             "contrib/libgit-rs/libgit-sys/libgitpub.a",
    +             "contrib/libgit-sys/libgitpub.a",
              ])
              .output()
     
    @@ t/Makefile: perf:
      .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
      	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
     +
    -+.PHONY: libgitrs-sys-test
    -+libgitrs-sys-test:
    ++.PHONY: libgit-sys-test
    ++libgit-sys-test:
     +	$(QUIET)(\
    -+		cd ../contrib/libgit-rs/libgit-sys && \
    ++		cd ../contrib/libgit-sys && \
     +		cargo test \
     +	)
    -+.PHONY: libgitrs-test
    -+libgitrs-test:
    ++.PHONY: libgit-rs-test
    ++libgit-rs-test:
     +	$(QUIET)(\
     +		cd ../contrib/libgit-rs && \
     +		cargo test \
     +	)
     +ifdef INCLUDE_LIBGIT_RS
    -+all:: libgitrs-sys-test libgitrs-test
    ++all:: libgit-sys-test libgit-rs-test
     +endif

base-commit: 757161efcca150a9a96b312d9e780a071e601a03
-- 
2.48.0.rc2.279.g1de40edade-goog

