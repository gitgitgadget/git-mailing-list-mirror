Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D782FC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiEWNtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiEWNtC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:49:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5556426
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:49:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p10so2838446wrg.12
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jdp0Qd54vQ0o7G0FgNEa12/QQwj/dI/J4aERo2G5/G8=;
        b=W4Qd8+GWlf7CxOSrz2OFbOEytCLxiuhdu5mIiAQsGbv7+3JV8NZiRo49mJQ678+5VU
         6n3o4J9HfY2oL0blsg7R/tCIs6XXtu2+dkpmi+J5FkgLXLlORHWriFVi2lrILSbP8Lrq
         wT+vES8jRTdJxxScc0e1QvzZwS/E9NgRxf+A3fCx+CuyOW4m05cBPrF3lWiwG5pMkVii
         OYRloi13grC5D/nWosqiIGxGquFxhDDvl4vg2vGUYE/WGTUORZtgEG4FOxLrt7k0Hf7N
         iZ5QyZDRMlZmIWcKwMnryGQDLozARf/LYgLbc7KUUAS6bbGsTXv5d+EK/BOjDMt+Vxlm
         1j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jdp0Qd54vQ0o7G0FgNEa12/QQwj/dI/J4aERo2G5/G8=;
        b=S6RoP54e9B4sDRcmE8DMv69F8LY5zyfUDGX7iWM8vCA1A9Fo1yRu7V5iY7YVYv7Lqm
         /2r/pHY+n77HwV8iDNoDkatYm2ThNECfb0cG4ESOwol/s49B94r5eyXQ2DHKFOc29sJQ
         dQT1XSCuUM1UCoVDc+2DPrIg5uaXx5TvRiHBdovL5+QfYUe8ggWKIXU/5twGSdFvt6YF
         N75YvkhdWFFzwdYvO0YYhwan1QeeZHtUsGeW5a4VbDJfSD1AiJQAKcgpCMN+YAX+WjTl
         wQuaB6IKm2LJgSJ7EdXd56olNDqQenqawwOVeFyC1Y7F+x0z971m9XeaSo6jV+GNzS/D
         Yndg==
X-Gm-Message-State: AOAM532GwDmKHYcXi2VpGb22BPzFvo7MH+pR6VpCRbrJLbNGFno2mDtd
        OYJVqdVyuHGW15ulVdifHLGKvtBrHKw=
X-Google-Smtp-Source: ABdhPJxrfKM6JDhWepOYN+bYIDfGiXhdmYr6WD/1oQ0Mc1tU8LJLRH5ZGegS4PhotMZjml9aDC+oXA==
X-Received: by 2002:adf:ed8a:0:b0:20c:fe1d:d9e3 with SMTP id c10-20020adfed8a000000b0020cfe1dd9e3mr19237146wro.546.1653313738230;
        Mon, 23 May 2022 06:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h124-20020a1c2182000000b0039744bd664esm4188199wmh.13.2022.05.23.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:48:57 -0700 (PDT)
Message-Id: <b3cbfd3f136fffcf83c9bdf9b43fa8e4929c1052.1653313727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
References: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <pull.1208.v3.git.1653313726.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 13:48:44 +0000
Subject: [PATCH v3 08/10] sparse-index: complete partial expansion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

To complete the implementation of expand_to_pattern_list(), we need to
detect when a sparse directory entry should remain sparse. This avoids a
full expansion, so we now need to use the PARTIALLY_SPARSE mode to
indicate this state.

There still are no callers to this method, but we will add one in the
next change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sparse-index.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index a881f851810..2c0a18380f1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -308,8 +308,24 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	 * continue. A NULL pattern set indicates a full expansion to a
 	 * full index.
 	 */
-	if (pl && !pl->use_cone_patterns)
+	if (pl && !pl->use_cone_patterns) {
 		pl = NULL;
+	} else {
+		/*
+		 * We might contract file entries into sparse-directory
+		 * entries, and for that we will need the cache tree to
+		 * be recomputed.
+		 */
+		cache_tree_free(&istate->cache_tree);
+
+		/*
+		 * If there is a problem creating the cache tree, then we
+		 * need to expand to a full index since we cannot satisfy
+		 * the current request as a sparse index.
+		 */
+		if (cache_tree_update(istate, 0))
+			pl = NULL;
+	}
 
 	if (!istate->repo)
 		istate->repo = the_repository;
@@ -327,8 +343,14 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	full = xcalloc(1, sizeof(struct index_state));
 	memcpy(full, istate, sizeof(struct index_state));
 
+	/*
+	 * This slightly-misnamed 'full' index might still be sparse if we
+	 * are only modifying the list of sparse directories. This hinges
+	 * on whether we have a non-NULL pattern list.
+	 */
+	full->sparse_index = pl ? INDEX_PARTIALLY_SPARSE : INDEX_EXPANDED;
+
 	/* then change the necessary things */
-	full->sparse_index = 0;
 	full->cache_alloc = (3 * istate->cache_alloc) / 2;
 	full->cache_nr = 0;
 	ALLOC_ARRAY(full->cache, full->cache_alloc);
@@ -340,11 +362,22 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 		struct cache_entry *ce = istate->cache[i];
 		struct tree *tree;
 		struct pathspec ps;
+		int dtype;
 
 		if (!S_ISSPARSEDIR(ce->ce_mode)) {
 			set_index_entry(full, full->cache_nr++, ce);
 			continue;
 		}
+
+		/* We now have a sparse directory entry. Should we expand? */
+		if (pl &&
+		    path_matches_pattern_list(ce->name, ce->ce_namelen,
+					      NULL, &dtype,
+					      pl, istate) == NOT_MATCHED) {
+			set_index_entry(full, full->cache_nr++, ce);
+			continue;
+		}
+
 		if (!(ce->ce_flags & CE_SKIP_WORKTREE))
 			warning(_("index entry is a directory, but not sparse (%08x)"),
 				ce->ce_flags);
@@ -370,7 +403,7 @@ void expand_index(struct index_state *istate, struct pattern_list *pl)
 	/* Copy back into original index. */
 	memcpy(&istate->name_hash, &full->name_hash, sizeof(full->name_hash));
 	memcpy(&istate->dir_hash, &full->dir_hash, sizeof(full->dir_hash));
-	istate->sparse_index = 0;
+	istate->sparse_index = pl ? INDEX_PARTIALLY_SPARSE : INDEX_EXPANDED;
 	free(istate->cache);
 	istate->cache = full->cache;
 	istate->cache_nr = full->cache_nr;
-- 
gitgitgadget

