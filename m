Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F36C33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4D6214AF
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHKBUB+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgANT0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:09 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52350 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgANT0I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:08 -0500
Received: by mail-wm1-f54.google.com with SMTP id p9so15215698wmc.2
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ltgTd1G5JELbEev3dXk1XKzh1boQBhIZMp3yIYfjkPE=;
        b=DHKBUB+YPWmVbYHxepP0BR+rezQcTcLL8d01DOfPs9Ydf0elDbh6Sur4Hf7EmWpcqb
         RyR+Ew1A5b61dG+4buqwgG4/FYAiA9K1V9YLG9n3YlmLdlX3uXQ5V0AbGBkqQFSjKmUb
         guz5tkjWWoZkjQoyV61tiUVFlEEw2axGXgVp6kx2S56AqTd9D8eTxIXpBKfmPhfUJCo1
         Z/vM7sipy8MCNpkHj9lmxdAmJWErPTasaQC1SDqvfaNWtS3d9quvq9JcQej10ykwgfru
         Naf6ALRj0rKzZEy87nt381mIPu9oYAu1A3X2WPydE3fYE5Yt/YqFQjVi6Rj4y3UESQqq
         JKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ltgTd1G5JELbEev3dXk1XKzh1boQBhIZMp3yIYfjkPE=;
        b=uNs/0wnhX0CCxVIS1Q8s0EFRmOEu/fDfucVqw+MVFZXeh91F85vih1LCgyiqdwRVHb
         XS8Bd8J0nGgOpAgX9MHNXrt/AtNK9VPGmAwjQyeRiUmjcSfR8K2XJJ64K2mWwTqmszaQ
         SRWP8jrog+NcYmPjpGc5euOqf1zWbLeEhzr592dN2kkvCV359rwc/FlHJ13KiKJ9HoSJ
         9ZzsjZY7NKxKX0ga4wQHnOMU2QfIGKLduTEcXUoGTTQrM8ikTQBujOu1Zb6iGNspevr9
         jfsokum7GD52iRExANkcgY9vmNd3ElMrkV9kx0EXn7yAWIOJDx1IjZt5HeFPCA0JoZwj
         sA+g==
X-Gm-Message-State: APjAAAUsnDL9rag5EwXvJHJO0UJs6VQ2hygD4dAAvT8pLRP+iJ/ifnrn
        QQLwPm+JO0x+rm9LaKxKDWTzC+JM
X-Google-Smtp-Source: APXvYqwLC40PPJu8CLX9QinhMtHl2LHkIB47X6BmJpcOgqZRolyU/j3mfgb20IjPRunP/HlSxavqcg==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr30240313wmb.137.1579029965002;
        Tue, 14 Jan 2020 11:26:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm1172925wmd.2.2020.01.14.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:04 -0800 (PST)
Message-Id: <9f7791ae5ee8df9d84d25407a014fb2c63e09b38.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:25:55 +0000
Subject: [PATCH 1/8] t1091: use check_files to reduce boilerplate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When testing the sparse-checkout feature, we need to compare the
contents of the working-directory against some expected output.
Using here-docs was useful in the beginning, but became repetetive
as the test script grew.

Create a check_files helper to make the tests simpler and easier
to extend. It also reduces instances of bad here-doc whitespace.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 215 ++++++++++-------------------
 1 file changed, 71 insertions(+), 144 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ff7f8f7a1f..20caefe155 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -12,6 +12,13 @@ list_files() {
 	(cd "$1" && printf '%s\n' *)
 }
 
+check_files() {
+	DIR=$1
+	printf "%s\n" $2 >expect &&
+	list_files $DIR >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'setup' '
 	git init repo &&
 	(
@@ -39,11 +46,11 @@ test_expect_success 'git sparse-checkout list (empty)' '
 
 test_expect_success 'git sparse-checkout list (populated)' '
 	test_when_finished rm -f repo/.git/info/sparse-checkout &&
-	cat >repo/.git/info/sparse-checkout <<-EOF &&
-		/folder1/*
-		/deep/
-		**/a
-		!*bin*
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/folder1/*
+	/deep/
+	**/a
+	!*bin*
 	EOF
 	cp repo/.git/info/sparse-checkout expect &&
 	git -C repo sparse-checkout list >list &&
@@ -52,22 +59,20 @@ test_expect_success 'git sparse-checkout list (populated)' '
 
 test_expect_success 'git sparse-checkout init' '
 	git -C repo sparse-checkout init &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	test_cmp_config -C repo true core.sparsecheckout &&
-	list_files repo >dir  &&
-	echo a >expect &&
-	test_cmp expect dir
+	check_files repo a
 '
 
 test_expect_success 'git sparse-checkout list after init' '
 	git -C repo sparse-checkout list >actual &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
 	EOF
 	test_cmp expect actual
 '
@@ -75,32 +80,24 @@ test_expect_success 'git sparse-checkout list after init' '
 test_expect_success 'init with existing sparse-checkout' '
 	echo "*folder*" >> repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		*folder*
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	*folder*
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	list_files repo >dir  &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files repo "a folder1 folder2"
 '
 
 test_expect_success 'clone --sparse' '
 	git clone --sparse repo clone &&
 	git -C clone sparse-checkout list >actual &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
 	EOF
 	test_cmp expect actual &&
-	list_files clone >dir &&
-	echo a >expect &&
-	test_cmp expect dir
+	check_files clone a
 '
 
 test_expect_success 'set enables config' '
@@ -119,41 +116,29 @@ test_expect_success 'set enables config' '
 
 test_expect_success 'set sparse-checkout using builtin' '
 	git -C repo sparse-checkout set "/*" "!/*/" "*folder*" &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		*folder*
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	*folder*
 	EOF
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	list_files repo >dir  &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files repo "a folder1 folder2"
 '
 
 test_expect_success 'set sparse-checkout using --stdin' '
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/folder1/
-		/folder2/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/folder1/
+	/folder2/
 	EOF
 	git -C repo sparse-checkout set --stdin <expect &&
 	git -C repo sparse-checkout list >actual &&
 	test_cmp expect actual &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	list_files repo >dir  &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files repo "a folder1 folder2"
 '
 
 test_expect_success 'cone mode: match patterns' '
@@ -162,13 +147,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo read-tree -mu HEAD 2>err &&
 	test_i18ngrep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
-	list_files repo >dir  &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files repo "a folder1 folder2"
 '
 
 test_expect_success 'cone mode: warn on bad pattern' '
@@ -185,14 +164,7 @@ test_expect_success 'sparse-checkout disable' '
 	test_path_is_file repo/.git/info/sparse-checkout &&
 	git -C repo config --list >config &&
 	test_must_fail git config core.sparseCheckout &&
-	list_files repo >dir &&
-	cat >expect <<-EOF &&
-		a
-		deep
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files repo "a deep folder1 folder2"
 '
 
 test_expect_success 'cone mode: init and set' '
@@ -204,52 +176,31 @@ test_expect_success 'cone mode: init and set' '
 	test_cmp expect dir &&
 	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
 	test_must_be_empty err &&
-	list_files repo >dir  &&
-	cat >expect <<-EOF &&
-		a
-		deep
-	EOF
-	test_cmp expect dir &&
-	list_files repo/deep >dir  &&
-	cat >expect <<-EOF &&
-		a
-		deeper1
-	EOF
-	test_cmp expect dir &&
-	list_files repo/deep/deeper1 >dir  &&
-	cat >expect <<-EOF &&
-		a
-		deepest
-	EOF
-	test_cmp expect dir &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/deep/
-		!/deep/*/
-		/deep/deeper1/
-		!/deep/deeper1/*/
-		/deep/deeper1/deepest/
+	check_files repo "a deep" &&
+	check_files repo/deep "a deeper1" &&
+	check_files repo/deep/deeper1 "a deepest" &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	!/deep/*/
+	/deep/deeper1/
+	!/deep/deeper1/*/
+	/deep/deeper1/deepest/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	git -C repo sparse-checkout set --stdin 2>err <<-EOF &&
-		folder1
-		folder2
+	git -C repo sparse-checkout set --stdin 2>err <<-\EOF &&
+	folder1
+	folder2
 	EOF
 	test_must_be_empty err &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	list_files repo >dir &&
-	test_cmp expect dir
+	check_files repo "a folder1 folder2"
 '
 
 test_expect_success 'cone mode: list' '
-	cat >expect <<-EOF &&
-		folder1
-		folder2
+	cat >expect <<-\EOF &&
+	folder1
+	folder2
 	EOF
 	git -C repo sparse-checkout set --stdin <expect &&
 	git -C repo sparse-checkout list >actual 2>err &&
@@ -260,10 +211,10 @@ test_expect_success 'cone mode: list' '
 test_expect_success 'cone mode: set with nested folders' '
 	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
 	test_line_count = 0 err &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/deep/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
 	EOF
 	test_cmp repo/.git/info/sparse-checkout expect
 '
@@ -275,13 +226,7 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
 	test_i18ngrep "cannot set sparse-checkout patterns" err &&
 	test_cmp repo/.git/info/sparse-checkout expect &&
-	list_files repo/deep >dir &&
-	cat >expect <<-EOF &&
-		a
-		deeper1
-		deeper2
-	EOF
-	test_cmp dir expect
+	check_files repo/deep "a deeper1 deeper2"
 '
 
 test_expect_success 'revert to old sparse-checkout on empty update' '
@@ -326,18 +271,13 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
-	cat >expect <<-EOF &&
-		/*
-		!/*/
-		/folder1/
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/folder1/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	list_files repo >dir &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-	EOF
-	test_cmp expect dir
+	check_files repo "a folder1"
 '
 
 test_expect_success 'interaction with submodules' '
@@ -351,21 +291,8 @@ test_expect_success 'interaction with submodules' '
 		git sparse-checkout init --cone &&
 		git sparse-checkout set folder1
 	) &&
-	list_files super >dir &&
-	cat >expect <<-\EOF &&
-		a
-		folder1
-		modules
-	EOF
-	test_cmp expect dir &&
-	list_files super/modules/child >dir &&
-	cat >expect <<-\EOF &&
-		a
-		deep
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files super "a folder1 modules" &&
+	check_files super/modules/child "a deep folder1 folder2"
 '
 
 test_done
-- 
gitgitgadget

