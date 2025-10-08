Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970E52FAC14
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938650; cv=none; b=LVSkfXx8BLwEXCUQARSHGVyJhlQRgoHkFiFcjOHC2bQ+1mHwX/ZLhMgJmbYLfx5OKkEAx3sEjytgrM6Rv/Aeyb/SYuajHsQDSfqVhodaGakQvLsb57dw46trsDusO/avixX1hMb0SXNdHbyurY/pPWCeB02LAYySqUZdg1AJYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938650; c=relaxed/simple;
	bh=MFLcw+HEZSRkwBdV0mFI4/0mAUb37kxWNnWhzCnwxM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJn5cOZefgez0BE1mwEXpJmeWh/dtholE6iEa+AYDMkxgYFeTgtYPV5UuOzrq/eAhyZjVZi9H8L+xworNx6sDP8V3kGi5IcCORL7InP4v7iSoNG2hUNtxjsIfmlk46EnAO0p8rpm3mMCr0FhaM8v3t3jMnHgc8xGTYNeLkDNpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o4EOJOPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qLL0jO+x; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o4EOJOPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qLL0jO+x"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B360B1D0054F;
	Wed,  8 Oct 2025 11:50:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 11:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938647;
	 x=1760025047; bh=nXDyldTODghOzCvoqpgQnHZdAfBXRZe3+4ktnnpVIt0=; b=
	o4EOJOPh/ney/4uB3YADoXkOGr+OO/9TM67gjBU0jJaoxnsdVtsd7aRRubhdzQrs
	q7iE7/8dC9Yk5BZPMAQl8sc7JkOPA+MPl0P4Vl5aSMK4O37Mn/4jsrFFt4a2HSxe
	6Ca6gcmXO3oTC8eFeDfV+A7BFxWW4qzzxJ9c8Vo/AlAk2UeOdS0+QvirLvte3hfB
	DsnlKxw11b6EzHcubsrzRAlFhHB3Ju+2OhdfMNNKbDAK1S955tQD37Om1LL8Khzw
	n0Z2XFxtyRErLbOZXIYMO/1R48XrfWEzjnV5O/BHM9MOrz0MTvA5uPksW29rm9eD
	Hv0/cdsKH7DT8Fjna2/LsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938647; x=
	1760025047; bh=nXDyldTODghOzCvoqpgQnHZdAfBXRZe3+4ktnnpVIt0=; b=q
	LL0jO+xmWrTdNVCwaPMgG8n3r2tbbM4IUCBgcMs5OMlrT2PF5GwYoveWrK1Vn+p8
	ph/HR4kBW0zBbfqBT4Ql+W1IJsGan/DRo0s96IUXBgqA69nOL5879Jmf3v6rwH0R
	dY5JX4brk5QPnodqstMfv0QhsqUPxPdZCV3tncX+d2NagU/86HlEpdE/xSFrSuwx
	AOgvRpFMCd1o3+vfN5K792JkB8sSEa/MeUVROJmQIxCI27RW3HG2OV0osDU0v1q0
	b/1EEL+SpRwygwZlwOTVupR+MDljGN6QPblP+wnknS2Ok3Dkcgmm8Vk+JJDbIDGg
	w9LGdGV15giMZGWvW49iQ==
X-ME-Sender: <xms:V4jmaJoqM72MRAohtXPu9zrePhYPARvBdhCL_2k4QS3MJOsaGRKmlQ>
    <xme:V4jmaPXAeFCSZF0ZjYEgJWFqlIv4UdsCl9v-piukB-SJhSJlelv_lH6a1sCsTEr5m
    8ZYWWUfxTBcWwJPd2MtaOHl4hDVMZv1jud0mU7xIrEYL7oxkUAY6g>
X-ME-Received: <xmr:V4jmaAChZWHwHP03IBQeBQFirE5rV-zmY4QyXnD1QOIgBePXUTRNHep-yQotPipTEJbV2zvBvRLy7aLh9RnTnTHmnd_jEK1ZD16tDJ3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:V4jmaL382Bafsgo2He4X5tfH4UiyMUG5ej2PBYGp4PxY1A7p6a7kkw>
    <xmx:V4jmaK05J_iH6SJ3oXrfWLqxxxRzXwHiRrB86uITuxwYDuuPu2JJFg>
    <xmx:V4jmaIAbMae0ASZC903UQtSBdx8MmtVumt5QQb44kS89zcHRvaj7rg>
    <xmx:V4jmaB4sprauGfcGtH6RWK1tC_ksjs50iHWH3oycfxiDEbtWv84Y1w>
    <xmx:V4jmaClIxOmGzFeDvO7oDVURkaCG-_4iBiAPoJNvgmuDZ8og4K95LVbm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7493dae6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:22 +0200
Subject: [PATCH v2 07/14] ref-filter: propagate peeled object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-7-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

When queueing a reference in the "ref-filter" subsystem we end up
creating a new ref array item that contains the reference's info. One
bit of info that we always discard though is the peeled object ID, and
because of that we are forced to use `peel_iterated_oid()`.

Refactor the code to propagate the peeled object ID via the ref array,
if available. This allows us to manually peel tags without having to go
through the object database.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-remote.c  |  2 +-
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 ref-filter.c         | 66 ++++++++++++++++++++++++++++++----------------------
 ref-filter.h         |  5 +++-
 5 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index df09000b30..fe77829557 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -156,7 +156,7 @@ int cmd_ls_remote(int argc,
 			continue;
 		if (!tail_match(&pattern, ref->name))
 			continue;
-		item = ref_array_push(&ref_array, ref->name, &ref->old_oid);
+		item = ref_array_push(&ref_array, ref->name, &ref->old_oid, NULL);
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
diff --git a/builtin/tag.c b/builtin/tag.c
index f0665af3ac..01eba90c5c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -153,7 +153,7 @@ static int verify_tag(const char *name, const char *ref UNUSED,
 		return -1;
 
 	if (format->format)
-		pretty_print_ref(name, oid, format);
+		pretty_print_ref(name, oid, NULL, format);
 
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index cd6bc11095..558121eaa1 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -67,7 +67,7 @@ int cmd_verify_tag(int argc,
 		}
 
 		if (format.format)
-			pretty_print_ref(name, &oid, &format);
+			pretty_print_ref(name, &oid, NULL, &format);
 	}
 	return had_error;
 }
diff --git a/ref-filter.c b/ref-filter.c
index 7740f35e93..b18a032e57 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2578,8 +2578,15 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	 * If it is a tag object, see if we use the peeled value. If we do,
 	 * grab the peeled OID.
 	 */
-	if (need_tagged && peel_iterated_oid(the_repository, &obj->oid, &oi_deref.oid))
-		die("bad tag");
+	if (need_tagged) {
+		if (!is_null_oid(&ref->peeled_oid)) {
+			oidcpy(&oi_deref.oid, &ref->peeled_oid);
+		} else if (!peel_object(the_repository, &obj->oid, &oi_deref.oid)) {
+			/* We managed to peel the object ourselves. */
+		} else {
+			die("bad tag");
+		}
+	}
 
 	return get_object(ref, 1, &obj, &oi_deref, err);
 }
@@ -2807,12 +2814,15 @@ static int match_points_at(struct oid_array *points_at,
  * Callers can then fill in other struct members at their leisure.
  */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const struct object_id *oid)
+						 const struct object_id *oid,
+						 const struct object_id *peeled_oid)
 {
 	struct ref_array_item *ref;
 
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
+	if (peeled_oid)
+		oidcpy(&ref->peeled_oid, peeled_oid);
 	ref->rest = NULL;
 
 	return ref;
@@ -2826,9 +2836,10 @@ static void ref_array_append(struct ref_array *array, struct ref_array_item *ref
 
 struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
-				      const struct object_id *oid)
+				      const struct object_id *oid,
+				      const struct object_id *peeled_oid)
 {
-	struct ref_array_item *ref = new_ref_array_item(refname, oid);
+	struct ref_array_item *ref = new_ref_array_item(refname, oid, peeled_oid);
 	ref_array_append(array, ref);
 	return ref;
 }
@@ -2871,25 +2882,25 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return ref_kind_from_refname(refname);
 }
 
-static struct ref_array_item *apply_ref_filter(const char *refname, const char *referent, const struct object_id *oid,
-			    int flag, struct ref_filter *filter)
+static struct ref_array_item *apply_ref_filter(const struct reference *ref,
+					       struct ref_filter *filter)
 {
-	struct ref_array_item *ref;
+	struct ref_array_item *item;
 	struct commit *commit = NULL;
 	unsigned int kind;
 
-	if (flag & REF_BAD_NAME) {
-		warning(_("ignoring ref with broken name %s"), refname);
+	if (ref->flags & REF_BAD_NAME) {
+		warning(_("ignoring ref with broken name %s"), ref->name);
 		return NULL;
 	}
 
-	if (flag & REF_ISBROKEN) {
-		warning(_("ignoring broken ref %s"), refname);
+	if (ref->flags & REF_ISBROKEN) {
+		warning(_("ignoring broken ref %s"), ref->name);
 		return NULL;
 	}
 
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
-	kind = filter_ref_kind(filter, refname);
+	kind = filter_ref_kind(filter, ref->name);
 
 	/*
 	 * Generally HEAD refs are printed with special description denoting a rebase,
@@ -2902,13 +2913,13 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const char *
 	else if (!(kind & filter->kind))
 		return NULL;
 
-	if (!filter_pattern_match(filter, refname))
+	if (!filter_pattern_match(filter, ref->name))
 		return NULL;
 
-	if (filter_exclude_match(filter, refname))
+	if (filter_exclude_match(filter, ref->name))
 		return NULL;
 
-	if (filter->points_at.nr && !match_points_at(&filter->points_at, oid, refname))
+	if (filter->points_at.nr && !match_points_at(&filter->points_at, ref->oid, ref->name))
 		return NULL;
 
 	/*
@@ -2918,7 +2929,7 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const char *
 	 */
 	if (filter->reachable_from || filter->unreachable_from ||
 	    filter->with_commit || filter->no_commit || filter->verbose) {
-		commit = lookup_commit_reference_gently(the_repository, oid, 1);
+		commit = lookup_commit_reference_gently(the_repository, ref->oid, 1);
 		if (!commit)
 			return NULL;
 		/* We perform the filtering for the '--contains' option... */
@@ -2936,13 +2947,13 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const char *
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid);
-	ref->commit = commit;
-	ref->flag = flag;
-	ref->kind = kind;
-	ref->symref = xstrdup_or_null(referent);
+	item = new_ref_array_item(ref->name, ref->oid, ref->peeled_oid);
+	item->commit = commit;
+	item->flag = ref->flags;
+	item->kind = kind;
+	item->symref = xstrdup_or_null(ref->target);
 
-	return ref;
+	return item;
 }
 
 struct ref_filter_cbdata {
@@ -2959,8 +2970,7 @@ static int filter_one(const struct reference *ref, void *cb_data)
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
 	struct ref_array_item *item;
 
-	item = apply_ref_filter(ref->name, ref->target, ref->oid,
-				ref->flags, ref_cbdata->filter);
+	item = apply_ref_filter(ref, ref_cbdata->filter);
 	if (item)
 		ref_array_append(ref_cbdata->array, item);
 
@@ -2997,8 +3007,7 @@ static int filter_and_format_one(const struct reference *ref, void *cb_data)
 	struct ref_array_item *item;
 	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
 
-	item = apply_ref_filter(ref->name, ref->target, ref->oid,
-				ref->flags, ref_cbdata->filter);
+	item = apply_ref_filter(ref, ref_cbdata->filter);
 	if (!item)
 		return 0;
 
@@ -3585,13 +3594,14 @@ void print_formatted_ref_array(struct ref_array *array, struct ref_format *forma
 }
 
 void pretty_print_ref(const char *name, const struct object_id *oid,
+		      const struct object_id *peeled_oid,
 		      struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
 	struct strbuf output = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
-	ref_item = new_ref_array_item(name, oid);
+	ref_item = new_ref_array_item(name, oid, peeled_oid);
 	ref_item->kind = ref_kind_from_refname(name);
 	if (format_ref_array_item(ref_item, format, &output, &err))
 		die("%s", err.buf);
diff --git a/ref-filter.h b/ref-filter.h
index 81f2c229a9..1126826201 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -41,6 +41,7 @@ enum ref_sorting_order {
 
 struct ref_array_item {
 	struct object_id objectname;
+	struct object_id peeled_oid;
 	const char *rest;
 	int flag;
 	unsigned int kind;
@@ -185,6 +186,7 @@ void print_formatted_ref_array(struct ref_array *array, struct ref_format *forma
  * name must be a fully qualified refname.
  */
 void pretty_print_ref(const char *name, const struct object_id *oid,
+		      const struct object_id *peeled_oid,
 		      struct ref_format *format);
 
 /*
@@ -193,7 +195,8 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
  */
 struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
-				      const struct object_id *oid);
+				      const struct object_id *oid,
+				      const struct object_id *peeled_oid);
 
 /*
  * If the provided format includes ahead-behind atoms, then compute the

-- 
2.51.0.764.g787ff6f08a.dirty

