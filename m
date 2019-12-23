Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17311C2D0D5
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5DF20643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps9sSNKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLWSuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:15 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:39746 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfLWSuN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:13 -0500
Received: by mail-ed1-f47.google.com with SMTP id t17so16123572eds.6
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ds1KRm/kbRB6rsjU/MsCu9BlXzLi/I6icRUWkrh+Dbg=;
        b=Ps9sSNKGl97cr16OOI3tsLnOMfYHqf3WixhX9Y2iciDh2+RQ8XUAn+xC1Y0K9R6pub
         sx9Wm21KRwMIdRMH1boMboRWqU+OIX7bbGfbtz1xw+B3zDVUVbeYU8NtcPp5MZEbPTqC
         x69sWp4rG76Xto4x/vKCBZNUm4aKvWAGhNgOmkp61Jd6pY+elijxaU7HxjID89ERH2J4
         4Az28TTS2OnXlBsteRqYo0I7BBgfZbhqrnn6ljL8G6g3eMQvzJPngMRuJEHWVyAeE+HS
         X1YL0eX+COyiM9jwr8fAqUb/5bi11vXTBs91dFriuFo95SfzxLDO8p+MiFot+YvcnYTr
         i/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ds1KRm/kbRB6rsjU/MsCu9BlXzLi/I6icRUWkrh+Dbg=;
        b=btzlD1mQNkt7AuqsnU20iuSarP8qtdzgyM7ta7L0urBn8hgJJWesEMj/2HSH558dNN
         d7nuguOnuTxMvCKa9eaaNZfi9eUVtXyojYrRtH5fvvE4Y5sbpAKi8wOIGT8iHGzs5Qw6
         A/tKKslT3favT4pAB4KaqW+QgnR3vi6p+oyLAtmcwurOEDjtXAPJ9vsgEK6N1gt6WLA+
         YRWOKXkeemgzzD68SiB4ShhmNo+aP0nNhKr8uqeA8269sPBuaLc1RlKwYVAMiQpbxzvS
         GkfGg2QtmMdnMJkjG1fMQN4/PU2y+xGWyMRV/74KCq35tQte0ArwrjwOGWeayLJ6DFue
         ciKw==
X-Gm-Message-State: APjAAAW7PT/WuP3iyejCCLgZZK+onaEa790od0nwD8jt8ORJT5eMVWkN
        5hUnDKyIxXA2P/tiXA+yoDlsw/7O
X-Google-Smtp-Source: APXvYqyiPXdTeQteDSiPRwV0Rhaj5IxUCIfK2FTCpwUQ5hBgojGz0TGbEWCJVCQSL+MA0oDkiWFJNQ==
X-Received: by 2002:aa7:c811:: with SMTP id a17mr33978917edt.272.1577127009884;
        Mon, 23 Dec 2019 10:50:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba29sm2329223edb.47.2019.12.23.10.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:09 -0800 (PST)
Message-Id: <c905d288bf94f8326f01dedfd432d1a91cb040bf.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:56 +0000
Subject: [PATCH v2 12/15] rebase tests: mark tests specific to the am-backend
 with --am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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
 t/t3400-rebase.sh                       | 10 +++++-----
 t/t3401-rebase-and-am-rename.sh         |  4 ++--
 t/t3404-rebase-interactive.sh           |  2 +-
 t/t3406-rebase-message.sh               | 12 ++++++------
 t/t3407-rebase-abort.sh                 |  6 +++---
 t/t3420-rebase-autostash.sh             |  2 +-
 t/t3425-rebase-topology-merges.sh       |  8 ++++----
 t/t3432-rebase-fast-forward.sh          |  4 ++--
 t/t3433-rebase-options-compatibility.sh |  8 ++++----
 t/t5407-post-rewrite-hook.sh            | 12 ++++++------
 t/t7512-status-help.sh                  | 12 ++++++------
 11 files changed, 40 insertions(+), 40 deletions(-)

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
index ae6e55ce79..743b7e511a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1137,7 +1137,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
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
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index bd4d2d2f63..a07e1f276b 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -51,9 +51,9 @@ test_expect_success '--ignore-whitespace works with am backend' '
 	new line 2
 	line 3
 	EOF
-	test_must_fail git rebase main side &&
+	test_must_fail git rebase --am main side &&
 	git rebase --abort &&
-	git rebase --ignore-whitespace main side &&
+	git rebase --am --ignore-whitespace main side &&
 	test_cmp expect file
 '
 
@@ -71,7 +71,7 @@ test_expect_success '--ignore-whitespace works with interactive backend' '
 
 test_expect_success '--committer-date-is-author-date works with am backend' '
 	git commit --amend &&
-	git rebase --committer-date-is-author-date HEAD^ &&
+	git rebase --am --committer-date-is-author-date HEAD^ &&
 	git show HEAD --pretty="format:%ai" >authortime &&
 	git show HEAD --pretty="format:%ci" >committertime &&
 	test_cmp authortime committertime
@@ -103,7 +103,7 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
 # sets to +0530.
 test_expect_success '--ignore-date works with am backend' '
 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
-	git rebase --ignore-date HEAD^ &&
+	git rebase --am --ignore-date HEAD^ &&
 	git show HEAD --pretty="format:%ai" >authortime &&
 	grep "+0000" authortime
 '
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

