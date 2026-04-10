Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14353BE62A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823191; cv=none; b=hxng4IZBaT0gUfbptwfqm5sz4G29Zr/zXxioL/O5mTNEAXfB8C1AzxXsS3woljSvahPUmoXz7C64qVevbahdcgQxjtBrVddI02cJxqlgNKfpdF2Gl3jC4vsZUZWVUqitQVhAHD7qbmXzSKYYI0EoiRC3xf4RFhUPEYQMFNqy2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823191; c=relaxed/simple;
	bh=Ae3uSf2iLm2WZDBpmkPMOI/rYeQR6DEL4LDHTTA1+Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJGHMyz0gT6R5AnKvuFu3rQg4irdA+5IRx7SOkeUSsPH/CO3VVtKPbzw8hQYkO4ITrnrjgLKMUej+51WOWermJigYaP5IlIzHMSCpZqkrg97nC/6yRaD0GStmmvCrdejrmtF6B+lzOW5l8WHSA1BN1euYrFVxw/uxVKvl6dbPi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t+WyVIQV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AyrvWI2J; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t+WyVIQV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AyrvWI2J"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E0497A029B;
	Fri, 10 Apr 2026 08:13:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 08:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823189;
	 x=1775909589; bh=JlZjra7Q8H99YvXnG06UjvibKfNpUEUIELFSbEkVSxE=; b=
	t+WyVIQV77L2JCeDNmPZTDmAoQ4o+ZL4ae8ch7d+00iR0OCDCYjLA/7gDUdocIwb
	kNGtWLDSkFWwnUWebuEL4ymZ4V7nBlpu//DYU5zNgkh3ZrvIIKAbGfzWotFxo5GJ
	RTQaQOGWCWUyIwIi9jnwL3Of08gqJqSy6aKQEUeS9BwiD5zAp6TDK7VgB7n9z84P
	pKuCWXzjfZXUwkWNIxwJsTmF9kvWPwGEFaezlh/NGKEduNi4PNWutEJLuaxGll77
	UqV4wgoh/eIaLeJab+73mZpfBmgcrLTrfkAoBepGu2of+uxN7VEA01nCBugdzMTL
	MdR5Ytk8WTJhQAsQd4xTwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823189; x=
	1775909589; bh=JlZjra7Q8H99YvXnG06UjvibKfNpUEUIELFSbEkVSxE=; b=A
	yrvWI2JXvhtRKhBEaaiicrToy3bJS4+q2DJJYv/HYN5iUA5en9PSsTFtTylOoz4n
	TtE1jC1BqHV5+Y7cOlM1X/Xs9DvIgxcgdD83M8z4q+y3OzqvL/riYfpGkkP5doWn
	I5UxmTlt1pb+GG3SZiujK1k3vZSBtHVQkRN31dkU/DO+oO8xRU1XFkXU9Y+wXNhX
	n6TA6Do82SbIbVTsVnRykSy9w6pG4Cq6+I1T3HslUjY0kTgpovA6GzS35/6N8yph
	/Nhps5CpiijVh+WYxiTf5vOqn1sxoRlEUJB3l1QQkdWtFogH59OGUwo+cJcpBPEM
	T1vRCjbeIVjeZBfgEJ/5w==
X-ME-Sender: <xms:VOnYadZdHOEWpDEI_snqHDz_NTqis9nnKPc1t9XVhRRwoBVuWWR78A>
    <xme:VOnYab0vfBy9GJOUzRqcQaykxzO8JXB89r6d4ugBQCMX5cMAm8e4ViRYNU5V6lbWQ
    n5PZbA1G2XJbsK6NElLtrg7Yz1V8eBxIM4p23xRoEzEY35e1Qq0DQ>
X-ME-Received: <xmr:VOnYadUpftCyhEin0gcoLo5Gmkvz07Hbx4cT8Oz5sVeLksDt0W-tVauaXh9lO-Q0yXwddfw49ldbO0UWHp7TlEq9iNYPwEeCAzKLe7s_P_nEZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:VOnYaVWxc05VUJKxnlugkrH1bPzVOZRmu2QhJVoscAYs6MlK5PhhfA>
    <xmx:VOnYacdaUvODJ7CJU_JXN35O7XBxNMlSTDAJc7R2J8DpYayh4j4sBw>
    <xmx:VOnYaeXxpOOBfAjkQwchnza-6B4ASeQ9qqVBL4Sp08sFMVt3JPeDYg>
    <xmx:VOnYaVfGfSF7hAs_xuuftaO0X8FnRU4KVbGngEHCUio1FB5hfF84HQ>
    <xmx:VenYaT0I_3FxIpAnN-QwmF321R6-C2LDHJ-5kjtzU9ItwfJpoGoqfABG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41efcb29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:38 +0200
Subject: [PATCH v3 08/17] cbtree: allow using arbitrary wrapper structures
 for nodes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-8-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
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
 cbtree.h  | 17 +++++++++--------
 oidtree.c | 33 ++++++++++++++-------------------
 3 files changed, 41 insertions(+), 34 deletions(-)

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
index c374b1b3db..4647d4a32f 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -6,9 +6,9 @@
  *
  * This is adapted to store arbitrary data (not just NUL-terminated C strings
  * and allocates no memory internally.  The user needs to allocate
- * "struct cb_node" and fill cb_node.k[] with arbitrary match data
- * for memcmp.
- * If "klen" is variable, then it should be embedded into "c_node.k[]"
+ * "struct cb_node" and provide `key_offset` to indicate where the key can be
+ * found relative to the `struct cb_node` for memcmp.
+ * If "klen" is variable, then it should be embedded into the key.
  * Recursion is bound by the maximum value of "klen" used.
  */
 #ifndef CBTREE_H
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
2.54.0.rc0.707.g0fbf48f4d6.dirty

