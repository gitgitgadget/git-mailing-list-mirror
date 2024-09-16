Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFE158DD0
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489767; cv=none; b=X0ToFbmTgP1JW8UGzmeBAM+JA2diGqj0Q2qdcl1pBT8a1FidDHWIPWEFK19oMSEPsmMoyDLoxUUE22ppYRzUO/+Zqw3VHBvNW4EertVPTvnvFVxc//NHGGqh3XEXkOpxsUCSq8vZYm9cSpdphT+cRpc3d/8rbPmyp6LHaWW5E1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489767; c=relaxed/simple;
	bh=mH8SZI/PsDZY+vWiycZ9iDbiEUl7i1XFUqdV3PCjPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCKbrnKaJhGqgbIP+mx7qCpf4tq5jMBVbQ1mMi4q7+N3h/MrI2nTKIA0Cap2H7qawxxQhNERD9vNdcVr1u8Y777WGKYqrX4cdzSQpfGSlHi4/4BVo7nY3alwoIkeJtEqpSUPSSGZf6LlqtDne6vJxnLCT5qCVwBknRfVfFJhHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MhqkoCGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDityAMv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MhqkoCGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDityAMv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C14E113801E8;
	Mon, 16 Sep 2024 08:29:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 08:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489764; x=1726576164; bh=jrq+YinpYa
	yN57PdMeGJ2dcQDFK6yzlCH+EpmagUSeA=; b=MhqkoCGWVtcqL5RC/eOhAO6k6i
	PkTyK+9sP+xDhXmEzeXFaq56JqIbNzi9k9pB3TeaGTP0BbLfYu9MasxQco+6Y+Tj
	CkI0jZkF59KjQlqTqJhm68uzYAfzI/AEpEhR3/628oYRpNTS5jEFh0kb9Zcy0P9n
	AtytgBdE6XTkSUdb5NQkiN2SG7ZBROT7DIopNNe5PncPDoVGAaeNO36JX+k1DZIP
	Hgqkd80WYlFTdaMvZR92eAEY/8YcicpTJsqFcFVyVh4gzk99cQNCDqgzLz22R9Lj
	Vzx84dE8vMVLQQWy1fpkRb+sDH+ShW5/WokGNK4C0vsajAj6Fidy5vaPY2/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489764; x=1726576164; bh=jrq+YinpYayN57PdMeGJ2dcQDFK6
	yzlCH+EpmagUSeA=; b=XDityAMvCVjM4ZlU7ODiqT3Vc6XC4zSOgs7qM24smqdT
	Q+5nvxZfn1/dAA9rMUp88x4Ht67MMuhL/8TqqVm1+z0aeSk2xWgRnxu3oaK1en95
	TxVtV+2FHCR64qV1vtpz0ttXh5pDMyrKDqBLEyKKEcjX9Km9aAgo9CPJ07xa/0Uk
	6r1BPHw96IqTMWSDaulWirPQECezo5eGv1crk3X3C6rs1I0FW8L/1geLkldIfzwE
	oQ5SZAoXmM4COAbYMeO7CB6SK2RRTecVc8HJ10PvE/IC3ew6XgVx19b68oYnDB0Q
	qWqoqGakp8beOw/gt7HpJimHydZuFneJmwAu4XLvwg==
X-ME-Sender: <xms:pCToZmzTXFwJ5U7KhQjIImb-DjBCDo0TFHdilgggV65F_QRMdnn-0w>
    <xme:pCToZiQp_5DAEZA9Ar2Go37BdkC2D-rB5uft-y6DZ-ZC5DsblNn34oFw2r4oMkmKW
    iH5eZctF9kdLZ8zvQ>
X-ME-Received: <xmr:pCToZoU0KxhDddNm5eLl7btBD0E7-05xpbUamHZzFsopkA88Dj7-7rLpIb2zAAxTo4fpe1ItZBs75MWRZ68gqOzxlLKEW6SxJUkOyWbqD-cpvCbF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pCToZshGFCG-v7PNLuhMIIPu5nA2aH2BgIK5IxXzdy70BenI0YT-FA>
    <xmx:pCToZoCX3TkJzPMEaw5QLF7XazzOj7N6iZwkArvhT_0AkEl6deRGVg>
    <xmx:pCToZtIdXeRWSKwSsQFUV1S_4KTtpzTTY7rDWjFIvhFFUJZOWnwtOQ>
    <xmx:pCToZvDvpfDPJRPRPMpeBN8PuZ4y2ow7CpQf-QKv-orbtq1jdvl5sw>
    <xmx:pCToZrMU9DgFnVGuqlnWdPX9rNvqh3lq3B2Oqi78ZBh0IwHy8Yzchwhr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 63a75499 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:29:07 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 21/22] reftable/tree: handle allocation failures
Message-ID: <99bca688f2a393190bb032238fb36e01088ff24c.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

The tree interfaces of the reftable library handle both insertion and
searching of tree nodes with a single function, where the behaviour is
altered between the two via an `insert` bit. This makes it quit awkward
to handle allocation failures because on inserting we'd have to check
for `NULL` pointers and return an error, whereas on searching entries we
don't have to handle it as an allocation error.

Split up concerns of this function into two separate functions, one for
inserting entries and one for searching entries. This makes it easy for
us to check for allocation errors as `tree_insert()` should never return
a `NULL` pointer now. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/tree.c                | 42 +++++++++++++++++++++++-----------
 reftable/tree.h                | 21 +++++++++++++----
 reftable/writer.c              |  7 +++---
 t/unit-tests/t-reftable-tree.c | 10 ++++----
 4 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/reftable/tree.c b/reftable/tree.c
index 5ffb2e0d690..f4dbe720901 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -11,28 +11,44 @@ license that can be found in the LICENSE file or at
 
 #include "basics.h"
 
-struct tree_node *tree_search(void *key, struct tree_node **rootp,
-			      int (*compare)(const void *, const void *),
-			      int insert)
+struct tree_node *tree_search(struct tree_node *tree,
+			      void *key,
+			      int (*compare)(const void *, const void *))
 {
 	int res;
+	if (!tree)
+		return NULL;
+	res = compare(key, tree->key);
+	if (res < 0)
+		return tree_search(tree->left, key, compare);
+	else if (res > 0)
+		return tree_search(tree->right, key, compare);
+	return tree;
+}
+
+struct tree_node *tree_insert(struct tree_node **rootp,
+			      void *key,
+			      int (*compare)(const void *, const void *))
+{
+	int res;
+
 	if (!*rootp) {
-		if (!insert) {
+		struct tree_node *n;
+
+		REFTABLE_CALLOC_ARRAY(n, 1);
+		if (!n)
 			return NULL;
-		} else {
-			struct tree_node *n;
-			REFTABLE_CALLOC_ARRAY(n, 1);
-			n->key = key;
-			*rootp = n;
-			return *rootp;
-		}
+
+		n->key = key;
+		*rootp = n;
+		return *rootp;
 	}
 
 	res = compare(key, (*rootp)->key);
 	if (res < 0)
-		return tree_search(key, &(*rootp)->left, compare, insert);
+		return tree_insert(&(*rootp)->left, key, compare);
 	else if (res > 0)
-		return tree_search(key, &(*rootp)->right, compare, insert);
+		return tree_insert(&(*rootp)->right, key, compare);
 	return *rootp;
 }
 
diff --git a/reftable/tree.h b/reftable/tree.h
index fbdd002e23a..9604453b6d5 100644
--- a/reftable/tree.h
+++ b/reftable/tree.h
@@ -15,12 +15,23 @@ struct tree_node {
 	struct tree_node *left, *right;
 };
 
-/* looks for `key` in `rootp` using `compare` as comparison function. If insert
- * is set, insert the key if it's not found. Else, return NULL.
+/*
+ * Search the tree for the node matching the given key using `compare` as
+ * comparison function. Returns the node whose key matches or `NULL` in case
+ * the key does not exist in the tree.
+ */
+struct tree_node *tree_search(struct tree_node *tree,
+			      void *key,
+			      int (*compare)(const void *, const void *));
+
+/*
+ * Insert a node into the tree. Returns the newly inserted node if the key does
+ * not yet exist. Otherwise it returns the preexisting node. Returns `NULL`
+ * when allocating the new node fails.
  */
-struct tree_node *tree_search(void *key, struct tree_node **rootp,
-			      int (*compare)(const void *, const void *),
-			      int insert);
+struct tree_node *tree_insert(struct tree_node **rootp,
+			      void *key,
+			      int (*compare)(const void *, const void *));
 
 /* performs an infix walk of the tree. */
 void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
diff --git a/reftable/writer.c b/reftable/writer.c
index 712a84791b2..44bed92f467 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -208,8 +208,7 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 	struct obj_index_tree_node *key;
 	struct tree_node *node;
 
-	node = tree_search(&want, &w->obj_index_tree,
-			   &obj_index_tree_node_compare, 0);
+	node = tree_search(w->obj_index_tree, &want, &obj_index_tree_node_compare);
 	if (!node) {
 		struct obj_index_tree_node empty = OBJ_INDEX_TREE_NODE_INIT;
 
@@ -221,8 +220,8 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 
 		strbuf_reset(&key->hash);
 		strbuf_addbuf(&key->hash, hash);
-		tree_search((void *)key, &w->obj_index_tree,
-			    &obj_index_tree_node_compare, 1);
+		tree_insert(&w->obj_index_tree, key,
+			    &obj_index_tree_node_compare);
 	} else {
 		key = node->key;
 	}
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index 700479d34b1..79b175a45a7 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -37,16 +37,17 @@ static void t_tree_search(void)
 	 * values[1] and values[10] (inclusive) in the tree.
 	 */
 	do {
-		nodes[i] = tree_search(&values[i], &root, &t_compare, 1);
+		nodes[i] = tree_insert(&root, &values[i], &t_compare);
+		check(nodes[i] != NULL);
 		i = (i * 7) % 11;
 	} while (i != 1);
 
 	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
 		check_pointer_eq(&values[i], nodes[i]->key);
-		check_pointer_eq(nodes[i], tree_search(&values[i], &root, &t_compare, 0));
+		check_pointer_eq(nodes[i], tree_search(root, &values[i], &t_compare));
 	}
 
-	check(!tree_search(values, &root, t_compare, 0));
+	check(!tree_search(root, values, t_compare));
 	tree_free(root);
 }
 
@@ -62,7 +63,8 @@ static void t_infix_walk(void)
 	size_t count = 0;
 
 	do {
-		tree_search(&values[i], &root, t_compare, 1);
+		struct tree_node *node = tree_insert(&root, &values[i], t_compare);
+		check(node != NULL);
 		i = (i * 7) % 11;
 		count++;
 	} while (i != 1);
-- 
2.46.0.551.gc5ee8f2d1c.dirty

