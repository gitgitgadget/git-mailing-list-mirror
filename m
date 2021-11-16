Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A67EC4332F
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DF563218
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhKPJxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhKPJwp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035A3C061206
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so36371488wrb.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p2vb6cLuLTkHSnEEqr1bN8UrIqfnfxxTwYxWo4ujnVY=;
        b=mdBEZ4WDWRmy2fC6bx6/aIP6nXp50ngRrz0TCbsmtIFYs0Ivc0ib8s6qm1VOzPnc+w
         jFnmZYcTi8yETIkLNB0oSsg1cSI5aX8+RNfxnQuyZEDLw07dKv+hVpqb7l6SaCfIHqTP
         +7MwwkLete4YXmg0MoRLAl2BcwjbnueUHqKGlHUiF2mcRAPrv5Bh4t5YOL3JQ24ZaQGG
         vnW97sTwoQWUJtGI0NdikTrw6NxVVVvna6q7DA4WHLAPq7ffxsZxSKxd7hf8CDnSUjNG
         Jm7+c+b08P2AWKlin8cwN5dhRhyocUObB6wu648UHMToQ1CKLDbFuieIdEzeH8f32vl1
         V5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p2vb6cLuLTkHSnEEqr1bN8UrIqfnfxxTwYxWo4ujnVY=;
        b=Rn4IxFdTj09jq/uWoXXZ2nfrflg2qG3otKnkWOYOwM+WNdhK8BX/wReermxb0Elhok
         Cq9L1MQsOlfNQONXr9tDoIoQ355baVJe5aZxcxykYJUodqGq4KgiQcyRnQhVDWew5DxM
         oP9b7U8WkxS7J5KS1PWyPEkBZ2QWSas7j8ARZA6VYyyVi/lrPYM1nsS99uVCls7nHiSV
         lC2jj60cf3+gKnaI9TWxUFWWdqXd2QBYPwLJ7yec9OgymzfNIRFOpNZOrbXwT3y5BQbM
         xbP2EEzwY8/2QoFEUXdtVWVoKcnjIcPdtscz0k5qNYSus14YEZxLhBfbKvPbutDHjc43
         b8/w==
X-Gm-Message-State: AOAM531dLbZWrCbWos2A/Nrh7aO7/Fp3aZ+rgNaIE83PUWwhyesO9bB8
        5RlktiMy9wIJB6Eiy/ESp5vlXDhAImw=
X-Google-Smtp-Source: ABdhPJxnFf7rZ1IL2sfG14FqStun+KSUw+CYbc1EoRduR+Hyvq5YtSKIXiOCbgQKtEpHDJwpNNm0iA==
X-Received: by 2002:a05:6000:252:: with SMTP id m18mr7606380wrz.117.1637056187522;
        Tue, 16 Nov 2021 01:49:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm17947314wru.21.2021.11.16.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:47 -0800 (PST)
Message-Id: <9eb8cecd52a5eef7510d59d7750f225eb5f8d64c.1637056179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:33 +0000
Subject: [PATCH v4 10/15] diff --color-moved: unify moved block growth
 functions
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

After the last two commits pmb_advance_or_null() and
pmb_advance_or_null_multi_match() differ only in the comparison they
perform. Lets simplify the code by combining them into a single
function.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 41 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/diff.c b/diff.c
index 22e0edac173..51f092e724e 100644
--- a/diff.c
+++ b/diff.c
@@ -1002,36 +1002,23 @@ static void pmb_advance_or_null(struct diff_options *o,
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
-		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
-			/* Advance to the next line */
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			match = cur &&
+				!cmp_in_block_with_wsd(cur, l, &pmb[i]);
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
 
@@ -1194,11 +1181,7 @@ static void mark_color_as_moved(struct diff_options *o,
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

