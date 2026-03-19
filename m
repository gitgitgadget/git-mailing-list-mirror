Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9CD3815D1
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903193; cv=none; b=Z0C300EawmH3iqYl+nP7QzQ7efASKHtOuprC3Bp5wq+5Y7ArZoEyghpH7FvjxWzSQL4Rws7hEdoFBbf6/9Fdb2g4fUf6sbZmDfUlWiu6pGBFwlqS0XZKGskBnuNop+Z1jvswJS/eh1npaPIc8DpLNucHBLnnZtBKWKD8W8QLZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903193; c=relaxed/simple;
	bh=DU+FSc98Xy/FhMPrhoSLBr+gP2/FUKhd120YKuebAEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P2yPBtH3hHAhBb0yV+7W+qBWgNOF1I2HrjmtjezNNVKn8Cz+EpyWOA8n1kw9OwQah5OlfTklxcEXLNWQTXpGK7Gni8jcYgT4VIToNwuId/YV6mQDLWwump740k3mGkv7/oaVqNJ9izuIAavuTOumEDC5ev1GEBxj+hfIGrCHoF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LOv15ZXT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rhoNTael; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LOv15ZXT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rhoNTael"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 86812EC0274
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 02:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903190;
	 x=1773989590; bh=1m0zRMbFVkNV0RYrSSeySzfz6dedVlz6OqvDS5Fs/tQ=; b=
	LOv15ZXT4R3AL/4Z1EYL1l9Sjm8LX/M0RRqnBIbsEzK7/x3UOzb159xIeg9XrjWo
	aFNDFB8/3JHob11L3k1FpM5RYoAK8xh3jG5cJ76VX5TgYF6LW5G/LrF0bwf0JeL/
	OfBsMCK7VWVeVHx8JWWVfEeFJ808rTsqo7WrA2+5Bw9JSUVM0d//FciZV7qc9SAL
	4pIOwajV5FS2r0gxWRsJjMIufn0clsUf+7nDQ9HeRZwDuTDuJV3YM9YGxmv6vTYJ
	u7R6c77ORcQUiPaMpF0yunkUvkk8MlEhSkOlh84rBAkl9VeRYBcdRy59BInVRTEh
	7TiHexpKdttffHzo0uEbSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903190; x=
	1773989590; bh=1m0zRMbFVkNV0RYrSSeySzfz6dedVlz6OqvDS5Fs/tQ=; b=r
	hoNTaelrMnWZN99wIWaVGa9sEnZVJAtuZUr+i2ncUkw9RBMbzSNAlD8iIBPC9PRs
	SUp/XJazrn5HA0C9YugXhIjRBjOalLbRP8qzrYyn0x9q16Z3ccug90iuQN47Y6av
	+ihnAcIhpHAPCWCbT0ol6D46pxoxpSeF/HuXy1JuD6l5RlICee4xrUFwBLq20uNE
	W33vULP6QLn5foiPjBUu3YgYb/yMOUY6cy5sGuY4/zvQcbZqFJtf+E0XLVid2Jk4
	eLN3YPQG0A4ZPPFD3vcuGBeMb+0Qg2xC1hShZ4KFjBtx3reWSXPPnDtZWA2cQLgj
	m5LGSDpm7bIworb+64L3A==
X-ME-Sender: <xms:Vp27aQlaDZT9KYBGro99g5ZuJxUQRsEVAdldSbgLDgew9aRAA7-8mA>
    <xme:Vp27aWyAf32vPsFjKeUxwskxlqAgpMbTkVfLpSOk6sme7XyhXSoMticTtRFnGXtDo
    R9lbeVD6UmPykN0AhQO3KhhQi1YL6MBNSUrCcVKST0MKeWsRZes_A>
X-ME-Received: <xmr:Vp27aUQhXYTd8HTf6u3EdbCPohrIXZ5jHlb8HzZ0RtucpbzmUQozicenUDn9E8C_bRP-0_epHOXNnDl3MO54nixXNz8uR6i_nGHriNm1fLQq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Vp27aRvDrxLxhzR_xNhng4B_B5kxQj32QVCaJEwdPlH9LXfscq-SZA>
    <xmx:Vp27aetJKca1nBUcoqnoY5qCUevWt-rolpr2x6ApAmyQ4u86ya9NRQ>
    <xmx:Vp27afyHTCgTkb_4Yu9XbAx_7KdnPim-C_N0MXyDqGYdmzz7Adtwow>
    <xmx:Vp27achXEd68AlcyVAoXymPDDPeiNvA93uXQgo_3XTphy-gCBYUnGg>
    <xmx:Vp27aU0PVwgHr6LKc-DKcgEVpaMHycge6x_yaXJZcKQsdlnnd8bwsN7m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa8fcde1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:00 +0100
Subject: [PATCH 02/14] oidtree: extend iteration to allow for arbitrary
 return codes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-2-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
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
 cbtree.h                 | 11 +++--------
 object-name.c            |  4 ++--
 oidtree.c                | 12 ++++++------
 oidtree.h                | 18 ++++++++++++------
 t/unit-tests/u-oidtree.c |  4 ++--
 6 files changed, 37 insertions(+), 33 deletions(-)

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
index 43193abdda..4f644d6e45 100644
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
@@ -46,9 +41,9 @@ static inline void cb_init(struct cb_tree *t)
 struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
 struct cb_node *cb_insert(struct cb_tree *, struct cb_node *, size_t klen);
 
-typedef enum cb_next (*cb_iter)(struct cb_node *, void *arg);
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

