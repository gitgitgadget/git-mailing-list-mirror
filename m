Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38722EE0
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443788; cv=none; b=lPRWVwQ0C8jpQ11bNAdKdZlV+e3PxEaZ4OXzsYo+BBoLq+iGROmGU2y029N9wTLAQB8nJwYIWHu7n7qVII29xzb+1EP3n42oX1xsj3oqoS4KdGAy2xO0etjixVNo88p8z6aYjHm/P5PZkfAORfdmHFS0aCyZgIwJrgRDQojdtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443788; c=relaxed/simple;
	bh=27l2Io+fixo/iyGSiuLQrirp4jmwxFL42Ozd6fEuDYg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:
	 From:To:Cc:Content-Type; b=IOvfJH2Lt8tlCntUTudI5xWOr+DboFCDqRadJBZq/6bhLAbFcz2rq+IrqWmifD1E8cFge8bKjaX+fRHlueEUFeZW2pqKgmPLWsWGJrIl5qksAyhNzicdNxZV+zM5a/FjE6iv6yQ77NviWkbKw4UtXNnN866xuxPxKXevYUX9UZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDPVHhGs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDPVHhGs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc21b7f41a1so2438072276.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705443785; x=1706048585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmkei7/0IMFagRCnsZIHWMQtMG2qsItZWOddcmJGBU8=;
        b=pDPVHhGsnpnn2vMVtjwnFwyffT6p2FC1yh5tuzqpmrpbC5/wOHBeL/hK2UHojETlfK
         Vq1TrOoHhQqHFYHN4y1VhNdE1iZ1piK8+GTMGDaPBBYZNOLDpibEz/QAnSFJgBIPzuPd
         x9+1Za2Ql5UiqLJ1r9QN2MyHYJqvbNXg3RV4Nz3csn2kVURHAlQhprRkBIQoTVA/IcOo
         IVcf8XxNnpRYQkUVUb8b08rHtXwHmQdSKNWLEeUzkwWYy2a3Dlw90Z7HtXr155oGVX6J
         TBrYVaebwLoNajI6tk3Ygeb5JLpuZW84Ry86uUMzUAilXtErkiFdyTeXFC9cyPZ+4Gp3
         F2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443785; x=1706048585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mmkei7/0IMFagRCnsZIHWMQtMG2qsItZWOddcmJGBU8=;
        b=SInkv6/b7uMXw7LXWQ8HyjbsHXB+kURGQJDbSSspxYmFChUA9wkP5PE47YOcsPn6zN
         ThQrJ9c8unQz8ttVGWb4p6LcFSWFM7wKGPm1acz6Nln+AeOwlb45NB72b4DP2rl8k6Z5
         wqO6dhYKBNTz251lJ4qChjP6NfI55/mAKGTOeyzSoO0ldP1DX9p8NzEd91DE9LLt5DwC
         ypQG1PmVj8lYSHTtbdo9JJnFN2tS6N2WAELr2VGqHA4r5y25lJu7PkxLtzT7noJtBVqD
         OKrSEpTpJ4FO7oocsK2ZSMz5xYJDPVj3o/vFoWM8vF+zhtWrw80TUriy2soT5qKOX2Zj
         d01Q==
X-Gm-Message-State: AOJu0Yy3UjCBPf8xlgVCLM1Bx9fsmJp+YNj2S2pjXqmjG8ivUhKu1eGG
	EBYe/5E9obU+MW90BJ1BbwD12XBPKJfWCRPXI3OE/erUZIcn0YzfICcC/4dcTSh5jfYEH4fyvBj
	DSg+ISrehtdMdrZy6HWNS6ZNFNvtOQuuDPh8q3ThZv4V1+npsbNNjdKfq/jepjamFbIfzNA==
X-Google-Smtp-Source: AGHT+IFniQbiXAXOafgPy09RpVOf9NBN3ppOfAErW67FhQ5kwX0ZTzW2z7S6wYwgPtm5wJNBB1du3rZp2oquWQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:a6f6:5624:1895:86a4])
 (user=steadmon job=sendgmr) by 2002:a25:aad1:0:b0:dc2:3247:89d5 with SMTP id
 t75-20020a25aad1000000b00dc2324789d5mr62891ybi.4.1705443785523; Tue, 16 Jan
 2024 14:23:05 -0800 (PST)
Date: Tue, 16 Jan 2024 14:22:58 -0800
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <a9f67ed703c8314f0f0507ffb83b503717b846b3.1705443632.git.steadmon@google.com>
Subject: [RFC PATCH 1/4] t0080: turn t-basic unit test into a helper
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

While t/unit-tests/t-basic.c uses the unit-test framework added in
e137fe3b29 (unit tests: add TAP unit test framework, 2023-11-09), it is
not a true unit test in that it intentionally fails in order to exercise
various codepaths in the unit-test framework. Thus, we intentionally
exclude it when running unit tests through the various t/Makefile
targets. Instead, it is executed by t0080-unit-test-output.sh, which
verifies its output follows the TAP format expected for the various
pass, skip, or fail cases.

As such, it makes more sense for t-basic to be a helper item for
t0080-unit-test-output.sh, so let's move it to t/t0080/t-basic.c and
adjust Makefiles and .gitignores as necessary.

This has the additional benefit that test harnesses seeking to run all
unit tests can find them with a simple glob of "t/unit-tests/bin/t-*",
with no exceptions needed. This will be important in a later patch where
we add support for running the unit tests via a test-tool subcommand.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                          | 17 +++++++++++++----
 t/Makefile                        |  2 +-
 t/t0080-unit-test-output.sh       | 24 ++++++++++++------------
 t/t0080/.gitignore                |  1 +
 t/{unit-tests => t0080}/t-basic.c |  2 +-
 5 files changed, 28 insertions(+), 18 deletions(-)
 create mode 100644 t/t0080/.gitignore
 rename t/{unit-tests => t0080}/t-basic.c (98%)

diff --git a/Makefile b/Makefile
index 88ba7a3c51..ab32ec1101 100644
--- a/Makefile
+++ b/Makefile
@@ -683,6 +683,7 @@ TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 UNIT_TEST_PROGRAMS =
+UNIT_TEST_HELPERS =
 UNIT_TEST_DIR = t/unit-tests
 UNIT_TEST_BIN = $(UNIT_TEST_DIR)/bin
 
@@ -1339,10 +1340,12 @@ THIRD_PARTY_SOURCES += compat/regex/%
 THIRD_PARTY_SOURCES += sha1collisiondetection/%
 THIRD_PARTY_SOURCES += sha1dc/%
 
-UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
+UNIT_TEST_HELPERS += t/t0080/t-basic
+UNIT_TEST_HELPER_PROGS = $(patsubst %,%$X,$(UNIT_TEST_HELPERS))
 UNIT_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
+UNIT_TEST_OBJS += $(patsubst %,%.o,$(UNIT_TEST_HELPERS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
@@ -3189,7 +3192,9 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs)
+
+all:: $(UNIT_TEST_PROGS) $(UNIT_TEST_HELPER_PROGS)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3620,7 +3625,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(UNIT_TEST_HELPER_PROGS) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3682,7 +3687,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) headless-git.o
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
-	$(RM) $(TEST_PROGRAMS) $(UNIT_TEST_PROGS)
+	$(RM) $(TEST_PROGRAMS) $(UNIT_TEST_PROGS) $(UNIT_TEST_HELPER_PROGS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
@@ -3869,6 +3874,10 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
+$(UNIT_TEST_HELPER_PROGS): %$X: %.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+
 .PHONY: build-unit-tests unit-tests
 build-unit-tests: $(UNIT_TEST_PROGS)
 unit-tests: $(UNIT_TEST_PROGS)
diff --git a/t/Makefile b/t/Makefile
index b7a6fefe28..0bee7bc6ea 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -42,7 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
+UNIT_TESTS = $(sort $(filter-out %.pdb,$(wildcard unit-tests/bin/t-*)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-output.sh
index 961b54b06c..7431023d97 100755
--- a/t/t0080-unit-test-output.sh
+++ b/t/t0080-unit-test-output.sh
@@ -8,50 +8,50 @@ test_expect_success 'TAP output from unit tests' '
 	cat >expect <<-EOF &&
 	ok 1 - passing test
 	ok 2 - passing test and assertion return 1
-	# check "1 == 2" failed at t/unit-tests/t-basic.c:76
+	# check "1 == 2" failed at t/t0080/t-basic.c:76
 	#    left: 1
 	#   right: 2
 	not ok 3 - failing test
 	ok 4 - failing test and assertion return 0
 	not ok 5 - passing TEST_TODO() # TODO
 	ok 6 - passing TEST_TODO() returns 1
-	# todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/t-basic.c:25
+	# todo check ${SQ}check(x)${SQ} succeeded at t/t0080/t-basic.c:25
 	not ok 7 - failing TEST_TODO()
 	ok 8 - failing TEST_TODO() returns 0
-	# check "0" failed at t/unit-tests/t-basic.c:30
+	# check "0" failed at t/t0080/t-basic.c:30
 	# skipping test - missing prerequisite
-	# skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:32
+	# skipping check ${SQ}1${SQ} at t/t0080/t-basic.c:32
 	ok 9 - test_skip() # SKIP
 	ok 10 - skipped test returns 1
 	# skipping test - missing prerequisite
 	ok 11 - test_skip() inside TEST_TODO() # SKIP
 	ok 12 - test_skip() inside TEST_TODO() returns 1
-	# check "0" failed at t/unit-tests/t-basic.c:48
+	# check "0" failed at t/t0080/t-basic.c:48
 	not ok 13 - TEST_TODO() after failing check
 	ok 14 - TEST_TODO() after failing check returns 0
-	# check "0" failed at t/unit-tests/t-basic.c:56
+	# check "0" failed at t/t0080/t-basic.c:56
 	not ok 15 - failing check after TEST_TODO()
 	ok 16 - failing check after TEST_TODO() returns 0
-	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/unit-tests/t-basic.c:61
+	# check "!strcmp("\thello\\\\", "there\"\n")" failed at t/t0080/t-basic.c:61
 	#    left: "\011hello\\\\"
 	#   right: "there\"\012"
-	# check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-basic.c:62
+	# check "!strcmp("NULL", NULL)" failed at t/t0080/t-basic.c:62
 	#    left: "NULL"
 	#   right: NULL
-	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/unit-tests/t-basic.c:63
+	# check "${SQ}a${SQ} == ${SQ}\n${SQ}" failed at t/t0080/t-basic.c:63
 	#    left: ${SQ}a${SQ}
 	#   right: ${SQ}\012${SQ}
-	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/unit-tests/t-basic.c:64
+	# check "${SQ}\\\\${SQ} == ${SQ}\\${SQ}${SQ}" failed at t/t0080/t-basic.c:64
 	#    left: ${SQ}\\\\${SQ}
 	#   right: ${SQ}\\${SQ}${SQ}
 	not ok 17 - messages from failing string and char comparison
-	# BUG: test has no checks at t/unit-tests/t-basic.c:91
+	# BUG: test has no checks at t/t0080/t-basic.c:91
 	not ok 18 - test with no checks
 	ok 19 - test with no checks returns 0
 	1..19
 	EOF
 
-	! "$GIT_BUILD_DIR"/t/unit-tests/bin/t-basic >actual &&
+	! "$GIT_BUILD_DIR"/t/t0080/t-basic >actual &&
 	test_cmp expect actual
 '
 
diff --git a/t/t0080/.gitignore b/t/t0080/.gitignore
new file mode 100644
index 0000000000..1903542827
--- /dev/null
+++ b/t/t0080/.gitignore
@@ -0,0 +1 @@
+/t-basic
diff --git a/t/unit-tests/t-basic.c b/t/t0080/t-basic.c
similarity index 98%
rename from t/unit-tests/t-basic.c
rename to t/t0080/t-basic.c
index fda1ae59a6..83727221b1 100644
--- a/t/unit-tests/t-basic.c
+++ b/t/t0080/t-basic.c
@@ -1,4 +1,4 @@
-#include "test-lib.h"
+#include "../unit-tests/test-lib.h"
 
 /*
  * The purpose of this "unit test" is to verify a few invariants of the unit
-- 
2.43.0.381.gb435a96ce8-goog

