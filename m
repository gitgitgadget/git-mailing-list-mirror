Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751A2C21D3
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203814; cv=none; b=E5ZBwAT5NgxtpRGtE48vUZgQ2iFiI5ns2AOVqJCoMkG9JC42Q+y72UvBzzHdHRBM25qMqIkFAbyPf7zp59uF7BDY+sAg8YmSCVr8zljJQH2BD/LHCknkQLhlwWGhInZf0AAYNLmt6PDi/ahQOzglwizczbuDR6GxoTnzWxqhpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203814; c=relaxed/simple;
	bh=N58SUIg7laqzFXTnPalHlrdh2BOSpUxLmhsv5Vh2M2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OeYU3nA6esm6bN3wL8NY8/ZqTD1xsr9+QMfrJ388U+IVjXaefr+iNFLrNuLrPiU145tXSvySrh9kSDrmHlyxu3K0Pb2kvSda97niJcE87D+olMVbTQa/lesQSbWexf2z+w64N1AZV6xLb3WhmvRfe1fA+6HUIR2cH0IlBzMfOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dOT91vyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFMw5Joq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dOT91vyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFMw5Joq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 271BB1400112;
	Thu, 23 Oct 2025 03:16:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 03:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203812;
	 x=1761290212; bh=0ZTWoek+WoJOUG4Wb3wudIVjFD1lmtm1oEQtomTo5qo=; b=
	dOT91vywCtTi8KpJ1TEve0yIihMt5TRp9F/LLJrnNJDK6qSZniCqXNMnRlOOSre9
	28bm5GoQs01kvKWNHWhq3VLnX/vkuVLg2R2eWPpgzgqR1enzevZ3iNzuZxjry0Zu
	qlVrRY246FY999SY9KWuWvR6tyaoj/HtX+ERSqQMVS4Vc/uy209MRRdcey/Cff92
	fpaLFV+qNWaMupamkmD9Xg8ZK4pUox6TCqtcOSOYtjiEM+D+X2jgLSeqlf8hHV5O
	R1NjkF2vQ5/QG7oz7KIQOugE/uHq9w/amfJlRneWbXtvIbGuM2t37ZdkiXMZxryx
	N/EPXyuK6JbtoSHLQ7yvtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203812; x=
	1761290212; bh=0ZTWoek+WoJOUG4Wb3wudIVjFD1lmtm1oEQtomTo5qo=; b=A
	FMw5Joq2UxfxowXAEwSXYuuoNK6uIck3g16AZCPE2sonpJ1pf3QiJXlnVgRFjYrr
	cIBwH7FeWx1QHAxzWKyuF4yi6V0+t5ZG2DG76q+E0TExcblY6r2v7RTVngIPecww
	CoMQ0m9h8CNJ5u1jaILgSa7QoGqnvnd6IzkIuNjIWMH1tBKXYnE5igb7anNzQ2UV
	MRMzohDnlUfkDuDk+K/bpMx2rLqD62dq23s5h3e0kCCdmqbMDiEx7sz9X+gCVBne
	PEcXzbFeUcOrIJSwniXb0ktbblmCdEZfhh7u6exWgtRLLCFMxt8g53pKygeZ5lS+
	/uz2yhpnu5Hnwz24XaObA==
X-ME-Sender: <xms:Y9b5aImVAfROfEspOSyJg1v55s1XMoXxbF48WI-YEfNxLJpn78yTTA>
    <xme:Y9b5aLgCw_CX4hrnmGsj4Ao2pMAglyTQhL70_ciWDZ2x0zPDfkgCHr8GhoGnM0IXP
    3jWrTWbXcsrJQ6s3Tp8kOgy5klJvK-Gu_shcuwBh86JcoykUmxG8A>
X-ME-Received: <xmr:Y9b5aAfT3BGfXGIKMG3ewTCQPQRGNi4YYMAueGQKNdolAml3oky5ufzMf-PW285parlnvMeNtVQrs1iyk8qx4rTPVTPSfxn7RZYshJ-fwFMrTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Y9b5aLiT_4DK1grrkZ6ZkTYWTpwueL3IBXWvLxgCQXC0BJLI6lMjQQ>
    <xmx:Y9b5aIwEn68VZ7Ech71oseVmjXQgq1EGzNK5J1xUwPGaK8OnIRAeXA>
    <xmx:Y9b5aHPWCs3vAAKOqWZ8W3945Iu0IEJPQTY3rjWcf5UFPBxKFsmniw>
    <xmx:Y9b5aJUXVYQSqkNvXUYV8HNPVShKiAqvEvI31waG3tVvICE0222bPA>
    <xmx:ZNb5aCigbFboj4fp2AvRwED_8gNqRGeBVlFzUuq6KEWzPk3gfXDdBVYC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a856712c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:20 +0200
Subject: [PATCH v4 11/14] object: add flag to `peel_object()` to verify
 object type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-11-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When peeling a tag to a non-tag object we repeatedly call
`parse_object()` on the tagged object until we find the first object
that isn't a tag. While this feels sensible at first, there is a big
catch here: `parse_object()` doesn't actually verify the type of the
tagged object.

The relevant code path here eventually ends up in `parse_tag_buffer()`.
Here, we parse the various fields of the tag, including the "type". Once
we've figured out the type and the tagged object ID, we call one of the
`lookup_${type}()` functions for whatever type we have found. There is
two possible outcomes in the successful case:

  1. The object is already part of our cached objects. In that case we
     double-check whether the type we're trying to look up matches the
     type that was cached.

  2. The object is _not_ part of our cached objects. In that case, we
     simply create a new object with the expected type, but we don't
     parse that object.

In the first case we might notice type mismatches, but only in the case
where our cache has the object with the correct type. In the second
case, we'll blindly assume that the type is correct and then go with it.
We'll only notice that the type might be wrong when we try to parse the
object at a later point.

Now arguably, we could change `parse_tag_buffer()` to verify the tagged
object's type for us. But that would have the effect that such a tag
cannot be parsed at all anymore, and we have a small bunch of tests for
exactly this case that assert we still can open such tags. So this
change does not feel like something we can retroactively tighten, even
though one shouldn't ever hit such corrupted tags.

Instead, add a new `flags` field to `peel_object()` that allows the
caller to opt in to strict object verification. This will be wired up at
a subset of callsites over the next few commits.

Note that this change also inlines `deref_tag_noverify()`. There's only
been two callsites of that function, the one we're changing and one in
our test helpers. The latter callsite can trivially use `deref_tag()`
instead, so by inlining the function we avoid having to pass down the
flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object.c                | 20 +++++++++++++++++---
 object.h                | 15 ++++++++++++++-
 ref-filter.c            |  2 +-
 refs.c                  |  2 +-
 refs/packed-backend.c   |  5 ++---
 refs/reftable-backend.c |  4 ++--
 t/helper/test-reach.c   |  2 +-
 tag.c                   | 12 ------------
 tag.h                   |  1 -
 9 files changed, 38 insertions(+), 25 deletions(-)

diff --git a/object.c b/object.c
index 986114a6dba..e72b0ed4360 100644
--- a/object.c
+++ b/object.c
@@ -209,11 +209,12 @@ struct object *lookup_object_by_type(struct repository *r,
 
 enum peel_status peel_object(struct repository *r,
 			     const struct object_id *name,
-			     struct object_id *oid)
+			     struct object_id *oid,
+			     unsigned flags)
 {
 	struct object *o = lookup_unknown_object(r, name);
 
-	if (o->type == OBJ_NONE) {
+	if (o->type == OBJ_NONE || flags & PEEL_OBJECT_VERIFY_OBJECT_TYPE) {
 		int type = odb_read_object_info(r->objects, name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
@@ -222,7 +223,20 @@ enum peel_status peel_object(struct repository *r,
 	if (o->type != OBJ_TAG)
 		return PEEL_NON_TAG;
 
-	o = deref_tag_noverify(r, o);
+	while (o && o->type == OBJ_TAG) {
+		o = parse_object(r, &o->oid);
+		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged) {
+			o = ((struct tag *)o)->tagged;
+
+			if (flags & PEEL_OBJECT_VERIFY_OBJECT_TYPE) {
+				int type = odb_read_object_info(r->objects, &o->oid, NULL);
+				if (type < 0 || !object_as_type(o, type, 0))
+					return PEEL_INVALID;
+			}
+		} else {
+			o = NULL;
+		}
+	}
 	if (!o)
 		return PEEL_INVALID;
 
diff --git a/object.h b/object.h
index 8c3c1c46e1b..1499f63d507 100644
--- a/object.h
+++ b/object.h
@@ -287,6 +287,17 @@ enum peel_status {
 	PEEL_BROKEN = -4
 };
 
+enum peel_object_flags {
+	/*
+	 * Always verify the object type, even in the case where the looked-up
+	 * object already has an object type. This can be useful when the
+	 * stored object type may be invalid. One such case is when looking up
+	 * objects via tags, where we blindly trust the object type declared by
+	 * the tag.
+	 */
+	PEEL_OBJECT_VERIFY_OBJECT_TYPE = (1 << 0),
+};
+
 /*
  * Peel the named object; i.e., if the object is a tag, resolve the
  * tag recursively until a non-tag is found.  If successful, store the
@@ -295,7 +306,9 @@ enum peel_status {
  * and leave oid unchanged.
  */
 enum peel_status peel_object(struct repository *r,
-			     const struct object_id *name, struct object_id *oid);
+			     const struct object_id *name,
+			     struct object_id *oid,
+			     unsigned flags);
 
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
diff --git a/ref-filter.c b/ref-filter.c
index 7fd8babec8f..9a8ed8c8fc1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2581,7 +2581,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	if (need_tagged) {
 		if (!is_null_oid(&ref->peeled_oid)) {
 			oidcpy(&oi_deref.oid, &ref->peeled_oid);
-		} else if (!peel_object(the_repository, &obj->oid, &oi_deref.oid)) {
+		} else if (!peel_object(the_repository, &oi.oid, &oi_deref.oid, 0)) {
 			/* We managed to peel the object ourselves. */
 		} else {
 			die("bad tag");
diff --git a/refs.c b/refs.c
index 9d8f0a9ca4a..a41a94ae55b 100644
--- a/refs.c
+++ b/refs.c
@@ -2333,7 +2333,7 @@ int reference_get_peeled_oid(struct repository *repo,
 		return 0;
 	}
 
-	return peel_object(repo, ref->oid, peeled_oid) ? -1 : 0;
+	return peel_object(repo, ref->oid, peeled_oid, 0) ? -1 : 0;
 }
 
 int refs_update_symref(struct ref_store *refs, const char *ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6fa229edd0f..4752d3f3981 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1527,9 +1527,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 			i++;
 		} else {
 			struct object_id peeled;
-			int peel_error = peel_object(refs->base.repo,
-						     &update->new_oid,
-						     &peeled);
+			int peel_error = peel_object(refs->base.repo, &update->new_oid,
+						     &peeled, 0);
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e329d4a423a..9febb2322c3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1632,7 +1632,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			ref.refname = (char *)u->refname;
 			ref.update_index = ts;
 
-			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled);
+			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled, 0);
 			if (!peel_error) {
 				ref.value_type = REFTABLE_REF_VAL2;
 				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
@@ -2497,7 +2497,7 @@ static int write_reflog_expiry_table(struct reftable_writer *writer, void *cb_da
 		ref.refname = (char *)arg->refname;
 		ref.update_index = ts;
 
-		if (!peel_object(arg->refs->base.repo, &arg->update_oid, &peeled)) {
+		if (!peel_object(arg->refs->base.repo, &arg->update_oid, &peeled, 0)) {
 			ref.value_type = REFTABLE_REF_VAL2;
 			memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
 			memcpy(ref.value.val2.value, arg->update_oid.hash, GIT_MAX_RAWSZ);
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 028ec003067..c58c93800f3 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -63,7 +63,7 @@ int cmd__reach(int ac, const char **av)
 			die("failed to resolve %s", buf.buf + 2);
 
 		orig = parse_object(r, &oid);
-		peeled = deref_tag_noverify(the_repository, orig);
+		peeled = deref_tag(the_repository, orig, NULL, 0);
 
 		if (!peeled)
 			die("failed to load commit for input %s resulting in oid %s",
diff --git a/tag.c b/tag.c
index 1d52686ee10..f5c232d2f1f 100644
--- a/tag.c
+++ b/tag.c
@@ -94,18 +94,6 @@ struct object *deref_tag(struct repository *r, struct object *o, const char *war
 	return o;
 }
 
-struct object *deref_tag_noverify(struct repository *r, struct object *o)
-{
-	while (o && o->type == OBJ_TAG) {
-		o = parse_object(r, &o->oid);
-		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged)
-			o = ((struct tag *)o)->tagged;
-		else
-			o = NULL;
-	}
-	return o;
-}
-
 struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
diff --git a/tag.h b/tag.h
index c49d7c19ad3..ef12a610372 100644
--- a/tag.h
+++ b/tag.h
@@ -16,7 +16,6 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 int parse_tag(struct tag *item);
 void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const char *, int);
-struct object *deref_tag_noverify(struct repository *r, struct object *);
 int gpg_verify_tag(const struct object_id *oid,
 		   const char *name_to_report, unsigned flags);
 struct object_id *get_tagged_oid(struct tag *tag);

-- 
2.51.1.930.gacf6e81ea2.dirty

