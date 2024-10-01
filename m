Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390061A073B
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775773; cv=none; b=V9E+8rx3TqJip6UZUouO70UsRzPkhdiGl0k22GS0z0Kxzv5dk8BGbzUUVqXUsy9q9DqNCysP1TUbA38x57wq+xp3RinAw4S2Lx28sBc61Kl5dIEqwswi+XGqBgEVL8gcKyJdN7LetwINylQagZNahVKhZ3I6pubO0mKWUMSwHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775773; c=relaxed/simple;
	bh=C5jR1IlCIKDK8WiUjz6HP24TIbtXWl+mhD3M36uUlsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDsNGYWSswCqnYDX6wt25QE8UG5QPpuU0P3naxN236b2iOo7fKmzLVNYAowXYeThmesTdO2dQcr+gwulVBdZp7GXxM51nUBJMJAIRyN1PZa+DLD5oJTLPcEwqUirBE1NqTewyPi20ySF17LHZGoCx64Xk3Xu2LFy1Ha8Lwezf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tJqYX+Of; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m6R1h5fc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tJqYX+Of";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m6R1h5fc"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 43DC713816BD;
	Tue,  1 Oct 2024 05:42:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 05:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775771; x=1727862171; bh=srMVGjg1LJ
	KX0ylPrgUBx2pqwuQ+br5EBxg31iRJj9Q=; b=tJqYX+Of6n7utrJG32raTRG9hf
	HxmoRt/oWgVoHIIeY6Dd+pfDxQv+TQrHw6MEBzFVWtQ7yAaGvVIezYBg+DqIoDZB
	Ec/9rwXtjl9+cA3mYuMrBJt8YuGHb8WXKfZ8pk3ed4TbaSMzuRYjpdo9fnTYd7cP
	K8HC2qaTQ+D/mfoh53y5YiKjik7Al8Yo72Y71lSZXEEIT1b8dtC+tzzQV5YmufNB
	Crk9ZR37YQ4Tfcf1l//UzHLj0mofk/g0kKRQuKRQ2v+eVENgDd99Qvl4odYi4Tv3
	iw2aDIxE6q5ZU7Tz82lOvbvO01g9ECr4bfeEexxXhbvCnvHOpWzE9jm+/6ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775771; x=1727862171; bh=srMVGjg1LJKX0ylPrgUBx2pqwuQ+
	br5EBxg31iRJj9Q=; b=m6R1h5fcY6tEY+Fi32l4n5I/zvwELsu6g6l5Vsx5gdT3
	2lPFFN8v1kigIDk2u5VPAazk4ZWruf2T/9aOYRzf4O/JIAeFwT6r4HsyCTt2k8L1
	2Csc2Y70cqn9zfEbUOhvu+C6m3CiR30cgYKDYCfvBpGs53TXOVWlZ82iLbfur63n
	vhnRylnkE83C3T4m85l0IGvL64dqmLbNtnycPLBtqeVezCA0jaxYkO9Wr5FODDQV
	YdeecbNiv5gBiL+rGk864wTchov3zo08/8i280ZMVyGliOsJIn1EK8+0rA0jwNN/
	Xdt6L4arl6tKiZuD40i/NOSZDFslvK3AO2/MsFG2nA==
X-ME-Sender: <xms:G8T7ZkhRYv1xJ-E9e_p48cwB9mYxqsMapdLOKa3c0PEsmOVw53Fltg>
    <xme:G8T7ZtBnOd4qe-ypKMJHP0S_87RvzCBfWBejtKYqxeELSI_k4nZ5_ILZmM_zIjYRD
    tAOaP53lWKxB4eR9A>
X-ME-Received: <xmr:G8T7ZsFr1jwuyHS5oJZPj_aw7bPVxtIi305OzCwnEupBgi-T3eFaH0JqQhQVAd4u4nlkbP5mTgmAMokxl2AYtVafLashRHkBWCspDWRpd-7AjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:G8T7ZlSz6oTlN4oYoEp2ZuaDlnu1fa6H_y7yi0rzL0Cmyl-uYUyFrw>
    <xmx:G8T7ZhyXv9pgE_TAVUF4Cj8sGSfsOFb0l68X2V3ElwgeJndUQ3Qb3w>
    <xmx:G8T7Zj4bDVyBMYazqrmnVkIrmau3tGHvCkjRBYjYY7xWbQZ59zQhuQ>
    <xmx:G8T7Zuze00t3ah8VLswjA_c9Xz3aOS7n8Yys1UWRs37CWw_oObEbPg>
    <xmx:G8T7Zjvf0X4ucZkuDXzSSDUiDXZoM7OeTHMO4uAQNZUS5C12KSOqo0HX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da89cdd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:42:02 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 21/25] reftable/tree: handle allocation failures
Message-ID: <a3639304884db6547f43461afe7aa9800ff24dc7.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

