Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8917EC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 13:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376997AbiFPNOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376926AbiFPNN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 09:13:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DEB33A0F
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n185so750295wmn.4
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 06:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=alRx2CpD6UCtMqSiYdRE3shPSPHBMdmw/AvBwMyz424=;
        b=J8sKlu2CyzqrE/Ntc37kw9ADw95RxfLhokM2jZ0V50T/YiBGhJ2l9jsnDtJlbwSM6A
         rl5Z+83ng4I73dnRaLezXs+qhukj9GWIQUIKxGVAVyxzjzlGsKH9j/sTzDIwwM4QIntK
         v+GDLyshzmUMzbF2nPKOKuwwvAntc1RpwPTGrL7S4Uaik7WAUh9+Ihour0yxaN3T6Vu3
         6Ku3hUmeqVazup2OT98S600nmI4F+QbouLEoV81ZBora0vJN+JN0qaJ7elY1zAlqPcWF
         Fbtly+KP0gavmD1FBlLaOiQhGrjLuuIi4rAGRyBSIoRFPQcRagHEzpN7dRwCE/YhC+ve
         fnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=alRx2CpD6UCtMqSiYdRE3shPSPHBMdmw/AvBwMyz424=;
        b=tSQX+wDioXIt7vS9zX0YDhjWeKBnhwQ6M8CAREVufSepMw4bIeVMr7I4hYNev81e/e
         qGBXUOjvN0HWsaB2b5A/xMhWFtf4gjgfZ1rVq45bCqLUn1+CDIESgAtGyCsKq+OqHqU4
         KfB9Jap+uLlSGxvtnabXCnU60T/Orvn24jLDigKZxSD4arjG8YlYWpHPw5Hbu+ggvlTK
         Myb47+hZJYpJ54SWr6P3As13g6vz0IXusBKpP7KVsZfxSE8DaNdGvJkk98rhx44Fc82J
         2kyxTAvkU1OdO1UZLiq8abRSbx/JN5MNkOjNSqNB1pHhwBZb4ECtjGZpE6+U+gBUgBB/
         Pcrw==
X-Gm-Message-State: AJIora8m1cNGZHZbgutlfWa0fPmKCZDVLIeULzKqrbLkowRmPtfRAbZM
        WxFJYE5VCuiNWF6h3EYPJRM5dzo1YkKPag==
X-Google-Smtp-Source: AGRyM1v/ia8KVhCYh1k0r2nYLDwuEO4oFyD75F7Ilz363WDBsF1Lz4YHmgJxGtQ2GYVPH0qCnu8YZw==
X-Received: by 2002:a05:600c:4e0e:b0:39c:8d11:58eb with SMTP id b14-20020a05600c4e0e00b0039c8d1158ebmr5056834wmq.190.1655385236908;
        Thu, 16 Jun 2022 06:13:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020adfc088000000b00213ba0cab3asm1903143wrf.44.2022.06.16.06.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:13:56 -0700 (PDT)
Message-Id: <8486a1d6eca66e2d71b4317ce03318aed6346bc0.1655385230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
        <pull.1261.v2.git.1655385230.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 13:13:50 +0000
Subject: [PATCH v2 4/4] cache-tree: remove cache_tree_find_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This reverts 080ab56a46 (cache-tree: implement cache_tree_find_path(),
2022-05-23). The cache_tree_find_path() method was never actually called
in the topic that added it. I cannot find any reference to it in any of
my forks, so this appears to not be needed at the moment.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 cache-tree.c | 27 ---------------------------
 cache-tree.h |  2 --
 2 files changed, 29 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index ff794d940fa..56db0b5026b 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -101,33 +101,6 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *it, const char *path)
 	return find_subtree(it, path, pathlen, 1);
 }
 
-struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
-{
-	const char *slash;
-	int namelen;
-	struct cache_tree_sub it_sub = {
-		.cache_tree = it,
-	};
-	struct cache_tree_sub *down = &it_sub;
-
-	while (down) {
-		slash = strchrnul(path, '/');
-		namelen = slash - path;
-		down->cache_tree->entry_count = -1;
-		if (!*slash) {
-			int pos;
-			pos = cache_tree_subtree_pos(down->cache_tree, path, namelen);
-			if (0 <= pos)
-				return down->cache_tree->down[pos]->cache_tree;
-			return NULL;
-		}
-		down = find_subtree(it, path, namelen, 0);
-		path = slash + 1;
-	}
-
-	return NULL;
-}
-
 static int do_invalidate_path(struct cache_tree *it, const char *path)
 {
 	/* a/b/c
diff --git a/cache-tree.h b/cache-tree.h
index f75f8e74dcd..8efeccebfc9 100644
--- a/cache-tree.h
+++ b/cache-tree.h
@@ -29,8 +29,6 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
 
 int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
 
-struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path);
-
 void cache_tree_write(struct strbuf *, struct cache_tree *root);
 struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
 
-- 
gitgitgadget
