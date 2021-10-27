Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B61DC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E30B60E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbhJ0MHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbhJ0MHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:07:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE548C06122F
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b82-20020a1c8055000000b0032ccc728d63so2172135wmd.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p2vb6cLuLTkHSnEEqr1bN8UrIqfnfxxTwYxWo4ujnVY=;
        b=LTSfljhqQvCFQo6YFdnuT6ok6VKH5hcbz6w9029QtqMm2qIOIWTApQUWnMfCmdWDi8
         DW/YFBppMaAuzrO0U01Y6Z4L+Ec/UqN2pIj9rdZRWuJqCUWy70guttU23J35XdJeY5/0
         PLySjHSVDNh6BpCQ8HwBzDQ76542TpYycQPuLfZrTw7mcnlcXOBe++d305YI0npRQu7o
         01I4twXMgrcAHiZAqybaDHC7xaW86qZh0cbqaIkKj6KDrwj0IeBdO3wiT/NZs1Qi0QLX
         T3fwSLdx9CuJ63ORpYcNAI4wyEjbBgVFB2e6ZIdRabvWXXOphtpjSJZm1+z1GJLXgtWq
         3YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p2vb6cLuLTkHSnEEqr1bN8UrIqfnfxxTwYxWo4ujnVY=;
        b=MhQq80chG5eXs0WWCPAA4ikvNdVX+aURL1tph1dHtoZYShw+JDE2kSfCDDBTjtcwfz
         EDe8uzYb5pOVBmgl+azOtGTZZrCaRTzPxpZ/Jr8bHDMUJObohApEhNXVbYCxnrkOoL+D
         FpMniMf1aZOObeRQsDguUwrukPOeh0HFWgD9zm5fyu1kkCdi+JHFNG8UK2qTl8TkP4r+
         YG/wztdqhjL0upNy2GUQRIOGffAi9G1T44z3/QxxvSOTPUkge8w8FAO5JsdcXqiVN4so
         ckrMeJwopVyVn3hpusiSVyCT5VeL9cGWc4E1CdnYbfM884e/KMad9gJZMtX6w+gN8VFg
         vecQ==
X-Gm-Message-State: AOAM533apyrKCJmU1smWpDYIK2YJQPieCSN0G29YzsGcaMPKcUt+fvCD
        0Aa8tx8J4HyyQUN35Tq+2fevGeCtipc=
X-Google-Smtp-Source: ABdhPJwcRTuJh1QiqbhwmHpyQd9hHK4KCbLppkaAYT0qyOT/1bhJq8WpmNmedk/3Fv06k/89i1Z+Ew==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr5364714wmg.105.1635336274437;
        Wed, 27 Oct 2021 05:04:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11sm6463574wrt.49.2021.10.27.05.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:34 -0700 (PDT)
Message-Id: <8f3ea865dd33047397207c9909f114601b0a2dda.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:17 +0000
Subject: [PATCH v3 10/15] diff --color-moved: unify moved block growth
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

