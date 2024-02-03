Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B564B
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921436; cv=none; b=es4ZHbXGx5U4si6vrnKU/PoPnuBsl8WyOygIU/lkGGptATEOHEhd1yarrtzbadFz5IhbQzFSdYepL9TWlQYMPKIfp3X4TRxljqbXUEbCrGiBlWKKHM9LxyuLVo1hsUeWFioAuzlPUvFxi1Oa1DqllBeplHqOQISYtW3tLW9HTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921436; c=relaxed/simple;
	bh=48LxXsl6fFzsqF8AnY6HPfSJRcBux2WrZMlZK6dGC8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYfhL29XfOi/Rz+FuUO03HpY2dD7mBtTvqywvP8oGrOnI7NreGiAUzSMfgt54rU154EulW2Ntk4frlwkn2aQX2Jc07ptVyfCet0U03j1IFScU0kBRo4oHXtRA3BZlNLITx7sBBblo7gc7WK/a9gmIQIkYFc92s2qtuN5BOo5uv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAy0okCG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAy0okCG"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6c47cf679so4724357276.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 16:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706921434; x=1707526234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxp6XD/y3/MFkmGZAkFxIwu7AEIL/K+WrB4PQxk8EqA=;
        b=oAy0okCG/eZue/f00ugR/RkegJgw9YjclyuqN45F2OgdMUPBSjhr7AYmDI/Rv+zZ8/
         +aAIwISwH8UDbmvyyEWJbDCGmVY2SRx14CPlMUtNhr+j9yFr8cQWKwCsFuOKErnwBCob
         mRcpf2GkIsiLbC0rMztq2UdEVDN58UGR7YM0BzWKpTqYdCw7fnWqAHj2XEsoR1iq7atA
         IZWeMHjO92s+kqivi1tGHMnQYmT7QRgWL/LvnKBHR6R0JTOWDBZzJnlPhC/Cm4JkBDi2
         t8R8/+fEpVCQFTok9X5rU35Xx/aeBaXXqEWCRdFcJCS+UA9ExHbAy2mskRHcw0Xah5nv
         HSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706921434; x=1707526234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sxp6XD/y3/MFkmGZAkFxIwu7AEIL/K+WrB4PQxk8EqA=;
        b=ZjVIPqzzIs9yWJUNKziI7GUf/BQLrusRINOo7Q1sTqrTOf2YT/t07JrIRnErdpSsQo
         p0q6V/00eO1fZD5s4zIZhXJHUKfDizgYWSaSbv0jKWa8Qx+sU2lBDivyW4wCfj5rsINX
         g+c0UXjTQHedr63cR9op1E0EgDjham6s6EPJQ/aVS82clAI1hR9zLCHGqd4sxZ1bTquX
         1940iDoMxLH8PnZ/lm7PdEAv7Mp1pSTaWIVKJD3wY6rhDVhoovMTKbRGAxaYYa9LR1v5
         rzT1TliaiBDtODoaAqzX8MRl9WL+5ug/SgjPzRIp+VxCJJfEnTxrFs9U9qVE2rhf20tE
         bYqg==
X-Gm-Message-State: AOJu0YwOS9/zKcar/EpYyz3m0jwrOcu5uchwoJllzJop5t6HvNOFLESH
	naIPHXEnrYtKS1HAfcEjq06nr5mQIoCpf4kTrsTx2LNEhVXUwvN+AeFhQG8shVrPxrwk/ZPJMc8
	LAi0U4vl+2bPzleblGCQAtiGah6elw95jr4nJk7MBwP37WLpukRcy/V23NEJ3CVDKoKUTCLcb+t
	yxLGGoRqb2hgaETBPmcSp/jnxvQds2bYTnt8pRxSI=
X-Google-Smtp-Source: AGHT+IEmiLfVc2Oy6XcARIkO2nHszTFLpG6KbuV7eWkI1zDIe/nZQZs/IWhfPzcpP8DXX/kuetnb/XUYO0gyHw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:705c:77af:6ef2:8f42])
 (user=steadmon job=sendgmr) by 2002:a05:6902:260d:b0:dc6:e1ed:bd1a with SMTP
 id dw13-20020a056902260d00b00dc6e1edbd1amr1019676ybb.2.1706921433858; Fri, 02
 Feb 2024 16:50:33 -0800 (PST)
Date: Fri,  2 Feb 2024 16:50:25 -0800
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <cover.1706921262.git.steadmon@google.com>
Subject: [RFC PATCH v2 0/6] test-tool: add unit test suite runner
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Please note: this series has been rebased onto jk/unit-tests-buildfix.

For various reasons (see discussion at [1]) we would like an alternative
to `prove` for running test suites (including the unit tests) on
Windows.

This series extends the existing `test-tool run-command testsuite` to
support running unit tests. In addition, it includes some small
cleanups:
* move t-basic out of the unit-tests directory
* don't hardcode the shell for running tests in `test-tool ... testsuite`
* don't hardcode a test name filter in `test-tool ... testsuite`
* add a test wrapper script to allow unit tests and the shell test suite
  to run in a single `prove` process

Some known remaining bits of work:
* We should investigate switching the Windows CI to use `test-tool`
  instead of prove. However, Windows CI seems broken on
  jk/unit-tests-buildfix, and I haven't had time to determine why.
* We should determine whether it is confusing or otherwise harmful to
  people's workflow to have the unit tests run in parallel with shell
  tests when using prove as the default test target.

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/

Changes in V2:
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

Josh Steadmon (5):
  t0080: turn t-basic unit test into a helper
  test-tool run-command testsuite: get shell from env
  test-tool run-command testsuite: remove hardcoded filter
  test-tool run-command testsuite: support unit tests
  unit tests: add rule for running with test-tool

 Makefile                                      |  6 ++--
 t/Makefile                                    | 15 +++++++---
 .../t-basic.c => helper/test-example-tap.c}   |  5 ++--
 t/helper/test-run-command.c                   | 29 +++++++++++++++----
 t/helper/test-tool.c                          |  1 +
 t/helper/test-tool.h                          |  1 +
 t/run-test.sh                                 | 13 +++++++++
 t/t0080-unit-test-output.sh                   | 24 +++++++--------
 8 files changed, 67 insertions(+), 27 deletions(-)
 rename t/{unit-tests/t-basic.c => helper/test-example-tap.c} (95%)
 create mode 100755 t/run-test.sh

Range-diff against v1:
1:  a9f67ed703 < -:  ---------- t0080: turn t-basic unit test into a helper
-:  ---------- > 1:  da756b4bfb t0080: turn t-basic unit test into a helper
-:  ---------- > 2:  c8448406d7 test-tool run-command testsuite: get shell from env
-:  ---------- > 3:  e1b89ae93e test-tool run-command testsuite: remove hardcoded filter
2:  5ecbc976e6 ! 4:  b5665386b5 test-tool run-command testsuite: support unit tests
    @@ Commit message
         test-tool run-command testsuite: support unit tests
     
         Teach the testsuite runner in `test-tool run-command testsuite` how to
    -    run unit tests, by adding two new flags:
    +    run unit tests: if TEST_SHELL_PATH is not set, assume that we're running
    +    the programs directly from CWD, rather than defaulting to "sh" as an
    +    interpreter.
     
    -    First, "--(no-)run-in-shell" allows the test-tool to exec the unit-test
    -    binaries directly, rather than trying to interpret them as shell
    -    scripts.
    -
    -    Second "--(no-)require-shell-test-pattern" bypasses the check that the
    -    test filenames match the expected t####-*.sh pattern.
    -
    -    With these changes, you can now use test-tool to run the unit tests:
    +    With this change, you can now use test-tool to run the unit tests:
         $ make
         $ cd t/unit-tests/bin
    -    $ ../../helper/test-tool run-command testsuite --no-run-in-shell \
    -        --no-require-shell-test-pattern
    +    $ ../../helper/test-tool run-command testsuite
     
         This should be helpful on Windows to allow running tests without
         requiring Perl (for `prove`), as discussed in [1] and [2].
     
    +    This again breaks backwards compatibility, as it is now required to set
    +    TEST_SHELL_PATH properly for executing shell scripts, but again, as
    +    noted in [2], there are no longer any such invocations in our codebase.
    +
         [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109091323150.59@tvgsbejvaqbjf.bet/
         [2] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/
     
     
      ## t/helper/test-run-command.c ##
    -@@ t/helper/test-run-command.c: static int task_finished(int result UNUSED,
    - struct testsuite {
    - 	struct string_list tests, failed;
    - 	int next;
    --	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml;
    -+	int quiet, immediate, verbose, verbose_log, trace, write_junit_xml, run_in_shell;
    - };
    - #define TESTSUITE_INIT { \
    - 	.tests = STRING_LIST_INIT_DUP, \
    - 	.failed = STRING_LIST_INIT_DUP, \
    -+	.run_in_shell = 1, \
    - }
    - 
    - static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
    -@@ t/helper/test-run-command.c: static int next_test(struct child_process *cp, struct strbuf *err, void *cb,
    - 		return 0;
    - 
    - 	test = suite->tests.items[suite->next++].string;
    --	strvec_pushl(&cp->args, "sh", test, NULL);
    -+	if (suite->run_in_shell)
    -+		strvec_push(&cp->args, "sh");
    -+	strvec_push(&cp->args, test);
    - 	if (suite->quiet)
    - 		strvec_push(&cp->args, "--quiet");
    - 	if (suite->immediate)
    -@@ t/helper/test-run-command.c: static const char * const testsuite_usage[] = {
    - static int testsuite(int argc, const char **argv)
    - {
    - 	struct testsuite suite = TESTSUITE_INIT;
    --	int max_jobs = 1, i, ret = 0;
    -+	int max_jobs = 1, i, ret = 0, require_shell_test_pattern = 1;
    - 	DIR *dir;
    - 	struct dirent *d;
    - 	struct option options[] = {
    -@@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
    - 		OPT_BOOL('x', "trace", &suite.trace, "trace shell commands"),
    - 		OPT_BOOL(0, "write-junit-xml", &suite.write_junit_xml,
    - 			 "write JUnit-style XML files"),
    -+		OPT_BOOL(0, "run-in-shell", &suite.run_in_shell,
    -+			 "run programs in the suite via `sh`"),
    -+		OPT_BOOL(0, "require-shell-test-pattern", &require_shell_test_pattern,
    -+			 "require programs to match 't####-*.sh'"),
    - 		OPT_END()
    - 	};
    - 	struct run_process_parallel_opts opts = {
     @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      		.task_finished = test_finished,
      		.data = &suite,
    @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      
      	argc = parse_options(argc, argv, NULL, options,
      			testsuite_usage, PARSE_OPT_STOP_AT_NON_OPTION);
    - 
    +@@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      	if (max_jobs <= 0)
      		max_jobs = online_cpus();
    + 
     +	/*
     +	 * If we run without a shell, we have to provide the relative path to
     +	 * the executables.
     +	 */
    -+	if (!suite.run_in_shell)
    + 	suite.shell_path = getenv("TEST_SHELL_PATH");
    + 	if (!suite.shell_path)
    +-		suite.shell_path = "sh";
     +		strbuf_addstr(&progpath, "./");
     +	path_prefix_len = progpath.len;
      
      	dir = opendir(".");
      	if (!dir)
     @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
    - 	while ((d = readdir(dir))) {
    - 		const char *p = d->d_name;
    - 
    --		if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
    --		    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
    --		    !ends_with(p, ".sh"))
    -+		if (!strcmp(p, ".") || !strcmp(p, ".."))
    - 			continue;
    -+		if (require_shell_test_pattern)
    -+			if (*p != 't' || !isdigit(p[1]) || !isdigit(p[2]) ||
    -+			    !isdigit(p[3]) || !isdigit(p[4]) || p[5] != '-' ||
    -+			    !ends_with(p, ".sh"))
    -+				continue;
      
      		/* No pattern: match all */
      		if (!argc) {
3:  5b34c851cd ! 5:  f2746703d5 unit tests: add rule for running with test-tool
    @@ Commit message
         `make DEFAULT_UNIT_TEST_TARGET=unit-tests-test-tool unit-tests`, or by
         setting DEFAULT_UNIT_TEST_TARGET in config.mak.
     
    -    NEEDS WORK: we need to exclude .pdb files generated by cmake [see
    -    0df903d402 (unit-tests: do not mistake `.pdb` files for being
    -    executable, 2023-09-25)]
    -
     
      ## Makefile ##
    -@@ Makefile: $(UNIT_TEST_HELPER_PROGS): %$X: %.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-L
    +@@ Makefile: $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/
      
      .PHONY: build-unit-tests unit-tests
      build-unit-tests: $(UNIT_TEST_PROGS)
    @@ Makefile: $(UNIT_TEST_HELPER_PROGS): %$X: %.o $(UNIT_TEST_DIR)/test-lib.o $(GITL
      	$(MAKE) -C t/ unit-tests
     
      ## t/Makefile ##
    +@@ t/Makefile: CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.tes
    + CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
    + UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
    + UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
    ++UNIT_TESTS_NO_DIR = $(notdir $(UNIT_TESTS))
    + 
    + # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
    + # checks all tests in all scripts via a single invocation, so tell individual
     @@ t/Makefile: $(T):
      $(UNIT_TESTS):
      	@echo "*** $@ ***"; $@
    @@ t/Makefile: unit-tests-raw: $(UNIT_TESTS)
     +	@echo "*** test-tool - unit tests **"
     +	( \
     +		cd unit-tests/bin && \
    -+		../../helper/test-tool run-command testsuite --no-run-in-shell --no-require-shell-test-pattern \
    ++		../../helper/test-tool$X run-command testsuite $(UNIT_TESTS_NO_DIR)\
     +	)
     +
      pre-clean:
4:  c823265f0d = 6:  cd7467a7bd t/Makefile: run unit tests alongside shell tests

base-commit: 799d449105dc1f6e77fa1ebaea4f6d8bdc6537cf
-- 
2.43.0.594.gd9cf4e227d-goog

