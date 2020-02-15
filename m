Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A706CC71150
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7625020718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvh62rHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgBOVhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgBOVg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so15115067wrh.5
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A17s0+w0Ko4KC4BNziv/kZjmtRZcfD/g9Nwp+66LUqE=;
        b=Kvh62rHo30Q2tyvCm3fVbKi1aOuVHkaUNZEjE8s3I0zs+Q3FPvePfHmCK+QAAc6g1c
         YH/DTttpzVOoDJjo44vrynDWUxzcgppY+c02O6k9YtYwhdNE5h14DovOmUDm7eFasLck
         r2usia9uxMaLvcSuf00y80CRIV3LjiIyRAGnSAQxuaJ8dk/QtJo3C8Qbgl6TXHN0ErJ4
         KKl5X48wUfbpP2BX2tOD+6XVM6I+C5bzqavQw4d6lrCQ1xFwwBCtanfCnPBW5wfrc/68
         XqZdt+omGjcXFF7WWRTf15y/jD0K1M605BMu27sr54vQ5YTaMqMs22ZLeyuD6eATfw/N
         L6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A17s0+w0Ko4KC4BNziv/kZjmtRZcfD/g9Nwp+66LUqE=;
        b=qqJj1CBPVghpLVEBnkxcw1Kzuw7/daLo+KVIroPzIgD5gy/NDhLmfs3ceE2sr8QnHX
         WCjkS6gtPIievFllK4FC5vjLEr1CCyO78qBb/vrk+y/V6WlkdNQ28C5+xS9KyiHHSzAQ
         eM1mKLQfTAeVQ61UcR5qSsjXzsWPKeUqlW4UZIC01hiDbwgCqKv1Sgeb1HovTDYtdRnH
         2IGU5QXudxUsRlJUDiZmkZ6wqFENVGJcR47r2mt9Q0dU780/uhcDk7jv9jCPzFYKM5O8
         s79awbfS1zFAWQQv9nLZzaOmkWl/gZepYtd8nNaMVsA4KndDnI2zd3QUWy3A/okYBVVW
         4MeA==
X-Gm-Message-State: APjAAAUe4FXwJwL0QOeAx/j7MpewQO0LepN6IyE/AHN+rrlnUT5yo4gn
        zacDUb2B3KcV6W7sKNHDJk25n9NP
X-Google-Smtp-Source: APXvYqz9puuC1fc7RXDoXUDo0SmLtzIdV/0RHwpdOg9dbR8qqdcm0zudfU/ClA2WsyR2V6fyEiS8bA==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr12687949wrw.60.1581802615267;
        Sat, 15 Feb 2020 13:36:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm12964113wmi.0.2020.02.15.13.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:54 -0800 (PST)
Message-Id: <56486d4d694be31c6912b7953fd7da3bc8db791f.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:37 +0000
Subject: [PATCH v5 16/20] rebase tests: mark tests specific to the am-backend
 with --am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We have many rebase tests in the testsuite, and often the same test is
repeated multiple times just testing different backends.  For those
tests that were specifically trying to test the am backend, add the --am
flag.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3400-rebase.sh                 | 10 ++++-----
 t/t3401-rebase-and-am-rename.sh   |  4 ++--
 t/t3404-rebase-interactive.sh     |  2 +-
 t/t3406-rebase-message.sh         | 12 +++++------
 t/t3407-rebase-abort.sh           |  6 +++---
 t/t3420-rebase-autostash.sh       |  2 +-
 t/t3421-rebase-topology-linear.sh | 34 +++++++++++++++----------------
 t/t3425-rebase-topology-merges.sh |  8 ++++----
 t/t3432-rebase-fast-forward.sh    |  4 ++--
 t/t5407-post-rewrite-hook.sh      | 12 +++++------
 t/t7512-status-help.sh            | 12 +++++------
 11 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71fd6396cdc..0a491f23632 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -183,19 +183,19 @@ test_expect_success 'default to common base in @{upstream}s reflog if no upstrea
 	test_cmp expect actual
 '
 
-test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg' '
+test_expect_success 'default to common base in @{upstream}s reflog if no upstream arg (--am)' '
 	git checkout -B default-base master &&
 	git checkout -B default topic &&
 	git config branch.default.remote . &&
 	git config branch.default.merge refs/heads/default-base &&
-	git rebase &&
+	git rebase --am &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
 	test_cmp expect actual &&
 	git checkout default-base &&
 	git reset --hard HEAD^ &&
 	git checkout default &&
-	git rebase &&
+	git rebase --am &&
 	git rev-parse --verify default-base >expect &&
 	git rev-parse default~1 >actual &&
 	test_cmp expect actual
@@ -226,7 +226,7 @@ test_expect_success 'cherry-picked commits and fork-point work together' '
 
 test_expect_success 'rebase --am -q is quiet' '
 	git checkout -b quiet topic &&
-	git rebase -q master >output.out 2>&1 &&
+	git rebase --am -q master >output.out 2>&1 &&
 	test_must_be_empty output.out
 '
 
@@ -325,7 +325,7 @@ test_expect_success 'rebase --am and --show-current-patch' '
 		echo two >>init.t &&
 		git commit -a -m two &&
 		git tag two &&
-		test_must_fail git rebase -f --onto init HEAD^ &&
+		test_must_fail git rebase --am -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
 		grep "show.*$(git rev-parse two)" stderr
 	)
diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index a0b9438b228..50803958fd0 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -52,13 +52,13 @@ test_expect_success 'rebase --interactive: directory rename detected' '
 	)
 '
 
-test_expect_failure 'rebase (am): directory rename detected' '
+test_expect_failure 'rebase --am: directory rename detected' '
 	(
 		cd dir-rename &&
 
 		git checkout B^0 &&
 
-		git -c merge.directoryRenames=true rebase A &&
+		git -c merge.directoryRenames=true rebase --am A &&
 
 		git ls-files -s >out &&
 		test_line_count = 5 out &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a31583eb2fd..f964b2cd41d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1138,7 +1138,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git checkout conflict-branch &&
 	(
 		set_fake_editor &&
-		test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
+		test_must_fail git rebase -f --am --onto HEAD~2 HEAD~ &&
 		test_must_fail git rebase --edit-todo
 	) &&
 	git rebase --abort
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 0c2c569f959..7ce617fc1fb 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -23,24 +23,24 @@ test_expect_success 'rebase -m' '
 '
 
 test_expect_success 'rebase against master twice' '
-	git rebase master >out &&
+	git rebase --am master >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
 
 test_expect_success 'rebase against master twice with --force' '
-	git rebase --force-rebase master >out &&
+	git rebase --force-rebase --am master >out &&
 	test_i18ngrep "Current branch topic is up to date, rebase forced" out
 '
 
 test_expect_success 'rebase against master twice from another branch' '
 	git checkout topic^ &&
-	git rebase master topic >out &&
+	git rebase --am master topic >out &&
 	test_i18ngrep "Current branch topic is up to date" out
 '
 
 test_expect_success 'rebase fast-forward to master' '
 	git checkout topic^ &&
-	git rebase topic >out &&
+	git rebase --am topic >out &&
 	test_i18ngrep "Fast-forwarded HEAD to topic" out
 '
 
@@ -89,7 +89,7 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	git checkout -b reflog-topic start &&
 	test_commit reflog-to-rebase &&
 
-	git rebase reflog-onto &&
+	git rebase --am reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
 	rebase finished: returning to refs/heads/reflog-topic
@@ -99,7 +99,7 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	test_cmp expect actual &&
 
 	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
+	GIT_REFLOG_ACTION=change-the-reflog git rebase --am reflog-onto &&
 	git log -g --format=%gs -3 >actual &&
 	cat >expect <<-\EOF &&
 	rebase finished: returning to refs/heads/reflog-prefix
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 910f2182843..3e318261703 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -96,14 +96,14 @@ testrebase() {
 	'
 }
 
-testrebase "" .git/rebase-apply
+testrebase " --am" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 
-test_expect_success 'rebase --quit' '
+test_expect_success 'rebase --am --quit' '
 	cd "$work_dir" &&
 	# Clean up the state from the previous one
 	git reset --hard pre-rebase &&
-	test_must_fail git rebase master &&
+	test_must_fail git rebase --am master &&
 	test_path_is_dir .git/rebase-apply &&
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 5f7e73cf83a..3816159e207 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -234,7 +234,7 @@ test_expect_success "rebase: noop rebase" '
 	git checkout feature-branch
 '
 
-testrebase "" .git/rebase-apply
+testrebase " --am" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 57334dca7e4..e12304012a2 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -26,7 +26,7 @@ test_run_rebase () {
 		test_linear_range 'd e' c..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -50,7 +50,7 @@ test_run_rebase () {
 		test_cmp_rev e HEAD
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -66,7 +66,7 @@ test_run_rebase () {
 		test_linear_range 'd e' b..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
@@ -83,7 +83,7 @@ test_run_rebase () {
 		test_linear_range 'd e' branch-b..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
@@ -98,7 +98,7 @@ test_run_rebase () {
 		test_cmp_rev e HEAD
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
@@ -139,7 +139,7 @@ test_run_rebase () {
 		test_linear_range 'd i' h..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -154,7 +154,7 @@ test_run_rebase () {
 		test_linear_range 'd' h..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -169,7 +169,7 @@ test_run_rebase () {
 		test_linear_range 'd i' f..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -184,7 +184,7 @@ test_run_rebase () {
 		test_linear_range 'd gp i' h..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -212,7 +212,7 @@ test_run_rebase () {
 		test_linear_range 'j d k l' c..
 	"
 }
-test_run_rebase failure ''
+test_run_rebase failure --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
@@ -227,7 +227,7 @@ test_run_rebase () {
 		test_linear_range 'd k l' c..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -242,7 +242,7 @@ test_run_rebase () {
 		test_linear_range 'd k l' j..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -282,7 +282,7 @@ test_run_rebase () {
 		test_linear_range 'x y' c..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -297,7 +297,7 @@ test_run_rebase () {
 		test_linear_range 'x y' c..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
@@ -312,7 +312,7 @@ test_run_rebase () {
 		test_linear_range 'x y' m..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
@@ -328,7 +328,7 @@ test_run_rebase () {
 	"
 }
 
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
@@ -343,7 +343,7 @@ test_run_rebase () {
 		test_linear_range 'x y' m..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index fd8efe84fe8..19700b025b5 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -54,7 +54,7 @@ test_run_rebase () {
 		test_linear_range 'n o' e..
 	"
 }
-test_run_rebase success ''
+test_run_rebase success --am
 test_run_rebase success -m
 test_run_rebase success -i
 
@@ -70,7 +70,7 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" d..
 	"
 }
-test_run_rebase success 'n o e' ''
+test_run_rebase success 'n o e' --am
 test_run_rebase success 'n o e' -m
 test_run_rebase success 'n o e' -i
 
@@ -86,7 +86,7 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-test_run_rebase success 'd n o e' ''
+test_run_rebase success 'd n o e' --am
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
@@ -102,7 +102,7 @@ test_run_rebase () {
 		test_linear_range "\'"$expected"\'" c..
 	"
 }
-test_run_rebase success 'd n o e' ''
+test_run_rebase success 'd n o e' --am
 test_run_rebase success 'd n o e' -m
 test_run_rebase success 'd n o e' -i
 
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 40388ccf9f3..4b3cecce560 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -28,8 +28,8 @@ test_rebase_same_head () {
 	shift &&
 	cmp_f="$1" &&
 	shift &&
-	test_rebase_same_head_ $status_n $what_n $cmp_n "" "$*" &&
-	test_rebase_same_head_ $status_f $what_f $cmp_f " --no-ff" "$*"
+	test_rebase_same_head_ $status_n $what_n $cmp_n " --am" "$*" &&
+	test_rebase_same_head_ $status_f $what_f $cmp_f " --am --no-ff" "$*"
 	test_rebase_same_head_ $status_n $what_n $cmp_n " --merge" "$*" &&
 	test_rebase_same_head_ $status_f $what_f $cmp_f " --merge --no-ff" "$*"
 }
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 7344253bfbb..a8a73616e46 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -53,10 +53,10 @@ test_expect_success 'git commit --amend --no-post-rewrite' '
 	test ! -f post-rewrite.data
 '
 
-test_expect_success 'git rebase' '
+test_expect_success 'git rebase --am' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --onto A B &&
+	test_must_fail git rebase --am --onto A B &&
 	echo C > foo &&
 	git add foo &&
 	git rebase --continue &&
@@ -68,10 +68,10 @@ test_expect_success 'git rebase' '
 	verify_hook_input
 '
 
-test_expect_success 'git rebase --skip' '
+test_expect_success 'git rebase --am --skip' '
 	git reset --hard D &&
 	clear_hook_input &&
-	test_must_fail git rebase --onto A B &&
+	test_must_fail git rebase --am --onto A B &&
 	test_must_fail git rebase --skip &&
 	echo D > foo &&
 	git add foo &&
@@ -84,10 +84,10 @@ test_expect_success 'git rebase --skip' '
 	verify_hook_input
 '
 
-test_expect_success 'git rebase --skip the last one' '
+test_expect_success 'git rebase --am --skip the last one' '
 	git reset --hard F &&
 	clear_hook_input &&
-	test_must_fail git rebase --onto D A &&
+	test_must_fail git rebase --am --onto D A &&
 	git rebase --skip &&
 	echo rebase >expected.args &&
 	cat >expected.data <<-EOF &&
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 66d7a627972..d22b0acf2ac 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -71,10 +71,10 @@ test_expect_success 'prepare for rebase conflicts' '
 '
 
 
-test_expect_success 'status when rebase in progress before resolving conflicts' '
+test_expect_success 'status when rebase --am in progress before resolving conflicts' '
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
-	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	test_must_fail git rebase --am HEAD^ --onto HEAD^^ &&
 	cat >expected <<EOF &&
 rebase in progress; onto $ONTO
 You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
@@ -94,11 +94,11 @@ EOF
 '
 
 
-test_expect_success 'status when rebase in progress before rebase --continue' '
+test_expect_success 'status when rebase --am in progress before rebase --continue' '
 	git reset --hard rebase_conflicts &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
-	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	test_must_fail git rebase --am HEAD^ --onto HEAD^^ &&
 	echo three >main.txt &&
 	git add main.txt &&
 	cat >expected <<EOF &&
@@ -688,7 +688,7 @@ EOF
 '
 
 
-test_expect_success 'status when rebase conflicts with statushints disabled' '
+test_expect_success 'status when rebase --am conflicts with statushints disabled' '
 	git reset --hard master &&
 	git checkout -b statushints_disabled &&
 	test_when_finished "git config --local advice.statushints true" &&
@@ -698,7 +698,7 @@ test_expect_success 'status when rebase conflicts with statushints disabled' '
 	test_commit three_statushints main.txt three &&
 	test_when_finished "git rebase --abort" &&
 	ONTO=$(git rev-parse --short HEAD^^) &&
-	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
+	test_must_fail git rebase --am HEAD^ --onto HEAD^^ &&
 	cat >expected <<EOF &&
 rebase in progress; onto $ONTO
 You are currently rebasing branch '\''statushints_disabled'\'' on '\''$ONTO'\''.
-- 
gitgitgadget

