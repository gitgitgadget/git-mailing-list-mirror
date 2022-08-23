Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74896C32774
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 06:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiHWGs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240619AbiHWGst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 02:48:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8651EAED
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 23:48:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j26so6702171wms.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=wS+h5h1wgnLEBXrdFn/O5iFEpoZrn/L/y8iuZ8OYUrM=;
        b=aK1ct9hqCk5lOHSO4NJmrQvgm7KlqUz0PVgEXxTc1gyOVMR92XiX0+oBHz0nZ0bCas
         H/zCvBm+nQXeEQURbAAG/1ar41urWkdOLR8RgczfOa8XjvNlL3tr1ePgAFduyzlcNtty
         1onutgws1kgPhgD5zLvvbL4wJ2H10D9OZyD2YiUGaCXaCyrcHd2mUksk4g48YGUKbb1a
         gciAepKh4aTuNaCtvLWq9EiU3C82W3fi1a/NOTCq/dzf5z2MEWNj4Jsz/5dD7LaXhJAT
         1yD6fSvLS4yVNGw9bAdMs0akHU4nY4V3MKqzkjgcxH34z9fh9zOMHcvSyrPnInc5q22o
         AC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=wS+h5h1wgnLEBXrdFn/O5iFEpoZrn/L/y8iuZ8OYUrM=;
        b=rw3abqn9qUwMibIdl6jkYDuOCUimhE84K0tvihtSR8nHkKOQAwB9/XsjovnuWb60pl
         TY1BmbvmuqHDXiNbY+c28apu93ccMQqN7+BFm+8BC+PVXj2Drj710yoUoAMbocMnzHHP
         VuAiP5/sgLmgwOzyf569lYyYa//JFM/fPPUt49yED2qXIZYOP/brTRC1+79e+MxOFQ9J
         2QQwIlQdAQhtk7lLGUUglvrodr3gNlEyGC983hJGY2m5JoYSbjEOE461CaGOQcedCyaY
         +SYksiC1qWLO5DY26HeyMIx3ttmoLb+KMgL5hg85K1qtUksdXlqizSAxh6CgtjtxBIW+
         rLdw==
X-Gm-Message-State: ACgBeo1BbVY8aXKCb9eNf1/6FyeMP35a14/erGj3VF7KkA1CD3i4v1VV
        8KNwo8Ef6WwGWLewZRsgIgofJl/V82s=
X-Google-Smtp-Source: AA6agR4aG+Vyh2WgCubmqUCPpDU+2gJ3ONuuorIlIT5bVeWAf3klEsUqBBi58zL1gm66xT6JFHPbyg==
X-Received: by 2002:a05:600c:19c6:b0:3a5:ffb3:d527 with SMTP id u6-20020a05600c19c600b003a5ffb3d527mr1105430wmq.106.1661237317872;
        Mon, 22 Aug 2022 23:48:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b002252f57865asm13489016wrs.15.2022.08.22.23.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 23:48:37 -0700 (PDT)
Message-Id: <pull.1332.git.1661237316150.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 06:48:36 +0000
Subject: [PATCH] t4301: add more interesting merge-tree testcases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This adds several tests of `merge-tree -z` extended conflict output
behavior to the testsuite, including some tests adapted from t6422.
These tests mark current behavior, not necessarily optimal behavior.  In
particular, some path_msg() calls might want to include additional
paths.

These testcases also make something clear about the <Conflicted file>
info section of the output.  That section consists of a sequence of
lines of the form
    <mode> <object> <stage> <filename>
where <stage> is always greater than 0 (since each line comes from a
conflicted file).  The lines correspond to conflicts that would be
placed in the index if we were doing a merge in a working tree.  It is
perhaps natural to assume that for any given line, the <object> and
<filename> correspond to a single <revision>:<filename> pair from one of
the commits being merged (or from the merge base).  This is true for
simple conflicts.  However, these testcases make it clear that this is
not the case in general.  For example, <object> may be the hash of a
three-way content merge of three different files (and with different
filenames).

The tests no longer pass under TEST_PASSES_SANITIZE_LEAK; it appears
that doing a directory rename with "git mv", among other possible
problems, triggers issues.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    t4301: add more interesting merge-tree testcases
    
    Spurred by
    https://lore.kernel.org/git/pull.1327.git.1660892256.gitgitgadget@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1332%2Fnewren%2Fmerge-tree-testcases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1332/newren/merge-tree-testcases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1332

 t/t4301-merge-tree-write-tree.sh | 574 ++++++++++++++++++++++++++++++-
 1 file changed, 573 insertions(+), 1 deletion(-)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index a243e3c5176..c5fd56df28f 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -2,7 +2,6 @@
 
 test_description='git merge-tree --write-tree'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
@@ -138,6 +137,579 @@ test_expect_success 'test conflict notices and such' '
 	test_cmp expect actual
 '
 
+# directory rename + content conflict
+#   Commit O: foo, olddir/{a,b,c}
+#   Commit A: modify foo, newdir/{a,b,c}
+#   Commit B: modify foo differently & rename foo -> olddir/bar
+#   Expected: CONFLICT(content) for for newdir/bar (not olddir/bar or foo)
+
+test_expect_success 'directory rename + content conflict' '
+	# Setup
+	git init dir-rename-and-content &&
+	(
+		cd dir-rename-and-content &&
+		test_write_lines 1 2 3 4 5 >foo &&
+		mkdir olddir &&
+		for i in a b c; do echo $i >olddir/$i; done
+		git add foo olddir &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 6 >foo &&
+		git add foo &&
+		git mv olddir newdir &&
+		git commit -m "Modify foo, rename olddir to newdir" &&
+
+		git checkout B &&
+		test_write_lines 1 2 3 4 5 six >foo &&
+		git add foo &&
+		git mv foo olddir/bar &&
+		git commit -m "Modify foo & rename foo -> olddir/bar"
+	) &&
+	# Testing
+	(
+		cd dir-rename-and-content &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+		anonymize_hash out >actual &&
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 1Qnewdir/bar
+		100644 HASH 2Qnewdir/bar
+		100644 HASH 3Qnewdir/bar
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		Q2Qnewdir/barQolddir/barQCONFLICT (directory rename suggested)QCONFLICT (file location): foo renamed to olddir/bar in B^0, inside a directory that was renamed in A^0, suggesting it should perhaps be moved to newdir/bar.
+		Q1Qnewdir/barQAuto-mergingQAuto-merging newdir/bar
+		Q1Qnewdir/barQCONFLICT (contents)QCONFLICT (content): Merge conflict in newdir/bar
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# rename/delete + modify/delete handling
+#   Commit O: foo
+#   Commit A: modify foo + rename to bar
+#   Commit B: delete foo
+#   Expected: CONFLICT(rename/delete) + CONFLICT(modify/delete)
+
+test_expect_success 'rename/delete handling' '
+	# Setup
+	git init rename-delete &&
+	(
+		cd rename-delete &&
+		test_write_lines 1 2 3 4 5 >foo &&
+		git add foo &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 6 >foo &&
+		git add foo &&
+		git mv foo bar &&
+		git commit -m "Modify foo, rename to bar" &&
+
+		git checkout B &&
+		git rm foo &&
+		git commit -m "remove foo"
+	) &&
+	# Testing
+	(
+		cd rename-delete &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+		anonymize_hash out >actual &&
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 1Qbar
+		100644 HASH 2Qbar
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		Q2QbarQfooQCONFLICT (rename/delete)QCONFLICT (rename/delete): foo renamed to bar in A^0, but deleted in B^0.
+		Q1QbarQCONFLICT (modify/delete)QCONFLICT (modify/delete): bar deleted in B^0 and modified in A^0.  Version A^0 of bar left in tree.
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# rename/add handling
+#   Commit O: foo
+#   Commit A: modify foo, add different bar
+#   Commit B: modify & rename foo->bar
+#   Expected: CONFLICT(add/add) [via rename collide] for bar
+
+test_expect_success 'rename/add handling' '
+	# Setup
+	git init rename-add &&
+	(
+		cd rename-add &&
+		test_write_lines original 1 2 3 4 5 >foo &&
+		git add foo &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 >foo &&
+		echo "different file" >bar &&
+		git add foo bar &&
+		git commit -m "Modify foo, add bar" &&
+
+		git checkout B &&
+		test_write_lines original 1 2 3 4 5 6 >foo &&
+		git add foo &&
+		git mv foo bar &&
+		git commit -m "rename foo to bar"
+	) &&
+	# Testing
+	(
+		cd rename-add &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+
+		#
+		# First, check that the bar that appears at stage 3 does not
+		# correspond to an individual blob anywhere in history
+		#
+		hash=$(cat out | tr "\0" "\n" | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
+		git rev-list --objects --all >all_blobs &&
+		! grep $hash all_blobs &&
+
+		#
+		# Second, check anonymized hash output against expectation
+		#
+		anonymize_hash out >actual &&
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 2Qbar
+		100644 HASH 3Qbar
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		Q1QbarQAuto-mergingQAuto-merging bar
+		Q1QbarQCONFLICT (contents)QCONFLICT (add/add): Merge conflict in bar
+		Q1QfooQAuto-mergingQAuto-merging foo
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# rename/add, where add is a mode conflict
+#   Commit O: foo
+#   Commit A: modify foo, add symlink bar
+#   Commit B: modify & rename foo->bar
+#   Expected: CONFLICT(distinct modes) for bar
+
+test_expect_success SYMLINKS 'rename/add, where add is a mode conflict' '
+	# Setup
+	git init rename-add-symlink &&
+	(
+		cd rename-add-symlink &&
+		test_write_lines original 1 2 3 4 5 >foo &&
+		git add foo &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 >foo &&
+		ln -s foo bar &&
+		git add foo bar &&
+		git commit -m "Modify foo, add symlink bar" &&
+
+		git checkout B &&
+		test_write_lines original 1 2 3 4 5 6 >foo &&
+		git add foo &&
+		git mv foo bar &&
+		git commit -m "rename foo to bar"
+	) &&
+	# Testing
+	(
+		cd rename-add-symlink &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+
+		#
+		# First, check that the bar that appears at stage 3 does not
+		# correspond to an individual blob anywhere in history
+		#
+		hash=$(cat out | tr "\0" "\n" | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
+		git rev-list --objects --all >all_blobs &&
+		! grep $hash all_blobs &&
+
+		#
+		# Second, check anonymized hash output against expectation
+		#
+		anonymize_hash out >actual &&
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		120000 HASH 2Qbar
+		100644 HASH 3Qbar~B^0
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		Q2QbarQbar~B^0QCONFLICT (distinct modes)QCONFLICT (distinct types): bar had different types on each side; renamed one of them so each can be recorded somewhere.
+		Q1QfooQAuto-mergingQAuto-merging foo
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# rename/rename(1to2) + content conflict handling
+#   Commit O: foo
+#   Commit A: modify foo & rename to bar
+#   Commit B: modify foo & rename to baz
+#   Expected: CONFLICT(rename/rename)
+
+test_expect_success 'rename/rename + content conflict' '
+	# Setup
+	git init rr-plus-content &&
+	(
+		cd rr-plus-content &&
+		test_write_lines 1 2 3 4 5 >foo &&
+		git add foo &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_write_lines 1 2 3 4 5 six >foo &&
+		git add foo &&
+		git mv foo bar &&
+		git commit -m "Modify foo + rename to bar" &&
+
+		git checkout B &&
+		test_write_lines 1 2 3 4 5 6 >foo &&
+		git add foo &&
+		git mv foo baz &&
+		git commit -m "Modify foo + rename to baz"
+	) &&
+	# Testing
+	(
+		cd rr-plus-content &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+		anonymize_hash out >actual &&
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 2Qbar
+		100644 HASH 3Qbaz
+		100644 HASH 1Qfoo
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		Q1QfooQAuto-mergingQAuto-merging foo
+		Q3QfooQbarQbazQCONFLICT (rename/rename)QCONFLICT (rename/rename): foo renamed to bar in A^0 and to baz in B^0.
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# rename/add/delete
+#   Commit O: foo
+#   Commit A: rm foo, add different bar
+#   Commit B: rename foo->bar
+#   Expected: CONFLICT (rename/delete), CONFLICT(add/add) [via rename collide]
+#             for bar
+
+test_expect_success 'rename/add/delete conflict' '
+	# Setup
+	git init rad &&
+	(
+		cd rad &&
+		echo "original file" >foo &&
+		git add foo &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm foo &&
+		echo "different file" >bar &&
+		git add bar &&
+		git commit -m "Remove foo, add bar" &&
+
+		git checkout B &&
+		git mv foo bar &&
+		git commit -m "rename foo to bar"
+	) &&
+	# Testing
+	(
+		cd rad &&
+
+		test_expect_code 1 \
+			git merge-tree -z B^0 A^0 >out &&
+		printf "\\n" >>out &&
+		anonymize_hash out >actual &&
+
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 2Qbar
+		100644 HASH 3Qbar
+
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		2QbarQfooQCONFLICT (rename/delete)QCONFLICT (rename/delete): foo renamed to bar in B^0, but deleted in A^0.
+		Q1QbarQAuto-mergingQAuto-merging bar
+		Q1QbarQCONFLICT (contents)QCONFLICT (add/add): Merge conflict in bar
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# rename/rename(2to1)/delete/delete
+#   Commit O: foo, bar
+#   Commit A: rename foo->baz, rm bar
+#   Commit B: rename bar->baz, rm foo
+#   Expected: 2x CONFLICT (rename/delete), CONFLICT (add/add) via colliding
+#             renames for baz
+
+test_expect_success 'rename/rename(2to1)/delete/delete conflict' '
+	# Setup
+	git init rrdd &&
+	(
+		cd rrdd &&
+		echo foo >foo &&
+		echo bar >bar &&
+		git add foo bar &&
+		git commit -m O &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv foo baz &&
+		git rm bar &&
+		git commit -m "Rename foo, remove bar" &&
+
+		git checkout B &&
+		git mv bar baz &&
+		git rm foo &&
+		git commit -m "Rename bar, remove foo"
+	) &&
+	# Testing
+	(
+		cd rrdd &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+		anonymize_hash out >actual &&
+
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 2Qbaz
+		100644 HASH 3Qbaz
+
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		2QbazQbarQCONFLICT (rename/delete)QCONFLICT (rename/delete): bar renamed to baz in B^0, but deleted in A^0.
+		Q2QbazQfooQCONFLICT (rename/delete)QCONFLICT (rename/delete): foo renamed to baz in A^0, but deleted in B^0.
+		Q1QbazQAuto-mergingQAuto-merging baz
+		Q1QbazQCONFLICT (contents)QCONFLICT (add/add): Merge conflict in baz
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# mod6: chains of rename/rename(1to2) + add/add via colliding renames
+#   Commit O: one,      three,       five
+#   Commit A: one->two, three->four, five->six
+#   Commit B: one->six, three->two,  five->four
+#   Expected: three CONFLICT(rename/rename) messages + three CONFLICT(add/add)
+#             messages; each path in two of the multi-way merged contents
+#             found in two, four, six
+
+test_expect_success 'mod6: chains of rename/rename(1to2) and add/add via colliding renames' '
+	# Setup
+	git init mod6 &&
+	(
+		cd mod6 &&
+		test_seq 11 19 >one &&
+		test_seq 31 39 >three &&
+		test_seq 51 59 >five &&
+		git add . &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_seq 10 19 >one &&
+		echo 40        >>three &&
+		git add one three &&
+		git mv  one   two  &&
+		git mv  three four &&
+		git mv  five  six  &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo 20    >>one       &&
+		echo forty >>three     &&
+		echo 60    >>five      &&
+		git add one three five &&
+		git mv  one   six  &&
+		git mv  three two  &&
+		git mv  five  four &&
+		test_tick &&
+		git commit -m "B"
+	) &&
+	# Testing
+	(
+		cd mod6 &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+
+		#
+		# First, check that some of the hashes that appear as stage
+		# conflict entries do not appear as individual blobs anywhere
+		# in history.
+		#
+		hash1=$(cat out | tr "\0" "\n" | head | grep 2.four | cut -f 2 -d " ") &&
+		hash2=$(cat out | tr "\0" "\n" | head | grep 3.two | cut -f 2 -d " ") &&
+		git rev-list --objects --all >all_blobs &&
+		! grep $hash1 all_blobs &&
+		! grep $hash2 all_blobs &&
+
+		#
+		# Now compare anonymized hash output with expectation
+		#
+		anonymize_hash out >actual &&
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 1Qfive
+		100644 HASH 2Qfour
+		100644 HASH 3Qfour
+		100644 HASH 1Qone
+		100644 HASH 2Qsix
+		100644 HASH 3Qsix
+		100644 HASH 1Qthree
+		100644 HASH 2Qtwo
+		100644 HASH 3Qtwo
+
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		3QfiveQsixQfourQCONFLICT (rename/rename)QCONFLICT (rename/rename): five renamed to six in A^0 and to four in B^0.
+		Q1QfourQAuto-mergingQAuto-merging four
+		Q1QfourQCONFLICT (contents)QCONFLICT (add/add): Merge conflict in four
+		Q1QoneQAuto-mergingQAuto-merging one
+		Q3QoneQtwoQsixQCONFLICT (rename/rename)QCONFLICT (rename/rename): one renamed to two in A^0 and to six in B^0.
+		Q1QsixQAuto-mergingQAuto-merging six
+		Q1QsixQCONFLICT (contents)QCONFLICT (add/add): Merge conflict in six
+		Q1QthreeQAuto-mergingQAuto-merging three
+		Q3QthreeQfourQtwoQCONFLICT (rename/rename)QCONFLICT (rename/rename): three renamed to four in A^0 and to two in B^0.
+		Q1QtwoQAuto-mergingQAuto-merging two
+		Q1QtwoQCONFLICT (contents)QCONFLICT (add/add): Merge conflict in two
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
+# directory rename + rename/delete + modify/delete + directory/file conflict
+#   Commit O: foo, olddir/{a,b,c}
+#   Commit A: delete foo, rename olddir/ -> newdir/, add newdir/bar/file
+#   Commit B: modify foo & rename foo -> olddir/bar
+#   Expected: CONFLICT(content) for for newdir/bar (not olddir/bar or foo)
+
+test_expect_success 'directory rename + rename/delete + modify/delete + directory/file conflict' '
+	# Setup
+	git init 4-stacked-conflict &&
+	(
+		cd 4-stacked-conflict &&
+		test_write_lines 1 2 3 4 5 >foo &&
+		mkdir olddir &&
+		for i in a b c; do echo $i >olddir/$i; done
+		git add foo olddir &&
+		git commit -m "original" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git rm foo &&
+		git mv olddir newdir &&
+		mkdir newdir/bar &&
+		>newdir/bar/file &&
+		git add newdir/bar/file &&
+		git commit -m "rm foo, olddir/ -> newdir/, + newdir/bar/file" &&
+
+		git checkout B &&
+		test_write_lines 1 2 3 4 5 6 >foo &&
+		git add foo &&
+		git mv foo olddir/bar &&
+		git commit -m "Modify foo & rename foo -> olddir/bar"
+	) &&
+	# Testing
+	(
+		cd 4-stacked-conflict &&
+
+		test_expect_code 1 \
+			git merge-tree -z A^0 B^0 >out &&
+		printf "\\n" >>out &&
+		anonymize_hash out >actual &&
+
+		q_to_tab <<-\EOF | lf_to_nul >expect &&
+		HASH
+		100644 HASH 1Qnewdir/bar~B^0
+		100644 HASH 3Qnewdir/bar~B^0
+		EOF
+
+		q_to_nul <<-EOF >>expect &&
+		Q2Qnewdir/barQolddir/barQCONFLICT (directory rename suggested)QCONFLICT (file location): foo renamed to olddir/bar in B^0, inside a directory that was renamed in A^0, suggesting it should perhaps be moved to newdir/bar.
+		Q2Qnewdir/barQfooQCONFLICT (rename/delete)QCONFLICT (rename/delete): foo renamed to newdir/bar in B^0, but deleted in A^0.
+		Q2Qnewdir/bar~B^0Qnewdir/barQCONFLICT (file/directory)QCONFLICT (file/directory): directory in the way of newdir/bar from B^0; moving it to newdir/bar~B^0 instead.
+		Q1Qnewdir/bar~B^0QCONFLICT (modify/delete)QCONFLICT (modify/delete): newdir/bar~B^0 deleted in A^0 and modified in B^0.  Version B^0 of newdir/bar~B^0 left in tree.
+		Q
+		EOF
+		test_cmp expect actual
+	)
+'
+
 for opt in $(git merge-tree --git-completion-helper-all)
 do
 	if test $opt = "--trivial-merge" || test $opt = "--write-tree"

base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
-- 
gitgitgadget
