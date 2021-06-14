Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A52C4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43FD6124B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhFNNIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:08:02 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37519 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbhFNNH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:07:59 -0400
Received: by mail-wr1-f49.google.com with SMTP id i94so14449236wri.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=HacJdtXP0AcquE6qAwsWi9BJXoS7CDHQiN0WsBsx2Yo=;
        b=Rgpl67HjJbttKtzkp5PlNpCZbxA9AMVv3iNtTG/KbZDp0oULjAzTkkPL5zgutHKSel
         SKyKWItO0QRk+At9MKynYmsd+qZOX9c0cCBCZ2o3E2x9rPbIu88DOnceWqXf7F/BElFS
         LA4QkCLYKR7CqXEQOLMZqmJUR8a8flt80M6vu0UhQrkykl4ChkjwvpnGCOMEF6YWcfAm
         Nmeg2v/x3lEfHc9RpRVgRMsAJgxZdAkvL0C6yMLKlMD28slAyjUzhk+bs9Rapy2eFQmE
         KkGNtJWIO5vFmqfb8lBiMbdPfk1wxU6juaq/tw0WKlUsBmBmt9zHQHatf5zcNABM+/DZ
         CDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=HacJdtXP0AcquE6qAwsWi9BJXoS7CDHQiN0WsBsx2Yo=;
        b=hBF70N4RyAFWckxsZ7YsB7OLbzUjs7QOa5khynm6obCqjLvId0mlEXKKxN6hPqdnch
         oDuivbpmFhcc321Pe5AjE0H5XSmJ37tC1C19RJ6J2BmOAUzO7pSOHdZff2dBgSv8tGZ0
         vLBBkXeozzCQkk4gxue49U/awD8VLR+noTjn0R1oUeP1h9eHR9GyIcVUBBpMT5o6kqvw
         sA08EybgQ0JQbK3tNuUjFttcf2ttTblr/pXjwkPFQ/dZfEb/fmohC8gNCBioLWjFbUV0
         gyK+ILs8C8mk7GpSJcWDtDVXoXPhkhFKBYLzTnPQRG9xMjlCZ5GTDBvGiyUq4JWYz99n
         oJyQ==
X-Gm-Message-State: AOAM531cHN7ZhCWHXQHnVnx5v4WoMyqOOUT0Z687MDNPL0blF9hGRVwI
        OGPy/FXa/8otbA1E0bfdWeDP8kSS3Qg=
X-Google-Smtp-Source: ABdhPJwmRz1/ItEiPKi8ypxTebtjQFPCqtOJ1wG0lZmy/dhstuSwPrHC6B6foCDOIXP8UDOO0+Omkw==
X-Received: by 2002:adf:f7d2:: with SMTP id a18mr19299919wrq.111.1623675896125;
        Mon, 14 Jun 2021 06:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm8472332wmq.43.2021.06.14.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:55 -0700 (PDT)
Message-Id: <220664dd907ed5e2183722fa2e1877f62c7d762a.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:48 +0000
Subject: [PATCH 10/10] diff --color-moved: intern strings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
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
which involve chasing a pointer with a simple integer comparison.  On
a large diff this commit reduces the time to run 'diff --color-moved'
by 33% and 'diff --color-moved-ws=allow-indentation-change' by 20%.

Compared to master the time to run 'git log --patch --color-moved' is
increased by 2% and 'git log --patch
--color-moved-ws=allow-indentation-change' in reduced by 14%. These
timings were performed on an i5-7200U, on an i5-3470 both commands are
faster than master. The small speed decrease on commit sized diffs is
unfortunate but I think it is small enough to be worth it for the
gains on larger diffs.

Large diff before this change:
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
  Time (mean ± σ):      1.147 s ±  0.005 s    [User: 1.085 s, System: 0.059 s]
  Range (min … max):    1.140 s …  1.154 s    10 runs

Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
  Time (mean ± σ):      1.048 s ±  0.005 s    [User: 987.4 ms, System: 58.8 ms]
  Range (min … max):    1.043 s …  1.056 s    10 runs

Large diff after this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --no-color-moved-ws v2.28.0 v2.29.0
  Time (mean ± σ):     762.7 ms ±   2.8 ms    [User: 707.5 ms, System: 53.7 ms]
  Range (min … max):   758.0 ms … 767.0 ms    10 runs

Benchmark #2: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
  Time (mean ± σ):     831.7 ms ±   1.7 ms    [User: 776.5 ms, System: 53.3 ms]
  Range (min … max):   829.2 ms … 835.1 ms    10 runs

Small diffs on master
Benchmark #1: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --no-color-moved-ws --no-merges -n1000 v2.29.0
  Time (mean ± σ):      1.567 s ±  0.001 s    [User: 1.443 s, System: 0.121 s]
  Range (min … max):    1.566 s …  1.571 s    10 runs

Benchmark #2: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change -n1000 --no-merges v2.29.0
  Time (mean ± σ):      1.865 s ±  0.008 s    [User: 1.748 s, System: 0.112 s]
  Range (min … max):    1.857 s …  1.881 s    10 runs

Small diffs after this change
Benchmark #1: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --no-color-moved-ws --no-merges -n1000 v2.29.0
  Time (mean ± σ):      1.597 s ±  0.003 s    [User: 1.413 s, System: 0.179 s]
  Range (min … max):    1.591 s …  1.601 s    10 runs

Benchmark #2: bin-wrappers/git log -p --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change -n1000 --no-merges v2.29.0
  Time (mean ± σ):      1.606 s ±  0.006 s    [User: 1.420 s, System: 0.181 s]
  Range (min … max):    1.601 s …  1.622 s    10 runs

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 173 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 96 insertions(+), 77 deletions(-)

diff --git a/diff.c b/diff.c
index e6f3586b39bf..3260e2c60591 100644
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
@@ -866,24 +868,24 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
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
 
@@ -894,22 +896,26 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
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
@@ -917,55 +923,81 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
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
@@ -974,7 +1006,6 @@ static void pmb_advance_or_null(struct diff_options *o,
 				int *pmb_nr)
 {
 	int i, j;
-	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
 	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
@@ -987,9 +1018,8 @@ static void pmb_advance_or_null(struct diff_options *o,
 			match = cur &&
 				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
 		else
-			match = cur &&
-				xdiff_compare_lines(cur->es->line, cur->es->len,
-						    l->line, l->len, flags);
+			match = cur && cur->es->id == l->id;
+
 		if (match)
 			pmb[j++].match = cur;
 	}
@@ -1034,8 +1064,7 @@ static int adjust_last_block(struct diff_options *o, int n, int block_length)
 
 /* Find blocks of moved code, delegate actual coloring decision to helper */
 static void mark_color_as_moved(struct diff_options *o,
-				struct hashmap *add_lines,
-				struct hashmap *del_lines)
+				struct moved_entry_list *entry_list)
 {
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
@@ -1044,23 +1073,15 @@ static void mark_color_as_moved(struct diff_options *o,
 
 
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
@@ -1089,7 +1110,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			 * The current line is the start of a new block.
 			 * Setup the set of potential blocks.
 			 */
-			hashmap_for_each_entry_from(hm, match, ent) {
+			for (; match; match = match->next_match) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
@@ -1460,7 +1481,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
-	struct emitted_diff_symbol e = {line, len, flags, 0, 0, s};
+	struct emitted_diff_symbol e = {line, len, flags, 0, 0, 0, s};
 
 	if (o->emitted_symbols)
 		append_emitted_diff_symbol(o, &e);
@@ -6214,20 +6235,18 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 
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
