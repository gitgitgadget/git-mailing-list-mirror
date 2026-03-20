Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE33359A69
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990469; cv=none; b=L8W1MPYCtPAYVv7o+Ne/aE053qYSHioKn5cQk6Ekm9MBzH7ukZ21cT3UYNYAuyKhVayHsU5Uzlz+X5CIncH9447XIDtghoAc/tGhVD5ffU3G0jxLqymIOLfjo5Z5ruvs1gorJ1bcEFjbVrEnwTPyPABemTX8oPl6giG+wB3OswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990469; c=relaxed/simple;
	bh=t9J94g/rqyobdoawDgvrs0pzBPsbgTUJZAy2CP9TP5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZOl6xgk0XOcJybYfhQ76zJqXxJLQr+5hF5iSboxttLpWf0O9meaWDxN2p8hx1tknmTznVC0WN1Ohmir12xhs3114B9vgwgJ+4J4uuWtxUte6Wm/DFFdK7DGLR96pZqJfoJAWau2zYBKi4FT0v40F6h4moEN3ob/NirzXK2REag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MYkiSjag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=er6cxWSu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MYkiSjag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="er6cxWSu"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D8E1EC014C;
	Fri, 20 Mar 2026 03:07:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 20 Mar 2026 03:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990467;
	 x=1774076867; bh=LfgyrMwZSstwumdb7z+P9dRC/rQQXpPgj03bX8TPI2U=; b=
	MYkiSjagJmUPonkxZOSxYgStFYRCwyAHv41+RH/kgJ/kZYGpD/P68gx8ExDFe9oX
	j/hqp/CfmBlxDsWBrEzm6qmwDA3i976jHOKxMs1jRLfqlqgyHhSsQEo5UpGYG2li
	IboEHTe3Z+Bmfu+WfSO6dCz8lCuesMx+OrY/QoVuyHx2KbhUqabWBOCXyR2S+/4R
	WQplUtTB63lBQrpU0EyMVUeRCUckp5hyLxdll9jQ6wJ4N+8zw2oN2qhaS0WpmRzZ
	oaXBqvMyomy9BGllITCoIyiM0FIhQfoL/eH6SYHdPXePWKi9hw9NC5VdKbwDAiwW
	H7EqcdhLewMHKcdWY8qCgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990467; x=
	1774076867; bh=LfgyrMwZSstwumdb7z+P9dRC/rQQXpPgj03bX8TPI2U=; b=e
	r6cxWSuJDQMi9ssRi5kTfMrL/98gpimUZNw0BV09KurgduPvfdS/UrOXCGADHqRa
	EMTSCLpCgBVk0JGulf2BhXbPPb6KXYfjVGJG7C8FU5KSczvwLKWSx9pZx6cg0kkb
	t/SuvTGthiTP01zqXckJ+IBj76RPQDDdiKDFX6KvKD2c446X4I9A7p2sfyWbfiPb
	+GXpYYqVfsmI3nYteIymdGGtpCC812oHoWbIEttytF68Fz+5Ubkyl5HpURrF/NCl
	k+I4r0uZ0KcCtC/f7fIX9cVg3d6fCIf0VKBbYSAQON1U1EPEDCdId72z5f46u2IQ
	N26piEVMlB/SGcRHEIrPQ==
X-ME-Sender: <xms:Q_K8aQI9Zkp2WaIRBx-a4fVaGGrZbzENhGDGUuuZU-KjiIpnCI5uhA>
    <xme:Q_K8aXm9ATQLq9JRICD4TmZoCGDGncvDpg0E2t6ZM31S1Jmg_HnD-hR9Xl6KJej1Q
    NhqIFqMjzwSB9FVl9f73WN9_Qg3kXqeMtl-kLPysDcQqmIIYCr7Lg>
X-ME-Received: <xmr:Q_K8aeFqAoOgiAe6RS5-fxu8FrCmJ1pHTTjuSeyycuLTGt9tAgGfEBa3F8VNxp_XOQRLRpu1lux5Awm7Nm3pnmtzC4SKJccdwu4QiV7GFXIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:Q_K8aXErRIIjlNSZUAvL_VafkO6fn5-QAyT0ij03GZAnkIY91ZIDYA>
    <xmx:Q_K8abOAmyp6V5iGVCKBc7A6dgg3E7Aq-rn26bvK5rt9Sfx0_ciNbg>
    <xmx:Q_K8aWEfbMMQ4E26PmcjNRRALYV18GiXVzTfGEd7lEVwuJdJPaEsYA>
    <xmx:Q_K8aSOMedL4rOmjc6DwG7Jto7VMWdBvy4ublSzO1OXWZ-JySYukYQ>
    <xmx:Q_K8afmYnPcvHvFLlKLyOrdz5dOdqxxF2OuBYLBIxKbKziZJNO6BkUn3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd8f9abf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:28 +0100
Subject: [PATCH v2 02/14] oidtree: extend iteration to allow for arbitrary
 return codes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-2-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The interface `cb_each()` iterates through a crit-bit tree and calls a
specific callback function for each of the contained items. The callback
function is expected to return either:

  - `CB_CONTINUE` in case iteration shall continue.

  - `CB_BREAK` to abort iteration.

This is needlessly restrictive though, as callers may want to return
arbitrary values and have them be bubbled up to the `cb_each()` call
site. In fact, this is a rather common pattern we have: whenever such a
callback function returns a non-zero error code, we abort iteration and
bubble up the code as-is.

Refactor both the crit-bit tree and oidtree subsystems to behave
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 cbtree.c                 | 21 ++++++++++++---------
 cbtree.h                 | 17 +++++++++--------
 object-name.c            |  4 ++--
 oidtree.c                | 12 ++++++------
 oidtree.h                | 18 ++++++++++++------
 t/unit-tests/u-oidtree.c |  4 ++--
 6 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/cbtree.c b/cbtree.c
index cf8cf75b89..4ab794bddc 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -96,26 +96,28 @@ struct cb_node *cb_lookup(struct cb_tree *t, const uint8_t *k, size_t klen)
 	return p && !memcmp(p->k, k, klen) ? p : NULL;
 }
 
-static enum cb_next cb_descend(struct cb_node *p, cb_iter fn, void *arg)
+static int cb_descend(struct cb_node *p, cb_iter fn, void *arg)
 {
 	if (1 & (uintptr_t)p) {
 		struct cb_node *q = cb_node_of(p);
-		enum cb_next n = cb_descend(q->child[0], fn, arg);
-
-		return n == CB_BREAK ? n : cb_descend(q->child[1], fn, arg);
+		int ret = cb_descend(q->child[0], fn, arg);
+		if (ret)
+			return ret;
+		return cb_descend(q->child[1], fn, arg);
 	} else {
 		return fn(p, arg);
 	}
 }
 
-void cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
-			cb_iter fn, void *arg)
+int cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
+	    cb_iter fn, void *arg)
 {
 	struct cb_node *p = t->root;
 	struct cb_node *top = p;
 	size_t i = 0;
 
-	if (!p) return; /* empty tree */
+	if (!p)
+		return 0; /* empty tree */
 
 	/* Walk tree, maintaining top pointer */
 	while (1 & (uintptr_t)p) {
@@ -130,7 +132,8 @@ void cb_each(struct cb_tree *t, const uint8_t *kpfx, size_t klen,
 
 	for (i = 0; i < klen; i++) {
 		if (p->k[i] != kpfx[i])
-			return; /* "best" match failed */
+			return 0; /* "best" match failed */
 	}
-	cb_descend(top, fn, arg);
+
+	return cb_descend(top, fn, arg);
 }
diff --git a/cbtree.h b/cbtree.h
index 43193abdda..c374b1b3db 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -30,11 +30,6 @@ struct cb_tree {
 	struct cb_node *root;
 };
 
-enum cb_next {
-	CB_CONTINUE = 0,
-	CB_BREAK = 1
-};
-
 #define CBTREE_INIT { 0 }
 
 static inline void cb_init(struct cb_tree *t)
@@ -46,9 +41,15 @@ static inline void cb_init(struct cb_tree *t)
 struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
 struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
 
-typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
+/*
+ * Callback invoked by `cb_each()` for each node in the critbit tree. A return
+ * value of 0 will cause the iteration to continue, a non-zero return code will
+ * cause iteration to abort. The error code will be relayed back from
+ * `cb_each()` in that case.
+ */
+typedef int (*cb_iter)(struct cb_node *, void *arg);
 
-void cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
-		cb_iter, void *arg);
+int cb_each(struct cb_tree *, const uint8_t *kpfx, size_t klen,
+	    cb_iter, void *arg);
 
 #endif /* CBTREE_H */
diff --git a/object-name.c b/object-name.c
index e5adec4c9d..a24a1b48e1 100644
--- a/object-name.c
+++ b/object-name.c
@@ -103,12 +103,12 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 
 static int match_hash(unsigned, const unsigned char *, const unsigned char *);
 
-static enum cb_next match_prefix(const struct object_id *oid, void *arg)
+static int match_prefix(const struct object_id *oid, void *arg)
 {
 	struct disambiguate_state *ds = arg;
 	/* no need to call match_hash, oidtree_each did prefix match */
 	update_candidates(ds, oid);
-	return ds->ambiguous ? CB_BREAK : CB_CONTINUE;
+	return ds->ambiguous;
 }
 
 static void find_short_object_filename(struct disambiguate_state *ds)
diff --git a/oidtree.c b/oidtree.c
index a4d10cd429..ab9fe7ec7a 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -71,7 +71,7 @@ struct oidtree_each_data {
 	uint8_t last_byte;
 };
 
-static enum cb_next iter(struct cb_node *n, void *cb_data)
+static int iter(struct cb_node *n, void *cb_data)
 {
 	struct oidtree_each_data *data = cb_data;
 	struct object_id k;
@@ -80,18 +80,18 @@ static enum cb_next iter(struct cb_node *n, void *cb_data)
 	memcpy(&k, n->k, sizeof(k));
 
 	if (data->algo != GIT_HASH_UNKNOWN && data->algo != k.algo)
-		return CB_CONTINUE;
+		return 0;
 
 	if (data->last_nibble_at) {
 		if ((k.hash[*data->last_nibble_at] ^ data->last_byte) & 0xf0)
-			return CB_CONTINUE;
+			return 0;
 	}
 
 	return data->cb(&k, data->cb_data);
 }
 
-void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
-		  size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
+int oidtree_each(struct oidtree *ot, const struct object_id *prefix,
+		 size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
 {
 	struct oidtree_each_data data = {
 		.cb = cb,
@@ -106,5 +106,5 @@ void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
 		data.last_nibble_at = &klen;
 	}
 
-	cb_each(&ot->tree, prefix->hash, klen, iter, &data);
+	return cb_each(&ot->tree, prefix->hash, klen, iter, &data);
 }
diff --git a/oidtree.h b/oidtree.h
index 0651401017..2b7bad2e60 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -35,16 +35,22 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid);
 /* Check whether the tree contains the given object ID. */
 bool oidtree_contains(struct oidtree *ot, const struct object_id *oid);
 
-/* Callback function used for `oidtree_each()`. */
-typedef enum cb_next (*oidtree_each_cb)(const struct object_id *oid,
-					void *cb_data);
+/*
+ * Callback function used for `oidtree_each()`. Returning a non-zero exit code
+ * will cause iteration to stop. The exit code will be propagated to the caller
+ * of `oidtree_each()`.
+ */
+typedef int (*oidtree_each_cb)(const struct object_id *oid,
+			       void *cb_data);
 
 /*
  * Iterate through all object IDs in the tree whose prefix matches the given
  * object ID prefix and invoke the callback function on each of them.
+ *
+ * Returns any non-zero exit code from the provided callback function.
  */
-void oidtree_each(struct oidtree *ot,
-		  const struct object_id *prefix, size_t prefix_hex_len,
-		  oidtree_each_cb cb, void *cb_data);
+int oidtree_each(struct oidtree *ot,
+		 const struct object_id *prefix, size_t prefix_hex_len,
+		 oidtree_each_cb cb, void *cb_data);
 
 #endif /* OIDTREE_H */
diff --git a/t/unit-tests/u-oidtree.c b/t/unit-tests/u-oidtree.c
index def47c6795..d4d05c7dc3 100644
--- a/t/unit-tests/u-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -38,7 +38,7 @@ struct expected_hex_iter {
 	const char *query;
 };
 
-static enum cb_next check_each_cb(const struct object_id *oid, void *data)
+static int check_each_cb(const struct object_id *oid, void *data)
 {
 	struct expected_hex_iter *hex_iter = data;
 	struct object_id expected;
@@ -49,7 +49,7 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
 			 &expected);
 	cl_assert_equal_s(oid_to_hex(oid), oid_to_hex(&expected));
 	hex_iter->i += 1;
-	return CB_CONTINUE;
+	return 0;
 }
 
 LAST_ARG_MUST_BE_NULL

-- 
2.53.0.1055.ga2ffed1127.dirty

