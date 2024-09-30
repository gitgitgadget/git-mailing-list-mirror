Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B9186294
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683757; cv=none; b=bFsR6UyGD9c9B7FWVRGUb0mSVk4GSQtr3ZkOOt4Iib6ZZmjeQamlTJof/lg6NAQ7B0KWS//GhRXG8kxwkDNvgABrwWSihl8u7R6UZ51EQff5+1iWYpmz3nxl4axXFXSdnqkAKxFZ7fj/HJ03w6RVz1VSJ7P3kvSQ+03OrBPgE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683757; c=relaxed/simple;
	bh=czA4UsM4MZz+mB8Oiolx/LrsQVni5WCHxd3vwCjS7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I66NhSX3SALlZEpF3RCJJZQeSNMtB3yRopomn5CVNvVNscTOzg4GachMvjX5zTnFHxUE1m/kB6hfnQlCY+yWosQBMZjCouLlurQPHqxqlAMwkOFkQNQnBuacCAJ+NRvZtQsaYq0xTTKX8CJ/Z33yzNAna1YUlS+XXmPQbl2LzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eiIAnRlr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SuT97PS1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eiIAnRlr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SuT97PS1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4048D1380204;
	Mon, 30 Sep 2024 04:09:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 04:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683755; x=1727770155; bh=fjrG5/rA86
	4IgAj5ZhQkZmFnxpFs4sRRftfGaGpDT9A=; b=eiIAnRlr7z3IHfEgO7AoO28FRA
	kcWWzNzN2WuyxFBOv7kKefyqQGKodK6imhwsPPhV/8dAp3yLbE1ujU9vdJDLshHx
	r5eDv+btAy4NZo6LN0UBBhNsfrsHin8Du3jbYmuAjr0cml/7oBpLW71S9xxm9Lwr
	5QA2hlkJoFE7reRU+ock5ir+Z31tIRE+V+7SbKteGE6SRQyrNsERuOgh2a6nWGtn
	Ib0C7IzpAkWuhu2cCCgTkkVzYCqMAv52gP5E7izCG02yvRMunXBJ9rEazYUDIPCb
	tT4jlxcVM8QlpIYwug/gso29/si7gMVQtCJs13rPQ+sOhuKobeVx0VgRSHjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683755; x=1727770155; bh=fjrG5/rA864IgAj5ZhQkZmFnxpFs
	4sRRftfGaGpDT9A=; b=SuT97PS1GXJ2ea72JicA10n9N/LNvSV463wyOLHWUhnX
	j16m0/6rI+G5AsOVBupMHo04cNK3foU9Jjaky0Yc/DAQQ1uY2Cz/8cWXqFOEIrmy
	gbH/TYqwQgK7nfFKcy2PbvaApF30nn0kHUx1re1fUuLWWftta5xRmxXaPUMfUAFN
	W9/4npMVvmTZNXjxb2PzHXTbBcFaO5DqGHChF4Xc3w1ghxqY95dGOKTdUrCct9qH
	K6cGhjeNTLVKb0pZyUMNLecgRt2yH+zlKsIh+vgQxxIn1wQ3uXHHPD5evYggzzHi
	sBz+6oER1wRC4N0W2MSLfhs8S2fwFRKav5Q6/2cu9g==
X-ME-Sender: <xms:q1z6ZhZZHwkHSIqTbv-3JWhV15i81LSrvCLOZkmHk899LRGGzjNSPQ>
    <xme:q1z6ZobOoIj_bsFF00H9-k50agpUo2Q3tVFmd4I00FEwwg4GYG2iu2_hkbgsMLQss
    wSmZVa9kqyLvzTsJg>
X-ME-Received: <xmr:q1z6Zj-r7DTbwHiVaEngFX_4k0ai6oKAmgfQGQgd4Z9D9FHZUZFUsblEagV5BR8PQ496VtfOdVuZr89k-tUQDH5ZbFNjkq8yENHntu760wNV-gY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    gvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:q1z6Zvrvlu-67kzzseDomT-PokObNx-VwM_EplQnFVLkoWPvNot-dw>
    <xmx:q1z6ZsqNmuHnH0_cZ98OtNPxzzY-f9lIruGK3OZMdgnjC4h0QVKI_w>
    <xmx:q1z6ZlR3UE35YFPRUfqJaZZvId7rJu7KEVMKIl9EN4QDPzNTMRDocg>
    <xmx:q1z6ZkrYhYK5c5a9aPYdM7gZx1hiiofFn_CR8xfyLgCdMsIlRL3BKQ>
    <xmx:q1z6ZllmOoJrEeIbrELrE36o3ushSCbSwzB4WWbGEXFP_wcsCQ_yk2U3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:09:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1dc55e0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:28 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:09:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 21/22] reftable/tree: handle allocation failures
Message-ID: <c291114553016985f5ba635457cbf9c87c05ad2d.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

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
index 5ffb2e0d69..f4dbe72090 100644
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
index fbdd002e23..9604453b6d 100644
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
index 712a84791b..44bed92f46 100644
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
index 700479d34b..79b175a45a 100644
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
2.46.2.852.g229c0bf0e5.dirty

