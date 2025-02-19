Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E541E51F5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971425; cv=none; b=habhl+DWjJRnyk7AjEjOnXOkG1jlWMvcZ7cHpfHLXoPRLUG/8lgUhrAPnsrVjzV3MdA6B4pbdXyHnEF1thberskI5NZwqmwnXeCmetT6e0NZKH6CCgxuJGeXn/yy4qJfv54PcPaMUC+7y5kdLG/2am7N6WAm3Gp0wro6cgrHBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971425; c=relaxed/simple;
	bh=GFYW8v1I1s3XR4mOR92PuvXxfEGPXj1fgJhTQ1qkl2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1dC6T3wz7rLonpVEJQmAA1ELuHts6tqWbUhb4JLm3USZeWLhaiIpErbTnoOTfCl9y2XMsm0Rf3vb1vZp8qJJbcAqafanc6nJVpfucgI5I0W9cTSSwrT9LMZ+/liYKbGKyQ9FAqPObLD8V3w/Bqs7T2epNvq0r4TUoC5KdtGuCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UikQ5fpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ME+dA8Vz; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UikQ5fpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ME+dA8Vz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6834625401C9;
	Wed, 19 Feb 2025 08:23:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 19 Feb 2025 08:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971422;
	 x=1740057822; bh=52NxtbIq9gxijQzHbbmME4VGu/SKyS5aRWCfR8SmDyc=; b=
	UikQ5fplYJCMqKHbh3I1HcLC0FKamq8e36A/6M9jhgXjewI6D/tNOvVF8MTRhIDX
	UzXWBW1xU29i+R7SPJxmVYQTxAw101YES6rnEnQywUw2tXbXfuSH+NLKa+RXepzT
	QLNuSnnYRECIxV+jkWr09ilCHQV+tluIQc9g/WSPFtsEDjzglYq+ti52FbSsg2yh
	yfgbn1JUUdrhQa0OSnhrxQ4abfGwH7+8dhKIhRWn1+dppsP10gGHBH5Y5CJVVHaq
	iMzCqrd3G8DBJyksx4TmIugn9S42V1ivpTRhxL3L2X90ny2pQlYlPcanEAU80Dqt
	YDE0mSrvclfQCNRgwM3tuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971422; x=
	1740057822; bh=52NxtbIq9gxijQzHbbmME4VGu/SKyS5aRWCfR8SmDyc=; b=M
	E+dA8Vz1quFw/7hWWvg8cyotv6mzBqfSDSS1R/Qp468/O/26JrEwSWGAxwmwdllT
	4M+52tXePl0gEevwJlFsFE9Au8Zq+G9v1XDEwiFJUL8mH/p+/jOkrzd/h82SkNdJ
	lAV1A7RGgv6H8peGhuno+LJuSqd9ADWOoVDlc3ly4bd9sY3cwD4AnJc2g5vERTFs
	mBdAAiRmDdp5br3ugekDYiuU4UGSdbW4f+s6cHcdrYp2A/LxNil5Igw6ol8la21p
	EK+Ezkle8+iaNxhFRuz99M6wGKObqT9RjmUKNYNtxxhVQJMz7gqvZtgfnrzzQ3xD
	wDVSQSaTkyY7aDpXMbu0A==
X-ME-Sender: <xms:Xtu1Z5Bn2SBTMuRh3cyxlWRkB5nLu6RT4rjPQ3velpA8vJEs9sForA>
    <xme:Xtu1Z3iUUvCX8q7Wu1f4LWZ0DrWQp24BO7lXHLWN9Y31d6FiRwKAJZCCHWKrlCyv7
    EvZkmIQXAZq-tBvsQ>
X-ME-Received: <xmr:Xtu1Z0lfjWo6Puw-Gltt7qkSdKw33t2CKRxZFezM0_DwUJRnPFCjawgZ-pb7aw27R8OslvhQGUZnJnXDceLfXluDHL7AtHeQrMpdsMSN_puZNaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhp
    rghsthgvrdhnvghtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Xtu1ZzyU_MtY6U1U-T9xjNl3sRl87pyvAZsh0bYOrXxJ5Jom0N9sig>
    <xmx:Xtu1Z-TJTLMDkZD89RvDlbcW389bWcyONREl8cwlvOs-7_4hCuyjjA>
    <xmx:Xtu1Z2ZqK6xulMXLLnZmTIeqtIcyxgHz5FrGcNZjxGbfx_nA2KSw5w>
    <xmx:Xtu1Z_SCuUxfxNVYRnpDEAm934Js5haRqNUgUpnd5osCD3OOQM4UHA>
    <xmx:Xtu1Z7Qs6uIORPOEy9yOCXlQPnjBAbGFuks8V-9_HrzxK3wmZ_X6ru0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f86a115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:31 +0100
Subject: [PATCH v2 04/16] refs: introduce function to batch refname
 availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-4-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
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

