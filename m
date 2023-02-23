Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3419C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjBWJPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjBWJPT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236024C6F5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:10 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso2153254wmp.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq/pwwFu2jHN6wkvRR/mMGXfOikuvtWzqzg/eIEyRck=;
        b=P+s2ro1Anu1NDfEUgMySSeIf6moN4h5DyprVjihCFWT5pZb9MBuHPHDnDn6ruWz8Nq
         E1VYAD5DSSX5fkojeRsNg+ed/kipMnZ8NTxeCEcv+RcKbwk2csWVSzpebii7M+7qvBLR
         uT+mqF5khVBoNcqQybUtOKChawQzNR/6pl1rwR9t3hxq03dHjlga+aGDruaugBEWRrIY
         jXO8Q0PhKDxS4nT//xj65YjdC/Z9/rQVVBjB8cmn+4CzBGLaNZupDDb9wmLyj1AQfAYB
         IhY2y6ZzxctdeOdr5HdujoGMidvBbCs4pLsLi/oi/NhFB+8mXqWw2WxAP5SVKfv6Bi6c
         f7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq/pwwFu2jHN6wkvRR/mMGXfOikuvtWzqzg/eIEyRck=;
        b=AEdWqd25coZs2f/VXgPsJOIUA4QT6AuPOtdx0jF7tkj7AUDw0jJXcJYzVqBy0uhzo/
         HNZBoufN8QwKOPYfFwUwFTBSr6KIcJdD8SCDis0TpsUF3XLLghhvRx7vvpQ5uHJ4s8V/
         Jc0fZP74bj2YW+kwp23sA1uJAXs/r1WGDue1nJ7SMCxraFfwWV0G0U36WkWGU8LsLJj7
         6/tVtTlW9nViLCDHzVR01iDR12Pf16lPxTlIweJavNIWZwRvrjFGNTsAr3y1CKmVjVbB
         KihrnRacSYQzayw7TO3weU76PoBcgKHr0Sdloy8/oaxbMe98IHP61FL1BK9KDhhRAmOO
         pBpg==
X-Gm-Message-State: AO0yUKXq2Yjat5zLtrGVodlMz+YkTjOJiX1omUjkv86g7euG4AS9zkbi
        9l/MfObRgiGM6mVDoqFB4ybP5W9WsWg=
X-Google-Smtp-Source: AK7set+r89/T0LJa3iBjTIZ1iHAWP+PtMDIoHcXPZSlzZ1X1rLhEOMzJ1YPLNLaLrrhwP7BR8bQUSw==
X-Received: by 2002:a05:600c:319a:b0:3dc:4fd7:31f7 with SMTP id s26-20020a05600c319a00b003dc4fd731f7mr7925931wmp.41.1677143708468;
        Thu, 23 Feb 2023 01:15:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003e7c89b3514sm7456228wmc.23.2023.02.23.01.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:08 -0800 (PST)
Message-Id: <f492ab27b19748a29cfcda88ea098797c512777a.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:58 +0000
Subject: [PATCH 09/11] unpack-trees: rewrap a few overlong lines from previous
 patch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The previous patch made many lines a little longer, resulting in four
becoming a bit too long.  They were left as-is for the previous patch
to facilitate reviewers verifying that we were just adding "internal."
in a bunch of places, but rewrap them now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index d89eb3d8bf0..fa186a27ccc 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1213,8 +1213,8 @@ static int unpack_single_entry(int n, unsigned long mask,
 		 * cache entry from the index aware logic.
 		 */
 		src[i + o->merge] = create_ce_entry(info, names + i, stage,
-						    &o->internal.result, o->merge,
-						    bit & dirmask);
+						    &o->internal.result,
+						    o->merge, bit & dirmask);
 	}
 
 	if (o->merge) {
@@ -1918,14 +1918,15 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	} else if (o->src_index == o->dst_index) {
 		/*
 		 * o->dst_index (and thus o->src_index) will be discarded
-		 * and overwritten with o->internal.result at the end of this function,
-		 * so just use src_index's split_index to avoid having to
-		 * create a new one.
+		 * and overwritten with o->internal.result at the end of
+		 * this function, so just use src_index's split_index to
+		 * avoid having to create a new one.
 		 */
 		o->internal.result.split_index = o->src_index->split_index;
 		o->internal.result.split_index->refcount++;
 	} else {
-		o->internal.result.split_index = init_split_index(&o->internal.result);
+		o->internal.result.split_index =
+			init_split_index(&o->internal.result);
 	}
 	oidcpy(&o->internal.result.oid, &o->src_index->oid);
 	o->merge_size = len;
@@ -2049,7 +2050,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0))
-				cache_tree_verify(the_repository, &o->internal.result);
+				cache_tree_verify(the_repository,
+						  &o->internal.result);
 			if (!o->skip_cache_tree_update &&
 			    !cache_tree_fully_valid(o->internal.result.cache_tree))
 				cache_tree_update(&o->internal.result,
-- 
gitgitgadget

