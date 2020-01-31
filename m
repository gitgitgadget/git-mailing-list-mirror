Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C9AC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85411214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEkfu3Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgAaUQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUQT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so10081107wrx.12
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PI7rAlWOADZX5nz+QBMgC5QO55bbe9huYYeZY+alby4=;
        b=fEkfu3Q/OvrAEoEI4zZjqJGGmuhPTNneXloKL3yC5xABZ4hnRe0xBCmQVoN64NxXWE
         Bhd1v2lg/UJhQHV1qm436sAOuQZKi58gSIZke5u8EFqwOV312LmWpwdiVduTLIGM/MMq
         eOhSDG2NQ73FAxBJ5g5SJRvP/O0GQc7x26R+rUFmfEwR4HIt8DI8EGsfXNMXPyANgDCE
         fyipqO2zwqxvNtf7BCiT3IkQtILZnw1V4WniRLSrYvt2TMukLd9VZKh8xBYOeYENj/1A
         TghKj9BuOK/+J9Nop3Yt84IoIzob2lcxpr7SXGh09ZiBoeEotwpTAWye1oZUQX3h1tJo
         BQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PI7rAlWOADZX5nz+QBMgC5QO55bbe9huYYeZY+alby4=;
        b=oWyNN97ebAFoO/gEPFua45ze3GrZOH+oexhdK6v3kUrkBmOc6Ykg5phR1SrbqwS0XW
         GJ45dQPLbDMreqclIpkLUcB5YmaJZEPJ6jGkFyTUVptSITUAlhwlw3ih+poHTU9tvgH+
         Zb/YhoXH6egANzN1mZu24vhkaUjcd4QEEbmaKhzjuXu5A8ws2ei23jkY590ypqkXBEEt
         IvZD7I8v+sfm31crehbcjPgXqAfn8WKsg9HwtrMVZrCsN0ekQt03flicpYZgoOXy9l0T
         TRfrtwN8NAUZ38uEtmcu9Dt4ge66xDyIFRo9GJGbs6ZZHbqNN5mHHLj+BVw4+TUkbWgl
         arcA==
X-Gm-Message-State: APjAAAX+na3tJSWSuD7XqRtYmS9k7F+vFA145jPSw0SNvpiVlpUKLQ5f
        EFaNPZ8MOpopdrGL0Fb6T7IGO0ak
X-Google-Smtp-Source: APXvYqz6g4CpZPsCSjyaVVFOUYvK0Fgk2ep1iyXWkg2SLV+n0wDTIU8Pnyj7jLWvz7lecqgsov8Fkw==
X-Received: by 2002:adf:ee43:: with SMTP id w3mr112068wro.339.1580501777146;
        Fri, 31 Jan 2020 12:16:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm13445209wrs.53.2020.01.31.12.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:16 -0800 (PST)
Message-Id: <1cc825412f0f2b66f7b89ed5ce33bcda937f4ee6.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:01 +0000
Subject: [PATCH v4 01/15] t1091: use check_files to reduce boilerplate
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
 t/t1091-sparse-checkout-builtin.sh | 117 ++++++-----------------------
 1 file changed, 22 insertions(+), 95 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ff7f8f7a1f..e058a20ad6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -12,6 +12,13 @@ list_files() {
 	(cd "$1" && printf '%s\n' *)
 }
 
+check_files() {
+	list_files "$1" >actual &&
+	shift &&
+	printf "%s\n" $@ >expect &&
+	test_cmp expect actual
+}
+
 test_expect_success 'setup' '
 	git init repo &&
 	(
@@ -58,9 +65,7 @@ test_expect_success 'git sparse-checkout init' '
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	test_cmp_config -C repo true core.sparsecheckout &&
-	list_files repo >dir  &&
-	echo a >expect &&
-	test_cmp expect dir
+	check_files repo a
 '
 
 test_expect_success 'git sparse-checkout list after init' '
@@ -81,13 +86,7 @@ test_expect_success 'init with existing sparse-checkout' '
 		*folder*
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	list_files repo >dir  &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	test_cmp expect dir
+	check_files repo a folder1 folder2
 '
 
 test_expect_success 'clone --sparse' '
@@ -98,9 +97,7 @@ test_expect_success 'clone --sparse' '
 		!/*/
 	EOF
 	test_cmp expect actual &&
-	list_files clone >dir &&
-	echo a >expect &&
-	test_cmp expect dir
+	check_files clone a
 '
 
 test_expect_success 'set enables config' '
@@ -127,13 +124,7 @@ test_expect_success 'set sparse-checkout using builtin' '
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
+	check_files repo a folder1 folder2
 '
 
 test_expect_success 'set sparse-checkout using --stdin' '
@@ -147,13 +138,7 @@ test_expect_success 'set sparse-checkout using --stdin' '
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
+	check_files repo a folder1 folder2
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
+	check_files repo a deep folder1 folder2
 '
 
 test_expect_success 'cone mode: init and set' '
@@ -204,24 +176,9 @@ test_expect_success 'cone mode: init and set' '
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
+	check_files repo a deep &&
+	check_files repo/deep a deeper1 &&
+	check_files repo/deep/deeper1 a deepest &&
 	cat >expect <<-EOF &&
 		/*
 		!/*/
@@ -237,13 +194,7 @@ test_expect_success 'cone mode: init and set' '
 		folder2
 	EOF
 	test_must_be_empty err &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-		folder2
-	EOF
-	list_files repo >dir &&
-	test_cmp expect dir
+	check_files repo a folder1 folder2
 '
 
 test_expect_success 'cone mode: list' '
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
+	check_files repo/deep a deeper1 deeper2
 '
 
 test_expect_success 'revert to old sparse-checkout on empty update' '
@@ -332,12 +277,7 @@ test_expect_success 'cone mode: set with core.ignoreCase=true' '
 		/folder1/
 	EOF
 	test_cmp expect repo/.git/info/sparse-checkout &&
-	list_files repo >dir &&
-	cat >expect <<-EOF &&
-		a
-		folder1
-	EOF
-	test_cmp expect dir
+	check_files repo a folder1
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
+	check_files super a folder1 modules &&
+	check_files super/modules/child a deep folder1 folder2
 '
 
 test_done
-- 
gitgitgadget

