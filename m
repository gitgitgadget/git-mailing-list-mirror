Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C02C64EC7
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1S4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1S4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 13:56:53 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4C30193
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:51 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 10-20020a63030a000000b004fb64e929f2so3679818pgd.7
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mr3R3joRcKFFbyznXeet9EbPAgSQ+Q4tIN1Ev2Trpd4=;
        b=KBbCVMhnQrfhQTQ437rWTVyE8LysI6wqUllpd8fqRT3ahwa8iw2qsGKylWgcWnh54J
         Dpd2Blz4c84bPz4RnLXUNcAEAiacpkxskXpYziUqMLj/pRbIjiPMpHooHLn8/4VUZdq+
         sooDSmoz/OK/oJRS5I5/TrvFYu/B7tv4q9PSNOgKmMTsrAM4iMNia1+8l/BbjWvXcHlr
         cRce68uEsEuGl9rvjNPW+IXMZP/6mbiPHfkZU3LcHpaGLFTXfTfMxR5W/GSQBc7XjilD
         sGCTD4IVHojLd6gGLv4sDFWtCTpKcGHYhvhaqc+pfBMSLm6xpETc98e44/Gwmz/hoENz
         t4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr3R3joRcKFFbyznXeet9EbPAgSQ+Q4tIN1Ev2Trpd4=;
        b=M/aK5+KeHAhLElEedhymuJMa6/tNmth1i0yx6YMcO/FF+Ow6IhN4XretTsTEIB+ukI
         0EnH/qJUqW6Axkc4ZAJoOABU/oam63hrI0S2XPwRrwx3g2RjfXq1esNZLmUCkeuUMcjK
         +IziprQiyAsHRcPgTC51P2fmsRA5cSwoH31NCtXdFu2Q7MtWfiWqcPp7PrO13148KuTC
         4a7QQDaybbdxTHu/5SUS27pomBcq9XZ5K1dkPR8SfrqjlYOpVXXj/l5XXkXATlkvBiZk
         XeJKNMFU3P7XnigShUBqEPso/tN5d8jtCOB6K1TvIt0r/9N+M0OLmbhhpB0Btv5OhbHX
         xaSA==
X-Gm-Message-State: AO0yUKVYjW8ErcCkDQP+qH2yTORVgeAtvfKEA6er2ppi1rDcOh9eVrBW
        ttTcqQURL859u38vRwP12A0zlmT8YYGgwUHYifvdu2nTP6Jb7lu1zWCYigShcafmuvvVhCkurgk
        3XR/Mo0N5TH2BekHdYh863cWHNJXR2/NeFjLje+x38pUh/8pj3nP6Fbwki0FJuoh9Jg==
X-Google-Smtp-Source: AK7set8Zf57dsON36hCbb3L7KjKh6//0pX6OFiYdvK8hb37X480ZqclM2tA6CLGE8rX16TN4AdiYMe+thz6EKh8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:4285:b0:199:1afc:16ad with SMTP
 id ju5-20020a170903428500b001991afc16admr1345831plb.5.1677610611090; Tue, 28
 Feb 2023 10:56:51 -0800 (PST)
Date:   Tue, 28 Feb 2023 18:56:37 +0000
In-Reply-To: <20230228185253.2356546-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228185642.2357806-1-calvinwan@google.com>
Subject: [PATCH v2 1/6] t4041, t4060: modernize test style
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, peff@peff.net,
        gitster@pobox.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

In preparation for later changes, move setup code into test_expect
blocks. Smaller sections are moved into existing blocks, while larger
sections with a standalone purpose are given their own new blocks.

This makes sure that later changes that may break the test setup are
easier to diagnose, because errors will caught immediately rather than
in later unrelated test_expect blocks.

While at it, have tests clean up after themselves with
test_when_finished and fix other minor style issues.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/t4041-diff-submodule-option.sh             |  79 ++++++++-------
 t/t4060-diff-submodule-option-diff-format.sh | 101 +++++++++----------
 2 files changed, 89 insertions(+), 91 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 0c1502d4b0..2aa12243bd 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -42,11 +42,12 @@ commit_file () {
 	git commit "$@" -m "Commit $*" >/dev/null
 }
 
-test_create_repo sm1 &&
-add_file . foo >/dev/null
-
-head1=$(add_file sm1 foo1 foo2)
-fullhead1=$(cd sm1; git rev-parse --verify HEAD)
+test_expect_success 'setup' '
+	test_create_repo sm1 &&
+	add_file . foo &&
+	head1=$(add_file sm1 foo1 foo2) &&
+	fullhead1=$(git -C sm1 rev-parse --verify HEAD)
+'
 
 test_expect_success 'added submodule' '
 	git add sm1 &&
@@ -99,10 +100,9 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 	test_cmp expected actual
 '
 
-commit_file sm1 &&
-head2=$(add_file sm1 foo3)
-
 test_expect_success 'modified submodule(forward)' '
+	commit_file sm1 &&
+	head2=$(add_file sm1 foo3) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -129,8 +129,8 @@ test_expect_success 'modified submodule(forward) --submodule' '
 	test_cmp expected actual
 '
 
-fullhead2=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(forward) --submodule=short' '
+	fullhead2=$(git -C sm1 rev-parse --verify HEAD) &&
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -144,14 +144,14 @@ test_expect_success 'modified submodule(forward) --submodule=short' '
 	test_cmp expected actual
 '
 
-commit_file sm1 &&
-head3=$(
-	cd sm1 &&
-	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --short --verify HEAD
-)
 
 test_expect_success 'modified submodule(backward)' '
+	commit_file sm1 &&
+	head3=$(
+		cd sm1 &&
+		git reset --hard HEAD~2 >/dev/null &&
+		git rev-parse --short --verify HEAD
+	) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -161,8 +161,8 @@ test_expect_success 'modified submodule(backward)' '
 	test_cmp expected actual
 '
 
-head4=$(add_file sm1 foo4 foo5)
 test_expect_success 'modified submodule(backward and forward)' '
+	head4=$(add_file sm1 foo4 foo5) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
@@ -174,13 +174,15 @@ test_expect_success 'modified submodule(backward and forward)' '
 	test_cmp expected actual
 '
 
-commit_file sm1 &&
-mv sm1 sm1-bak &&
-echo sm1 >sm1 &&
-head5=$(git hash-object sm1 | cut -c1-7) &&
-git add sm1 &&
-rm -f sm1 &&
-mv sm1-bak sm1
+test_expect_success 'setup - change sm1 to a blob' '
+	commit_file sm1 &&
+	mv sm1 sm1-bak &&
+	echo sm1 >sm1 &&
+	head5=$(git hash-object sm1 | cut -c1-7) &&
+	git add sm1 &&
+	rm -f sm1 &&
+	mv sm1-bak sm1
+'
 
 test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	git diff --submodule=log --cached >actual &&
@@ -198,6 +200,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 '
 
 test_expect_success 'typechanged submodule(submodule->blob)' '
+	test_when_finished rm -rf sm1 &&
 	git diff --submodule=log >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -212,9 +215,9 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	test_cmp expected actual
 '
 
-rm -rf sm1 &&
-git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' '
+	test_when_finished rm -f sm1 &&
+	git checkout-index sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...0000000 (submodule deleted)
@@ -229,11 +232,10 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	test_cmp expected actual
 '
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
-fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'nonexistent commit' '
+	test_create_repo sm1 &&
+	head6=$(add_file sm1 foo6 foo7) &&
+	fullhead6=$(git -C sm1 rev-parse --verify HEAD) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...$head6 (commits not present)
@@ -241,8 +243,8 @@ test_expect_success 'nonexistent commit' '
 	test_cmp expected actual
 '
 
-commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' '
+	commit_file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -257,8 +259,8 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 	test_cmp expected actual
 '
 
-commit_file sm1 &&
 test_expect_success 'submodule is up to date' '
+	commit_file sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
@@ -313,13 +315,13 @@ test_expect_success 'submodule contains untracked and modified content (dirty ig
 '
 
 test_expect_success 'submodule contains untracked and modified content (all ignored)' '
+	test_when_finished rm -f sm1/new-file &&
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains modified content' '
-	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
@@ -327,9 +329,9 @@ test_expect_success 'submodule contains modified content' '
 	test_cmp expected actual
 '
 
-(cd sm1; git commit -mchange foo6 >/dev/null) &&
-head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 test_expect_success 'submodule is modified' '
+	(cd sm1 && git commit -mchange foo6 >/dev/null) &&
+	head8=$(cd sm1 && git rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head6..$head8:
@@ -406,13 +408,14 @@ test_expect_success 'modified submodule contains untracked and modified content
 '
 
 test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
+	test_when_finished rm -f sm1/new-file &&
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'modified submodule contains modified content' '
-	rm -f sm1/new-file &&
+	test_when_finished rm -rf sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
@@ -422,7 +425,6 @@ test_expect_success 'modified submodule contains modified content' '
 	test_cmp expected actual
 '
 
-rm -rf sm1
 test_expect_success 'deleted submodule' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -454,8 +456,8 @@ test_expect_success 'path filter' '
 	test_cmp expected actual
 '
 
-commit_file sm2
 test_expect_success 'given commit' '
+	commit_file sm2 &&
 	git diff-index -p --submodule=log HEAD^ >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head6...0000000 (submodule deleted)
@@ -473,9 +475,8 @@ test_expect_success 'given commit --submodule' '
 	test_cmp expected actual
 '
 
-fullhead7=$(cd sm2; git rev-parse --verify HEAD)
-
 test_expect_success 'given commit --submodule=short' '
+	fullhead7=$(git -C sm2 rev-parse --verify HEAD) &&
 	git diff-index -p --submodule=short HEAD^ >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 97c6424cd5..a760ed5eb6 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -138,10 +138,9 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 	diff_cmp expected actual
 '
 
-commit_file sm1 &&
-head2=$(add_file sm1 foo3)
-
 test_expect_success 'modified submodule(forward)' '
+	commit_file sm1 &&
+	head2=$(add_file sm1 foo3) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head1..$head2:
@@ -180,8 +179,8 @@ test_expect_success 'modified submodule(forward) --submodule' '
 	diff_cmp expected actual
 '
 
-fullhead2=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'modified submodule(forward) --submodule=short' '
+	fullhead2=$(git -C sm1 rev-parse --verify HEAD) &&
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -195,14 +194,12 @@ test_expect_success 'modified submodule(forward) --submodule=short' '
 	diff_cmp expected actual
 '
 
-commit_file sm1 &&
-head3=$(
-	cd sm1 &&
-	git reset --hard HEAD~2 >/dev/null &&
-	git rev-parse --short --verify HEAD
-)
-
 test_expect_success 'modified submodule(backward)' '
+	commit_file sm1 &&
+	head3=$(
+		git -C sm1 reset --hard HEAD~2 >/dev/null &&
+		git -C sm1 rev-parse --short --verify HEAD
+	) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -224,8 +221,8 @@ test_expect_success 'modified submodule(backward)' '
 	diff_cmp expected actual
 '
 
-head4=$(add_file sm1 foo4 foo5)
 test_expect_success 'modified submodule(backward and forward)' '
+	head4=$(add_file sm1 foo4 foo5) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
@@ -261,13 +258,15 @@ test_expect_success 'modified submodule(backward and forward)' '
 	diff_cmp expected actual
 '
 
-commit_file sm1 &&
-mv sm1 sm1-bak &&
-echo sm1 >sm1 &&
-head5=$(git hash-object sm1 | cut -c1-7) &&
-git add sm1 &&
-rm -f sm1 &&
-mv sm1-bak sm1
+test_expect_success 'setup - change sm1 to a blob' '
+	commit_file sm1 &&
+	mv sm1 sm1-bak &&
+	echo sm1 >sm1 &&
+	head5=$(git hash-object sm1 | cut -c1-7) &&
+	git add sm1 &&
+	rm -f sm1 &&
+	mv sm1-bak sm1
+'
 
 test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	git diff --submodule=diff --cached >actual &&
@@ -306,6 +305,7 @@ test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 '
 
 test_expect_success 'typechanged submodule(submodule->blob)' '
+	test_when_finished rm -rf sm1 &&
 	git diff --submodule=diff >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -341,9 +341,9 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	diff_cmp expected actual
 '
 
-rm -rf sm1 &&
-git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' '
+	test_when_finished rm -f sm1 &&
+	git checkout-index sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...0000000 (submodule deleted)
@@ -358,10 +358,9 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	diff_cmp expected actual
 '
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' '
+	test_create_repo sm1 &&
+	head6=$(add_file sm1 foo6 foo7) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...$head6 (commits not present)
@@ -369,8 +368,8 @@ test_expect_success 'nonexistent commit' '
 	diff_cmp expected actual
 '
 
-commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' '
+	commit_file &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -399,8 +398,8 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 	diff_cmp expected actual
 '
 
-commit_file sm1 &&
 test_expect_success 'submodule is up to date' '
+	commit_file sm1 &&
 	head7=$(git -C sm1 rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
@@ -471,13 +470,13 @@ test_expect_success 'submodule contains untracked and modified content (dirty ig
 '
 
 test_expect_success 'submodule contains untracked and modified content (all ignored)' '
+	test_when_finished rm -f sm1/new-file &&
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'submodule contains modified content' '
-	rm -f sm1/new-file &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
@@ -492,9 +491,9 @@ test_expect_success 'submodule contains modified content' '
 	diff_cmp expected actual
 '
 
-(cd sm1; git commit -mchange foo6 >/dev/null) &&
-head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 test_expect_success 'submodule is modified' '
+	(git -C sm1 commit -mchange foo6 >/dev/null) &&
+	head8=$(git -C sm1 rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7..$head8:
@@ -616,6 +615,7 @@ test_expect_success 'modified submodule contains untracked and modified content
 '
 
 test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
+	test_when_finished rm -f sm1/new-file &&
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
@@ -623,7 +623,7 @@ test_expect_success 'modified submodule contains untracked and modified content
 
 # NOT OK
 test_expect_success 'modified submodule contains modified content' '
-	rm -f sm1/new-file &&
+	test_when_finished rm -rf sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 contains modified content
@@ -643,7 +643,6 @@ test_expect_success 'modified submodule contains modified content' '
 	diff_cmp expected actual
 '
 
-rm -rf sm1
 test_expect_success 'deleted submodule' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -703,13 +702,15 @@ test_expect_success 'path filter' '
 	diff_cmp expected actual
 '
 
-cat >.gitmodules <<-EOF
-[submodule "sm2"]
-	path = sm2
-	url = bogus_url
-EOF
-git add .gitmodules
-commit_file sm2 .gitmodules
+test_expect_success 'setup - construct .gitmodules' '
+	cat >.gitmodules <<-EOF &&
+	[submodule "sm2"]
+		path = sm2
+		url = bogus_url
+	EOF
+	git add .gitmodules &&
+	commit_file sm2 .gitmodules
+'
 
 test_expect_success 'given commit' '
 	git diff-index -p --submodule=diff HEAD^ >actual &&
@@ -779,9 +780,8 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	diff_cmp expected actual
 '
 
-mv sm2 sm2-bak
-
 test_expect_success 'deleted submodule with .git file' '
+	mv sm2 sm2-bak &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
@@ -804,9 +804,9 @@ test_expect_success 'deleted submodule with .git file' '
 	diff_cmp expected actual
 '
 
-echo submodule-to-blob>sm2
-
 test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
+	test_when_finished "rm sm2 && mv sm2-bak sm2" &&
+	echo submodule-to-blob>sm2 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
@@ -836,9 +836,6 @@ test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
 	diff_cmp expected actual
 '
 
-rm sm2
-mv sm2-bak sm2
-
 test_expect_success 'setup nested submodule' '
 	git -c protocol.file.allow=always -C sm2 submodule add ../sm2 nested &&
 	git -C sm2 commit -a -m "nested sub" &&
@@ -910,13 +907,11 @@ test_expect_success 'diff --submodule=diff recurses into nested submodules' '
 	diff_cmp expected actual
 '
 
-(cd sm2; commit_file nested)
-commit_file sm2
-head12=$(cd sm2; git rev-parse --short --verify HEAD)
-
-mv sm2 sm2-bak
-
 test_expect_success 'diff --submodule=diff recurses into deleted nested submodules' '
+	(cd sm2 && commit_file nested) &&
+	commit_file sm2 &&
+	head12=$(git -C sm2 rev-parse --short --verify HEAD) &&
+	mv sm2 sm2-bak &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
 	Submodule sm2 $head12...0000000 (submodule deleted)
@@ -971,6 +966,8 @@ test_expect_success 'diff --submodule=diff recurses into deleted nested submodul
 	diff_cmp expected actual
 '
 
-mv sm2-bak sm2
+test_expect_success 'submodule cleanup' '
+	mv sm2-bak sm2
+'
 
 test_done
-- 
2.39.2.722.g9855ee24e9-goog

