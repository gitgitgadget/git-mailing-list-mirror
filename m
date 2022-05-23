Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA835C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiEWNtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiEWNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:48:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE0B562E4
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t13so2291673wrg.9
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JOe9/xcyWlPygpRg9fHBknYEcVKDUlk3pocQHkD5gJA=;
        b=bjzoY5WcaQ7pZ8haSh07AlSkLv/C8K8jfGGtW788VML6QKESZnyJR8lgJQp6yymHJB
         g5kCY5LYDb72vJen4/P+k2SCc+K/aZwtWhBJoFwOVKEf778cg9FY3LJYj8zN7kEP8qwV
         TY7CgLRf79KQs6qrCe3eXN5K7MDzweH69gSgVqKhk8/vN4wKe5ExXvoghvc3vvzPeWXN
         hEQySYr/d/WcG02Tj1q0cKYYDYYMfUzGjUGTzIbw1TocZnXoMrPVafXqk7N8YMIqpyFD
         AkILaZdYG2vhmLIyYR5gig7hXHICuKvZEpgj0Q/pvjtODToKISZB6znwayY7aKC7yg2/
         pDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JOe9/xcyWlPygpRg9fHBknYEcVKDUlk3pocQHkD5gJA=;
        b=SkIafq3DXMe6SxAEXyD78XFWlUp+cuvjCik5l5HM4/yTdpmOLBBkDeJ3EAySPer8EJ
         p7WMpk1pIyXexmK3+y4aFBX4IYKWd8CkO7mGXI6oBm8+5ftsSPUgI9/uHyhJESljvRcF
         Va9RbKYVrYCaZNcTYCJfV381QazD2dPjz8ucv6DaCcEL650+5FGoyWCsjFxtxxnLBtNP
         6np4y+YaiVhiLuh6i+CScE42GwzWCc0dPjGMNUtabnuhhWezHxUbK1SmjOYnnbG6hZB2
         JKh3ADQtH+bRgKFbQlRJi1PAxKrglSI4KiG6nB7L+GbzHt5jCRLRrgMA/62keqrvdxtj
         7rRg==
X-Gm-Message-State: AOAM530QPzmW36X9yZ+8pclGWHqSu6ze0VDd1MPwsrUrYU11tceJM1EP
        XMhBPrXTlLSUhf5YKbNnEuGVAyU4CeY=
X-Google-Smtp-Source: ABdhPJzRa93Qz8ORvaS21uPSeEAc0+JOjb7b0kLDb1z0N/v7rTekBi4/OSnvJy0xWcukSr0OcOQpBg==
X-Received: by 2002:a5d:6d88:0:b0:20e:6f48:a18b with SMTP id l8-20020a5d6d88000000b0020e6f48a18bmr16780380wrs.521.1653313729635;
        Mon, 23 May 2022 06:48:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w5-20020adf8bc5000000b0020e615bab7bsm10256310wra.7.2022.05.23.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:48 -0700 (PDT)
Message-Id: <f2960747ed868d57bc2eccfbe49d284f5268aba4.1653313726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:37 +0000
Subject: [PATCH v3 01/10] t1092: refactor 'sparse-index contents' test
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

Before expanding this test with more involved cases, first extract the
repeated logic into a new test_sparse_checkout_set helper. This helper
checks that 'git sparse-checkout set ...' succeeds and then verifies
that certain directories have sparse directory entries in the sparse
index. It also verifies that the in-cone directories are _not_ sparse
directory entries in the sparse index.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 53 ++++++++++++++++--------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 93bcfd20bbc..e7c0ae9b953 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -205,36 +205,53 @@ test_sparse_unstaged () {
 	done
 }
 
-test_expect_success 'sparse-index contents' '
-	init_repos &&
-
+# Usage: test_sprase_checkout_set "<c1> ... <cN>" "<s1> ... <sM>"
+# Verifies that "git sparse-checkout set <c1> ... <cN>" succeeds and
+# leaves the sparse index in a state where <s1> ... <sM> are sparse
+# directories (and <c1> ... <cN> are not).
+test_sparse_checkout_set () {
+	CONE_DIRS=$1 &&
+	SPARSE_DIRS=$2 &&
+	git -C sparse-index sparse-checkout set $CONE_DIRS &&
 	git -C sparse-index ls-files --sparse --stage >cache &&
-	for dir in folder1 folder2 x
+
+	# Check that the directories outside of the sparse-checkout cone
+	# have sparse directory entries.
+	for dir in $SPARSE_DIRS
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
 		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
-	git -C sparse-index sparse-checkout set folder1 &&
-
-	git -C sparse-index ls-files --sparse --stage >cache &&
-	for dir in deep folder2 x
+	# Check that the directories in the sparse-checkout cone
+	# are not sparse directory entries.
+	for dir in $CONE_DIRS
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 $TREE 0	$dir/" cache \
+		! grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
-	done &&
+	done
+}
 
-	git -C sparse-index sparse-checkout set deep/deeper1 &&
+test_expect_success 'sparse-index contents' '
+	init_repos &&
 
-	git -C sparse-index ls-files --sparse --stage >cache &&
-	for dir in deep/deeper2 folder1 folder2 x
-	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 $TREE 0	$dir/" cache \
-			|| return 1
-	done &&
+	# Remove deep, add three other directories.
+	test_sparse_checkout_set \
+		"folder1 folder2 x" \
+		"before deep" &&
+
+	# Remove folder1, add deep
+	test_sparse_checkout_set \
+		"deep folder2 x" \
+		"before folder1" &&
+
+	# Replace deep with deep/deeper2 (dropping deep/deeper1)
+	# Add folder1
+	test_sparse_checkout_set \
+		"deep/deeper2 folder1 folder2 x" \
+		"before deep/deeper1" &&
 
 	# Disabling the sparse-index replaces tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
-- 
gitgitgadget

