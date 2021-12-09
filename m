Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49923C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 10:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhLIKeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbhLIKeB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 05:34:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E715C061D76
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 02:30:26 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so3689980wms.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 02:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p5cnPMQKbgHXVyVGUj+cefY7DiWcqcJMbT+NkgNsm8c=;
        b=CG4Zy+soFpCevMahk2DcIx2BpN/38fzKT8MJcvFm4dhrdmKmbDvC+nkg37fjNKHcDM
         kbeRHZJijkr6o/KtuMzhatbCslRRLTSLQ6j2vwhBiP9KdXjOiYGFyhtfhza9e6EI0yb4
         MHkLyU5E8GSu5lde6vWk2aT20dNjEX9i2m8EXoXoSEYzP23w3ezVXAKdPBfRXwumtCDE
         SWdKPRjCbDsDM0awTvYz3CjegPuiPdCNsedWtYKu+ifnY839hlO/URIyBzRewoJuMT/b
         CHidEVT0SlJyknTPNRETBmAxwgW2fPW7XffKxE6j8JaYrHIOj4SrBFR7fTmBnhTgEJqR
         GyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p5cnPMQKbgHXVyVGUj+cefY7DiWcqcJMbT+NkgNsm8c=;
        b=Jq+xN6NvnVXK0eAf9IOS2q9TUHoScYG/xLNoYZi3/CBK91TaO86wcEj8tOnAM1PqbD
         2Kg/baFT8ry0I/Zmxoq7v7S78wcWXxsN8d6Ee3/wvtgeZYhVy9J61O9l96DLbs3svnRI
         KIIuIgUN56Ma83r1XCTubgjZhpuqEZnXuWhhP1YhpD46YSRUNuSc0dbmjMqrvBe4w5wV
         ssZRZfcBSdRIzhcg4QRUj1xa35FMCZyI3iuWJ3J3E5gTp+OkfQh0Hd/+tAkPWarRuR3U
         YcrHg2XleCBOBXAaEIrOL01wSLkYbQE82KYVd6Zd1yxd0JDC+RHUz/snJ3xuTt7XN4r5
         KBVw==
X-Gm-Message-State: AOAM533PVZ7ldZUx8eGCK5MYDO6Itwkjd/Pv/1sabyjw+pmp5OstfmoW
        lh2bXcOHn+kaMMSYVr7575LqpnpEln8=
X-Google-Smtp-Source: ABdhPJxnBpKHYEQjAqbD0lQUFD71KTARUTKwAEFE6t25Jih+2zkd3+vaspa+zOfND6LNK4QzxHfTgQ==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr6284852wmc.62.1639045824482;
        Thu, 09 Dec 2021 02:30:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q123sm8034027wma.30.2021.12.09.02.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:30:24 -0800 (PST)
Message-Id: <350fa55ce5eaf92f000f52668dfa7c2485b8660a.1639045810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
References: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
        <pull.981.v5.git.1639045809.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:30:09 +0000
Subject: [PATCH v5 15/15] diff --color-moved: intern strings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Taking inspiration from xdl_classify_record() assign an id to each
addition and deletion such that lines that match for the current
--color-moved-ws mode share the same unique id. This reduces the
number of hash lookups a little (calculating the ids still involves
one hash lookup per line) but the main benefit is that when growing
blocks of potentially moved lines we can replace string comparisons
which involve chasing a pointer with a simple integer comparison. On a
large diff this commit reduces the time to run 'diff --color-moved' by
37% compared to the previous commit and 31% compared to master, for
'diff --color-moved-ws=allow-indentation-change' the reduction is 28%
compared to the previous commit and 96% compared to master. There is
little change in the performance of 'git log --patch' as the diffs are
smaller.

Test                                                                  HEAD^              HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38(0.33+0.05)    0.38(0.33+0.05)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.88(0.81+0.06)    0.55(0.50+0.04) -37.5%
4002.3: diff --color-moved-ws=allow-indentation-change large change   0.85(0.79+0.06)    0.61(0.54+0.06) -28.2%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16(1.07+0.08)    1.15(1.09+0.05)  -0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.31(1.22+0.08)    1.29(1.19+0.09)  -1.5%
4002.6: log --color-moved-ws=allow-indentation-change                 1.32(1.24+0.08)    1.31(1.18+0.13)  -0.8%

Test                                                                  master             HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.33+0.05)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.55(0.50+0.04) -31.2%
4002.3: diff --color-moved-ws=allow-indentation-change large change  14.20(14.15+0.05)   0.61(0.54+0.06) -95.7%
4002.4: log --no-color-moved --no-color-moved-ws                      1.15 (1.05+0.09)   1.15(1.09+0.05)  +0.0%
4002.5: log --color-moved --no-color-moved-ws                         1.30 (1.19+0.11)   1.29(1.19+0.09)  -0.8%
4002.6: log --color-moved-ws=allow-indentation-change                 1.70 (1.63+0.06)   1.31(1.18+0.13) -22.9%

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 174 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 96 insertions(+), 78 deletions(-)

diff --git a/diff.c b/diff.c
index 9ef88d7665a..c28c56c1283 100644
--- a/diff.c
+++ b/diff.c
@@ -18,6 +18,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "hashmap.h"
+#include "mem-pool.h"
 #include "ll-merge.h"
 #include "string-list.h"
 #include "strvec.h"
@@ -772,6 +773,7 @@ struct emitted_diff_symbol {
 	int flags;
 	int indent_off;   /* Offset to first non-whitespace character */
 	int indent_width; /* The visual width of the indentation */
+	unsigned id;
 	enum diff_symbol s;
 };
 #define EMITTED_DIFF_SYMBOL_INIT {NULL}
@@ -797,9 +799,9 @@ static void append_emitted_diff_symbol(struct diff_options *o,
 }
 
 struct moved_entry {
-	struct hashmap_entry ent;
 	const struct emitted_diff_symbol *es;
 	struct moved_entry *next_line;
+	struct moved_entry *next_match;
 };
 
 struct moved_block {
@@ -865,24 +867,24 @@ static int cmp_in_block_with_wsd(const struct moved_entry *cur,
 				 const struct emitted_diff_symbol *l,
 				 struct moved_block *pmb)
 {
-	int al = cur->es->len, bl = l->len;
-	const char *a = cur->es->line,
-		   *b = l->line;
-	int a_off = cur->es->indent_off,
-	    a_width = cur->es->indent_width,
-	    b_off = l->indent_off,
-	    b_width = l->indent_width;
+	int a_width = cur->es->indent_width, b_width = l->indent_width;
 	int delta;
 
-	/* If 'l' and 'cur' are both blank then they match. */
-	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
+	/* The text of each line must match */
+	if (cur->es->id != l->id)
+		return 1;
+
+	/*
+	 * If 'l' and 'cur' are both blank then we don't need to check the
+	 * indent. We only need to check cur as we know the strings match.
+	 * */
+	if (a_width == INDENT_BLANKLINE)
 		return 0;
 
 	/*
 	 * The indent changes of the block are known and stored in pmb->wsd;
 	 * however we need to check if the indent changes of the current line
-	 * match those of the current block and that the text of 'l' and 'cur'
-	 * after the indentation match.
+	 * match those of the current block.
 	 */
 	delta = b_width - a_width;
 
@@ -893,22 +895,26 @@ static int cmp_in_block_with_wsd(const struct moved_entry *cur,
 	if (pmb->wsd == INDENT_BLANKLINE)
 		pmb->wsd = delta;
 
-	return !(delta == pmb->wsd && al - a_off == bl - b_off &&
-		 !memcmp(a + a_off, b + b_off, al - a_off));
+	return delta != pmb->wsd;
 }
 
-static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
-			   const struct hashmap_entry *eptr,
-			   const struct hashmap_entry *entry_or_key,
-			   const void *keydata)
+struct interned_diff_symbol {
+	struct hashmap_entry ent;
+	struct emitted_diff_symbol *es;
+};
+
+static int interned_diff_symbol_cmp(const void *hashmap_cmp_fn_data,
+				    const struct hashmap_entry *eptr,
+				    const struct hashmap_entry *entry_or_key,
+				    const void *keydata)
 {
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct emitted_diff_symbol *a, *b;
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
-	a = container_of(eptr, const struct moved_entry, ent)->es;
-	b = container_of(entry_or_key, const struct moved_entry, ent)->es;
+	a = container_of(eptr, const struct interned_diff_symbol, ent)->es;
+	b = container_of(entry_or_key, const struct interned_diff_symbol, ent)->es;
 
 	return !xdiff_compare_lines(a->line + a->indent_off,
 				    a->len - a->indent_off,
@@ -916,55 +922,81 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 				    b->len - b->indent_off, flags);
 }
 
-static struct moved_entry *prepare_entry(struct diff_options *o,
-					 int line_no)
+static void prepare_entry(struct diff_options *o, struct emitted_diff_symbol *l,
+			  struct interned_diff_symbol *s)
 {
-	struct moved_entry *ret = xmalloc(sizeof(*ret));
-	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 	unsigned int hash = xdiff_hash_string(l->line + l->indent_off,
 					      l->len - l->indent_off, flags);
 
-	hashmap_entry_init(&ret->ent, hash);
-	ret->es = l;
-	ret->next_line = NULL;
-
-	return ret;
+	hashmap_entry_init(&s->ent, hash);
+	s->es = l;
 }
 
-static void add_lines_to_move_detection(struct diff_options *o,
-					struct hashmap *add_lines,
-					struct hashmap *del_lines)
+struct moved_entry_list {
+	struct moved_entry *add, *del;
+};
+
+static struct moved_entry_list *add_lines_to_move_detection(struct diff_options *o,
+							    struct mem_pool *entry_mem_pool)
 {
 	struct moved_entry *prev_line = NULL;
-
+	struct mem_pool interned_pool;
+	struct hashmap interned_map;
+	struct moved_entry_list *entry_list = NULL;
+	size_t entry_list_alloc = 0;
+	unsigned id = 0;
 	int n;
+
+	hashmap_init(&interned_map, interned_diff_symbol_cmp, o, 8096);
+	mem_pool_init(&interned_pool, 1024 * 1024);
+
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
-		struct hashmap *hm;
-		struct moved_entry *key;
+		struct interned_diff_symbol key;
+		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+		struct interned_diff_symbol *s;
+		struct moved_entry *entry;
 
-		switch (o->emitted_symbols->buf[n].s) {
-		case DIFF_SYMBOL_PLUS:
-			hm = add_lines;
-			break;
-		case DIFF_SYMBOL_MINUS:
-			hm = del_lines;
-			break;
-		default:
+		if (l->s != DIFF_SYMBOL_PLUS && l->s != DIFF_SYMBOL_MINUS) {
 			prev_line = NULL;
 			continue;
 		}
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			fill_es_indent_data(&o->emitted_symbols->buf[n]);
-		key = prepare_entry(o, n);
-		if (prev_line && prev_line->es->s == o->emitted_symbols->buf[n].s)
-			prev_line->next_line = key;
+			fill_es_indent_data(l);
 
-		hashmap_add(hm, &key->ent);
-		prev_line = key;
+		prepare_entry(o, l, &key);
+		s = hashmap_get_entry(&interned_map, &key, ent, &key.ent);
+		if (s) {
+			l->id = s->es->id;
+		} else {
+			l->id = id;
+			ALLOC_GROW_BY(entry_list, id, 1, entry_list_alloc);
+			hashmap_add(&interned_map,
+				    memcpy(mem_pool_alloc(&interned_pool,
+							  sizeof(key)),
+					   &key, sizeof(key)));
+		}
+		entry = mem_pool_alloc(entry_mem_pool, sizeof(*entry));
+		entry->es = l;
+		entry->next_line = NULL;
+		if (prev_line && prev_line->es->s == l->s)
+			prev_line->next_line = entry;
+		prev_line = entry;
+		if (l->s == DIFF_SYMBOL_PLUS) {
+			entry->next_match = entry_list[l->id].add;
+			entry_list[l->id].add = entry;
+		} else {
+			entry->next_match = entry_list[l->id].del;
+			entry_list[l->id].del = entry;
+		}
 	}
+
+	hashmap_clear(&interned_map);
+	mem_pool_discard(&interned_pool, 0);
+
+	return entry_list;
 }
 
 static void pmb_advance_or_null(struct diff_options *o,
@@ -973,7 +1005,6 @@ static void pmb_advance_or_null(struct diff_options *o,
 				int *pmb_nr)
 {
 	int i, j;
-	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
 	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
@@ -986,9 +1017,8 @@ static void pmb_advance_or_null(struct diff_options *o,
 			match = cur &&
 				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
 		else
-			match = cur &&
-				xdiff_compare_lines(cur->es->line, cur->es->len,
-						    l->line, l->len, flags);
+			match = cur && cur->es->id == l->id;
+
 		if (match) {
 			pmb[j] = pmb[i];
 			pmb[j++].match = cur;
@@ -998,7 +1028,6 @@ static void pmb_advance_or_null(struct diff_options *o,
 }
 
 static void fill_potential_moved_blocks(struct diff_options *o,
-					struct hashmap *hm,
 					struct moved_entry *match,
 					struct emitted_diff_symbol *l,
 					struct moved_block **pmb_p,
@@ -1012,7 +1041,7 @@ static void fill_potential_moved_blocks(struct diff_options *o,
 	 * The current line is the start of a new block.
 	 * Setup the set of potential blocks.
 	 */
-	hashmap_for_each_entry_from(hm, match, ent) {
+	for (; match; match = match->next_match) {
 		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
@@ -1067,8 +1096,7 @@ static int adjust_last_block(struct diff_options *o, int n, int block_length)
 
 /* Find blocks of moved code, delegate actual coloring decision to helper */
 static void mark_color_as_moved(struct diff_options *o,
-				struct hashmap *add_lines,
-				struct hashmap *del_lines)
+				struct moved_entry_list *entry_list)
 {
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
@@ -1077,23 +1105,15 @@ static void mark_color_as_moved(struct diff_options *o,
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
-		struct hashmap *hm = NULL;
-		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
-			hm = del_lines;
-			key = prepare_entry(o, n);
-			match = hashmap_get_entry(hm, key, ent, NULL);
-			free(key);
+			match = entry_list[l->id].del;
 			break;
 		case DIFF_SYMBOL_MINUS:
-			hm = add_lines;
-			key = prepare_entry(o, n);
-			match = hashmap_get_entry(hm, key, ent, NULL);
-			free(key);
+			match = entry_list[l->id].add;
 			break;
 		default:
 			flipped_block = 0;
@@ -1135,7 +1155,7 @@ static void mark_color_as_moved(struct diff_options *o,
 				 */
 				n -= block_length;
 			else
-				fill_potential_moved_blocks(o, hm, match, l,
+				fill_potential_moved_blocks(o, match, l,
 							    &pmb, &pmb_alloc,
 							    &pmb_nr);
 
@@ -6253,20 +6273,18 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
 	if (o->emitted_symbols) {
 		if (o->color_moved) {
-			struct hashmap add_lines, del_lines;
-
-			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
+			struct mem_pool entry_pool;
+			struct moved_entry_list *entry_list;
 
-			add_lines_to_move_detection(o, &add_lines, &del_lines);
-			mark_color_as_moved(o, &add_lines, &del_lines);
+			mem_pool_init(&entry_pool, 1024 * 1024);
+			entry_list = add_lines_to_move_detection(o,
+								 &entry_pool);
+			mark_color_as_moved(o, entry_list);
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
 				dim_moved_lines(o);
 
-			hashmap_clear_and_free(&add_lines, struct moved_entry,
-						ent);
-			hashmap_clear_and_free(&del_lines, struct moved_entry,
-						ent);
+			mem_pool_discard(&entry_pool, 0);
+			free(entry_list);
 		}
 
 		for (i = 0; i < esm.nr; i++)
-- 
gitgitgadget
