Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFF311950
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591590; cv=none; b=U3wac87NzyLwb09GsQnD0NoVD7ORp4gheWGlmgXXDy9fWE4aMgILlX4In3QR6n5p2SrYcwj44k9xq90z7u1aA/zqKWNrYUkwqDjbqBEJOk5VdnTQGxapIuGLYqK2+VRwfMffAKe6V/1jF6ibC0ztQEkgCS9E1phy7aazqQ1v5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591590; c=relaxed/simple;
	bh=WuCIU6g4evDAq1dgviM5rjpSwlDRe2EFIPqbdc9Wqqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWGrcho+0pKGDh76gPu9a5Xuwy39wYg/1LGa9CmFZqHPFUBk41NbvzKoBbOAD2WjvNPuoKwaBdAle7O4qXJfetd7tSkFsLPRPpQC152c5cxUUxF/itl743cO8AbRiIrrDjuW3Jrf0ynEPN6lRjGb5jWsI2kPuLs+x1/hWHG5N0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQz6mN5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vs2HgCB+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQz6mN5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vs2HgCB+"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 7CED91D00267
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 04:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591587;
	 x=1755677987; bh=A4+WUXTYTaDppY0RRVFOz+qOTAHBYIK6kl/KVkWMrog=; b=
	EQz6mN5bEHwD0/4RitllVv0Xzs/pWVYazRtJL3uwQWRtZdQQYofgQQmSAzKONyPv
	oFNSQRw/r1+IxdNcQX0TdTGEY2WlVDBVrUb4c3qPzueyfOPYstckFUblbojAhvck
	2uA1J35AazcHnC8C94Q9+pkatemQA8QKHUva/tv01HUIn9Tio3ozosu/sQRfDhF9
	Z5RwlKqg3kAAqCj0EyKK9DCf8SQ0nQH5gUmnOFGy7eDkTAUmi9EMrliGiHx7Zghn
	HmfebNkdy3+sDrT2kXqn6WykPW78zd4Y5KYR+T771qrjWvhdm2anSsuX5UpS8mff
	GsRW+nBWUtR5JnVZJv2KPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591587; x=
	1755677987; bh=A4+WUXTYTaDppY0RRVFOz+qOTAHBYIK6kl/KVkWMrog=; b=V
	s2HgCB+/WdHvkFBJkfoyRsjVKNWTlOWkuL7HGTsDNrYFXyqUNeVLdgcEzGcIr6et
	0XIWysWHwP5MnP9IkvRjORK/xtgLkm8KIK9+eElOeZihtYHDwOv5Jm5udITw6n2y
	+k6dda5cMBW6JAA+TeTQbJUEGK51BbQWFENkwDt+6ynzxisVN7h/bZqhN3spWpzf
	zYNbGqMIrAok04+dgAkRgJn5NkEM93aivplanuGILVDyw2UTjpdXBikLYpFi4FVw
	2HB7cdg03NQn3Iy8SfF1bZznaBBTZmHhAtL5KrQH9zLdIoPi6S8LL2vk/DGlre+I
	QH4QOyQhfedkrclqAfw+Q==
X-ME-Sender: <xms:ozOkaDJUJn6y7IDcIAL76ikaT4sMaRPtPkTXKH1HiLwZ74qZDd-jyg>
    <xme:ozOkaJIwMZxzwqZl5YREHgrrmaZAivH5Q7cj6otNctqx28LE0eEnhpPNqdGktS4gG
    YRKc8f5hJt8sxw27w>
X-ME-Received: <xmr:ozOkaFFbon0yL-flWFKUn9bFWuuD9refQWZtzW8iKO__oXOxNXp6TT3xZGKdiZ4WLJa1uWfiDy2StAT7tgkkU-JUlzbe_x-yxhvwe9quHeLx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ozOkaOmc_Gnd4kLS-0QFpGBDRF8tJ_HhCstinc5Fqac151VLJogpxw>
    <xmx:ozOkaCIS_4sw8dczXiLocDnK9pk1J2PyDd3n764kmp6DiLM6FXUGJw>
    <xmx:ozOkaPZNPAgT-3qgkd20lfYO7DtdwNGeVfy5lgBMIvBoJvqIIXmAOg>
    <xmx:ozOkaEbVE7sPZ4LigAM_h-DLIGCZza7FQApvTHUXSyX5doPHv4czUg>
    <xmx:ozOkaBjOHC5g9-xGTwQDfpGUgCdz4PjGruKUbaHAlL6R2we8H212hyuq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:19:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e9d8c2d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:19:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:33 +0200
Subject: [PATCH 04/16] odb: move packfile map into `struct packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-4-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 970919403d..99c1ba7b77 100644
--- a/odb.h
+++ b/odb.h
@@ -148,12 +148,6 @@ struct object_database {
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
index 4e5f84eb09..6582b0a479 100644
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
index 573564b19e..2f84d7d7e6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -65,6 +65,12 @@ struct packfile_store {
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
@@ -90,20 +96,6 @@ void packfile_store_free(struct packfile_store *store);
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

