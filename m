Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A93C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBMSWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjBMSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:22:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140D1A96E
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u18-20020a62ed12000000b00593cc641da4so6593235pfh.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3pAvTQVWuv+/Z8mP2TbPKDUkmBy5TW9DXOvSb/zWsYc=;
        b=cUVgrKjh9A9W0g94C84aaz9EN21aMVnf9l7gRc4fWHFL7AyaaY7vrZvSD6oV1lu8Xn
         /7N2mVZJmIyyliEWN1+3FvdLO4Ui1RddIfVPANYZpjEDZ7B80RFTWFVBWNt3o2sf1WCU
         SSCuLvVxnT2TXEkC6j3+8E7x/pPdtctNiZl7vG8I+7Inqu/5vglpeGpjK7QVJ0kkOs58
         ddeKZJTFyJ6jI7swkxY4KaIT9l3PAZuOwCDD4GYEbZoz2SH4W+VLz4q+SYTO6O9+gGoq
         QWlpoiAduUbNAhASxzcj0Q+kICSel9YsLpPEIdgjVeIxZtaMW0Zrr/eaRkqZyQXsxZE7
         ciKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pAvTQVWuv+/Z8mP2TbPKDUkmBy5TW9DXOvSb/zWsYc=;
        b=br2bm8uv84rCcqqR6qkf2ZcaPk6skqQG/DBs3EAryLZtoYodMBgvxcOEmmpJVcGvqz
         si0eyJdhsKdexdYYzg46CQhDN1saMM025nFkG+rAmR352J6l6MdXg6HEC593dFzCkGge
         8FYX2eVJvNQwwAn5OCA/GgRSktvUJmAgwxl3xczF7yHGHr/zISsD+YCRrm/GGMdPmkFi
         pm+JH9E2KhWLGrgqfP9P3kHYmOHxFY6C7ptVZbIATi8QveGrZGCG77yPxpT89UablT8Y
         VuNQLTVz/oPO2gztaHbsdgdGRDKEpwKAJDuVopTqb+9GqE4XOwkrsSOJ5Kn5J941+evO
         GErw==
X-Gm-Message-State: AO0yUKXE52eux5z93kFKtZvfOFeTCBtUdkHVyW7EfsnMUiYP9MdhVBc4
        sfUhw+whOkvV/4s84CHSwLsL4pBs4R52FdmINR5riF/7K4g3hPDUH8vS98w+ahOJggP+eOwhH4y
        UlkimGrWPelMjcO3gCYZ4otMdrrq5H+njSRXeQE/PWxiGw8zH9q98d95iOKSMMJiFhw==
X-Google-Smtp-Source: AK7set+R8/T77/Rhy5DhstWdw/gDGgY+LcYC7MRrxuXqSdscUJcwl44J8I6aB9vzxGkL7UTcXjlXsLmD6ZObDeU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:51c3:b0:233:af25:85f6 with SMTP
 id u61-20020a17090a51c300b00233af2585f6mr301359pjh.1.1676312521338; Mon, 13
 Feb 2023 10:22:01 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:30 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-3-calvinwan@google.com>
Subject: [RFC PATCH 2/6] t4041, t4060: modernize test style
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
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

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/t4041-diff-submodule-option.sh             | 75 +++++++--------
 t/t4060-diff-submodule-option-diff-format.sh | 99 ++++++++++----------
 2 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 0c1502d4b0..556682b18b 100755
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
+	add_file . foo >/dev/null &&
+	head1=$(add_file sm1 foo1 foo2) &&
+	fullhead1=$(cd sm1 && git rev-parse --verify HEAD)
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
+	fullhead2=$(cd sm1 && git rev-parse --verify HEAD) &&
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
@@ -212,9 +214,9 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	test_cmp expected actual
 '
 
-rm -rf sm1 &&
-git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' '
+	rm -rf sm1 &&
+	git checkout-index sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...0000000 (submodule deleted)
@@ -229,11 +231,11 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	test_cmp expected actual
 '
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
-fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'nonexistent commit' '
+	rm -f sm1 &&
+	test_create_repo sm1 &&
+	head6=$(add_file sm1 foo6 foo7) &&
+	fullhead6=$(cd sm1 && git rev-parse --verify HEAD) &&
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
@@ -422,8 +424,8 @@ test_expect_success 'modified submodule contains modified content' '
 	test_cmp expected actual
 '
 
-rm -rf sm1
 test_expect_success 'deleted submodule' '
+	rm -rf sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head6...0000000 (submodule deleted)
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
+	fullhead7=$(cd sm2 && git rev-parse --verify HEAD) &&
 	git diff-index -p --submodule=short HEAD^ >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 97c6424cd5..3cda8ffd14 100755
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
+	fullhead2=$(cd sm1 && git rev-parse --verify HEAD) &&
 	git diff --submodule=short >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -195,14 +194,13 @@ test_expect_success 'modified submodule(forward) --submodule=short' '
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
+		cd sm1 &&
+		git reset --hard HEAD~2 >/dev/null &&
+		git rev-parse --short --verify HEAD
+	) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2..$head3 (rewind):
@@ -224,8 +222,8 @@ test_expect_success 'modified submodule(backward)' '
 	diff_cmp expected actual
 '
 
-head4=$(add_file sm1 foo4 foo5)
 test_expect_success 'modified submodule(backward and forward)' '
+	head4=$(add_file sm1 foo4 foo5) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head2...$head4:
@@ -261,13 +259,15 @@ test_expect_success 'modified submodule(backward and forward)' '
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
@@ -341,9 +341,9 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	diff_cmp expected actual
 '
 
-rm -rf sm1 &&
-git checkout-index sm1
 test_expect_success 'typechanged submodule(submodule->blob)' '
+	rm -rf sm1 &&
+	git checkout-index sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...0000000 (submodule deleted)
@@ -358,10 +358,10 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	diff_cmp expected actual
 '
 
-rm -f sm1 &&
-test_create_repo sm1 &&
-head6=$(add_file sm1 foo6 foo7)
 test_expect_success 'nonexistent commit' '
+	rm -f sm1 &&
+	test_create_repo sm1 &&
+	head6=$(add_file sm1 foo6 foo7) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head4...$head6 (commits not present)
@@ -369,8 +369,8 @@ test_expect_success 'nonexistent commit' '
 	diff_cmp expected actual
 '
 
-commit_file
 test_expect_success 'typechanged submodule(blob->submodule)' '
+	commit_file &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/sm1 b/sm1
@@ -399,8 +399,8 @@ test_expect_success 'typechanged submodule(blob->submodule)' '
 	diff_cmp expected actual
 '
 
-commit_file sm1 &&
 test_expect_success 'submodule is up to date' '
+	commit_file sm1 &&
 	head7=$(git -C sm1 rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	test_must_be_empty actual
@@ -492,9 +492,9 @@ test_expect_success 'submodule contains modified content' '
 	diff_cmp expected actual
 '
 
-(cd sm1; git commit -mchange foo6 >/dev/null) &&
-head8=$(cd sm1; git rev-parse --short --verify HEAD) &&
 test_expect_success 'submodule is modified' '
+	(cd sm1 && git commit -mchange foo6 >/dev/null) &&
+	head8=$(cd sm1 && git rev-parse --short --verify HEAD) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7..$head8:
@@ -643,8 +643,8 @@ test_expect_success 'modified submodule contains modified content' '
 	diff_cmp expected actual
 '
 
-rm -rf sm1
 test_expect_success 'deleted submodule' '
+	rm -rf sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
@@ -703,13 +703,15 @@ test_expect_success 'path filter' '
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
@@ -779,9 +781,8 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	diff_cmp expected actual
 '
 
-mv sm2 sm2-bak
-
 test_expect_success 'deleted submodule with .git file' '
+	mv sm2 sm2-bak &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
@@ -804,9 +805,8 @@ test_expect_success 'deleted submodule with .git file' '
 	diff_cmp expected actual
 '
 
-echo submodule-to-blob>sm2
-
 test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
+	echo submodule-to-blob>sm2 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
@@ -836,10 +836,9 @@ test_expect_success 'typechanged(submodule->blob) submodule with .git file' '
 	diff_cmp expected actual
 '
 
-rm sm2
-mv sm2-bak sm2
-
 test_expect_success 'setup nested submodule' '
+	rm sm2 &&
+	mv sm2-bak sm2 &&
 	git -c protocol.file.allow=always -C sm2 submodule add ../sm2 nested &&
 	git -C sm2 commit -a -m "nested sub" &&
 	head10=$(git -C sm2 rev-parse --short --verify HEAD)
@@ -910,13 +909,11 @@ test_expect_success 'diff --submodule=diff recurses into nested submodules' '
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
+	head12=$(cd sm2 && git rev-parse --short --verify HEAD) &&
+	mv sm2 sm2-bak &&
 	cat >expected <<-EOF &&
 	Submodule sm1 $head7...0000000 (submodule deleted)
 	Submodule sm2 $head12...0000000 (submodule deleted)
@@ -971,6 +968,8 @@ test_expect_success 'diff --submodule=diff recurses into deleted nested submodul
 	diff_cmp expected actual
 '
 
-mv sm2-bak sm2
+test_expect_success 'submodule cleanup' '
+	mv sm2-bak sm2
+'
 
 test_done
-- 
2.39.1.581.gbfd45094c4-goog

