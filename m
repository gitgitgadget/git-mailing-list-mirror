Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882342F1FD3
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115285; cv=none; b=S8sy6O67pmcJ3ONPfF/O/AJF6VPrhSRRzmeJv3XmvNjpXC0rN25ZlqcWlnC31qFfQCj2WOjn5mlH1KmQh+AkSpR3JVMeq56sNf2USsISfZwWoqk3LlkqKyJatJho7Ha0fye8XnEZDT2SciG3m34XHMU7EvDIVudCSXjg/bJbWAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115285; c=relaxed/simple;
	bh=70717hzjiaFPO5Oe2rMWERF/KNPXqSqfBzsrRI+PWyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OTY0J1rIq8ubjoRt1SvoshSzFUby7HTQU8fnloWNnLGb9RYLrWRgXsF9qUOcxf4iYMYDsTV6LeYAJdhVU6JLGrOlxyUgD0odNUlpE0T+iFaaqhhY9fLkmKDSf+jkDK+TiIR4g8yZRhJRznyR8KKqUITqfWrm5I5WtV0J6NBHB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bFNMu9WE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LD7OEBFO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bFNMu9WE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LD7OEBFO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B81537A0073;
	Wed, 22 Oct 2025 02:41:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 02:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115282;
	 x=1761201682; bh=pB+t1BAk+rGufRgh/ZCoN6vHQpfKj5zkdPUjxAf/5z4=; b=
	bFNMu9WEaG3ADIZBnCiUdDayTHxMfAApPrLsXUDqpXDggGigymmAbb73vXuwnHJv
	waHy/VGGOQyo7HGEZA5ERWP9rkyNOHYvF5ubEfN5yKFMLImrtRni8VxngbD2BHXs
	fG9MKVwwT81i44kMRCRoGXcPmmgnwGjfi7vVWLtiPtHqeD+4IY3GUrqnMbRo0BMy
	vZ7bXhXq2rbppvq3dKsl8eudQMlSpLIHjdKfp7I45CJDSpCwCXR/w+1QdIVZBauo
	nNP1mrJJvC6oonISWPmyJW1Jy31/Ix7FzDof5uq8zbEMNzbHuxNpeBz1LJIcfefm
	MNAh7Pms5vKDpiXAQ8kjFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115282; x=
	1761201682; bh=pB+t1BAk+rGufRgh/ZCoN6vHQpfKj5zkdPUjxAf/5z4=; b=L
	D7OEBFOuQhMEWDMaajHrxbtEj1507KBo6E3Us+f5LaBcRYywk44LXoBubMJwujOW
	hgbMKdjfY8TSAMwYartknBclsZPYXhd1McgSZimL6Kru6QSRg1J96rU2TxgC83Y2
	CzU0LGqMrLOuDuZK7pKDWIXnR3+NuNP+j6yvvT0UdTehdPzpnPog9szzuKCoxpUH
	iL9y3ipetQcFHEhc2piV2oBzZ0gYR+eI6lriKYFHJ3yT4DvhLb2krQLAQKCjsRoe
	FOexPWMEZrLQ3s3vEl8BPR0+MCIQxvGU5KmSAK9siKbFy0ZyAGqyQ3HqRngtCJzK
	fFqPn/2bwTsqlYBc9572A==
X-ME-Sender: <xms:knz4aD8MEJy99xZffKQPY8Fb_1SBRQfoOSNZGFMNtPxYXwerWxmJ5w>
    <xme:knz4aDYSW8Fu54y-_Gvhd8mwu_sbn89e5fWpwfST445vG2uEuW5XE2zSplVsg5p_R
    1vSMiCMjcsPpr8xyavWU8ea_1-DnNlvw_dyMPSUV1iHe3In6Kl6pWk>
X-ME-Received: <xmr:knz4aK2frgwj043mZKY2VOGVB1ONs7lbkcnUp9aZ7fzJZRDjIewNDhfwpIAc4wMIFSG1LQE4i8arcjQ4SkyYpCMP-tZFsrya9Ux-tyq-EU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduffeuvdeggffhfefgtddvhfffieetgefghfehkedtheevffevjeelheeftdeufeen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthdprhgvfhdrnhgrmhgvpdhrvghfrdhtrg
    hrghgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:knz4aGbaOGeCas6YeauyBi1WtZIUt7A2gBWeCRDqZN35QW58TSazDQ>
    <xmx:knz4aKJw6jfVOmZJLhB9ycUc7U-xFh79oFo7BwsutFLvCweGmgmSRQ>
    <xmx:knz4aNGfi1D5ltUwLdMFiB7EAT-a0izMf85GMoPGcxzBlfoCGd7qHA>
    <xmx:knz4aJtIvV1Mjgsp-tZ8KYQxzqayHXKXnVInk54OB09JPBQabtdSDg>
    <xmx:knz4aH5Dy8GZ1mZekQnqiP2Z7H0MbzUQCbD9EcxuDay5EN6ySXOkm7Cu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 59aeeaa9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:05 +0200
Subject: [PATCH v3 05/14] refs: expose peeled object ID via the iterator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-5-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
2.51.1.851.g4ebd6896fd.dirty

