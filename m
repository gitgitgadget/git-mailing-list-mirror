Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E505232379
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807433; cv=none; b=A3cvjlvKnfFg8Glpb4fAOmFlAZ0ySurT6qYWuF40KjZtcEkdcEQQmjwLBUvrLI8Ewg6Yr7yb7vLkBtoL8dc6QGFvX9VFWZRne46NT0ItCjbOhldtXFfIQaRQhcAi9u85rc1VXWP/CQfiW99R1HgldbStvetr5phuQWEE66061Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807433; c=relaxed/simple;
	bh=5gFC7EdB8/xgFsWt2M0tBFstQFI/o40iljpqi0GLwfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHVBo/JEpf/lchMNxsWegYSVVpG1+lsLO/2kGlCFMz7FEXVcxTqdutOxXHHkGo3xFca0BJXXLR+peaB0RnsWf2a4oX8JSmEGdI97TKiV3i8joxRgeUOzefFIq3NuAUbKK4caT1xR8vFca3M4KMyPsYyPMosXefEFEaoESO5k/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BHYtbeiS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1FEPeULg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BHYtbeiS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1FEPeULg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D3912540195;
	Mon, 17 Feb 2025 10:50:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Feb 2025 10:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807430;
	 x=1739893830; bh=pDlSVTnv+ExdQia0H72GhO6Tv2RISPyZbQpJAjatYfw=; b=
	BHYtbeiShgf6D4NkRiBMJYMEc8W3+/GwLJCuFj97CMxoLUcgLnr7r29aW4PjXBW9
	dWbBF04iOX/SjLk5SqJZ0BpNwOYPp6W8ZUqNXvszuAnxEulbifUUoDLFhnqztJ7M
	GBpagCNsyIk02IV6qkCAdMyaOzJfgRQoQkWCykzII7K0ep0a+Wr5oIYvdLtvg4wz
	cg6eUbFv7U4VIqEw5lNjWEN3YHWAjHUobvJaeyYD6xlwF+piDpZzeycxAbxBIFe9
	SoNxfmiHTxsgnp2ERBzcaGmAlzdK0Qg8PH8tbi0avtA2zfhZhNUB2OLSc2XSbWGH
	6/G1sDbE87U38ddkv8bIag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807430; x=
	1739893830; bh=pDlSVTnv+ExdQia0H72GhO6Tv2RISPyZbQpJAjatYfw=; b=1
	FEPeULgs839XGGNe+lt0D+xWxjhrjgIiE0/WYaeqi+Gtf3UaBB4V1nXjDpa8dQJS
	6KML+DbvnW5GWdQE9I3gJD3x7oBihwq99oKK1N0WhsmtFKAC9yinQwwaKg1ohc6o
	khMgBCL8WG4+L09RTzJucMqfadz6Fkbm15wKbXV7PL/8m6eapYJVVCYl+t/SMWx0
	HOXzNze3s/A/PdrkxvdHL3lmGEnYU0Vo7hOj4QZFyWYsbKMagEmEWbhnKcIc92Ye
	PmFCX9AvZsiI4diBGX4DSQDSmFj96SijFyID2HkyMHlmmRYBUhmQnBpfiTtvMgHj
	9/4+cQMTGyAOvHhrNKCyA==
X-ME-Sender: <xms:xVqzZ8ni1gNN5-3dRUpYOFSDj2YXD_w-S4xS2Y33d-TKu-qFF4rWdg>
    <xme:xVqzZ71BgVkKs8gcnmywrZfX_fztYR0IySevWlqGzOS8wLLhGj3aUvD-sYeJxXU8f
    2OQaPdV9z5n66Ue_Q>
X-ME-Received: <xmr:xVqzZ6ojtbQBiomCiNbIqe6Rb5w3gXht1PKJkWcWGNoh3_Lcx5ZrdsgM6rn29SV6KiUlNWPzAL-FiXZsE8-hMHwKojk3QSOccQ3DRqz_JUjvagA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhl
    hidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:xVqzZ4lXxkCA0Q6m__bXr4A0GzQEdNMD7zgovG82bxUr-oD40laIZg>
    <xmx:xVqzZ60fqIMWsaHfGGC-ZAcnxkIC350rMIHRQ6l60Qh07L6UIvLYAg>
    <xmx:xVqzZ_uGbdUX9tU_2Vqd_M8qYdR-XAe7_Uug5_GYLxTT5yp3PwGSFA>
    <xmx:xVqzZ2WM6dLuHRrJaiauUHitng8M1xc5hdMoaze_ppNY0pEPziYqOg>
    <xmx:xlqzZ0qM1nXibkKOGNJxPUmqUeB4kUXkx45LJt42urRKDczdx2G_wEqz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3cbf738 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:18 +0100
Subject: [PATCH 04/14] refs: introduce function to batch refname
 availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-4-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.48.1.666.gff9fcf71b7.dirty

