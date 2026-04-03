Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFC137266F
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196166; cv=none; b=IgAREEiT6tO4puPlly6QZSq8Uv0szU9rAo9z5+dRDH7upcv/XyuwowQdvn7LaFxxLBoLGldiqSZOG/CMIK8aixDoaTwBSXZjKJjHREdvUuF3dFGzV4M/+pxi2oIqjuCZX3XAqmw0IgWXcaRt61p+Y1Y7QgVBEB8+ftfiKRS6Qxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196166; c=relaxed/simple;
	bh=gMmjgQmLadmBlBLNfxMzZge6tZaLPFNbJWgI+sO2lJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DsPMbSEFugW4oYiehweL5tqE9R0CpnHKJhEek0/5CWNJH6MpKzQ/ELUTGXLfr7pPOxqD83Qlvd5xoPqBvEAsThwTqTFglCAq245VdX2WvtYJpP/FX8V0sI9DREDRton1ds3tPjwNqwueMp6MLnlr2Rkr7aB8HDXZSlI2V8NX5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oL+8Ib1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uV9h8xIQ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oL+8Ib1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uV9h8xIQ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C4671D00173
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 03 Apr 2026 02:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196157;
	 x=1775282557; bh=zoVaa3sLAW3Uehm2K8F3+q2kHzRHWsA0XKJ69y7ZftY=; b=
	oL+8Ib1KCPtwK846rORDF85mZEpMW7F8f5XOJk4UgAUDCpaenPZi1e1HWTSDu2iU
	Y4JdjfjaYjNE1bWLHkTPo6sKO0M6lKB/v5p75F9qiGrc+hdTQdwkVJoSPpPQdNrh
	Ev5We1JSs3Y+bwAgdTG5EPSap+bmkMtMQ+okeEqWc7C+iBfmcaVZLJeOCH/eQ7Eg
	9Nw1qdO5tbbqt38AJz/OjOsSWBJQTAlOYcAiuSNEkgrlffKG2vvA9vxZ34sLmu0i
	z6TwcRt8UENiy7rT8pd/St155ma9Fd1r9o6BPmL+x+j1eiyngUsSGbPuyYYcmW3I
	RyjgyS7pWMbp51z8WpWOsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196157; x=
	1775282557; bh=zoVaa3sLAW3Uehm2K8F3+q2kHzRHWsA0XKJ69y7ZftY=; b=u
	V9h8xIQ4/8gmlPkB7bL/BhSPsVu64/9gQmzOkiWvDhy2+PlA+2lB4p1dqfMOeyek
	yKkI04cegDbvkZw0h7neWB5Z+NzWz6wTYFTQb8Hmk4XUIq7IjGFjT5Qhi1Sl4Je4
	/nvw2h4ihlLma7CzW8TQHL0GDUZE6t3F2jr5NVJQBBsmoL0TIBPzJsVthd2nOuOp
	dNJ+XO9wKEl4/jY2OZDLdh/bs1ZppJsy++wP58hqJZmPVnDQ44Bm09f+q/5zWzZ5
	JqPXs5CJZFglZPfsZc4ThjyrSjpeD/tkgJDdoAjWaFkZREN1xw8FZkKXlC4XWRAa
	N4izaHETgR1RTpBVs8nnA==
X-ME-Sender: <xms:_VfPaVc-bOkZrN9-3sue7FW4MPNlBUTi6pNIwJBx2Htcbtaf1YUOKw>
    <xme:_VfPaaLJ7DOtHY-9xD1ktWdP41R08sjcdrUQYZfx7asXIHUcTRpoYWareCjGZ63kW
    ehrlGbxW-Jflyp5jNV76M7Wvd-mClUZnVwQQNFQ0B77BegBIy_IsGw>
X-ME-Received: <xmr:_VfPaULRc7K6e_cg1if0Z3sbXeWcBOmZs7gUGzOmcVEtCDsV7wC7E338dUPVlodexRS65-E34A_0l8dReGuIOpWP43BS1AOf_9XUsLnajVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:_VfPaUHmnpZrunhBZLTz-iVhcGw5-jI2aVScItg9mCzG68y_Co1Hlw>
    <xmx:_VfPaRlllydp1FAAiYvZQbVZa7nQeGhUVT5pTkJXWebOAWpr6gi9hQ>
    <xmx:_VfPaZJuAYPU8I1Gf1IDXhHSS6vKq4PrpKyjglfAbJET3s6cVeRnAA>
    <xmx:_VfPaaZJiqpjIbP2Pf4l_Hu0-i3wyynJ-ruZLMflnfHx9WTk1xzicQ>
    <xmx:_VfPafNHjZMDPJzNsZmqk5a8Bg4BF5eoWoLE0JjVguTaOBIfWm6IY_wJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0480ff71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:55 +0200
Subject: [PATCH 08/16] cbtree: allow using arbitrary wrapper structures for
 nodes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-8-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.53.0.1323.g189a785ab5.dirty

