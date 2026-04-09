Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D36282F1E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719500; cv=none; b=Rlg8BpwGisdnBPsv/pM4CSwWx27kf6/cN8Z5fXG0+mJrbc5j6kbppb0wBhu+2UKE2HGk3fYtrhOvqg6YHI6rs353YGYLcKCRZBiuIgB6/IHgjrSGkxpWhx2rnK87LvqhCppPPXKrevyFeEzGjdpu4VgEBGgjKqKlTYk7SfS1n4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719500; c=relaxed/simple;
	bh=KlH/UqKEu25jeFeM8nmsx6+XD32PDlA0Mv7hDhQbZIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I7Ml+EKXyuq7cEymamE84ne2oGXHmHi3C6CQD1++sI+I+UdRaISN5EQAzwIiHfddta0IKMYEkRvj0RFQdFMpeI2o/C9T03fDR8b/D65g3ui7s5W1p59eFGoKSUhWPGuDGrNrq0L1UM2iNTMSn53Cpnlvxd4EmLnFBdJQDJXrJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yBV0XaaI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nz3TtgXv; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yBV0XaaI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nz3TtgXv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09EDF1400271;
	Thu,  9 Apr 2026 03:24:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 03:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719498;
	 x=1775805898; bh=eH8M7hiyCfsKo338u1zKmq+/Hgx2CCmnloxiyTYrfgY=; b=
	yBV0XaaIhxoTxyicRDtdZWBcJvwvEVXJ4VqSYg1YpHx2/SmfhI7xjwtz7fDDqJ56
	jN/NYAY6H9ZzaqV+nB74PWLIu7avFo8Ig0//OrDnOQDN7FY/E9KC6QQpWj8CtQsf
	V55vl9koL31wnWA4YhKvJSvXspA799DehmmKFb39vkJ+E0u308o0fIk+fM5EphmR
	usJvz5bIOorhKZIfrmJuxX52Mf20k7UFsZC04ManzNyplKD8omoNS/gM9UgKsm/H
	oc5ILoMqtlzv+gJtixKOX7yJT7AuZaOEDvQYRWSYsgn0x0l/zVsfoMV1QEu7w4L+
	KY5Rv/cStNdVpEw1ppfdGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719498; x=
	1775805898; bh=eH8M7hiyCfsKo338u1zKmq+/Hgx2CCmnloxiyTYrfgY=; b=n
	z3TtgXvaHeSwc6efIKff/A/2LW+CixTRyGouJgUbLt7GJJJUhJWTOb8aogSAing6
	LY+7qwqvDuIcAivyqGJy0gX3hxC/LuMU72KZOATY//NL9G7qY9eileZeZlwWnWbR
	hzGvgV1kmYkqWt/QIWaLH1lfAC392Q5UKoVgHbPLSqDFhJCnhUP2ap1ex2+uobeY
	3cymSNkWxv6w8Tv0yowdNDv5KpX5MrTOCkPOBxBVNHEZahY8ec5yy4wHNFQ1NXIL
	wApkKgu2+NN5EfP4jFeybKBEtl6lxfWazR28GQJ6pzuEIqgGwa0dpOrOd6wTqH17
	y6mBJ1J5A/twFtdXsXz1g==
X-ME-Sender: <xms:SVTXaZepLouJWPF_bToDNHMM51u1pWRmqu6xeKVdduzsI8JlItcpWQ>
    <xme:SVTXaerWQSo2wDO4ld0N1xP1M8Xv3TVmOk5y6sgdZct-pJVgLrWJvSTsnDavBd3oA
    KHSRvw4adRkwIh0yrnEwGVz9gzMxKsVEVh9H9qD0MqsaLP05U-Yow>
X-ME-Received: <xmr:SVTXaf7FVGUf-eM9vLsdZbQ7yEVM12aeQbM-8e54ZcAfdxwu7CZsBc-BgVu9IQ43XdTOH-2dxMQ7e40gyYwFxk7gogzB9FUgZiy9KuKW-Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:SVTXacoE7QFSxlZC6W1B5Y_gn2y838r9QR2YAeEe-Fc-mQ-qHOOXgw>
    <xmx:SVTXaZgB0sTu8JuEutbUOuZdCxW6_Ma3QFnxeyRTW37kVpHMEdwrpg>
    <xmx:SVTXaeK-is3n6jBYBwfOt53afYZxCQuo5pfpIWx8BzPZ1_2ADE5_CQ>
    <xmx:SVTXaRBcvY2eFUy4Q5ACNx1Fc3qutQjlGEcRJ35DHlhAoMxHlHlDLg>
    <xmx:SlTXaaqJX_PUxGPI2vJJ6kzppgdct8UpkTNZSDw8fNKMVjPZK-8363X0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ac67606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:31 +0200
Subject: [PATCH v2 10/17] oidtree: add ability to store data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-10-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
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
2.54.0.rc0.680.geaeac8ef83.dirty

