Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57786C2D0EC
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3178720719
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="togpbffl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgC0AtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44548 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgC0AtM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so9414117wrw.11
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yBv5qNEPdqGZgAGt3McRF7qBENlsktMTkf1A68Bjr4I=;
        b=togpbfflm0wC5SOT/8N1xZ1+mfmFySwiyIwLqlXUrgvzRLkHRKPpGZmk4U6Hn+Z1TW
         gVC/NaqkWiK2FMxEKXLthDFHN++LwMxRY62bbuYGlSySDvYrAJyVvOsXC+xgULtyuBpO
         9XyMyVT97fzGynyW+GOGrQQCPvyWrJtxOtynrkWxA0TGQLd44TD/wY2oldRZoG67HXwa
         igfjqonZr3AhJMCEOYI9eRy/dzl4KWygSo8WmpianIKQ/DTaAWuH04WyuhsCm3f6vmSV
         3AfxTpuMmhyb5WooWBXHCz2YQo3gxn6WXUjkC3vEtU1zyDiLOsxPkJZ2q30fIwVi1pU3
         cPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yBv5qNEPdqGZgAGt3McRF7qBENlsktMTkf1A68Bjr4I=;
        b=l+F0tb4m9G5f6iGHTyxaaxwlf5aB6HfurPcc39142oLf9fkLGbmuMV6WFsqmuO5bGc
         bWzPY2EH9LIWgjpCcFmsmZJQSuYs+2tSFZREmS9kU5963QiySlRKDd1iuh0ARYgFur3p
         PpKQNpW4Os7Jjdmd/dilAfEDRNy2kxEtjNdfJkzSrU5jXvZ6iSGj9B5TpaYlJmCu1q2E
         CUmtJk40JRqL8+xtPoYZXsiOltAHBz9oqkd84l4eZyWPbqZ4v+wtAdoY0bFom7rCcOBU
         Gk/pF/Wwcv8BGooDXpOvj3YTcl9PCdTE963Gv0U/InCf0+s2ro73uQXOZCPxuvY8wAx5
         lYBg==
X-Gm-Message-State: ANhLgQ15WlO8iam2+ZWMDmsBPEF8WDQUR4wbj3FFrnG3FUu7hCZX08eE
        ksW0FU23aROozVMvt0YMaYB1zB04
X-Google-Smtp-Source: ADFU+vtJq/qd12NUqSS+OZ0LJBOlFSabBQ9SwbGvCd6OyyAsS+C57mEsFdatKvik8az8N7nI63RAGg==
X-Received: by 2002:adf:9dca:: with SMTP id q10mr11823379wre.11.1585270149392;
        Thu, 26 Mar 2020 17:49:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm6078419wrx.90.2020.03.26.17.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:09 -0700 (PDT)
Message-Id: <8ed2f4e49ed80626292013f55dc5164f0eaad98b.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:51 +0000
Subject: [PATCH v3 08/18] unpack-trees: pull sparse-checkout pattern reading
 into a new function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Create a populate_from_existing_patterns() function for reading the
path_patterns from $GIT_DIR/info/sparse-checkout so that we can re-use
it elsewhere.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e8e794880ab..4733e7eaf89 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1492,6 +1492,20 @@ static void mark_new_skip_worktree(struct pattern_list *pl,
 	clear_ce_flags(istate, select_flag, skip_wt_flag, pl, show_progress);
 }
 
+static void populate_from_existing_patterns(struct unpack_trees_options *o,
+					    struct pattern_list *pl)
+{
+	char *sparse = git_pathdup("info/sparse-checkout");
+
+	pl->use_cone_patterns = core_sparse_checkout_cone;
+	if (add_patterns_from_file_to_list(sparse, "", 0, pl, NULL) < 0)
+		o->skip_sparse_checkout = 1;
+	else
+		o->pl = pl;
+	free(sparse);
+}
+
+
 static int verify_absent(const struct cache_entry *,
 			 enum unpack_trees_error_types,
 			 struct unpack_trees_options *);
@@ -1512,18 +1526,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 
 	trace_performance_enter();
-	memset(&pl, 0, sizeof(pl));
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout && !o->pl) {
-		char *sparse = git_pathdup("info/sparse-checkout");
-		pl.use_cone_patterns = core_sparse_checkout_cone;
-		if (add_patterns_from_file_to_list(sparse, "", 0, &pl, NULL) < 0)
-			o->skip_sparse_checkout = 1;
-		else
-			o->pl = &pl;
-		free(sparse);
+		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
+		populate_from_existing_patterns(o, &pl);
 	}
 
 	memset(&o->result, 0, sizeof(o->result));
-- 
gitgitgadget

