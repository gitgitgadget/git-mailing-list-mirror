Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A513AD22
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159588; cv=none; b=LR+717x8tdS252NbHJOnOWRP1But4B5fvbcgy5WIHDQdYEedj+TEde8ntF2JIQF6714w6hXs2Gb5tl23zGCkkTweCN1Hv0E5SJJ91kX+uIDeZkKGqBXSzM0LZL6Uj/Z0CZuVwjlga9lW9nYG45PQYgcpAlvhOB+RWMUALCP1ew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159588; c=relaxed/simple;
	bh=mH8SZI/PsDZY+vWiycZ9iDbiEUl7i1XFUqdV3PCjPd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzjkCfwJEY8ZG4HEE6bUb/p2CitmGAe4A9cRcS2Ww/XuqQqzH2SdJVcVRkcCk951qkn+7/gtiu1DI7C219fcPIm+ctu83/g6WCVihcXvIALy16lr6shOavVbizAEiMMZYrdJh25ZP9VXLHhm1I0XRh81qBc0H/VXHsLumUpjbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gJb2WALV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCXvrk5w; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJb2WALV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCXvrk5w"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 320E61140262;
	Tue, 24 Sep 2024 02:33:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 02:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159586; x=1727245986; bh=jrq+YinpYa
	yN57PdMeGJ2dcQDFK6yzlCH+EpmagUSeA=; b=gJb2WALVJ37Wa+S8mY4PpKvzkM
	/8Fsp5KfCeMz00zu31iWcen0Ll70POnVXJVq0/hsTw2RpyILREzKK7SM0zoAZffZ
	XjE+QkaIih3nu4VAgJ3OQInv48rAwv5UGbvcnnr/aDHHHpZ1SG6Qo8zhPTFJk93R
	Trq+mK2t8fDtYjR4fk2+ZhJNb8r4WL8JA6XebbuhVSb6VaIyWe4YWfD161BI56ne
	shq9YxEEgUDf7gef669z0oBixzPGqHPTAYcyRR7JX+yZv14eR/V0WQDNlxmcLw+R
	s8f3Oiqh0Nyv3Y7yg11ub4QJCT9rzMu/Jbtn+9oIQqi/vi7rYsde/ZE3hOsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159586; x=1727245986; bh=jrq+YinpYayN57PdMeGJ2dcQDFK6
	yzlCH+EpmagUSeA=; b=VCXvrk5w9Osz+amkzm9U37Vlr5h9jvafhERNyfjeSSFN
	vic0U4DQF5Xu8tYu5m/cCDL0PRt185Ix338OOTqKYm6Ct6LZNfn7vrL0T5hD/64+
	QuriUqArD2j5qtmf6CcyXNysDsC8DXJ3jQO030xAv5aK5XgbeWXSGLU0STwQgqFk
	g0wklhSv8gMOYWFA5pQxCV+oCp4fRnkjNIe8lLtrDI+SwGcTdq39tRA/DOwamM3l
	6OYUkEZYJzheMn0U3r+hGmBizVFVia2JqVaeilQrYqxocQOGpVRmzR9RSwJXYMZP
	X12K/VS6YWDVwqBvHRE41E2FQcj4KBT1TkmSaIh9eg==
X-ME-Sender: <xms:Il3yZsbkpXWAjJ_ikdL6KqQZZLmm1oSCOQV77ZqYCDdt5b5n1XJ5KA>
    <xme:Il3yZnZoqgWJHK4zpQKsLCQ6qyoVwltZl-YR0OVd_GlYoVUireq7Xo8NbBNjBLWaC
    Ya-AsTq8qLa2Z7BrQ>
X-ME-Received: <xmr:Il3yZm_WkBuICLs6xrs5-OBoNkp0bs5E7_oCsqwQuXE4d4vhy23fzR7TkaIRIJSm6QwXfbavQGfg2tbMBuOMNILsuwtzFMmgU4yCI2XQXbrGRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Il3yZmpzihLztNTZ2xUv1FnXTejm78neA89eDcRQe96hQLIaCKKesw>
    <xmx:Il3yZnokoNbODQTKQL_2v-LS4X0cKIKPtk-L9JhiOXyFMkEN_f7qHA>
    <xmx:Il3yZkTAUzCvkRzOB7o36UIk_HCr9a0VadG7XvLJY4DKo1YKus0_0g>
    <xmx:Il3yZnqGs3sqSWP1BiCaq0NrOaRId5Vib-Oh3tEDfYDTt7jd5voHpg>
    <xmx:Il3yZmVqsipz24GkktJ_tRxUDLSuspqiOUD8CmC6sTZnUnob4CL30jLp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:33:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34c096c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:31 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:33:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 21/22] reftable/tree: handle allocation failures
Message-ID: <c31f9e53f529055bbc1eb5022befb497c1682d19.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

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

