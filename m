Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9A31355A
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784198; cv=none; b=WMVH6uxoZ2PM9keKW7zGpChqek+LB8gu41hqv1W5wP9CkOqhGCoJM8c7a/4JzE2LR7cCawE+0BgYO0TEKiqQgAkPXXy4rgtGHrG0++t6d1ZKgxHtZZ6gJVrXJaVUQlwFMWanFOc5N2aNkKYU+6NsdZg2Zy6ZO3o3bLeY4FVONWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784198; c=relaxed/simple;
	bh=SQ54D3YVwheSIQ7DFaOZKwz3x4I1HoRuZTfJz1lPl5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=siSqGsc5kJvHumI8syxx8izJActRWkVJcupdkhgI68JElELpQGJFVAET5MhMgBpWotbX526+N6ovdNaEjYTctk1u5z6jKskDsAARFwOpBRoJGdBObUycpWHKlwNu4XB0o5zy6wRfSSbYaS63yJWd+bUMvIJ0UNCcmA64bKOuMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cGaeJa/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxegJGBy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cGaeJa/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxegJGBy"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A24861400138
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Dec 2025 02:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765784194;
	 x=1765870594; bh=f6mwdqqtdtQcnh+JdJXypY2uUUcxPQ3QxW2UA1Hjgh0=; b=
	cGaeJa/CWVURpw40E+wfqhrOnmj5rVLMu0F6QVwS49xpd4an2vO9QjCqQHm3CEua
	pxQbfJSjcAHRwFO/I+xtmFtVnKkRYYJe16zgezD+0Z2PymsheoUK7W+OaFNQi436
	ckWTbWeEXw1movHDSph/Fw7ySELHHSNfqelnYgyqZ8M8EGdCuwHrxZyIjZMaXUfK
	Z9brThB3bdbbnFv6V2Mi1zvrIYWO0O0WECpaBbCvjbN8gQQNTwL1wB73ZKZqoAXU
	DL8I1oYvkJu3up3+j5HQkQW1Q8mTHmm4B8/mIJUHCjiuVW1dLWLbs7lmEz7bn7RP
	lJeMGYv0G+DVe/NLHUFwug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765784194; x=
	1765870594; bh=f6mwdqqtdtQcnh+JdJXypY2uUUcxPQ3QxW2UA1Hjgh0=; b=F
	xegJGBy5z7Pvd8Rn2HDvgKu4DVF/aio/1ueJ7Dy7nRKBwxVn8w2VUa4Jt/ODWekh
	X1aueitU90/LaMuiavni/U3in3+Q+N7NdX56GieZLDxWBkYINRhVT1+N7/ML5ALC
	48FCi4oPJjlMwDNC+d599f9UsVKJxHsrDWfX6XQJqECYcSBR4s8gCXdr8+GJkoaw
	QP2UaGzL+rSFyy/yQje9I6mfsTcOg+USmG4LrTkNycnS4xZepEf+0YWYIh/ur5a/
	csemm7EAy7nHvLnvaEC88KOiGfOpjiSrgGJJ6qMBMgbWop3pLBdujSD9iCwKNsEM
	PePIaP8h3KnDZHY6goi9Q==
X-ME-Sender: <xms:gro_aeXkEjeIZuVzrkfmQMogIQZD8TIInuk13bUS-3zVFzbNwTKJtQ>
    <xme:gro_aRhIbazAX4a4tbWPE__tPOg8vpproADtYj0RpSEhxPSm_Rm_FzP-KAJHfq5fF
    w1abqy1rSRTqdcykPEj_8qKL997iReGjWKVrS7hgskZ0oPYh-g>
X-ME-Received: <xmr:gro_aYCtj1s7D9wDIAoi61OyDCtjoLORZuMCX94DLH7icjgSWH1DeHVf8atgkjFpxncmDNV3LUWEt3rmW1zuEL9DNwEMxhgQquGuZoK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefiedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:gro_aadgg2xGPwZE3vF3u7Il10GdxzHseXqsJEc6HlqLZyzSEnmeNQ>
    <xmx:gro_aYcm38kg_3sbReCB5fkn_hYtDbMnCafwcVFhnYFbbg5BA4YoHg>
    <xmx:gro_aWiev8ge9teLNeS9THKsLEckxIeznfYHSUDiTwUZbrk4PgNW3w>
    <xmx:gro_acTrxujjVsuD6sruOZkEk-DigKFy6V4juHCOZs81B5pdrulR-Q>
    <xmx:gro_adknvWFl9zCb45xwxOtbPpx7yaNcq9qYP8A6In86XPKrEpDZ6Vhw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Dec 2025 02:36:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3426ced (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Dec 2025 07:36:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Dec 2025 08:36:22 +0100
Subject: [PATCH 03/10] packfile: refactor kept-pack cache to work with
 packfile stores
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251215-b4-pks-pack-store-via-source-v1-3-433aac465295@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The kept pack cache is a cache of packfiles that are marked as kept
either via an accompanying ".kept" file or via an in-memory flag. The
cache can be retrieved via `kept_pack_cache()`, where one needs to pass
in a repository.

Ultimately though the kept-pack cache is a property of the packfile
store, and this causes problems in a subsequent commit where we want to
move down the packfile store to be a per-object-source entity.

Prepare for this and refactor the kept-pack cache to work on top of a
packfile store instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 12 ++++++------
 packfile.c             | 37 ++++++++++++++++++++-----------------
 packfile.h             | 18 +++++++++++++-----
 reachable.c            |  2 +-
 revision.c             |  8 ++++----
 5 files changed, 44 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ce8d6ee21..e86b8f387a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1529,9 +1529,9 @@ static int want_cruft_object_mtime(struct repository *r,
 				   const struct object_id *oid,
 				   unsigned flags, uint32_t mtime)
 {
-	struct packed_git **cache;
+	struct packed_git **cache = packfile_store_get_kept_pack_cache(r->objects->packfiles, flags);
 
-	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
+	for (; *cache; cache++) {
 		struct packed_git *p = *cache;
 		off_t ofs;
 		uint32_t candidate_mtime;
@@ -1624,9 +1624,9 @@ static int want_found_object(const struct object_id *oid, int exclude,
 		 */
 		unsigned flags = 0;
 		if (ignore_packed_keep_on_disk)
-			flags |= ON_DISK_KEEP_PACKS;
+			flags |= KEPT_PACK_ON_DISK;
 		if (ignore_packed_keep_in_core)
-			flags |= IN_CORE_KEEP_PACKS;
+			flags |= KEPT_PACK_IN_CORE;
 
 		/*
 		 * If the object is in a pack that we want to ignore, *and* we
@@ -3931,7 +3931,7 @@ static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpacked)
 	 * an optimization during delta selection.
 	 */
 	revs.no_kept_objects = 1;
-	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+	revs.keep_pack_cache_flags |= KEPT_PACK_IN_CORE;
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
 	revs.tag_objects = 1;
@@ -4030,7 +4030,7 @@ static void show_cruft_commit(struct commit *commit, void *data)
 
 static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
 {
-	return !has_object_kept_pack(to_pack.repo, &obj->oid, IN_CORE_KEEP_PACKS);
+	return !has_object_kept_pack(to_pack.repo, &obj->oid, KEPT_PACK_IN_CORE);
 }
 
 static int cruft_include_check(struct commit *commit, void *data)
diff --git a/packfile.c b/packfile.c
index ab86afa01d..191344eb1c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2164,25 +2164,26 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	return 0;
 }
 
-static void maybe_invalidate_kept_pack_cache(struct repository *r,
+static void maybe_invalidate_kept_pack_cache(struct packfile_store *store,
 					     unsigned flags)
 {
-	if (!r->objects->packfiles->kept_cache.packs)
+	if (!store->kept_cache.packs)
 		return;
-	if (r->objects->packfiles->kept_cache.flags == flags)
+	if (store->kept_cache.flags == flags)
 		return;
-	FREE_AND_NULL(r->objects->packfiles->kept_cache.packs);
-	r->objects->packfiles->kept_cache.flags = 0;
+	FREE_AND_NULL(store->kept_cache.packs);
+	store->kept_cache.flags = 0;
 }
 
-struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
+struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
+						       unsigned flags)
 {
-	maybe_invalidate_kept_pack_cache(r, flags);
+	maybe_invalidate_kept_pack_cache(store, flags);
 
-	if (!r->objects->packfiles->kept_cache.packs) {
+	if (!store->kept_cache.packs) {
 		struct packed_git **packs = NULL;
+		struct packfile_list_entry *e;
 		size_t nr = 0, alloc = 0;
-		struct packed_git *p;
 
 		/*
 		 * We want "all" packs here, because we need to cover ones that
@@ -2192,9 +2193,11 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		 * covers, one kept and one not kept, but the midx returns only
 		 * the non-kept version.
 		 */
-		repo_for_each_pack(r, p) {
-			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
-			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
+		for (e = packfile_store_get_packs(store); e; e = e->next) {
+			struct packed_git *p = e->pack;
+
+			if ((p->pack_keep && (flags & KEPT_PACK_ON_DISK)) ||
+			    (p->pack_keep_in_core && (flags & KEPT_PACK_IN_CORE))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
 				packs[nr++] = p;
 			}
@@ -2202,11 +2205,11 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		ALLOC_GROW(packs, nr + 1, alloc);
 		packs[nr] = NULL;
 
-		r->objects->packfiles->kept_cache.packs = packs;
-		r->objects->packfiles->kept_cache.flags = flags;
+		store->kept_cache.packs = packs;
+		store->kept_cache.flags = flags;
 	}
 
-	return r->objects->packfiles->kept_cache.packs;
+	return store->kept_cache.packs;
 }
 
 int find_kept_pack_entry(struct repository *r,
@@ -2214,9 +2217,9 @@ int find_kept_pack_entry(struct repository *r,
 			 unsigned flags,
 			 struct pack_entry *e)
 {
-	struct packed_git **cache;
+	struct packed_git **cache = packfile_store_get_kept_pack_cache(r->objects->packfiles, flags);
 
-	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
+	for (; *cache; cache++) {
 		struct packed_git *p = *cache;
 		if (fill_pack_entry(oid, e, p))
 			return 1;
diff --git a/packfile.h b/packfile.h
index 33cc1c1654..701a3b4946 100644
--- a/packfile.h
+++ b/packfile.h
@@ -210,6 +210,19 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 int packfile_store_freshen_object(struct packfile_store *store,
 				  const struct object_id *oid);
 
+enum kept_pack_type {
+	KEPT_PACK_ON_DISK = (1 << 0),
+	KEPT_PACK_IN_CORE = (1 << 1),
+};
+
+/*
+ * Retrieve the cache of kept packs from the given packfile store. Accepts a
+ * combination of `kept_pack_type` flags. The cache is computed on demand and
+ * will be recomputed whenever the flags change.
+ */
+struct packed_git **packfile_store_get_kept_pack_cache(struct packfile_store *store,
+						       unsigned flags);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
@@ -385,9 +398,6 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
 const struct packed_git *has_packed_and_bad(struct repository *, const struct object_id *);
 
-#define ON_DISK_KEEP_PACKS 1
-#define IN_CORE_KEEP_PACKS 2
-
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
@@ -398,8 +408,6 @@ int has_object_pack(struct repository *r, const struct object_id *oid);
 int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 			 unsigned flags);
 
-struct packed_git **kept_pack_cache(struct repository *r, unsigned flags);
-
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
diff --git a/reachable.c b/reachable.c
index b753c39553..4b532039d5 100644
--- a/reachable.c
+++ b/reachable.c
@@ -242,7 +242,7 @@ static int want_recent_object(struct recent_data *data,
 			      const struct object_id *oid)
 {
 	if (data->ignore_in_core_kept_packs &&
-	    has_object_kept_pack(data->revs->repo, oid, IN_CORE_KEEP_PACKS))
+	    has_object_kept_pack(data->revs->repo, oid, KEPT_PACK_IN_CORE))
 		return 0;
 	return 1;
 }
diff --git a/revision.c b/revision.c
index 5f0850ae5c..64d223a7c6 100644
--- a/revision.c
+++ b/revision.c
@@ -2541,14 +2541,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		die(_("--unpacked=<packfile> no longer supported"));
 	} else if (!strcmp(arg, "--no-kept-objects")) {
 		revs->no_kept_objects = 1;
-		revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
-		revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+		revs->keep_pack_cache_flags |= KEPT_PACK_IN_CORE;
+		revs->keep_pack_cache_flags |= KEPT_PACK_ON_DISK;
 	} else if (skip_prefix(arg, "--no-kept-objects=", &optarg)) {
 		revs->no_kept_objects = 1;
 		if (!strcmp(optarg, "in-core"))
-			revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+			revs->keep_pack_cache_flags |= KEPT_PACK_IN_CORE;
 		if (!strcmp(optarg, "on-disk"))
-			revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+			revs->keep_pack_cache_flags |= KEPT_PACK_ON_DISK;
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;

-- 
2.52.0.351.gbe84eed79e.dirty

