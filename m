Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6753D1F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeEQTrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:18 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33643 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTrO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id n10-v6so3150073plp.0
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Seo/OQ6RfKhLa2GBRi+ar5kHRJFTfxqc27Mu4eYjDRU=;
        b=e4HuF0kg0enDp2ZZEisFzamu615Ex/baDBhI2WUntqvS2wSuaeB4o+rwfa2BikV5vX
         hQK1F8mn/PL0YTI4N8gFINflASkCRaurwOYrNCMuMvLPafFojNINbah3nvtUR2v+qVsC
         Dmi+0HBCxVJWPG8q5cLD9hUP6duVoTUnDeCycQRCSz5qFURkCjpx5AMYRGp4VQjbC+d5
         C9P+fe9cEqBOMGVAgvKFuwY0wEh2DEBLtrDyI3UGhsxq7Y6r6XgLDR0kTOyHGlMv6h1x
         TGkI/ullxC/d4ulmtrEdcF3L2cMi1yBCkZm9eNKX84EaN4EqOdPrG5JyIr3VulbG2Zgg
         5i2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Seo/OQ6RfKhLa2GBRi+ar5kHRJFTfxqc27Mu4eYjDRU=;
        b=CmLmDc6vsR/JkbYJGsZ+fRURriNTxDPqp5FDAnOTJumY61jpg6j+i+6MBFjlqG+uUv
         zCu3kQNpdNZl1M++G2L2NsDGz2KrdCDzTqlfZkAu5VfBjw62YuiK4nbPtEChFBXI2oRu
         WXtvEkISjJPcoUVN3bEpITMPnXmw3pRz/Pb+fafpkbiyyrTUBeZUNvAkMyll8hfGdUQy
         aGzQxuqFH/KbLgNchnpvx6zbd1BOOACPlu00i4YdpRZe2njK0byAo/vbi+BfUZE6fPe1
         PR4WGgtpB7Sp9MAWlWtsXfOSGzdDAmq8pDiqZfPM+f/GSm0vvTZVhYZiaLMhKNz8unm6
         4H0Q==
X-Gm-Message-State: ALKqPwc1RuOXy0Pff9hMVgZkGbPr0XxUVQFi0xEcfNliXYnQ0QUV5WDJ
        XnU8avdypbB+k16py64Wx5YW+A==
X-Google-Smtp-Source: AB8JxZpdXSRrJu/MwdLNxEd6bW8A7prH3ujPwDoQSlQwvHH2drG5zpyXpUFSldgwgJrPmxd6dGZ71Q==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr6529674pll.243.1526586433471;
        Thu, 17 May 2018 12:47:13 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id q76-v6sm12288860pfi.139.2018.05.17.12.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:12 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 7/8] diff.c: add --color-moved-ignore-space-delta option
Date:   Thu, 17 May 2018 12:46:52 -0700
Message-Id: <20180517194653.48928-8-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
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
index 7b2527b9a19..facdbc8f95f 100644
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
index b5819dd538f..1227a4d2a83 100644
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
index de5dc680051..b00ea76c083 100644
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
index 751fc478dde..37ff528822f 100755
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
+	git diff --color --color-moved --color-moved-ignore-space-prefix-delta |
+		grep -v "index" |
+		test_decode_color >actual &&
+
+	q_to_tab <<-\EOF >expected &&
+		<BOLD>diff --git a/text.txt b/text.txt<RESET>
+		<BOLD>--- a/text.txt<RESET>
+		<BOLD>+++ b/text.txt<RESET>
+		<CYAN>@@ -1,7 +1,7 @@<RESET>
+		<BOLD;MAGENTA>-QIndented<RESET>
+		<BOLD;MAGENTA>-QText across<RESET>
+		<BOLD;MAGENTA>-Qthree lines<RESET>
+		<RED>-QBut! <- this stands out<RESET>
+		<BOLD;MAGENTA>-Qthis one<RESET>
+		<BOLD;MAGENTA>-QQline did<RESET>
+		<BOLD;MAGENTA>-Qnot adjust<RESET>
+		<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>Indented<RESET>
+		<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>Text across<RESET>
+		<BOLD;YELLOW>+<RESET>QQ<BOLD;YELLOW>three lines<RESET>
+		<GREEN>+<RESET>QQQ<GREEN>But! <- this stands out<RESET>
+		<BOLD;YELLOW>+<RESET><BOLD;YELLOW>this one<RESET>
+		<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>line did<RESET>
+		<BOLD;YELLOW>+<RESET><BOLD;YELLOW>not adjust<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.17.0.582.gccdcbd54c44.dirty

