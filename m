Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8350C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiCPUNf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357363AbiCPUNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:13:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B96E37D
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h23so3918507wrb.8
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xrp8MT8ACTXGNJUVhneG1R5rYubVZNSKTK4YRPw0Nmw=;
        b=qCG8S7ZOZOa7MD9/N2PH5fyyrPg+UT+kbT1D4kdHdUrA3TCr0vtLZwffl8UTIgtOEo
         dauiUm/vAcBR6ejQ+tigbSUU4IjehK3GEAmmG/O9A3k+XlDDmLVeYBHtZxWFglbQy/pe
         N+/oRR5JVFyNZ31GLa4XVr8vVLj6jgOApHCEQ4RTLYr6AyOUOdzfQJ9YIT0i/lb37kgl
         U14OKl85Iipi3BPeD0v2I24WxSQqyPUKQtrerX07SYuvFmItvPToyNG+TjDjwTh9NOIf
         h1buVOB7oHvk6m7bTV/lMFFXzYMrBJD4qAXVOltpOZ7Mm9gxn5eVhT66ciuTbgnAOjS0
         /pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xrp8MT8ACTXGNJUVhneG1R5rYubVZNSKTK4YRPw0Nmw=;
        b=NMSOoaV8HjQCnIPWwclH2nj95LpzEeMZcTNoO/EvgbHWH4OMs2JC49YSj09KxaECQK
         4bIS285kVB0GmaJAkJPWPQWCiZlvVcKL9Ejh9KVQlp1M+9GUopiF57KECuRZXFUwyyTW
         pj5iuIXNDoPB56ueiVqXOFurnDkiqhfPBo/LXuu1F7P2JxEX/8py8loz3LnMG9yWrDZ6
         Rc2YWa15etXXb9tj8wafqOT/BkhFqv2jF9V/ZUp9YCZiLsoxXkKcJJMa8SAAI4dchW2A
         eEkvPfIwLNdbHyHP2bvHGxr2h/WrtvRVQP8xP9idn0IEqDqep7Plkf0NZsAfbFL/9xVH
         cHGQ==
X-Gm-Message-State: AOAM533cb2lAxk+5iy58c+ir1ry+cZuhYAb6S/GjY169xydtBEQ20FbO
        z1d2KmXqcUPaD7ncBiZtf/0XAy7WnA0=
X-Google-Smtp-Source: ABdhPJxx1iAPCRh734fKNUkslZqdWDilToXvjrDVrEk3Q1j5cB9utjBh6kFcMjPPfUu9sq/xes4TcQ==
X-Received: by 2002:a5d:6d44:0:b0:1e4:9a6d:c171 with SMTP id k4-20020a5d6d44000000b001e49a6dc171mr1303890wri.468.1647461526921;
        Wed, 16 Mar 2022 13:12:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b0038c6d38b42fsm2800590wmq.36.2022.03.16.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:12:06 -0700 (PDT)
Message-Id: <ec6b9686e8f388a3edc42c9b51372cf062ae5699.1647461522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 20:12:02 +0000
Subject: [PATCH 3/3] Revert "unpack-trees: improve performance of
 next_cache_entry"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

This reverts commit f2a454e0a5 (unpack-trees: improve performance of
next_cache_entry, 2021-11-29).

The "hint" value was originally needed to improve performance in 'git reset
-- <pathspec>' caused by 'cache_bottom' lagging behind its correct value
when using a sparse index. The 'cache_bottom' tracking has since been
corrected, removing the need for an additional "pseudo-cache_bottom"
tracking variable.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index aac927faf08..7e5715c42b3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -644,24 +644,17 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 	}
 }
 
-static struct cache_entry *next_cache_entry(struct unpack_trees_options *o, int *hint)
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 {
 	const struct index_state *index = o->src_index;
 	int pos = o->cache_bottom;
 
-	if (*hint > pos)
-		pos = *hint;
-
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED)) {
-			*hint = pos + 1;
+		if (!(ce->ce_flags & CE_UNPACKED))
 			return ce;
-		}
 		pos++;
 	}
-
-	*hint = pos;
 	return NULL;
 }
 
@@ -1373,13 +1366,12 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
-		int hint = -1;
 		while (1) {
 			int cmp;
 			struct cache_entry *ce;
 
 			if (o->diff_index_cached)
-				ce = next_cache_entry(o, &hint);
+				ce = next_cache_entry(o);
 			else
 				ce = find_cache_entry(info, p);
 
@@ -1706,7 +1698,7 @@ static int verify_absent(const struct cache_entry *,
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	struct repository *repo = the_repository;
-	int i, hint, ret;
+	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
@@ -1795,15 +1787,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
-			hint = -1;
-
 			/*
 			 * Unpack existing index entries that sort before the
 			 * prefix the tree is spliced into.  Note that o->merge
 			 * is always true in this case.
 			 */
 			while (1) {
-				struct cache_entry *ce = next_cache_entry(o, &hint);
+				struct cache_entry *ce = next_cache_entry(o);
 				if (!ce)
 					break;
 				if (ce_in_traverse_path(ce, &info))
@@ -1824,9 +1814,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
-		hint = -1;
 		while (1) {
-			struct cache_entry *ce = next_cache_entry(o, &hint);
+			struct cache_entry *ce = next_cache_entry(o);
 			if (!ce)
 				break;
 			if (unpack_index_entry(ce, o) < 0)
-- 
gitgitgadget
