Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F12D97AB
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834758; cv=none; b=Q5ucm+BGv5u7Yvjz00F4M20F4Lp6NcDsCgF8a8sJQnhhgVJMEDIhe3n4fm5VJXlCdCVHcxVVwb51GrPIcTu294dLd9r6lIfN6p/x+ikwJrf2kG4LNZPsftrKK6YLQWIBnBCyP+SG2/7aBnMUTDx+QE/eeb2GU6AaNoWlXgzRC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834758; c=relaxed/simple;
	bh=MFLcw+HEZSRkwBdV0mFI4/0mAUb37kxWNnWhzCnwxM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAFUQh+Q/8eVGovpgKSbT4WJ8zolFrz6wEZfn6UisauxzenCg3TXmbTqhA35fH07sGKL0liVEtNRYSmdHLYoEQAFoP/hjFua573A2i/C1lXAgleEjTZEQCQpRxx6X5yrTVKRITBEhz2bW08xn/AsGSkrWWgfg3a/YLqd5q3isTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rI/kiXVN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rE339GrN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rI/kiXVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rE339GrN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 88B211D0000E
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 06:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834755;
	 x=1759921155; bh=nXDyldTODghOzCvoqpgQnHZdAfBXRZe3+4ktnnpVIt0=; b=
	rI/kiXVNjiHCqnG7Sd7ICgN8fPO53ACB9Mh3DBChEKyV059LV7c/7VMDc6fvRUNT
	WgDf6RNA72hvE87uze4p+fFe3b6N/k9LJOgXYT620vRTLnUNFb846+s+Xv2aEyxe
	hWwpTjcrWp/zAABqDNyzsJ9vf9+e/MXctB4NiFDwC6r7dY21bTravnu3G7rNEVPA
	MVJlb3rjKnyKS6Milm6eklf1HGw6vYN39FVvrJBtdyo1IiLAnn4UNfQKJIqtKWxh
	KkURmZBDTm84ohbzUom3UMPU9Ldv/Fuc4KHF/5Kdusr/gXxHtDVdcmqSuUoSLk93
	euUGXPVopYaJ0XfbsNbjLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834755; x=
	1759921155; bh=nXDyldTODghOzCvoqpgQnHZdAfBXRZe3+4ktnnpVIt0=; b=r
	E339GrNoS12V2UQCNp3uq1hE8Z184JJUfgtVw8dNyHnsXfNVPIKWhs5hKUHVnztN
	ivb44ASF2zzS/KfmX8Rrq5dLR4U7xeril8IkdiF4CB97sdpi6a9EuL6A2X0ve2hq
	AO1wNtDXqDssGiHgVVCJy4xe4MauubKUWZSKIq6bT/cv1o/a48Xjlgc5Juy/k0dc
	Nr84foxHci41qQM4vzJxCS7EDQKMVMBirKf/AY9ZbtLIPlQgU/vbG/0JBONiyY6n
	7f26M5pjcIF22ho7ZvalZbc6mYR/DXS0nduJyz2gi2cMTjbxSEgXRCGpsmaOCr/M
	VfLPcVbKZ0s7tCsVPZskw==
X-ME-Sender: <xms:g_LkaBuLKWnx6VYqXwANH3fwX6PYhhXRaGQOj8z1Ymbe1DSYGcI_SA>
    <xme:g_LkaBaRLmc4fMBHOjsr3uSvPfkBMZZ9ljjQYyaILm4MLxoNJzEitU-i5gEjvCiLU
    yp36aNrkkz51n6f3EkCaLCkLtSWC94iscviZpkDpKckT4dxxlP7>
X-ME-Received: <xmr:g_LkaKb1lxVZPOtzETTnTpkLuQod4Mllgh8YVeLnx5rRhimnUC013vuCACuBLsLH53hGYxGkL5cxrBl9ar-oAE5GJhvhaeneb9IN6xerXew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:g_LkaNU85Ik-OMNquu85jpalUNWUbRnpGIDwA2G05k8cr8Y-586H_w>
    <xmx:g_LkaB06VjCqZkWbaPGNmXcDbm3XRhr3jXIvSDV7mGZSe5Z0MbrZ0Q>
    <xmx:g_LkaEa5U4ejfQjeZzyHkUEex2U4387tmulnL-_Y1_YSjMlmKIV4ug>
    <xmx:g_LkaErQoWbMtEtmP3ShkDbZLzx34xdf_F7LCaqoMZ64MrM1yx6H7A>
    <xmx:g_LkaIdr5Z1uWCOU5R9QIAP_rbBhGLRnbjLGE8uR8aqMx-VBR9yRGazD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5db88c04 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:43 +0200
Subject: [PATCH 06/13] ref-filter: propagate peeled object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-6-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
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

