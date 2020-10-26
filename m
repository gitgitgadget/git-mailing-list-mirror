Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BAC5517A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513782067B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN7/G7z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787071AbgJZRCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775672AbgJZRB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id k18so13214387wmj.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6GQbWuh37mT7te6bMTumGT3vAbVRprkgFjHvwvPU8nI=;
        b=rN7/G7z9RvATaYj7/PuwvSrRUEq1CDb2+Lay2ovD2UXccW9R/sAAItiOliL0GkuslS
         sg8d93Y2XQElvknTU+UfpDkldT/BfrtodM9LdaJqHovWUKjanoA6Q/aWiV403o14w35j
         HetH5EP2JruJW+kBiAbnpJH6YD2SwJ92bY+iGbiK25GOvNYbit4vKDFI1AlH7pC6kjAk
         Ys0tMjF9i75YYjCIhEyOWkMbgkkSjc24WltzmOf+2vjO4e8hsJsUihQN2bCRRK1btL/5
         Yq2L711DpNvsRaR31b6d+BkI3t6chFgLqEeeoIXbr9mV75rvAwIdErtuyOqXXO1EtI/V
         k3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6GQbWuh37mT7te6bMTumGT3vAbVRprkgFjHvwvPU8nI=;
        b=tVZVx7rVqSOr+3OvgPvNDwKAacAbPvNrxy1wkVlqjGS28Z2CJWuDylz+fq1ErHbkTK
         6AAZ04pf0471oG12f3fQBD2/yreBhW+LzWss8NNbcxjoSeRCd524ATJm2Ou8C59VIPhS
         XuXoZGjkyGczeGuaQVtgZwoLs5k1qISHqiOOUhCdGyTv+nrnogjJGamTGs+3aMyooEA6
         DNjmCwl0Xw3Jb1kGTz6RYC99EFr3xCMbunTokEIDO0ldR8E0a8jRV3E63HVSLBd63aU+
         zbpLmkeCcdLISJwrrdoGAwyWdoqBGvsg2D77izhePkyG73fombCBgcOH0iX6Vr9sB1x8
         UndQ==
X-Gm-Message-State: AOAM530Uicywx4MJ8sIYHIcH0ELhs8L+VedfTBzFlekH2NBVL/VPE89Y
        AzP51NC9JewbDj+ugR/T9NAPNYKXNfs=
X-Google-Smtp-Source: ABdhPJzV7Ztsln4tbIzVCgIoA5OPQUT9rRP10tQ36e+0riq8jR4SSNFXTlvG34G/m1j2PSuC3g36+Q==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr17944107wmf.185.1603731713247;
        Mon, 26 Oct 2020 10:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm20428484wmf.44.2020.10.26.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:52 -0700 (PDT)
Message-Id: <6fd224247d9ccc1e6283a1e5a2c5678a1a0699b6.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:43 +0000
Subject: [PATCH v2 8/9] t6423: note improved ort handling with untracked files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Similar to the previous commit, since the "recursive" backend relies on
unpack_trees() to check if unstaged or untracked files would be
overwritten by a merge, and unpack_trees() does not understand renames
-- it has false positives and false negatives.  Once it has run, since
it updates as it goes, merge-recursive then has to handle completing the
merge as best it can despite extra changes in the working copy.
However, this is not just an issue for dirty files, but also for
untracked files because directory renames can cause file contents to
need to be written to a location that was not tracked on either side of
history.

Since the "ort" backend does the complete merge inmemory, and only
updates the index and working copy as a post-processing step, if there
are untracked files in the way it can simply abort the merge much like
checkout does.

Update t6423 to reflect the better merge abilities and expectations for
ort, while still leaving the best-case-as-good-as-recursive-can-do
expectations there for the recursive backend so we retain its stability
until we are ready to deprecate and remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 195 ++++++++++++++++++----------
 1 file changed, 124 insertions(+), 71 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 32e6925ca4..db694a6316 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -3214,6 +3214,7 @@ test_expect_success '10a: Overwrite untracked with normal rename/delete' '
 		echo important >z/d &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+		test_path_is_missing .git/MERGE_HEAD &&
 		test_i18ngrep "The following untracked working tree files would be overwritten by merge" err &&
 
 		git ls-files -s >out &&
@@ -3283,21 +3284,34 @@ test_expect_success '10b: Overwrite untracked with dir rename + delete' '
 		echo contents >y/e &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
-		test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 3 out &&
-		git ls-files -u >out &&
-		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 5 out &&
+			git ls-files -s >out &&
+			test_line_count = 1 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 5 out
+		else
+			test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
+			test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
 
-		git rev-parse >actual \
-			:0:y/b :3:y/d :3:y/e &&
-		git rev-parse >expect \
-			O:z/b  O:z/c  B:z/e &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 3 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 5 out &&
+
+			git rev-parse >actual \
+				:0:y/b :3:y/d :3:y/e &&
+			git rev-parse >expect \
+				O:z/b  O:z/c  B:z/e &&
+			test_cmp expect actual
+		fi &&
 
 		echo very >expect &&
 		test_cmp expect y/c &&
@@ -3360,25 +3374,38 @@ test_expect_success '10c1: Overwrite untracked with dir rename/rename(1to2)' '
 		echo important >y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 6 out &&
-		git ls-files -u >out &&
-		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 3 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		git hash-object y/c~B^0 >actual &&
-		git rev-parse O:x/c >expect &&
-		test_cmp expect actual &&
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
+			test_cmp expect actual &&
+
+			git hash-object y/c~B^0 >actual &&
+			git rev-parse O:x/c >expect &&
+			test_cmp expect actual
+		fi &&
 
 		echo important >expect &&
 		test_cmp expect y/c
@@ -3398,25 +3425,38 @@ test_expect_success '10c2: Overwrite untracked with dir rename/rename(1to2), oth
 		echo important >y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 6 out &&
-		git ls-files -u >out &&
-		test_line_count = 3 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 4 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:x/d :1:x/c :3:w/c :2:y/c &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 3 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
 
-		git hash-object y/c~HEAD >actual &&
-		git rev-parse O:x/c >expect &&
-		test_cmp expect actual &&
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:x/d :1:x/c :3:w/c :2:y/c &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
+			test_cmp expect actual &&
+
+			git hash-object y/c~HEAD >actual &&
+			git rev-parse O:x/c >expect &&
+			test_cmp expect actual
+		fi &&
 
 		echo important >expect &&
 		test_cmp expect y/c
@@ -3474,37 +3514,50 @@ test_expect_success '10d: Delete untracked with dir rename/rename(2to1)' '
 		echo important >y/wham &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
-		test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
+		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+		then
+			test_path_is_missing .git/MERGE_HEAD &&
+			test_i18ngrep "error: The following untracked working tree files would be overwritten by merge" err &&
 
-		git ls-files -s >out &&
-		test_line_count = 6 out &&
-		git ls-files -u >out &&
-		test_line_count = 2 out &&
-		git ls-files -o >out &&
-		test_line_count = 3 out &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 0 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out
+		else
+			test_i18ngrep "CONFLICT (rename/rename)" out &&
+			test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
 
-		git rev-parse >actual \
-			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
-		git rev-parse >expect \
-			 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
-		test_cmp expect actual &&
+			git ls-files -s >out &&
+			test_line_count = 6 out &&
+			git ls-files -u >out &&
+			test_line_count = 2 out &&
+			git ls-files -o >out &&
+			test_line_count = 3 out &&
+
+			git rev-parse >actual \
+				:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
+			git rev-parse >expect \
+				 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
+			test_cmp expect actual &&
 
-		test_must_fail git rev-parse :1:y/wham &&
+			test_must_fail git rev-parse :1:y/wham &&
 
-		echo important >expect &&
-		test_cmp expect y/wham &&
+			# Test that two-way merge in y/wham~merged is as expected
+			git cat-file -p :2:y/wham >expect &&
+			git cat-file -p :3:y/wham >other &&
+			>empty &&
+			test_must_fail git merge-file \
+				-L "HEAD" \
+				-L "" \
+				-L "B^0" \
+				expect empty other &&
+			test_cmp expect y/wham~merged
+		fi &&
 
-		# Test that the two-way merge in y/wham~merged is as expected
-		git cat-file -p :2:y/wham >expect &&
-		git cat-file -p :3:y/wham >other &&
-		>empty &&
-		test_must_fail git merge-file \
-			-L "HEAD" \
-			-L "" \
-			-L "B^0" \
-			expect empty other &&
-		test_cmp expect y/wham~merged
+		echo important >expect &&
+		test_cmp expect y/wham
 	)
 '
 
-- 
gitgitgadget

