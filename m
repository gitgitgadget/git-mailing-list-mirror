Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AD261372
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473767; cv=none; b=VfyEZqvh+WQzumPuZQx3yupHBF4QMzyuLvRpbp3bFt1Sy6ubYnfFAZ1i+S1K1UY3c3ReQ8rECGz8j73kDn7FHESXE3SrjpHW5mhPQ6TGcVrGP04DGLNx9wR6ITA4d+esavwwUIc/2PI+E0fw4s9UTeRtcftqHuyI5f1LJMaITl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473767; c=relaxed/simple;
	bh=GFYW8v1I1s3XR4mOR92PuvXxfEGPXj1fgJhTQ1qkl2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQvtj8nJniMBOeLZgEYLjR3dsQZN1lEESuClQr/pO47oeyiEd5cScyJJPLCQpMaFZ5+DAkp156jIC2REtHRZZt+sCrLsOl/BAHTN9PpVouMoaS+rfNkA2JT0E+5L93FnvtpvuexiWsHHtoFScbjJeGhVN7qIb5nUMWYjD1Zx2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VbgInJcg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CEu8Z836; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VbgInJcg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CEu8Z836"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F0BA62540172;
	Tue, 25 Feb 2025 03:56:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 03:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473763;
	 x=1740560163; bh=52NxtbIq9gxijQzHbbmME4VGu/SKyS5aRWCfR8SmDyc=; b=
	VbgInJcgRu9tBZctFkJ9fY/cLaas6X5/oON/Z9FpHk1QwtkQ/U1zvJDKPHYcflMq
	nIuhuWIFEonG9GcgFgYe5nCrfWs34Y50MRQd/MbmKLNGgibNW1veR/+3XrgntsHC
	ZE2tiNVikTfknG4C6QjkRQtXGnU/yQsyXoEXWBa6xZOILsgWslE0m2f1LbuasQm+
	6aI0g6Udm/PDGnYVIwghiviWRpUdKUdzLTFgK1oPzZ51kBQHuG6KHfCLykgAo25X
	znzypsGBcI1K9bJySQa5vjH8eHOwQF+USu/LKt/fxLv6yBSrkBAG1YlidTiJFsA7
	aF6ffFsR0SpFpc2N2DSSNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473763; x=
	1740560163; bh=52NxtbIq9gxijQzHbbmME4VGu/SKyS5aRWCfR8SmDyc=; b=C
	Eu8Z836t1jvASVe1kww4QjF5ynLp+CtBjxDPdVHuT8AJeYLLwu1NiZt4YpQPxzbN
	ZtMpFrQrk0jXnD/xCVkbOEc8SIA8hdZLDA22X5EfIJJUfKokHdoja4ASt9ycXReY
	au3s5kGQlXciT2lTIKXmP6ffbUQtzo2MMyKb9pyRRgQ1m7RrBDOMG43YL6tmFftN
	kWwP8SYHhq/E1nL38HEsZ7E8nap1QxiHnyXH6VPABpTzfQkS+ekeC/xGdPMTXqWS
	n5VVKRFde9UMEQXMrhS519XQYNO73YHyAqReSD7xWpI1avTjeUo86VuE3nigTIgB
	mq7M319m2L/21fDRa5wnw==
X-ME-Sender: <xms:o4W9ZzGAJOEVtA1dq9zsl7Tv34YAAZCVXcwaKJb2V41dJy3CHhdYhA>
    <xme:o4W9ZwW32JpsISZ2GhISDrUP3XHJTiTBkIwhaav417MjsDgY8Vx6jVdACPurvIH9r
    wgiUdJORaP91ZrAdQ>
X-ME-Received: <xmr:o4W9Z1LDsKjPXIeFYtmPLbKNci2OoFC0PJhSJ1T_2zg_WBPRjr68KK8G08KLoF7hukDpF6N9w2JeD5Swuj_BA1a-eN4hMTOtIIRQQs7PCrbdCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:o4W9ZxFCOhO2kiV4c-nXIXpWIJrN96eM0y_jRCD6lofH-0TufPuIxg>
    <xmx:o4W9Z5UrGWmogqqxcQcxq2OLsN479GrkjNnMe2T-jeMjlFgqHYS6VQ>
    <xmx:o4W9Z8MIIkG6Ih-9xdtU74tFZrHJhA5x6jY3_dfOydjKKPJ4SLkPqQ>
    <xmx:o4W9Z41-vu_vRgYZrNMLxZ42JgXlVLXIjRZsyIqNH3lNnP_M2QZkRQ>
    <xmx:o4W9Z4EMIsPlYvxczJ0A_U4vpUAVLwZX4ua56d3WdoSBU8Zxf17W3pdO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f02ed44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:55:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:55:50 +0100
Subject: [PATCH v3 04/16] refs: introduce function to batch refname
 availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-4-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The `refs_verify_refname_available()` functions checks whether a
reference update can be committed or whether it would conflict with
either a prefix or suffix thereof. This function needs to be called once
per reference that one wants to check, which requires us to redo a
couple of checks every time the function is called.

Introduce a new function `refs_verify_refnames_available()` that does
the same, but for a list of references. For now, the new function uses
the exact same implementation, except that we loop through all refnames
provided by the caller. This will be tuned in subsequent commits.

The existing `refs_verify_refname_available()` function is reimplemented
on top of the new function. As such, the diff is best viewed with the
`--ignore-space-change option`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 169 +++++++++++++++++++++++++++++++++++++----------------------------
 refs.h |  12 +++++
 2 files changed, 109 insertions(+), 72 deletions(-)

diff --git a/refs.c b/refs.c
index f4094a326a9..5a9b0f2fa1e 100644
--- a/refs.c
+++ b/refs.c
@@ -2467,19 +2467,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	return ret;
 }
 
-int refs_verify_refname_available(struct ref_store *refs,
-				  const char *refname,
-				  const struct string_list *extras,
-				  const struct string_list *skip,
-				  unsigned int initial_transaction,
-				  struct strbuf *err)
+int refs_verify_refnames_available(struct ref_store *refs,
+				   const struct string_list *refnames,
+				   const struct string_list *extras,
+				   const struct string_list *skip,
+				   unsigned int initial_transaction,
+				   struct strbuf *err)
 {
-	const char *slash;
-	const char *extra_refname;
 	struct strbuf dirname = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
-	struct object_id oid;
-	unsigned int type;
 	int ret = -1;
 
 	/*
@@ -2489,79 +2485,91 @@ int refs_verify_refname_available(struct ref_store *refs,
 
 	assert(err);
 
-	strbuf_grow(&dirname, strlen(refname) + 1);
-	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
-		/*
-		 * Just saying "Is a directory" when we e.g. can't
-		 * lock some multi-level ref isn't very informative,
-		 * the user won't be told *what* is a directory, so
-		 * let's not use strerror() below.
-		 */
-		int ignore_errno;
-		/* Expand dirname to the new prefix, not including the trailing slash: */
-		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
+	for (size_t i = 0; i < refnames->nr; i++) {
+		const char *refname = refnames->items[i].string;
+		const char *extra_refname;
+		struct object_id oid;
+		unsigned int type;
+		const char *slash;
+
+		strbuf_reset(&dirname);
+
+		for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+			/*
+			 * Just saying "Is a directory" when we e.g. can't
+			 * lock some multi-level ref isn't very informative,
+			 * the user won't be told *what* is a directory, so
+			 * let's not use strerror() below.
+			 */
+			int ignore_errno;
+
+			/* Expand dirname to the new prefix, not including the trailing slash: */
+			strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
+
+			/*
+			 * We are still at a leading dir of the refname (e.g.,
+			 * "refs/foo"; if there is a reference with that name,
+			 * it is a conflict, *unless* it is in skip.
+			 */
+			if (skip && string_list_has_string(skip, dirname.buf))
+				continue;
+
+			if (!initial_transaction &&
+			    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
+					       &type, &ignore_errno)) {
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    dirname.buf, refname);
+				goto cleanup;
+			}
+
+			if (extras && string_list_has_string(extras, dirname.buf)) {
+				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
+					    refname, dirname.buf);
+				goto cleanup;
+			}
+		}
 
 		/*
-		 * We are still at a leading dir of the refname (e.g.,
-		 * "refs/foo"; if there is a reference with that name,
-		 * it is a conflict, *unless* it is in skip.
+		 * We are at the leaf of our refname (e.g., "refs/foo/bar").
+		 * There is no point in searching for a reference with that
+		 * name, because a refname isn't considered to conflict with
+		 * itself. But we still need to check for references whose
+		 * names are in the "refs/foo/bar/" namespace, because they
+		 * *do* conflict.
 		 */
-		if (skip && string_list_has_string(skip, dirname.buf))
-			continue;
+		strbuf_addstr(&dirname, refname + dirname.len);
+		strbuf_addch(&dirname, '/');
+
+		if (!initial_transaction) {
+			struct ref_iterator *iter;
+			int ok;
+
+			iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
+						       DO_FOR_EACH_INCLUDE_BROKEN);
+			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
+				if (skip &&
+				    string_list_has_string(skip, iter->refname))
+					continue;
+
+				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
+					    iter->refname, refname);
+				ref_iterator_abort(iter);
+				goto cleanup;
+			}
 
-		if (!initial_transaction &&
-		    !refs_read_raw_ref(refs, dirname.buf, &oid, &referent,
-				       &type, &ignore_errno)) {
-			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-				    dirname.buf, refname);
-			goto cleanup;
+			if (ok != ITER_DONE)
+				BUG("error while iterating over references");
 		}
 
-		if (extras && string_list_has_string(extras, dirname.buf)) {
+		extra_refname = find_descendant_ref(dirname.buf, extras, skip);
+		if (extra_refname) {
 			strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-				    refname, dirname.buf);
+				    refname, extra_refname);
 			goto cleanup;
 		}
 	}
 
-	/*
-	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
-	 * There is no point in searching for a reference with that
-	 * name, because a refname isn't considered to conflict with
-	 * itself. But we still need to check for references whose
-	 * names are in the "refs/foo/bar/" namespace, because they
-	 * *do* conflict.
-	 */
-	strbuf_addstr(&dirname, refname + dirname.len);
-	strbuf_addch(&dirname, '/');
-
-	if (!initial_transaction) {
-		struct ref_iterator *iter;
-		int ok;
-
-		iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
-					       DO_FOR_EACH_INCLUDE_BROKEN);
-		while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-			if (skip &&
-			    string_list_has_string(skip, iter->refname))
-				continue;
-
-			strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-				    iter->refname, refname);
-			ref_iterator_abort(iter);
-			goto cleanup;
-		}
-
-		if (ok != ITER_DONE)
-			BUG("error while iterating over references");
-	}
-
-	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
-	if (extra_refname)
-		strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
-			    refname, extra_refname);
-	else
-		ret = 0;
+	ret = 0;
 
 cleanup:
 	strbuf_release(&referent);
@@ -2569,6 +2577,23 @@ int refs_verify_refname_available(struct ref_store *refs,
 	return ret;
 }
 
+int refs_verify_refname_available(struct ref_store *refs,
+				  const char *refname,
+				  const struct string_list *extras,
+				  const struct string_list *skip,
+				  unsigned int initial_transaction,
+				  struct strbuf *err)
+{
+	struct string_list_item item = { .string = (char *) refname };
+	struct string_list refnames = {
+		.items = &item,
+		.nr = 1,
+	};
+
+	return refs_verify_refnames_available(refs, &refnames, extras, skip,
+					      initial_transaction, err);
+}
+
 struct do_for_each_reflog_help {
 	each_reflog_fn *fn;
 	void *cb_data;
diff --git a/refs.h b/refs.h
index a0cdd99250e..185aed5a461 100644
--- a/refs.h
+++ b/refs.h
@@ -124,6 +124,18 @@ int refs_verify_refname_available(struct ref_store *refs,
 				  unsigned int initial_transaction,
 				  struct strbuf *err);
 
+/*
+ * Same as `refs_verify_refname_available()`, but checking for a list of
+ * refnames instead of only a single item. This is more efficient in the case
+ * where one needs to check multiple refnames.
+ */
+int refs_verify_refnames_available(struct ref_store *refs,
+				   const struct string_list *refnames,
+				   const struct string_list *extras,
+				   const struct string_list *skip,
+				   unsigned int initial_transaction,
+				   struct strbuf *err);
+
 int refs_ref_exists(struct ref_store *refs, const char *refname);
 
 int should_autocreate_reflog(enum log_refs_config log_all_ref_updates,

-- 
2.48.1.683.gf705b3209c.dirty

