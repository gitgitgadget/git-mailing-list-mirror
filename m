Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B5C4332F
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 21:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiLRVlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Dec 2022 16:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRVlp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 16:41:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A9A1A9
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 13:41:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ja17so5261472wmb.3
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iLBtMEKtJnpBv8UjK5M0ZBeHX1CJQak3Si0qeSFNRlo=;
        b=GYz60TZ6coVfVz97smX8opCZ6qnjB5ub+254syifwRFFYIY2VHtYZRJ9qG88cYXpQR
         XL/7dySqBFLnynoawZUi2OPjw12QmEbnbYSKm1OG6/EeUq681KQ+CAp3sXqKSgeBSwHr
         PksDOgq/wU9XEPHDtz0cImL7lFyflDegGJvT4tqUeFU2FD72nefSHoKL2USTpwMBCBtm
         tZLksMWVAvyWsdTX3Fp9/omI4Ru9uu4cZtIJU9WVQc6tk5am1yk6myVSegmmvGB0lU/G
         aGuw3LiLlK7ycLBbYYQ4pKCZ5UVzs3U+YgDc4+Q/g6Axiprc/7Nt8NZreJotoiUgx6nB
         gNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLBtMEKtJnpBv8UjK5M0ZBeHX1CJQak3Si0qeSFNRlo=;
        b=0uhIfd1oA/MYDlZvaIGtZ8AbbiKfhIvFukMqHLlfgQMeZh4Y/bSmTJhWvyYTk7R6t5
         mDU0/msXkROvF5P2j1jlbKKO8WHhoapiGlAWyPNWdTKR4CUGihgxmVaU7UngyI1B+Di7
         E//JL/8X6S/Qa349Z6zIz2RTbj2y7EiGMjQL/uz1P2ARGQrw64FcQx/1ef8M5eNV8E5C
         bW4iOd4O451cOnVZS5gKV0pXqoV5tdGMB4czwu9evcfKoTDmcxUokrN44G9qrR0/UNFo
         0vJMshdri77xeUkNGAEi+6BR2/LvwBiDpq+QiBNqilIq2HrX78wdTqCcmQO/PzpYOxn/
         j+Yw==
X-Gm-Message-State: AFqh2kot09Jv0PSXc25/H59K+3OwYGVwLV7beObrkEZsg1N4hvC33Tzq
        U1iXhItwvuthB6vrXSWTXO3GEz2tqYQ=
X-Google-Smtp-Source: AMrXdXsYs64GMvgw8HxIPPBaSyEbQ6qaQpwetTQd/OyjOM1Y7SHojE3+LHys1gowSvZI4vpW/vVXLA==
X-Received: by 2002:a05:600c:500d:b0:3d3:4367:ba34 with SMTP id n13-20020a05600c500d00b003d34367ba34mr7572215wmr.26.1671399700501;
        Sun, 18 Dec 2022 13:41:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b003c6f1732f65sm19446712wmq.38.2022.12.18.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 13:41:40 -0800 (PST)
Message-Id: <pull.1400.git.git.1671399699603.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 18 Dec 2022 21:41:39 +0000
Subject: [PATCH] git: remove redundant notes_ref check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

Earlier in the init_notes function, notes_ref is guaranteed
to be the default ref if it is NULL by then,
making future checks for notes_ref to be redundant,
and xstrdup_or_null can just be xstrdup.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: remove redundant notes_ref check
    
    Earlier in the init_notes function, notes_ref is guaranteed to be the
    default ref if it is NULL by then, making future checks for notes_ref to
    be redundant, and xstrdup_or_null can just be xstrdup.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1400%2FAtariDreams%2Fxstrdup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1400/AtariDreams/xstrdup-v1
Pull-Request: https://github.com/git/git/pull/1400

 notes.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index f2805d51bb1..a2283b9ace4 100644
--- a/notes.c
+++ b/notes.c
@@ -1014,14 +1014,13 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
 	t->prev_non_note = NULL;
-	t->ref = xstrdup_or_null(notes_ref);
+	t->ref = xstrdup(notes_ref);
 	t->update_ref = (flags & NOTES_INIT_WRITABLE) ? t->ref : NULL;
 	t->combine_notes = combine_notes;
 	t->initialized = 1;
 	t->dirty = 0;
 
-	if (flags & NOTES_INIT_EMPTY || !notes_ref ||
-	    get_oid_treeish(notes_ref, &object_oid))
+	if (flags & NOTES_INIT_EMPTY || get_oid_treeish(notes_ref, &object_oid))
 		return;
 	if (flags & NOTES_INIT_WRITABLE && read_ref(notes_ref, &object_oid))
 		die("Cannot use notes ref %s", notes_ref);

base-commit: 57e2c6ebbe7108b35ba30184dcbcb6c34c929ad8
-- 
gitgitgadget
