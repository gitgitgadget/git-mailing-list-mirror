Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175402DEA7B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761962; cv=none; b=aMhusjj88skU7cLbmN/BLZkTA1/PDVW3haTiws5urHtqxzqo+2evxoVAUEgcam/MLOWbMda9lphb90vJ+ZFNOgReO6I9PBb0MwzHmeEk/o9+iKipBItIRDAHFkBVYRTImaDZpNha6+bn2yZFY1L285fBOjWOjxZY7fm5B5aghs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761962; c=relaxed/simple;
	bh=EeDQRkxoND5nskjC0AJUDBV71PjnPZ+M4LH8bUPIar4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGCdevHb+HhLWhoGSWpsB24rZBGnSC5pQ0AJLPdmRyjtzJffAxhOgH09q5zTtNH5oV6OP5vU/lq/UsXColpUHSYDZVwnXocKTyTh34a12ZLFyq9dOd/sp/Cg+eXAVE/eb95qxuhq9e9mVjeOam4mg/pG5rRU30AZV7N2vtYZRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KOR1zVS5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvFrUH+o; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KOR1zVS5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvFrUH+o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29AEB14000B6;
	Thu, 21 Aug 2025 03:39:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 03:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761960;
	 x=1755848360; bh=IOFYLLcKP1RlUZQqUakhb3UZaHxZ7nlmsEtTBf5k3L8=; b=
	KOR1zVS5H+mN0J5rbl37LGfB16DYR/83HxCa9iinSbcHwqp9cKAeljnQgHN+Gbu7
	1SgSWbSp97CJePqR24DqbKgjeQw4pXoZWTNR8sdryq2p6JbSc7rxF7ctUW0Er7ec
	kBvb6hjnh5NnZQt+lOXoIQYxntcFwELbmAPTi04pKg2yk4rw9J8HuhHQGcx78iyh
	IYuUhK2nDx/+te9ldXTbrfY+om7wOJNF2uPHLwPFbbQ5sJ2K9vQU093wSFijSalL
	SwJ+n/4B6nDXM6NQpmU0+EVKUAUXcURhltEdHGzZ6X2SXjTEnHaRvstjk/SLLMwu
	aY9zyC3NQenzLILceVwOKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761960; x=
	1755848360; bh=IOFYLLcKP1RlUZQqUakhb3UZaHxZ7nlmsEtTBf5k3L8=; b=X
	vFrUH+oh4F6m6i2Jh+jnw1qDYLw3fZlQZU18A5Y5GvX28opacb7wqQL7Ll4hU0zv
	XipOQCSCy7Yuq7d2mjpk+sQyP+I0tnrC8K2qykKtHWtBPNXmdk91pm/7Qg2Qld+m
	zaCg1gb1oSheSer3K+6/f/4F0r/lnWlXzkgB/sKRxondmzA3tD9n2FYWXTTXiEd/
	/PQiFlIm6BM1jyLYoIS4XwH5Zp5r2HTVYfvRvcHgJsy7MZH19fn3KaL/QWeFbVaR
	If3C7obdXQMWwI8bzTKh5gFtBtKhzTcJLmM/USjw3CYAk3xL3VUUh6WGLg84OwYq
	oFH9gIcUdmNTp8HUHn1Fg==
X-ME-Sender: <xms:KM2maC7xYZaRLR79p5oc2QeW4A84V_7oDMJhWW7DJu9H--DQx2xiDg>
    <xme:KM2maPIMSXXXyrE06q-4XXLX1qOkxCZ5uSAYZzoFdX49AUCjnyTIREIk11kuiDaNQ
    2Sc22bdPKyxmUb57A>
X-ME-Received: <xmr:KM2maK5ynkV-H9SwoGE2Qt8MWRQVIo7nTYE4cDARViXu1htOZnbbwc1HHrThQ-jbFL0pvSzq5XtOJj0LBanKjos4QkKJfKC8YKVyjsekIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:KM2maKyjSAZzLmRrwbKYx6IjER3hBx6lDP-FsELvV9ve3FME90Tswg>
    <xmx:KM2maGa5GwUVxwCs81aqA7IUjTuVE-h22-S0xbaUSFoMjSL1xHfkJw>
    <xmx:KM2maESeOuHVK3ScqSJzgAX7EpDO5jAr6iqI-iVu1uSmk6tWPONhxQ>
    <xmx:KM2maIw7BdJBmXlceUJZMgvgXQpRJ_xB2UcOeqO_naAIZ8jEOmIm4Q>
    <xmx:KM2maEzOu-UtF9S2N-7EC73NV0joY5F9MR1zkVR-qaNlkh4c9gL2hi9o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 290c2584 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:02 +0200
Subject: [PATCH v2 04/16] odb: move packfile map into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-4-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The object database tracks a map of packfiles by their respective paths,
which is used to figure out whether a given packfile has already been
loaded.With the introduction of the `struct packfile_store` we have a
better place to host this list though.

Move the map accordingly. `pack_map_entry_cmp()` isn't used anywhere but
in "packfile.c" anymore after this change, so we convert it to a static
function, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  2 +-
 odb.c      |  2 --
 odb.h      |  6 ------
 packfile.c | 20 ++++++++++++++++++--
 packfile.h | 20 ++++++--------------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/midx.c b/midx.c
index 7d407682e6..7f3f74ef2b 100644
--- a/midx.c
+++ b/midx.c
@@ -471,7 +471,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	strbuf_addbuf(&key, &pack_name);
 	strbuf_strip_suffix(&key, ".idx");
 	strbuf_addstr(&key, ".pack");
-	p = hashmap_get_entry_from_hash(&r->objects->pack_map,
+	p = hashmap_get_entry_from_hash(&r->objects->packfiles->map,
 					strhash(key.buf), key.buf,
 					struct packed_git, packmap_ent);
 	if (!p) {
diff --git a/odb.c b/odb.c
index 17a9135cbd..568c820ef8 100644
--- a/odb.c
+++ b/odb.c
@@ -998,7 +998,6 @@ struct object_database *odb_new(struct repository *repo)
 	o->repo = repo;
 	o->packfiles = packfile_store_new(o);
 	INIT_LIST_HEAD(&o->packed_git_mru);
-	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 	return o;
@@ -1040,6 +1039,5 @@ void odb_clear(struct object_database *o)
 	close_object_store(o);
 	packfile_store_free(o->packfiles);
 
-	hashmap_clear(&o->pack_map);
 	string_list_clear(&o->submodule_source_paths, 0);
 }
diff --git a/odb.h b/odb.h
index 98e038fa73..fb37c6ebce 100644
--- a/odb.h
+++ b/odb.h
@@ -147,12 +147,6 @@ struct object_database {
 	struct cached_object_entry *cached_objects;
 	size_t cached_object_nr, cached_object_alloc;
 
-	/*
-	 * A map of packfiles to packed_git structs for tracking which
-	 * packs have been loaded already.
-	 */
-	struct hashmap pack_map;
-
 	/*
 	 * A fast, rough count of the number of objects in the repository.
 	 * These two fields are not meant for direct access. Use
diff --git a/packfile.c b/packfile.c
index 17f770e0e0..752a0cee8d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -788,7 +788,7 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
 	r->objects->packfiles->packs = pack;
 
 	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
-	hashmap_add(&r->objects->pack_map, &pack->packmap_ent);
+	hashmap_add(&r->objects->packfiles->map, &pack->packmap_ent);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -901,7 +901,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		hashmap_entry_init(&hent, hash);
 
 		/* Don't reopen a pack we already have. */
-		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
+		if (!hashmap_get(&data->r->objects->packfiles->map, &hent, pack_name)) {
 			p = add_packed_git(data->r, full_name, full_name_len, data->local);
 			if (p)
 				install_packed_git(data->r, p);
@@ -2329,11 +2329,26 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
+static int pack_map_entry_cmp(const void *cmp_data UNUSED,
+			      const struct hashmap_entry *entry,
+			      const struct hashmap_entry *entry2,
+			      const void *keydata)
+{
+	const char *key = keydata;
+	const struct packed_git *pg1, *pg2;
+
+	pg1 = container_of(entry, const struct packed_git, packmap_ent);
+	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
+
+	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
+}
+
 struct packfile_store *packfile_store_new(struct object_database *odb)
 {
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
 	store->odb = odb;
+	hashmap_init(&store->map, pack_map_entry_cmp, NULL, 0);
 	return store;
 }
 
@@ -2346,6 +2361,7 @@ void packfile_store_free(struct packfile_store *store)
 		free(p);
 	}
 
+	hashmap_clear(&store->map);
 	free(store);
 }
 
diff --git a/packfile.h b/packfile.h
index cf81091175..9bbef51164 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,12 @@ struct packfile_store {
 	 */
 	struct packed_git *packs;
 
+	/*
+	 * A map of packfile names to packed_git structs for tracking which
+	 * packs have been loaded already.
+	 */
+	struct hashmap map;
+
 	/*
 	 * Whether packfiles have already been populated with this store's
 	 * packs.
@@ -89,20 +95,6 @@ void packfile_store_free(struct packfile_store *store);
  */
 void packfile_store_close(struct packfile_store *store);
 
-static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
-				     const struct hashmap_entry *entry,
-				     const struct hashmap_entry *entry2,
-				     const void *keydata)
-{
-	const char *key = keydata;
-	const struct packed_git *pg1, *pg2;
-
-	pg1 = container_of(entry, const struct packed_git, packmap_ent);
-	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
-
-	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
-}
-
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;

-- 
2.51.0.261.g7ce5a0a67e.dirty

