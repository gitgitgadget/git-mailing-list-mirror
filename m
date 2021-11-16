Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A67C43217
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235206321A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhKPJxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhKPJwq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B76C061207
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:49 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b12so36383845wrh.4
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PvZWtTB+saRNvbTicS6KSTgR/AzyDN0INgP6F8z97h4=;
        b=HBze0Zx/e2JcKLsikgJxm7kSpNX2fwHUmoGomnOKcZ8gor3PfrHke/WkXeBLlyZTyN
         m/7vs4vyX0oCfIYO33vYftohcxQIfdsRwp5JU4NXeeXn0tDsTJqa+4mnP2c8+8z2nf34
         BRO5OPXnC9wp0DiaVQA9lTUwsbQCcpqSA7zl5LH+DIWPVKl4m4eyrlpXqwP0CTK20an+
         ACKyIlXMLrDvQGDeHF+QnRfC9A3fF8hXQbLsfO3PeRyfvwVj9RNAGZfDdcTAn69iSrf9
         TU9uhfFzaOyhjsg0SUykftP3/XUBfrzDU4UD/qRSWyEzAG5zBq0LwjwxIkCeD1rkSRaF
         hBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PvZWtTB+saRNvbTicS6KSTgR/AzyDN0INgP6F8z97h4=;
        b=hSF1tJBHXxtSTcxxHGERzoaK+sHbaV2CmHArtRnRp5yZWHHRdB5wOod6fIJGgkbwkZ
         jjwO2v8mDmyrnimfAK9FQ2Aeab75mMOQNDGn2KQteJE5Kgb24CLfjAXyfXPKjUmqXk9E
         06FwHh3L7ghHUIz8t3FdfMZUEPgdhxrZcMdO47U9RKmtFduJxncfZNA+L3ELuSy9oxL8
         r6I19eSaqv9T5IHjrEfZhb80UOLrONFgLWK6eRaY6KTte9xiQ3253VJuQ7c9Whwd9+uB
         gI8v8T23PMK/H/TEQAUm05WJLhd5qxz6dTHMihiRsHMTwB6nX6nu3MG9uMmev47UpkXi
         stjA==
X-Gm-Message-State: AOAM530APL2DpwS7dqCPzbuhX5JH6zZsHbI0TKBRhTflRIRf/tmM/NHu
        9ViWXBOtH8Y0wxHIfPgl1GLeIe5D1wU=
X-Google-Smtp-Source: ABdhPJz9hmru3qgOpzmHZZDGM+Y9V/0jq37UNsghBi4X3wKy7tyjSuDoTiswYXs36HGmW4R7QFC/Yg==
X-Received: by 2002:a05:6000:1a45:: with SMTP id t5mr7606951wry.306.1637056188140;
        Tue, 16 Nov 2021 01:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g124sm1422533wme.28.2021.11.16.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:47 -0800 (PST)
Message-Id: <35e204e157896ea1bd99535a89051dee245a6600.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:34 +0000
Subject: [PATCH v4 11/15] diff --color-moved: shrink potential moved blocks as
 we go
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

Rather than setting `match` to NULL and then looping over the list of
potential matched blocks for a second time to remove blocks with no
matches just filter out the blocks with no matches as we go.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 44 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index 51f092e724e..626fd47aa0e 100644
--- a/diff.c
+++ b/diff.c
@@ -996,12 +996,12 @@ static void add_lines_to_move_detection(struct diff_options *o,
 static void pmb_advance_or_null(struct diff_options *o,
 				struct emitted_diff_symbol *l,
 				struct moved_block *pmb,
-				int pmb_nr)
+				int *pmb_nr)
 {
-	int i;
+	int i, j;
 	unsigned flags = o->color_moved_ws_handling & XDF_WHITESPACE_FLAGS;
 
-	for (i = 0; i < pmb_nr; i++) {
+	for (i = 0, j = 0; i < *pmb_nr; i++) {
 		int match;
 		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
@@ -1015,38 +1015,12 @@ static void pmb_advance_or_null(struct diff_options *o,
 			match = cur &&
 				xdiff_compare_lines(cur->es->line, cur->es->len,
 						    l->line, l->len, flags);
-		if (match)
-			pmb[i].match = cur;
-		else
-			moved_block_clear(&pmb[i]);
-	}
-}
-
-static int shrink_potential_moved_blocks(struct moved_block *pmb,
-					 int pmb_nr)
-{
-	int lp, rp;
-
-	/* Shrink the set of potential block to the remaining running */
-	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
-		while (lp < pmb_nr && pmb[lp].match)
-			lp++;
-		/* lp points at the first NULL now */
-
-		while (rp > -1 && !pmb[rp].match)
-			rp--;
-		/* rp points at the last non-NULL */
-
-		if (lp < pmb_nr && rp > -1 && lp < rp) {
-			pmb[lp] = pmb[rp];
-			memset(&pmb[rp], 0, sizeof(pmb[rp]));
-			rp--;
-			lp++;
+		if (match) {
+			pmb[j] = pmb[i];
+			pmb[j++].match = cur;
 		}
 	}
-
-	/* Remember the number of running sets */
-	return rp + 1;
+	*pmb_nr = j;
 }
 
 static void fill_potential_moved_blocks(struct diff_options *o,
@@ -1181,9 +1155,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 		}
 
-		pmb_advance_or_null(o, l, pmb, pmb_nr);
-
-		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
+		pmb_advance_or_null(o, l, pmb, &pmb_nr);
 
 		if (pmb_nr == 0) {
 			int contiguous = adjust_last_block(o, n, block_length);
-- 
gitgitgadget

