Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CE2F5480
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810138; cv=none; b=cNDi6jIBqcFqzzQ+a8eT+pVXE71PlVw7xbltGuPvHWQik9ALRAG0jD8vvar9clgZFcqh6WV6FbtrPbtNHE3VGMjPJshQ2cT13BhLaJoK0GMP0+SfQgovmrx8B6Qh59wWtyNcndekSnX6zKVYva2b4QJzOhI5idnJ8DKK50UHPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810138; c=relaxed/simple;
	bh=Z4tO0dMgL5fo7R1DPEEJmFgoRSUa4Tl7TchDezslnb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7SceCQ0TkMFJJ0pl5WR4ePB1CCRTQi0X8Mz8Bv3lBUBBlrcMxCfxCLz7BRX5JKh6SvWXKfXkfACFn3gfH8L/Q6JN6KguL0rOc9vmS93d9wFnoX3WJ9ZGRYYCmFcPeX3r18MMOJgldgtYZBtjKTR5fB2sXu3m+o1R6o7osX2REU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kVYsayv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgwPftC5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kVYsayv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgwPftC5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46A8214000EB;
	Tue,  2 Sep 2025 06:48:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 06:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810136;
	 x=1756896536; bh=abbp5hosD9HrgOiXdBNIDVbmVQTsZypiQxmZBOeft14=; b=
	kVYsayv19ePAJnBy2pE6oxnBwqFWzVA+9cHv126rYOVNZSRAVbdhzje9C2vs6HKx
	L0aXZBOVO9fs29bFE4s/w2XdC5C7BDSQePDitPCuH38NI4ngQoVGafvZa9WSvGL+
	DHHWZ+IdxjpEs7AibeaLxJWDZTz5wFQdjf2TD9Y6Y1hHC0B614GDI03NvDGNqTlZ
	/nBn4Qwn3wf0UvgVGrdXm9EqYYjkbb+LDecQKfLv6cGNV1eZN4kPDqTdci7McR2F
	RAaubY5GVjM6e8+mm32KIVALRODcYDmRKetua897+sygXYlcNWZPMRlP8wRkcoPV
	2c4QDqd5ZpXGIkseFyJM3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810136; x=
	1756896536; bh=abbp5hosD9HrgOiXdBNIDVbmVQTsZypiQxmZBOeft14=; b=X
	gwPftC5JrxOyU86DuSroHVZcPQyeAlr1nMhe4KTckvH8OF+L0/JNYHTPGfgcSVpj
	eXtUqrSSsk6Kj2TsAq23T5DkCRxOvqn9AINZt52cR/uQEeLPoWkHo9dwuLMJ4Gdy
	TmG6MUqhQ44oRGrE+OZ1GBVSvVeGSLGMibRauDJStJGmeyyduNITCZlGk1ii5Cou
	/P6YjvswtjCB7iquh9h90ebk9BoHc7100qB31uGeXR3jat2OVHGLe3lWVaiwZWdF
	TDD7ZOjbf5zUO4B1TBptwelDHs7wMpi4GgqkrDLKUh2hP2Hl3He3us3MVM/v6n+I
	EwhrjtFffwQpMRSMnoMZA==
X-ME-Sender: <xms:mMu2aFYNLG-ZmXfvFe3CcGIdwDv7ZYefiLUU2hXeodmMEoOrc3KuYw>
    <xme:mMu2aH6EF2wFwl-KTKI82wMC-I6ZryTX9YCsTza-2SVqOQMPwqJVXmMQlyefU6_RT
    XLXrs-ojwmL8_2lyw>
X-ME-Received: <xmr:mMu2aObH1RSjgvBVydHwrze-MCfpBXjTyYIjCQHpfqerAaq5_8FMVo_3ZrtjQUetmlFpmiSxwbS-hbhL0MfXt0Uo5yOAhJdF-Tsh4cL-fJrGlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:mMu2aOh9vOGiRTMHs4OlVcU4tckzDeh6FstbRCh9Hb8jGHVmLUb10g>
    <xmx:mMu2aH9lPLzfEhmIP30_9wT2iNxbSjjWG6rCLrMPKp6zc38UxNwvhQ>
    <xmx:mMu2aBqZNHKNcP3qQjvRRnSykNIadlNd3CxvdMe3srRJBZplAg0luw>
    <xmx:mMu2aHXNW4l1EIJDYLXkqnrfz8CfNPs7upxyXwr2kdNmBqbAKNsr5A>
    <xmx:mMu2aKUcLheT-TmpoMOA3CyFmraVTXa3BK3lK-G4h-KHtJVbxG47XKWH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:48:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09173db4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:48:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:29 +0200
Subject: [PATCH v3 04/15] odb: move packfile map into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-4-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
index 0cfeb68b6b..60ccdfaafb 100644
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
2.51.0.384.g4c02a37b29.dirty

