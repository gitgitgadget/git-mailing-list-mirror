Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B9374160
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196170; cv=none; b=RAlSZ0WoMyW0mOcvIvT+JrnExwl//196qkq/nNsmeDGtNvRbkUbtpHnbTSyAnkAiReci0+2BsqlzVBUcPBr7eaUbHYCt2eSDLBZoSySU5sdng+OXaOxKvWfH4zoXN4stvVaVfKyWi/LTUz5yJqZ8gfj0+vkUzg7AoZ7QzjtSYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196170; c=relaxed/simple;
	bh=d/1UPwSMtzaXXuN2HIw/gA5349rX2ZdE7bFyS02+4FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAKCv4doOvcuqPHoYeYUj1VGWESTUefG88VcJLzGONsYf3xHwzSYA0S4OyFQgyeWvFIZbV3mS/IjsDgD1ZN9QBuIK9NyxD5fBa1wviZPI5Q1JRc9M/maTTF/ozIxeFBK+u9rYl8Xc+l91GC3ZtzFt9kgq6W5sJgj8MBOv8uK4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VDKMyZms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZW3havp5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VDKMyZms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZW3havp5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E36E7A011C
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 02:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196160;
	 x=1775282560; bh=H52bsjg8mUNHDiTI5zvw9pGJx2bLn6JhYgegjNBnDiE=; b=
	VDKMyZmstI2YRnhgTd0Xfai9S+Qz8umjRFe8/W1ZJZ0IJX4mb9LSAMhwbskZu5d5
	FWcWQOj+n/f7CLVlxuetuiWF7yoeuayvKrgqe0CzmkQCVvMjwoSS3TbLY70fKdw4
	F3SWYruQS1jKSHuTAd+Od1YgG/cFz71SvjDPZCZXjsgck2rcV4cBPij/y16VRKVX
	k7CnSqp6uSYeEWiMDiP370hrlGhz778VkwYFK4XM/1Q1S1DQRHtCA6j+tFH0YhKe
	/8CXAswXjmh4V/ep4uZDK1B3gDrmBozw+ODS9xBe18P87h/9N/CjPLE9fwWczDXe
	9y2rhdrnQlNJwZpm3FHJSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196160; x=
	1775282560; bh=H52bsjg8mUNHDiTI5zvw9pGJx2bLn6JhYgegjNBnDiE=; b=Z
	W3havp5zI5XssGK9qEhJBo5j45mEZ5fnH+Mn6j/gE5CvVZgOYYE2u/cv18VUOzyA
	B9sVu+dLE7RbD16PIPLTjSEVKMDddbs0Qafv81/4CLChxYDavruQHEPwyiFn7zxT
	oIw52oW+HRO2PevGR+/7wcv5Eijgt8fs+4wAZMg27zHZghTA7rH4mWyFFZC7EaSa
	Iur58pxO1vNh+sig8UGnTFerGRe2WJ00yWsWy7o19ebepXqMdnpJmasqtWUU8AHc
	6Zh/O5nOrwMsGjLQt3yirQbh9K3/W9InFtGOF+iEnZZF/ItuIVq677SKsDZDDLBF
	Ras/2wjoSKI5qOXBKoKHg==
X-ME-Sender: <xms:AFjPaRvRUWeWx96i0s9gXWLocJ19Jjm29Eu77OX0iAlFSbEn58bSMg>
    <xme:AFjPaRZfOFXWEJ35Po5irkLD0cWhD7VCHyzm6lgAhZhPkIe9gRWoDEwFMtQs9XRUu
    iWAJpkoOlVnuhYpj4_DpXd-stj2RzHGE7L7Hjye8j2zvtECvSu2uw>
X-ME-Received: <xmr:AFjPaaar2CZFzeB6ig7klEIdpj7av86HZ-nyI0q2ddKlIZCbK3SLGzSNpYT07vATC4EtX6eEFs9NWp07LqM1iaArS8jf-ZUcABX_iy49fiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:AFjPadW69c3qwXbi1m7ndzvv9bcV52h12mba2nPNsqYRCBfYFYJ8Ow>
    <xmx:AFjPaR3g_AqsmMHHbuKqMmXo8s7_z_mkm_XRVx5mE4EnbYqTXfP--A>
    <xmx:AFjPaUZnbGGj7uxMFheXoRcnxc40bUBX_I53GzagITxeZoJrMf7u9g>
    <xmx:AFjPaUrmd9d7LlLbOTh8sbQ1ddYtuhJ2ATqNmhbuoi6w7petUxA4tA>
    <xmx:AFjPaYdpUiEytvPwIoI17jueatame3jGbOYv3G_i0HICL5g8IC9Wzop5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 663c088d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:56 +0200
Subject: [PATCH 09/16] oidtree: add ability to store data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-9-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 98a4678ca4..c0805f0ebb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1850,6 +1850,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 }
 
 static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
+					       void *node_data UNUSED,
 					       void *cb_data)
 {
 	struct for_each_object_wrapper_data *data = cb_data;
@@ -1995,7 +1996,7 @@ static int append_loose_object(const struct object_id *oid,
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
2.53.0.1323.g189a785ab5.dirty

