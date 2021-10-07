Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52F7C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9B160F58
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240519AbhJGLBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhJGLBI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C5BC061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so17820547wrg.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tEEtHAQ8UCYDaO4A/Ch4X+sM3t0MfBKstGjJxvTXvA8=;
        b=ZyAUZgxxOSg34ObH3RNP0zaADZeYhR9vyxIefcbG0aC2eX315vEAPPNgbvm8FyVskX
         Qt6Syj6oNG5/LA5Z0rIaBDx5Cs4PcFV+bxJ/w90Di4X+Wex2LHOyI5RXpjSzCV0FBmUR
         Tx0lVOF7hnJ2WJqh/XevWyUD5G5QyzSMSMRGEyR/rnxJrNUcROafwfVSSwjxe4wr270S
         brtsA7CO053rKMiJa7WQgH3aoQbyCMIpDHV7UJxepvOO7gO2H5NKI/JZHLXcrcNVPcpI
         5awb79k0JOISeAvTi3z6EZuSSP8J2LPB04d+9WcI9wutVBXAZqMgfPaqvRGU+ogoTHFp
         LCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tEEtHAQ8UCYDaO4A/Ch4X+sM3t0MfBKstGjJxvTXvA8=;
        b=ZS9iFeP6XoL3zZyQt8u/oH48xHLGFlFN0/p2SpLa7CiIzfqHofsjm77w5rZiOZjYpl
         vCQrgGCT58KiAn890ubDYqB5krHNFnOqUvuupphK3/Ac55dJ4rGu1OkS+XIKdckKKtjW
         UdQ5/noYjNRcd259A7zwQevi7765O2LXzkFBHHEa/dMPpHjfmNITY1C0LzpHiZ0dcEV3
         xPy7TS06ljZPC+ac+hhnAH2xi0Hm/1F9v2JL9uyDKOipu3iSr3vPXTl79pkCmpyvqic/
         QRy98b64KUV5gBxw+SoFdIakyQ8VhyVyf8ZutzfPFVRIHLOQcVa+Fo6gZZkrTe8wfzOp
         bc/Q==
X-Gm-Message-State: AOAM531BWXkz3uTBSQR9OZUod1o5rrVfDzP0Hb9moc9KMGiQM4DjL+zT
        8gjgZoTwbM+rbvqni3BC9nhZiUd4D6Y=
X-Google-Smtp-Source: ABdhPJwnUbgNupYq05fKiSGat1BtyGzKwRa1ThakzKWoF7xkoFJ1ys9uhD26ofzKlMbJUOHFNdbmRg==
X-Received: by 2002:adf:ab03:: with SMTP id q3mr4719361wrc.396.1633604352924;
        Thu, 07 Oct 2021 03:59:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26sm11662225wms.39.2021.10.07.03.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:12 -0700 (PDT)
Message-Id: <9eeb66d5b5d47a6498518657c7ba608e2bc78114.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:58:57 +0000
Subject: [PATCH v5 03/15] scalar: create test infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To test the Scalar command, create a test script in contrib/scalar/t
that is executed as `make -C contrib/scalar test`. Since Scalar has no
meaningful capabilities yet, the only test is rather simple. We will add
more tests in subsequent commits that introduce corresponding, new
functionality.

Note: this test script is intended to test `scalar` only lightly, even
after all of the functionality is implemented.

A more comprehensive functional (or: integration) test suite can be
found at https://github.com/microsoft/scalar; It is used in the workflow
https://github.com/microsoft/git/blob/HEAD/.github/workflows/scalar-functional-tests.yml
in Microsoft's Git fork. This test suite performs end-to-end tests with
a real remote repository, and is run as part of the regular CI builds.
Since those tests require some functionality supported only by
Microsoft's Git fork ("GVFS protocol"), there is no intention to port
that fuller test suite to `contrib/scalar/`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/Makefile          | 17 +++++--
 contrib/scalar/t/Makefile        | 78 ++++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh | 17 +++++++
 3 files changed, 109 insertions(+), 3 deletions(-)
 create mode 100644 contrib/scalar/t/Makefile
 create mode 100755 contrib/scalar/t/t9099-scalar.sh

diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
index 85c186634e9..8620042f281 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -3,6 +3,7 @@ QUIET_SUBDIR1  =
 
 ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
+	QUIET_GEN      = @echo '   ' GEN $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -21,7 +22,7 @@ include ../../config.mak.uname
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-all: scalar$X
+all: scalar$X ../../bin-wrappers/scalar
 
 $(GITLIBS):
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
@@ -30,9 +31,19 @@ $(TARGETS): $(GITLIBS) scalar.c
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
 
 clean:
-	$(RM) $(TARGETS)
+	$(RM) $(TARGETS) ../../bin-wrappers/scalar
 	$(RM) scalar.1 scalar.html scalar.xml
 
+../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
+	@mkdir -p ../../bin-wrappers
+	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
+	     -e 's|@@BUILD_DIR@@|$(shell cd ../.. && pwd)|' \
+	     -e 's|@@PROG@@|contrib/scalar/scalar$(X)|' < $< > $@ && \
+	chmod +x $@
+
+test: all
+	$(MAKE) -C t
+
 docs: scalar.html scalar.1
 
 scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel
@@ -43,4 +54,4 @@ scalar.html scalar.1: scalar.txt
 		../contrib/scalar/$@
 	$(QUIET)test scalar.1 != "$@" || mv ../../Documentation/$@ .
 
-.PHONY: all clean docs FORCE
+.PHONY: all clean docs test FORCE
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
new file mode 100644
index 00000000000..6170672bb37
--- /dev/null
+++ b/contrib/scalar/t/Makefile
@@ -0,0 +1,78 @@
+# Run scalar tests
+#
+# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
+#
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+SHELL_PATH ?= $(SHELL)
+PERL_PATH ?= /usr/bin/perl
+RM ?= rm -f
+PROVE ?= prove
+DEFAULT_TEST_TARGET ?= test
+TEST_LINT ?= test-lint
+
+ifdef TEST_OUTPUT_DIRECTORY
+TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
+else
+TEST_RESULTS_DIRECTORY = ../../../t/test-results
+endif
+
+# Shell quote;
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
+
+T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
+
+all: $(DEFAULT_TEST_TARGET)
+
+test: $(TEST_LINT)
+	$(MAKE) aggregate-results-and-cleanup
+
+prove: $(TEST_LINT)
+	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
+	$(MAKE) clean-except-prove-cache
+
+$(T):
+	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
+
+clean-except-prove-cache:
+	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
+	$(RM) -r valgrind/bin
+
+clean: clean-except-prove-cache
+	$(RM) .prove
+
+test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
+
+test-lint-duplicates:
+	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
+		test -z "$$dups" || { \
+		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
+
+test-lint-executable:
+	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
+		test -z "$$bad" || { \
+		echo >&2 "non-executable tests:" $$bad; exit 1; }
+
+test-lint-shell-syntax:
+	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T)
+
+aggregate-results-and-cleanup: $(T)
+	$(MAKE) aggregate-results
+	$(MAKE) clean
+
+aggregate-results:
+	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
+		echo "$$f"; \
+	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
+
+valgrind:
+	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
+
+test-results:
+	mkdir -p test-results
+
+.PHONY: $(T) aggregate-results clean valgrind
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
new file mode 100755
index 00000000000..16f2b72b126
--- /dev/null
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description='test the `scalar` command'
+
+TEST_DIRECTORY=$PWD/../../../t
+export TEST_DIRECTORY
+
+# Make it work with --no-bin-wrappers
+PATH=$PWD/..:$PATH
+
+. ../../../t/test-lib.sh
+
+test_expect_success 'scalar shows a usage' '
+	test_expect_code 129 scalar -h
+'
+
+test_done
-- 
gitgitgadget

