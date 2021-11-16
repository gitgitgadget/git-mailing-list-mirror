Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF4EC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D9763223
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhKPJwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhKPJwl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:41 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50566C061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so1473992wme.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I1OjuyEdvS7pDHXy+edm6Y3GA0g7nFkP4MZfeMkkBBA=;
        b=NfVQqZIpLcL2TcPH+3KEgZN1fkPIBaoh3w8xYcFo4WN9v/VWPBUCxetzQzjwxLd7te
         VGJqQ0N6NaHjLH8IC6KiwTirc3PFzS6AdiqY2xBB1tVAaH6703tsGoTfZlyThEyCmYMA
         WULovOeG3F4XRXQzPCKWaEGDj0bP4bhoZNPI76Vnq79/GIw9vp80LmSncAotk+VQEFyh
         dEN71hp8+ol17nI9TEUAHTgLoM16KvPOrElQmpfp1qPBPE+EHkzCDw5LycZio77akVCx
         3UyP5DjoNSAKmYZ2VEfPvgxfd0rvbrQPMQM7tv4JZYETne7TZQjgxISjZSap3Twrscx2
         +s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I1OjuyEdvS7pDHXy+edm6Y3GA0g7nFkP4MZfeMkkBBA=;
        b=Mk5L3Al3ZfMPU94jRXun1HsIxg7SDcKJ/W5Z/zm5af3clYBuCAOncdQnzSseqrItww
         NKqXpqLwi1y756fDDn0XP1Q5jX7babajvnO5Z2Z186RsyMeapT8LtR7z/uP+cUqxOLOB
         70cC7Wdy9HJZ2UBx/SR6UiwZU8Ykbd/x5fgx/wb9rP5gCnNshbjZ/gqY+o5Fmb05Cj0+
         /IWLA7PfuGQMs3RlyduiZ9j8juFS73VKLJuB+5xo/vUEgB1Eyjqb9Tp+/2mY3mgnOue7
         +rW0jCmanuGr86IpPe9QGH77X2ZaqBHZH8lNEZw/0c6cEMtyJxSDUTdMFWVSInLNlNAZ
         MMyw==
X-Gm-Message-State: AOAM533/d3HDWeww2uomJbOUco/Q5WEclR0Kh2iJaEKG1j/K8uQY7UIW
        Ev5bp4+c2aBvIybdLLlVI/C+bP4JNco=
X-Google-Smtp-Source: ABdhPJy6V/V+lWVlJ5ZVUKQ7bc1VIeL5fIv2zLbMZIbYIBdH8YkbDldPcDR8JKXT0340W8q/0yl0TA==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr6052281wmq.148.1637056182765;
        Tue, 16 Nov 2021 01:49:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm2443466wmp.1.2021.11.16.01.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:42 -0800 (PST)
Message-Id: <99e38ba9de9bcd7b767908ec218937ae8c2ccf36.1637056178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:26 +0000
Subject: [PATCH v4 03/15] diff --color-moved: factor out function
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

