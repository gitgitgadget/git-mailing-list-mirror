Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F75C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF9661B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhKPJxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhKPJwo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB259C061764
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r8so36269395wra.7
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/NY0FSLLgoOM2WL1cJXCz+GAAkWsSqC7KSVILVwygw=;
        b=amaIAAb6TfNMreMgdHBSbX4Bt2XzWm+DD623LP+e54DGs6ekpNOi1HG321qy1pU9Ps
         G/HFTGLkaUgnSKPicqDt7mbE5Y2a/HE+tKXKj37395omWVQfA7nyc7+1xYtCyIS22FYN
         L3P3dwIQFrcg65YkkMIGy0/FCu85chHhxwxSLRXJbAjsVdXl1Ez+fvAjdHIhqz5HgEye
         W/5ibGzT+cFf19FcaTxioW33AJjcvsx1lwS6J3cZy/pi6cxsNLFeRpWJ8JUSz8yaO/3l
         SiaE9C+Yw08g93K/rCSgZbdCL18wWfWru49XVMc38ElvtNefaY/HblqcxrkpbcsrFjIb
         aA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/NY0FSLLgoOM2WL1cJXCz+GAAkWsSqC7KSVILVwygw=;
        b=8C56VQSqFYsSH9KW4einVl2RfUIROAZ9rjVDo6pizZkl1Ahon79SOruT0lmgWi0BLh
         NSSv9uzs2rNL4sC/2fSPK8v5/wKgT2mco0x4aFeONWMrPEomMUYbK5DVFQ0ANwy82G88
         jD5jSSx5aOAhlQ+WeSJkZ6oZNzv5x/QGE0vjzIdJAN8cEU4O6pk62ZQwhCBmVPYOS46m
         YGvK+sI2PkHoNExivuZ2oDjP6r6EiWYFRjPGnM1G+bLLFBlf0bDgUZKrHK+m0NZXP+XI
         q9bXzMev2RWkaeIy5/9eOUlnQqCJ+N4Tg5T2E93h0zFlaSTNlVg2WePqE6udFCGiKz2S
         5+0A==
X-Gm-Message-State: AOAM532bESCt8rlR0YgVyCojlZ+5kz2WIU9lgtiIKpelJrNrIEhh2u+R
        K7JJFrVdK7Q214Mt2f60qPICCo3zPLw=
X-Google-Smtp-Source: ABdhPJxHKRCXWUBuEAodxphiEu1h4M+500yFgFKvsYkBwKPX7EyQbHUYm9b/zJ+/pm4/7poU9kmcww==
X-Received: by 2002:adf:f001:: with SMTP id j1mr7417110wro.351.1637056186228;
        Tue, 16 Nov 2021 01:49:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22sm2096832wmq.38.2021.11.16.01.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:45 -0800 (PST)
Message-Id: <d7bbc0041e076077d3c3299858799cc9907d9831.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:31 +0000
Subject: [PATCH v4 08/15] diff --color-moved-ws=allow-indentation-change:
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

Test                                                                  HEAD^              HEAD
---------------------------------------------------------------------------------------------------------------
4002.1: diff --no-color-moved --no-color-moved-ws large change        0.38 (0.35+0.03)   0.38(0.35+0.03)  +0.0%
4002.2: diff --color-moved --no-color-moved-ws large change           0.86 (0.80+0.06)   0.87(0.83+0.04)  +1.2%
4002.3: diff --color-moved-ws=allow-indentation-change large change  19.01(18.93+0.06)   0.97(0.92+0.04) -94.9%
4002.4: log --no-color-moved --no-color-moved-ws                      1.16 (1.06+0.09)   1.17(1.06+0.10)  +0.9%
4002.5: log --color-moved --no-color-moved-ws                         1.32 (1.25+0.07)   1.32(1.24+0.08)  +0.0%
4002.6: log --color-moved-ws=allow-indentation-change                 1.71 (1.64+0.06)   1.36(1.25+0.10) -20.5%

Test                                                                  master             HEAD
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

