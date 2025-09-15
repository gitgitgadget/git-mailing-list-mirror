Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C682F363D
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926483; cv=none; b=Mny4Xvm2BK2AKyQOP7lFMnf1/hGOtK0g9DRhC2Fikitrly7E4YeN0acWK4jbuH2NHHynqWQuZTibw12HjVG1Uew6bFX67x7E1+kd6nBHFrqIG/lx3MitEDw0rB273nQeg+VPIHF0XLXFiKbQdjAKGZDiMcU52Q3amE329NBoUkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926483; c=relaxed/simple;
	bh=dsmlJ/XoieBZugft8ILCIVqLfrqkIFuHfmSaoIjJZc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbCfBC9MR9IXZm66cKHi0BPKD04avCx/4ZpbOrPvCgSvPPSOnD2UbOCFKNRWQSfM8tkPIqiI5C+zT355qigPLUVcZKHz+DbRsfvZVGfUetclkOf6vzU6S76aQ24oylTPHu8NLBMpos5dlOnZmgkQiToVaX/K4xiZn1YFiiAIaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KH1j9+EM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hrH0boky; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KH1j9+EM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hrH0boky"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE83D140019C;
	Mon, 15 Sep 2025 04:54:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 04:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926480;
	 x=1758012880; bh=v6coCY0rzW3ywddeBj8NmGexjVEswkh03rh1MD6THRo=; b=
	KH1j9+EM3gogGkVqYCv2KLVI1EuyXbB1dgR+P+jy4TDD+VkHFjEVREt3gwMJty+p
	DDWO1VO/CUA+HQtzJAgd7B27lqM4ocoimb9c+iQkWCGBCMTyGvsF9HrL//V/MGd7
	vVKUc0cEibcMP3WVVPBxsAp2gZj8GqwFX7EZCskEW0LmEzhSu3BoL+T27YF1+b7O
	SSa+yHecKv62kg76lxBAjCApSY6e/LimXM02l+de7ZDQlBzd81mLp3H4p5Os1SHO
	XlCH9sDSgWBRlqsd8KLIs2XdSmUAkkp8Ci64nrSFdJLy+JgTMBj+49pzhsklDkCP
	52br7tohJaXNsXL0tNRB7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926480; x=
	1758012880; bh=v6coCY0rzW3ywddeBj8NmGexjVEswkh03rh1MD6THRo=; b=h
	rH0boky4lEsduDea26UIE14u6N0y9zbfeX2/LxZJk1SVFvP54t81FoYQW2PH0wEX
	MG9ffNkMjVRjWqdiFPg0LolMljupBEJ1FRgxoi4FOY2qsp/dNo6GonUwBZTPaOwL
	Zdyfv16Bj3APDyivH2tkvbJ16U354OOy0w3RnEx/1mj6Vx6Cs3Iubvm6KJ0/9GpA
	405SvLID8DytSEbHMbBHExvQ5c2U1QD7OxUFTcOnxDDlBuGfUPA311S4n5DUtqnz
	MDdPQIenrp5wAbfMz+1/S62rsmJF6K4kPcycDY9ZwJJrmj/M1LBIJIbmPB/yRplS
	AsQQUgpu446IH0KgdmlnQ==
X-ME-Sender: <xms:UNTHaPD7dCBMc2tb9Hbc1nS9Y9JupOHhWWC7bAa0TxnZsVwkUrT9-Q>
    <xme:UNTHaBB4e_BVlsxoVhy8jgftPCkmY9c36Q06aJiEb7RT-BKEMsulIdNu_zU1sTF0V
    1vlztEqC2Wj27XzAg>
X-ME-Received: <xmr:UNTHaBCp0WYoIi08-LpFAtVTL1d2CaG8WsTHzR0sj8qrw_gMTqCmif6z-djcIAI6U1Z6-RVz5x_iun8r2bX3UrE0vkf44Rkh3t98R-iiKIT3RQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UNTHaMoY_xTmOZATBe6kCIciqScxj_GpV3Wf-iW7ynShWQjn7pILeg>
    <xmx:UNTHaLljFyv7PFw-g9FWXKbtdviGASWUN8RPfAyLJvwbCr7p4YGWoQ>
    <xmx:UNTHaMzzUg-kiQdRo9CTn2flK6BHwfemPg7hZnFQ82hADk7vGE86Sw>
    <xmx:UNTHaD9X3Kww8m0AWl5RbZ5qn3JE402KrvdtUi14xecYwumLPvFbag>
    <xmx:UNTHaP2OBMWFcNvECUaKlh-K8q1NTtEFAhMWc3i8sPciSN0Kf86iAbfP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26202215 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:22 +0200
Subject: [PATCH v5 04/15] odb: move packfile map into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-4-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
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
2.51.0.450.g87641ccf93.dirty

