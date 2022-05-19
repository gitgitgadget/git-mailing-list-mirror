Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34743C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243436AbiESRxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243390AbiESRx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF8DE9
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so8270152wrg.3
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U5UspuwgHVBqo7FpE1+kOE+FRDR7ixKr1UpHpeCL9Ig=;
        b=UsVPTu4qeF/T3ZAkVrk/XhZcXkCtH/OYL4tve9qpEQTkYVI+/tuAe0w6Oiv2f3O24T
         5vz+ILYbirgUx6moSDBTYowKQphr6NMamwjxlIzGR9OEmX+NQ97IBLyBov+Z+IpyoONo
         QNua4Sy+O7cBCLzWtUw+FjTM20BoH4QS1Ml+Lzx9l3wYc9eh80r24ozWkcz13OST1qD7
         NKqr9rknl/PP/ILY0yKRxsINutz/kPqLReZpE8FeX8Gr/JYWPHWx4wflqOPmQxGD7U/z
         j4EzyeApU8A4PvOMr/Yj1i0YV3xEGgE1vTgYAvnWx+Dy/Fp0fRCrI/BFtRiMKhJt8FYo
         pRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U5UspuwgHVBqo7FpE1+kOE+FRDR7ixKr1UpHpeCL9Ig=;
        b=BuEa0BWDew4cJaq+X9rQzLG7gcNbXkN6ZkOHg653oY4VOX6klrHFBRQXfReiSVbi/K
         gcKWiBcDDLm0pKYLXfr3Ig8a6r3f9xbJIhpKhL3AG2SXeA7HdWIE+qochBanUvslql+W
         WjG2tTakss1dDnxQpA5SDX0GF5mH4ydvhIM8mz9/cnQBdliCdbchu2obf8+M+OSXtLVV
         0uwBexWU8dgUJZQ0FhfW5Ni29TKzpULRA6mFHjQ7uLRJ+nUR19NJ/7QoFiJ60JY59fQw
         +6KGOkMicCAPK4QOcM+h8176ofGu6Vje/YSUkrkxLYhA8AQCle7LaD1GHmjQI4mnigaH
         jO8w==
X-Gm-Message-State: AOAM5334pZ9QfzdouT6ZosrmWUAmxrJ1PyTsZgiCogSfxbk74GeFN+ED
        7Akh2kkE26ubczoRgjJVCPmPPqd8PH0=
X-Google-Smtp-Source: ABdhPJwhnfnJhePMepN1UtQU7FXmYeYgHitpCOdszmJ9LulCCm2EdMX+jVkgOiUTkS4w2UWTsOLUJg==
X-Received: by 2002:a05:6000:1842:b0:20d:2834:765e with SMTP id c2-20020a056000184200b0020d2834765emr4972513wri.599.1652982762568;
        Thu, 19 May 2022 10:52:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n128-20020a1c2786000000b003942a244f50sm106083wmn.41.2022.05.19.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:42 -0700 (PDT)
Message-Id: <5030eeecf4f8e2dd65bc055d6a720c7d67015b1e.1652982758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:30 +0000
Subject: [PATCH v2 02/10] t1092: stress test 'git sparse-checkout set'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'sparse-index contents' test checks that the sparse index has the
correct set of sparse directories in the index after modifying the cone
mode patterns using 'git sparse-checkout set'. Add to the coverage here
by adding more complicated scenarios that were not previously tested.

In order to check paths that do not exist at HEAD, we need to modify the
test_sparse_checkout_set helper slightly:

1. Add the --skip-checks argument to the 'set' command to avoid failures
   when passing paths that do not exist at HEAD.

2. When looking for the non-existence of sparse directories for the
   paths in $CONE_DIRS, allow the rev-list command to fail because the
   path does not exist at HEAD.

This allows us to add some interesting test cases.

Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index e7c0ae9b953..785820f9fd5 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -212,7 +212,7 @@ test_sparse_unstaged () {
 test_sparse_checkout_set () {
 	CONE_DIRS=$1 &&
 	SPARSE_DIRS=$2 &&
-	git -C sparse-index sparse-checkout set $CONE_DIRS &&
+	git -C sparse-index sparse-checkout set --skip-checks $CONE_DIRS &&
 	git -C sparse-index ls-files --sparse --stage >cache &&
 
 	# Check that the directories outside of the sparse-checkout cone
@@ -228,7 +228,9 @@ test_sparse_checkout_set () {
 	# are not sparse directory entries.
 	for dir in $CONE_DIRS
 	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
+		# Allow TREE to not exist because
+		# $dir does not exist at HEAD.
+		TREE=$(git -C sparse-index rev-parse HEAD:$dir) ||
 		! grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done
@@ -253,6 +255,19 @@ test_expect_success 'sparse-index contents' '
 		"deep/deeper2 folder1 folder2 x" \
 		"before deep/deeper1" &&
 
+	# Replace deep/deeper2 with deep/deeper1
+	# Replace folder1 with folder1/0/0
+	# Replace folder2 with non-existent folder2/2/3
+	# Add non-existent "bogus"
+	test_sparse_checkout_set \
+		"bogus deep/deeper1 folder1/0/0 folder2/2/3 x" \
+		"before deep/deeper2 folder2/0" &&
+
+	# Drop down to only files at root
+	test_sparse_checkout_set \
+		"" \
+		"before deep folder1 folder2 x" &&
+
 	# Disabling the sparse-index replaces tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
 	test_sparse_match git ls-files --stage --sparse
-- 
gitgitgadget

