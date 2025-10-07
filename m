Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B02D94BB
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834753; cv=none; b=FohEXnMYjMFwWkjNA+te5QN/ThLq2I+CQqOH6/xLy1nyJAId3JnNZWb7xoegma1AzwEUHotFe6z1jeZ3CQDCW83Zc23wLTd0V1MSLO/iygoB5yXWvtlp7hHr9CNQ0c7Ht2FwHWridwQ5YyuomCNvetlhTO85eALVcmTru8Ctuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834753; c=relaxed/simple;
	bh=8pro/zHNiC0kMvtgBkAZAJkzFvndIk+XzMdrqt4X9CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoZHxa1O/GVe+18UeKe1OOJmBgck4lAzOonH3zoOL661yAQCRNMvSvkAXWi/slAcXZBKswPhKStJMX67XitwI0FqoOoQzXpCnaaDZQPOgh++jBrHKjq0y9jnV5TdX5ew0KttEoEbi3KDE6UmdI0z04skl0XsYjs0zo/LUyQ0qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=buPuc3PE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ykQEjTUJ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="buPuc3PE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ykQEjTUJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8EA9E1D00047
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 06:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834749;
	 x=1759921149; bh=XJ/kYclLMnPtql2wZPPr8yKCuAsIRYMFZlnkRDh19LQ=; b=
	buPuc3PEdYrS1a8oXfQEwtJArnboHqVY0dONdf2DVAoCdREBjsUIL+bIspKNkLmD
	vDKkRoDqiSCO2ikrc0zVpIG7RTsNGWlf9+bhIVVZu0WhPomTU4UhUVI41rzWmSWU
	IHlIK4YPLG8N+rKtW2iOE/s3AxN9vHdMYM6D9R3+4SRTpDEFHa5B1RUMCHhg37zY
	Tgw5Umv55W+eXZA2qmiq83GMyQiG3EKQTnZuqIk/AxCpTFFxVjFysfnOeJVB7Pjv
	KAhZYZq88IXHv/wrNccN8avB7lOC2aTEnaWFh6VZQ07r9pW93/z68D1jhgV92/Qg
	+YfwK4C/GtvHTgVkTN5e4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834749; x=
	1759921149; bh=XJ/kYclLMnPtql2wZPPr8yKCuAsIRYMFZlnkRDh19LQ=; b=y
	kQEjTUJBFjG6MFv8r58ui65R7qiedbtIlEtLq8bMxgdJZU05W8GEZ0vH6JH4HmBA
	nwPBTu0gNSkWG09u3GGvze5gdY0xhascwdF0vT1FW4NOpdmv52CTl+z6Z0PW7NrC
	Q0NDmLsq56cI+A5QGoxmgcloHqyi5NcGATCKV1x52SylSar27MVjgwELsE/QcTAy
	/fKY8imm7nEpEYvbF4XKkZBT3Qu4OkRoee5xKo4Lu+jBIj2/0IBLidrBvzCSzwkP
	EibK6WkKcq/cflWIxJjPZ69xsex84bjZ0OG0utenGjBH6o0gcJ7SWbW/y3+DEEB2
	iJV9WLsuWJvwZzceurUtA==
X-ME-Sender: <xms:ffLkaJgDwD2pTFRCVt7B85NPjlw17O14y5LOYbs7rbJU7-QAUn6v8w>
    <xme:ffLkaE8svJQRXNCEF-o4Ow5m0LABwPhBbaiWHllVqVqCrjIotFjyqDJsdOC_3hwW-
    Wjw1ZOLIdZI2MtcgNekBs0y8yoq8wyBsfRu5GG8KNCShRMUrMbEEw>
X-ME-Received: <xmr:ffLkaOtC5DpbMLBNjsFAK1kA5Tbu6RK31ee67theaMNPNR5tY9Qq2NAFk-rZplBy6q_-rigXbihqz2dOM5Fvb2LDaTBV_dr42IINg3b21s0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepjedugfeuuedtfeejueeuleetffehgfeiue
    fgleffieelheffleekfedvffejheevnecuffhomhgrihhnpehrvghfrdhnrghmvgdprhgv
    fhdrthgrrhhgvghtpdhvrghlvddrthgrrhhgvghtnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ffLkaDYhaQqSxATf9LqWGK3OW6O3hr4X0EPI0MeXrglvFBOSB4LeAQ>
    <xmx:ffLkaGqdhvVqhefL_BsRgQUmyVPcY-Cu0QQd3YL4FvS-Ls1z_3x17A>
    <xmx:ffLkaA8vIUe6tQ27R7h1ozrqPmuvzE94mh-Cd34wKw5JZy8Is7U8og>
    <xmx:ffLkaN-MO4yoeuqUNIEj9scooRX9Z62h-E4y6GUBwIbMisgLRG3XyQ>
    <xmx:ffLkaCgqYCUxMRehO81Dr9qwbnmSrdoGI7oTSqy1TjfYevs0AlBqGLcT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 425733f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:41 +0200
Subject: [PATCH 04/13] refs: expose peeled object ID via the iterator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-4-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Both the "files" and "reftable" backend are able to store peeled values
for tags in the respective formats. This allows for a more efficient
lookup of the target object of such a tag without having to manually
peel via the object database.

The infrastructure to access these peeled object IDs is somewhat funky
though. When iterating through objects, we store a pointer reference to
the current iterator in a global variable. The callbacks invoked by that
iterator are then expected to call `peel_iterated_oid()`, which checks
whether the globally-stored iterator's current reference refers to the
one handed into that function. If so, we ask the iterator to peel the
object, otherwise we manually peel the object via the object database.
Depending on global state like this is somewhat weird and also quite
fragile.

Introduce a new `struct reference::peeled_oid` field that can be
populated by the reference backends. This field can be accessed via a
new function `reference_get_peeled_oid()` that either uses that value,
if set, or alternatively peels via the ODB. With this change we don't
have to rely on global state anymore, but make the peeled object ID
available to the callback functions directly.

Adjust trivial callers that already have a `struct reference` available.
Remaining callers will be adjusted in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/describe.c      |  2 +-
 builtin/gc.c            |  2 +-
 builtin/pack-objects.c  |  7 ++++---
 builtin/repack.c        |  2 +-
 commit-graph.c          |  2 +-
 ls-refs.c               |  2 +-
 midx-write.c            |  2 +-
 pseudo-merge.c          |  2 +-
 refs.c                  | 12 ++++++++++++
 refs.h                  | 19 +++++++++++++++++++
 refs/packed-backend.c   |  3 +++
 refs/ref-cache.c        |  1 +
 refs/reftable-backend.c |  7 +++++++
 13 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 7954535044..443546aaac 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -208,7 +208,7 @@ static int get_name(const struct reference *ref, void *cb_data UNUSED)
 	}
 
 	/* Is it annotated? */
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled)) {
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled)) {
 		is_annotated = !oideq(ref->oid, &peeled);
 	} else {
 		oidcpy(&peeled, ref->oid);
diff --git a/builtin/gc.c b/builtin/gc.c
index a104c1cb78..814be8d1a9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1107,7 +1107,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 	struct commit_list *stack = NULL;
 	struct commit *commit;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		maybe_peeled = &peeled;
 	if (odb_read_object_info(the_repository->objects, maybe_peeled, NULL) != OBJ_COMMIT)
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 288ba19981..7fd457779d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -838,7 +838,7 @@ static int mark_tagged(const struct reference *ref, void *cb_data UNUSED)
 
 	if (entry)
 		entry->tagged = 1;
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled)) {
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled)) {
 		entry = packlist_find(&to_pack, &peeled);
 		if (entry)
 			entry->tagged = 1;
@@ -3309,7 +3309,8 @@ static int add_ref_tag(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled) && obj_is_packed(&peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled) &&
+	    obj_is_packed(&peeled))
 		add_tag_chain(ref->oid);
 	return 0;
 }
@@ -4532,7 +4533,7 @@ static int mark_bitmap_preferred_tip(const struct reference *ref, void *data UNU
 	struct object_id peeled;
 	struct object *object;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		maybe_peeled = &peeled;
 
 	object = parse_object_or_die(the_repository, maybe_peeled, ref->name);
diff --git a/builtin/repack.c b/builtin/repack.c
index 893c105c81..873e21c35d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -779,7 +779,7 @@ static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
 	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		maybe_peeled = &peeled;
 
 	if (oidset_insert(&data->seen, maybe_peeled))
diff --git a/commit-graph.c b/commit-graph.c
index 0cfe16ad08..bfd8b187f0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1852,7 +1852,7 @@ static int add_ref_to_set(const struct reference *ref, void *cb_data)
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(data->repo, ref, &peeled))
 		maybe_peeled = &peeled;
 	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) == OBJ_COMMIT)
 		oidset_insert(data->commits, maybe_peeled);
diff --git a/ls-refs.c b/ls-refs.c
index 64d0272369..8641281b86 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -110,7 +110,7 @@ static int send_ref(const struct reference *ref, void *cb_data)
 
 	if (data->peel && ref->oid) {
 		struct object_id peeled;
-		if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+		if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 			strbuf_addf(&data->buf, " peeled:%s", oid_to_hex(&peeled));
 	}
 
diff --git a/midx-write.c b/midx-write.c
index f4dd875747..23e61cb000 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -709,7 +709,7 @@ static int add_ref_to_pending(const struct reference *ref, void *cb_data)
 		return 0;
 	}
 
-	if (!peel_iterated_oid(revs->repo, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(revs->repo, ref, &peeled))
 		maybe_peeled = &peeled;
 
 	object = parse_object_or_die(revs->repo, maybe_peeled, ref->name);
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 0abd51b42c..a2d5bd85f9 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -230,7 +230,7 @@ static int find_pseudo_merge_group_for_ref(const struct reference *ref, void *_d
 	uint32_t i;
 	int has_bitmap;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		maybe_peeled = &peeled;
 
 	c = lookup_commit(the_repository, maybe_peeled);
diff --git a/refs.c b/refs.c
index 15ad0ef7a8..5002e56435 100644
--- a/refs.c
+++ b/refs.c
@@ -2333,6 +2333,18 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
 	return peel_object(r, base, peeled) ? -1 : 0;
 }
 
+int reference_get_peeled_oid(struct repository *repo,
+			     const struct reference *ref,
+			     struct object_id *peeled_oid)
+{
+	if (ref->peeled_oid) {
+		oidcpy(peeled_oid, ref->peeled_oid);
+		return 0;
+	}
+
+	return peel_object(repo, ref->oid, peeled_oid) ? -1 : 0;
+}
+
 int refs_update_symref(struct ref_store *refs, const char *ref,
 		       const char *target, const char *logmsg)
 {
diff --git a/refs.h b/refs.h
index 8f484e2ffc..f1e023df35 100644
--- a/refs.h
+++ b/refs.h
@@ -371,10 +371,29 @@ struct reference {
 	 */
 	const struct object_id *oid;
 
+	/*
+	 * An optional peeled object ID. This field _may_ be set for tags in
+	 * case the peeled value is present in the backend. Please refer to
+	 * `reference_get_peeled_oid()`.
+	 */
+	const struct object_id *peeled_oid;
+
 	/* A bitfield of `enum reference_status` flags. */
 	unsigned flags;
 };
 
+/*
+ * Peel the tag to a non-tag commit. If present, this uses the peeled object ID
+ * exposed by the reference backend. Otherwise, the object is peeled via the
+ * object database, which is less efficient.
+ *
+ * Return `0` if the reference could be peeled, a negative error code
+ * otherwise.
+ */
+int reference_get_peeled_oid(struct repository *repo,
+			     const struct reference *ref,
+			     struct object_id *peeled_oid);
+
 /*
  * The signature for the callback function for the for_each_*()
  * functions below.  The memory pointed to by the refname and oid
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 7987acdc96..7922d63acc 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -959,11 +959,14 @@ static int next_record(struct packed_ref_iterator *iter)
 		if ((iter->base.ref.flags & REF_ISBROKEN)) {
 			oidclr(&iter->peeled, iter->repo->hash_algo);
 			iter->base.ref.flags &= ~REF_KNOWS_PEELED;
+			iter->base.ref.peeled_oid = NULL;
 		} else {
 			iter->base.ref.flags |= REF_KNOWS_PEELED;
+			iter->base.ref.peeled_oid = &iter->peeled;
 		}
 	} else {
 		oidclr(&iter->peeled, iter->repo->hash_algo);
+		iter->base.ref.peeled_oid = NULL;
 	}
 
 	return ITER_OK;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 97555fa118..2f46f650a6 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -428,6 +428,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			iter->base.ref.name = entry->name;
 			iter->base.ref.target = entry->u.value.referent;
 			iter->base.ref.oid = &entry->u.value.oid;
+			iter->base.ref.peeled_oid = NULL;
 			iter->base.ref.flags = entry->flag;
 			return ITER_OK;
 		}
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7fbc77492e..f93ab96358 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -546,6 +546,7 @@ struct reftable_ref_iterator {
 	struct reftable_iterator iter;
 	struct reftable_ref_record ref;
 	struct object_id oid;
+	struct object_id peeled_oid;
 
 	char *prefix;
 	size_t prefix_len;
@@ -670,6 +671,8 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		case REFTABLE_REF_VAL2:
 			oidread(&iter->oid, iter->ref.value.val2.value,
 				refs->base.repo->hash_algo);
+			oidread(&iter->peeled_oid, iter->ref.value.val2.target_value,
+				refs->base.repo->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
 			referent = refs_resolve_ref_unsafe(&iter->refs->base,
@@ -706,6 +709,10 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		iter->base.ref.name = iter->ref.refname;
 		iter->base.ref.target = referent;
 		iter->base.ref.oid = &iter->oid;
+		if (iter->ref.value_type == REFTABLE_REF_VAL2)
+			iter->base.ref.peeled_oid = &iter->peeled_oid;
+		else
+			iter->base.ref.peeled_oid = NULL;
 		iter->base.ref.flags = flags;
 
 		break;

-- 
2.51.0.764.g787ff6f08a.dirty

