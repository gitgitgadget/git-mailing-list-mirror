Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605714D44A
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731241; cv=none; b=oFn72bX5QrS8lavX0YCmBBwCmo5+5PqOIgRstSvCSwe7yMMZ+d+uTezixfRkynwQzNhLuNoMtomGjXebVnhW/+RRbkooCiMd/Xc+a37b+JJ5GV9C7ytgRHZaRx9mkyKxN/Y1FSkqlS1034nf63/yIKZIASdQNvrcTpifw6fLWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731241; c=relaxed/simple;
	bh=977K93+4EFHrZomBu+njJlsqiSzMmMASnepLh2bc1Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UucTgs9Mcn7cP+6fdhSCvyTKj0XfnEhSqipXXGXzGPf73G5wT5/uDosr24IjlrWSPBwzbLCLh5KqORr9AqzqfRHmL9arPZBPXvb7eUZrRFcgETSa3dZp1jf4H66vHG0dNqrSgDc2st1sFnFkOz1lUJC/GP2I1Zsu0mhb7/s4aeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSCHQxa2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSCHQxa2"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608d2cffc7eso452587b3.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 15:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708731238; x=1709336038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk8wCwzqJEloTGnwg85Q+otVahwLLq8/UErA1bmzRCU=;
        b=PSCHQxa2UpI5TPRvnJlbkkpSFr67UV4Km7yE98ebzytTT2I662NjjaDiahiaMljuj/
         ITjbbYvF6OuQHYsc71pVqpxyOHsvuo3SbwSDHhTX1JJ+0CR0Yvb+zYOKsEk5S25kjCVC
         z9Lj8FWMsxddjkbO81GAs9U3/WgFiy6g5sxVClTwRMmy86iluhFskNmGZIC+EoPiaHpx
         VYcYzR1DipebXd5kUGuoyqFMTAby6kCltu1Zn91TEN1F0jD7T0zUkbsEz6EcyAqb+FWS
         KVDdCo/wsGTuUo0JelTu9rTNhOiFASztTT++yWqZ275TeKLeAUWdnHSWSBA9/9sS3/+y
         9qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731238; x=1709336038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk8wCwzqJEloTGnwg85Q+otVahwLLq8/UErA1bmzRCU=;
        b=RGmLgFFao8NTUdh1Mo0Pfztmo3YvxafypZsjjksb7DiKc4fQWoONhCA7tQST68gP90
         sGzi31A7o2mwV43G+4YMHFTCTqqo2IHsgt9IDwz6OvWeghFyjQNlac5/oAymD0+AwT7q
         soZDP+3KRmxwCb9TmP0Q0YhLrErDcwbl16c6Ye5i/qxeTGct9n6zsTvRLhavqj8EEdZx
         JXZFlCN1CDeORetAWPiHeT7iJY1PFdKc6mx71F4GJokMOrRaTTJiBqCp1KUJK6KHVsjN
         0zMFM49DPoW4dKvu51pWTzuMxVRcDBhV/yDqVxwfLQiPeIRfguQ9FB6DCIZy+y3RCo+u
         AEjw==
X-Gm-Message-State: AOJu0YyFQwxg1K+ABYwVxebt94MwHQZEe0ebn12LvT3X37rbEI/dVI9r
	rfjMCRnx7bjj7r8pbZOtBsowKF/tUmUMnRe3DVy6tDnlc90hhJbBQH1ohNiYsxxp8r0NbiZyXxs
	yLeJyodJ6I9YHFQiddO3dKlxXYQqwR9f+PV+SnkHTOuOrKGRCj6OFGkfM55QUG0N4UBKJK8UY6v
	cbahAMRCKgunkCG2cjrPvHQRl2hqjzxv4cHu1vMV8=
X-Google-Smtp-Source: AGHT+IGW4LKbZHhhf9yI4sNsOY0dZGmlZtLA4WdVjuVe2/doZ8MDPEDkbni/KgagtoPPAu+t0YACqLYMfS/zzw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2fd9:97d1:a490:26b8])
 (user=steadmon job=sendgmr) by 2002:a81:6d8d:0:b0:608:b76c:406 with SMTP id
 i135-20020a816d8d000000b00608b76c0406mr312361ywc.1.1708731238492; Fri, 23 Feb
 2024 15:33:58 -0800 (PST)
Date: Fri, 23 Feb 2024 15:33:49 -0800
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <cover.1708728717.git.steadmon@google.com>
Subject: [PATCH v3 0/7] test-tool: add unit test suite runner
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Please note: this series has once again been rebased onto the latest
jk/unit-tests-buildfix.

For various reasons (see discussion at [1]) we would like an alternative
to `prove` for running test suites (including the unit tests) on
Windows.

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/

This series extends the existing `test-tool run-command testsuite` to
support running unit tests. In addition, it includes some small
cleanups:
* move t-basic out of the unit-tests directory
* don't hardcode the shell for running tests in `test-tool ... testsuite`
* don't hardcode a test name filter in `test-tool ... testsuite`
* add a test wrapper script to allow unit tests and the shell test suite
  to run in a single `prove` process

Changes in V3:
* Added new patch (#7) to use the new test-tool runner for unit tests in
  Windows CI.
* Restored the explicit sort call in t/Makefile, for backwards
  compatibility with older GNU Make versions.
* Rebased the series on the latest jk/unit-tests-buildfix branch.
* Fixed header include order in patch #1.
* Removed a paragraph in patch #1's commit message that is obsolete now
  that we're building the list of test files from the sources rather
  than by globbing.
* Added a note in patch #2 that setting a NULL suite.shell_path will be
  used in a later commit.
* Clarified up some sloppy wording in commit messages and comments in
  t/helper/test-run-command.c.

Changes in V2:
* Rebased the series on the latest jk/unit-tests-buildfix branch.
* Patch 1: move t-basic to a test-tool subcommand rather than a new
  executable under t/t0080/
* New patch 2: get the shell path from TEST_SHELL_PATH in
  `test-tool run-command testsuite`
* New patch 3: remove the hardcoded filename filter in
  `test-tool run-command testsuite`
* Patch 4 (previously 2): simplified now that we no longer need to add
  any command-line flags to support unit tests
* Patch 5 (previously 3): avoid trying to run cmake *.pdb files by using
  the unit test list built in the makefile in jk/unit-tests-buildfix.


Jeff King (1):
  t/Makefile: run unit tests alongside shell tests

Josh Steadmon (6):
  t0080: turn t-basic unit test into a helper
  test-tool run-command testsuite: get shell from env
  test-tool run-command testsuite: remove hardcoded filter
  test-tool run-command testsuite: support unit tests
  unit tests: add rule for running with test-tool
  ci: use test-tool as unit test runner on Windows

 Makefile                                      |  6 ++--
 ci/run-build-and-tests.sh                     |  2 --
 ci/run-test-slice.sh                          |  2 +-
 t/Makefile                                    | 14 ++++++++--
 .../t-basic.c => helper/test-example-tap.c}   |  5 ++--
 t/helper/test-run-command.c                   | 28 +++++++++++++++----
 t/helper/test-tool.c                          |  1 +
 t/helper/test-tool.h                          |  1 +
 t/run-test.sh                                 | 13 +++++++++
 t/t0080-unit-test-output.sh                   | 24 ++++++++--------
 10 files changed, 67 insertions(+), 29 deletions(-)
 rename t/{unit-tests/t-basic.c => helper/test-example-tap.c} (95%)
 create mode 100755 t/run-test.sh

Range-diff against v2:
1:  da756b4bfb ! 1:  6777451100 t0080: turn t-basic unit test into a helper
    @@ Commit message
         t0080-unit-test-output.sh, so let's move it to
         t/helper/test-example-tap.c and adjust Makefiles as necessary.
     
    -    This has the additional benefit that test harnesses seeking to run all
    -    unit tests can find them with a simple glob of "t/unit-tests/bin/t-*",
    -    with no exceptions needed. This will be important in a later patch where
    -    we add support for running the unit tests via a test-tool subcommand.
    -
     
      ## Makefile ##
    @@ Makefile: perf: all
      	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
     
      ## t/Makefile ##
    -@@ t/Makefile: TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
    - CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
    +@@ t/Makefile: CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.tes
      CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
      UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
    --UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
    + UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
     -UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
    -+UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
    ++UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
      
      # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
      # checks all tests in all scripts via a single invocation, so tell individual
    @@ t/Makefile: TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
      ## t/unit-tests/t-basic.c => t/helper/test-example-tap.c ##
     @@
     -#include "test-lib.h"
    -+#include "t/unit-tests/test-lib.h"
     +#include "test-tool.h"
    ++#include "t/unit-tests/test-lib.h"
      
      /*
       * The purpose of this "unit test" is to verify a few invariants of the unit
2:  c8448406d7 ! 2:  24f47f8fc7 test-tool run-command testsuite: get shell from env
    @@ Commit message
         Add a shell_path field in struct testsuite so that we can pass this to
         the task runner callback. If this is non-null, we'll use it as the
         argv[0] of the subprocess. Otherwise, we'll just execute the test
    -    program directly.
    +    program directly. We will use this feature in a later commit to enable
    +    running binary executable unit tests.
     
    -    When setting up the struct testsuite in testsuite(), use the value
    -    of TEST_SHELL_PATH if it's set, otherwise default to `sh`.
    +    However, for now when setting up the struct testsuite in testsuite(),
    +    use the value of TEST_SHELL_PATH if it's set, otherwise keep the
    +    original behavior by defaulting to `sh`.
     
         [1] https://lore.kernel.org/git/20240123005913.GB835964@coredump.intra.peff.net/
     
3:  e1b89ae93e = 3:  4a16a3ec24 test-tool run-command testsuite: remove hardcoded filter
4:  b5665386b5 ! 4:  abc9a7afe8 test-tool run-command testsuite: support unit tests
    @@ Commit message
         test-tool run-command testsuite: support unit tests
     
         Teach the testsuite runner in `test-tool run-command testsuite` how to
    -    run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
    -    the programs directly from CWD, rather than defaulting to "sh" as an
    -    interpreter.
    +    run unit tests: if TEST_SHELL_PATH is not set, run the programs directly
    +    from CWD, rather than defaulting to "sh" as an interpreter.
     
         With this change, you can now use test-tool to run the unit tests:
         $ make
    @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      		max_jobs = online_cpus();
      
     +	/*
    -+	 * If we run without a shell, we have to provide the relative path to
    -+	 * the executables.
    ++	 * If we run without a shell, execute the programs directly from CWD.
     +	 */
      	suite.shell_path = getenv("TEST_SHELL_PATH");
      	if (!suite.shell_path)
5:  f2746703d5 ! 5:  a8bbff2c6b unit tests: add rule for running with test-tool
    @@ Makefile: $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_
      	$(MAKE) -C t/ unit-tests
     
      ## t/Makefile ##
    -@@ t/Makefile: CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.tes
    - CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
    +@@ t/Makefile: CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
      UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
    - UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
    + UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
    + UNIT_TESTS = $(sort $(UNIT_TEST_PROGRAMS))
     +UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
      
      # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
6:  cd7467a7bd ! 6:  cfcc4bd427 t/Makefile: run unit tests alongside shell tests
    @@ Commit message
         twice in CI, as discussed in [1].
     
         Additionally, this moves the unit tests into the main dev workflow, so
    -    that errors can be spotted more quickly.
    -
    -    NEEDS WORK: as discussed in previous commits in this series, there's a
    -    desire to avoid `prove` specifically and (IIUC) unnecessary
    -    fork()/exec()ing in general on Windows. This change adds an extra exec()
    -    for each shell and unit test execution, will that be a problem for
    -    Windows?
    +    that errors can be spotted more quickly. Accordingly, we remove the
    +    separate unit tests step for Linux CI. (We leave the Windows CI
    +    unit-test step as-is, because the sharding scheme there involves
    +    selecting specific test files rather than running `make test`.)
     
         [1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    + ## ci/run-build-and-tests.sh ##
    +@@ ci/run-build-and-tests.sh: if test -n "$run_tests"
    + then
    + 	group "Run tests" make test ||
    + 	handle_failed_tests
    +-	group "Run unit tests" \
    +-		make DEFAULT_UNIT_TEST_TARGET=unit-tests-prove unit-tests
    + fi
    + check_unignored_build_artifacts
    + 
    +
      ## t/Makefile ##
     @@ t/Makefile: failed:
      	test -z "$$failed" || $(MAKE) $$failed
-:  ---------- > 7:  cbf37e0ddc ci: use test-tool as unit test runner on Windows

base-commit: 4904a4d08cc085716df12ce713ae7ee3d5ecb75a
-- 
2.44.0.rc0.258.g7320e95886-goog

