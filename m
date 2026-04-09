Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1900379EE8
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719498; cv=none; b=IDeLNazvuHNdk50juPrQ9RnOoMcsr4rdGLAQA58jrlcFbvaFN4uRbkd1zfgXxUUL5UowVfEZ60ho7ociQCS+LzKRV78oARafaO2tOTn/Nvp4KT0ti59LHswiAscueOIUVOuKCFB/OIXAD93Lwbp77rDEz3NEMUwbJ4rc/KEw4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719498; c=relaxed/simple;
	bh=BhRdx+mBgzj/2ipFNCZ0Tufpl0AyW3NxEMQ7XgIRmjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvk58kVVpFartrUtBsqCnGhCF5N9+8TFDlwDL1wjDFo727ydsF/X/e6lebaEEQTKuC81EACJ6UTkl7Li9hKnOU9uh8lpWLRgAEC2RGLl8ElGSe1bYyf61LLyWy2UnWT9PyzPwU+4zFkd5wAw5dDAJt3F3DVNgfyZ15XU6mZ3LBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P2S5kkjn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bTrX8vBf; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P2S5kkjn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bTrX8vBf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 040F0EC0477;
	Thu,  9 Apr 2026 03:24:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 03:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719496;
	 x=1775805896; bh=/X9Ai8aIY+n3wdkn3rwznJgGilVLlKgrtVnSV6RMk+g=; b=
	P2S5kkjn71jBZOhyV6jmAfQNJ900ipCV0GU0l6HiBW4JSp+8nMLFPzboCi7wSbnV
	vtvasUh5j7SrYf9MzPeSEe2mhtetJPFa8/B77jdTz5BtB7nN/MMSHFKHrH+xHW1d
	0BhAIfzjbGSIOWtNN9gqObmw9yFb0yVLOp0dZA3nqGXRFqCt4xk40tzCdI2bQt1I
	9gA+g9hosJ7qKtoTV49Wyp5nKVWvxgVL102YuHwQr0aKCEdUbNogMKXr8ohts/4g
	9TaoIpD57gjQFWmHeDLCPIQTQoru9nqjvXoEQurbIARDfHAV2/O3qtq5XScQujx9
	X4KBUb2+GhGpPoDBXolgog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719496; x=
	1775805896; bh=/X9Ai8aIY+n3wdkn3rwznJgGilVLlKgrtVnSV6RMk+g=; b=b
	TrX8vBfjvzAHnBiSwGbLD7UEU7oM0U+ZN0oEHjSC0cnBw3PCIfMK0IcelZdU7eDF
	DNJptSBGwmib5xxZqQ0obcACBoLDgIA/YfloE+WUg1Hg8qZAxU8k6EejdWXBn0m3
	cnqIdY1kLlsuNhFj+XiC30i4RmEn6+0I9iB05PK0vwEfD0tYkMHAVMr+Zc5tmctv
	GsCoPRcgQcTgDcN78BqdvIzJ4VSSdi0qLNqCqN5PE5+Mt5apsj4DNSUVdOImTtcw
	eBJZGkQbXf9ng3RRNKyGT/0nEVF9qcxAGgqkKHEST199FFDhI4oJL7zWeP9icn5L
	z3TxUwCLARBPXU5NDNMiw==
X-ME-Sender: <xms:R1TXaUjpdU-fgK22rThLkUoDg4KEu3iXsh0Y17LHIoacwAY8UdYfTQ>
    <xme:R1TXaUf7_PRYK-Fnp2BwyUZyyRUs3vfkByzzZznYebpwjfay58Q2fBKkW0ySYrCHD
    e9QUSxqVR8DEhfzXz9YeLL2sOfrpTHTnysS4-o1K4jO2TsOeWts0g>
X-ME-Received: <xmr:R1TXaZfPagV49YsQ8W6hpPcJgvWmb5FvyA1yf5g6sHXqg8QTlU5MpXZy_Wn4UUIYIB1-kv2_jj109eABkmXg72ivFu6d1UXMmxc-PgvaNJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:R1TXae-Q-n7RUBCz_jXPQk3yfDkvs2WahBvkkq33ZlYgfN_-Tlwj5Q>
    <xmx:R1TXaVnrm3fY2If7-XUMwB3MGECHF6fjM3oHaziv-474Orhix8Z2Hg>
    <xmx:R1TXaQ-scjFKTT2EgFqOumJbEMJGwu4hDYOmaJMhGOrwDKfT3Pl2fg>
    <xmx:R1TXaTnGDyIB1xUtyJq4jkm12Y9Ml2-5iW55FVqwD9cpkiUFL_E_9g>
    <xmx:SFTXaUfkU9FU0rPpYT6AeBg532hLFlUlerWlfD4eZD7D0pW7YTZmxFKk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66ee2c82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:30 +0200
Subject: [PATCH v2 09/17] cbtree: allow using arbitrary wrapper structures
 for nodes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-9-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

The cbtree subsystem allows the user to store arbitrary data in a
prefix-free set of strings. This is used by us to store object IDs in a
way that we can easily iterate through them in lexicograph order, and so
that we can easily perform lookups with shortened object IDs.

In its current form, it is not easily possible to store arbitrary data
with the tree nodes. There are a couple of approaches such a caller
could try to use, but none of them really work:

  - One may embed the `struct cb_node` in a custom structure. This does
    not work though as `struct cb_node` contains a flex array, and
    embedding such a struct in another struct is forbidden.

  - One may use a `union` over `struct cb_node` and ones own data type,
    which _is_ allowed even if the struct contains a flex array. This
    does not work though, as the compiler may align members of the
    struct so that the node key would not immediately start where the
    flex array starts.

  - One may allocate `struct cb_node` such that it has room for both its
    key and the custom data. This has the downside though that if the
    custom data is itself a pointer to allocated memory, then the leak
    checker will not consider the pointer to be alive anymore.

Refactor the cbtree to drop the flex array and instead take in an
explicit offset for where to find the key, which allows the caller to
embed `struct cb_node` is a wrapper struct.

Note that this change has the downside that we now have a bit of padding
in our structure, which grows the size from 60 to 64 bytes on a 64 bit
system. On the other hand though, it allows us to get rid of the memory
copies that we previously had to do to ensure proper alignment. This
seems like a reasonable tradeoff.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cbtree.c  | 25 ++++++++++++++++++-------
 cbtree.h  | 11 ++++++-----
 oidtree.c | 33 ++++++++++++++-------------------
 3 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/cbtree.c b/cbtree.c
index 4ab794bddc..8f5edbb80a 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -7,6 +7,11 @@
 #include "git-compat-util.h"
 #include "cbtree.h"
 
+static inline uint8_t *cb_node_key(struct cb_tree *t, struct cb_node *node)
+{
+	return (uint8_t *) node + t->key_offset;
+}
+
 static struct cb_node *cb_node_of(const void *p)
 {
 	return (struct cb_node *)((uintptr_t)p - 1);
@@ -33,6 +38,7 @@ struct cb_node *cb_insert(struct cb_tree *t, struct cb_node *node, size_t klen)
 	uint8_t c;
 	int newdirection;
 	struct cb_node **wherep, *p;
+	uint8_t *node_key, *p_key;
 
 	assert(!((uintptr_t)node & 1)); /* allocations must be aligned */
 
@@ -41,23 +47,26 @@ struct cb_node *cb_insert(struct cb_tree *t, struct cb_node *node, size_t klen)
 		return NULL;	/* success */
 	}
 
+	node_key = cb_node_key(t, node);
+
 	/* see if a node already exists */
-	p = cb_internal_best_match(t->root, node->k, klen);
+	p = cb_internal_best_match(t->root, node_key, klen);
+	p_key = cb_node_key(t, p);
 
 	/* find first differing byte */
 	for (newbyte = 0; newbyte < klen; newbyte++) {
-		if (p->k[newbyte] != node->k[newbyte])
+		if (p_key[newbyte] != node_key[newbyte])
 			goto different_byte_found;
 	}
 	return p;	/* element exists, let user deal with it */
 
 different_byte_found:
-	newotherbits = p->k[newbyte] ^ node->k[newbyte];
+	newotherbits = p_key[newbyte] ^ node_key[newbyte];
 	newotherbits |= newotherbits >> 1;
 	newotherbits |= newotherbits >> 2;
 	newotherbits |= newotherbits >> 4;
 	newotherbits = (newotherbits & ~(newotherbits >> 1)) ^ 255;
-	c = p->k[newbyte];
+	c = p_key[newbyte];
 	newdirection = (1 + (newotherbits | c)) >> 8;
 
 	node->byte = newbyte;
@@ -78,7 +87,7 @@ struct cb_node *cb_insert(struct cb_tree *t, struct cb_node *node, size_t klen)
 			break;
 		if (q->byte == newbyte && q->otherbits > newotherbits)
 			break;
-		c = q->byte < klen ? node->k[q->byte] : 0;
+		c = q->byte < klen ? node_key[q->byte] : 0;
 		direction = (1 + (q->otherbits | c)) >> 8;
 		wherep = q->child + direction;
 	}
@@ -93,7 +102,7 @@ struct cb_node *cb_lookup(struct cb_tree *t, const uint8_t *k, size_t klen)
 {
 	struct cb_node *p = cb_internal_best_match(t->root, k, klen);
 
-	return p && !memcmp(p->k, k, klen) ? p : NULL;
+	return p && !memcmp(cb_node_key(t, p), k, klen) ? p : NULL;
 }
 
 static int cb_descend(struct cb_node *p, cb_iter fn, void *arg)
@@ -115,6 +124,7 @@ int cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
 	struct cb_node *p = t->root;
 	struct cb_node *top = p;
 	size_t i = 0;
+	uint8_t *p_key;
 
 	if (!p)
 		return 0; /* empty tree */
@@ -130,8 +140,9 @@ int cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
 			top = p;
 	}
 
+	p_key = cb_node_key(t, p);
 	for (i = 0; i < klen; i++) {
-		if (p->k[i] != kpfx[i])
+		if (p_key[i] != kpfx[i])
 			return 0; /* "best" match failed */
 	}
 
diff --git a/cbtree.h b/cbtree.h
index c374b1b3db..3ce0d6b287 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -23,18 +23,19 @@ struct cb_node {
 	 */
 	uint32_t byte;
 	uint8_t otherbits;
-	uint8_t k[FLEX_ARRAY]; /* arbitrary data, unaligned */
 };
 
 struct cb_tree {
 	struct cb_node *root;
+	ptrdiff_t key_offset;
 };
 
-#define CBTREE_INIT { 0 }
-
-static inline void cb_init(struct cb_tree *t)
+static inline void cb_init(struct cb_tree *t,
+			   ptrdiff_t key_offset)
 {
-	struct cb_tree blank = CBTREE_INIT;
+	struct cb_tree blank = {
+		.key_offset = key_offset,
+	};
 	memcpy(t, &blank, sizeof(*t));
 }
 
diff --git a/oidtree.c b/oidtree.c
index ab9fe7ec7a..117649753f 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -6,9 +6,14 @@
 #include "oidtree.h"
 #include "hash.h"
 
+struct oidtree_node {
+	struct cb_node base;
+	struct object_id key;
+};
+
 void oidtree_init(struct oidtree *ot)
 {
-	cb_init(&ot->tree);
+	cb_init(&ot->tree, offsetof(struct oidtree_node, key));
 	mem_pool_init(&ot->mem_pool, 0);
 }
 
@@ -22,20 +27,13 @@ void oidtree_clear(struct oidtree *ot)
 
 void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 {
-	struct cb_node *on;
-	struct object_id k;
+	struct oidtree_node *on;
 
 	if (!oid->algo)
 		BUG("oidtree_insert requires oid->algo");
 
-	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on) + sizeof(*oid));
-
-	/*
-	 * Clear the padding and copy the result in separate steps to
-	 * respect the 4-byte alignment needed by struct object_id.
-	 */
-	oidcpy(&k, oid);
-	memcpy(on->k, &k, sizeof(k));
+	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on));
+	oidcpy(&on->key, oid);
 
 	/*
 	 * n.b. Current callers won't get us duplicates, here.  If a
@@ -43,7 +41,7 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 	 * that won't be freed until oidtree_clear.  Currently it's not
 	 * worth maintaining a free list
 	 */
-	cb_insert(&ot->tree, on, sizeof(*oid));
+	cb_insert(&ot->tree, &on->base, sizeof(*oid));
 }
 
 bool oidtree_contains(struct oidtree *ot, const struct object_id *oid)
@@ -73,21 +71,18 @@ struct oidtree_each_data {
 
 static int iter(struct cb_node *n, void *cb_data)
 {
+	struct oidtree_node *node = container_of(n, struct oidtree_node, base);
 	struct oidtree_each_data *data = cb_data;
-	struct object_id k;
-
-	/* Copy to provide 4-byte alignment needed by struct object_id. */
-	memcpy(&k, n->k, sizeof(k));
 
-	if (data->algo != GIT_HASH_UNKNOWN && data->algo != k.algo)
+	if (data->algo != GIT_HASH_UNKNOWN && data->algo != node->key.algo)
 		return 0;
 
 	if (data->last_nibble_at) {
-		if ((k.hash[*data->last_nibble_at] ^ data->last_byte) & 0xf0)
+		if ((node->key.hash[*data->last_nibble_at] ^ data->last_byte) & 0xf0)
 			return 0;
 	}
 
-	return data->cb(&k, data->cb_data);
+	return data->cb(&node->key, data->cb_data);
 }
 
 int oidtree_each(struct oidtree *ot, const struct object_id *prefix,

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

