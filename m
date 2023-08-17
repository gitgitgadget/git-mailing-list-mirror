Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07477C52CDA
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 18:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354494AbjHQSiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 14:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354478AbjHQShf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 14:37:35 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A322D58
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:37:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d428d4956so1614817b3.0
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692297451; x=1692902251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=30GFFsNS6EBKl0PMTGbEt7dnRcOk8sPVtVZy0KxAnSY=;
        b=FId9TPKp4Fm9PtM2RpvknsftYdYfDSXbpa/kumnjyHcceRBw6av/o8F8x3qpasYhT7
         GtoUH4EbJIULC4EnUzt1ldPtdMIGQkZND3LlI5uNUtipsj3ygFIkQJIU+LhXiy9BBUtw
         TAMC1MSAu88lVtX4k4F4c/R+onUPoOD6eGiOohCw1CEATLRH1Akx8vSjUjcYnlsaXaWs
         yXC2Fn4Dk5FoqpZFRv9fiN0BB9nvbSdSZLV9E29cHU+vZeiUWTNfFA/V2pvXJ4TBDbPs
         6zb+tFKkMjNhQ13uDRUQmReZKoIqtHVC4fxuR5qu+xYSSjPrLDMIAuTIDzOcuMb3yb3U
         wUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297451; x=1692902251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30GFFsNS6EBKl0PMTGbEt7dnRcOk8sPVtVZy0KxAnSY=;
        b=ceJuZbxpA5z3YQCqyi66LhibCqzwWr6LqJLJeAeHEogtf+M6SPH9WVNxz7od2gVVze
         vjSz7Ao7Jm1nUCrijT07+0+L7+oblV8vmZagTCHmsKyaDb0Ewv/FLotD7u6lHNpknfNF
         ntM1j1+uNWLiYtg9WjZVJmmf+dX4qyKlkoEyuTUqzZqmGMkwpFUynZlVYwlx+E+Fevmf
         0G3JjWSTs0s1+pAC7pGjVJ203no3F/s9e6xV/TC5BrTp++whDp1Crb3DTOsKfJS6rxTn
         m2tvCgrkCQWYmNkd+CKmvJrqdmkeT0ee0P657udHftongjsW2oXRSWpJBWFEKNq6bcOu
         fZ6g==
X-Gm-Message-State: AOJu0YzkrtBdUAwjz5LXS5wQd8cI65xAcncP7Kq6jij04FG5FgIgThGt
        s0JzQDRCQE5Y38c9N2q/l4s6oFc/6ZKWN80u/YpZDFaazVkEJ3w8QD7aU2IuMpoFvsomfBhFYmL
        OLuO0HnPoIO5gaue9RKsRP0oE7Wp3XABva1FAlUlHjARIuKJ2PxRt0QNgUv6ZM1s=
X-Google-Smtp-Source: AGHT+IHSVVeAcIAxvwwL+mW+mAB5zM8sjb2dGsLCBqQksrpNixmlqOyC8qffA+qJ15sgmXnSwEFQSBoWc+esNg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:e60a:f80e:4b7a:6509])
 (user=steadmon job=sendgmr) by 2002:a05:690c:707:b0:58c:9fda:d043 with SMTP
 id bs7-20020a05690c070700b0058c9fdad043mr2629ywb.10.1692297451281; Thu, 17
 Aug 2023 11:37:31 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:37:22 -0700
In-Reply-To: <cover.1692297001.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692297001.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
Subject: [PATCH v7 2/3] unit tests: add TAP unit test framework
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This patch contains an implementation for writing unit tests with TAP
output. Each test is a function that contains one or more checks. The
test is run with the TEST() macro and if any of the checks fail then the
test will fail. A complete program that tests STRBUF_INIT would look
like

     #include "test-lib.h"
     #include "strbuf.h"

     static void t_static_init(void)
     {
             struct strbuf buf = STRBUF_INIT;

             check_uint(buf.len, ==, 0);
             check_uint(buf.alloc, ==, 0);
             if (check(buf.buf == strbuf_slopbuf))
		    return; /* avoid SIGSEV */
             check_char(buf.buf[0], ==, '\0');
     }

     int main(void)
     {
             TEST(t_static_init(), "static initialization works);

             return test_done();
     }

The output of this program would be

     ok 1 - static initialization works
     1..1

If any of the checks in a test fail then they print a diagnostic message
to aid debugging and the test will be reported as failing. For example a
failing integer check would look like

     # check "x >= 3" failed at my-test.c:102
     #    left: 2
     #   right: 3
     not ok 1 - x is greater than or equal to three

There are a number of check functions implemented so far. check() checks
a boolean condition, check_int(), check_uint() and check_char() take two
values to compare and a comparison operator. check_str() will check if
two strings are equal. Custom checks are simple to implement as shown in
the comments above test_assert() in test-lib.h.

Tests can be skipped with test_skip() which can be supplied with a
reason for skipping which it will print. Tests can print diagnostic
messages with test_msg().  Checks that are known to fail can be wrapped
in TEST_TODO().

There are a couple of example test programs included in this
patch. t-basic.c implements some self-tests and demonstrates the
diagnostic output for failing test. The output of this program is
checked by t0080-unit-test-output.sh. t-strbuf.c shows some example
unit tests for strbuf.c

The unit tests can be built with "make unit-tests" (this works but the
Makefile changes need some further work). Once they have been built they
can be run manually (e.g t/unit-tests/t-strbuf) or with prove.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                    |  24 ++-
 t/Makefile                  |  15 +-
 t/t0080-unit-test-output.sh |  58 +++++++
 t/unit-tests/.gitignore     |   2 +
 t/unit-tests/t-basic.c      |  95 +++++++++++
 t/unit-tests/t-strbuf.c     |  75 ++++++++
 t/unit-tests/test-lib.c     | 329 ++++++++++++++++++++++++++++++++++++
 t/unit-tests/test-lib.h     | 143 ++++++++++++++++
 8 files changed, 737 insertions(+), 4 deletions(-)
 create mode 100755 t/t0080-unit-test-output.sh
 create mode 100644 t/unit-tests/.gitignore
 create mode 100644 t/unit-tests/t-basic.c
 create mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/test-lib.c
 create mode 100644 t/unit-tests/test-lib.h

diff --git a/Makefile b/Makefile
index e440728c24..4016da6e39 100644
--- a/Makefile
+++ b/Makefile
@@ -682,6 +682,8 @@ TEST_BUILTINS_OBJS =
 TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
+UNIT_TEST_PROGRAMS =
+UNIT_TEST_DIR = t/unit-tests
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1331,6 +1333,12 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
+UNIT_TEST_PROGRAMS += t-basic
+UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_DIR)/%$X,$(UNIT_TEST_PROGRAMS))
+UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
+UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
+
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
@@ -2672,6 +2680,7 @@ OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+OBJECTS += $(UNIT_TEST_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3167,7 +3176,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3592,7 +3601,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(MOFILES)
+		$(UNIT_TEST_PROGS) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3653,7 +3662,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
-	$(RM) $(TEST_PROGRAMS)
+	$(RM) $(TEST_PROGRAMS) $(UNIT_TEST_PROGS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
@@ -3831,3 +3840,12 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+$(UNIT_TEST_PROGS): $(UNIT_TEST_DIR)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+
+.PHONY: build-unit-tests unit-tests
+build-unit-tests: $(UNIT_TEST_PROGS)
+unit-tests: $(UNIT_TEST_PROGS)
+	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index 3e00cdd801..2db8b3adb1 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,7 @@ TAR ?= $(TAR)
 RM ?= rm -f
 PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
+DEFAULT_UNIT_TEST_TARGET ?= unit-tests-raw
 TEST_LINT ?= test-lint
 
 ifdef TEST_OUTPUT_DIRECTORY
@@ -41,6 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
+UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/*)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
@@ -65,6 +67,17 @@ prove: pre-clean check-chainlint $(TEST_LINT)
 $(T):
 	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+$(UNIT_TESTS):
+	@echo "*** $@ ***"; $@
+
+.PHONY: unit-tests unit-tests-raw unit-tests-prove
+unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
+
+unit-tests-raw: $(UNIT_TESTS)
+
+unit-tests-prove:
+	@echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
@@ -149,4 +162,4 @@ perf:
 	$(MAKE) -C perf/ all
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
-	check-chainlint clean-chainlint test-chainlint
+	check-chainlint clean-chainlint test-chainlint $(UNIT_TESTS)
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
new file mode 100755
index 0000000000..e0fc07d1e5
--- /dev/null
+++ b/t/t0080-unit-test-output.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='Test the output of the unit test framework'
+
+. ./test-lib.sh
+
+test_expect_success 'TAP output from unit tests' '
+	cat >expect <<-EOF &&
+	ok 1 - passing test
+	ok 2 - passing test and assertion return 0
+	# check "1 == 2" failed at t/unit-tests/t-basic.c:76
+	#    left: 1
+	#   right: 2
+	not ok 3 - failing test
+	ok 4 - failing test and assertion return -1
+	not ok 5 - passing TEST_TODO() # TODO
+	ok 6 - passing TEST_TODO() returns 0
+	# todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/t-basic.c:25
+	not ok 7 - failing TEST_TODO()
+	ok 8 - failing TEST_TODO() returns -1
+	# check "0" failed at t/unit-tests/t-basic.c:30
+	# skipping test - missing prerequisite
+	# skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:32
+	ok 9 - test_skip() # SKIP
+	ok 10 - skipped test returns 0
+	# skipping test - missing prerequisite
+	ok 11 - test_skip() inside TEST_TODO() # SKIP
+	ok 12 - test_skip() inside TEST_TODO() returns 0
+	# check "0" failed at t/unit-tests/t-basic.c:48
+	not ok 13 - TEST_TODO() after failing check
+	ok 14 - TEST_TODO() after failing check returns -1
+	# check "0" failed at t/unit-tests/t-basic.c:56
+	not ok 15 - failing check after TEST_TODO()
+	ok 16 - failing check after TEST_TODO() returns -1
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/unit-tests/t-basic.c:61
+	#    left: "\011hello\\\\"
+	#   right: "there\"\012"
+	# check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-basic.c:62
+	#    left: "NULL"
+	#   right: NULL
+	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/unit-tests/t-basic.c:63
+	#    left: ${SQ}a${SQ}
+	#   right: ${SQ}\012${SQ}
+	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/unit-tests/t-basic.c:64
+	#    left: ${SQ}\\\\${SQ}
+	#   right: ${SQ}\\${SQ}${SQ}
+	not ok 17 - messages from failing string and char comparison
+	# BUG: test has no checks at t/unit-tests/t-basic.c:91
+	not ok 18 - test with no checks
+	ok 19 - test with no checks returns -1
+	1..19
+	EOF
+
+	! "$GIT_BUILD_DIR"/t/unit-tests/t-basic >actual &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
new file mode 100644
index 0000000000..e292d58348
--- /dev/null
+++ b/t/unit-tests/.gitignore
@@ -0,0 +1,2 @@
+/t-basic
+/t-strbuf
diff --git a/t/unit-tests/t-basic.c b/t/unit-tests/t-basic.c
new file mode 100644
index 0000000000..d20f444fab
--- /dev/null
+++ b/t/unit-tests/t-basic.c
@@ -0,0 +1,95 @@
+#include "test-lib.h"
+
+/*
+ * The purpose of this "unit test" is to verify a few invariants of the unit
+ * test framework itself, as well as to provide examples of output from actually
+ * failing tests. As such, it is intended that this test fails, and thus it
+ * should not be run as part of `make unit-tests`. Instead, we verify it behaves
+ * as expected in the integration test t0080-unit-test-output.sh
+ */
+
+/* Used to store the return value of check_int(). */
+static int check_res;
+
+/* Used to store the return value of TEST(). */
+static int test_res;
+
+static void t_res(int expect)
+{
+	check_int(check_res, ==, expect);
+	check_int(test_res, ==, expect);
+}
+
+static void t_todo(int x)
+{
+	check_res = TEST_TODO(check(x));
+}
+
+static void t_skip(void)
+{
+	check(0);
+	test_skip("missing prerequisite");
+	check(1);
+}
+
+static int do_skip(void)
+{
+	test_skip("missing prerequisite");
+	return 0;
+}
+
+static void t_skip_todo(void)
+{
+	check_res = TEST_TODO(do_skip());
+}
+
+static void t_todo_after_fail(void)
+{
+	check(0);
+	TEST_TODO(check(0));
+}
+
+static void t_fail_after_todo(void)
+{
+	check(1);
+	TEST_TODO(check(0));
+	check(0);
+}
+
+static void t_messages(void)
+{
+	check_str("\thello\\", "there\"\n");
+	check_str("NULL", NULL);
+	check_char('a', ==, '\n');
+	check_char('\\', ==, '\'');
+}
+
+static void t_empty(void)
+{
+	; /* empty */
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	test_res = TEST(check_res = check_int(1, ==, 1), "passing test");
+	TEST(t_res(0), "passing test and assertion return 0");
+	test_res = TEST(check_res = check_int(1, ==, 2), "failing test");
+	TEST(t_res(-1), "failing test and assertion return -1");
+	test_res = TEST(t_todo(0), "passing TEST_TODO()");
+	TEST(t_res(0), "passing TEST_TODO() returns 0");
+	test_res = TEST(t_todo(1), "failing TEST_TODO()");
+	TEST(t_res(-1), "failing TEST_TODO() returns -1");
+	test_res = TEST(t_skip(), "test_skip()");
+	TEST(check_int(test_res, ==, 0), "skipped test returns 0");
+	test_res = TEST(t_skip_todo(), "test_skip() inside TEST_TODO()");
+	TEST(t_res(0), "test_skip() inside TEST_TODO() returns 0");
+	test_res = TEST(t_todo_after_fail(), "TEST_TODO() after failing check");
+	TEST(check_int(test_res, ==, -1), "TEST_TODO() after failing check returns -1");
+	test_res = TEST(t_fail_after_todo(), "failing check after TEST_TODO()");
+	TEST(check_int(test_res, ==, -1), "failing check after TEST_TODO() returns -1");
+	TEST(t_messages(), "messages from failing string and char comparison");
+	test_res = TEST(t_empty(), "test with no checks");
+	TEST(check_int(test_res, ==, -1), "test with no checks returns -1");
+
+	return test_done();
+}
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
new file mode 100644
index 0000000000..561611e242
--- /dev/null
+++ b/t/unit-tests/t-strbuf.c
@@ -0,0 +1,75 @@
+#include "test-lib.h"
+#include "strbuf.h"
+
+/* wrapper that supplies tests with an initialized strbuf */
+static void setup(void (*f)(struct strbuf*, void*), void *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	f(&buf, data);
+	strbuf_release(&buf);
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, ==, 0);
+	check(buf.buf == strbuf_slopbuf);
+	check_char(buf.buf[0], ==, '\0');
+}
+
+static void t_static_init(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, ==, 0);
+	if (check(buf.buf == strbuf_slopbuf))
+		return; /* avoid de-referencing buf.buf */
+	check_char(buf.buf[0], ==, '\0');
+}
+
+static void t_dynamic_init(void)
+{
+	struct strbuf buf;
+
+	strbuf_init(&buf, 1024);
+	check_uint(buf.len, ==, 0);
+	check_uint(buf.alloc, >=, 1024);
+	check_char(buf.buf[0], ==, '\0');
+	strbuf_release(&buf);
+}
+
+static void t_addch(struct strbuf *buf, void *data)
+{
+	const char *p_ch = data;
+	const char ch = *p_ch;
+
+	strbuf_addch(buf, ch);
+	if (check_uint(buf->len, ==, 1) ||
+	    check_uint(buf->alloc, >, 1))
+		return; /* avoid de-referencing buf->buf */
+	check_char(buf->buf[0], ==, ch);
+	check_char(buf->buf[1], ==, '\0');
+}
+
+static void t_addstr(struct strbuf *buf, void *data)
+{
+	const char *text = data;
+	size_t len = strlen(text);
+
+	strbuf_addstr(buf, text);
+	if (check_uint(buf->len, ==, len) ||
+	    check_uint(buf->alloc, >, len) ||
+	    check_char(buf->buf[len], ==, '\0'))
+	    return;
+	check_str(buf->buf, text);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	if (TEST(t_static_init(), "static initialization works"))
+		test_skip_all("STRBUF_INIT is broken");
+	TEST(t_dynamic_init(), "dynamic initialization works");
+	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
+	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
+	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
+
+	return test_done();
+}
diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
new file mode 100644
index 0000000000..70030d587f
--- /dev/null
+++ b/t/unit-tests/test-lib.c
@@ -0,0 +1,329 @@
+#include "test-lib.h"
+
+enum result {
+	RESULT_NONE,
+	RESULT_FAILURE,
+	RESULT_SKIP,
+	RESULT_SUCCESS,
+	RESULT_TODO
+};
+
+static struct {
+	enum result result;
+	int count;
+	unsigned failed :1;
+	unsigned lazy_plan :1;
+	unsigned running :1;
+	unsigned skip_all :1;
+	unsigned todo :1;
+} ctx = {
+	.lazy_plan = 1,
+	.result = RESULT_NONE,
+};
+
+static void msg_with_prefix(const char *prefix, const char *format, va_list ap)
+{
+	fflush(stderr);
+	if (prefix)
+		fprintf(stdout, "%s", prefix);
+	vprintf(format, ap); /* TODO: handle newlines */
+	putc('\n', stdout);
+	fflush(stdout);
+}
+
+void test_msg(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	msg_with_prefix("# ", format, ap);
+	va_end(ap);
+}
+
+void test_plan(int count)
+{
+	assert(!ctx.running);
+
+	fflush(stderr);
+	printf("1..%d\n", count);
+	fflush(stdout);
+	ctx.lazy_plan = 0;
+}
+
+int test_done(void)
+{
+	assert(!ctx.running);
+
+	if (ctx.lazy_plan)
+		test_plan(ctx.count);
+
+	return ctx.failed;
+}
+
+void test_skip(const char *format, ...)
+{
+	va_list ap;
+
+	assert(ctx.running);
+
+	ctx.result = RESULT_SKIP;
+	va_start(ap, format);
+	if (format)
+		msg_with_prefix("# skipping test - ", format, ap);
+	va_end(ap);
+}
+
+void test_skip_all(const char *format, ...)
+{
+	va_list ap;
+	const char *prefix;
+
+	if (!ctx.count && ctx.lazy_plan) {
+		/* We have not printed a test plan yet */
+		prefix = "1..0 # SKIP ";
+		ctx.lazy_plan = 0;
+	} else {
+		/* We have already printed a test plan */
+		prefix = "Bail out! # ";
+		ctx.failed = 1;
+	}
+	ctx.skip_all = 1;
+	ctx.result = RESULT_SKIP;
+	va_start(ap, format);
+	msg_with_prefix(prefix, format, ap);
+	va_end(ap);
+}
+
+int test__run_begin(void)
+{
+	assert(!ctx.running);
+
+	ctx.count++;
+	ctx.result = RESULT_NONE;
+	ctx.running = 1;
+
+	return ctx.skip_all;
+}
+
+static void print_description(const char *format, va_list ap)
+{
+	if (format) {
+		fputs(" - ", stdout);
+		vprintf(format, ap);
+	}
+}
+
+int test__run_end(int was_run UNUSED, const char *location, const char *format, ...)
+{
+	va_list ap;
+
+	assert(ctx.running);
+	assert(!ctx.todo);
+
+	fflush(stderr);
+	va_start(ap, format);
+	if (!ctx.skip_all) {
+		switch (ctx.result) {
+		case RESULT_SUCCESS:
+			printf("ok %d", ctx.count);
+			print_description(format, ap);
+			break;
+
+		case RESULT_FAILURE:
+			printf("not ok %d", ctx.count);
+			print_description(format, ap);
+			break;
+
+		case RESULT_TODO:
+			printf("not ok %d", ctx.count);
+			print_description(format, ap);
+			printf(" # TODO");
+			break;
+
+		case RESULT_SKIP:
+			printf("ok %d", ctx.count);
+			print_description(format, ap);
+			printf(" # SKIP");
+			break;
+
+		case RESULT_NONE:
+			test_msg("BUG: test has no checks at %s", location);
+			printf("not ok %d", ctx.count);
+			print_description(format, ap);
+			ctx.result = RESULT_FAILURE;
+			break;
+		}
+	}
+	va_end(ap);
+	ctx.running = 0;
+	if (ctx.skip_all)
+		return 0;
+	putc('\n', stdout);
+	fflush(stdout);
+	ctx.failed |= ctx.result == RESULT_FAILURE;
+
+	return -(ctx.result == RESULT_FAILURE);
+}
+
+static void test_fail(void)
+{
+	assert(ctx.result != RESULT_SKIP);
+
+	ctx.result = RESULT_FAILURE;
+}
+
+static void test_pass(void)
+{
+	assert(ctx.result != RESULT_SKIP);
+
+	if (ctx.result == RESULT_NONE)
+		ctx.result = RESULT_SUCCESS;
+}
+
+static void test_todo(void)
+{
+	assert(ctx.result != RESULT_SKIP);
+
+	if (ctx.result != RESULT_FAILURE)
+		ctx.result = RESULT_TODO;
+}
+
+int test_assert(const char *location, const char *check, int ok)
+{
+	assert(ctx.running);
+
+	if (ctx.result == RESULT_SKIP) {
+		test_msg("skipping check '%s' at %s", check, location);
+		return 0;
+	} else if (!ctx.todo) {
+		if (ok) {
+			test_pass();
+		} else {
+			test_msg("check \"%s\" failed at %s", check, location);
+			test_fail();
+		}
+	}
+
+	return -!ok;
+}
+
+void test__todo_begin(void)
+{
+	assert(ctx.running);
+	assert(!ctx.todo);
+
+	ctx.todo = 1;
+}
+
+int test__todo_end(const char *location, const char *check, int res)
+{
+	assert(ctx.running);
+	assert(ctx.todo);
+
+	ctx.todo = 0;
+	if (ctx.result == RESULT_SKIP)
+		return 0;
+	if (!res) {
+		test_msg("todo check '%s' succeeded at %s", check, location);
+		test_fail();
+	} else {
+		test_todo();
+	}
+
+	return -!res;
+}
+
+int check_bool_loc(const char *loc, const char *check, int ok)
+{
+	return test_assert(loc, check, ok);
+}
+
+union test__tmp test__tmp[2];
+
+int check_int_loc(const char *loc, const char *check, int ok,
+		  intmax_t a, intmax_t b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (ret) {
+		test_msg("   left: %"PRIdMAX, a);
+		test_msg("  right: %"PRIdMAX, b);
+	}
+
+	return ret;
+}
+
+int check_uint_loc(const char *loc, const char *check, int ok,
+		   uintmax_t a, uintmax_t b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (ret) {
+		test_msg("   left: %"PRIuMAX, a);
+		test_msg("  right: %"PRIuMAX, b);
+	}
+
+	return ret;
+}
+
+static void print_one_char(char ch, char quote)
+{
+	if ((unsigned char)ch < 0x20u || ch == 0x7f) {
+		/* TODO: improve handling of \a, \b, \f ... */
+		printf("\\%03o", (unsigned char)ch);
+	} else {
+		if (ch == '\\' || ch == quote)
+			putc('\\', stdout);
+		putc(ch, stdout);
+	}
+}
+
+static void print_char(const char *prefix, char ch)
+{
+	printf("# %s: '", prefix);
+	print_one_char(ch, '\'');
+	fputs("'\n", stdout);
+}
+
+int check_char_loc(const char *loc, const char *check, int ok, char a, char b)
+{
+	int ret = test_assert(loc, check, ok);
+
+	if (ret) {
+		fflush(stderr);
+		print_char("   left", a);
+		print_char("  right", b);
+		fflush(stdout);
+	}
+
+	return ret;
+}
+
+static void print_str(const char *prefix, const char *str)
+{
+	printf("# %s: ", prefix);
+	if (!str) {
+		fputs("NULL\n", stdout);
+	} else {
+		putc('"', stdout);
+		while (*str)
+			print_one_char(*str++, '"');
+		fputs("\"\n", stdout);
+	}
+}
+
+int check_str_loc(const char *loc, const char *check,
+		  const char *a, const char *b)
+{
+	int ok = (!a && !b) || (a && b && !strcmp(a, b));
+	int ret = test_assert(loc, check, ok);
+
+	if (ret) {
+		fflush(stderr);
+		print_str("   left", a);
+		print_str("  right", b);
+		fflush(stdout);
+	}
+
+	return ret;
+}
diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
new file mode 100644
index 0000000000..720c97c6f8
--- /dev/null
+++ b/t/unit-tests/test-lib.h
@@ -0,0 +1,143 @@
+#ifndef TEST_LIB_H
+#define TEST_LIB_H
+
+#include "git-compat-util.h"
+
+/*
+ * Run a test function, returns 0 if the test succeeds, -1 if it
+ * fails. If test_skip_all() has been called then the test will not be
+ * run. The description for each test should be unique. For example:
+ *
+ *  TEST(test_something(arg1, arg2), "something %d %d", arg1, arg2)
+ */
+#define TEST(t, ...)					\
+	test__run_end(test__run_begin() ? 0 : (t, 1),	\
+		      TEST_LOCATION(),  __VA_ARGS__)
+
+/*
+ * Print a test plan, should be called before any tests. If the number
+ * of tests is not known in advance test_done() will automatically
+ * print a plan at the end of the test program.
+ */
+void test_plan(int count);
+
+/*
+ * test_done() must be called at the end of main(). It will print the
+ * plan if plan() was not called at the beginning of the test program
+ * and returns the exit code for the test program.
+ */
+int test_done(void);
+
+/* Skip the current test. */
+__attribute__((format (printf, 1, 2)))
+void test_skip(const char *format, ...);
+
+/* Skip all remaining tests. */
+__attribute__((format (printf, 1, 2)))
+void test_skip_all(const char *format, ...);
+
+/* Print a diagnostic message to stdout. */
+__attribute__((format (printf, 1, 2)))
+void test_msg(const char *format, ...);
+
+/*
+ * Test checks are built around test_assert(). checks return 0 on
+ * success, -1 on failure. If any check fails then the test will
+ * fail. To create a custom check define a function that wraps
+ * test_assert() and a macro to wrap that function. For example:
+ *
+ *  static int check_oid_loc(const char *loc, const char *check,
+ *			     struct object_id *a, struct object_id *b)
+ *  {
+ *	    int res = test_assert(loc, check, oideq(a, b));
+ *
+ *	    if (res) {
+ *		    test_msg("   left: %s", oid_to_hex(a);
+ *		    test_msg("  right: %s", oid_to_hex(a);
+ *
+ *	    }
+ *	    return res;
+ *  }
+ *
+ *  #define check_oid(a, b) \
+ *	    check_oid_loc(TEST_LOCATION(), "oideq("#a", "#b")", a, b)
+ */
+int test_assert(const char *location, const char *check, int ok);
+
+/* Helper macro to pass the location to checks */
+#define TEST_LOCATION() TEST__MAKE_LOCATION(__LINE__)
+
+/* Check a boolean condition. */
+#define check(x)				\
+	check_bool_loc(TEST_LOCATION(), #x, x)
+int check_bool_loc(const char *loc, const char *check, int ok);
+
+/*
+ * Compare two integers. Prints a message with the two values if the
+ * comparison fails. NB this is not thread safe.
+ */
+#define check_int(a, op, b)						\
+	(test__tmp[0].i = (a), test__tmp[1].i = (b),			\
+	 check_int_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+		       test__tmp[0].i op test__tmp[1].i, a, b))
+int check_int_loc(const char *loc, const char *check, int ok,
+		  intmax_t a, intmax_t b);
+
+/*
+ * Compare two unsigned integers. Prints a message with the two values
+ * if the comparison fails. NB this is not thread safe.
+ */
+#define check_uint(a, op, b)						\
+	(test__tmp[0].u = (a), test__tmp[1].u = (b),			\
+	 check_uint_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+			test__tmp[0].u op test__tmp[1].u, a, b))
+int check_uint_loc(const char *loc, const char *check, int ok,
+		   uintmax_t a, uintmax_t b);
+
+/*
+ * Compare two chars. Prints a message with the two values if the
+ * comparison fails. NB this is not thread safe.
+ */
+#define check_char(a, op, b)						\
+	(test__tmp[0].c = (a), test__tmp[1].c = (b),			\
+	 check_char_loc(TEST_LOCATION(), #a" "#op" "#b,			\
+			test__tmp[0].c op test__tmp[1].c, a, b))
+int check_char_loc(const char *loc, const char *check, int ok,
+		   char a, char b);
+
+/* Check whether two strings are equal. */
+#define check_str(a, b)							\
+	check_str_loc(TEST_LOCATION(), "!strcmp("#a", "#b")", a, b)
+int check_str_loc(const char *loc, const char *check,
+		  const char *a, const char *b);
+
+/*
+ * Wrap a check that is known to fail. If the check succeeds then the
+ * test will fail. Returns 0 if the check fails, -1 if it
+ * succeeds. For example:
+ *
+ *  TEST_TODO(check(0));
+ */
+#define TEST_TODO(check) \
+	(test__todo_begin(), test__todo_end(TEST_LOCATION(), #check, check))
+
+/* Private helpers */
+
+#define TEST__STR(x) #x
+#define TEST__MAKE_LOCATION(line) __FILE__ ":" TEST__STR(line)
+
+union test__tmp {
+	intmax_t i;
+	uintmax_t u;
+	char c;
+};
+
+extern union test__tmp test__tmp[2];
+
+int test__run_begin(void);
+__attribute__((format (printf, 3, 4)))
+int test__run_end(int, const char *, const char *, ...);
+void test__todo_begin(void);
+int test__todo_end(const char *, const char *, int);
+
+#endif /* TEST_LIB_H */
-- 
2.42.0.rc1.204.g551eb34607-goog

