Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E192E1F461
	for <e@80x24.org>; Mon, 13 May 2019 18:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfEMSc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 14:32:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33967 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfEMSc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 14:32:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so582957wma.1
        for <git@vger.kernel.org>; Mon, 13 May 2019 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKPYKlGz6hrtpNMi+tVFfPsyNdjVz3y035260QQFRqw=;
        b=sQ7aVYunFEYowZ48YiV3K+AxytV//yHMhRGuu7GniDtRA24qU1nhfV/trsXZTGC7pS
         lty/rGV6e7eJUPzU+MTmesase7OB7kKZ5ic8lst/RUyQmbKxemsJ/WEe/R6m8TzRXOeR
         NmaSqKiXcYRhkGXm3gqpXsDkUDEFpVgSGqW9OSWT6jrQARcE0ybaSNWzacfG9Lydae8g
         esaHqFIlEFsJvZGwTXGK5vwWm1I+33/F+mcM9R1JrurpW2Bo/nyrw9AZy0jcEQXf4Wzq
         NiFJJ2G/XXxyZ6ZZ69dEsFFVYL67VAHunYSfvaopwO8NX6SIA0f5TvoBAc8TzobYQEsh
         gHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKPYKlGz6hrtpNMi+tVFfPsyNdjVz3y035260QQFRqw=;
        b=a5ETERBCYRONoRCQnpzTeUXsMrPcqYUk7w7d2ExDUolU3PnyMVagunmya2I2A1a0Ml
         I0VDsECe5srmwDmRyok0eodv9+ohFBNVX33kKSqw7Z6B/5GSiCgCD06B/+jSPjNYb9bu
         EjR2KqJ2wFjL5vcPHERgKxnzvywiQM08iLVhXZH+N/2D6qbFeA4PJ2SHXSX0Remw72iA
         9uqe764xC+9AzOMALm5f7LpU4cWLWJjrCVfnh6EOk6LCuqi2HuMOSMqEa9geCthPBhC/
         /lMSueN/6Isn2dwobwicn7Xc/+c6/K7bWY2l9WnR7m53H2abuAFitb0PsNDzf8N8THvz
         Mb2A==
X-Gm-Message-State: APjAAAV98hYqvPL5T6H4M7Uru32mCGcxDrTPee0Al8+nRSgpiJrZGSrT
        hrWulpMO4LRwdeogiA9usSHDGpyx
X-Google-Smtp-Source: APXvYqzIiH9BS0WtaTAwjIE6IJmyIuMB9L+wn6/PUDpA5nf85PJj9pMt3o7juB1Nl+2N6ZCXyXGbmg==
X-Received: by 2002:a05:600c:1109:: with SMTP id b9mr16291134wma.77.1557772374356;
        Mon, 13 May 2019 11:32:54 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e8sm32355512wrc.34.2019.05.13.11.32.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 11:32:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] tests: add a special setup where prerequisites fail
Date:   Mon, 13 May 2019 20:32:42 +0200
Message-Id: <20190513183242.10600-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in [1] there's a regression in the "pu" branch now
because a new test implicitly assumed that a previous test guarded by
a prerequisite had been run. Add a "GIT_TEST_FAIL_PREREQS" special
test setup where we'll skip (nearly) all tests guarded by
prerequisites, allowing us to easily emulate those platform where we
don't run these tests.

As noted in the documentation I'm adding I'm whitelisting the SYMLINKS
prerequisite for now. A lot of tests started failing if we lied about
not supporting symlinks. It's also unlikely that we'll have a failing
test due to a hard dependency on symlinks without that being the
obvious cause, so for now it's not worth the effort to make it work.

1. https://public-inbox.org/git/nycvar.QRO.7.76.6.1905131531000.44@tvgsbejvaqbjf.bet/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, May 13 2019, Johannes Schindelin wrote:

> [...]
> Namely, when test cases 51 and 52 are skipped because of a missing GPG
> prerequisite [*1*], and those two are obviously required to run for the
> `git merge to fail in your test case, as you can very easily verify by
> downloading the artifact containing the `trash directory.t7600-merge`
> directory and re-running the last steps on Linux (where the `git -c
> rerere.enabled=true merge master` *succeeds*).
>
> In fact, you can very, very easily emulate the whole situation on your box
> by running:
>
> 	sh t7600-merge.sh -i -v -x --run=1-50,53-59
>
> And then you can fix your test case so that it does not need to rely on
> test cases that may, or may not, have run previously.

I think it would be better to more pro-actively spot this sort of
thing in the future, so here's a patch to do that. It passes on
"master", but fails on "pu" due to the issue with the one test being
discussed here.

 t/README                   |  9 +++++++++
 t/t0000-basic.sh           | 10 +++++-----
 t/t4202-log.sh             |  2 +-
 t/t7405-submodule-merge.sh |  2 +-
 t/t7810-grep.sh            |  6 +++---
 t/test-lib-functions.sh    | 20 ++++++++++++++++++++
 t/test-lib.sh              |  4 ++++
 7 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/t/README b/t/README
index 6404f33e19..9747971d58 100644
--- a/t/README
+++ b/t/README
@@ -334,6 +334,15 @@ that cannot be easily covered by a few specific test cases. These
 could be enabled by running the test suite with correct GIT_TEST_
 environment set.
 
+GIT_TEST_FAIL_PREREQS<non-empty?> fails all prerequisites. This is
+useful for discovering issues with the tests where say a later test
+implicitly depends on an optional earlier test.
+
+There's a "FAIL_PREREQS" prerequisite that can be used to test for
+whether this mode is active, and e.g. skip some tests that are hard to
+refactor to deal with it. The "SYMLINKS" prerequisite is currently
+excluded as so much relies on it, but this might change in the future.
+
 GIT_TEST_GETTEXT_POISON=<non-empty?> turns all strings marked for
 translation into gibberish if non-empty (think "test -n"). Used for
 spotting those tests that need to be marked with a C_LOCALE_OUTPUT
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index c03054c538..31de7e90f3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -726,7 +726,7 @@ donthaveit=yes
 test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be skipped' '
 	donthaveit=no
 '
-if test $haveit$donthaveit != yesyes
+if test -z "$GIT_TEST_FAIL_PREREQS" -a $haveit$donthaveit != yesyes
 then
 	say "bug in test framework: prerequisite tags do not work reliably"
 	exit 1
@@ -747,7 +747,7 @@ donthaveiteither=yes
 test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test to be skipped' '
 	donthaveiteither=no
 '
-if test $haveit$donthaveit$donthaveiteither != yesyesyes
+if test -z "$GIT_TEST_FAIL_PREREQS" -a $haveit$donthaveit$donthaveiteither != yesyesyes
 then
 	say "bug in test framework: multiple prerequisite tags do not work reliably"
 	exit 1
@@ -763,7 +763,7 @@ test_expect_success !LAZY_TRUE 'missing lazy prereqs skip tests' '
 	donthavetrue=no
 '
 
-if test "$havetrue$donthavetrue" != yesyes
+if test -z "$GIT_TEST_FAIL_PREREQS" -a "$havetrue$donthavetrue" != yesyes
 then
 	say 'bug in test framework: lazy prerequisites do not work'
 	exit 1
@@ -779,7 +779,7 @@ test_expect_success LAZY_FALSE 'missing negative lazy prereqs will skip' '
 	havefalse=no
 '
 
-if test "$nothavefalse$havefalse" != yesyes
+if test -z "$GIT_TEST_FAIL_PREREQS" -a "$nothavefalse$havefalse" != yesyes
 then
 	say 'bug in test framework: negative lazy prerequisites do not work'
 	exit 1
@@ -790,7 +790,7 @@ test_expect_success 'tests clean up after themselves' '
 	test_when_finished clean=yes
 '
 
-if test $clean != yes
+if test -z "$GIT_TEST_FAIL_PREREQS" -a $clean != yes
 then
 	say "bug in test framework: basic cleanup command does not work reliably"
 	exit 1
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 819c24d10e..c20209324c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -352,7 +352,7 @@ test_expect_success 'log with grep.patternType configuration and command line' '
 	test_cmp expect actual
 '
 
-test_expect_success 'log with various grep.patternType configurations & command-lines' '
+test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurations & command-lines' '
 	git init pattern-type &&
 	(
 		cd pattern-type &&
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 7855bd8648..aa33978ed2 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -417,7 +417,7 @@ test_expect_failure 'directory/submodule conflict; keep submodule clean' '
 	)
 '
 
-test_expect_failure 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
+test_expect_failure !FAIL_PREREQS 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
 	test_when_finished "git -C directory-submodule/path reset --hard" &&
 	test_when_finished "git -C directory-submodule reset --hard" &&
 	(
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 2e1bb61b41..7d7b396c23 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -412,7 +412,7 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success !PCRE "grep $L with grep.patterntype=perl errors without PCRE" '
+	test_expect_success !FAIL_PREREQS,!PCRE "grep $L with grep.patterntype=perl errors without PCRE" '
 		test_must_fail git -c grep.patterntype=perl grep "foo.*bar"
 	'
 
@@ -1234,7 +1234,7 @@ test_expect_success PCRE 'grep --perl-regexp pattern' '
 	test_cmp expected actual
 '
 
-test_expect_success !PCRE 'grep --perl-regexp pattern errors without PCRE' '
+test_expect_success !FAIL_PREREQS,!PCRE 'grep --perl-regexp pattern errors without PCRE' '
 	test_must_fail git grep --perl-regexp "foo.*bar"
 '
 
@@ -1249,7 +1249,7 @@ test_expect_success LIBPCRE2 "grep -P with (*NO_JIT) doesn't error out" '
 
 '
 
-test_expect_success !PCRE 'grep -P pattern errors without PCRE' '
+test_expect_success !FAIL_PREREQS,!PCRE 'grep -P pattern errors without PCRE' '
 	test_must_fail git grep -P "foo.*bar"
 '
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8270de74be..0367cec5fd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -309,6 +309,26 @@ test_unset_prereq () {
 }
 
 test_set_prereq () {
+	if test -n "$GIT_TEST_FAIL_PREREQS"
+	then
+		case "$1" in
+		# The "!" case is handled below with
+		# test_unset_prereq()
+		!*)
+			;;
+		# (Temporary?) whitelist of things we can't easily
+		# pretend not to support
+		SYMLINKS)
+			;;
+		# Inspecting whether GIT_TEST_FAIL_PREREQS is on
+		# should be unaffected.
+		FAIL_PREREQS)
+			;;
+		*)
+			return
+		esac
+	fi
+
 	case "$1" in
 	!*)
 		test_unset_prereq "${1#!}"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 908ddb9c46..6fabafebb3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1607,3 +1607,7 @@ test_lazy_prereq SHA1 '
 test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
+
+test_lazy_prereq FAIL_PREREQS '
+	test -n "$GIT_TEST_FAIL_PREREQS"
+'
-- 
2.21.0.1020.gf2820cf01a

