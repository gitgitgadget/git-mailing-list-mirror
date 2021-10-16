Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B02EC433F5
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4761160F02
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhJPJJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbhJPJJU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:09:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265F7C061570
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:07:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso4008674wms.5
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Q7X0c3Iyc+EkD3kFzX8Z8RQ2I3m80zz93Ca0M1y8ZjI=;
        b=pJmvbgKdYjUwuS9e5a8Lth9F2NIYSjnW2X/ilrys4VrgvLHD7QPAdG7wknrE6EjTWX
         vXZcBOYmfOjA8o/bmJR1tn62p3j5kqfDrTds9qvPigoY6C59ofIpzzEzokybl1P/bS8W
         /9OHQ8DybPS4VrJj5bNMBatMPch9pggpwT+KhxSG/mZV+ptKC03lZCn/bJN13Xs2a8mQ
         gmq7tEFvXWja6pRH8g2WEVimZcwDPgBJ6WY7R9rInldTBs5h4R3TqAt+qJwN9DeICSyR
         Ie+xHNuf3cTEEokiYFZdisTjIuZngJ6Dw5Jd2xrpTdtIqzHHkxBR97YA1Jv31bEml9Lu
         lJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Q7X0c3Iyc+EkD3kFzX8Z8RQ2I3m80zz93Ca0M1y8ZjI=;
        b=nE315pp9bY921mBFyo9wIzZULLvmnubQ8+b5GYKaNA1GYx+vZEVgfGWyJLnze3MmQf
         h4qvo5Upf+pmLd6EPMVnsruulb/0/z+1AxfdraRHCyh0GANw9C7QTVxzGSgh2kicCtEz
         HEHMpm+BTde9h/aKpX5qNGdiWvH9nhso5H6jVab7dEESXcAv5qCAYx0BJ9J+++8IkKME
         etNE/XyJrb2zjSYKU/ObiV38BIUustTmb8xixq7SOYeGRKYaDUc7Q0jFr/FACwci82Fw
         5yxaN0KTLowl8+9jLltpWjjJluhg3peqoxSaDYmybsRNuMQAOkqNTZlhcpur3P2ia0h9
         bAFA==
X-Gm-Message-State: AOAM531AURmX7EhMq3P3/mlby//Db27hqdH5DsQbSRkQMMCHBmzPz2Uw
        oiQSJVE8wpruD/Q3rKAh83FVI+RjuWw=
X-Google-Smtp-Source: ABdhPJyD8tK4e1XpJFCAB+5IBEQzSFMeM78AoS54LnPvYCnXiF57/f1GmMUK4SPmiFvkXWs/DacTjg==
X-Received: by 2002:a05:600c:4ca7:: with SMTP id g39mr17577869wmp.115.1634375230675;
        Sat, 16 Oct 2021 02:07:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm855622wmq.17.2021.10.16.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:07:10 -0700 (PDT)
Message-Id: <pull.1053.v4.git.1634375229338.gitgitgadget@gmail.com>
In-Reply-To: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
References: <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Oct 2021 09:07:09 +0000
Subject: [PATCH v4] sparse index: fix use-after-free bug in
 cache_tree_verify()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

In a sparse index it is possible for the tree that is being verified
to be freed while it is being verified. This happens when the index is
sparse but the cache tree is not and index_name_pos() looks up a path
from the cache tree that is a descendant of a sparse index entry. That
triggers a call to ensure_full_index() which frees the cache tree that
is being verified.  Carrying on trying to verify the tree after this
results in a use-after-free bug. Instead restart the verification if a
sparse index is converted to a full index. This bug is triggered by a
call to reset_head() in "git rebase --apply". Thanks to René Scharfe
and Derrick Stolee for their help analyzing the problem.

==74345==ERROR: AddressSanitizer: heap-use-after-free on address 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
READ of size 4 at 0x606000001b20 thread T0
    #0 0x557cbe82d3a1 in verify_one /home/phil/src/git/cache-tree.c:863
    #1 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #2 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #3 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #4 0x557cbe830a2b in cache_tree_verify /home/phil/src/git/cache-tree.c:910
    #5 0x557cbea53741 in write_locked_index /home/phil/src/git/read-cache.c:3250
    #6 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
    #7 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
    #8 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
    #9 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
    #10 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
    #11 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
    #12 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
    #13 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
    #14 0x557cbe5bcb8d in _start (/home/phil/src/git/git+0x1b9b8d)

0x606000001b20 is located 0 bytes inside of 56-byte region [0x606000001b20,0x606000001b58)
freed by thread T0 here:
    #0 0x7fdd4bacff19 in __interceptor_free /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:127
    #1 0x557cbe82af60 in cache_tree_free /home/phil/src/git/cache-tree.c:35
    #2 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
    #3 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
    #4 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
    #5 0x557cbeb2557a in ensure_full_index /home/phil/src/git/sparse-index.c:310
    #6 0x557cbea45c4a in index_name_stage_pos /home/phil/src/git/read-cache.c:588
    #7 0x557cbe82ce37 in verify_one /home/phil/src/git/cache-tree.c:850
    #8 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #9 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #10 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
    #11 0x557cbe830a2b in cache_tree_verify /home/phil/src/git/cache-tree.c:910
    #12 0x557cbea53741 in write_locked_index /home/phil/src/git/read-cache.c:3250
    #13 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
    #14 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
    #15 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
    #16 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
    #17 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
    #18 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
    #19 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
    #20 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)

previously allocated by thread T0 here:
    #0 0x7fdd4bad0459 in __interceptor_calloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x557cbebc1807 in xcalloc /home/phil/src/git/wrapper.c:140
    #2 0x557cbe82b7d8 in cache_tree /home/phil/src/git/cache-tree.c:17
    #3 0x557cbe82b7d8 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:763
    #4 0x557cbe82b837 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:764
    #5 0x557cbe82b837 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:764
    #6 0x557cbe8304e1 in prime_cache_tree /home/phil/src/git/cache-tree.c:779
    #7 0x557cbeab7fa7 in reset_head /home/phil/src/git/reset.c:85
    #8 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
    #9 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
    #10 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
    #11 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
    #12 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
    #13 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
    #14 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    [RFC] sparse index: fix use-after-free bug in cache_tree_verify()
    
    Changes since V3
    
     * removed "-q" from the test [1]. This is the same as V2 with a typo
       fixed in the commit message
    
    [1] https://lore.kernel.org/git/
    e281c2e2-2044-1a11-e2bc-5ab3ee92c300@gmail.com/
    
    Changes since V2
    
     * Fixed the spelling of Stolee's name (sorry Stolee)
     * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
    
    [1]
    https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/
    
    Thanks for the feedback and help, here are the changes from the RFC
    
     * Updated commit message and comments to make it clear this is
       triggered by a sparse index with a full cache tree based on Stolee's
       explanation.
     * Added a comment and BUG() suggested by Junio
    
    RFC cover letter In a sparse index it is possible for the tree that is
    being verified to be freed while it is being verified. This is an RFC as
    I'm not familiar with the cache tree code. I'm confused as to why this
    bug is triggered by the sequence
    
    unpack_trees()
    prime_cache_tree()
    write_locked_index()
    
    
    but not
    
    unpack_trees()
    write_locked_index()
    
    
    as unpack_trees() appears to update the cache tree with
    
    if (!cache_tree_fully_valid(o->result.cache_tree))
                cache_tree_update(&o->result,
                          WRITE_TREE_SILENT |
                          WRITE_TREE_REPAIR);
    
    
    and I don't understand why the cache tree from prime_cache_tree()
    results in different behavior. It concerns me that this fix is hiding
    another bug.
    
    Best Wishes
    
    Phillip

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1053%2Fphillipwood%2Fwip%2Fsparse-index-fix-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1053/phillipwood/wip/sparse-index-fix-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1053

Range-diff vs v3:

 1:  b3dbe02fcc3 ! 1:  ea7e93e1a47 sparse index: fix use-after-free bug in cache_tree_verify()
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and rese
       	init_repos &&
       
      -	for OPERATION in "merge -m merge" cherry-pick rebase
     -+	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
     ++	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
       	do
       		test_all_match git checkout -B temp update-deep &&
       		test_all_match git $OPERATION update-folder1 &&


 cache-tree.c                             | 37 +++++++++++++++++++-----
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 90919f9e345..8044e21bcf3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -826,10 +826,17 @@ static void verify_one_sparse(struct repository *r,
 		    path->buf);
 }
 
-static void verify_one(struct repository *r,
-		       struct index_state *istate,
-		       struct cache_tree *it,
-		       struct strbuf *path)
+/*
+ * Returns:
+ *  0 - Verification completed.
+ *  1 - Restart verification - a call to ensure_full_index() freed the cache
+ *      tree that is being verified and verification needs to be restarted from
+ *      the new toplevel cache tree.
+ */
+static int verify_one(struct repository *r,
+		      struct index_state *istate,
+		      struct cache_tree *it,
+		      struct strbuf *path)
 {
 	int i, pos, len = path->len;
 	struct strbuf tree_buf = STRBUF_INIT;
@@ -837,21 +844,30 @@ static void verify_one(struct repository *r,
 
 	for (i = 0; i < it->subtree_nr; i++) {
 		strbuf_addf(path, "%s/", it->down[i]->name);
-		verify_one(r, istate, it->down[i]->cache_tree, path);
+		if (verify_one(r, istate, it->down[i]->cache_tree, path))
+			return 1;
 		strbuf_setlen(path, len);
 	}
 
 	if (it->entry_count < 0 ||
 	    /* no verification on tests (t7003) that replace trees */
 	    lookup_replace_object(r, &it->oid) != &it->oid)
-		return;
+		return 0;
 
 	if (path->len) {
+		/*
+		 * If the index is sparse and the cache tree is not
+		 * index_name_pos() may trigger ensure_full_index() which will
+		 * free the tree that is being verified.
+		 */
+		int is_sparse = istate->sparse_index;
 		pos = index_name_pos(istate, path->buf, path->len);
+		if (is_sparse && !istate->sparse_index)
+			return 1;
 
 		if (pos >= 0) {
 			verify_one_sparse(r, istate, it, path, pos);
-			return;
+			return 0;
 		}
 
 		pos = -pos - 1;
@@ -899,6 +915,7 @@ static void verify_one(struct repository *r,
 		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
 	strbuf_setlen(path, len);
 	strbuf_release(&tree_buf);
+	return 0;
 }
 
 void cache_tree_verify(struct repository *r, struct index_state *istate)
@@ -907,6 +924,10 @@ void cache_tree_verify(struct repository *r, struct index_state *istate)
 
 	if (!istate->cache_tree)
 		return;
-	verify_one(r, istate, istate->cache_tree, &path);
+	if (verify_one(r, istate, istate->cache_tree, &path)) {
+		strbuf_reset(&path);
+		if (verify_one(r, istate, istate->cache_tree, &path))
+			BUG("ensure_full_index() called twice while verifying cache tree");
+	}
 	strbuf_release(&path);
 }
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 886e78715fe..85d5279b33c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-	for OPERATION in "merge -m merge" cherry-pick rebase
+	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
 	do
 		test_all_match git checkout -B temp update-deep &&
 		test_all_match git $OPERATION update-folder1 &&

base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
gitgitgadget
