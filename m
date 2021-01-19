Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55641C433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BB223109
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbhASX0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbhASXZV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:21 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38FC061794
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 19so318438qkh.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7WeABY+vAqwNzN0bzWtj8mK0ZamjlSlAYHKJlFfisJQ=;
        b=1Eo9WX0HC0ZtgfWHqKN87Az3NFboCv//9DL3BRvJdybwZdPnFNX3KCQpk8W1dJoYWl
         YMyxuEcLrzCCMbiGeABaYRbD78J5axn/3D9G03XJXPjX/e+G7RQdWVrDNbxvYomfUKCc
         cGN+SJcAZ8ifPUtX7UliMzpN5wINoOMVX//0Frd/YmEWe4BjS4goLP0NJOVxXlNvl5RE
         r6Sl/3/eztkKp+OxWklc1HZpOeYkzcCWPZuWXrfxOwb9BjxhY/ZTLJZMHARP4meovrRz
         XtTqOWjlC+75DpCNtXafdB64UJVVx6Ruk5Asemo8BYdp3sFF7nQ1cLFSdtGokofZB/hd
         nuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7WeABY+vAqwNzN0bzWtj8mK0ZamjlSlAYHKJlFfisJQ=;
        b=s+FzS8ayYSDOZ3fmVeHfQUzTBiSSQ+HrDj61lWtfRMqJUo7xwDhPz9s/12LbmWfAoP
         6CulivncHIcWg2aQ9BqK9GVoToWtjV+njmJD8BDhgvmbzm2dpHXnenQILgKsezA0tT49
         yLnU9gubXAsn9Ei80ozfQvKxMA4oel7qlufcE5xK6fgHp7JAA61A16GoFtmNvM9BoZFG
         iWvdfep4mH+MPqP2TuSXoVTdfDix8tDRFJlDWZ195ZX2HmX1GNxzYj7zvHipc/XQZtKD
         hacBSue/kvBGkBc72bAxobQYKiq2x1A1nc0Ufcku6fsCZifwN4uo6+c/9TqM7F1TCtVN
         YoFA==
X-Gm-Message-State: AOAM5306BTOCsU5hj5SEONWThDjOfiRt9NYvhi1wpln4CIdEdFDOGFzJ
        p8QSE0zjgzyfXA08gferv1Vkosberm5e0A==
X-Google-Smtp-Source: ABdhPJzG5jlQWmpcGgacRxxqwJotmU4Rd+0brURHvfGmdaxpgXEmS3mqJuZnhWh+DGAl+Y7YYR4Q8w==
X-Received: by 2002:a37:4d8e:: with SMTP id a136mr6670989qkb.317.1611098667747;
        Tue, 19 Jan 2021 15:24:27 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id o187sm51584qkd.70.2021.01.19.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:27 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 07/10] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <182664e1a9c107fd830f9eb02bfa25fe9679e9a7.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
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

Here are p5303 results (as always, measured against the kernel):

  Test                               HEAD^                  HEAD
  ------------------------------------------------------------------------------------
  5303.5: repack (1)                 56.87(54.63+10.48)     56.63(54.41+10.36) -0.4%
  5303.6: repack with keep (1)       1.26(1.19+0.06)        1.25(1.19+0.05) -0.8%
  5303.10: repack (50)               89.35(132.42+6.25)     89.49(132.31+6.31) +0.2%
  5303.11: repack with keep (50)     6.73(26.61+0.59)       6.72(26.70+0.53) -0.1%
  5303.15: repack (1000)             217.25(494.38+15.24)   218.69(495.62+14.99) +0.7%
  5303.16: repack with keep (1000)   133.12(311.80+8.44)    128.79(306.96+8.55) -3.3%

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |   4 +-
 object-store.h         |  10 ++++
 packfile.c             | 103 +++++++++++++++++++++++------------------
 packfile.h             |   4 --
 revision.c             |   8 ++--
 5 files changed, 75 insertions(+), 54 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c84642df98..f2c7a1e35b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1215,9 +1215,9 @@ static int want_found_object(const struct object_id *oid, int exclude,
 		 */
 		unsigned flags = 0;
 		if (ignore_packed_keep_on_disk)
-			flags |= ON_DISK_KEEP_PACKS;
+			flags |= CACHE_ON_DISK_KEEP_PACKS;
 		if (ignore_packed_keep_in_core)
-			flags |= IN_CORE_KEEP_PACKS;
+			flags |= CACHE_IN_CORE_KEEP_PACKS;
 
 		if (ignore_packed_keep_on_disk && p->pack_keep)
 			return 0;
diff --git a/object-store.h b/object-store.h
index c4fc9dd74e..4cbe8eae3c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -105,6 +105,14 @@ static inline int pack_map_entry_cmp(const void *unused_cmp_data,
 	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
 }
 
+#define CACHE_ON_DISK_KEEP_PACKS 1
+#define CACHE_IN_CORE_KEEP_PACKS 2
+
+struct kept_pack_cache {
+	struct packed_git **packs;
+	unsigned flags;
+};
+
 struct raw_object_store {
 	/*
 	 * Set of all object directories; the main directory is first (and
@@ -150,6 +158,8 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
+	struct kept_pack_cache *kept_pack_cache;
+
 	/*
 	 * A map of packfiles to packed_git structs for tracking which
 	 * packs have been loaded already.
diff --git a/packfile.c b/packfile.c
index 30f43a1a35..25f5407ed0 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2015,10 +2015,7 @@ static int fill_pack_entry(const struct object_id *oid,
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
@@ -2028,49 +2025,64 @@ static int find_one_pack_entry(struct repository *r,
 		return 0;
 
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (!(fill_midx_entry(r, oid, e, m)))
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
+	if (!r->objects->kept_pack_cache)
+		return;
+	if (r->objects->kept_pack_cache->flags == flags)
+		return;
+	free(r->objects->kept_pack_cache->packs);
+	FREE_AND_NULL(r->objects->kept_pack_cache);
+}
+
+static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
+{
+	maybe_invalidate_kept_pack_cache(r, flags);
+
+	if (!r->objects->kept_pack_cache) {
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
+			if ((p->pack_keep && (flags & CACHE_ON_DISK_KEEP_PACKS)) ||
+			    (p->pack_keep_in_core && (flags & CACHE_IN_CORE_KEEP_PACKS))) {
+				ALLOC_GROW(packs, nr + 1, alloc);
+				packs[nr++] = p;
+			}
+		}
+		ALLOC_GROW(packs, nr + 1, alloc);
+		packs[nr] = NULL;
+
+		r->objects->kept_pack_cache = xmalloc(sizeof(*r->objects->kept_pack_cache));
+		r->objects->kept_pack_cache->packs = packs;
+		r->objects->kept_pack_cache->flags = flags;
+	}
+
+	return r->objects->kept_pack_cache->packs;
 }
 
 int find_kept_pack_entry(struct repository *r,
@@ -2078,13 +2090,15 @@ int find_kept_pack_entry(struct repository *r,
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
@@ -2093,7 +2107,8 @@ int has_object_pack(const struct object_id *oid)
 	return find_pack_entry(the_repository, oid, &e);
 }
 
-int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+int has_object_kept_pack(const struct object_id *oid,
+			 unsigned flags)
 {
 	struct pack_entry e;
 	return find_kept_pack_entry(the_repository, oid, flags, &e);
diff --git a/packfile.h b/packfile.h
index 624327f64d..eb56db2a7b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -161,10 +161,6 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
-#define ON_DISK_KEEP_PACKS 1
-#define IN_CORE_KEEP_PACKS 2
-#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)
-
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
diff --git a/revision.c b/revision.c
index ff1ea77224..ce87081b8e 100644
--- a/revision.c
+++ b/revision.c
@@ -2336,14 +2336,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		die(_("--unpacked=<packfile> no longer supported"));
 	} else if (!strcmp(arg, "--no-kept-objects")) {
 		revs->no_kept_objects = 1;
-		revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
-		revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+		revs->keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
+		revs->keep_pack_cache_flags |= CACHE_ON_DISK_KEEP_PACKS;
 	} else if (skip_prefix(arg, "--no-kept-objects=", &optarg)) {
 		revs->no_kept_objects = 1;
 		if (!strcmp(optarg, "in-core"))
-			revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+			revs->keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
 		if (!strcmp(optarg, "on-disk"))
-			revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+			revs->keep_pack_cache_flags |= CACHE_ON_DISK_KEEP_PACKS;
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
-- 
2.30.0.138.g6d7191ea01

