Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFDECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 00:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiJ1AqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiJ1AqF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 20:46:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE14B9BB
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:46:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h9so5005092wrt.0
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 17:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWPqpZYEtT/kkQZFdpfFj+ZWJ1izqjLcz0kxaN8IKqQ=;
        b=F2L4Dh1Ezj17U6uSgYMmIbfTugiYQj9y1diHnO0+aGppT23iplSnmrNuwq6suzja1o
         rXKD0YI4iGLOEjK0YG2kTn1tpJUR7gQMeGAsR3Z9rILSuXNitm6F+SiPzHfLcYCMa9qG
         FlgV4yHa1FwUM/swAJK6yUdvy31DTO67acvv7Kl6sMsNYfOODE8I3vw2Csqwt42hBdFP
         Id9JzizY2oVMXZdEOfyXDChiBTpIxSMISqQK+hOn6X0eQQl5id/yqgMgJWRJNYdEcgH6
         2POIhurXNdW0yrfUh0gScqi1CdruHQySiiwhcTe2dhfmZNrxL1wOpMHj/NIxsgdvRFut
         9E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWPqpZYEtT/kkQZFdpfFj+ZWJ1izqjLcz0kxaN8IKqQ=;
        b=CnKkn1Uy0DpaoVvH9Z1Y32sO9IzA0DFB9Hu7kC5H4QjIlEa/ypNC+XTRfSSd79vPLY
         leBEeThvPYbixzFBz8/k+LPyPyCG4s3z+at3CqYAf/9suF1ijtWFpnA8MjKHXKe78xK/
         YjkHSNDdmqZQIQjbfnwBZm4M8M+UyH1o+pm6AuCQZUK6P2xQ3WsyPkG26/4700+hqjZo
         LJVm8/u7hb+JTGaPns8M1zR2+W/4gmJblcqW+Ealltkm2w4QUOnUDlhDHI9ejv04Yjg3
         5aDXIFMC9nomZTYlmuvc5KAEwHtt6Nhsb5Iw0kGCTVZtLJIMG3CtLY1xP2VMbAJxtdX+
         zLGg==
X-Gm-Message-State: ACrzQf3aoPTm1/eExMhIc0pKgpEIbwE/NiWExTGSLRcGk2OKr4OLixb1
        mJsMMApowQn1ZHlVG+2L8vXGJI3WI0E=
X-Google-Smtp-Source: AMsMyM7ewmtplggRDsJPVbidYnlMMM0RGwhe1r5jNed0WLzrpBkrB6HQbUoyqfE2cbfVrCrSXVPKfw==
X-Received: by 2002:adf:dbc7:0:b0:236:4edb:d7c5 with SMTP id e7-20020adfdbc7000000b002364edbd7c5mr25243808wrj.197.1666917962748;
        Thu, 27 Oct 2022 17:46:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh17-20020a05600c3d1100b003cf47fdead5sm2850660wmb.30.2022.10.27.17.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 17:46:02 -0700 (PDT)
Message-Id: <pull.1368.v2.git.git.1666917961644.gitgitgadget@gmail.com>
In-Reply-To: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
References: <pull.1368.git.git.1666742722502.gitgitgadget@gmail.com>
From:   "Anh Le via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 00:46:01 +0000
Subject: [PATCH v2] index: add trace2 region for clear skip worktree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>, Anh Le <anh@canva.com>,
        Anh Le <anh@canva.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Anh Le <anh@canva.com>

In a large repository using sparse checkout, checking
whether a file marked with skip worktree is present
on disk and its skip worktree bit should be cleared
can take a considerable amount of time. Add a trace2
region to surface this information, keeping a count of how many paths
have been checked and separately
keep counts for after a full index is
materialised.

Signed-off-by: Anh Le <anh@canva.com>
---
    index: add trace2 region for clear skip worktree
    
    In large repository using sparse checkout, checking whether a file
    marked with skip worktree is present on disk and its skip worktree bit
    should be cleared can take a considerable amount of time. Add a trace2
    region to surface this information.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1368%2FHaizzz%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1368/Haizzz/master-v2
Pull-Request: https://github.com/git/git/pull/1368

Range-diff vs v1:

 1:  7d1bb3cba2a ! 1:  effe6b5b912 index: add trace2 region for clear skip worktree
     @@ Commit message
          whether a file marked with skip worktree is present
          on disk and its skip worktree bit should be cleared
          can take a considerable amount of time. Add a trace2
     -    region to surface this information.
     +    region to surface this information, keeping a count of how many paths
     +    have been checked and separately
     +    keep counts for after a full index is
     +    materialised.
      
          Signed-off-by: Anh Le <anh@canva.com>
      
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
       	int dir_found = 1;
       
       	int i;
     -+	intmax_t path_count = 0;
     -+	intmax_t restart_count = 0;
     ++	int path_counts[2] = {0, 0};
     ++	int restarted = 0;
       
       	if (!core_apply_sparse_checkout ||
       	    sparse_expect_files_outside_of_patterns)
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
      -				ensure_full_index(istate);
      -				goto restart;
      +		if (ce_skip_worktree(ce)) {
     -+			path_count++;
     ++			path_counts[restarted]++;
      +			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
      +				if (S_ISSPARSEDIR(ce->ce_mode)) {
      +					ensure_full_index(istate);
     -+					restart_count++;
     ++					restarted = 1;
      +					goto restart;
      +				}
      +				ce->ce_flags &= ~CE_SKIP_WORKTREE;
     @@ sparse-index.c: void clear_skip_worktree_from_present_files(struct index_state *
      -			ce->ce_flags &= ~CE_SKIP_WORKTREE;
       		}
       	}
     -+	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_count);
     -+	trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/restart_count", restart_count);
     ++
     ++	if (path_counts[0] > 0) {
     ++		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_counts[0]);
     ++	}
     ++	if (restarted) {
     ++		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/full_index/path_count", path_counts[1]);
     ++	}
      +	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
       }
       


 sparse-index.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e4a54ce1943..dbf647949c1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -493,24 +493,38 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	int dir_found = 1;
 
 	int i;
+	int path_counts[2] = {0, 0};
+	int restarted = 0;
 
 	if (!core_apply_sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
+	trace2_region_enter("index", "clear_skip_worktree_from_present_files", istate->repo);
 restart:
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 
-		if (ce_skip_worktree(ce) &&
-		    path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
-			if (S_ISSPARSEDIR(ce->ce_mode)) {
-				ensure_full_index(istate);
-				goto restart;
+		if (ce_skip_worktree(ce)) {
+			path_counts[restarted]++;
+			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+				if (S_ISSPARSEDIR(ce->ce_mode)) {
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
+	if (path_counts[0] > 0) {
+		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/path_count", path_counts[0]);
+	}
+	if (restarted) {
+		trace2_data_intmax("index", istate->repo, "clear_skip_worktree_from_present_files/full_index/path_count", path_counts[1]);
+	}
+	trace2_region_leave("index", "clear_skip_worktree_from_present_files", istate->repo);
 }
 
 /*

base-commit: 1fc3c0ad407008c2f71dd9ae1241d8b75f8ef886
-- 
gitgitgadget
