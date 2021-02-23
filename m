Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B8C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC99564E41
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhBWC0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhBWC02 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:26:28 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0BFC061794
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f17so14868999qkl.5
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W7BAgY6QH8/c+NOhD4ioZpf2YtEHxcDQW5EvyimR7YQ=;
        b=jqjbjbqJgwuFYyIxonXcGfl47CRwhrnESVzd6eb0O0272I+V2XpZiMWNiAN2KUr6lU
         2yiQwWOQnvjubf2KNv6wFEZxw70ndVNBRfYOo0U60pnP7Y99hRCD/OK3tswHmNVv0Np9
         eZEz188Hr0iRSFRhpDyBWuSDyoLTEblLuqKrb3lIfbsO03bjED7vOKMvRB1/zZXSO2Q3
         yTkCZJqhhafFMPfEmkDLwxyGbIwRwL8k8qTI2qsTYu60wrXv/lkijPUxncDI89ymo89N
         xrgqep4YDEGqzB+uXNVH673kDZKRA2YFboK5r9vleK4/IBK9bSlP7rfm/qKAGHlcOAiZ
         nmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7BAgY6QH8/c+NOhD4ioZpf2YtEHxcDQW5EvyimR7YQ=;
        b=EF87d2oOFJog22pECcX138YslgtPOgxlTiZtWJUFzgcmYzW08DlJbac/6g+xV14fML
         FCDV/ZdVJPT4FYbHn+z1JNWxwj2g72TSPpIF3Ou/tlF45W2AEzCFv/UDKEUHQiDk31p6
         AQ4bp8fFvqfTAAw46Icv1ZrfgVB3bVyVTBw5TQHXi77tbyEIH+R2RiQG+ixEFVUQG+zf
         /5J0lsZCewZLedFrokVDHXBCknkwq4glKja10PVDlUWa1if6B5m/5cKkzdq1CQBjjyob
         VlhSLEi7Jc84mfw8w+wHU87jyozCr3dZ7hgvRvVPudtZKJREyJkRVi+A1XysT7+PfMNx
         8Vgg==
X-Gm-Message-State: AOAM5319t1OF6AmSGkwSxD0Oto4Vt8qKeq6l5l+M2CzhsPaleo+V6Bx4
        UHfuocdd99MUOxQaMRGntwOmZQHeCBYoG2jj
X-Google-Smtp-Source: ABdhPJw9V9UBm9afFvaCnzthFFZ9wjB+WVKjY+F/UNHhoTs4zExrsKSaiWCSXh8ObZ798oKOWAk3Gw==
X-Received: by 2002:a37:5088:: with SMTP id e130mr24533226qkb.321.1614047125620;
        Mon, 22 Feb 2021 18:25:25 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id a206sm14042801qkc.7.2021.02.22.18.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:25 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:25:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 7/8] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <db9f07ec1ae3fe0d9dce922ee0dea831e4a25b13.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a recent patch we added a function 'find_kept_pack_entry()' to look
for an object only among kept packs.

While this function avoids doing any lookup work in non-kept packs, it
is still linear in the number of packs, since we have to traverse the
linked list of packs once per object. Let's cache a reduced version of
that list to save us time.

Note that this cache will last the lifetime of the program. We could
invalidate it on reprepare_packed_git(), but there's not much point in
being rigorous here:

  - we might already fail to notice new .keep packs showing up after the
    program starts. We only reprepare_packed_git() when we fail to find
    an object. But adding a new pack won't cause that to happen.
    Somebody repacking could add a new pack and delete an old one, but
    most of the time we'd have a descriptor or mmap open to the old
    pack anyway, so we might not even notice.

  - in pack-objects we already cache the .keep state at startup, since
    56dfeb6263 (pack-objects: compute local/ignore_pack_keep early,
    2016-07-29). So this is just extending that concept further.

  - we don't have to worry about any packed_git being removed; we always
    keep the old structs around, even after reprepare_packed_git()

We do defensively invalidate the cache in case the set of kept packs
being asked for changes (e.g., only in-core kept packs were cached, but
suddenly the caller also wants on-disk kept packs, too). In theory we
could build all three caches and switch between them, but it's not
necessary, since this patch (and series) never changes the set of kept
packs that it wants to inspect from the cache.

So that "optimization" is more about being defensive in the face of
future changes than it is about asking for multiple kinds of kept packs
in this patch.

Here are p5303 results (as always, measured against the kernel):

  Test                                        HEAD^                   HEAD
  -----------------------------------------------------------------------------------------------
  5303.5: repack (1)                          57.34(54.66+10.88)      56.98(54.36+10.98) -0.6%
  5303.6: repack with kept (1)                57.38(54.83+10.49)      57.17(54.97+10.26) -0.4%
  5303.11: repack (50)                        71.70(88.99+4.74)       71.62(88.48+5.08) -0.1%
  5303.12: repack with kept (50)              72.58(89.61+4.78)       71.56(88.80+4.59) -1.4%
  5303.17: repack (1000)                      217.19(491.72+14.25)    217.31(490.82+14.53) +0.1%
  5303.18: repack with kept (1000)            246.12(520.07+14.93)    217.08(490.37+15.10) -11.8%

and the --stdin-packs case, which scales a little bit better (although
not by that much even at 1,000 packs):

  5303.7: repack with --stdin-packs (1)       0.00(0.00+0.00)         0.00(0.00+0.00) =
  5303.13: repack with --stdin-packs (50)     3.43(11.75+0.24)        3.43(11.69+0.30) +0.0%
  5303.19: repack with --stdin-packs (1000)   130.50(307.15+7.66)     125.13(301.36+8.04) -4.1%

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 object-store.h |  5 +++
 packfile.c     | 99 ++++++++++++++++++++++++++++----------------------
 2 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/object-store.h b/object-store.h
index 541dab0858..ec32c23dcb 100644
--- a/object-store.h
+++ b/object-store.h
@@ -153,6 +153,11 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
+	struct {
+		struct packed_git **packs;
+		unsigned flags;
+	} kept_pack_cache;
+
 	/*
 	 * A map of packfiles to packed_git structs for tracking which
 	 * packs have been loaded already.
diff --git a/packfile.c b/packfile.c
index 7f84f221ce..57d5b436fb 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2042,10 +2042,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_one_pack_entry(struct repository *r,
-			       const struct object_id *oid,
-			       struct pack_entry *e,
-			       int kept_only)
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
 	struct multi_pack_index *m;
@@ -2055,49 +2052,63 @@ static int find_one_pack_entry(struct repository *r,
 		return 0;
 
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (!fill_midx_entry(r, oid, e, m))
-			continue;
-
-		if (!kept_only)
-			return 1;
-
-		if (((kept_only & ON_DISK_KEEP_PACKS) && e->p->pack_keep) ||
-		    ((kept_only & IN_CORE_KEEP_PACKS) && e->p->pack_keep_in_core))
+		if (fill_midx_entry(r, oid, e, m))
 			return 1;
 	}
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (p->multi_pack_index && !kept_only) {
-			/*
-			 * If this pack is covered by the MIDX, we'd have found
-			 * the object already in the loop above if it was here,
-			 * so don't bother looking.
-			 *
-			 * The exception is if we are looking only at kept
-			 * packs. An object can be present in two packs covered
-			 * by the MIDX, one kept and one not-kept. And as the
-			 * MIDX points to only one copy of each object, it might
-			 * have returned only the non-kept version above. We
-			 * have to check again to be thorough.
-			 */
-			continue;
-		}
-		if (!kept_only ||
-		    (((kept_only & ON_DISK_KEEP_PACKS) && p->pack_keep) ||
-		     ((kept_only & IN_CORE_KEEP_PACKS) && p->pack_keep_in_core))) {
-			if (fill_pack_entry(oid, e, p)) {
-				list_move(&p->mru, &r->objects->packed_git_mru);
-				return 1;
-			}
+		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
+			list_move(&p->mru, &r->objects->packed_git_mru);
+			return 1;
 		}
 	}
 	return 0;
 }
 
-int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+static void maybe_invalidate_kept_pack_cache(struct repository *r,
+					     unsigned flags)
 {
-	return find_one_pack_entry(r, oid, e, 0);
+	if (!r->objects->kept_pack_cache.packs)
+		return;
+	if (r->objects->kept_pack_cache.flags == flags)
+		return;
+	FREE_AND_NULL(r->objects->kept_pack_cache.packs);
+	r->objects->kept_pack_cache.flags = 0;
+}
+
+static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
+{
+	maybe_invalidate_kept_pack_cache(r, flags);
+
+	if (!r->objects->kept_pack_cache.packs) {
+		struct packed_git **packs = NULL;
+		size_t nr = 0, alloc = 0;
+		struct packed_git *p;
+
+		/*
+		 * We want "all" packs here, because we need to cover ones that
+		 * are used by a midx, as well. We need to look in every one of
+		 * them (instead of the midx itself) to cover duplicates. It's
+		 * possible that an object is found in two packs that the midx
+		 * covers, one kept and one not kept, but the midx returns only
+		 * the non-kept version.
+		 */
+		for (p = get_all_packs(r); p; p = p->next) {
+			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
+			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
+				ALLOC_GROW(packs, nr + 1, alloc);
+				packs[nr++] = p;
+			}
+		}
+		ALLOC_GROW(packs, nr + 1, alloc);
+		packs[nr] = NULL;
+
+		r->objects->kept_pack_cache.packs = packs;
+		r->objects->kept_pack_cache.flags = flags;
+	}
+
+	return r->objects->kept_pack_cache.packs;
 }
 
 int find_kept_pack_entry(struct repository *r,
@@ -2105,13 +2116,15 @@ int find_kept_pack_entry(struct repository *r,
 			 unsigned flags,
 			 struct pack_entry *e)
 {
-	/*
-	 * Load all packs, including midx packs, since our "kept" strategy
-	 * relies on that. We're relying on the side effect of it setting up
-	 * r->objects->packed_git, which is a little ugly.
-	 */
-	get_all_packs(r);
-	return find_one_pack_entry(r, oid, e, flags);
+	struct packed_git **cache;
+
+	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
+		struct packed_git *p = *cache;
+		if (fill_pack_entry(oid, e, p))
+			return 1;
+	}
+
+	return 0;
 }
 
 int has_object_pack(const struct object_id *oid)
-- 
2.30.0.667.g81c0cbc6fd

