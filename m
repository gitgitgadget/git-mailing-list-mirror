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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D493C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD126128B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhFNNH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:07:57 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38515 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhFNNH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:07:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id c9so14467829wrt.5
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7ptADnsdV5jSqQyjKSoWpUjp24y32fJyMkCdCIo/HpY=;
        b=p1VIYBmfc4Sfv47pzBthmbkOOfcpmMmjjdlmnxNE8ppakE34zlHYeY1T+IjRyutlGH
         JHRiPW6oONnzn6E6p+HBrMQujM8LGQ6NxLpYF3/f0XBxSUt0BbyRGQbXMF5jp1laHEYq
         k5D2sd7Je2laZa8TqEoNn1sycllECPxRcswv4oostBk6yHfdEAmlMZXgGdDNeimYGybg
         GvcvgsoaR5z+RuJrehUUZFYXmBQrENr7pRU4gxjJE/SjaSyzwehXTbGwRzRwvrUrVhJp
         zxNz0J3kFAyzSrKulS9UQsbGQVeICrm/gynsJP5Uos+jeFj/xDlbUaNOLNNP84ghF1rX
         jebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7ptADnsdV5jSqQyjKSoWpUjp24y32fJyMkCdCIo/HpY=;
        b=HbrgHezwQPIIRKHBFZceP7hy8XHxpJ+LeKkPNpEcIX3X8B/hR7W/1EnwWcDIwtWqXV
         mVFMtw1o+gtJiP8MIoPhtVYa6cb9HRx5KaxledrdJihRiII6cIEIZJ9LMBJTLlHoOCgJ
         URobNLY4jYUUrtOvKmmPTZWN05h7KKZdv4Sa+apjYY4qt6Z38dBhwKHYE/50pFvVeO3I
         oKAHV12TFDuxPqZXUr1B+o+w8GDybKg5XXRNX0iWutBiPQKMiwaF6fWOtqSMXMgz/44H
         IzI6UrxnTzip/USwjS5R9IyiMQkiHJEeuCLiYSVh6D7I5S0jntnd5XjibfoRDji+6/Bo
         5Xlg==
X-Gm-Message-State: AOAM532u6HurJLgvqZwbc9bvulYBTmnMCRt3ISqhe1mN8ewDumUNu1Bl
        7L8KzXGFa/2YJjQ8icIo0dZM9A+Sa+s=
X-Google-Smtp-Source: ABdhPJy9ADasxiJnpMencYUDOrJ4Kjsf1pFtSF4yXOHhvmnKOFHGLjHP7jYwLxGQ5x31SJuf9baD+Q==
X-Received: by 2002:adf:9031:: with SMTP id h46mr18862057wrh.125.1623675892884;
        Mon, 14 Jun 2021 06:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1sm13290825wmi.44.2021.06.14.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:52 -0700 (PDT)
Message-Id: <ebb6eec1d928e02c9d85afad8b18551ec245fc71.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:42 +0000
Subject: [PATCH 04/10] diff --color-moved-ws=allow-indentation-change:
 simplify and optimize
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
by 88% and simplifies the code.

Before this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
  Time (mean ± σ):      9.978 s ±  0.042 s    [User: 9.905 s, System: 0.057 s]
  Range (min … max):    9.917 s … 10.037 s    10 runs

After this change
Benchmark #1: bin-wrappers/git diff --diff-algorithm=myers --color-moved --color-moved-ws=allow-indentation-change v2.28.0 v2.29.0
  Time (mean ± σ):      1.220 s ±  0.004 s    [User: 1.160 s, System: 0.058 s]
  Range (min … max):    1.214 s …  1.226 s    10 runs

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 65 ++++++++++++++++------------------------------------------
 1 file changed, 18 insertions(+), 47 deletions(-)

diff --git a/diff.c b/diff.c
index 19c8954ec546..5d5d168107a6 100644
--- a/diff.c
+++ b/diff.c
@@ -881,35 +881,20 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 
 static int cmp_in_block_with_wsd(const struct diff_options *o,
 				 const struct moved_entry *cur,
-				 const struct moved_entry *match,
-				 struct moved_block *pmb,
-				 int n)
+				 const struct emitted_diff_symbol *l,
+				 struct moved_block *pmb)
 {
-	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-	int al = cur->es->len, bl = match->es->len, cl = l->len;
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
@@ -918,7 +903,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	delta = c_width - a_width;
+	delta = b_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
@@ -927,9 +912,8 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (pmb->wsd == INDENT_BLANKLINE)
 		pmb->wsd = delta;
 
-	return !(delta == pmb->wsd && al - a_off == cl - c_off &&
-		 !memcmp(a, b, al) && !
-		 memcmp(a + a_off, c + c_off, al - a_off));
+	return !(delta == pmb->wsd && al - a_off == bl - b_off &&
+		 !memcmp(a + a_off, b + b_off, al - a_off));
 }
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
@@ -1030,36 +1014,23 @@ static void pmb_advance_or_null(struct diff_options *o,
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
+		if (cur && !cmp_in_block_with_wsd(o, cur, l, &pmb[i])) {
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
@@ -1181,7 +1152,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		if (o->color_moved_ws_handling &
 		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
+			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
 		else
 			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
-- 
gitgitgadget

