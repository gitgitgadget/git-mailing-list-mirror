Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2D8D1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 22:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbeDBWtS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 18:49:18 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45975 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754709AbeDBWtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id v18-v6so4150454ply.12
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nRsPoDrDKP4Ih06Ska7V0VBs2JRLMSdzNIw6vIMZUug=;
        b=lt2JQ1zP0w4S4jNO7AoG6OifwNqSEKlGbDReDyIU5pznuiyfCz1sO5A2/DG0B3zZn+
         beHZUDYIJ6fDN3LS3vsEbwW90h5liddah0MGmuopbj1ORRvDVFxjEs3F6qjLqvaXzdZ+
         a9+PEpZ6+JHhaif0o9s4Ellj52DWygu10kSAz5KH6y1U+rldKcUnxHaT1CHFgkdrmuKb
         X1tgMYMBSHO/kSBdECI7iKm9Ff/NiykaSPuRoNuhCyxlcBANJ/L5I/LN1/5W/h7QqBPr
         H8kKDmh3VHOgjEEgJIT2U2oE/zwY74lVJ4E5jFXy9xru7vRrMs8c2nr0qXBdwSgCugDQ
         NFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nRsPoDrDKP4Ih06Ska7V0VBs2JRLMSdzNIw6vIMZUug=;
        b=jMORlBLYosNI8REepLk5daMNr81zghYsHgpOtags24IwvFpHOGhU8Tcr7cbIDJHplI
         RlZ7ymAk/ySGjIXeGFWABEID2KL1BK9gy7uojaLR+Tibr0XVMY5K4A3cL+eG7Ys4keSU
         9fE1n0HMoGsHAWUpOd6c+PBNGcsA3RccQQBZhdjOYJnUwuQL/g8j4IC7ncUkiyfDGcKH
         jvFL6abpuP7JjfyXkdhb3IMWTF8AnRpoflbhX2zCz0F1uXr0y3WjSWN7n6apH+yLqUFc
         fayetNiG2RMGghcpqqt0vf6cV1+gCZj77S+eox5BilaBOXsBtVxpfaAt3MS7Zm5ySaXL
         WN4Q==
X-Gm-Message-State: AElRT7F15hh9XYUiOPvVKo6H3RC3/GBmc3ACxP/ownBbae1Hg3eKS6AS
        02R2QfCixKQ01pwraCzZOzOMv8aPZhc=
X-Google-Smtp-Source: AIpwx4/LaGnvoAHUpSfidvBZAzmTTnZNpylATLoK2msB1UHWt/9EVFnea6YW3jcQcKqzv6ucauE1+Q==
X-Received: by 10.101.100.132 with SMTP id e4mr7467960pgv.240.1522709355012;
        Mon, 02 Apr 2018 15:49:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id e62sm2350486pfl.117.2018.04.02.15.49.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 15:49:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com, jacob.keller@gmail.com,
        simon@ruderich.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
Date:   Mon,  2 Apr 2018 15:48:54 -0700
Message-Id: <20180402224854.86922-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This marks moved code still as blocks when their indentation level
changes uniformly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     |  93 ++++++++++++++++--
 diff.h                     |   1 +
 t/t4015-diff-whitespace.sh | 191 +++++++++++++++++++++++++++++++++++++
 3 files changed, 278 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 5fe2930dca..9f969be588 100644
--- a/diff.c
+++ b/diff.c
@@ -709,6 +709,41 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
+struct ws_delta {
+	int deltachars;
+	char firstchar;
+};
+
+static void compute_ws_delta(const struct emitted_diff_symbol *a,
+			     const struct emitted_diff_symbol *b,
+			     struct ws_delta *out)
+{
+	int i;
+	const struct emitted_diff_symbol *longer = a->len > b->len ? a : b;
+
+
+	out->deltachars = 0;
+	out->firstchar = 0;
+
+	if (longer->len > 0 && isspace(longer->line[0]))
+		out->firstchar = longer->line[0];
+	else
+		return;
+
+	for (i = 0; i < a->len; i++)
+		if (a->line[i] == out->firstchar)
+			out->deltachars ++;
+
+	for (i = 0; i < b->len; i++)
+		if (b->line[i] == out->firstchar)
+			out->deltachars --;
+}
+
+static int compare_ws_delta(const struct ws_delta *a, const struct ws_delta *b)
+{
+	return  a->firstchar == b->firstchar && a->deltachars == b->deltachars;
+}
+
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			   const void *entry,
 			   const void *entry_or_key,
@@ -717,10 +752,20 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 	const struct diff_options *diffopt = hashmap_cmp_fn_data;
 	const struct moved_entry *a = entry;
 	const struct moved_entry *b = entry_or_key;
+	unsigned flags = diffopt->color_moved & XDF_WHITESPACE_FLAGS;
+
+	if (diffopt->color_moved & COLOR_MOVED_DELTA_WHITESPACES)
+		/*
+		 * As there is not specific white space config given,
+		 * we'd need to check for a new block, so ignore all
+		 * white space. The setup of the white space
+		 * configuration for the next block is done else where
+		 */
+		flags |= XDF_IGNORE_WHITESPACE;
 
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
-				    diffopt->color_moved & XDF_WHITESPACE_FLAGS);
+				    flags);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -770,7 +815,8 @@ static void add_lines_to_move_detection(struct diff_options *o,
 }
 
 static int shrink_potential_moved_blocks(struct moved_entry **pmb,
-					 int pmb_nr)
+					 int pmb_nr,
+					 struct ws_delta **wsd)
 {
 	int lp, rp;
 
@@ -786,6 +832,8 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 
 		if (lp < pmb_nr && rp > -1 && lp < rp) {
 			pmb[lp] = pmb[rp];
+			if (*wsd)
+				(*wsd)[lp] = (*wsd)[rp];
 			pmb[rp] = NULL;
 			rp--;
 			lp++;
@@ -835,8 +883,11 @@ static void mark_color_as_moved(struct diff_options *o,
 {
 	struct moved_entry **pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
-	int n, flipped_block = 1, block_length = 0;
 
+	struct ws_delta *wsd = NULL; /* white space deltas between pmb */
+	int wsd_alloc = 0;
+
+	int n, flipped_block = 1, block_length = 0;
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
 		struct hashmap *hm = NULL;
@@ -879,14 +930,30 @@ static void mark_color_as_moved(struct diff_options *o,
 			struct moved_entry *p = pmb[i];
 			struct moved_entry *pnext = (p && p->next_line) ?
 					p->next_line : NULL;
-			if (pnext && !hm->cmpfn(o, pnext, match, NULL)) {
-				pmb[i] = p->next_line;
+
+			if (o->color_moved & COLOR_MOVED_DELTA_WHITESPACES) {
+				struct ws_delta out;
+
+				if (pnext)
+					compute_ws_delta(l, pnext->es, &out);
+				if (pnext &&
+				    !hm->cmpfn(o, pnext, match, NULL) &&
+				    compare_ws_delta(&out, &wsd[i])) {
+					pmb[i] = p->next_line;
+					/* wsd[i] is the same */
+				} else {
+					pmb[i] = NULL;
+				}
 			} else {
-				pmb[i] = NULL;
+				if (pnext && !hm->cmpfn(o, pnext, match, NULL)) {
+					pmb[i] = p->next_line;
+				} else {
+					pmb[i] = NULL;
+				}
 			}
 		}
 
-		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
+		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr, &wsd);
 
 		if (pmb_nr == 0) {
 			/*
@@ -895,6 +962,10 @@ static void mark_color_as_moved(struct diff_options *o,
 			 */
 			for (; match; match = hashmap_get_next(hm, match)) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+				if (o->color_moved & COLOR_MOVED_DELTA_WHITESPACES) {
+					ALLOC_GROW(wsd, pmb_nr + 1, wsd_alloc);
+					compute_ws_delta(l, match->es, &wsd[pmb_nr]);
+				}
 				pmb[pmb_nr++] = match;
 			}
 
@@ -912,6 +983,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	adjust_last_block(o, n, block_length);
 
 	free(pmb);
+	free(wsd);
 }
 
 #define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
@@ -4645,12 +4717,16 @@ int diff_opt_parse(struct diff_options *options,
 		options->color_moved &= ~XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--color-moved-no-ignore-space-at-eol"))
 		options->color_moved &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-delta"))
+		options->color_moved &= ~COLOR_MOVED_DELTA_WHITESPACES;
 	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
 		options->color_moved |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
 		options->color_moved |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
 		options->color_moved |= XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-ignore-space-delta"))
+		options->color_moved |= COLOR_MOVED_DELTA_WHITESPACES;
 	else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
@@ -5555,6 +5631,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
 			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
+			if (o->color_moved & COLOR_MOVED_DELTA_WHITESPACES)
+				o->color_moved |= XDF_IGNORE_WHITESPACE;
+
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
 			if (o->color_moved & COLOR_MOVED_DIMMED_BLOCKS)
diff --git a/diff.h b/diff.h
index 9542017986..b8c0cf1232 100644
--- a/diff.h
+++ b/diff.h
@@ -212,6 +212,7 @@ struct diff_options {
 	#define COLOR_MOVED_FIND_BLOCKS		(1 << 1)
 	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
 
+	#define COLOR_MOVED_DELTA_WHITESPACES	(1 << 22)
 	#define COLOR_MOVED_DIMMED_BLOCKS	(1 << 23)
 
 	#define COLOR_MOVED_DEFAULT (COLOR_MOVED_ENABLED | COLOR_MOVED_FIND_BLOCKS)
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 38aaf4c46c..246ccadf9b 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1861,4 +1861,195 @@ test_expect_success 'move detection only ignores white spaces' '
 	test_cmp expected actual
 '
 
+test_expect_success 'compare whitespace delta across moved blocks' '
+
+	git reset --hard &&
+	q_to_tab <<-\EOF >text.txt &&
+	QIndented
+	QText
+	Qacross
+	Qfive
+	Qlines
+	QBut!
+	Qthis
+	QQone
+	Qline
+	QQdid
+	Qnot
+	QQadjust
+	EOF
+
+	git add text.txt &&
+	git commit -m "add text.txt" &&
+
+	q_to_tab <<-\EOF >text.txt &&
+	QQIndented
+	QQText
+	QQacross
+	QQfive
+	QQlines
+	QQQBut!
+	QQthis
+	QQQone
+	QQline
+	QQQdid
+	QQnot
+	QQQadjust
+	EOF
+
+	git diff --color --color-moved-ignore-space-delta |
+		grep -v "index" |
+		test_decode_color >actual &&
+
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,12 +1,12 @@<RESET>
+	<BOLD;MAGENTA>-QIndented<RESET>
+	<BOLD;MAGENTA>-QText<RESET>
+	<BOLD;MAGENTA>-Qacross<RESET>
+	<BOLD;MAGENTA>-Qfive<RESET>
+	<BOLD;MAGENTA>-Qlines<RESET>
+	<RED>-QBut!<RESET>
+	<BOLD;MAGENTA>-Qthis<RESET>
+	<BOLD;MAGENTA>-QQone<RESET>
+	<BOLD;MAGENTA>-Qline<RESET>
+	<BOLD;MAGENTA>-QQdid<RESET>
+	<BOLD;MAGENTA>-Qnot<RESET>
+	<BOLD;MAGENTA>-QQadjust<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>Indented<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>Text<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>across<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>five<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>lines<RESET>
+	<GREEN>+<RESET>QQQ<GREEN>But!<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>this<RESET>
+	<BOLD;YELLOW>+<RESET>QQQ<BOLD;YELLOW>one<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>line<RESET>
+	<BOLD;YELLOW>+<RESET>QQQ<BOLD;YELLOW>did<RESET>
+	<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>not<RESET>
+	<BOLD;YELLOW>+<RESET>QQQ<BOLD;YELLOW>adjust<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
+test_expect_success 'compare whitespace delta across moved blocks with multiple indentation levels' '
+	# alternative: "python programmers would love the move detection, too"
+
+	git reset --hard &&
+	q_to_tab <<-\EOF >test.py &&
+	class test:
+	Qdef f(x):
+	QQ"""
+	QQA simple python function
+	QQthat returns the square of a number
+	QQAlthough it may not be pythonic
+	QQ"""
+	QQdef g(x):
+	QQQ"""
+	QQQNested function that returns the same number
+	QQQWe just multiply by 1.0
+	QQQso we can write a comment about it
+	QQQas we need longer blocks
+	QQQ"""
+	QQQreturn 1.0 * x
+	QQ# Another comment for f(x)
+	QQ# also spanning multiple lines
+	QQ# to make a block
+	QQreturn g(x) * g(x)
+	Qdef h(x):
+	QQ# Another function unrelated to the previous
+	QQ# but building a block,
+	QQ# long enough to call it a block
+	QQreturn x * 1.0
+	EOF
+
+	git add test.py &&
+	git commit -m "add test.py" &&
+
+	q_to_tab <<-\EOF >test.py &&
+	class test:
+	Qdef h(x):
+	QQ# Another function unrelated to the previous
+	QQ# but building a block,
+	QQ# long enough to call it a block
+	QQreturn x * 1.0
+	def f(x):
+	Q"""
+	QA simple python function
+	Qthat returns the square of a number
+	QAlthough it may not be pythonic
+	Q"""
+	Qdef g(x):
+	QQ"""
+	QQNested function that returns the same number
+	QQWe just multiply by 1.0
+	QQso we can write a comment about it
+	QQas we need longer blocks
+	QQ"""
+	QQreturn 1.0 * x
+	Q# Another comment for f(x)
+	Q# also spanning multiple lines
+	Q# to make a block
+	Qreturn g(x) * g(x)
+	EOF
+
+	git diff --color --color-moved-ignore-space-delta |
+		grep -v "index" |
+		test_decode_color >actual &&
+
+	q_to_tab <<-\EOF >expected &&
+	<BOLD>diff --git a/test.py b/test.py<RESET>
+	<BOLD>--- a/test.py<RESET>
+	<BOLD>+++ b/test.py<RESET>
+	<CYAN>@@ -1,24 +1,24 @@<RESET>
+	 class test:<RESET>
+	<BOLD;MAGENTA>-Qdef f(x):<RESET>
+	<BOLD;MAGENTA>-QQ"""<RESET>
+	<BOLD;MAGENTA>-QQA simple python function<RESET>
+	<BOLD;MAGENTA>-QQthat returns the square of a number<RESET>
+	<BOLD;MAGENTA>-QQAlthough it may not be pythonic<RESET>
+	<BOLD;MAGENTA>-QQ"""<RESET>
+	<BOLD;MAGENTA>-QQdef g(x):<RESET>
+	<BOLD;MAGENTA>-QQQ"""<RESET>
+	<BOLD;MAGENTA>-QQQNested function that returns the same number<RESET>
+	<BOLD;MAGENTA>-QQQWe just multiply by 1.0<RESET>
+	<BOLD;MAGENTA>-QQQso we can write a comment about it<RESET>
+	<BOLD;MAGENTA>-QQQas we need longer blocks<RESET>
+	<BOLD;MAGENTA>-QQQ"""<RESET>
+	<BOLD;MAGENTA>-QQQreturn 1.0 * x<RESET>
+	<BOLD;MAGENTA>-QQ# Another comment for f(x)<RESET>
+	<BOLD;MAGENTA>-QQ# also spanning multiple lines<RESET>
+	<BOLD;MAGENTA>-QQ# to make a block<RESET>
+	<BOLD;MAGENTA>-QQreturn g(x) * g(x)<RESET>
+	 Qdef h(x):<RESET>
+	 QQ# Another function unrelated to the previous<RESET>
+	 QQ# but building a block,<RESET>
+	 QQ# long enough to call it a block<RESET>
+	 QQreturn x * 1.0<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>def f(x):<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>"""<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>A simple python function<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>that returns the square of a number<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>Although it may not be pythonic<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>"""<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>def g(x):<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>"""<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Nested function that returns the same number<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>We just multiply by 1.0<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>so we can write a comment about it<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>as we need longer blocks<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>"""<RESET>
+	<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>return 1.0 * x<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN># Another comment for f(x)<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN># also spanning multiple lines<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN># to make a block<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>return g(x) * g(x)<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.17.0.484.g0c8726318c-goog

