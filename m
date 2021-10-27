Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B32C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20DB60E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhJ0MHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbhJ0MHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BADC061224
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d3so3731871wrh.8
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/NY0FSLLgoOM2WL1cJXCz+GAAkWsSqC7KSVILVwygw=;
        b=G6c+xU680ooYDURVbohdis89yrW0oEszmUqp8ZBfR8LPqnRwG1HtLWCVP5IPbSZELD
         KeMDOKQ93Xj4LTmfx4OKKKgz/kA6EYlJDNy05vh3trSeK9G2qKbkwtY1OI5kd1I5mpI5
         qUAQGmZ1rJ4z0VMO0gKItdjdSmhKHEkPEpBkJ6yUtrfCa+RDP0iZ5qajmZaQr76c2rqM
         KWYnrtYeoDS3onm0wVpkNNU7aAfSiCNDqO5W8RO9nF9CrSmj7BFoIpMPdQDgCxiRo56P
         idzFPmsBFs81AMeL28QrSUOmH2WPtHgcmWWQWlwUwBFEQ8oo0hwyI3WstQ/VfXeOjj5v
         Uwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/NY0FSLLgoOM2WL1cJXCz+GAAkWsSqC7KSVILVwygw=;
        b=a9sMmsLIPFch8B5jjMybMRsbDWJQNWHAsDzukiL9Ey2mATH8UcSCmgBKGt8f4BVXRe
         kgWO6c3Z+P/002jPVuaSvEQUY+Y2aDci+5S3Zceua8w7CW6lwkxTRhX0Vm8MJcf5JhwR
         VktFE+fJfZBt9YCT5xUc6kvzM4VddBUoUQqmCEXjD+azZYIOp691A+56QNMutJm3RhO/
         AtTZaBsaVgjnHXrkX79LHVsthzj/SaarLli4bng96nd/Pk3tYqy8yLkfJ/l6ze2sNxje
         RkJ8SYrExmkUCL44hoCOKTv7uz8WjZaWxnqM0RSAiMV2Ty+NHEuBn5pK65WT6WGIgr7r
         OTdg==
X-Gm-Message-State: AOAM532/fIWFxvntr9JLRcujpW6WMjWB9+vDiMo0V7JRxTHdD+2VUpfc
        ymdcQFzHYiiVnl4CLfhVieitv+ge4bk=
X-Google-Smtp-Source: ABdhPJxTtBip7QSTjBZ9M6oaehzcOHoylWKZTCbgHJb7jk+LJRaZYnvK/yQ3TtKd+993BwjSBnY00g==
X-Received: by 2002:adf:b19b:: with SMTP id q27mr40360281wra.125.1635336270948;
        Wed, 27 Oct 2021 05:04:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm15804919wrw.78.2021.10.27.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:30 -0700 (PDT)
Message-Id: <324b689c915ddcb006907eec72a10257186c9e17.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:15 +0000
Subject: [PATCH v3 08/15] diff --color-moved-ws=allow-indentation-change:
 simplify and optimize
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If we already have a block of potentially moved lines then as we move
down the diff we need to check if the next line of each potentially
moved line matches the current line of the diff. The implementation of
--color-moved-ws=allow-indentation-change was needlessly performing
this check on all the lines in the diff that matched the current line
rather than just the current line. To exacerbate the problem finding
all the other lines in the diff that match the current line involves a
fuzzy lookup so we were wasting even more time performing a second
comparison to filter out the non-matching lines. Fixing this reduces
time to run
  git diff --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
by 93% compared to master and simplifies the code.

Test                                                                 HEAD^               HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.35+0.03)   0.38(0.35+0.03)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.86 (0.80+0.06)   0.87(0.83+0.04)  +1.2%
4002.3: diff --color-moved-ws=allow-indentation-change large change  19.01(18.93+0.06)   0.97(0.92+0.04) -94.9%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16 (1.06+0.09)   1.17(1.06+0.10)  +0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.32 (1.25+0.07)   1.32(1.24+0.08)  +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.64+0.06)   1.36(1.25+0.10) -20.5%

Test                                                                 master              HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.33+0.05)   0.38(0.35+0.03)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.80 (0.75+0.04)   0.87(0.83+0.04)  +8.7%
4002.3: diff --color-moved-ws=allow-indentation-change large change  14.20(14.15+0.05)   0.97(0.92+0.04) -93.2%
4002.4: log --no-color-moved --no-color-moved-ws                      1.15 (1.05+0.09)   1.17(1.06+0.10)  +1.7%
4002.5: log --color-moved --no-color-moved-ws                         1.30 (1.19+0.11)   1.32(1.24+0.08)  +1.5%
4002.6: log --color-moved-ws=allow-indentation-change                 1.70 (1.63+0.06)   1.36(1.25+0.10) -20.0%

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 70 +++++++++++++++++-----------------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/diff.c b/diff.c
index 9aff167be27..78a486021ab 100644
--- a/diff.c
+++ b/diff.c
@@ -879,37 +879,21 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	return 1;
 }
 
-static int cmp_in_block_with_wsd(const struct diff_options *o,
-				 const struct moved_entry *cur,
-				 const struct moved_entry *match,
-				 struct moved_block *pmb,
-				 int n)
-{
-	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-	int al = cur->es->len, bl = match->es->len, cl = l->len;
+static int cmp_in_block_with_wsd(const struct moved_entry *cur,
+				 const struct emitted_diff_symbol *l,
+				 struct moved_block *pmb)
+{
+	int al = cur->es->len, bl = l->len;
 	const char *a = cur->es->line,
-		   *b = match->es->line,
-		   *c = l->line;
+		   *b = l->line;
 	int a_off = cur->es->indent_off,
 	    a_width = cur->es->indent_width,
-	    c_off = l->indent_off,
-	    c_width = l->indent_width;
+	    b_off = l->indent_off,
+	    b_width = l->indent_width;
 	int delta;
 
-	/*
-	 * We need to check if 'cur' is equal to 'match'.  As those
-	 * are from the same (+/-) side, we do not need to adjust for
-	 * indent changes. However these were found using fuzzy
-	 * matching so we do have to check if they are equal. Here we
-	 * just check the lengths. We delay calling memcmp() to check
-	 * the contents until later as if the length comparison for a
-	 * and c fails we can avoid the call all together.
-	 */
-	if (al != bl)
-		return 1;
-
 	/* If 'l' and 'cur' are both blank then they match. */
-	if (a_width == INDENT_BLANKLINE && c_width == INDENT_BLANKLINE)
+	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE)
 		return 0;
 
 	/*
@@ -918,7 +902,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	delta = c_width - a_width;
+	delta = b_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
@@ -927,9 +911,8 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (pmb->wsd == INDENT_BLANKLINE)
 		pmb->wsd = delta;
 
-	return !(delta == pmb->wsd && al - a_off == cl - c_off &&
-		 !memcmp(a, b, al) && !
-		 memcmp(a + a_off, c + c_off, al - a_off));
+	return !(delta == pmb->wsd && al - a_off == bl - b_off &&
+		 !memcmp(a + a_off, b + b_off, al - a_off));
 }
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
@@ -1030,36 +1013,23 @@ static void pmb_advance_or_null(struct diff_options *o,
 }
 
 static void pmb_advance_or_null_multi_match(struct diff_options *o,
-					    struct moved_entry *match,
-					    struct hashmap *hm,
+					    struct emitted_diff_symbol *l,
 					    struct moved_block *pmb,
-					    int pmb_nr, int n)
+					    int pmb_nr)
 {
 	int i;
-	char *got_match = xcalloc(1, pmb_nr);
-
-	hashmap_for_each_entry_from(hm, match, ent) {
-		for (i = 0; i < pmb_nr; i++) {
-			struct moved_entry *prev = pmb[i].match;
-			struct moved_entry *cur = (prev && prev->next_line) ?
-					prev->next_line : NULL;
-			if (!cur)
-				continue;
-			if (!cmp_in_block_with_wsd(o, cur, match, &pmb[i], n))
-				got_match[i] |= 1;
-		}
-	}
 
 	for (i = 0; i < pmb_nr; i++) {
-		if (got_match[i]) {
+		struct moved_entry *prev = pmb[i].match;
+		struct moved_entry *cur = (prev && prev->next_line) ?
+			prev->next_line : NULL;
+		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
 			/* Advance to the next line */
-			pmb[i].match = pmb[i].match->next_line;
+			pmb[i].match = cur;
 		} else {
 			moved_block_clear(&pmb[i]);
 		}
 	}
-
-	free(got_match);
 }
 
 static int shrink_potential_moved_blocks(struct moved_block *pmb,
@@ -1223,7 +1193,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
+			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
 			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
-- 
gitgitgadget

