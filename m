Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77531C43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CFE2077D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmMIyHBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCUSAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33233 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgCUSAS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id z65so11175000ede.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EIfvVbBkvScmJvnbKGVGvOAliCWTnbb9adsE63m/+RU=;
        b=NmMIyHBzdcYLtNFC4QX4RiIY8cz6iLe0nCNuHlGDxT+bREvJ6X7wTKHxpPez/SaLio
         SJckNRiffOgiEFWeVl9nz2KlZdBQF0XlTH+EvZJCZP0Dt/jSBLkZ930PY6Gj7EOa8+4E
         99iWOSGhluKpFId+GcY9txXM66JT8komSYmCeOJyZP6XLeGjSIDvpoz1xv5C86X/Qb7R
         P+S6DxtZuBEuzJURLNHY23suRVVzVUdpJcQ+fv/lIBeBy6VRqNrVe681vDi8T3nmqEVv
         6bGzDpEcPNd0YvWETrLNma5/pFQMo1f9y2F8GTT30L/GRtCiMUBrO/+hcj4OjjIOVa6p
         2Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EIfvVbBkvScmJvnbKGVGvOAliCWTnbb9adsE63m/+RU=;
        b=T+ENgy4j8lqrrh7G0pvMRtZzxflT5xpHg35YE32lekmdpcMdroZsehNC5K99VlZSk1
         SGV+z9NvKaTQu6Kdzhjb+0MvYN3XEh1HpfggDM4jZtwMzwdZDDb0D9yXZ9u4gB3KwXBO
         7r6g/vhuzqVXX35kwepak4QDSSlBFO/0ph5yu+gB8Z2bj25mFCqAixvizFEH8jgQUbjy
         pw9RIARmSsSkUa3xamg4Iq/gvf2ibdXsgol0AXWmRq+YWsZRqg1nXnu0fflvr2Le3rL+
         oL8rURYuFckutpzHuM/b51i71hiozkfbE911fm9te7xxk/VTvJDjGftTBjl80Fq8HT7A
         8kyQ==
X-Gm-Message-State: ANhLgQ0CLaLypsJobsjPQJTtGp3dkmUr6esaTjfdRiKuYmjNFMMLqrDs
        NqxLxEZBkZDgJWWEgW3IwJG7OvZf
X-Google-Smtp-Source: ADFU+vuQvHaT51AlRJjDotY5YsIkm7m7N86eVkm86R2vdEd7Ww5KyY30tCbHaD4hqw1wOBC0qG3hrw==
X-Received: by 2002:a05:6402:1002:: with SMTP id c2mr14467804edu.185.1584813616044;
        Sat, 21 Mar 2020 11:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id nh1sm597945ejb.72.2020.03.21.11.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:15 -0700 (PDT)
Message-Id: <27d6304d33f568c185219f76e47c53ecf9fe8b43.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:59 +0000
Subject: [PATCH v2 08/18] unpack-trees: pull sparse-checkout pattern reading
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

