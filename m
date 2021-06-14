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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0FC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8346124B
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 13:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhFNNIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 09:08:01 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54975 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhFNNH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 09:07:57 -0400
Received: by mail-wm1-f51.google.com with SMTP id m3so6863256wms.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BTvJD0RFB3UwlLw/SUZjYlXTTZadKg4MdVAfS3fgAB0=;
        b=RcZkKvik9cqy8CxN7Dm4hz/s0+hux8gxibf6/rxfVIaUPxTU7v4vVjXkq4o+hbY/nf
         akfB2tMFJG6GUbF688GvoUVjJv4lOM9+9Z9CYsD3afxGLHSX1vtCwQJBswTE91Z6jypa
         tGiB8V5jlNZqdyFAg0tFNxy49EIYZZfO/kJABBLC3HXBgAERoUfS/4uQj1/QiChfatR2
         UaHFk5rVw1SgJ3YGGyKQv3kJDzJxhZgt6opbyt1f7CrdNcmu6NMK1Q12VuuJpf+q4kYR
         LjNXaFcqgLFIhu9eFLiALyLrptheeRuWTnhwTKAXe+hH+m116NLeffeHdn6SFT2Rw/gX
         sUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BTvJD0RFB3UwlLw/SUZjYlXTTZadKg4MdVAfS3fgAB0=;
        b=CXaUecpeBBPh7tcO99OenPNbf72LSJUcdEKIVgJTy2oDbEtCJRBzUJhQkWzxWA1LDy
         d9CBB7rMbKxa+VYKXvTH7MbRIRqksbmkLaQHbbx9fuEujduRRdInflLNUwUbKPlvGwO3
         AhH6HUjLCGf+Hzd19lFv04PD/beAfXBqfFCXeruM6mzg6+vh0GLuADUjx60iUUeEXfJ9
         Rq2imzFUoQE4h/No5kABgiVGFSKuqyMle/crQsAGIgFom90N52jtMwzDTgLGiqWY7/Sb
         3X59/aXFvES/A+cmSVMnRaNHW6Qhcx6bNDiywFEPW7lyIGWWTQb2qzVkdPSDjteqh73b
         oE7g==
X-Gm-Message-State: AOAM531nb+Xi7Q0DXHJx2b2QLJS2oIY5cr8HYs/GGcw6fpoGSDF78h4i
        hmuweGE5BfPOhNs0d8KR9ThyQNlo0Gk=
X-Google-Smtp-Source: ABdhPJx/hdk94oO0sI25ho9nU9ZMKVEPVkWKa1IPQtStQlau1Ex2KFHV8IGi5FcXsxcwgFF9mqQplg==
X-Received: by 2002:a05:600c:1c22:: with SMTP id j34mr33769690wms.166.1623675893872;
        Mon, 14 Jun 2021 06:04:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm15754076wrx.28.2021.06.14.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:04:53 -0700 (PDT)
Message-Id: <050cef0081dc8252b55a4d69cca3bd08ae4eff98.1623675889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.git.1623675888.gitgitgadget@gmail.com>
References: <pull.981.git.1623675888.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Jun 2021 13:04:44 +0000
Subject: [PATCH 06/10] diff --color-moved: unify moved block growth functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

After the last two commits pmb_advance_or_null() and
pmb_advance_or_null_multi_match() differ only in the comparison they
perform. Lets simplify the code by combining them into a single
function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index c8fdfc9049bb..de6522a3a860 100644
--- a/diff.c
+++ b/diff.c
@@ -1003,36 +1003,23 @@ static void pmb_advance_or_null(struct diff_options *o,
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
 	for (i = 0; i < pmb_nr; i++) {
+		int match;
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
-		if (cur && xdiff_compare_lines(cur->es->line, cur->es->len,
-						l->line, l->len,
-						flags)) {
-			pmb[i].match = cur;
-		} else {
-			pmb[i].match = NULL;
-		}
-	}
-}
 
-static void pmb_advance_or_null_multi_match(struct diff_options *o,
-					    struct emitted_diff_symbol *l,
-					    struct moved_block *pmb,
-					    int pmb_nr)
-{
-	int i;
-
-	for (i = 0; i < pmb_nr; i++) {
-		struct moved_entry *prev = pmb[i].match;
-		struct moved_entry *cur = (prev && prev->next_line) ?
-			prev->next_line : NULL;
-		if (cur && !cmp_in_block_with_wsd(o, cur, l, &pmb[i])) {
-			/* Advance to the next line */
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			match = cur &&
+				!cmp_in_block_with_wsd(o, cur, l, &pmb[i]);
+		else
+			match = cur &&
+				xdiff_compare_lines(cur->es->line, cur->es->len,
+						    l->line, l->len, flags);
+		if (match)
 			pmb[i].match = cur;
-		} else {
+		else
 			moved_block_clear(&pmb[i]);
-		}
 	}
 }
 
@@ -1153,11 +1140,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		if (o->color_moved_ws_handling &
-		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
-			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);
-		else
-			pmb_advance_or_null(o, l, pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
gitgitgadget

