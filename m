Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6BD2F0C67
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649727; cv=none; b=l/4ymgakUcx9UmNgb6qAkjXHCoTa68aJwJZOzMkjGYjbT/kzG9Zx7xSTji1JJZ6eiFyJdQvdxSNyia8iEJ88sAwUB6DORbqJcF4FIOHMCIXV5RQ6yo11Nezi3MiHhAiXghbCX3zKhi7lxJEA+WLvzQdxZVbBoCflvOPopoS2QFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649727; c=relaxed/simple;
	bh=xT4T2gbB7bP8OncISphtiFZ/HsyPQyb7tK6h1AcZvtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnrkGXPxqsjfkb1iTzCJJx8hQE5WIGmCTLz+1ksu4FyPH3YtEXo9uKVKT3Bbl4poejJJ1HlbpTlpxWhkb6VW8ECEbKd/Di1KnVr8iwXGTydhuEr1bCYWkJPz7LmWwMmpwTXNaoweu+ZQY/UXBnSgv9G7ELnSvFE5qPdP+E0vxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EHXCtOul; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARmmVW40; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EHXCtOul";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARmmVW40"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E597140034D;
	Tue, 28 Oct 2025 07:08:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 07:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761649723;
	 x=1761736123; bh=c9Z/ODrIpzvlHZi+RBDndmKDwnhq54VJzhMqHq+a7JM=; b=
	EHXCtOulsavxSFuxQubLwFWVBgrlzGm6xap+4bw3BTC9d/CK6uRQGP0Gu0fus863
	SQtQHcL9xXHN+Ohlc3LMLGOkHhKPd6GlQrc7cv3VC8M2Uv6NXm7KW8lGwaK1Y4OQ
	MKS9YP7NUhaQwMrWcUwBEo7f5gWa8z2uJMxYxrPMJfAaTjN9+g+6OJLJYj+RJvA2
	bZWxWRwQbzlFEOpIpzi9wJskqD0tCUsDlpixyYQcvor1bCpzPwp2ECFyam6LFvqg
	IhNgIu7ZWZqRUssY3Y2bF0KHxMS3j60y3lSGbYh6xWvRpQprKTWOjtzMPE2RMAwG
	jbPsngj6K4nCOYeudUiFTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761649723; x=
	1761736123; bh=c9Z/ODrIpzvlHZi+RBDndmKDwnhq54VJzhMqHq+a7JM=; b=A
	RmmVW40nWkv9MW6ix64qAjmNIOjZjYiMMP7u4/AkBvlifIlpzvsJXPZQk2crV1qr
	FUsX5J+bSeJ6+xIQAJOTbLPhgHRTq4Ze7GyHzWyWbo8a8P2CxgziPa4jTQRXDzwK
	G1184/EPNPZvFCONtNOg7AU9Yp25/LN8xmSxMu9HYwbmof5cEui8kESP0AS9MH/X
	gTgjg/UoIJLZUhZVSwMa7iee4kfvLnZxjkDyDZd5ZN/jwMpFUGy7YWcCa9in6GSJ
	7u5Uc5kgLzE1pT2cGkAWjb2923caUc8ECzNnHMHKiq8miy/oswikXVbngI19lZA2
	db6Pk6n8wp3Mr5zc1ojQA==
X-ME-Sender: <xms:O6QAad5k357z6y9vA9vvJ7ntjJYCIzvakCbnqn71s2ohytWG1z5cIA>
    <xme:O6QAaSVeN4xR5kJl4GXDWkakWthJZpU0bl03C-zveRsd4wZibolsqfLS9mfofZpHf
    L4PEkwa9qqQRqHJ1gAtTHFG0EATBgE8_wa5663QcY2golL2C2cn5Q>
X-ME-Received: <xmr:O6QAaR1cwoZgcQM3C4r5C_72HAWnr-ePgGb_j5VHHoQ0Pkv94JYhSVa-le-da7a8BAJbcouWKEpnHZnBWf3kVpt81dy92iGGnzNJo3cN9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:O6QAaf3JCflpk_Du26h6oUWnJ-OKal8J5XsQaz3xIEEy3QIinOP1Lg>
    <xmx:O6QAaU_KQdrP7CC_COYMW2iRzO3t8ESw_NPHl8s5ShqEJfC4EdEtpw>
    <xmx:O6QAac2eKxfAO1QewjcrJ_0h6G0OMaj24AFDCXZopyp9T_X5TftJhw>
    <xmx:O6QAaR_VDafnie9a8PKPjnIxK0ds9hvObRSQaCx3rT0sbXfnlox1OA>
    <xmx:O6QAaVPo2BSQ5uYBvBoXj5tL6CC6EbIG7mCQOjcBbSppj0-p6Cbh2bz3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 07:08:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3841a50e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 11:08:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Oct 2025 12:08:31 +0100
Subject: [PATCH 1/8] packfile: use a `strmap` to store packs by name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pks-packfiles-store-drop-list-v1-1-1a3b82030a7a@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
In-Reply-To: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

To allow fast lookups of a packfile by name we use a hashmap that has
the packfile name as key and the pack itself as value. But while this is
the perfect use case for a `strmap`, we instead use `struct hashmap` and
store the hashmap entry in the packfile itself.

Simplify the code by using a `strmap` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 24 ++++--------------------
 packfile.h |  4 ++--
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1ae2b2fe1ed..04649e52920 100644
--- a/packfile.c
+++ b/packfile.c
@@ -788,8 +788,7 @@ void packfile_store_add_pack(struct packfile_store *store,
 	pack->next = store->packs;
 	store->packs = pack;
 
-	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
-	hashmap_add(&store->map, &pack->packmap_ent);
+	strmap_put(&store->packs_by_path, pack->pack_name, pack);
 }
 
 struct packed_git *packfile_store_load_pack(struct packfile_store *store,
@@ -806,8 +805,7 @@ struct packed_git *packfile_store_load_pack(struct packfile_store *store,
 	strbuf_strip_suffix(&key, ".idx");
 	strbuf_addstr(&key, ".pack");
 
-	p = hashmap_get_entry_from_hash(&store->map, strhash(key.buf), key.buf,
-					struct packed_git, packmap_ent);
+	p = strmap_get(&store->packs_by_path, key.buf);
 	if (!p) {
 		p = add_packed_git(store->odb->repo, idx_path,
 				   strlen(idx_path), local);
@@ -2311,27 +2309,13 @@ int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 	return 0;
 }
 
-static int pack_map_entry_cmp(const void *cmp_data UNUSED,
-			      const struct hashmap_entry *entry,
-			      const struct hashmap_entry *entry2,
-			      const void *keydata)
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
 struct packfile_store *packfile_store_new(struct object_database *odb)
 {
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
 	store->odb = odb;
 	INIT_LIST_HEAD(&store->mru);
-	hashmap_init(&store->map, pack_map_entry_cmp, NULL, 0);
+	strmap_init(&store->packs_by_path);
 	return store;
 }
 
@@ -2341,7 +2325,7 @@ void packfile_store_free(struct packfile_store *store)
 		next = p->next;
 		free(p);
 	}
-	hashmap_clear(&store->map);
+	strmap_clear(&store->packs_by_path, 0);
 	free(store);
 }
 
diff --git a/packfile.h b/packfile.h
index c9d0b93446b..9da7f14317b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -5,12 +5,12 @@
 #include "object.h"
 #include "odb.h"
 #include "oidset.h"
+#include "strmap.h"
 
 /* in odb.h */
 struct object_info;
 
 struct packed_git {
-	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
 	struct list_head mru;
 	struct pack_window *windows;
@@ -85,7 +85,7 @@ struct packfile_store {
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.
 	 */
-	struct hashmap map;
+	struct strmap packs_by_path;
 
 	/*
 	 * Whether packfiles have already been populated with this store's

-- 
2.51.2.997.g839fc31de9.dirty

