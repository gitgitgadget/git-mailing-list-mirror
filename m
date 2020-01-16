Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C34C35241
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B6C20728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDNxqaG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgAPGO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:58 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41767 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgAPGOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:50 -0500
Received: by mail-wr1-f42.google.com with SMTP id c9so17875483wrw.8
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MEgkfIf6e2ZNByifJBuaFEt3L/CHk3iNrDlWOIQNdUA=;
        b=GDNxqaG3aYyxTBLoi42jiYvNv3rmZfzBsBr897dZOf2UPeCojwgM7Kuyc9vOj4O6JN
         njvThGdXA5qIZskcZtmjwWZJHPn+E/z88tpts6Akhy0/6oLhqBXqnN72WDds8d5rM+QS
         yfhtFxdvkXWM6d1Y+QCxFoQxwIpMT4yPrc4Bvp/kAQhMKDPSZOgYCw5CHRl17fmyP/EE
         OxTxTDUDaHiiXqBttxFT4iDw70uRUBS+gNC4mT5aV2KMj2BQGbEoVmEkr7G+BuyWp+z2
         OQ89ibDDbhFlNSUZ7SF/EdjAYTObiMh8THgwf9fSpf2ccbdXey9o7g4GGBu7PYCx3Qzc
         P/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MEgkfIf6e2ZNByifJBuaFEt3L/CHk3iNrDlWOIQNdUA=;
        b=bDnUTOEOfKZ2N6IDt5o2cZmwzGm5lpeF+JLNLQ12DGngDBZZpro8+XiuCVrH0BY7lU
         EjnAclXTQeFPsTqrxQB8RB0Mvw0Sot+6ReK8zoL0vzD7oawXe5woGE1hfpdq11Agw0bN
         Egh4eIlz9WcSN5KaR8wGQsAsNGtAWvbVoyLB7oM53ghCgXGs/oUXL96UebUrFprPQXIq
         8NVcSYdUmN8pbvyweSkQDKGYUlG5cepU9JhRG4lV+75At4UViwenqqj/sDA4Qi/z7aZK
         4rlzcNmjSbndjcFDQQpPkza+0A3WjSW+9PVMu2nrB7gze72xqdXtWatqd3ighEzkrrtD
         q7ow==
X-Gm-Message-State: APjAAAWTVP0k+uvAvqc4qPnecpkX38K7u3s6IIqIPfhub3SLFluLyBIY
        X5KCy6ep2vCJiddhWK/A5H6b68Hs
X-Google-Smtp-Source: APXvYqywP4XRt97cqvxHZjqtaThkpV70RvO6CmTuedEZbNYOjNzuMPvoFKVjXNE7G+od47LzQCMLyw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr1241926wru.294.1579155287529;
        Wed, 15 Jan 2020 22:14:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm3029699wmj.19.2020.01.15.22.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:47 -0800 (PST)
Message-Id: <170be283a851322afffa1b74e7d3eb366eb2da50.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:30 +0000
Subject: [PATCH v4 16/19] rebase tests: mark tests specific to the am-backend
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
 t/t3400-rebase.sh                 | 10 +++++-----
 t/t3401-rebase-and-am-rename.sh   |  4 ++--
 t/t3404-rebase-interactive.sh     |  2 +-
 t/t3406-rebase-message.sh         | 12 ++++++------
 t/t3407-rebase-abort.sh           |  6 +++---
 t/t3420-rebase-autostash.sh       |  2 +-
 t/t3425-rebase-topology-merges.sh |  8 ++++----
 t/t3432-rebase-fast-forward.sh    |  4 ++--
 t/t5407-post-rewrite-hook.sh      | 12 ++++++------
 t/t7512-status-help.sh            | 12 ++++++------
 10 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 71fd6396cd..0a491f2363 100755
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
index a0b9438b22..50803958fd 100755
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
index a31583eb2f..f964b2cd41 100755
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
index 0c2c569f95..7ce617fc1f 100755
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
index 910f218284..3e31826170 100755
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
index 5f7e73cf83..3816159e20 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -234,7 +234,7 @@ test_expect_success "rebase: noop rebase" '
 	git checkout feature-branch
 '
 
-testrebase "" .git/rebase-apply
+testrebase " --am" .git/rebase-apply
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index fd8efe84fe..19700b025b 100755
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
index 40388ccf9f..4b3cecce56 100755
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
index 7344253bfb..a8a73616e4 100755
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
index 66d7a62797..d22b0acf2a 100755
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

