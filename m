Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F22FC4332F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0933660E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbhJ0MG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbhJ0MGy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA84C061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v127so2367157wme.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I1OjuyEdvS7pDHXy+edm6Y3GA0g7nFkP4MZfeMkkBBA=;
        b=mp8FdCghF8/KlhQlcCCk7ee0prHiDk7D+jy+6FUDbB2FPfQaTmLLlwK5oERFiRxMOF
         LG/4sJ0ReRn5/ybXUITqAL3IW7AY0Cr3M7PUsicp7UnLrPWRYtkebsOzq6QdxH805+hr
         jNbCgKG+kPBKeaK6k2YRp6/s+wKU4jqNs7Y3iNJq6NFDS6GpRGsKeDWLraDC9cnHWXWH
         v++kz1w+lboLyJzmV9eBhflRy1eM7tQ29MIa474y1Inba/iWs1Q+DuHIbkrG1XQ0AY8s
         IQLfuZCjKlonHRxPSHoum6evxin53ucwGHGdsMxrB9H4h67sby+6vXG35G6nPAG7fmgX
         206w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I1OjuyEdvS7pDHXy+edm6Y3GA0g7nFkP4MZfeMkkBBA=;
        b=OqxloMp+L7DEnpdpw3ZPdPag1Iyq+SbKvMWapFCWFLdVKR8aSR3SCFUnPQ1DMDVkbP
         WmckYh5RSLI8SUI36UP8ABBoGOaWms1BNtbd2Cjep9sRilrX593wNrHYQ7OfhLiIhi1t
         lMKMoZrTT0xuqNJKnyEJSdXW9BV6ZDvUyhcgpbbTiNLsAQjbRPksu/8mQXmC6MY347zg
         tiDcd0VP5FSVWw5Vein48dDUoOGDDQYvy2Y/P3fe9IdJf7N7OyA8Fcdw5I7R7T1dQSHT
         IF3Nh8rpUO1kHOkzkSjDbUHBxtOSpMGkYz6iww+I7OH5a1MxdB2eIsYjGASLhQXK5uN6
         k+VA==
X-Gm-Message-State: AOAM5317fR+1HajJkrnk4CFNFk5CSKaZpv2cjoJGMOgRK/5gumY0YGwC
        XkZE6WBJUIHdct2RcIQTKMVVC8SYD+0=
X-Google-Smtp-Source: ABdhPJz2CeWovAK2TBD02K9H9qnugNmyAuVmCHiyB3mwp1T7HuUgrntT7dG+CJs2+8FTXdsfoPnPIg==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr5322774wmc.126.1635336266996;
        Wed, 27 Oct 2021 05:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3sm3415325wms.5.2021.10.27.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:26 -0700 (PDT)
Message-Id: <658aec2670c78f9753a5acccab20d3a1741403e6.1635336262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:10 +0000
Subject: [PATCH v3 03/15] diff --color-moved: factor out function
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

This code is quite heavily indented and having it in its own function
simplifies an upcoming change.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index bd8e4ec9757..09af94e018c 100644
--- a/diff.c
+++ b/diff.c
@@ -1098,6 +1098,38 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
 	return rp + 1;
 }
 
+static void fill_potential_moved_blocks(struct diff_options *o,
+					struct hashmap *hm,
+					struct moved_entry *match,
+					struct emitted_diff_symbol *l,
+					struct moved_block **pmb_p,
+					int *pmb_alloc_p, int *pmb_nr_p)
+
+{
+	struct moved_block *pmb = *pmb_p;
+	int pmb_alloc = *pmb_alloc_p, pmb_nr = *pmb_nr_p;
+
+	/*
+	 * The current line is the start of a new block.
+	 * Setup the set of potential blocks.
+	 */
+	hashmap_for_each_entry_from(hm, match, ent) {
+		ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
+			if (compute_ws_delta(l, match->es, &(pmb[pmb_nr]).wsd))
+				pmb[pmb_nr++].match = match;
+		} else {
+			pmb[pmb_nr].wsd = 0;
+			pmb[pmb_nr++].match = match;
+		}
+	}
+
+	*pmb_p = pmb;
+	*pmb_alloc_p = pmb_alloc;
+	*pmb_nr_p = pmb_nr;
+}
+
 /*
  * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
  *
@@ -1198,23 +1230,8 @@ static void mark_color_as_moved(struct diff_options *o,
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
 		if (pmb_nr == 0) {
-			/*
-			 * The current line is the start of a new block.
-			 * Setup the set of potential blocks.
-			 */
-			hashmap_for_each_entry_from(hm, match, ent) {
-				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
-				if (o->color_moved_ws_handling &
-				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
-					if (compute_ws_delta(l, match->es,
-							     &pmb[pmb_nr].wsd))
-						pmb[pmb_nr++].match = match;
-				} else {
-					pmb[pmb_nr].wsd = 0;
-					pmb[pmb_nr++].match = match;
-				}
-			}
-
+			fill_potential_moved_blocks(
+				o, hm, match, l, &pmb, &pmb_alloc, &pmb_nr);
 			if (adjust_last_block(o, n, block_length) &&
 			    pmb_nr && last_symbol != l->s)
 				flipped_block = (flipped_block + 1) % 2;
-- 
gitgitgadget

