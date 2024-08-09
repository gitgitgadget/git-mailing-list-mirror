Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92219C8D1
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243283; cv=none; b=g9ZYbOk7xiifae0du8bzOtRvWQdmOc0lESg0NzgxehcilJoJRP9LIT9OGL8HaS5/66/gCVwE93F62EjzFtSf2xvzGN/FykarFe7omYbixdRSCbaXFdeSgbFXP3D51PUMbueYnfa+0ldlHdK+7QuKnD5mTg9V8xIFMgbn1+lsQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243283; c=relaxed/simple;
	bh=IolkVHA6Y4i0bZzX/1zkQj4aTE52mwQU0bMfwbKimuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stEumK6hLry4RbHMfQtfgrFEPe5WEF21YuGFLUn1vP5sZrU4teet4SCGuuyYWgfcgPMqaeM+l72W7dnRbMDWscFFDUmZWG+MgCKnLeJuJc2aTeoDhv2YS06fFyM83EigPI0BI+msH0picy1l4bO9T/h7meP+p3lGCIeXuKv7XO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0klQfQ4p; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0klQfQ4p"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650ab31aabdso49802227b3.3
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723243279; x=1723848079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gtWHjkAL+MAZMRXq88QQvzULyGRvD9BgZJ66XBNw/M=;
        b=0klQfQ4pFOzYmVjIoj6hVC2zR0YTDO7Lta99DIRuQ9M9cfe6cTwMyCXswQ/xWJdVr2
         g5u61Wm1m9wehAF/Q347nZlB747ughq7nX31v/6fwSuok5oR2aTSbcDp1nT1lvI5d6zv
         zmq6jaXjpy4hjYeCkpVH+EZBnVCZUNwIEGSnWNeZlW8HU11BLCxIyGmYsoWvUm+vqM43
         e8Ap028I9elSpbZcGBHcgwtUORFMFnmFNQn1FVkRifwNsg4MWVc15MQ/E3cBPI59hFvz
         As+E8rDpLMbEh46B2uyq1Hl0OvySecU8OKVxl7dzFkbEkieXMEEsDl7Fgv/WMsvOA7Sn
         11qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723243279; x=1723848079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gtWHjkAL+MAZMRXq88QQvzULyGRvD9BgZJ66XBNw/M=;
        b=VPxEY0Kzo7Tx2CpGV5dKdyIgLhOHD9wxK5SvP7bcdjU7FBxalmX2f68zdtG3d5x3JP
         mtZ9IeLxmhrFv3jlJkNwBmleRIDh3/w49RMi7WpnCOudLcZzmN6mp0/Ce5wnVfwbGA14
         WuBaAOMT9VknWwqmWw8UnIn89VrAlu5tybB8/HOBQFtrDUsWGyxQW9D9fobEj7oJBxYt
         aq7AqiS11s+sG2wUhsibeyE1uRUwvX7j7+9G98iCt9Ei8tC8CCLBsiPxdcUHNicBu2EU
         VVmARLkZgINmPRHTcWnfhZQO/SnxJC60WGw0taXxnUygnfHxLclIGq27gUM7abl3OW2n
         QZ/g==
X-Gm-Message-State: AOJu0YwZR5aft5m5XZ2xA68hOSPCpNkCmtRjIangSEqtZcAQEHbFf8nT
	ul8r+5hIIfLdKMaVEDGuY2bY0/PobfgcoNiFzUT1reuw30LGMSh+106CLq2PxdEjkj73pPPQP1U
	uI1urJU5bBOHSKeW487+h2HSkFDPXp7TnaLe+7E6l2OFwyW5apuXfYZuUDyD2j13nSNO8paksfq
	c+vO2CSG3R0BVU+Bb/mIJ3TdBfUnxwoybBlWIFu4U=
X-Google-Smtp-Source: AGHT+IE/trVyyt2aGRYIvQfFyVCbDBYJWTFroCDHrVV1M4apMzYVzSCBdjz9BHApn48qOWa3d0FC+KAavSLNFQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:34c7:b0:62f:1f63:ae4f with SMTP
 id 00721157ae682-69ec4c03006mr672267b3.1.1723243279092; Fri, 09 Aug 2024
 15:41:19 -0700 (PDT)
Date: Fri,  9 Aug 2024 15:41:12 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <cover.1723242556.git.steadmon@google.com>
Subject: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

This series provides two small Rust wrapper libraries around parts of
Git: "cgit-sys", which exposes a few functions from libgit.a, and
"cgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/martinvonz/jj

Please find V1 cover letter here:
https://lore.kernel.org/git/cover.1723054623.git.steadmon@google.com/

Changes in V2:
* Split out the exposed C APIs into a cgit-sys module, and build nicer
  Rust interfaces on top of that in cgit-rs

* Replace the proof-of-concept cgit-info binary with unit tests

* In addition to splitting common_exit() into a new file, also move the
  initialization code in main() to a new init_git() function in its own
  file, and include this in libgit.a. This allows us to drop V1 patch #2
  [which added a wrapper around initialize_repo()]

* Remove libc dependency (by declaring an extern "C" free function, not
  sure if this is the best approach)

* Add git_configset_clear_and_free to also support the above

* Use "std::env::home_dir" instead of the "home" crate due to desired
  behavior on Windows. "std::env::home_dir" is deprecated, but is only
  used in unit tests which will need to be rewritten anyway to provide a
  testdata config.

* Use recommended empty array + PhantomData approach instead of empty
  enums for wrapping opaque C structs/pointers

* Don't force CC=clang in build.rs

* Simplify conversion of PathBufs to Strings in build.rs

* Don't unnecessarily expose git_attr__true and git_attr__false in
  public_symbol_export.c. That fixes `make sparse`.

* Clippy and rustfmt cleanups throughout

* Whitespace fix

Known NEEDSWORK:
* Support older Rust versions

* Investigate alternative methods of managing symbol visibility.

* Figure out symbol versioning

* Bikeshed on the name

* Makefile cleanup, particularly adding config.mak options that
  developers can set to run Rust builds and tests by default

* Automate the process of exporting additional functions in cgit-sys
  (possibly with a wrapper script around bindgen)

* Provide testdata configs for unit tests

* Rethink the Rust-y ConfigSet API, particularly for Path vs. &str


Calvin Wan (2):
  contrib/cgit-rs: add repo initialization and config access
  contrib/cgit-rs: add a subset of configset wrappers

Josh Steadmon (3):
  common-main: split init and exit code into new files
  contrib/cgit-rs: introduce Rust wrapper for libgit.a
  config: add git_configset_alloc() and git_configset_clear_and_free()

 .gitignore                                    |   2 +
 Makefile                                      |  15 +++
 common-exit.c                                 |  26 ++++
 common-init.c                                 |  63 ++++++++++
 common-init.h                                 |   6 +
 common-main.c                                 |  83 +------------
 config.c                                      |  11 ++
 config.h                                      |  10 ++
 contrib/cgit-rs/Cargo.lock                    |  14 +++
 contrib/cgit-rs/Cargo.toml                    |  10 ++
 contrib/cgit-rs/cgit-sys/Cargo.lock           |   7 ++
 contrib/cgit-rs/cgit-sys/Cargo.toml           |   9 ++
 contrib/cgit-rs/cgit-sys/README.md            |  15 +++
 contrib/cgit-rs/cgit-sys/build.rs             |  32 +++++
 .../cgit-rs/cgit-sys/public_symbol_export.c   |  76 ++++++++++++
 .../cgit-rs/cgit-sys/public_symbol_export.h   |  28 +++++
 contrib/cgit-rs/cgit-sys/src/lib.rs           | 112 ++++++++++++++++++
 contrib/cgit-rs/src/lib.rs                    |  82 +++++++++++++
 18 files changed, 520 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/cgit-rs/Cargo.lock
 create mode 100644 contrib/cgit-rs/Cargo.toml
 create mode 100644 contrib/cgit-rs/cgit-sys/Cargo.lock
 create mode 100644 contrib/cgit-rs/cgit-sys/Cargo.toml
 create mode 100644 contrib/cgit-rs/cgit-sys/README.md
 create mode 100644 contrib/cgit-rs/cgit-sys/build.rs
 create mode 100644 contrib/cgit-rs/cgit-sys/public_symbol_export.c
 create mode 100644 contrib/cgit-rs/cgit-sys/public_symbol_export.h
 create mode 100644 contrib/cgit-rs/cgit-sys/src/lib.rs
 create mode 100644 contrib/cgit-rs/src/lib.rs

Range-diff against v1:
1:  78c2aa2ef9 ! 1:  800b37d16b common-main: split common_exit() into a new file
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    common-main: split common_exit() into a new file
    +    common-main: split init and exit code into new files
     
         Currently, object files in libgit.a reference common_exit(), which is
         contained in common-main.o. However, common-main.o also includes main(),
    @@ Commit message
         conflicts. Now we are trying to make libgit.a more self-contained, so
         hopefully we can revisit this approach.
     
    +    Additionally, move the initialization code out of main() into a new
    +    init_git() function in its own file. Include this in libgit.a as well,
    +    so that external users can share our setup code without calling our
    +    main().
    +
         [1] https://lore.kernel.org/git/Yp+wjCPhqieTku3X@google.com/
         [2] https://lore.kernel.org/git/20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com/
     
    -    Signed-off-by: Josh Steadmon <steadmon@google.com>
    -
     
      ## Makefile ##
    @@ Makefile: LIB_OBJS += combine-diff.o
      LIB_OBJS += commit-reach.o
      LIB_OBJS += commit.o
     +LIB_OBJS += common-exit.o
    ++LIB_OBJS += common-init.o
      LIB_OBJS += compat/nonblock.o
      LIB_OBJS += compat/obstack.o
      LIB_OBJS += compat/terminal.o
    @@ common-exit.c (new)
     +	return code;
     +}
     
    + ## common-init.c (new) ##
    +@@
    ++#define USE_THE_REPOSITORY_VARIABLE
    ++
    ++#include "git-compat-util.h"
    ++#include "common-init.h"
    ++#include "exec-cmd.h"
    ++#include "gettext.h"
    ++#include "attr.h"
    ++#include "repository.h"
    ++#include "setup.h"
    ++#include "strbuf.h"
    ++#include "trace2.h"
    ++
    ++/*
    ++ * Many parts of Git have subprograms communicate via pipe, expect the
    ++ * upstream of a pipe to die with SIGPIPE when the downstream of a
    ++ * pipe does not need to read all that is written.  Some third-party
    ++ * programs that ignore or block SIGPIPE for their own reason forget
    ++ * to restore SIGPIPE handling to the default before spawning Git and
    ++ * break this carefully orchestrated machinery.
    ++ *
    ++ * Restore the way SIGPIPE is handled to default, which is what we
    ++ * expect.
    ++ */
    ++static void restore_sigpipe_to_default(void)
    ++{
    ++	sigset_t unblock;
    ++
    ++	sigemptyset(&unblock);
    ++	sigaddset(&unblock, SIGPIPE);
    ++	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
    ++	signal(SIGPIPE, SIG_DFL);
    ++}
    ++
    ++void init_git(const char **argv)
    ++{
    ++	struct strbuf tmp = STRBUF_INIT;
    ++
    ++	trace2_initialize_clock();
    ++
    ++	/*
    ++	 * Always open file descriptors 0/1/2 to avoid clobbering files
    ++	 * in die().  It also avoids messing up when the pipes are dup'ed
    ++	 * onto stdin/stdout/stderr in the child processes we spawn.
    ++	 */
    ++	sanitize_stdfds();
    ++	restore_sigpipe_to_default();
    ++
    ++	git_resolve_executable_dir(argv[0]);
    ++
    ++	setlocale(LC_CTYPE, "");
    ++	git_setup_gettext();
    ++
    ++	initialize_repository(the_repository);
    ++
    ++	attr_start();
    ++
    ++	trace2_initialize();
    ++	trace2_cmd_start(argv);
    ++	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
    ++
    ++	if (!strbuf_getcwd(&tmp))
    ++		tmp_original_cwd = strbuf_detach(&tmp, NULL);
    ++}
    +
    + ## common-init.h (new) ##
    +@@
    ++#ifndef COMMON_INIT_H
    ++#define COMMON_INIT_H
    ++
    ++void init_git(const char **argv);
    ++
    ++#endif /* COMMON_INIT_H */
    +
      ## common-main.c ##
    -@@ common-main.c: int main(int argc, const char **argv)
    +@@
    +-#define USE_THE_REPOSITORY_VARIABLE
    +-
    + #include "git-compat-util.h"
    +-#include "exec-cmd.h"
    +-#include "gettext.h"
    +-#include "attr.h"
    +-#include "repository.h"
    +-#include "setup.h"
    +-#include "strbuf.h"
    +-#include "trace2.h"
    +-
    +-/*
    +- * Many parts of Git have subprograms communicate via pipe, expect the
    +- * upstream of a pipe to die with SIGPIPE when the downstream of a
    +- * pipe does not need to read all that is written.  Some third-party
    +- * programs that ignore or block SIGPIPE for their own reason forget
    +- * to restore SIGPIPE handling to the default before spawning Git and
    +- * break this carefully orchestrated machinery.
    +- *
    +- * Restore the way SIGPIPE is handled to default, which is what we
    +- * expect.
    +- */
    +-static void restore_sigpipe_to_default(void)
    +-{
    +-	sigset_t unblock;
    +-
    +-	sigemptyset(&unblock);
    +-	sigaddset(&unblock, SIGPIPE);
    +-	sigprocmask(SIG_UNBLOCK, &unblock, NULL);
    +-	signal(SIGPIPE, SIG_DFL);
    +-}
    ++#include "common-init.h"
    + 
    + int main(int argc, const char **argv)
    + {
    + 	int result;
    +-	struct strbuf tmp = STRBUF_INIT;
    +-
    +-	trace2_initialize_clock();
    +-
    +-	/*
    +-	 * Always open file descriptors 0/1/2 to avoid clobbering files
    +-	 * in die().  It also avoids messing up when the pipes are dup'ed
    +-	 * onto stdin/stdout/stderr in the child processes we spawn.
    +-	 */
    +-	sanitize_stdfds();
    +-	restore_sigpipe_to_default();
    +-
    +-	git_resolve_executable_dir(argv[0]);
    +-
    +-	setlocale(LC_CTYPE, "");
    +-	git_setup_gettext();
    +-
    +-	initialize_repository(the_repository);
    +-
    +-	attr_start();
    +-
    +-	trace2_initialize();
    +-	trace2_cmd_start(argv);
    +-	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
    +-
    +-	if (!strbuf_getcwd(&tmp))
    +-		tmp_original_cwd = strbuf_detach(&tmp, NULL);
    + 
    ++	init_git(argv);
    + 	result = cmd_main(argc, argv);
    + 
      	/* Not exit(3), but a wrapper calling our common_exit() */
      	exit(result);
      }
2:  5f2e816cf6 < -:  ---------- repository: add initialize_repo wrapper without pointer
3:  9a846c17c8 ! 2:  3589d2d6a2 contrib/cgit-rs: introduce Rust wrapper for libgit.a
    @@ Commit message
         Co-authored-by: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Kyle Lippincott <spectral@google.com>
    -    Signed-off-by: Josh Steadmon <steadmon@google.com>
    -
     
      ## .gitignore ##
    @@ .gitignore: Release/
      /git.VC.db
      *.dSYM
      /contrib/buildsystems/out
    -+/contrib/cgit-rs/target
    ++/contrib/cgit-rs/cgit-sys/target
     
      ## Makefile ##
     @@ Makefile: CURL_CONFIG = curl-config
    @@ Makefile: OBJECTS += $(XDIFF_OBJS)
      OBJECTS += $(FUZZ_OBJS)
      OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
      OBJECTS += $(UNIT_TEST_OBJS)
    -+OBJECTS += contrib/cgit-rs/public_symbol_export.o
    ++OBJECTS += contrib/cgit-rs/cgit-sys/public_symbol_export.o
      
      ifndef NO_CURL
      	OBJECTS += http.o http-walker.o remote-curl.o
    @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
      	$(MAKE) -C Documentation/ clean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
    -+	$(RM) -r contrib/cgit-rs/target
    ++	$(RM) -r contrib/cgit-rs/cgit-sys/target
      ifndef NO_PERL
      	$(RM) -r perl/build/
      endif
    @@ Makefile: $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
      unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
      	$(MAKE) -C t/ unit-tests
     +
    -+contrib/cgit-rs/partial_symbol_export.o: contrib/cgit-rs/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    ++contrib/cgit-rs/cgit-sys/partial_symbol_export.o: contrib/cgit-rs/cgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
     +	$(LD) -r $^ -o $@
     +
    -+contrib/cgit-rs/hidden_symbol_export.o: contrib/cgit-rs/partial_symbol_export.o
    ++contrib/cgit-rs/cgit-sys/hidden_symbol_export.o: contrib/cgit-rs/cgit-sys/partial_symbol_export.o
     +	$(OBJCOPY) --localize-hidden $^ $@
     +
    -+contrib/cgit-rs/libcgit.a: contrib/cgit-rs/hidden_symbol_export.o
    ++contrib/cgit-rs/cgit-sys/libcgit.a: contrib/cgit-rs/cgit-sys/hidden_symbol_export.o
     +	$(AR) $(ARFLAGS) $@ $^
     
    - ## contrib/cgit-rs/Cargo.lock (new) ##
    + ## contrib/cgit-rs/cgit-sys/Cargo.lock (new) ##
     @@
     +# This file is automatically @generated by Cargo.
     +# It is not intended for manual editing.
     +version = 3
     +
     +[[package]]
    -+name = "cgit"
    ++name = "cgit-sys"
     +version = "0.1.0"
    -+dependencies = [
    -+ "libc",
    -+]
    -+
    -+[[package]]
    -+name = "libc"
    -+version = "0.2.155"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
     
    - ## contrib/cgit-rs/Cargo.toml (new) ##
    + ## contrib/cgit-rs/cgit-sys/Cargo.toml (new) ##
     @@
     +[package]
    -+name = "cgit"
    ++name = "cgit-sys"
     +version = "0.1.0"
     +edition = "2021"
     +build = "build.rs"
     +links = "git"
     +
    -+[[bin]]
    -+name = "cgit-test"
    -+path = "src/main.rs"
    -+
     +[lib]
     +path = "src/lib.rs"
    -+
    -+[dependencies]
    -+libc = "0.2.155"
     
    - ## contrib/cgit-rs/README.md (new) ##
    + ## contrib/cgit-rs/cgit-sys/README.md (new) ##
     @@
     +# cgit-info
     +
    @@ contrib/cgit-rs/README.md (new)
     +Assuming you don't make any changes to the Git source, you can just work from
     +`contrib/cgit-rs` and use `cargo build` or `cargo run` as usual.
     
    - ## contrib/cgit-rs/build.rs (new) ##
    + ## contrib/cgit-rs/cgit-sys/build.rs (new) ##
     @@
     +use std::env;
     +use std::path::PathBuf;
     +
     +pub fn main() -> std::io::Result<()> {
     +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
    -+    let git_root = crate_root.join("../..");
    ++    let git_root = crate_root.join("../../..");
     +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
     +
     +    let make_output = std::process::Command::new("make")
     +        .env_remove("PROFILE")
     +        .current_dir(git_root.clone())
    -+        .args(&[
    -+            "CC=clang",
    ++        .args([
     +            "CFLAGS=-fvisibility=hidden",
    -+            "contrib/cgit-rs/libcgit.a"
    ++            "contrib/cgit-rs/cgit-sys/libcgit.a",
     +        ])
     +        .output()
     +        .expect("Make failed to run");
     +    if !make_output.status.success() {
     +        panic!(
    -+                "Make failed:\n  stdout = {}\n  stderr = {}\n",
    -+                String::from_utf8(make_output.stdout).unwrap(),
    -+                String::from_utf8(make_output.stderr).unwrap()
    ++            "Make failed:\n  stdout = {}\n  stderr = {}\n",
    ++            String::from_utf8(make_output.stdout).unwrap(),
    ++            String::from_utf8(make_output.stderr).unwrap()
     +        );
     +    }
     +    std::fs::copy(crate_root.join("libcgit.a"), dst.join("libcgit.a"))?;
    -+    println!("cargo::rustc-link-search=native={}", dst.into_os_string().into_string().unwrap());
    ++    println!("cargo::rustc-link-search=native={}", dst.display());
     +    println!("cargo::rustc-link-lib=cgit");
     +    println!("cargo::rustc-link-lib=z");
    -+    println!("cargo::rerun-if-changed={}", git_root.into_os_string().into_string().unwrap());
    ++    println!("cargo::rerun-if-changed={}", git_root.display());
     +
     +    Ok(())
     +}
     
    - ## contrib/cgit-rs/public_symbol_export.c (new) ##
    + ## contrib/cgit-rs/cgit-sys/public_symbol_export.c (new) ##
     @@
     +// Shim to publicly export Git symbols. These must be renamed so that the
     +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
     +// avoid conflicts with other libraries such as libgit2.
     +
    -+#include "contrib/cgit-rs/public_symbol_export.h"
    ++#include "contrib/cgit-rs/cgit-sys/public_symbol_export.h"
     +#include "version.h"
     +
     +#pragma GCC visibility push(default)
    @@ contrib/cgit-rs/public_symbol_export.c (new)
     +
     +#pragma GCC visibility pop
     
    - ## contrib/cgit-rs/public_symbol_export.h (new) ##
    + ## contrib/cgit-rs/cgit-sys/public_symbol_export.h (new) ##
     @@
     +#ifndef PUBLIC_SYMBOL_EXPORT_H
     +#define PUBLIC_SYMBOL_EXPORT_H
    @@ contrib/cgit-rs/public_symbol_export.h (new)
     +
     +#endif /* PUBLIC_SYMBOL_EXPORT_H */
     
    - ## contrib/cgit-rs/src/lib.rs (new) ##
    + ## contrib/cgit-rs/cgit-sys/src/lib.rs (new) ##
     @@
    -+use libc::c_char;
    ++use std::ffi::c_char;
     +
     +extern "C" {
     +    // From version.c
     +    pub fn libgit_user_agent() -> *const c_char;
     +    pub fn libgit_user_agent_sanitized() -> *const c_char;
     +}
    -
    - ## contrib/cgit-rs/src/main.rs (new) ##
    -@@
    -+use std::ffi::CStr;
    -+
    -+fn main() {
    -+    println!("Let's print some strings provided by Git");
    -+    let c_buf = unsafe { cgit::libgit_user_agent() };
    -+    let c_str = unsafe { CStr::from_ptr(c_buf) };
    -+    println!("git_user_agent() = {:?}", c_str);
    -+    println!("git_user_agent_sanitized() = {:?}",
    -+        unsafe { CStr::from_ptr(cgit::libgit_user_agent_sanitized()) });
    ++
    ++#[cfg(test)]
    ++mod tests {
    ++    use std::ffi::CStr;
    ++
    ++    use super::*;
    ++
    ++    #[test]
    ++    fn user_agent_starts_with_git() {
    ++        let c_str = unsafe { CStr::from_ptr(libgit_user_agent()) };
    ++        let agent = c_str
    ++            .to_str()
    ++            .expect("User agent contains invalid UTF-8 data");
    ++        assert!(
    ++            agent.starts_with("git/"),
    ++            r#"Expected user agent to start with "git/", got: {}"#,
    ++            agent
    ++        );
    ++    }
    ++
    ++    #[test]
    ++    fn sanitized_user_agent_starts_with_git() {
    ++        let c_str = unsafe { CStr::from_ptr(libgit_user_agent_sanitized()) };
    ++        let agent = c_str
    ++            .to_str()
    ++            .expect("Sanitized user agent contains invalid UTF-8 data");
    ++        assert!(
    ++            agent.starts_with("git/"),
    ++            r#"Expected user agent to start with "git/", got: {}"#,
    ++            agent
    ++        );
    ++    }
     +}
4:  b84a8210a0 ! 3:  527780f816 contrib/cgit-rs: add repo initialization and config access
    @@ Commit message
         contrib/cgit-rs: add repo initialization and config access
     
         Co-authored-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
    - ## contrib/cgit-rs/public_symbol_export.c ##
    + ## contrib/cgit-rs/cgit-sys/public_symbol_export.c ##
     @@
      // original symbols can be hidden. Renaming these with a "libgit_" prefix also
      // avoid conflicts with other libraries such as libgit2.
      
     +#include "git-compat-util.h"
    - #include "contrib/cgit-rs/public_symbol_export.h"
    -+#include "attr.h"
    + #include "contrib/cgit-rs/cgit-sys/public_symbol_export.h"
    ++#include "common-init.h"
     +#include "config.h"
     +#include "setup.h"
      #include "version.h"
      
    ++extern struct repository *the_repository;
    ++
      #pragma GCC visibility push(default)
      
     +const char *libgit_setup_git_directory(void)
    @@ contrib/cgit-rs/public_symbol_export.c
     +
     +int libgit_config_get_int(const char *key, int *dest)
     +{
    -+	return git_config_get_int(key, dest);
    ++	return repo_config_get_int(the_repository, key, dest);
     +}
     +
    -+void libgit_initialize_the_repository(void)
    ++void libgit_init_git(const char **argv)
     +{
    -+	initialize_the_repository();
    ++	init_git(argv);
     +}
     +
     +int libgit_parse_maybe_bool(const char *val)
    @@ contrib/cgit-rs/public_symbol_export.c
      const char *libgit_user_agent(void)
      {
      	return git_user_agent();
    -@@ contrib/cgit-rs/public_symbol_export.c: const char *libgit_user_agent_sanitized(void)
    - 	return git_user_agent_sanitized();
    - }
    - 
    -+const char *libgit_attr__true = git_attr__true;
    -+const char *libgit_attr__false = git_attr__false;
    -+
    - #pragma GCC visibility pop
     
    - ## contrib/cgit-rs/public_symbol_export.h ##
    + ## contrib/cgit-rs/cgit-sys/public_symbol_export.h ##
     @@
      #ifndef PUBLIC_SYMBOL_EXPORT_H
      #define PUBLIC_SYMBOL_EXPORT_H
    @@ contrib/cgit-rs/public_symbol_export.h
     +
     +int libgit_config_get_int(const char *key, int *dest);
     +
    -+void libgit_initialize_the_repository(void);
    ++void libgit_init_git(const char **argv);
     +
     +int libgit_parse_maybe_bool(const char *val);
     +
    @@ contrib/cgit-rs/public_symbol_export.h
      
      const char *libgit_user_agent_sanitized(void);
     
    - ## contrib/cgit-rs/src/lib.rs ##
    + ## contrib/cgit-rs/cgit-sys/src/lib.rs ##
     @@
    --use libc::c_char;
    -+use libc::{c_char, c_int};
    +-use std::ffi::c_char;
    ++use std::ffi::{c_char, c_int};
      
      extern "C" {
     +    pub fn libgit_setup_git_directory() -> *const c_char;
     +
     +    // From config.c
    -+    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) ->c_int;
    ++    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) -> c_int;
     +
    -+    // From repository.c
    -+    pub fn libgit_initialize_the_repository();
    ++    // From common-init.c
    ++    pub fn libgit_init_git(argv: *const *const c_char);
     +
     +    // From parse.c
     +    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
    @@ contrib/cgit-rs/src/lib.rs
          // From version.c
          pub fn libgit_user_agent() -> *const c_char;
          pub fn libgit_user_agent_sanitized() -> *const c_char;
    -
    - ## contrib/cgit-rs/src/main.rs ##
    -@@
    --use std::ffi::CStr;
    -+use std::ffi::{CStr, CString};
    +@@ contrib/cgit-rs/cgit-sys/src/lib.rs: extern "C" {
      
    - fn main() {
    -     println!("Let's print some strings provided by Git");
    -@@ contrib/cgit-rs/src/main.rs: fn main() {
    -     println!("git_user_agent() = {:?}", c_str);
    -     println!("git_user_agent_sanitized() = {:?}",
    -         unsafe { CStr::from_ptr(cgit::libgit_user_agent_sanitized()) });
    -+
    -+    println!("\nNow try passing args");
    -+    let test_arg = CString::new("test_arg").unwrap();
    -+    println!("git_parse_maybe_bool(...) = {:?}",
    -+        unsafe { cgit::libgit_parse_maybe_bool(test_arg.as_ptr()) });
    -+
    -+    println!("\nCan we get an int out of our config??");
    -+    unsafe {
    -+        cgit::libgit_initialize_the_repository();
    -+        cgit::libgit_setup_git_directory();
    -+        let mut val: libc::c_int = 0;
    + #[cfg(test)]
    + mod tests {
    +-    use std::ffi::CStr;
    ++    use std::ffi::{CStr, CString};
    + 
    +     use super::*;
    + 
    +@@ contrib/cgit-rs/cgit-sys/src/lib.rs: mod tests {
    +             agent
    +         );
    +     }
    ++
    ++    #[test]
    ++    fn parse_bools_from_strings() {
    ++        let arg = CString::new("true").unwrap();
    ++        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 1);
    ++
    ++        let arg = CString::new("yes").unwrap();
    ++        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 1);
    ++
    ++        let arg = CString::new("false").unwrap();
    ++        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 0);
    ++
    ++        let arg = CString::new("no").unwrap();
    ++        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, 0);
    ++
    ++        let arg = CString::new("maybe").unwrap();
    ++        assert_eq!(unsafe { libgit_parse_maybe_bool(arg.as_ptr()) }, -1);
    ++    }
    ++
    ++    #[test]
    ++    fn access_configs() {
    ++        // NEEDSWORK: we need to supply a testdata config
    ++        let fake_argv = [std::ptr::null::<c_char>()];
    ++        unsafe {
    ++            libgit_init_git(fake_argv.as_ptr());
    ++            libgit_setup_git_directory();
    ++        }
    ++        let mut val: c_int = 0;
     +        let key = CString::new("trace2.eventNesting").unwrap();
    -+        cgit::libgit_config_get_int(
    -+            key.as_ptr(),
    -+            &mut val as *mut i32
    -+        );
    -+        println!(
    -+            "git_config_get_int(\"trace2.eventNesting\") -> {:?}",
    -+            val
    -+        );
    -+    };
    ++        unsafe { libgit_config_get_int(key.as_ptr(), &mut val as *mut i32) };
    ++        assert_eq!(val, 5);
    ++    }
      }
5:  c8befb680e ! 4:  908ad0b82f config: add git_configset_alloc
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    config: add git_configset_alloc
    +    config: add git_configset_alloc() and git_configset_clear_and_free()
     
    -    Add git_configset_alloc so that non-C external consumers can use
    -    configset functions without redefining config_set.
    +    Add git_configset_alloc() so that and git_configset_clear_and_free()
    +    functions so that callers can manage config_set structs on the heap.
    +    This also allows non-C external consumers to treat config_sets as opaque
    +    structs.
     
         Co-authored-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Josh Steadmon <steadmon@google.com>
    -
     
    +    Also add _clear_and_free
    +
    +
      ## config.c ##
     @@ config.c: static int config_set_element_cmp(const void *cmp_data UNUSED,
      	return strcmp(e1->key, e2->key);
    @@ config.c: static int config_set_element_cmp(const void *cmp_data UNUSED,
      void git_configset_init(struct config_set *set)
      {
      	hashmap_init(&set->config_hash, config_set_element_cmp, NULL, 0);
    +@@ config.c: void git_configset_clear(struct config_set *set)
    + 	set->list.items = NULL;
    + }
    + 
    ++void git_configset_clear_and_free(struct config_set *set)
    ++{
    ++	git_configset_clear(set);
    ++	free(set);
    ++}
    ++
    + static int config_set_callback(const char *key, const char *value,
    + 			       const struct config_context *ctx,
    + 			       void *cb)
     
      ## config.h ##
     @@ config.h: struct config_set {
    @@ config.h: struct config_set {
      /**
       * Initializes the config_set `cs`.
       */
    +@@ config.h: int git_configset_get_string_multi(struct config_set *cs, const char *key,
    +  */
    + void git_configset_clear(struct config_set *cs);
    + 
    ++/**
    ++ * Clears and frees a heap-allocated `config_set` structure.
    ++ */
    ++void git_configset_clear_and_free(struct config_set *cs);
    ++
    + /*
    +  * These functions return 1 if not found, and 0 if found, leaving the found
    +  * value in the 'dest' pointer.
6:  1e981a6880 ! 5:  514c744ba4 contrib/cgit-rs: add a subset of configset wrappers
    @@ Metadata
      ## Commit message ##
         contrib/cgit-rs: add a subset of configset wrappers
     
         Signed-off-by: Calvin Wan <calvinwan@google.com>
    -    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
    - ## contrib/cgit-rs/Cargo.lock ##
    -@@ contrib/cgit-rs/Cargo.lock: version = 3
    - name = "cgit"
    - version = "0.1.0"
    - dependencies = [
    -+ "home",
    -  "libc",
    - ]
    - 
    -+[[package]]
    -+name = "home"
    -+version = "0.5.9"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "e3d1354bf6b7235cb4a0576c2619fd4ed18183f689b12b006a0ee7329eeff9a5"
    -+dependencies = [
    -+ "windows-sys",
    -+]
    -+
    - [[package]]
    - name = "libc"
    - version = "0.2.155"
    - source = "registry+https://github.com/rust-lang/crates.io-index"
    - checksum = "97b3888a4aecf77e811145cadf6eef5901f4782c53886191b2f693f24761847c"
    -+
    -+[[package]]
    -+name = "windows-sys"
    -+version = "0.52.0"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "282be5f36a8ce781fad8c8ae18fa3f9beff57ec1b52cb3de0789201425d9a33d"
    -+dependencies = [
    -+ "windows-targets",
    -+]
    + ## .gitignore ##
    +@@ .gitignore: Release/
    + /git.VC.db
    + *.dSYM
    + /contrib/buildsystems/out
    ++/contrib/cgit-rs/target
    + /contrib/cgit-rs/cgit-sys/target
    +
    + ## Makefile ##
    +@@ Makefile: clean: profile-clean coverage-clean cocciclean
    + 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
    + 	$(MAKE) -C Documentation/ clean
    + 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
    +-	$(RM) -r contrib/cgit-rs/cgit-sys/target
    ++	$(RM) -r contrib/cgit-rs/target contrib/cgit-rs/cgit-sys/target
    + ifndef NO_PERL
    + 	$(RM) -r perl/build/
    + endif
    +
    + ## contrib/cgit-rs/Cargo.lock (new) ##
    +@@
    ++# This file is automatically @generated by Cargo.
    ++# It is not intended for manual editing.
    ++version = 3
     +
     +[[package]]
    -+name = "windows-targets"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "9b724f72796e036ab90c1021d4780d4d3d648aca59e491e6b98e725b84e99973"
    ++name = "cgit"
    ++version = "0.1.0"
     +dependencies = [
    -+ "windows_aarch64_gnullvm",
    -+ "windows_aarch64_msvc",
    -+ "windows_i686_gnu",
    -+ "windows_i686_gnullvm",
    -+ "windows_i686_msvc",
    -+ "windows_x86_64_gnu",
    -+ "windows_x86_64_gnullvm",
    -+ "windows_x86_64_msvc",
    ++ "cgit-sys",
     +]
     +
     +[[package]]
    -+name = "windows_aarch64_gnullvm"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "32a4622180e7a0ec044bb555404c800bc9fd9ec262ec147edd5989ccd0c02cd3"
    -+
    -+[[package]]
    -+name = "windows_aarch64_msvc"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "09ec2a7bb152e2252b53fa7803150007879548bc709c039df7627cabbd05d469"
    -+
    -+[[package]]
    -+name = "windows_i686_gnu"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "8e9b5ad5ab802e97eb8e295ac6720e509ee4c243f69d781394014ebfe8bbfa0b"
    -+
    -+[[package]]
    -+name = "windows_i686_gnullvm"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "0eee52d38c090b3caa76c563b86c3a4bd71ef1a819287c19d586d7334ae8ed66"
    -+
    -+[[package]]
    -+name = "windows_i686_msvc"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "240948bc05c5e7c6dabba28bf89d89ffce3e303022809e73deaefe4f6ec56c66"
    -+
    -+[[package]]
    -+name = "windows_x86_64_gnu"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "147a5c80aabfbf0c7d901cb5895d1de30ef2907eb21fbbab29ca94c5b08b1a78"
    ++name = "cgit-sys"
    ++version = "0.1.0"
    +
    + ## contrib/cgit-rs/Cargo.toml (new) ##
    +@@
    ++[package]
    ++name = "cgit"
    ++version = "0.1.0"
    ++edition = "2021"
     +
    -+[[package]]
    -+name = "windows_x86_64_gnullvm"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "24d5b23dc417412679681396f2b49f3de8c1473deb516bd34410872eff51ed0d"
    ++[lib]
    ++path = "src/lib.rs"
     +
    -+[[package]]
    -+name = "windows_x86_64_msvc"
    -+version = "0.52.6"
    -+source = "registry+https://github.com/rust-lang/crates.io-index"
    -+checksum = "589f6da84c646204747d1270a2a5661ea66ed1cced2631d546fdfb155959f9ec"
    ++[dependencies]
    ++cgit-sys = { version = "0.1.0", path = "cgit-sys" }
     
    - ## contrib/cgit-rs/Cargo.toml ##
    -@@ contrib/cgit-rs/Cargo.toml: path = "src/lib.rs"
    - 
    - [dependencies]
    - libc = "0.2.155"
    -+home = "0.5.9"
    -
    - ## contrib/cgit-rs/public_symbol_export.c ##
    -@@ contrib/cgit-rs/public_symbol_export.c: int libgit_parse_maybe_bool(const char *val)
    + ## contrib/cgit-rs/cgit-sys/public_symbol_export.c ##
    +@@ contrib/cgit-rs/cgit-sys/public_symbol_export.c: int libgit_parse_maybe_bool(const char *val)
      	return git_parse_maybe_bool(val);
      }
      
    @@ contrib/cgit-rs/public_symbol_export.c: int libgit_parse_maybe_bool(const char *
     +	return git_configset_alloc();
     +}
     +
    ++void libgit_configset_clear_and_free(struct config_set *cs)
    ++{
    ++	git_configset_clear_and_free(cs);
    ++}
    ++
     +void libgit_configset_init(struct config_set *cs)
     +{
     +	git_configset_init(cs);
    @@ contrib/cgit-rs/public_symbol_export.c: int libgit_parse_maybe_bool(const char *
      {
      	return git_user_agent();
     
    - ## contrib/cgit-rs/public_symbol_export.h ##
    -@@ contrib/cgit-rs/public_symbol_export.h: void libgit_initialize_the_repository(void);
    + ## contrib/cgit-rs/cgit-sys/public_symbol_export.h ##
    +@@ contrib/cgit-rs/cgit-sys/public_symbol_export.h: void libgit_init_git(const char **argv);
      
      int libgit_parse_maybe_bool(const char *val);
      
     +struct config_set *libgit_configset_alloc(void);
     +
    ++void libgit_configset_clear_and_free(struct config_set *cs);
    ++
     +void libgit_configset_init(struct config_set *cs);
     +
     +int libgit_configset_add_file(struct config_set *cs, const char *filename);
    @@ contrib/cgit-rs/public_symbol_export.h: void libgit_initialize_the_repository(vo
      
      const char *libgit_user_agent_sanitized(void);
     
    - ## contrib/cgit-rs/src/lib.rs ##
    + ## contrib/cgit-rs/cgit-sys/src/lib.rs ##
     @@
    --use libc::{c_char, c_int};
    -+use std::ffi::{CStr, CString};
    +-use std::ffi::{c_char, c_int};
    ++use std::ffi::{c_char, c_int, c_void};
    ++
    ++#[allow(non_camel_case_types)]
    ++#[repr(C)]
    ++pub struct config_set {
    ++    _data: [u8; 0],
    ++    _marker: core::marker::PhantomData<(*mut u8, core::marker::PhantomPinned)>,
    ++}
    + 
    + extern "C" {
    ++    pub fn free(ptr: *mut c_void);
     +
    -+use libc::{c_char, c_int, c_void};
    +     pub fn libgit_setup_git_directory() -> *const c_char;
    + 
    +     // From config.c
    +@@ contrib/cgit-rs/cgit-sys/src/lib.rs: extern "C" {
    +     // From version.c
    +     pub fn libgit_user_agent() -> *const c_char;
    +     pub fn libgit_user_agent_sanitized() -> *const c_char;
     +
    -+pub enum GitConfigSet {}
    ++    pub fn libgit_configset_alloc() -> *mut config_set;
    ++    pub fn libgit_configset_clear_and_free(cs: *mut config_set);
     +
    -+pub struct ConfigSet(*mut GitConfigSet);
    -+impl ConfigSet {
    ++    pub fn libgit_configset_init(cs: *mut config_set);
    ++
    ++    pub fn libgit_configset_add_file(cs: *mut config_set, filename: *const c_char) -> c_int;
    ++
    ++    pub fn libgit_configset_get_int(
    ++        cs: *mut config_set,
    ++        key: *const c_char,
    ++        int: *mut c_int,
    ++    ) -> c_int;
     +
    ++    pub fn libgit_configset_get_string(
    ++        cs: *mut config_set,
    ++        key: *const c_char,
    ++        dest: *mut *mut c_char,
    ++    ) -> c_int;
    ++
    + }
    + 
    + #[cfg(test)]
    +
    + ## contrib/cgit-rs/src/lib.rs (new) ##
    +@@
    ++use std::ffi::{c_char, c_int, c_void, CStr, CString};
    ++
    ++use cgit_sys::*;
    ++
    ++pub struct ConfigSet(*mut config_set);
    ++impl ConfigSet {
     +    pub fn new() -> Self {
     +        unsafe {
    -+            // TODO: we need to handle freeing this when the ConfigSet is dropped
    -+            // git_configset_clear(ptr) and then libc::free(ptr)
     +            let ptr = libgit_configset_alloc();
     +            libgit_configset_init(ptr);
     +            ConfigSet(ptr)
     +        }
     +    }
     +
    ++    // NEEDSWORK: maybe replace &str with &Path
     +    pub fn add_files(&mut self, files: &[&str]) {
     +        for file in files {
     +            let rs = CString::new(*file).expect("Couldn't convert to CString");
    @@ contrib/cgit-rs/src/lib.rs
     +        let key = CString::new(key).expect("Couldn't convert to CString");
     +        let mut val: *mut c_char = std::ptr::null_mut();
     +        unsafe {
    -+            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0 {
    ++            if libgit_configset_get_string(self.0, key.as_ptr(), &mut val as *mut *mut c_char) != 0
    ++            {
     +                return None;
     +            }
     +            let borrowed_str = CStr::from_ptr(val);
     +            let owned_str = CString::from_vec_with_nul(borrowed_str.to_bytes_with_nul().to_vec());
    -+            libc::free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
    ++            free(val as *mut c_void); // Free the xstrdup()ed pointer from the C side
     +            Some(owned_str.unwrap())
     +        }
     +    }
     +}
    - 
    - extern "C" {
    -     pub fn libgit_setup_git_directory() -> *const c_char;
    -@@ contrib/cgit-rs/src/lib.rs: extern "C" {
    -     // From version.c
    -     pub fn libgit_user_agent() -> *const c_char;
    -     pub fn libgit_user_agent_sanitized() -> *const c_char;
    -+
    -+    fn libgit_configset_alloc() -> *mut GitConfigSet;
    -+
    -+    fn libgit_configset_init(cs: *mut GitConfigSet);
     +
    -+    fn libgit_configset_add_file(cs: *mut GitConfigSet, filename: *const c_char) -> c_int;
    ++impl Default for ConfigSet {
    ++    fn default() -> Self {
    ++        Self::new()
    ++    }
    ++}
     +
    -+    pub fn libgit_configset_get_int(cs: *mut GitConfigSet, key: *const c_char, int: *mut c_int) -> c_int;
    -+    pub fn libgit_configset_get_string(cs: *mut GitConfigSet, key: *const c_char, dest: *mut *mut c_char) -> c_int;
    ++impl Drop for ConfigSet {
    ++    fn drop(&mut self) {
    ++        unsafe {
    ++            libgit_configset_clear_and_free(self.0);
    ++        }
    ++    }
    ++}
     +
    - }
    -
    - ## contrib/cgit-rs/src/main.rs ##
    -@@
    - use std::ffi::{CStr, CString};
    -+use home::home_dir;
    - 
    - fn main() {
    -     println!("Let's print some strings provided by Git");
    -@@ contrib/cgit-rs/src/main.rs: fn main() {
    -             val
    -         );
    -     };
    -+
    -+    println!("\nTry out our configset wrappers");
    -+    let mut cs = cgit::ConfigSet::new();
    -+    let mut path = home_dir().expect("cannot get home directory path");
    -+    path.push(".gitconfig");
    -+    let path:String = path.into_os_string().into_string().unwrap();
    -+    cs.add_files(&["/etc/gitconfig", ".gitconfig", &path]);
    -+    /*
    -+     * Returns Some(x) if defined in local config, otherwise None
    -+     */
    -+    println!("get_configset_get_int = {:?}", cs.get_int("trace2.eventNesting")); 
    -+    println!("cs.get_str(\"garbage\") = {:?}", cs.get_str("this_string_does_not_exist"));
    - }
    ++#[cfg(test)]
    ++mod tests {
    ++    use super::*;
    ++
    ++    #[test]
    ++    fn load_configs_via_configset() {
    ++        // NEEDSWORK: we need to supply a testdata config
    ++        let mut cs = ConfigSet::new();
    ++        let mut path = std::env::home_dir().expect("cannot get home directory path");
    ++        path.push(".gitconfig");
    ++        let path: String = path.into_os_string().into_string().unwrap();
    ++        cs.add_files(&["/etc/gitconfig", ".gitconfig", &path]);
    ++        assert_eq!(cs.get_int("trace2.eventNesting"), Some(5));
    ++        assert_eq!(cs.get_str("no_such_config_item"), None);
    ++    }
    ++}

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
2.46.0.76.ge559c4bf1a-goog

