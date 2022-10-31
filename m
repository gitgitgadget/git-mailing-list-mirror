Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A34C38A02
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 00:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJaA4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 20:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJaA4g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 20:56:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC509FCD
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 17:56:34 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n39-20020a05600c3ba700b003cf71011cddso453277wms.1
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLSTT4Y0S82+uA6eyZqQ+Z8jE9SFVy8xDJz0CSRB6vY=;
        b=oDw3xmOS62IcKVOP86moQSWSOjCUDu/fFKEGEgPsSXpHd5w9j8yXxSr8zC/Y2iz3u1
         dm+V+hfSUCiwl+6Mm4JbsMM83x+V4hlYFFabOP7szKSv9v1ZAS06qZMDn62vUzTdmi8C
         muPDZ41Uw9ObU1/MMCHpVkA+FuzVYjQGn0uMMaoYZlChcdi4yJmzk9H4nfmgzmVYM7qm
         l+EIBcXAHIWIFquBilOtDC35sX44yD+l5iqTohLylRRYgOn/MNgH3n+/ZmSuyHQSTzqk
         2d1vVUJSqMLKVqvvVHvcDgwQzq8yaLHgdEDLAhZOeIIwqXQ4250sg1ytqIb93FpwPXOL
         blyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLSTT4Y0S82+uA6eyZqQ+Z8jE9SFVy8xDJz0CSRB6vY=;
        b=Ae7aJ1Ly1BPCLoeu+dD0YI/wSW53m+ZV5FoGdbuVwovujQtRVVDu9a9U9Fgb39h0Gd
         kZS/oBZeFc6WH7aGHBnRnkW8flnSMuMrLcLh4/ew4uSWR67drRJrrIrmplBUS6VP8qyY
         NpG0P5DiW5yPxt4TEVj33nLYttHZWK6+DEoxraBcKKOSQMc75+OQE9s3ySeEr8N7E0Jy
         HRWUbBDnjchudzcg/SpZf1L5BQ7Aut7xwCC1Df37YC4Lf6XHpokovdtC9kHicT56qbYG
         KpIM4oMSCJ7ULh8emTovvBDQ9dWHdgplV2M2COKAZmrqIAltjURFka7yP1zBTamWr0G2
         rCEw==
X-Gm-Message-State: ACrzQf3pFbia9c6b1gCN9+US5LWw1tuER2iRcj7Bu9JtH/7HNhJvxsUT
        0yTW23RaAp+2XqFBoVlmB6oqPVxxiWw=
X-Google-Smtp-Source: AMsMyM6TWgREA1k7CYMr+XLyRuD6OdVcP2sCL/AvLgs9trtdBge9P544gHBZ0Ga7IPmnjQ0OU4hYUg==
X-Received: by 2002:a05:600c:5122:b0:3c6:fcce:e4e2 with SMTP id o34-20020a05600c512200b003c6fccee4e2mr16690517wms.65.1667177792809;
        Sun, 30 Oct 2022 17:56:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d404b000000b002258235bda3sm5397384wrp.61.2022.10.30.17.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 17:56:32 -0700 (PDT)
Message-Id: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
In-Reply-To: <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
References: <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
From:   "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Oct 2022 00:56:31 +0000
Subject: [PATCH v3] index: add trace2 region for clear skip worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Anh Le <anh@canva.com>, Anh Le <anh@canva.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anh Le <anh@canva.com>

In a large repository using sparse checkout, checking whether a file marked
with skip worktree is present on disk and its skip worktree bit should be
cleared can take a considerable amount of time. Add a trace2 region to
surface this information, keeping a count of how many paths have been
checked and separately keep counts for after a full index is materialised.

Signed-off-by: Anh Le <anh@canva.com>
---
    index: add trace2 region for clear skip worktree
    
    In large repository using sparse checkout, checking whether a file
    marked with skip worktree is present on disk and its skip worktree bit
    should be cleared can take a considerable amount of time. Add a trace2
    region to surface this information.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1368%2FHaizzz%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1368/Haizzz/master-v3
Pull-Request: https://github.com/git/git/pull/1368

Range-diff vs v2:

 1:  effe6b5b912 ! 1:  d0d9f258b08 index: add trace2 region for clear skip worktree
     @@ Metadata
       ## Commit message ##
          index: add trace2 region for clear skip worktree
      
     -    In a large repository using sparse checkout, checking
     -    whether a file marked with skip worktree is present
     -    on disk and its skip worktree bit should be cleared
     -    can take a considerable amount of time. Add a trace2
     -    region to surface this information, keeping a count of how many paths
     -    have been checked and separately
     -    keep counts for after a full index is
     -    materialised.
     +    In a large repository using sparse checkout, checking whether a file marked
     +    with skip worktree is present on disk and its skip worktree bit should be
     +    cleared can take a considerable amount of time. Add a trace2 region to
     +    surface this information, keeping a count of how many paths have been
     +    checked and separately keep counts for after a full index is materialised.
      
          Signed-off-by: Anh Le <anh@canva.com>
      
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
       	int dir_found = 1;
       
       	int i;
     -+	int path_counts[2] = {0, 0};
     ++	int path_count[2] = {0, 0};
      +	int restarted = 0;
       
       	if (!core_apply_sparse_checkout ||
       	    sparse_expect_files_outside_of_patterns)
       		return;
       
     -+	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
     ++	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
     ++											istate->repo);
       restart:
       	for (i = 0; i < istate->cache_nr; i++) {
       		struct cache_entry *ce = istate->cache[i];
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
      -				ensure_full_index(istate);
      -				goto restart;
      +		if (ce_skip_worktree(ce)) {
     -+			path_counts[restarted]++;
     ++			path_count[restarted]++;
      +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
      +				if (S_ISSPARSEDIR(ce->ce_mode)) {
     ++					if (restarted)
     ++						BUG("ensure-full-index did not fully flatten?");
      +					ensure_full_index(istate);
      +					restarted = 1;
      +					goto restart;
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
       		}
       	}
      +
     -+	if (path_counts[0] > 0) {
     -+		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_counts[0]);
     -+	}
     -+	if (restarted) {
     -+		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/full_index/path_count", path_counts[1]);
     -+	}
     -+	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
     ++	if (path_count[0])
     ++		trace2_data_intmax("index", istate->repo,
     ++											 "sparse_path_count", path_count[0]);
     ++	if (restarted)
     ++		trace2_data_intmax("index", istate->repo,
     ++											 "sparse_path_count_full", path_count[1]);
     ++	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
     ++										  istate->repo);
       }
       
       /*


 sparse-index.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..8301129bf8f 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -493,24 +493,42 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	int dir_found = 1;
 
 	int i;
+	int path_count[2] = {0, 0};
+	int restarted = 0;
 
 	if (!core_apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files",
+											istate->repo);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
-		if (ce_skip_worktree(ce) &&
-		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
-			if (S_ISSPARSEDIR(ce->ce_mode)) {
-				ensure_full_index(istate);
-				goto restart;
+		if (ce_skip_worktree(ce)) {
+			path_count[restarted]++;
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+				if (S_ISSPARSEDIR(ce->ce_mode)) {
+					if (restarted)
+						BUG("ensure-full-index did not fully flatten?");
+					ensure_full_index(istate);
+					restarted = 1;
+					goto restart;
+				}
+				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 			}
-			ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
 	}
+
+	if (path_count[0])
+		trace2_data_intmax("index", istate->repo,
+											 "sparse_path_count", path_count[0]);
+	if (restarted)
+		trace2_data_intmax("index", istate->repo,
+											 "sparse_path_count_full", path_count[1]);
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files",
+										  istate->repo);
 }
 
 /*

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
