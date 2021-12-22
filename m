Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE6C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343538AbhLVOVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbhLVOVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:21:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AB7C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g7-20020a7bc4c7000000b00345c4bb365aso1178318wmk.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LptVVk401A/kcVr4wa7dIRYaI4RiLqOsY/gC10856C0=;
        b=P1hi40b0d4u5XPlroftdrGSWmSEIoPJYa8APFbxQ1+yM3IX2WsBwBbmz77BEosW+5Q
         KFltbsx+2nlZC++rR5+N4HRhzfyr9P7hWyr1VinpOdSCMPUsKzG9YfVmnNtfOX9bijq0
         vZcKj32Y2FNUjvv6wKB5xFjjNTRvieeeh7LBQZsl4XTZOgPYClPdbwuY1ycVAcfJv9Si
         Po/HwIKQRAZKOhpPMLkgFJ3qNGcb0jLJnl+e2of7xlmZQhe6EP/NTVxieGZ6LXQrji/E
         nfrLwLV/C6lAr1/BNJEFzBprK5LeupoUATaSuCDVO8eJD384Xpg1l67BEOkmjm9t/NIz
         RIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LptVVk401A/kcVr4wa7dIRYaI4RiLqOsY/gC10856C0=;
        b=YgIRYrSCL7c1hCWv4h8LmRej7DU9JWJjyrIHbwOCZEvwZPBaHaAD9TUHifaSBT3fd+
         ZRB6yGjF8gfnCWqHUDQr8d8VJX43y+dm9/35+RI78i7qqV/ATwVLDi1Hxd70/fRtGTZz
         lE0kBnGpwBMbIh+2oC25KriAW+RhDGOr1wg1mq8Pgql4iCrRxDEkb067in408UXZu86V
         pSdgdvxdfBHTPJ1mq4cHyzjIq4+iwkCuHAq2jerZGm8dihdi6XJWkTxKKpSf82xZ3Sh4
         1mX8po0QLvJBf+k5mP8tu21R9ahfxgUcTzW58jJWcp4lyhWnZOiyyBNlHMxX4CVWaOKp
         P0Bw==
X-Gm-Message-State: AOAM530UIo3GqqqS0Pno9FgHg4/Ghecy0kYGqUE9qiq+Lw9XjgiNfvhq
        4xUgbWWjBLTH06Fu/ELwoIbKaEWFp4Q=
X-Google-Smtp-Source: ABdhPJyNVMGh6Nanehl9uPhhfIvqs0MRmjiN4Gfyc9s0OqsXYIENyXdQ69xLXmVvTL2KdjZ86u66JA==
X-Received: by 2002:a05:600c:4f55:: with SMTP id m21mr1095736wmq.49.1640182860695;
        Wed, 22 Dec 2021 06:21:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19sm1958974wmq.30.2021.12.22.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:21:00 -0800 (PST)
Message-Id: <0c53bd09ba4a4c16e2be4b92c4386e22dbe98b50.1640182856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
        <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:20:54 +0000
Subject: [PATCH v4 3/5] t1092: replace 'read-cache --table' with 'ls-files
 --sparse'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that 'git ls-files --sparse' exists, we can use it to verify the
state of a sparse index instead of 'test-tool read-cache table'. Replace
these usages within t1092-sparse-checkout-compatibility.sh.

The important changes are due to the different output format. We need to
use the '--stage' output to get a file mode and OID, but it also
includes a stage value and drops the object type. This leads to some
differences in how we handle looking for specific entries.

Some places where we previously looked for no 'tree' entries, we can
instead directly compare the output across the repository with a sparse
index and the one without.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 31 +++++++++++-------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c51e9bd3b7..4ba16177528 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -206,45 +206,42 @@ test_sparse_unstaged () {
 test_expect_success 'sparse-index contents' '
 	init_repos &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in folder1 folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set folder1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in deep folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set deep/deeper1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse --stage >cache &&
 	for dir in deep/deeper2 folder1 folder2 x
 	do
 		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
+		grep "040000 $TREE 0	$dir/" cache \
 			|| return 1
 	done &&
 
-	# Disabling the sparse-index removes tree entries with full ones
+	# Disabling the sparse-index replaces tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
-
-	test-tool -C sparse-index read-cache --table >cache &&
-	! grep "040000 tree" cache &&
-	test_sparse_match test-tool read-cache --table
+	test_sparse_match git ls-files --stage --sparse
 '
 
 test_expect_success 'expanded in-memory index matches full index' '
 	init_repos &&
-	test_sparse_match test-tool read-cache --expand --table
+	test_sparse_match git ls-files --stage
 '
 
 test_expect_success 'status with options' '
@@ -801,9 +798,9 @@ test_expect_success 'submodule handling' '
 
 	# having a submodule prevents "modules" from collapse
 	test_sparse_match git sparse-checkout set deep/deeper1 &&
-	test-tool -C sparse-index read-cache --table >cache &&
-	grep "100644 blob .*	modules/a" cache &&
-	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
+	git -C sparse-index ls-files --sparse --stage >cache &&
+	grep "100644 .*	modules/a" cache &&
+	grep "160000 $(git -C initial-repo rev-parse HEAD) 0	modules/sub" cache
 '
 
 # When working with a sparse index, some commands will need to expand the
@@ -1125,13 +1122,13 @@ test_expect_success 'reset mixed and checkout orphan' '
 	# the sparse checkouts skip "adding" the other side of
 	# the conflict.
 	test_sparse_match git reset --mixed HEAD~1 &&
-	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git ls-files --stage &&
 	test_sparse_match git status --porcelain=v2 &&
 
 	# At this point, sparse-checkouts behave differently
 	# from the full-checkout.
 	test_sparse_match git checkout --orphan new-branch &&
-	test_sparse_match test-tool read-cache --table --expand &&
+	test_sparse_match git ls-files --stage &&
 	test_sparse_match git status --porcelain=v2
 '
 
-- 
gitgitgadget

