Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52173624D7
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903190; cv=none; b=Ffzvn8kAna/c2G5FMDoWhnkQIrKn6E/fZbw+UiXDRiUNDevC4Z7BtJAsjVo5wm4citXZPdV9CMpKt6+xFos432DrMD7fWl89fi+QgWmXeIMZC1FNuIPybz5H65+J2YXrp+jMDHFRc7hP4PcNuZ7VyiZKxz9jYN3FxsXoUfqbpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903190; c=relaxed/simple;
	bh=UyWlRvF5gSA3OBwt3Gvt3ltdOfViRoVRA5ApvVm7wd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gti3gMcMnlegrJaYeLeSRFvf9Oy7XicMgafa4ilqOpByeuvYAJn2oDWs+BG/Pg38XTNtQftIeQpRyZ5lS5ATOpWoMch1sUadwvmbHb3bFPXrtako4kipOtSULd4Y1cG9paBJy6vCErjPjz3iJMO65Ref33P0ckHrzXpbMcPwWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PEGoSedi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hh85Ylre; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PEGoSedi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hh85Ylre"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFAFD1400223
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 02:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903187;
	 x=1773989587; bh=sNbK6Vt7xbmeBEFtIMM0g88zDqR3BPtN5Y011gVpeFs=; b=
	PEGoSedipl1/wkRtmikxNw6d810h8LJsMUV3adFyXta14tiwO2eYm8fHIc1eDL/f
	IRjIvueMpzmNj0zWwZtYJYPLFoxuOa/EWVNn7qi4ZKhnZDP5ca0dCvsfxeJ7YWJr
	jE+605MwMjLuV0YntNms2lqKDUL3ezaQMm4W/I+RAQjQM4CId5yIIZjbUSOQ6a6e
	VuGQE0vmUkdJ89abRtRFhV6mLnhIq4caBenukGvxfvVSVpfBl/zZLEQC8TXH2k/h
	xdMsOpswbueN4mksbuitc0JqevJg+NOV9U5DC/uutfiXRpiV4X9vng2YwJz1iUnq
	ze6Uq//BnfYuDNU2zL0JPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903187; x=
	1773989587; bh=sNbK6Vt7xbmeBEFtIMM0g88zDqR3BPtN5Y011gVpeFs=; b=H
	h85YlreTKiFDfKU7bRB08N+hqtISLRvJSREhLhE0t9mWz7ET+80YJBifBcJXAAnn
	jvUo4F0ayV1aIjeRElhY2Of+KCZdoWPctoEcbD3D75ZWz/VKgHgwVrJaDlM6jizE
	vylaU4tdKefVK7NjMmy0B3+7FiOk2EDTeJP2c7x3/Q5ijpVf38OaokMwrAmiGlMW
	Vyvstj57aXwiqhn/lxSs/VoX6w6P51ji7AlWWXkOUfXrnUgwqPo4lLx8QqRGvZga
	2W4+RW1qQJV9Ow4yp2XP3DTO6YssaVvhFX79MbfHoeFifR97eCmdlnlcpDcU2Zui
	he3kvET5oU8bJCHq0P85g==
X-ME-Sender: <xms:U527ac090cNTHWttMVd4TUZPH-FzPdh3-SyYMzBwzQcctVA__MFvag>
    <xme:U527aeCSOcNGENGdVXMEuu_JoymaXJaYZ2KXqjqQk7_nUzqKLPbcgnnMrzr94pY1x
    yKNcoIPvDF5SdXFsX_PGJMFpxpTNylaQzakzyoYxgC0RhbiI4mO8A>
X-ME-Received: <xmr:U527aag0G_yHO77jHiQNKWZXdgir8DsnIeILBZ1vZDRsy0oBhvIx8pC4Zx2kGGaaSMKnOG1sxCAakD5vW16AY-LLvPDz0MY3waQOGSTBnnEO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:U527aa_cOWyy41B3xpPDlZMPNTY0eD1LlAktctwcpfb0rH8kLiGgCA>
    <xmx:U527ae8lYeW9WOR42i_R3DpvhPqAjux9TWs9yCGU9nQYpe3cV3RzaQ>
    <xmx:U527abDNcO7ZgPFeUC_3qdDMapUtukeqMn8765Dfyf5d4psadp2w4Q>
    <xmx:U527aWy9EiyRis2naBrWkGsL6Z3e2oXebgOOqZH2_Dr3dfbtgwdL_g>
    <xmx:U527aeG1qu-m6tCq8rmp4XPGKm5b87dQ-FcB0rwpEldRdyBKHzgqnB9V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17290009 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:52:59 +0100
Subject: [PATCH 01/14] oidtree: modernize the code a bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-1-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "oidtree.c" subsystem is rather small and self-contained and tends
to just work. It thus doesn't typically receive a lot of attention,
which has as a consequence that it's coding style is somewhat dated
nowadays.

Modernize the style of this subsystem a bit:

  - Rename the `oidtree_iter()` function to `oidtree_each_cb()`.

  - Rename `struct oidtree_iter_data` to `struct oidtree_each_data` to
    match the renamed callback function type.

  - Rename parameters and variables to clarify their intent.

  - Add comments that explain what some of the functions do.

  - Adapt the return value of `oidtree_contains()` to be a boolean.

This prepares for some changes to the subsystem that'll happen in the
next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 oidtree.c                | 61 ++++++++++++++++++++++++------------------------
 oidtree.h                | 42 +++++++++++++++++++++++++++------
 t/unit-tests/u-oidtree.c | 14 +++++------
 3 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/oidtree.c b/oidtree.c
index 324de94934..a4d10cd429 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -6,14 +6,6 @@
 #include "oidtree.h"
 #include "hash.h"
 
-struct oidtree_iter_data {
-	oidtree_iter fn;
-	void *arg;
-	size_t *last_nibble_at;
-	uint32_t algo;
-	uint8_t last_byte;
-};
-
 void oidtree_init(struct oidtree *ot)
 {
 	cb_init(&ot->tree);
@@ -54,8 +46,7 @@ void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
 	cb_insert(&ot->tree, on, sizeof(*oid));
 }
 
-
-int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
+bool oidtree_contains(struct oidtree *ot, const struct object_id *oid)
 {
 	struct object_id k;
 	size_t klen = sizeof(k);
@@ -69,41 +60,51 @@ int oidtree_contains(struct oidtree *ot, const struct object_id *oid)
 	klen += BUILD_ASSERT_OR_ZERO(offsetof(struct object_id, hash) <
 				offsetof(struct object_id, algo));
 
-	return cb_lookup(&ot->tree, (const uint8_t *)&k, klen) ? 1 : 0;
+	return !!cb_lookup(&ot->tree, (const uint8_t *)&k, klen);
 }
 
-static enum cb_next iter(struct cb_node *n, void *arg)
+struct oidtree_each_data {
+	oidtree_each_cb cb;
+	void *cb_data;
+	size_t *last_nibble_at;
+	uint32_t algo;
+	uint8_t last_byte;
+};
+
+static enum cb_next iter(struct cb_node *n, void *cb_data)
 {
-	struct oidtree_iter_data *x = arg;
+	struct oidtree_each_data *data = cb_data;
 	struct object_id k;
 
 	/* Copy to provide 4-byte alignment needed by struct object_id. */
 	memcpy(&k, n->k, sizeof(k));
 
-	if (x->algo != GIT_HASH_UNKNOWN && x->algo != k.algo)
+	if (data->algo != GIT_HASH_UNKNOWN && data->algo != k.algo)
 		return CB_CONTINUE;
 
-	if (x->last_nibble_at) {
-		if ((k.hash[*x->last_nibble_at] ^ x->last_byte) & 0xf0)
+	if (data->last_nibble_at) {
+		if ((k.hash[*data->last_nibble_at] ^ data->last_byte) & 0xf0)
 			return CB_CONTINUE;
 	}
 
-	return x->fn(&k, x->arg);
+	return data->cb(&k, data->cb_data);
 }
 
-void oidtree_each(struct oidtree *ot, const struct object_id *oid,
-			size_t oidhexsz, oidtree_iter fn, void *arg)
+void oidtree_each(struct oidtree *ot, const struct object_id *prefix,
+		  size_t prefix_hex_len, oidtree_each_cb cb, void *cb_data)
 {
-	size_t klen = oidhexsz / 2;
-	struct oidtree_iter_data x = { 0 };
-	assert(oidhexsz <= GIT_MAX_HEXSZ);
-
-	x.fn = fn;
-	x.arg = arg;
-	x.algo = oid->algo;
-	if (oidhexsz & 1) {
-		x.last_byte = oid->hash[klen];
-		x.last_nibble_at = &klen;
+	struct oidtree_each_data data = {
+		.cb = cb,
+		.cb_data = cb_data,
+		.algo = prefix->algo,
+	};
+	size_t klen = prefix_hex_len / 2;
+	assert(prefix_hex_len <= GIT_MAX_HEXSZ);
+
+	if (prefix_hex_len & 1) {
+		data.last_byte = prefix->hash[klen];
+		data.last_nibble_at = &klen;
 	}
-	cb_each(&ot->tree, (const uint8_t *)oid, klen, iter, &x);
+
+	cb_each(&ot->tree, prefix->hash, klen, iter, &data);
 }
diff --git a/oidtree.h b/oidtree.h
index 77898f510a..0651401017 100644
--- a/oidtree.h
+++ b/oidtree.h
@@ -5,18 +5,46 @@
 #include "hash.h"
 #include "mem-pool.h"
 
+/*
+ * OID trees are an efficient storage for object IDs that use a critbit tree
+ * internally. Common prefixes are duplicated and object IDs are stored in a
+ * way that allow easy iteration over the objects in lexicographic order. As a
+ * consequence, operations that want to enumerate all object IDs that match a
+ * given prefix can be answered efficiently.
+ *
+ * Note that it is not (yet) possible to store data other than the object IDs
+ * themselves in this tree.
+ */
 struct oidtree {
 	struct cb_tree tree;
 	struct mem_pool mem_pool;
 };
 
-void oidtree_init(struct oidtree *);
-void oidtree_clear(struct oidtree *);
-void oidtree_insert(struct oidtree *, const struct object_id *);
-int oidtree_contains(struct oidtree *, const struct object_id *);
+/* Initialize the oidtree so that it is ready for use. */
+void oidtree_init(struct oidtree *ot);
 
-typedef enum cb_next (*oidtree_iter)(const struct object_id *, void *data);
-void oidtree_each(struct oidtree *, const struct object_id *,
-			size_t oidhexsz, oidtree_iter, void *data);
+/*
+ * Release all memory associated with the oidtree and reinitialize it for
+ * subsequent use.
+ */
+void oidtree_clear(struct oidtree *ot);
+
+/* Insert the object ID into the tree. */
+void oidtree_insert(struct oidtree *ot, const struct object_id *oid);
+
+/* Check whether the tree contains the given object ID. */
+bool oidtree_contains(struct oidtree *ot, const struct object_id *oid);
+
+/* Callback function used for `oidtree_each()`. */
+typedef enum cb_next (*oidtree_each_cb)(const struct object_id *oid,
+					void *cb_data);
+
+/*
+ * Iterate through all object IDs in the tree whose prefix matches the given
+ * object ID prefix and invoke the callback function on each of them.
+ */
+void oidtree_each(struct oidtree *ot,
+		  const struct object_id *prefix, size_t prefix_hex_len,
+		  oidtree_each_cb cb, void *cb_data);
 
 #endif /* OIDTREE_H */
diff --git a/t/unit-tests/u-oidtree.c b/t/unit-tests/u-oidtree.c
index e6eede2740..def47c6795 100644
--- a/t/unit-tests/u-oidtree.c
+++ b/t/unit-tests/u-oidtree.c
@@ -24,7 +24,7 @@ static int fill_tree_loc(struct oidtree *ot, const char *hexes[], size_t n)
 	return 0;
 }
 
-static void check_contains(struct oidtree *ot, const char *hex, int expected)
+static void check_contains(struct oidtree *ot, const char *hex, bool expected)
 {
 	struct object_id oid;
 
@@ -88,12 +88,12 @@ void test_oidtree__cleanup(void)
 void test_oidtree__contains(void)
 {
 	FILL_TREE(&ot, "444", "1", "2", "3", "4", "5", "a", "b", "c", "d", "e");
-	check_contains(&ot, "44", 0);
-	check_contains(&ot, "441", 0);
-	check_contains(&ot, "440", 0);
-	check_contains(&ot, "444", 1);
-	check_contains(&ot, "4440", 1);
-	check_contains(&ot, "4444", 0);
+	check_contains(&ot, "44", false);
+	check_contains(&ot, "441", false);
+	check_contains(&ot, "440", false);
+	check_contains(&ot, "444", true);
+	check_contains(&ot, "4440", true);
+	check_contains(&ot, "4444", false);
 }
 
 void test_oidtree__each(void)

-- 
2.53.0.1055.ga2ffed1127.dirty

