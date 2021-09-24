Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F57C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFD961241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347231AbhIXPk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347183AbhIXPku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82471C061613
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so28619154wrc.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yVuKsZPqLiD2f7SnVIfjQHCr8IGVg+GERk3ix01BkMo=;
        b=GL+EQdJRyBURTalQy+3UUI+Cfe/XS9hae9zvxRE5SlrtBPQ/IvdAiw/zEdU+vACRgd
         Plxzu+EiRLUg2v3tPD3RIw36JTgiOqC/X8mMYncqj5/pAf1WxoYB2lrxCtS3av5Lf8zq
         rF3s7cLE3JkH0dRGjyt4UmNtYR1Tli2LIH2SZeSsxuc1jtTbWCu/I/hh00ewVtErKHJs
         R2X4mqhgPRhYWv64NNiqzh3tLQNcA5vbUOBTMskAW783PPK9VveYNouf0BWdONlVpYEq
         08Ai0vvafSZcnAU6m/wrMncYOL6wn0X0YWwtJAt1dVZ77mghwZcdf9wWTiHb6LYQEW75
         no4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yVuKsZPqLiD2f7SnVIfjQHCr8IGVg+GERk3ix01BkMo=;
        b=PCT1LTM78LVznh5Gzqm1KeumT/9MXiDJy3BhDUCFurEpZwrR+LGARNG8cJhSvua02M
         R7oCOOIlA6PCFRVEiMoGVFiq+kpWDPGdE+LFUiqdJdult7nJw948wz0EWBQY90/+AyJD
         YY2owKec0VfzvLNP1Ao1gtFxTp/+kFV1KwKPF5ABEw5cDfXESPrz9+4JQK6m3MXzAi4F
         sEfxIskEcm7vz+hz5MIK1YZ/Z7KqnKKYF0YIr9FLOaLDFfHWrkoWp1byccBlm9dg0ktt
         PIz+v1qR5bkooAI8YOOnwqWu43qZrdrEEwj5fABEN/Zl6weE2dCxOd379TIiTQqxW+Vl
         oR3g==
X-Gm-Message-State: AOAM531vOdY6m1qoQrnh43G4ZeazNpiM3hInZIWRVV37OnUFYsKGR6+s
        t4j1G3MCQ0PyfP8tI2XOYRlalyAnduI=
X-Google-Smtp-Source: ABdhPJwBDYyX8hHJCWP0PvLkssIffMkO0ujt+qAW6gAo+BK6SnvWBX5G26GUhJ4++O9VWmdXOBNJsw==
X-Received: by 2002:adf:9d47:: with SMTP id o7mr12436207wre.50.1632497956084;
        Fri, 24 Sep 2021 08:39:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o26sm12648652wmc.17.2021.09.24.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:15 -0700 (PDT)
Message-Id: <642b05fc0204f2f9f655afd13695f22d30c2fc83.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:02 +0000
Subject: [PATCH v4 01/13] t3705: test that 'sparse_entry' is unstaged
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
behaves with paths outside the sparse-checkout definition. These
currently check to see if a given warning is present but not that the
index is not updated with the sparse entries. Add a new
'test_sparse_entry_unstaged' helper to be sure 'git add' is behaving
correctly.

We need to modify setup_sparse_entry to actually commit the sparse_entry
file so it exists at HEAD and as an entry in the index, but its exact
contents are not staged in the index.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3705-add-sparse-checkout.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2b1fd0d0eef..b2d798662ee 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -19,6 +19,7 @@ setup_sparse_entry () {
 	fi &&
 	git add sparse_entry &&
 	git update-index --skip-worktree sparse_entry &&
+	git commit --allow-empty -m "ensure sparse_entry exists at HEAD" &&
 	SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
 }
 
@@ -36,6 +37,11 @@ setup_gitignore () {
 	EOF
 }
 
+test_sparse_entry_unstaged () {
+	git diff --staged -- sparse_entry >diff &&
+	test_must_be_empty diff
+}
+
 test_expect_success 'setup' "
 	cat >sparse_error_header <<-EOF &&
 	The following pathspecs didn't match any eligible path, but they do match index
@@ -55,6 +61,7 @@ test_expect_success 'git add does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	test_must_fail git add sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -73,6 +80,7 @@ test_expect_success 'git add . does not remove sparse entries' '
 	rm sparse_entry &&
 	setup_gitignore &&
 	test_must_fail git add . 2>stderr &&
+	test_sparse_entry_unstaged &&
 
 	cat sparse_error_header >expect &&
 	echo . >>expect &&
@@ -88,6 +96,7 @@ do
 		setup_sparse_entry &&
 		echo modified >sparse_entry &&
 		test_must_fail git add $opt sparse_entry 2>stderr &&
+		test_sparse_entry_unstaged &&
 		test_cmp error_and_hint stderr &&
 		test_sparse_entry_unchanged
 	'
@@ -98,6 +107,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	git ls-files --debug sparse_entry | grep mtime >before &&
 	test-tool chmtime -60 sparse_entry &&
 	test_must_fail git add --refresh sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	git ls-files --debug sparse_entry | grep mtime >after &&
 	test_cmp before after
@@ -106,6 +116,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
 	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged &&
 	! test -x sparse_entry
@@ -116,6 +127,7 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
 	test_must_fail git add --renormalize sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -124,6 +136,7 @@ test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -148,6 +161,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 test_expect_success 'add obeys advice.updateSparsePath' '
 	setup_sparse_entry &&
 	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp sparse_entry_error stderr
 
 '
-- 
gitgitgadget

