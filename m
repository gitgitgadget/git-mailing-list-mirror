Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E442D7398
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203796; cv=none; b=IQxetcGwIvCMCDXo3Ui7gQEgrd8CS3xiSgp0pctmaV9eRw+/UfSEHUauLSmJ4bSB3cHwL20DNBbpIEOF1l7Ix520IERYW6nWoDlhdD1LN3Jb7V8hdu7TXDxduMlrcz1fJizbkvpV9L45pKJsCKV5ZYeH4jBsyoZ6y+ggla928Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203796; c=relaxed/simple;
	bh=XQaXpBYGpL4k6vem1rD2/l87v9TMdPCy+Yx9QVpxSbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlX1N6Sm1lkQN0GZSHf9RQ0igVSuGjxnupOpBMyvtekcmT3iNsiM1uV3S61EsrEf58QQbZkn9U7JrtHylMqAkne5JyEnbbjVocAO1ZxY2BlwUo8TLvByqAQWf0IXWiI3eNPxYrfs8N/bd8ad/HgBMUGYvvM0XtzYx9UrnxNjhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IfhyL7hI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k6VhBj+7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IfhyL7hI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k6VhBj+7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B8008EC01FA;
	Thu, 23 Oct 2025 03:16:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 03:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203792;
	 x=1761290192; bh=2MeVoRyHYFwT3uT4BCM4rid/xpRpnidsF5aSOpIP4CY=; b=
	IfhyL7hIx81spD+5/79DKAxHOwUIb7lX2F158eXKYkwdr8V0bvtuCziDXo5VpEXz
	K+ti3WnvbPL7I9HdtjF29ZeyRepVMJsE/kUS+jZcUhz2rAjqhVdF9wjmYSTR+VJV
	W+MSCO1znunZLhvX1ctzSF9gvoZZOmUzQObMsC+BIiM63Z5sE8qv40/BlOYEmJWi
	uCH7wZEuLgP9B+Coq2HFAEmFS+hBZ5vOaIdhRuiYx+zE+qU1BFATWwFkbcWB/Y3T
	x4ArFzUJjKoQuN1ZGaAjTmaUkZEDMU0BHMGIqphG53L8bgSEn1s9Lknp0MFYdhJu
	YS8Nq7YVbBzOPFMtmVEBkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203792; x=
	1761290192; bh=2MeVoRyHYFwT3uT4BCM4rid/xpRpnidsF5aSOpIP4CY=; b=k
	6VhBj+74b8Ia3uEEpdn2TJ+3RgG5fGkSRnDDQRUajbLRUfk5P4AFyFdxuNfb8qLu
	/uRxYyWVyMKvvlhwsD6JKqpCEzQrKGCzDba9QN05uFeLaBbBnWJ6G1ZMccNg1MAa
	F5aE/FPFJHSbme/4eKgttihMXyDb4DeaI/Cht70swEfx4AQjPmQJ8yQ0N4an2asx
	AusfVaIYKJwNwMA2IHnooP8dqKlZpqM5j7bburmwQ76J1KQqlaa/+3qlqpFldM72
	wvwhOu5We173rkkLGU+prAsYLZ4KW7xx+BOSSre/L56/iq3AwpKu0vAfPq4/xqag
	dxp4OLuD8wSCE//LtzPHw==
X-ME-Sender: <xms:UNb5aLAHGy7jFXloOi58V-NU9JCF8F8FksnoLtTlH1QAvEzq0rtXMw>
    <xme:UNb5aFOnG5ipG6MqsFCVpvRXlAMAPriEBFhSIrjmvhOHVQpiJdUb3ypQ9PPuWzazx
    ofOROOo-HKiQQY19596JAw9VdvejmrhUqAwh3FloED2eZxkijJhp48>
X-ME-Received: <xmr:UNb5aAYrYh9QnS93dT7S_bIBl-1_SCsVJMbiJkwc78GNV7-wsEuHILXNvgqTQU3Lsqtk_8SuVbhjOEPUFPsbPnb9kf8Vdrp5wd4DznKkWbDEDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduffeuvdeggffhfefgtddvhfffieetgefghfehkedtheevffevjeelheeftdeufeen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthdprhgvfhdrnhgrmhgvpdhrvghfrdhtrg
    hrghgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:UNb5aEsl6VDFlhp9WNQx7LqP8gpQaxQ4W3THW5FMOJSaSmDv2LVo_A>
    <xmx:UNb5aCMSYLx9aSqR2u6L8Cc76VzhMuYKwiJi23CpWH9t80J3mzwzmg>
    <xmx:UNb5aL5JpyYkMxKoe01TkEGzhGLvJxFC-2wjhJ_c4TMBTMR-4ai80w>
    <xmx:UNb5aISQq47ZbH6pWpHL5N6Kj_sTCEQfkotTDk58m7kzs3E2K6eqAg>
    <xmx:UNb5aN9rKz58M9FQ0rEFbMZGqlMgpF_PuhNbThH2SJzVhHzBd6UAJ1qL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c81e7aa1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:14 +0200
Subject: [PATCH v4 05/14] refs: expose peeled object ID via the iterator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-5-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
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
 commit-graph.c          |  2 +-
 ls-refs.c               |  2 +-
 midx-write.c            |  2 +-
 pseudo-merge.c          |  2 +-
 refs.c                  | 12 ++++++++++++
 refs.h                  | 19 +++++++++++++++++++
 refs/packed-backend.c   |  1 +
 refs/reftable-backend.c |  5 +++++
 repack-midx.c           |  2 +-
 12 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 79545350443..443546aaac9 100644
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
index 9de5de175f6..f0cf20d4238 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1109,7 +1109,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 	struct commit_list *stack = NULL;
 	struct commit *commit;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		maybe_peeled = &peeled;
 	if (odb_read_object_info(the_repository->objects, maybe_peeled, NULL) != OBJ_COMMIT)
 		return 0;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 39633a0158e..1613fecb669 100644
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
@@ -4537,7 +4538,7 @@ static int mark_bitmap_preferred_tip(const struct reference *ref, void *data UNU
 	struct object_id peeled;
 	struct object *object;
 
-	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(the_repository, ref, &peeled))
 		maybe_peeled = &peeled;
 
 	object = parse_object_or_die(the_repository, maybe_peeled, ref->name);
diff --git a/commit-graph.c b/commit-graph.c
index f91af416259..80be2ff2c39 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1857,7 +1857,7 @@ static int add_ref_to_set(const struct reference *ref, void *cb_data)
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(data->repo, ref, &peeled))
 		maybe_peeled = &peeled;
 	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) == OBJ_COMMIT)
 		oidset_insert(data->commits, maybe_peeled);
diff --git a/ls-refs.c b/ls-refs.c
index 64d02723691..8641281b86c 100644
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
index f4dd875747a..23e61cb0001 100644
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
index 0abd51b42c1..a2d5bd85f95 100644
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
index f96cf43b128..1b1551f9814 100644
--- a/refs.c
+++ b/refs.c
@@ -2334,6 +2334,18 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
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
index 4f0a685714f..886ed2c0f43 100644
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
  * functions below.  The memory pointed to by the `struct reference`
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 711e07f8326..1fefefd54ed 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -963,6 +963,7 @@ static int next_record(struct packed_ref_iterator *iter)
 			iter->base.ref.flags &= ~REF_KNOWS_PEELED;
 		} else {
 			iter->base.ref.flags |= REF_KNOWS_PEELED;
+			iter->base.ref.peeled_oid = &iter->peeled;
 		}
 	} else {
 		oidclr(&iter->peeled, iter->repo->hash_algo);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 728886eafd3..e214e120d77 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -547,6 +547,7 @@ struct reftable_ref_iterator {
 	struct reftable_iterator iter;
 	struct reftable_ref_record ref;
 	struct object_id oid;
+	struct object_id peeled_oid;
 
 	char *prefix;
 	size_t prefix_len;
@@ -671,6 +672,8 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		case REFTABLE_REF_VAL2:
 			oidread(&iter->oid, iter->ref.value.val2.value,
 				refs->base.repo->hash_algo);
+			oidread(&iter->peeled_oid, iter->ref.value.val2.target_value,
+				refs->base.repo->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
 			referent = refs_resolve_ref_unsafe(&iter->refs->base,
@@ -708,6 +711,8 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		iter->base.ref.name = iter->ref.refname;
 		iter->base.ref.target = referent;
 		iter->base.ref.oid = &iter->oid;
+		if (iter->ref.value_type == REFTABLE_REF_VAL2)
+			iter->base.ref.peeled_oid = &iter->peeled_oid;
 		iter->base.ref.flags = flags;
 
 		break;
diff --git a/repack-midx.c b/repack-midx.c
index 349f7e20b53..74bdfa3a6e9 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -22,7 +22,7 @@ static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
 	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
+	if (!reference_get_peeled_oid(data->repo, ref, &peeled))
 		maybe_peeled = &peeled;
 
 	if (oidset_insert(&data->seen, maybe_peeled))

-- 
2.51.1.930.gacf6e81ea2.dirty

