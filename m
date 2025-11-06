Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA42A1BB
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419192; cv=none; b=sMYBW3sQ1gI5fFF5y8e+LXG2FomKxbJ9h4zxFFJgezGFpu6YARz2eA9wnYW90ROyyWAeBt3KiLMhTgIVG3MR2NJxZV5FIrdokwGV+AHkSdsW+tCPzLD77AV+2B2i+x07iSxN2TOfVbRlBaCicvO3KSlxVJFfsFsyxmol9p7zVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419192; c=relaxed/simple;
	bh=FiMY+H7qV+6pVFxhqzmLBE5npdOoUXzbi2Fqup9KOtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hB4Jv4eZmv2Ppz5/GlF03dZr/Rwxy2Fi8Eoe5aEnLzgqnKb32bw07RVrP1BbnELwjq32xmCF/cu4sLrunrtIxOSq+5NxBDh2dxP0vIvFh6pjwYBe9bCwgtLPXgbyU9u8I4SnZID/glQQq11gtYPKWT1T7tG7oWFfm+vedlS6gKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bc8W7UEr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ck5a3qoe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bc8W7UEr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ck5a3qoe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AA7214001BB
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 03:53:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 03:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1762419188; x=1762505588; bh=cGkpf99Tpy
	PwvBDSOFQLxd7zScUSpEsEXN36XRD2DE4=; b=bc8W7UEr9fFRaymHO+eWXxWd0X
	Y8THacDs761KktTGGql15UUAnFNLQeIIj9kltf6m7QNz5Y3Wr+bQMz51R12zs063
	IXpELIcJxuRsYDUJj4LEArKJxdrrwJPwTSXLnKJTM3m0zw63LJmvbA2rkXkmvtGS
	kAfxZ4hYYHvL5Nj/LFejZdGNZD80hp8Ebg7oLjJodB0Oz1NqBD5pKOKRmd/A4Hj4
	pgnzTgcHgCR2JldDAcIFrHcmuWUVwMmgOjpv9HwpSIanmwL002KXIilPHZqasjBr
	qW6KieKTJZRzVPq8eNW94x9utSBQ4sEFWDOJBN3vatE7Vp9sHWCj1hCQcHQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762419188; x=1762505588; bh=cGkpf99TpyPwvBDSOFQLxd7zScUS
	pEsEXN36XRD2DE4=; b=ck5a3qoedAzF6MvWLnefGRFbyWb6IQVZNwXS/hfg08Bv
	4sMaHifVImrAb8hLEdFRb9YJB66U6T5lt0NJ+008LZXLuI1TYfU75sP2RvHDP/ES
	LgAvelZ176oeOPGZkoXkC8J1yBQUYatKkbXB5ERizAj03dFbG6EsbjkqfCtOUcbF
	XFUNuE6Jno2b2xwewkY396uqDIkWHggeF5vy0npYct67bQQiVahVXxyyC1iuL8NP
	f6jVk5bDOvEwvD8cndER/9hYgQAZ2CXhNA4p8fVZ4nZKCkTFjA0DKf7s5rQsgPQ2
	gL9aPiQ1L3UJvVIToJPkQp+GcVoDDXMsXHOWrZ2sKg==
X-ME-Sender: <xms:9GEMaU_Iuquwwo0xlMl4vTFOMO58YHCVRt1P_Q8T_CpXyWtwdmAyaA>
    <xme:9GEMaTpY8r_jsvcH_BjAj_UlM2z4_UKZuZtqT3j6Rn45yhbBK15R03vfjLffDk21O
    Rk-mb_YOMml4CzEwe4tLHCw92BaNBOO6Hb_1O-g1neFEVW8fwiY2RU>
X-ME-Received: <xmr:9GEMafoXDpOj95qY9rC5Y57NtBhZQzNC5_DgQHNRyY_Wt4LQgMtv55w3_q2ZoEVrtOyr8yB1Z90RNu7e-2LEaG0zLf8nIaEWcHgyq-K7xUyJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthekredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnheptdegvdffudfgvdeigeduueegieelvdffgeduve
    ekledvgefggefhfeevleffleevnecuffhomhgrihhnpegsvghntghhvghrrdguvghvpdhv
    rghlvddrthgrrhhgvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9GEMaZlSeJUC51zjT6Pr3X9Qu2e3sArqZXLSZC7R_-53oynwcJm-sw>
    <xmx:9GEMaZGWoTL9p9c-uAayJMn8o-HF_ZSpSt7j6Ao23E1yKPPWQSXFzw>
    <xmx:9GEMaapOagl3w-GIsb1-ITuXtfHrhbQD0fFD7nsVa4wQUZw_VxkmcA>
    <xmx:9GEMad5Dp4Sd9poQDm65kdw32gt60besxt3t4e4BIlx0uMExrRqyJw>
    <xmx:9GEMaUt6ehOz8uB7-sMA_8IvRZRGFVvn0684zyOCyrcMmEFDhTBaUERQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Nov 2025 03:53:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 53b77bea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Nov 2025 08:53:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Nov 2025 09:52:54 +0100
Subject: [PATCH] object: fix performance regression when peeling tags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-b4-pks-peel-object-performance-regression-v1-1-a386147750b0@pks.im>
X-B4-Tracking: v=1; b=H4sIAOVhDGkC/x2NSQrDMBAEv2LmnAHJ2Nm+EnzQ0naURRIzIQSM/
 x4lt6pL1UoKSVA6dysJ3klTyU3srqNwdXkBp9icetOP1po9+4HrXbkCDy7+hvBqLHORp8sBLFg
 E+qvwwdjhGP0Y3QnUelUwp8//dZm27QsinpFjewAAAA==
X-Change-ID: 20251106-b4-pks-peel-object-performance-regression-70148db5da9e
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Our Bencher dashboards [1] have recently alerted us about a bunch of
performance regressions when writing references, specifically with the
reftable backend. There is a 3x regression when writing many refs with
preexisting refs in the reftable format, and a 10x regression when
migrating refs between backends in either of the formats.

Bisecting the issue lands us at 6ec4c0b45b (refs: don't store peeled
object IDs for invalid tags, 2025-10-23). The gist of the commit is that
we may end up storing peeled objects in both reftables and packed-refs
for corrupted tags, where the claimed tagged object type is different
than the actual tagged object type. This will then cause us to create
the `struct object *` with a wrong type, as well, and obviously nothing
good comes out of that.

The fix for this issue was to introduce a new flag to `peel_object()`
that causes us to verify the tagged object's type before writing it into
the refdb -- if the tag is corrupt, we skip writing the peeled value.
To verify whether the peeled value is correct we have to look up the
object type via the ODB and compare the actual type with the claimed
type, and that additional object lookup is costly.

This also explains why we see the regression only when writing refs with
the reftable backend, but we see the regression with both backends when
migrating refs:

  - The reftable backend knows to store peeled values in the new table
    immediately, so it has to try and peel each ref it's about to write
    to the transaction. So the performance regression is visible for all
    writes.

  - The files backend only stores peeled values when writing the
    packed-refs file, so it wouldn't hit the performance regression for
    normal writes. But on ref migrations we know to write all new values
    into the packed-refs file immediately, and that's why we see the
    regression for both backends there.

Taking a step back though reveals an oddity in the new verification
logic: we not only verify the _tagged_ object's type, but we also verify
the type of the tag itself. But this isn't really needed, as we wouldn't
hit the bug in such a case anyway, as we only hit the issue with corrupt
tags claiming an invalid type for the tagged object.

The consequence of this is that we now started to look up the target
object of every single reference we're about to write, regardless of
whether it even is a tag or not. And that is of course quite costly.

Fix the issue by only verifying the type of the tagged objects. This
means that we of course still have a performance hit for actual tags.
But this only happens for writes anyway, and I'd claim it's preferable
to not store corrupted data in the refdb than to be fast here. Rename
the flag accordingly to clarify that we only verify the tagged object's
type.

This fix brings performance back to previous levels:

    Benchmark 1: baseline
      Time (mean ± σ):      46.0 ms ±   0.4 ms    [User: 40.0 ms, System: 5.7 ms]
      Range (min … max):    45.0 ms …  47.1 ms    54 runs

    Benchmark 2: regression
      Time (mean ± σ):     140.2 ms ±   1.3 ms    [User: 77.5 ms, System: 60.5 ms]
      Range (min … max):   138.0 ms … 142.7 ms    20 runs

    Benchmark 3: fix
      Time (mean ± σ):      46.2 ms ±   0.4 ms    [User: 40.2 ms, System: 5.7 ms]
      Range (min … max):    45.0 ms …  47.3 ms    55 runs

    Summary
      update-ref: baseline
        1.00 ± 0.01 times faster than fix
        3.05 ± 0.04 times faster than regression

[1]: https://bencher.dev/perf/git/plots

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Patrick
---
 object.c                |  4 ++--
 object.h                | 12 ++++++------
 ref-filter.c            |  2 +-
 refs/packed-backend.c   |  2 +-
 refs/reftable-backend.c |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index e72b0ed436..b08fc7a163 100644
--- a/object.c
+++ b/object.c
@@ -214,7 +214,7 @@ enum peel_status peel_object(struct repository *r,
 {
 	struct object *o = lookup_unknown_object(r, name);
 
-	if (o->type == OBJ_NONE || flags & PEEL_OBJECT_VERIFY_OBJECT_TYPE) {
+	if (o->type == OBJ_NONE) {
 		int type = odb_read_object_info(r->objects, name, NULL);
 		if (type < 0 || !object_as_type(o, type, 0))
 			return PEEL_INVALID;
@@ -228,7 +228,7 @@ enum peel_status peel_object(struct repository *r,
 		if (o && o->type == OBJ_TAG && ((struct tag *)o)->tagged) {
 			o = ((struct tag *)o)->tagged;
 
-			if (flags & PEEL_OBJECT_VERIFY_OBJECT_TYPE) {
+			if (flags & PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE) {
 				int type = odb_read_object_info(r->objects, &o->oid, NULL);
 				if (type < 0 || !object_as_type(o, type, 0))
 					return PEEL_INVALID;
diff --git a/object.h b/object.h
index 1499f63d50..e9baade1e0 100644
--- a/object.h
+++ b/object.h
@@ -289,13 +289,13 @@ enum peel_status {
 
 enum peel_object_flags {
 	/*
-	 * Always verify the object type, even in the case where the looked-up
-	 * object already has an object type. This can be useful when the
-	 * stored object type may be invalid. One such case is when looking up
-	 * objects via tags, where we blindly trust the object type declared by
-	 * the tag.
+	 * Always verify the object type of the tagged object, even in the case
+	 * where the looked-up object already has an object type. This can be
+	 * useful when the tagged object type may be invalid. One such case is
+	 * when looking up objects via tags, where we blindly trust the object
+	 * type declared by the tag.
 	 */
-	PEEL_OBJECT_VERIFY_OBJECT_TYPE = (1 << 0),
+	PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE = (1 << 0),
 };
 
 /*
diff --git a/ref-filter.c b/ref-filter.c
index d8667c569a..d7454269e8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2654,7 +2654,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 		if (!is_null_oid(&ref->peeled_oid)) {
 			oidcpy(&oi_deref.oid, &ref->peeled_oid);
 		} else if (!peel_object(the_repository, &oi.oid, &oi_deref.oid,
-					PEEL_OBJECT_VERIFY_OBJECT_TYPE)) {
+					PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE)) {
 			/* We managed to peel the object ourselves. */
 		} else {
 			die("bad tag");
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1ab0c50393..5aa615011a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1528,7 +1528,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 		} else {
 			struct object_id peeled;
 			int peel_error = peel_object(refs->base.repo, &update->new_oid,
-						     &peeled, PEEL_OBJECT_VERIFY_OBJECT_TYPE);
+						     &peeled, PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE);
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6bbfd5618d..1ac1f6156f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1633,7 +1633,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			ref.update_index = ts;
 
 			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled,
-						 PEEL_OBJECT_VERIFY_OBJECT_TYPE);
+						 PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE);
 			if (!peel_error) {
 				ref.value_type = REFTABLE_REF_VAL2;
 				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);

---
base-commit: ad5e7227123df84edc0cc82d18c5962cd9983b85
change-id: 20251106-b4-pks-peel-object-performance-regression-70148db5da9e

