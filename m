Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360CB358377
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990466; cv=none; b=uqR7e6mfV0Gcmvp6upAHHJUcO65R9rOdse4CYmG4LL2ENfH3WWSJ0FFz1E2gZ+58geeABZLgpsGbxb1x2/zGtQ6A3hBVL30FMXvIgF0pcD9HEH1ahT3pszt4eaWB7+CXt+lijow9/0jha9DYPztbaeR6f+lIzItiNIhTEewTBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990466; c=relaxed/simple;
	bh=UyWlRvF5gSA3OBwt3Gvt3ltdOfViRoVRA5ApvVm7wd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaITko0t0LOVkxmYfwaIEtQ738IkRovSbnV8KArSg95MWkVMqu1kFxL+1lnOS7FKuwRrh/YH6F6YPTOKttN8MjsUP4AxTyb8lu5p7PPfoSby/0deq1z/4j9IOSuWVabRn+51+gCCSCQMJHU9XH1VCkBW1LHSfHwTB0kF3gpQ3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BO+DIBQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/KBJmE3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BO+DIBQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/KBJmE3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65FA9140026F;
	Fri, 20 Mar 2026 03:07:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 20 Mar 2026 03:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990464;
	 x=1774076864; bh=sNbK6Vt7xbmeBEFtIMM0g88zDqR3BPtN5Y011gVpeFs=; b=
	BO+DIBQ4jGOl6lun94vrf2iRnbvTGXb5P+2/oo1fPtFRcEi4oqX8g19YTQdpDCeW
	kRU3ngAAgTq0BRlHzohduxhFhSufRr6VzP4tLTRL4GxIajqmeCx3/bFNYY/d4Df/
	+f97tnnIZYBSG/mTqI9R6mjMRfjRImO4w4bl2EsAWPScsit5zDCJbPPONUE8l1zj
	Y7pFpLNIitIWxI+QWlUL0j3vJEQhuu/D7WIXjeDxdSF22ra0YNuiatqmxPukXXea
	ssR8KpevuXaLCzMR+SqrDXRckZ6/qdRzQ4lhe+t35yroz4Qbw8QMRoBj7T55z4eO
	P0H7oNs8C9rbYshBCVJTsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990464; x=
	1774076864; bh=sNbK6Vt7xbmeBEFtIMM0g88zDqR3BPtN5Y011gVpeFs=; b=c
	/KBJmE3El6BI14bdI3woZb4KuWQR0ybCJe0v5dsUPGsDpHuyqidzH2UBfGS3GOVI
	gyoDElQBXL1fH7aC6s1GkylZo1fUyd9ckE0eDmLpXRGq923zWJqzm86GhycrPRO9
	UDtdUC9lnw8QSCW5ay9LIqoD4okompNc4rTvILhJo7I0glQGTtCZckxeU5vxX26r
	vBp8glW8+gUCBlpM9+4v/yfhse+fm7HIOW0f/b5SxCqdLjGMbPWCQ+78VZO8UYjl
	FYSPbdFh2V0bdC3nRu8WNY+iXKqiU7n5/598GFMoQtUOhK/InujuEuSlwY0KGDV0
	U3HhSVK1kHJHC5LXcBciw==
X-ME-Sender: <xms:QPK8aTAcFDHrYyQqTB_c3xBbFefmEQEtfFKPb7YwIRFCSFXkBHOKrA>
    <xme:QPK8aQ8Y9US4e7emuBe6mpiW863lszcjG7mnzAGTKAu3ZFipSgF2yAj7IwF_R87dF
    hwmltRqE_4BOmtdXQAVj-7sdGQV0mOS8VLlLO7JbhOGV3xo7KQs1w>
X-ME-Received: <xmr:QPK8ab_ASvQwn-S6yAvORzf60walzALtBaEdu35KoujHLs9vijJjTBccsvdVjwLkwOrFv0htlNQwLIH715Skcgk4pk3FRugwS58oCabNZrCW>
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
X-ME-Proxy: <xmx:QPK8afcu3meGDHokgW02hHQiSNfUKhxOkLiYUOTR3HWcPzkk9wjQRw>
    <xmx:QPK8acFk4b_LAHLjTS8mOsXpz4gMDj_ANzfIkHyloRgE3FYpaq4tzQ>
    <xmx:QPK8aVfN-n06y2YNIXi-3XuEtA6hbPQQxQ0jNLg2G9kIDPNBIzT51Q>
    <xmx:QPK8aeGhTCQZYH9QW2hbN-AiAdn_dTAOB1Kj1R-mryIdbgvpjWz45g>
    <xmx:QPK8aQ_L_BMmloL5XzXxE63kTpp3OoVYiI9ULf8BLw9uZlgFlrYIUMFc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 409a5d47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:27 +0100
Subject: [PATCH v2 01/14] oidtree: modernize the code a bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-1-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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

