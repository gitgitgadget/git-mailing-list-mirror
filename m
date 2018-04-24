Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136171F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDXVDs (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:03:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42377 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeDXVDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:03:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id e12so11739580pgn.9
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQAlnGzjAqGlnc3WPA+oOMffKBWX3cL5GTXbXbxb64Q=;
        b=Mn4gUxrHubbFgNl1ugLBLKu+Zy2gmKmO852M2UkTChhp3f8eT12Hpyogr5igt9o045
         7aGNIqt15+V6YHfg33FXqsztU05uinvw++XQRn7pX0MgzP5jg3G1yEYHkHnm2ENmuGrb
         6DvLMy1C5K39BWe7WvpKgRlh45Ors3Y0cbSfnQvy2Ja+sV6UkbyQCv/MH90uw9auoclN
         fnIZ27yU4hjA32csQ/bdJB38HHFwWweATfi+ZVLedafSXOtA9cKEt3w0HjFyki+AE8Zy
         XyCpSXavQIDpLFrnscH1nkqjSG02K5pO45/4MTxfxPKi4EW0w8t3Iz8ZVKG3A4SBMfrr
         MhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQAlnGzjAqGlnc3WPA+oOMffKBWX3cL5GTXbXbxb64Q=;
        b=e+5HsY2NeJrRw4n4/YKsWlv0b0qAMNAX8Eiqz4v8I11r3fq55tqWnMW/lzDTDxs57a
         DNWBWg5/IHzlzHym9t37C4AoodSK2qVky96Yx3k9h2LNWVVjSmTV5EQaA3fLAv/NOQx6
         iyhkIkf8ydvJafZSBlptAiLGh2Z1gOETj8tsBY7ym0S31xjQmNmbeXCPva2mSIT8Z+/z
         WQoKGUfZaiHnKt07ah3Byq7bXWPasWWz06TkIHb9u6Of8scg2MOsv8BZszlSua9pRlMW
         iHszgf4eFwsqoXurKhKLuAqGVAm7fTB775fIA8TcU6F5nLSmCsQ/8soELSwIVTzmDmYB
         d3MQ==
X-Gm-Message-State: ALQs6tBsZbDWOs9c0z8p6836QqlFn2YoPg4SwriOPD7/80Si3RMBDR4Q
        5qDbHVZM5UKMxjOeN/oSbBbkbgdhZcA=
X-Google-Smtp-Source: AIpwx48zxpuo5RA5hcZypgWQLimzLWr6kDMcu8RClZeWGKMkMZVBkshnLLIN1QFDINKeSw46n25ZLA==
X-Received: by 10.98.82.131 with SMTP id g125mr25159100pfb.198.1524603823347;
        Tue, 24 Apr 2018 14:03:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id z62sm7079097pff.57.2018.04.24.14.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:03:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, simon@ruderich.org, avarab@gmail.com,
        jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/7] diff.c: add --color-moved-ignore-space-delta option
Date:   Tue, 24 Apr 2018 14:03:30 -0700
Message-Id: <20180424210330.87861-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424210330.87861-1-sbeller@google.com>
References: <20180424210330.87861-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This marks moved code still as blocks when their indentation level
changes uniformly.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt |  4 ++
 diff.c                         | 83 +++++++++++++++++++++++++++++++---
 diff.h                         |  2 +
 t/t4015-diff-whitespace.sh     | 54 ++++++++++++++++++++++
 4 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7b2527b9a1..facdbc8f95 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -304,6 +304,10 @@ dimmed_zebra::
 	Ignore whitespace when comparing lines when performing the move
 	detection for --color-moved.  This ignores differences even if
 	one line has whitespace where the other line has none.
+--color-moved-[no-]ignore-space-prefix-delta::
+	Ignores whitespace when comparing lines when performing the move
+	detection for --color-moved. This ignores uniform differences
+	of white space at the beginning lines in moved blocks.
 
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
diff --git a/diff.c b/diff.c
index b5819dd538..1227a4d2a8 100644
--- a/diff.c
+++ b/diff.c
@@ -709,6 +709,31 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
+struct ws_delta {
+	char *string; /* The prefix delta, which is the same in the block */
+	int direction; /* adding or removing the line? */
+	int missmatch; /* in the remainder */
+};
+#define WS_DELTA_INIT { NULL, 0, 0 }
+
+static void compute_ws_delta(const struct emitted_diff_symbol *a,
+			     const struct emitted_diff_symbol *b,
+			     struct ws_delta *out)
+{
+	const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
+	const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
+	int d = longer->len - shorter->len;
+
+	out->missmatch = !memcmp(longer->line + d, shorter->line, shorter->len);
+	out->string = xmemdupz(longer->line, d);
+	out->direction = (a == longer);
+}
+
+static int compare_ws_delta(const struct ws_delta *a, const struct ws_delta *b)
+{
+	return a->direction == b->direction && !strcmp(a->string, b->string);
+}
+
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			   const void *entry,
 			   const void *entry_or_key,
@@ -720,6 +745,15 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 	unsigned flags = diffopt->color_moved_ws_handling
 			 & XDF_WHITESPACE_FLAGS;
 
+	if (diffopt->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES)
+		/*
+		 * As there is not specific white space config given,
+		 * we'd need to check for a new block, so ignore all
+		 * white space. The setup of the white space
+		 * configuration for the next block is done else where
+		 */
+		flags |= XDF_IGNORE_WHITESPACE;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    flags);
@@ -772,7 +806,8 @@ static void add_lines_to_move_detection(struct diff_options *o,
 }
 
 static int shrink_potential_moved_blocks(struct moved_entry **pmb,
-					 int pmb_nr)
+					 int pmb_nr,
+					 struct ws_delta **wsd)
 {
 	int lp, rp;
 
@@ -788,6 +823,10 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 
 		if (lp < pmb_nr && rp > -1 && lp < rp) {
 			pmb[lp] = pmb[rp];
+			if (*wsd) {
+				free((*wsd)[lp].string);
+				(*wsd)[lp] = (*wsd)[rp];
+			}
 			pmb[rp] = NULL;
 			rp--;
 			lp++;
@@ -837,8 +876,11 @@ static void mark_color_as_moved(struct diff_options *o,
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
@@ -881,14 +923,31 @@ static void mark_color_as_moved(struct diff_options *o,
 			struct moved_entry *p = pmb[i];
 			struct moved_entry *pnext = (p && p->next_line) ?
 					p->next_line : NULL;
-			if (pnext && !hm->cmpfn(o, pnext, match, NULL)) {
-				pmb[i] = p->next_line;
+
+			if (o->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES) {
+				struct ws_delta out = WS_DELTA_INIT;
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
+				free(out.string);
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
@@ -897,6 +956,10 @@ static void mark_color_as_moved(struct diff_options *o,
 			 */
 			for (; match; match = hashmap_get_next(hm, match)) {
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+				if (o->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES) {
+					ALLOC_GROW(wsd, pmb_nr + 1, wsd_alloc);
+					compute_ws_delta(l, match->es, &wsd[pmb_nr]);
+				}
 				pmb[pmb_nr++] = match;
 			}
 
@@ -914,6 +977,7 @@ static void mark_color_as_moved(struct diff_options *o,
 	adjust_last_block(o, n, block_length);
 
 	free(pmb);
+	free(wsd);
 }
 
 #define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
@@ -4647,12 +4711,16 @@ int diff_opt_parse(struct diff_options *options,
 		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--color-moved-no-ignore-space-at-eol"))
 		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-no-ignore-space-prefix-delta"))
+		options->color_moved_ws_handling &= ~COLOR_MOVED_DELTA_WHITESPACES;
 	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
 		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
 		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_CHANGE;
 	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
 		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_AT_EOL;
+	else if (!strcmp(arg, "--color-moved-ignore-space-prefix-delta"))
+		options->color_moved_ws_handling |= COLOR_MOVED_DELTA_WHITESPACES;
 	else if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
@@ -5558,6 +5626,9 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
 			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
+			if (o->color_moved_ws_handling & COLOR_MOVED_DELTA_WHITESPACES)
+				o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
+
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
 			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
diff --git a/diff.h b/diff.h
index de5dc68005..b00ea76c08 100644
--- a/diff.h
+++ b/diff.h
@@ -214,6 +214,8 @@ struct diff_options {
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
+	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
+	#define COLOR_MOVED_DELTA_WHITESPACES	(1 << 22)
 	int color_moved_ws_handling;
 };
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 751fc478dd..3e94cf051d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1847,4 +1847,58 @@ test_expect_success 'only move detection ignores white spaces' '
 	test_cmp expected actual
 '
 
+test_expect_success 'compare whitespace delta across moved blocks' '
+
+	git reset --hard &&
+	q_to_tab <<-\EOF >text.txt &&
+	QIndented
+	QText across
+	Qthree lines
+	QBut! <- this stands out
+	Qthis one
+	QQline did
+	Qnot adjust
+	EOF
+
+	git add text.txt &&
+	git commit -m "add text.txt" &&
+
+	q_to_tab <<-\EOF >text.txt &&
+	QQIndented
+	QQText across
+	QQthree lines
+	QQQBut! <- this stands out
+	this one
+	Qline did
+	not adjust
+	EOF
+
+	git diff --color --color-moved-ignore-space-prefix-delta |
+		grep -v "index" |
+		test_decode_color >actual &&
+
+	q_to_tab <<-\EOF >expected &&
+		<BOLD>diff --git a/text.txt b/text.txt<RESET>
+		<BOLD>--- a/text.txt<RESET>
+		<BOLD>+++ b/text.txt<RESET>
+		<CYAN>@@ -1,7 +1,7 @@<RESET>
+		<RED>-QIndented<RESET>
+		<RED>-QText across<RESET>
+		<RED>-Qthree lines<RESET>
+		<RED>-QBut! <- this stands out<RESET>
+		<RED>-Qthis one<RESET>
+		<RED>-QQline did<RESET>
+		<RED>-Qnot adjust<RESET>
+		<GREEN>+<RESET>QQ<GREEN>Indented<RESET>
+		<GREEN>+<RESET>QQ<GREEN>Text across<RESET>
+		<GREEN>+<RESET>QQ<GREEN>three lines<RESET>
+		<GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
+		<GREEN>+<RESET><GREEN>this one<RESET>
+		<GREEN>+<RESET>Q<GREEN>line did<RESET>
+		<GREEN>+<RESET><GREEN>not adjust<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.17.0.441.gb46fe60e1d-goog

