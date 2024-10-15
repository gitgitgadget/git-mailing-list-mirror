Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E0D21E3D1
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032663; cv=none; b=LvpPxCustdhIlrQtUOdbmmwX+DWr/e+iecPDTzI8YPkAa/hYkDHlfhAFYQwTT5Bb18e+BiQoAytSKJWkRrzdeGVUZ7fv2wIErza0suwrGdiBbBszGJx92kVtAAa4e0shO2axIhxGQ/b8ayBF1JUDd6OBjFKk/9E8WHbj3OT4MAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032663; c=relaxed/simple;
	bh=xVWHdQ45+i4o6u+/+PY4NQhGXSZK4lUMpWlF8UY23qQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GJ8wSTOS8YodQT2nTq5FeMn7S9MmbHsZ64P7bxwof/48g2Mr35Jo+GUgi7eRoUSF1hhwAIvwEO5xoHV1K8ED9aqESAj/F8p7RtdC9EfbQwjfRpdz346t46D0cj24bnfcZ/AAmDg3TVq1vss6goqkYciwqN0m6GbToNdplLRGvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNCf6Fri; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNCf6Fri"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e000d68bb1so4081977b3.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729032660; x=1729637460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+u1tR34256au9OfQLGSzqaLg5JMVO5cb/iy42ud8og=;
        b=fNCf6FriasJquB+cBmDh6C8bW03CfZmjizcLnu6R8QDsqy4oeP7iVflXqoQ/+B0c3g
         q7mZWVKgh8gHCB97xRJ66sjeXPncdIrGW3tZnNaiByXj6FUw09jxrLbxmMcTArwvidd8
         rEZqYk6tzNMVkeKV9XrKxqGgl3rWw4LduH8qNFNmP9025dIZfV6Nyt62x+DVYDlrn7Jp
         JIpKgHy1J6S9bJNDQ39H6HSzwI5jW69wZY8Omf99g1fvCLPVoWLv6dDyRl7g+0HvLbRq
         DZwuy5sYNFjL2TZJV/kdxLZu5aDBtiNB5IA9tEqAAWOFk7nl92JxJlbpkziC5Sg6kzKS
         vtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032660; x=1729637460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+u1tR34256au9OfQLGSzqaLg5JMVO5cb/iy42ud8og=;
        b=ZkEiknmPtyR2g5E4PlPNSy4LSpjZA3iJPZeKsKqLW5D90jSybIA0PcAEOKsS4M5ZY0
         M/ne+xuWBy8y0XGZJnA4c2igI+D4rAXPYD9e4ICKiBl2hkFZwTaNIM1Lnv6QsqxCEsiX
         Tyf4FGDWMyeUafKt2G711PLuh/6tVeFWlobKHAHBY9V1WLQapmfu2JXm4et7JzbPAfo8
         NCdW0LTkfWw94BGcGjwv70zWlZIDIDIDbB63eTK1FegrO2IPC67ToAc96mDUWwBUXq0I
         W9uNosE2UqCl/v0NVYYJtWahV2+dMspFibRBjk+yarObzNej9nWHtHPhRADIkrJJh9VZ
         UOjw==
X-Gm-Message-State: AOJu0Ywulraw5UIzx9fiT53e0sIs7lIx4i639R8H7qBspqEcXqqw10ie
	yXYsjikwVXrg7IEWk+XKxDI21H0PjIXqOFO6WTRSdUQURQsK20GpeeKuKT28azRbW4OucxDVR76
	n93kriIy9CkIScjBg6NwOlrxGUR/UeSJKAjSRF5EdJNtaVnm1E7xwLryuhIJe2mZTMDbXLcDsqw
	1ultLIv2W2EKRCbg/ECwO4+IKP+iqErEYjJjoASVs=
X-Google-Smtp-Source: AGHT+IHV4woYHhuGzBVfB9BurJyHNNGDfiIMjLIwRhiu3Wk+APyuDg7VBuqoknzfyhUXDUP8ABhIYZ1XA+g+bA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:ddcc:6d3c:e4d6:3076])
 (user=steadmon job=sendgmr) by 2002:a5b:f09:0:b0:e29:ad0:a326 with SMTP id
 3f1490d57ef6-e2976fbb30bmr16254276.0.1729032659471; Tue, 15 Oct 2024 15:50:59
 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:50:52 -0700
In-Reply-To: <cover.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723054623.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <cover.1729032373.git.steadmon@google.com>
Subject: [PATCH v5 0/5] Introduce libgit-rs, a Rust wrapper around libgit.a
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, emrass@google.com, gitster@pobox.com, 
	mh@glandium.org, sandals@crustytoothpaste.net, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com, 
	rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

A quick note: normally I'd wait longer for more feedback before sending
out a new reroll, but due to some firefighting at $DAYJOB, I will not
have time to focus on this series for the next several weeks, possibly
up to a month. I wanted to get V5 out before then, but please understand
that I will not be able to address new feedback for a while.

This series provides two small Rust wrapper libraries around parts of
Git: "libgit-sys", which exposes a few functions from libgit.a, and
"libgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/martinvonz/jj

Please find V1 cover letter here:
https://lore.kernel.org/git/cover.1723054623.git.steadmon@google.com/

Known NEEDSWORK:

* Investigate alternative methods of managing symbol visibility &
  renaming.

* Figure out symbol versioning

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

 .gitignore                                    |  2 +
 Makefile                                      | 44 +++++++++
 common-exit.c                                 | 26 +++++
 common-init.c                                 | 63 ++++++++++++
 common-init.h                                 |  6 ++
 common-main.c                                 | 83 +---------------
 contrib/libgit-rs/Cargo.lock                  | 77 +++++++++++++++
 contrib/libgit-rs/Cargo.toml                  | 15 +++
 contrib/libgit-rs/build.rs                    |  4 +
 contrib/libgit-rs/libgit-sys/Cargo.lock       | 69 ++++++++++++++
 contrib/libgit-rs/libgit-sys/Cargo.toml       | 17 ++++
 contrib/libgit-rs/libgit-sys/README.md        | 15 +++
 contrib/libgit-rs/libgit-sys/build.rs         | 35 +++++++
 .../libgit-sys/public_symbol_export.c         | 50 ++++++++++
 .../libgit-sys/public_symbol_export.h         | 18 ++++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 79 +++++++++++++++
 contrib/libgit-rs/src/lib.rs                  | 95 +++++++++++++++++++
 contrib/libgit-rs/testdata/config1            |  2 +
 contrib/libgit-rs/testdata/config2            |  2 +
 contrib/libgit-rs/testdata/config3            |  2 +
 t/Makefile                                    | 16 ++++
 21 files changed, 639 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/build.rs
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-rs/libgit-sys/README.md
 create mode 100644 contrib/libgit-rs/libgit-sys/build.rs
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-rs/libgit-sys/src/lib.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3

Range-diff against v4:
4:  2ed503216f ! 1:  1ae14207f6 Makefile: add option to build and test libgit-rs and libgit-rs-sys
    @@
      ## Metadata ##
    -Author: Calvin Wan <calvinwan@google.com>
    +Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    Makefile: add option to build and test libgit-rs and libgit-rs-sys
    +    common-main: split init and exit code into new files
     
    -    Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
    -    to their respective Makefiles so they can be built and tested without
    -    having to run cargo build/test.
    +    Currently, object files in libgit.a reference common_exit(), which is
    +    contained in common-main.o. However, common-main.o also includes main(),
    +    which references cmd_main() in git.o, which in turn depends on all the
    +    builtin/*.o objects.
     
    -    Add environment variable, INCLUDE_LIBGIT_RS, that when set,
    -    automatically builds and tests libgit-rs and libgit-rs-sys when `make
    -    all` is ran.
    +    We would like to allow external users to link libgit.a without needing
    +    to include so many extra objects. Enable this by splitting common_exit()
    +    and check_bug_if_BUG() into a new file common-exit.c, and add
    +    common-exit.o to LIB_OBJS so that these are included in libgit.a.
     
    -    Signed-off-by: Calvin Wan <calvinwan@google.com>
    +    This split has previously been proposed ([1], [2]) to support fuzz tests
    +    and unit tests by avoiding conflicting definitions for main(). However,
    +    both of those issues were resolved by other methods of avoiding symbol
    +    conflicts. Now we are trying to make libgit.a more self-contained, so
    +    hopefully we can revisit this approach.
    +
    +    Additionally, move the initialization code out of main() into a new
    +    init_git() function in its own file. Include this in libgit.a as well,
    +    so that external users can share our setup code without calling our
    +    main().
    +
    +    [1] https://lore.kernel.org/git/Yp+wjCPhqieTku3X@google.com/
    +    [2] https://lore.kernel.org/git/20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com/
    +
    +    Signed-off-by: Josh Steadmon <steadmon@google.com>
     
      ## Makefile ##
    -@@ Makefile: build-unit-tests: $(UNIT_TEST_PROGS)
    - unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
    - 	$(MAKE) -C t/ unit-tests
    +@@ Makefile: LIB_OBJS += combine-diff.o
    + LIB_OBJS += commit-graph.o
    + LIB_OBJS += commit-reach.o
    + LIB_OBJS += commit.o
    ++LIB_OBJS += common-exit.o
    ++LIB_OBJS += common-init.o
    + LIB_OBJS += compat/nonblock.o
    + LIB_OBJS += compat/obstack.o
    + LIB_OBJS += compat/terminal.o
    +
    + ## common-exit.c (new) ##
    +@@
    ++#include "git-compat-util.h"
    ++#include "trace2.h"
    ++
    ++static void check_bug_if_BUG(void)
    ++{
    ++	if (!bug_called_must_BUG)
    ++		return;
    ++	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
    ++}
    ++
    ++/* We wrap exit() to call common_exit() in git-compat-util.h */
    ++int common_exit(const char *file, int line, int code)
    ++{
    ++	/*
    ++	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
    ++	 * to e.g. turn -1 into 255. On a POSIX system this is
    ++	 * redundant, see exit(3) and wait(2), but as it doesn't harm
    ++	 * anything there we don't need to guard this with an "ifdef".
    ++	 */
    ++	code &= 0xff;
    ++
    ++	check_bug_if_BUG();
    ++	trace2_cmd_exit_fl(file, line, code);
    ++
    ++	return code;
    ++}
    +
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
    + ## common-main.c ##
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
      
    -+.PHONY: libgitrs-sys
    -+libgitrs-sys:
    -+	$(QUIET)(\
    -+		cd contrib/libgit-rs/libgit-sys && \
    -+		cargo build \
    -+	)
    -+.PHONY: libgitrs
    -+libgitrs:
    -+	$(QUIET)(\
    -+		cd contrib/libgit-rs && \
    -+		cargo build \
    -+	)
    -+ifdef INCLUDE_LIBGIT_RS
    -+all:: libgitrs
    -+endif
    -+
    - contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
    - 	$(LD) -r $^ -o $@
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
      
    -
    - ## t/Makefile ##
    -@@ t/Makefile: perf:
    ++	init_git(argv);
    + 	result = cmd_main(argc, argv);
      
    - .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
    - 	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
    -+
    -+.PHONY: libgitrs-sys-test
    -+libgitrs-sys-test:
    -+	$(QUIET)(\
    -+		cd ../contrib/libgit-rs/libgit-sys && \
    -+		cargo test \
    -+	)
    -+.PHONY: libgitrs-test
    -+libgitrs-test:
    -+	$(QUIET)(\
    -+		cd ../contrib/libgit-rs && \
    -+		cargo test \
    -+	)
    -+ifdef INCLUDE_LIBGIT_RS
    -+all:: libgitrs-sys-test libgitrs-test
    -+endif
    + 	/* Not exit(3), but a wrapper calling our common_exit() */
    + 	exit(result);
    + }
    +-
    +-static void check_bug_if_BUG(void)
    +-{
    +-	if (!bug_called_must_BUG)
    +-		return;
    +-	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
    +-}
    +-
    +-/* We wrap exit() to call common_exit() in git-compat-util.h */
    +-int common_exit(const char *file, int line, int code)
    +-{
    +-	/*
    +-	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
    +-	 * to e.g. turn -1 into 255. On a POSIX system this is
    +-	 * redundant, see exit(3) and wait(2), but as it doesn't harm
    +-	 * anything there we don't need to guard this with an "ifdef".
    +-	 */
    +-	code &= 0xff;
    +-
    +-	check_bug_if_BUG();
    +-	trace2_cmd_exit_fl(file, line, code);
    +-
    +-	return code;
    +-}
1:  ed925d6a33 ! 2:  1ed010c378 libgit-sys: introduce Rust wrapper for libgit.a
    @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(MAKE) -C Documentation/ clean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
     +	$(RM) -r contrib/libgit-rs/libgit-sys/target
    ++	$(RM) -r contrib/libgit-rs/libgit-sys/partial_symbol_export.o
    ++	$(RM) -r contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
    ++	$(RM) -r contrib/libgit-rs/libgit-sys/libgitpub.a
      ifndef NO_PERL
      	$(RM) -r perl/build/
      endif
2:  8eeab7b418 = 3:  00762b57d0 libgit-sys: also export some config_set functions
3:  29599e9c7b ! 4:  4e5360931b libgit: add higher-level libgit crate
    @@ Metadata
      ## Commit message ##
         libgit: add higher-level libgit crate
     
    -    Wrap `struct config_set` and a few of its associated functions in
    -    libgit-sys. Also introduce a higher-level "libgit" crate which provides
    -    a more Rust-friendly interface to config_set structs.
    +    The C functions exported by libgit-sys do not provide an idiomatic Rust
    +    interface. To make it easier to use these functions via Rust, add a
    +    higher-level "libgit" crate, that wraps the lower-level configset API
    +    with an interface that is more Rust-y.
    +
    +    This combination of $X and $X-sys crates is a common pattern for FFI in
    +    Rust, as documented in "The Cargo Book" [1].
    +
    +    [1] https://doc.rust-lang.org/cargo/reference/build-scripts.html#-sys-packages
     
         Co-authored-by: Josh Steadmon <steadmon@google.com>
         Signed-off-by: Josh Steadmon <steadmon@google.com>
    @@ Makefile: clean: profile-clean coverage-clean cocciclean
      	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
     -	$(RM) -r contrib/libgit-rs/libgit-sys/target
     +	$(RM) -r contrib/libgit-rs/target contrib/libgit-rs/libgit-sys/target
    - ifndef NO_PERL
    - 	$(RM) -r perl/build/
    - endif
    + 	$(RM) -r contrib/libgit-rs/libgit-sys/partial_symbol_export.o
    + 	$(RM) -r contrib/libgit-rs/libgit-sys/hidden_symbol_export.o
    + 	$(RM) -r contrib/libgit-rs/libgit-sys/libgitpub.a
     
      ## contrib/libgit-rs/Cargo.lock (new) ##
     @@
    @@ contrib/libgit-rs/src/lib.rs (new)
     +        }
     +    }
     +
    -+    pub fn get_int(&mut self, key: &str) -> Option<c_int> {
    ++    pub fn get_int(&mut self, key: &str) -> Option<i32> {
     +        let key = CString::new(key).expect("Couldn't convert to CString");
     +        let mut val: c_int = 0;
     +        unsafe {
    @@ contrib/libgit-rs/src/lib.rs (new)
     +            }
     +        }
     +
    -+        Some(val)
    ++        Some(val.into())
     +    }
     +
     +    pub fn get_string(&mut self, key: &str) -> Option<String> {
-:  ---------- > 5:  15ce989de8 Makefile: add option to build and test libgit-rs and libgit-rs-sys

base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
-- 
2.47.0.rc1.288.g06298d1525-goog

