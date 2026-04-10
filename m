Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138C3B9618
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823193; cv=none; b=Euw3vFQj8mjZRFqBGznoYvpUHCDgVkOf5er2nCw3na9jheZQUTVJALH+dFJXD65RW8dPu/O+g+5J5mhisiwTOrF8AtiazevCUmA64f3oDccK1ZsoRkoawtPQmA93vSvdh4EWDDjIXO1+t098wWO/6i8dGyzi48AhjN46eIeJ+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823193; c=relaxed/simple;
	bh=ze+GDiGYD5tY5gNeiDNREh3XquIKSvH48fM1X9j0DDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajvJXwwi1IAh9NvsnlADalbrjbU5eUbsmg4JC3XXHuO/WBeiSBGeYdDdo14YpWthPXdE8+l+MvGBx9iC20tfbB1Ltw8O36LLBmUY3reYmVbLYAF/g7ITjpKoHkLRkaMScSbFHq2XI6sHDBBgDFyLUUBC1HELJrL3Lhg/Dp8j1aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A+6oqQ/I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6XLjaJc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A+6oqQ/I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6XLjaJc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A7241D001DB;
	Fri, 10 Apr 2026 08:13:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 08:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823191;
	 x=1775909591; bh=T/LL3tWuJ0zaUL9ktHv7+6PfGLhKt2yaBWME7cqjpDg=; b=
	A+6oqQ/IvztTZ2fZFdOZhTwi9QcTXRNVIAZaCp0w1X2rDe3GPqenZl8WAgspDoMO
	5chqXDzxXIB8Mg0CpTimr5+1S7gU6KRTK9GIMaTuJE1u3Yd4HCV5Tl+wAcwjnfKT
	QWVSVvRb2PeUw7nvY8tbFk3WFk0rdkcFLsWtVVXn0kw2kSHWoL/T6USkhhCMu/YK
	BUtLVGVT5jUobK8ss27tM/Hy6DB/wNYFYhRIYngYTbfRWHXUcQJiszYKS5JJH6sn
	CHpBtliRYwVJ7MVdV8IT6IvyHezI8W7cOMwlwd96U1CS0v/PWkhWTeMPCOeuu8lT
	EQaHyIgg66hyHCtuqzJRhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823191; x=
	1775909591; bh=T/LL3tWuJ0zaUL9ktHv7+6PfGLhKt2yaBWME7cqjpDg=; b=E
	6XLjaJcr1/fUScB4jMnLyJNTz/Za5dFZwL59ou8WVXscUROa3MddzpT8khlQcGUg
	vI5Qj6dzT9IDVczoqdwIo+NwwSdnMvVnjn/iibaLVl5ZxIuZDn6PNzLnaZOTgWEh
	MwgvJsWh5HdrkrbCx6rXP9h5zMc2ZrvrRcf9uDZLH8YfBpIdCA3Rlu3rp8hVXCTm
	pc/SkU8Dm15VG49500wGrB2CvHS2oJjYwk4dllPVMVfAVpMLHDwRYJPsb6KBlaaa
	Eg93xcDYnmuckx85g4hd825p6YaRChrW9jwHEYq4pb1GjMt2zXWAw3spLyXT+8/D
	kY9z48E/VUS4IMYXkCA5A==
X-ME-Sender: <xms:V-nYacavad0m3_bu3lOkB5lZS2WzlDQCf9Q6MA85tPMMLmKPTVAbzw>
    <xme:V-nYae2yRapCEoKJaRMiznrqxbNu5fBqNiDkWy1SpOxH8ukQjXC6Oa7N5Lao5-CDk
    __1V1OjAPUE7ZMe161Pz5F46Kq9x4bzCh68OR-iYciW69PKAt_2zjo>
X-ME-Received: <xmr:V-nYaUUlaMuk15c13w58MIBqJhmhBJnv-PHLvWdxF6SLUGNx5nPm4ind_xw0uT_sL_Ukmi1n7aEKkkEa_HorzyIKU7h5R9ZEdaN2fT9EhmviRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:V-nYaQVgOkeqP7VAwr9qsCOomwEXNDzZVDZI2KuAvZyG7x42Xo-3Wg>
    <xmx:V-nYabfbHAtNLo-DlMKLbB9VYtgBWoXWpTjnXnXHKj3b6ViOXfTw5w>
    <xmx:V-nYaRV49fHuAymLHHSelDZycpYRO2NPP0x9R5_pOuLSw8rVm82gPA>
    <xmx:V-nYaccIluYxISZBZteoM-3KuSMw3Y6qrFIjkhCxPrkH_59Hfg1KUQ>
    <xmx:V-nYaW1naqhG-0wyz8pKHMSNgrWD6GiZhY6ijFBn9Ll43k2bDWIj-KzC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ea0b36e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:39 +0200
Subject: [PATCH v3 09/17] oidtree: add ability to store data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-9-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

The oidtree data structure is currently only used to store object IDs,
without any associated data. So consequently, it can only really be used
to track which object IDs exist, and we can use the tree structure to
efficiently operate on OID prefixes.

But there are valid use cases where we want to both:

  - Store object IDs in a sorted order.

  - Associated arbitrary data with them.

Refactor the oidtree interface so that it allows us to store arbitrary
payloads within the respective nodes. This will be used in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c                  |  2 +-
 object-file.c            |  3 ++-
 oidtree.c                | 37 ++++++++++++++++++++++++++++++++-----
 oidtree.h                | 12 ++++++++++--
 t/unit-tests/u-oidtree.c | 26 +++++++++++++++++++++++---
 5 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/loose.c b/loose.c
index 07333be696..f7a3dd1a72 100644
--- a/loose.c
+++ b/loose.c
@@ -57,7 +57,7 @@ static int insert_loose_map(struct odb_source *source,
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(files->loose->cache, compat_oid);
+		oidtree_insert(files->loose->cache, compat_oid, NULL);
 
 	return inserted;
 }
diff --git a/object-file.c b/object-file.c
index 3e70e5d668..d04ab57253 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1857,6 +1857,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 }
 
 static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
+					       void *node_data UNUSED,
 					       void *cb_data)
 {
 	struct for_each_object_wrapper_data *data = cb_data;
@@ -2002,7 +2003,7 @@ static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
 			       void *data)
 {
-	oidtree_insert(data, oid);
+	oidtree_insert(data, oid, NULL);
 	return 0;
 }
 
diff --git a/oidtree.c b/oidtree.c
index 117649753f..e43f18026e 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -9,6 +9,7 @@
 struct oidtree_node {
 	struct cb_node base;
 	struct object_id key;
+	void *data;
 };
 
 void oidtree_init(struct oidtree *ot)
@@ -25,15 +26,22 @@ void oidtree_clear(struct oidtree *ot)
 	}
 }
 
-void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
+struct oidtree_data {
+	struct object_id oid;
+};
+
+void oidtree_insert(struct oidtree *ot, const struct object_id *oid,
+		    void *data)
 {
 	struct oidtree_node *on;
+	struct cb_node *node;
 
 	if (!oid->algo)
 		BUG("oidtree_insert requires oid->algo");
 
 	on = mem_pool_alloc(&ot->mem_pool, sizeof(*on));
 	oidcpy(&on->key, oid);
+	on->data = data;
 
 	/*
 	 * n.b. Current callers won't get us duplicates, here.  If a
@@ -41,13 +49,19 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 	 * that won't be freed until oidtree_clear.  Currently it's not
 	 * worth maintaining a free list
 	 */
-	cb_insert(&ot->tree, &on->base, sizeof(*oid));
+	node = cb_insert(&ot->tree, &on->base, sizeof(*oid));
+	if (node) {
+		struct oidtree_node *preexisting = container_of(node, struct oidtree_node, base);
+		preexisting->data = data;
+	}
 }
 
-bool oidtree_contains(struct oidtree *ot, const struct object_id *oid)
+static struct oidtree_node *oidtree_lookup(struct oidtree *ot,
+					   const struct object_id *oid)
 {
 	struct object_id k;
 	size_t klen = sizeof(k);
+	struct cb_node *node;
 
 	oidcpy(&k, oid);
 
@@ -58,7 +72,20 @@ bool oidtree_contains(struct oidtree *ot, const struct object_id *oid)
 	klen += BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, hash) <
 				offsetof(struct object_id, algo));
 
-	return !!cb_lookup(&ot->tree, (const uint8_t *)&k, klen);
+	node = cb_lookup(&ot->tree, (const uint8_t *)&k, klen);
+	return node ? container_of(node, struct oidtree_node, base) : NULL;
+}
+
+bool oidtree_contains(struct oidtree *ot, const struct object_id *oid)
+{
+	struct oidtree_node *node = oidtree_lookup(ot, oid);
+	return node ? 1 : 0;
+}
+
+void *oidtree_get(struct oidtree *ot, const struct object_id *oid)
+{
+	struct oidtree_node *node = oidtree_lookup(ot, oid);
+	return node ? node->data : NULL;
 }
 
 struct oidtree_each_data {
@@ -82,7 +109,7 @@ static int iter(struct cb_node *n, void *cb_data)
 			return 0;
 	}
 
-	return data->cb(&node->key, data->cb_data);
+	return data->cb(&node->key, node->data, data->cb_data);
 }
 
 int oidtree_each(struct oidtree *ot, const struct object_id *prefix,
diff --git a/oidtree.h b/oidtree.h
index 2b7bad2e60..baa5a436ea 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -29,18 +29,26 @@ void oidtree_init(struct oidtree *ot);
  */
 void oidtree_clear(struct oidtree *ot);
 
-/* Insert the object ID into the tree. */
-void oidtree_insert(struct oidtree *ot, const struct object_id *oid);
+/*
+ * Insert the object ID into the tree and store the given pointer alongside
+ * with it. The data pointer of any preexisting entry will be overwritten.
+ */
+void oidtree_insert(struct oidtree *ot, const struct object_id *oid,
+		    void *data);
 
 /* Check whether the tree contains the given object ID. */
 bool oidtree_contains(struct oidtree *ot, const struct object_id *oid);
 
+/* Get the payload stored with the given object ID. */
+void *oidtree_get(struct oidtree *ot, const struct object_id *oid);
+
 /*
  * Callback function used for `oidtree_each()`. Returning a non-zero exit code
  * will cause iteration to stop. The exit code will be propagated to the caller
  * of `oidtree_each()`.
  */
 typedef int (*oidtree_each_cb)(const struct object_id *oid,
+			       void *node_data,
 			       void *cb_data);
 
 /*
diff --git a/t/unit-tests/u-oidtree.c b/t/unit-tests/u-oidtree.c
index d4d05c7dc3..f0d5ebb733 100644
--- a/t/unit-tests/u-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -19,7 +19,7 @@ static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
 	for (size_t i = 0; i < n; i++) {
 		struct object_id oid;
 		cl_parse_any_oid(hexes[i], &oid);
-		oidtree_insert(ot, &oid);
+		oidtree_insert(ot, &oid, NULL);
 	}
 	return 0;
 }
@@ -38,9 +38,9 @@ struct expected_hex_iter {
 	const char *query;
 };
 
-static int check_each_cb(const struct object_id *oid, void *data)
+static int check_each_cb(const struct object_id *oid, void *node_data UNUSED, void *cb_data)
 {
-	struct expected_hex_iter *hex_iter = data;
+	struct expected_hex_iter *hex_iter = cb_data;
 	struct object_id expected;
 
 	cl_assert(hex_iter->i < hex_iter->expected_hexes.nr);
@@ -105,3 +105,23 @@ void test_oidtree__each(void)
 	check_each(&ot, "32100", "321", NULL);
 	check_each(&ot, "32", "320", "321", NULL);
 }
+
+void test_oidtree__insert_overwrites_data(void)
+{
+	struct object_id oid;
+	struct oidtree ot;
+	int a, b;
+
+	cl_parse_any_oid("1", &oid);
+
+	oidtree_init(&ot);
+
+	oidtree_insert(&ot, &oid, NULL);
+	cl_assert_equal_p(oidtree_get(&ot, &oid), NULL);
+	oidtree_insert(&ot, &oid, &a);
+	cl_assert_equal_p(oidtree_get(&ot, &oid), &a);
+	oidtree_insert(&ot, &oid, &b);
+	cl_assert_equal_p(oidtree_get(&ot, &oid), &b);
+
+	oidtree_clear(&ot);
+}

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

