Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6952D9EEC
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203802; cv=none; b=MERlohlFz2boZTcWBWqIdZoejAxdTpTL8KaGPTETR/T2YjBTOxhRQWI7FsqUYwh0ChQosiiyBH4dpo3gW1ym8+zY+hw4asU0F8gsQBr13KBk0OTEkd/8RfNLo3auWKPIEm5dhQ4U3HhfySkVGzAxepWuhjgrwxepAHcvhW2sLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203802; c=relaxed/simple;
	bh=ustt5O7OKgpokVJ/bgmDqe6Cz/tnXRRC9fNphqiqftw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/acHgJPXJV4qLBCGL8IRjZfXJsmkJPyMxnIyvaRNSCe1vaNW8BKDgwW7d2V/E9chJVOvYITGafDKqN6jdmCxkTGBqGOpoF1KZoJF5BddNU73btqD/JiCaFshnyAF/eDmI2iDGnMrV7oAwAr5yYFMmN6NpIjWZm/bewBr9MqMpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FGoZFF19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TWQwBwrS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FGoZFF19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TWQwBwrS"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 906AF14001E2;
	Thu, 23 Oct 2025 03:16:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 23 Oct 2025 03:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203799;
	 x=1761290199; bh=BeuS/L9lCkjVe5vPK2DS3T2Wws7IIN+yiOkV5MXops8=; b=
	FGoZFF197tVBfxm04H29AHLj3r1+OImdY7I7/cuNcyueNZpj8nuBUh4wnKNWXvpc
	jA0TOfyUvYOiD0PhSB6y/KA2Ms+5vmQ77xTP2y/Lk4C6EcIftwWsfgDrhB5ftgBE
	bU9VfHcoVzHVRkwjrdarSPCwQBb8w1sV2foXcUofgq/XdFa9mafNkHm8FYWjwYg5
	2oiiidgxC9xooY8isDCMmMD7p3K31hN9RxNkrxef6dajlFO9Di2HOS563aKuGW5P
	Pw/ugXrF6NivFtg0Gu9rE6uSq7eOykC5N8TEU5YIk7l2GjHBgy6j/kogZzjig3hZ
	wlMVWkE6DgIxlLPgDIV+NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203799; x=
	1761290199; bh=BeuS/L9lCkjVe5vPK2DS3T2Wws7IIN+yiOkV5MXops8=; b=T
	WQwBwrSBlTN8KeGIE+06rcsDFv8J4D0GvfCBfQlu67CjvXqOnRYCTtmtUMR8XD5c
	EHzM0SIa16cGQCoxFngarLy6o4ZoVTEcpVTL4ocPYGe/e0HlMOx8lBbQr2KWAX83
	ZFm1bwCJPNmd3nRiBZjxPNpkc9uoRiDtwUjQO58QC9UJdajD6lc60g2UCy1xqm2T
	vmrs2oNDUSwn7U2DZfSsyLjpd4pGm4oy22nZGphdjTXG0mxMaxuxH36VYUqtJpNA
	yurCQtdOx79AmElNElyDuFHpa+TDSf/k3JcTFIhsew2Xe+kqgTQi3zaX1yQyL7bz
	2vGwBigeVKRntL7CFqPcg==
X-ME-Sender: <xms:V9b5aBWmTSbuDK-ktNiseZBDwEPSgvbfmisvwVG1yXXYUBSUmFiVVQ>
    <xme:V9b5aFTWE1scAFUACcEgsFpVIMKFv39uaD8EwNZCUxFjB-LxXkzoUWdM8a7v0ugpx
    _iFEk5Wkw9iG4T2qcBoZ0xyomSO8RQ37uvZhbB-7-ekE93Y8Hmx8A>
X-ME-Received: <xmr:V9b5aHMUNVBUuCsGYebpTTodWfLFnRq-S8xBosjohCm48KHOyulhJmdpuD-pSm1_CxF0kHoIVrjpYMn3_WRum6AzJ4ZerPAFL0J77anAx_cdnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:V9b5aLR26k6AHaEKmSRMTee_aYNNHMBDXDdrtF1YBqlttRTjre8C_A>
    <xmx:V9b5aNgR4Cx0b1_5StPtsgUOlgLMZJyZ9okSXVD6GR1VvIHwH010VA>
    <xmx:V9b5aM_Hv71eyi3SEiVqzAeCTfquQrjX3Q0DhRkNl6kt4C0GShraiA>
    <xmx:V9b5aMGDCNtZLgZWsDaypVW8EU6nX2hRyeLbRuSxiyv_2FMotirUcw>
    <xmx:V9b5aPRXd0--LQrH2h8FLQBYWSW0ayZ6YJktZODIYhZH4sXghJ4G_dNJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57dbcbac (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:16 +0200
Subject: [PATCH v4 07/14] ref-filter: propagate peeled object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-7-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
index df09000b30d..fe77829557f 100644
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
index f0665af3acd..01eba90c5c7 100644
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
index cd6bc11095d..558121eaa16 100644
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
index 6837fa60a9b..7fd8babec8f 100644
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
index 235c60f79c9..120221b47fa 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -41,6 +41,7 @@ enum ref_sorting_order {
 
 struct ref_array_item {
 	struct object_id objectname;
+	struct object_id peeled_oid;
 	const char *rest;
 	int flag;
 	unsigned int kind;
@@ -187,6 +188,7 @@ void print_formatted_ref_array(struct ref_array *array, struct ref_format *forma
  * name must be a fully qualified refname.
  */
 void pretty_print_ref(const char *name, const struct object_id *oid,
+		      const struct object_id *peeled_oid,
 		      struct ref_format *format);
 
 /*
@@ -195,7 +197,8 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
  */
 struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
-				      const struct object_id *oid);
+				      const struct object_id *oid,
+				      const struct object_id *peeled_oid);
 
 /*
  * If the provided format includes ahead-behind atoms, then compute the

-- 
2.51.1.930.gacf6e81ea2.dirty

