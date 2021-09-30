Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE39C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C374B61A55
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbhI3OxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351588AbhI3Owv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E35BC06176D
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so8670825wmb.3
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2HRlxeP3tz/uNY5+unoDO9/v7e3CHEEqIbEgAsKvEsY=;
        b=TJdDPhNdD2GGzb+ll2IqaLMvZWfxOf6OtyRjlMgLyi0UvAhBlqV6nIEAITZS8o+u7s
         XW0/+pctnztXaEXGW9ldtaCKbb0sn450Sq4K2qUxKjW8T51bvqzFdKiF35sD4itamjef
         9RYWF+odCfkkINGF4HF9glsvk6S6L/rLYg8xV6BMDaDYK+tCVjv/orh/ZA9mvYBzIFnJ
         QIbWkisKBMJjHQagHR8kS1VdrrjoCft6ImB5PQs26cGzb0mhHAabZX6wLRXiqWWn2Dxd
         Rn1w7ayHxYnb7lCyQkpKwV4tGGwyD2wIcAp7HFVy1ZYvNp6gKivdHPTGyeayFrBa7NAE
         syQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2HRlxeP3tz/uNY5+unoDO9/v7e3CHEEqIbEgAsKvEsY=;
        b=f7JfqazWVL5eBBHjM6v/zGi/aGGpXWhms8BQ8qsS4YHPKekLCWwy84pW2l+mwvuhuj
         8zF1D4LEhh16prJ3JHgV5UChduzgiAJhZj/AWT1HNYsBAKEyXkaM5L97ubBCi2DNpuYa
         V4okjLPWo7xp5PzQKHTrO3PmOsz5/kmLs3x84rgN86s7+3myDl084R9uJhcBoTtVkmD1
         h/ZafbqyNpUBFpGzZFB1PDVk8LFKZRC5qpv3rd6j4tAzHl0hSpB/bwTM7QrIlnLFnVTa
         je4XQZKhKCzwTatnU7n893LY73lpr+phKPd9NUEtzOHv85JdJLTR5u50kEkCeQGqxBct
         Sj7A==
X-Gm-Message-State: AOAM531Grxj9uoCxIGSo+GUk4BYRD1YkQ7j2qVkBijzTbdP1ewprpYpW
        hrGQ8d9urG78iT9lTsG2qrz1cBhhDq8=
X-Google-Smtp-Source: ABdhPJytIMA/tirUJ/BTtebDz6c7MXieobae8KCc0YQ0u3AF1u39IOayRV47Bm1dtIUxQecfC6up6g==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr16270216wml.93.1633013467213;
        Thu, 30 Sep 2021 07:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j27sm3792093wms.6.2021.09.30.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
Message-Id: <8637ec1660ebb1b19f1f73c38debb7b098187e6f.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:51:01 +0000
Subject: [PATCH 7/7] unpack-trees: improve performance of next_cache_entry
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

To find the first non-unpacked cache entry, `next_cache_entry` iterates
through index, starting at `cache_bottom`. The performance of this in full
indexes is helped by `cache_bottom` advancing with each invocation of
`mark_ce_used` (called by `unpack_index_entry`). However, the presence of
sparse directories can prevent the `cache_bottom` from advancing in a sparse
index case, effectively forcing `next_cache_entry` to search from the
beginning of the index each time it is called.

The `cache_bottom` must be preserved for the sparse index (see 17a1bb570b
(unpack-trees: preserve cache_bottom, 2021-07-14)).  Therefore, to retain
the benefit `cache_bottom` provides in non-sparse index cases, a separate
`hint` position indicates the first position `next_cache_entry` should
search, updated each execution with a new position.  The performance of `git
reset -- does-not-exist` (testing the "worst case" in which all entries in
the index are unpacked with `next_cache_entry`) is significantly improved
for the sparse index case:

Test          before            after
------------------------------------------------------
(full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
(full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%
(sparse-v3)   0.76(0.43+0.69)   0.44(0.08+0.67) -42.1%
(sparse-v4)   0.71(0.40+0.65)   0.41(0.09+0.65) -42.3%

Signed-off-by: Victoria Dye <vdye@github.com>
---
 unpack-trees.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 8ea0a542da8..b94733de6be 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -645,17 +645,24 @@ static void mark_ce_used_same_name(struct cache_entry *ce,
 	}
 }
 
-static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o, int *hint)
 {
 	const struct index_state *index = o->src_index;
 	int pos = o->cache_bottom;
 
+	if (*hint > pos)
+		pos = *hint;
+
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED))
+		if (!(ce->ce_flags & CE_UNPACKED)) {
+			*hint = pos + 1;
 			return ce;
+		}
 		pos++;
 	}
+
+	*hint = pos;
 	return NULL;
 }
 
@@ -1365,12 +1372,13 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
+		int hint = -1;
 		while (1) {
 			int cmp;
 			struct cache_entry *ce;
 
 			if (o->diff_index_cached)
-				ce = next_cache_entry(o);
+				ce = next_cache_entry(o, &hint);
 			else
 				ce = find_cache_entry(info, p);
 
@@ -1690,7 +1698,7 @@ static int verify_absent(const struct cache_entry *,
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
 	struct repository *repo = the_repository;
-	int i, ret;
+	int i, hint, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
@@ -1763,13 +1771,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.pathspec = o->pathspec;
 
 		if (o->prefix) {
+			hint = -1;
+
 			/*
 			 * Unpack existing index entries that sort before the
 			 * prefix the tree is spliced into.  Note that o->merge
 			 * is always true in this case.
 			 */
 			while (1) {
-				struct cache_entry *ce = next_cache_entry(o);
+				struct cache_entry *ce = next_cache_entry(o, &hint);
 				if (!ce)
 					break;
 				if (ce_in_traverse_path(ce, &info))
@@ -1790,8 +1800,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
+		hint = -1;
 		while (1) {
-			struct cache_entry *ce = next_cache_entry(o);
+			struct cache_entry *ce = next_cache_entry(o, &hint);
 			if (!ce)
 				break;
 			if (unpack_index_entry(ce, o) < 0)
-- 
gitgitgadget
