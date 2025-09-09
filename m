Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46462311C13
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415800; cv=none; b=iHAzwsz++FgDdNaDc8jU7W9RRsCdfm/LeRB+GRKMc/U0E8u5+PK6Wg4AhvlBfnPbSjgxzemrZlUwOGMpUWRFvfqqcIX0qDkl87iEnkKQ87tMF9ZS71jLfzVSTgwsy/MfoYGLOEsynuwH4HMU0wMqhd4QGPJ7QgJ5DVXc0Y9juao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415800; c=relaxed/simple;
	bh=SgiChzJhWTcTrgJf2bZ7ISeZZlESr06AEmBmDEKGdog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg0bZk/yCkQ+CBxbUYwJNYnkY6i99YN7Zd2s7TpOggJ8qZmO0mKMoHkY650pMUG+h3QdTrb1AScLb5uyT858uaNBRsCTXKgqtTAZvQy9XbMw0TGGpJWNUAcjIWiI8gqNlye5lBpmPz3VSaAVa/aiTXzNh6a4p8n/AN/jpaWZK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CgxkGDve; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JiLu2v7y; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CgxkGDve";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiLu2v7y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6780314000D1;
	Tue,  9 Sep 2025 07:03:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Sep 2025 07:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415798;
	 x=1757502198; bh=+lLBOqk103I5/mBRc1o40x6p8eO6kEsY3Xb0RausAnk=; b=
	CgxkGDveu6UHCMGhgiZF7es2YpEMkvEVgAk0erPWSpkUdrzcYtx8RoBLaU6FtmSD
	IDjkc8jMCmoz8Ck2qDb6dqtdoiUaSIVuR6tRMoK1ZGcSuTvgBFXhQf9nlBNeihIE
	UfuEmYr4jpFm7rGIN2VHEtmILxIDt/oDKesWj8N9dvt0WOd510ZPhZ2TLar/y8Sm
	Bka1hrF0iccc5ChrokoxiGVbZLLfSc3CvXjJ3ZKfDSs+muDS4oVBCMw1NjLIozQH
	N63A+sbKOUgm4uwuiah4VDZTcewWQvynPc36gT7RoIY7YwBfWutdZdnlOBg7/kLK
	VWba04t4YWKaHxe13d8FfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415798; x=
	1757502198; bh=+lLBOqk103I5/mBRc1o40x6p8eO6kEsY3Xb0RausAnk=; b=J
	iLu2v7yT9HD4iQKcowT3pFT+OIuZatbi96wmINiVF+wehERTI/yxjXuss/xfElSF
	UAFJYkb+kvIp9l+NX8y4ZAF6BOlg6QDP8D96PJchRB3x9YKA3yjDqzGZN9UfQf3d
	15ICDFQWxQDOjRjWGOiFBN7rMia+lofRt9gEf88mXM+Ah2Ql2PXfwLHgrwY5msce
	HuLPameS0bDAuFy3W3ytMafd9UbZFdot7mu9LQDnKiwlTdv9KGH46MSpyI2ktwGk
	1CP9aAta6sTSjVW8uLu+4y/S+otDJn6O/0KgNLVB2FS4IR33aPfC1kCGT8+gQDWn
	Lg/TLkh15Wb2K9LEj2gFw==
X-ME-Sender: <xms:dgnAaOEP0ziCtJHIqSjrOmonbkrZ3qtXHNkhzEGu0QO5lYJxdqwv-g>
    <xme:dgnAaK17oDbbNqTGGLnHtx5j0pkRrV7nmNf2FJbdJbJiH37jigt4qlrftE3J_KKYZ
    r2vLaetxWBBbnDH6A>
X-ME-Received: <xmr:dgnAaOlAjwBeJe3YAMbKl8w-6Xn6pf4RXHDr0z9U5BbOiBkA5b6IeAMXq8KSgBP2Hejfp61x6jI8GaZ1gZaEoUOLjuoAZJieICO8kQffaDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:dgnAaC-2MQvqaomkwuN4IwCZSQsogEJMaOyKZ_4wHu9__DKTV1ElgQ>
    <xmx:dgnAaLolKSegfzPoYxX42fg3mS-8d2xebkuTcgfjqApkdOYjGcUmUQ>
    <xmx:dgnAaDl0Gw7kGEb7CHgS6GudfNHlkUwVk8nq6UMVaR-IglC-K4O_Wg>
    <xmx:dgnAaKjzGDbNNHwllqu2BOK0J6WT64LkhCF4Vx12zuwox_x6b1km5A>
    <xmx:dgnAaGIGdV4G-fvh_7QpgTBlwIBAJd9F2qrGPeUJUcR2pmRQNNWrzGJ5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d20f7471 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:03 +0200
Subject: [PATCH v4 04/15] odb: move packfile map into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-4-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The object database tracks a map of packfiles by their respective paths,
which is used to figure out whether a given packfile has already been
loaded. With the introduction of the `struct packfile_store` we have a
better place to host this list though.

Move the map accordingly.

`pack_map_entry_cmp()` isn't used anywhere but in "packfile.c" anymore
after this change, so we convert it to a static function, as well. Note
that we also drop the `inline` hint: the function is used as a callback
function exclusively, and callbacks cannot be inlined.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  2 +-
 odb.c      |  2 --
 odb.h      |  6 ------
 packfile.c | 20 ++++++++++++++++++--
 packfile.h | 20 ++++++--------------
 5 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/midx.c b/midx.c
index 7726c13d7e..e96970efbf 100644
--- a/midx.c
+++ b/midx.c
@@ -460,7 +460,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	strbuf_addbuf(&key, &pack_name);
 	strbuf_strip_suffix(&key, ".idx");
 	strbuf_addstr(&key, ".pack");
-	p = hashmap_get_entry_from_hash(&r->objects->pack_map,
+	p = hashmap_get_entry_from_hash(&r->objects->packfiles->map,
 					strhash(key.buf), key.buf,
 					struct packed_git, packmap_ent);
 	if (!p) {
diff --git a/odb.c b/odb.c
index 7201d01406..737d98c911 100644
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
@@ -1041,6 +1040,5 @@ void odb_clear(struct object_database *o)
 	packfile_store_free(o->packfiles);
 	o->packfiles = NULL;
 
-	hashmap_clear(&o->pack_map);
 	string_list_clear(&o->submodule_source_paths, 0);
 }
diff --git a/odb.h b/odb.h
index bf1b4d4677..73a669b993 100644
--- a/odb.h
+++ b/odb.h
@@ -155,12 +155,6 @@ struct object_database {
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
index 711ccd95f1..9006a9ea67 100644
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
@@ -2328,11 +2328,26 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
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
 
@@ -2345,6 +2360,7 @@ void packfile_store_free(struct packfile_store *store)
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
2.51.0.450.g87641ccf93.dirty

