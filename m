Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBC1EBFE8
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866594; cv=none; b=re2LmCSo0J4Z4xdeat/+7u9EAsBOiwbay8Pwpy6vyGFfdQY5VE6LAwb4/049ZhfpE/GgzY1C+g4p8iT3pjEql2BADs/329eE9hdwhEiTLv2JW9eXOsDNPKj+4J5re8LPQw/w4S0x5KdIZf7ma4+u/Oevo0QCaWnNH7/x3GWSdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866594; c=relaxed/simple;
	bh=C5jR1IlCIKDK8WiUjz6HP24TIbtXWl+mhD3M36uUlsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlhMbnWM9E+DBgO0w5GQnBNUsL51QsvLdsQq+KX7zsjMwUD2JIlTwR8RwacmWDZHAx/mvvm1cYa1KdE2uGKtNIgCuOPSaTl6JxUew1rFK+QHEReRuu4okT+3QOhxflb8OBBmlGKq7njHP2yVVlkz+lVF9riGCz8brF8Yk+wbKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=omdVsEKz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQkF17uJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="omdVsEKz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQkF17uJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F14C913802BC;
	Wed,  2 Oct 2024 06:56:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 02 Oct 2024 06:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866591; x=1727952991; bh=srMVGjg1LJ
	KX0ylPrgUBx2pqwuQ+br5EBxg31iRJj9Q=; b=omdVsEKz88TAx9oinqLGMOrj67
	1rVx3tjIfWhPOh3QvyYFEgGnOqjPuvwGGxcutVu6Ld9x5PLeF2P1nfwGjnDePIn0
	KuOeFmaTdC1TMRRoRssiDcqV6wLRB0gAPQnPcqD6kHJh3NOQeBfpjjidY45DqO0H
	6VUIkNXlXFaV7YtjScrnTOwa4kkgfdbdggMt6qOuNtqbsWvMFSOh0Qq9owoeAfZ3
	HNjV3+jHzzlF/Y5QWUhcPEnhS4nhj1YeKzsp0/AQ1AggEUMo6i5eAVOLxQDjRKYg
	hoYkQ08lrwR/tWWzMrolvg8ozIQmjawR3cYAnQx3I+cCEw19PBcHVkUGJkhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866591; x=1727952991; bh=srMVGjg1LJKX0ylPrgUBx2pqwuQ+
	br5EBxg31iRJj9Q=; b=aQkF17uJZfP1QpQB8t14wyxa26lNXCuENqzyzepQVF9+
	4DqflMZx71Krd5J6MkDJTf4OdqrWjA9MzhGyXl082Ceqa7fJnOxtiUr4FBKpFuwJ
	kC+w/PM/GfTHVqRxG/DBe31mxZ44FGHUI47/gXJwxtfJJqjpUYaT87Eh/ekSLxik
	k9iPqDS/exkQv/cntvHHTqfBxrmHvjQ4CHqnSqxs2Y/mVU2uO+zkuKceGQjkJSaU
	vUwBy2Y/MPZQZH3XUjJzMaeK0W1NovFt+I4DefZbQZE2ijaCmM5cVdAc2TN21K3g
	b36BiKulyn7makla2rJVp3N0jG7Hek/m4fOM5jcpvA==
X-ME-Sender: <xms:3yb9ZvRDrje1vVOWUS0UPAne13XlEhSu8W9wPAgpFleUGqFBOF52YA>
    <xme:3yb9ZgxDJstYrqkkLtlEOUXDAGwD9s_TXQGQXb4JA-Ko5OEW-BBExHMsDj_N0HeOe
    leEo5hDoZZIelhODA>
X-ME-Received: <xmr:3yb9Zk2s9w3HssLumlL6KMLd3De7HuSiWvGtdwodk6mdDG0L5ChBwB_HGtEBw5yNPSYSbqFzo2FLvw8bzYUygP3N6D_ww3-jug3a4kZxqr0w9Im5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:3yb9ZvD2IFn5SE3CyxaRJkF9XKocxHJSB71tZ-3jr80QQmKuBE4Ylg>
    <xmx:3yb9ZoiIaJKXRvwx6jhrZFUbMOEWH-K4-FUYEBKzZ5WXFbPDYNwF9Q>
    <xmx:3yb9Zjruco_1NZkmKy8itmEWScFvtv1EAc4ytGw6aI6IAxWJR04QXQ>
    <xmx:3yb9ZjgcDbK2DJisaOpTV9TLjwAes1qXx-J4M-JxnpwnWi-prcT_7A>
    <xmx:3yb9Zgf6QEnBooFAQ_DtlqTv4yUh-u6SJgsNaOfPvsbsZPSvKWW9VB7S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba2d3c0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:41 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 21/25] reftable/tree: handle allocation failures
Message-ID: <a3639304884db6547f43461afe7aa9800ff24dc7.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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
index 791e246337..e180c10840 100644
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
2.47.0.rc0.dirty

