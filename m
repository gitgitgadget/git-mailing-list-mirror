Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE9C7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 23:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjEQX4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 19:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEQX4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 19:56:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B125049DC
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba802c775caso2571407276.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684367803; x=1686959803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AKuE9r6n8FKqfM9kKnAgVnNixDFjb0M1StSgfl1Ot0=;
        b=xkn8oRz5Lg/sC3MvKOJMBiMUF28tkFYyy4a9tF2G4tIEmMeThgMexUQmej5r0hFDV9
         3ybunEsk4RXibf8Jze8EADdKP5CL5ZWfJrXuDtkdKmOObC+7/cPiE2liT7OSojrfIenh
         eIWREGbJrIiWvoNwOl1bYUCalQpPL0JdUXm9QTEDaHN49li7QXXDXXirPxxbsobCY87b
         uqlKKGbJxvYjNRDCslJDksC47AAyhS4ZzcykabLgRVaYGCLd1imlLa2+DDk8OYlLkmDJ
         1ONYFXygh6czpy6PIUVLV++FrAYs+BxVp1WDLI2uAAPvylnpZzF9Dybt4JtG2VufFfFg
         Uscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367803; x=1686959803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AKuE9r6n8FKqfM9kKnAgVnNixDFjb0M1StSgfl1Ot0=;
        b=eDEQgn5oSBc+rkWpe5LzZ7Ygbf/bOp5zP1xLXoAnoNuP28sjUJPK3Fwoch/eo27Ly2
         fQVuvDy52gVU/HLCPyr/cTxfu0F64EHT6zAgTbw7PDNulR/Na6EAVDBml10thXRHfVVM
         ycoykPRCHJ5BLKaNY4It0pK9pZVKOnTUJRlhNGFVRzD0M9F8XLhsIV7IpR5tP2T++k+h
         WWrVncwPm8N2Du3qZZHpr0E2zKP8SCuAXE2bSNCUAEumtI7ezDOKtNTdn+wlhZkOrjeK
         8kMT5RYglvYtHDKqYjLp7GRw8sRWhiB/R+A/vPShZaPT5da+tuqR8UZK1D2TqO/HY5eR
         jzTQ==
X-Gm-Message-State: AC+VfDwZQjnrZ1kQtLCbiw1GxRZJsvd64tv0VxOKtkAqos4FSGjD6Ck2
        uthIyRt4yUUb8QD6kiUIGRnP8AxDyZe9b8a1sPSkvN3wRxFuWtYnVTvrIAhuW9RrbF5uEAeaxjp
        v3F+t+p6zT6rD6yqUzTklwHVFde2l3iUMENAv25QJJ/jx5gLuF/wBkn7XVMUx82M=
X-Google-Smtp-Source: ACHHUZ4M/hIG/f3JD1jfPv1Qqo8NMwXsf/vWB3Cg/N8fmdZr9AF6NjT/BtHx+VoIAZYTV4/MVJy+okLziBW4AA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:f597:a1b7:3c54:2bc8])
 (user=steadmon job=sendgmr) by 2002:a25:ae9d:0:b0:ba8:2e68:7715 with SMTP id
 b29-20020a25ae9d000000b00ba82e687715mr3971848ybj.2.1684367802841; Wed, 17 May
 2023 16:56:42 -0700 (PDT)
Date:   Wed, 17 May 2023 16:56:34 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
X-Mailer: b4 0.12.2
Message-ID: <20230517-unit-tests-v2-v2-4-21b5b60f4b32@google.com>
Subject: [PATCH RFC v2 4/4] unit test: add basic example and build rules
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, calvinwan@gmail.com,
        szeder.dev@gmail.com, phillip.wood123@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate a simple strbuf unit test with Git's Makefiles.

You can build and run the unit tests with `make unit-tests` (or just
build them with `make build-unit-tests`). By default we use the basic
test runner from the C-TAP project, but users who prefer prove as a test
runner can set `DEFAULT_UNIT_TEST_TARGET=prove-unit-tests` instead.

We modify the `#include`s in the C TAP libraries so that we can build
them without having to include the t/ directory in our include search
path.

Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
Change-Id: Ie61eafd2bd8f8dc5b30449af1e436889f91da3b7
---
 .gitignore      |  2 ++
 Makefile        | 24 +++++++++++++++++++++++-
 t/Makefile      | 10 ++++++++++
 t/strbuf-test.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 t/tap/basic.c   |  2 +-
 t/tap/basic.h   |  2 +-
 6 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index e875c59054..464e301345 100644
--- a/.gitignore
+++ b/.gitignore
@@ -245,3 +245,5 @@ Release/
 /git.VC.db
 *.dSYM
 /contrib/buildsystems/out
+/t/runtests
+/t/unit-tests/
diff --git a/Makefile b/Makefile
index 8ee7c7e5a8..aa94e3ba45 100644
--- a/Makefile
+++ b/Makefile
@@ -661,6 +661,7 @@ BUILTIN_OBJS =
 BUILT_INS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
+CTAP_OBJS =
 XDIFF_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
@@ -682,6 +683,8 @@ TEST_BUILTINS_OBJS =
 TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
+UNIT_TEST_PROGRAMS =
+UNIT_TEST_DIR = t/unit-tests
 
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
@@ -1318,6 +1321,10 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+CTAP_OBJS += t/tap/basic.o
+UNIT_TEST_RUNNER = t/runtests
+UNIT_TEST_PROGRAMS += $(UNIT_TEST_DIR)/strbuf-test-t
+
 # THIRD_PARTY_SOURCES is a list of patterns compatible with the
 # $(filter) and $(filter-out) family of functions. They specify source
 # files which are taken from some third-party source where we want to be
@@ -2673,6 +2680,7 @@ OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
+OBJECTS += $(CTAP_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3654,7 +3662,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
-	$(RM) $(TEST_PROGRAMS)
+	$(RM) $(TEST_PROGRAMS) $(UNIT_TEST_RUNNER) $(UNIT_TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
 	$(RM) $(HCC)
@@ -3832,3 +3840,17 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+$(UNIT_TEST_DIR):
+	$(QUIET)mkdir $(UNIT_TEST_DIR)
+
+$(UNIT_TEST_PROGRAMS): $(UNIT_TEST_DIR) $(CTAP_OBJS) $(GITLIBS)
+	$(QUIET_CC)$(CC) -o $@ t/$(patsubst %-t,%,$(notdir $@)).c $(CTAP_OBJS) $(LIBS)
+
+$(UNIT_TEST_RUNNER): $(patsubst %,%.c,$(UNIT_TEST_RUNNER))
+	$(QUIET_CC)$(CC) -o $@ $^
+
+.PHONY: build-unit-tests unit-tests
+build-unit-tests: $(UNIT_TEST_PROGRAMS)
+unit-tests: $(UNIT_TEST_PROGRAMS) $(UNIT_TEST_RUNNER)
+	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index 3e00cdd801..9df1a4e34b 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -17,6 +17,7 @@ TAR ?= $(TAR)
 RM ?= rm -f
 PROVE ?= prove
 DEFAULT_TEST_TARGET ?= test
+DEFAULT_UNIT_TEST_TARGET ?= run-unit-tests
 TEST_LINT ?= test-lint
 
 ifdef TEST_OUTPUT_DIRECTORY
@@ -41,6 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
+UNIT_TESTS = $(sort $(wildcard unit-tests/*))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
@@ -65,6 +67,14 @@ prove: pre-clean check-chainlint $(TEST_LINT)
 $(T):
 	@echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
 
+unit-tests: $(DEFAULT_UNIT_TEST_TARGET)
+
+run-unit-tests:
+	./runtests $(UNIT_TESTS)
+
+prove-unit-tests:
+	@echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_OPTS) $(UNIT_TESTS)
+
 pre-clean:
 	$(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
 
diff --git a/t/strbuf-test.c b/t/strbuf-test.c
new file mode 100644
index 0000000000..8f8d4e11db
--- /dev/null
+++ b/t/strbuf-test.c
@@ -0,0 +1,54 @@
+#include "tap/basic.h"
+
+#include "../git-compat-util.h"
+#include "../strbuf.h"
+
+int strbuf_init_test()
+{
+	struct strbuf *buf = malloc(sizeof(void*));
+	strbuf_init(buf, 0);
+
+	if (buf->buf[0] != '\0')
+		return 0;
+	if (buf->alloc != 0)
+		return 0;
+	if (buf->len != 0)
+		return 0;
+	return 1;
+}
+
+int strbuf_init_test2() {
+	struct strbuf *buf = malloc(sizeof(void*));
+	strbuf_init(buf, 100);
+
+	if (buf->buf[0] != '\0')
+		return 0;
+	if (buf->alloc != 101)
+		return 0;
+	if (buf->len != 0)
+		return 0;
+	return 1;
+}
+
+
+int strbuf_grow_test() {
+	struct strbuf *buf = malloc(sizeof(void*));
+	strbuf_grow(buf, 100);
+
+	if (buf->buf[0] != '\0')
+		return 0;
+	if (buf->alloc != 101)
+		return 0;
+	if (buf->len != 0)
+		return 0;
+	return 1;
+}
+
+int main(void)
+{
+	plan(3);
+	ok(strbuf_init_test(), "strbuf_init initializes properly");
+	ok(strbuf_init_test2(), "strbuf_init with hint initializes properly");
+	ok(strbuf_grow_test(), "strbuf_grow grows properly");
+	return 0;
+}
diff --git a/t/tap/basic.c b/t/tap/basic.c
index 704282b9c1..37c2d6f082 100644
--- a/t/tap/basic.c
+++ b/t/tap/basic.c
@@ -52,7 +52,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include <tap/basic.h>
+#include "basic.h"
 
 /* Windows provides mkdir and rmdir under different names. */
 #ifdef _WIN32
diff --git a/t/tap/basic.h b/t/tap/basic.h
index afea8cb210..a0c0ef2c87 100644
--- a/t/tap/basic.h
+++ b/t/tap/basic.h
@@ -36,7 +36,7 @@
 #include <stdarg.h> /* va_list */
 #include <stddef.h> /* size_t */
 #include <stdlib.h> /* free */
-#include <tap/macros.h>
+#include "macros.h"
 
 /*
  * Used for iterating through arrays.  ARRAY_SIZE returns the number of

-- 
2.40.1.606.ga4b1b128d6-goog

