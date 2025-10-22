Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F62EC0B3
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115290; cv=none; b=lJ1WA0rqJ5XVsBShM6C9ZO836UZc8qAoaInd3G5Eiq7AAhJ4lFg+uHXws4ND0p6+GCbncSQ4/NuS/myWlY7Ioenj/I8mluUycOZEbtJ5uEorxC6WYhvuYDIUT8+SagWtYDB/qyRDgM6AWga4VeOiLCWXfcB2LGd9njT93QYgaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115290; c=relaxed/simple;
	bh=eyaZVmfiUCXgOEtnctW4hBlKPhtVVrJq8A45DfQz7Rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BnyHJAAeJIROSDCmM2SOCbRA228jdOSKYspzK/aAswPFXFzPSHZOqp4wz+jddqvM87kcEvxANSFFwcIZAfiXDBKFvZe0AC2rdgOR76RfJvL6ehaSkynWMV8eVL5zugKkkXCj6MTX+lGNHLpMAWpHeL1LZl1b0wqi+9A3JAma7nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HHINSmSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6IGMfDV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HHINSmSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6IGMfDV"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DB627A0073;
	Wed, 22 Oct 2025 02:41:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 02:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115288;
	 x=1761201688; bh=SiSfJTetKJaB8QAaqb01GZCCaCsWKE009xEno8IKnjk=; b=
	HHINSmSP1iEg5lGklEPNgiLcJEhS6tHZ1N4jRCPBel3whe39hQy7oJm+3CUbBUZC
	B+if4ICiTjSK6gXSat1oRgAv5AO8j5rA4Q1ywYkr7jPJe/uZl0Fuycjz3TuNok3u
	xHNIyxtWVsLl3q9dd85CLUiNDSHzfIagdvaiZL4zWOQQkw94K6bMIMytHn4/11TZ
	bONb7AxYHPZvxLtaNLKOM3OhHqlVWhKP16200IX+53Mn7oe45+QuWuH3i3bUzhXD
	Z46eHHa9aGV8K9jl4MdmXuxjSVag8MMAFUOj0xBPxi7KXG22v8Mdf0bZh2GfOwcj
	HEcG3pq8jpwbK93Vu2oy0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115288; x=
	1761201688; bh=SiSfJTetKJaB8QAaqb01GZCCaCsWKE009xEno8IKnjk=; b=p
	6IGMfDVhopH8BY+Z0ZfFX3+bpoEWTOJoO4GOg0X+5AZO/rZdpLjHyzmfhajra7Qa
	eXNcbFZantXYapJQmRP2xL5tSnDym+Imgj6dJreGM+mvMnHmFbRyP6lC4Up53V2C
	fY4GxMSVD6DLyuskRf3G1Us+0zZzZk3SkevWMyJXoZ2s+epOhsDWihrQmU7fMNaE
	o04KZmGtcJ9h2qUkYSDUfAfj+2wC7WW8lJ/16RaIkeExE8DCS5Z3uLAZP2kdIfBe
	r1HxH5kn1ODzHgj2t6jSJOhcJInVaREdL4U9AYxNmeJ0SJ6pHA6u7qm8VJt9NlZ9
	kAvXxA76VQTyCY3sWvU5Q==
X-ME-Sender: <xms:l3z4aJ2e1n_bentiUW_lwno7eiacEyMViya-AEiyiu85vUYOhRg7RQ>
    <xme:l3z4aDzYD5expOdy4LsQanvBjxWs6oAVsKHq0vaQr_A6u4XDzAGu2GEOu74B-_7V-
    seD7ewF3-nUuQv6t2pkP9qLOOVy144707yxHsTeOmzjQfhsmrtHbA>
X-ME-Received: <xmr:l3z4aDtUGDabyvIEHf3_hs59gvbaECfmIb1j3vGJwNfPlZTW7A-Dpww-QaTlSBXUaKMw-4m_tcRMvzMxtoKyLQLHKl0l3wmuAcwGy17jp3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:l3z4aNxOWpjHUcTXO3Fa_j6BJVRze2WvgnA2TbxzmvT2qkvKAbDxJg>
    <xmx:l3z4aOAKk-KDEcvkV_5s_t5M-2gmnVM8cf-nnoYUiN5vp4tzlItNYQ>
    <xmx:l3z4aDcAEWrEbkzcNKNw3IIL8v57jqQ1YzXwl6D4_b3NuFencCPP3g>
    <xmx:l3z4aAn4KmInQruS7QeIXgOP5hB8MZdhFl6AWNVyE8Mj_BlYEv7blQ>
    <xmx:mHz4aPznq0XS2Ijfx5FE6GN_uTWUgwky_2UZnMAOnG2z-ygBDblNU6g3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1da35ce1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:07 +0200
Subject: [PATCH v3 07/14] ref-filter: propagate peeled object ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-7-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
2.51.1.851.g4ebd6896fd.dirty

