Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E726320CC1
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622644; cv=none; b=rEm1Wb/KZXqC5wC+XZL/SQVYGxYn8M/mIjd82yh66W8Lwj8DWoodQhwYzzLbEMqRQs7dTgetrjfs0UUPtiJZ72cYFFy3EKe9KyZAgNxshMxnNxaI5sydK/z9sZCvaWCS9ESA1z2uklJjUoJLxoERF3ahXvc2q1WzOy8eg3FPjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622644; c=relaxed/simple;
	bh=1n5xLhjsqQr4GAU8c9RUvUCFb3Y7SDXoO8LffeVVtAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8mdDKQ1MX0xymiHU+xRdRkeDCLjvpX6TNHxPOAZ8Mt7TMFc6dqxIZoCVYu7WNthTUfq4xtGIACnWCxkidY3ItNnbJsgsAXwl0L9LbebTaqqC1IgLAIcdQvJmG3oRatYtCUUDxK9SNv7e5Kun4kmvmaWTxR1niUZrUzLZMNQPsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=luMrfqYi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wt3Z/T1F; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="luMrfqYi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wt3Z/T1F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 52E2F1D00100;
	Tue, 23 Sep 2025 06:17:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 23 Sep 2025 06:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622641;
	 x=1758709041; bh=JGT+qlo8t30S6tWEO3K7ONBFzY3GsYI5aw1MvyB2OD4=; b=
	luMrfqYiUzBQ6pH3C8mp8gveJDqeraqsp84ekwChwYJmi9EJ9DVnOuqWzZWrH2kh
	A4n0eJ7lieDBrZuQZgwLbU6MuiPVlEiBxIOVEEzOoZaVYmhQ3VsiVQW+3CpXuc55
	ix/i2zws0yxBZB3w/ZR2eGHebFCqa8BlN7LqmNHxsXtUjYCZkUydv9Axkn6KD7ZL
	7afdReJrUXT9R3Vi0NC4b2YCpzSVacCPjgXcBQfyc2s22gCXGQQAFohimpZ58Pe7
	7L8rNCHKjqi0UazGoMSX4OSHjgyGxBqsu4OJedo1lDram4HqU/8dYCtSSfNTTBBh
	taa/SqiDrVX5XANSy5IyAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622641; x=
	1758709041; bh=JGT+qlo8t30S6tWEO3K7ONBFzY3GsYI5aw1MvyB2OD4=; b=W
	t3Z/T1F+HPrfvFvgNjt8OJoJ+OSnHmxKns+YtkCAKaue7cn+yjr2JKS4Mwmiw2dL
	NCuq20NdmHbfzCADt3+EtG1D8x1ltC9rAxbLRJDkOTQ4PaGvBHW1cVJPAQ9nHChC
	8AXI4NezyZ/xhG+sPLKCYHkCyIkIIyPArI4UiVKcyhFKM54h4oCQJUB7pIBOp+7d
	LubDb4kc+QtoN2vL98uTaIHgcb9YAUFYcRd2FpFPg0HXot+vEFe1tIJ/0ilLKnWw
	w9N83mfuoZ7CIkndPD6iwAJYxMxDJGtOsh258R8X/LDB0qNtnSsbEWEiHPnGzBvH
	WJChvssS0Zlkv1bN0IZaQ==
X-ME-Sender: <xms:sHPSaPFMpCU3i4UoXdrn_k54d42cCk885Hzf3HAH83uwNeeQrdVMJw>
    <xme:sHPSaACKsod9wOBgHpy_tPE6xd_EkSuZR7R1B3N1oyy6PX4HJr1gmWnWqAjlsGHIY
    cHma9N3JttP2rmoJOcDscml50ol0hsqaAUo_LhNqL75jMT-bIc>
X-ME-Received: <xmr:sHPSaK8cxK9kkNlYIH0DTdtoj_w3KuWhUYR5AFDI9FjFENBivBeV9oFbZwoT4hVfjM6To6UjsJF0sWu9JC6vaPOOgHkjziDcNC2x8Jou1t6_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:sXPSaEDghh-ykkEKCTWUeJU7YJeKZFz4ND20x63E4p2IpklbouV1vQ>
    <xmx:sXPSaHTKXDt2bgeg2GdAHCKfQMQaa8-04W7zJyy8yJqEaU6pT6gNmQ>
    <xmx:sXPSaDuKhm7LMBNNWoyF5skoJc4L_HCveZG7tpZvQWN3GlwuOs4ixg>
    <xmx:sXPSaL1T5pVBaR5wtinKcvqePabfGoqgf9xo31wlLtuK-jBQpVivrQ>
    <xmx:sXPSaFi8tCXfGp2q_WZJDumcKDwyDqXUafxq1AVxgQ2b9i_KEULvCIQi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 136aaff9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:03 +0200
Subject: [PATCH v6 04/15] odb: move packfile map into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-4-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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
 odb.h      |  8 +-------
 packfile.c | 20 ++++++++++++++++++--
 packfile.h | 20 ++++++--------------
 5 files changed, 26 insertions(+), 26 deletions(-)

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
index bf1b4d4677..b79e7280c1 100644
--- a/odb.h
+++ b/odb.h
@@ -135,7 +135,7 @@ struct object_database {
 	/*
 	 * private data
 	 *
-	 * should only be accessed directly by packfile.c
+	 * Should only be accessed directly by packfile.c and midx.c.
 	 */
 	struct packfile_store *packfiles;
 	/* A most-recently-used ordered version of the packed_git list. */
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
index f37557eac5..17e0b8ab27 100644
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
 
@@ -2342,6 +2357,7 @@ void packfile_store_free(struct packfile_store *store)
 		next = p->next;
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
2.51.0.536.g15c5d4f767.dirty

