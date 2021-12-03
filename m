Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E55C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381096AbhLCNiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381025AbhLCNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:38:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBEEC06173E
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:34:37 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so5806806wrw.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=urTN5i86EXuc5a/mSz2OtPkPDT42VYR77j7zOne496I=;
        b=P5rKOdJJnR1C0SQnJAtgC3yYtSBE0EtU/cwCh2F5117443+bj/AqMXora5LyHTWJkD
         SeFIIdFLrMqhu2y9mfL6QT1V9kFokl5JPwuzngzlGTncWSPRZY+E0FVHkI10JzQ4cmLZ
         u7lj6n9BaZZqWJlONw1bcU3IMclA7+UyEkGTOXAND3OcAOsA8FqUVArpWRv/IOZU9qMs
         w0st5YhvE98SAYQk9GKYCxG7ZI2DsVvasC6DhSq4ahNJsO3jMYnx7j+5uTKXq0f2OUXd
         dN0Nhdl5Bfd2L+bqXFW+NMKaVl6Smb/7JBC2slsgVVDrL4lfmuV1myZ/tvZucXzY69Bg
         ihXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=urTN5i86EXuc5a/mSz2OtPkPDT42VYR77j7zOne496I=;
        b=y4mynnU8cWLReDB+YvkCBSWfaYhmk2XeGNKgBdMNgwIOxXNlTySDHlQUIzsY9d7rmV
         6VDRBsdCvMK0aPhG0J6Gcb6KhgMoYWX9ypgyWYR/RLwDXchr1V9p4pWagdrigghVknpL
         L/SFpFyDcjz2ay9XBb/apUAcdmgaHysB3Mpg1ggr+PwN3hZ/uB+5WMsy7PGNWRfDAVp8
         72fhbJq8rmZaoCnz3gmu0KdIk3fNty4TaDiDXjzONOQBVNlqWuKbuzgnyFVV7CnDLNu9
         9yc9ESZrcGKdV0k29YDuV6HSp2RIwm2FJ4n6lTrSgxwWfaPh+o5XurpdDkAayXJLNpjB
         52XA==
X-Gm-Message-State: AOAM530uXNYfbORhVMdpfKzQALI1MgoSpFC9DXRNvIWVaRe0GDViDquV
        o1Q5PYFtw3Uq+bSVQZowq4mtXQ40Lgw=
X-Google-Smtp-Source: ABdhPJwwPDaK1X2fj9Kxp1Kur/b7EdnefoyMR5MET08JjqnU7DK8Sbnqcv27CE4+MhuEddEzD6mj4w==
X-Received: by 2002:adf:f542:: with SMTP id j2mr21298111wrp.616.1638538475385;
        Fri, 03 Dec 2021 05:34:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k37sm2795942wms.21.2021.12.03.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:34:34 -0800 (PST)
Message-Id: <37231a4dd07833807639c8a650185569d0c99af2.1638538470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 13:34:18 +0000
Subject: [PATCH v10 04/15] scalar: create test infrastructure
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
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
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

Note: This test script is intended to test `scalar` only lightly, even
after all of the functionality is implemented.

A more comprehensive functional (or: integration) test suite can be
found at https://github.com/microsoft/scalar; It is used in the workflow
https://github.com/microsoft/git/blob/HEAD/.github/workflows/scalar-functional-tests.yml
in Microsoft's Git fork. This test suite performs end-to-end tests with
a real remote repository, and is run as part of the regular CI and PR
builds in that fork.

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
index f6f0036f0fa..231b1ee1796 100644
--- a/contrib/scalar/Makefile
+++ b/contrib/scalar/Makefile
@@ -3,6 +3,7 @@ QUIET_SUBDIR1  =
 
 ifneq ($(findstring s,$(MAKEFLAGS)),s)
 ifndef V
+	QUIET_GEN      = @echo '   ' GEN $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
@@ -20,7 +21,7 @@ include ../../config.mak.uname
 TARGETS = scalar$(X) scalar.o
 GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
 
-all: scalar$(X)
+all: scalar$(X) ../../bin-wrappers/scalar
 
 $(GITLIBS):
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
@@ -29,6 +30,16 @@ $(TARGETS): $(GITLIBS) scalar.c
 	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
 
 clean:
-	$(RM) $(TARGETS)
+	$(RM) $(TARGETS) ../../bin-wrappers/scalar
 
-.PHONY: $(GITLIBS) all clean FORCE
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
+.PHONY: $(GITLIBS) all clean test FORCE
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

