Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABE618C92F
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273729; cv=none; b=pWwhs0LFGkAbv4lBYvRcnApL66G3DpDsWIOBj4WkSHVjwsm0Q+LMFqJH4pHVmTEys7jWheMxoeThkuQmU9rMyBvrB7EoMr89v4xaZnq1TH0H5nh1LnfLn4D0VNBypkiykXcdQpJ/G6pzesWEosEIu/K73PXd0MEPRMEpTImchVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273729; c=relaxed/simple;
	bh=sb3XjAxABCfF4cxMqn2HFJpx9Zi3qxhebaNSB7qO7N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZFjFga3UqpBkueU15W0PVpJTzV30o4LJcVhh/xiah9b0RUJgHNE76mZfEWCRBwAu+IQRHqx4bpwu0S3OaQT8PTW0yBARitxhOgD6PYL1huDpRfyFIt6mYsCQ4JQYLzRCgg8YJTVjDaJgGO1FZSIFfgaSVy2PLNsDRtFBS30ySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jNi1sGEQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRIZmSZh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jNi1sGEQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRIZmSZh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B2DC1140159;
	Thu,  6 Mar 2025 10:08:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 10:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273726;
	 x=1741360126; bh=5L67u+lvaBbUnCLveZ5tFpci4yebngppu3PmualLKfM=; b=
	jNi1sGEQi2/bnF9x43zlEkdzgHEe6bg4LzJC2dT4cZNDetcYJkjB2G/1SQVU8A/5
	ii4UMz8SJw4qyVm1ulGXm7Tr0wbJAWqHHC9lo3GN7zEP2fe90gNfaZ4hlD+s2g56
	nDXlGv2GvH2T8YeZM590jtVmyvzQwjiThmmA+gJLCTnkGbXXWAMlegQ7U+bn/s+r
	GlADYaa3VGBvV/oPP+3b+0eLd3Yc84+XN0i5HlQVryuNsLLBzeSHpOKcywSNiy00
	B9ae78wVN2g6YMk633rG/mrVCMdIhhZtH5xek/2V/qS3SyRWDb2Z6YgVHyGzvjRN
	fldw9MA9EFJtsjMKFwfhLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273726; x=
	1741360126; bh=5L67u+lvaBbUnCLveZ5tFpci4yebngppu3PmualLKfM=; b=c
	RIZmSZhczDWJMENA0lsi3RpHCi8mMF4RpNRoNx0QN0HcgK7Ov+NvgctLuc+H0y9E
	6/wQqDyxXYa/i1MkhZ6I+wZgYFX9dhiCuSUraDEWz8/p/x4VYPXgoNnZwKfaBWns
	QZeLSPDwSUrBBwSuJGYAK4j0xnjdfVcE1124UDWwzFFvGPJRQzc6V5Yz5G0lbXE+
	tC2fSKSjhDK1YY1W2mZKmgvzNJm8jqYYNtQrjbv8m2TueoygKu2ZvOY0e5UrRTMs
	vtZN1BZyXMF0V04OjFcqvmadhjOEWOyzvLECi3fI7JZXNkbDPs+srBgR1j46wo3T
	7lOs6QG+NkZ7DAFl5iz4Q==
X-ME-Sender: <xms:frrJZ-47kcA7tECtw18VLRTWuBRyvQKjfhICk38uNVc1NKQKJY2n5Q>
    <xme:frrJZ350DGUcIyj-Uf7TF_FebNC5dbc6SEDXgg3uRW97i-sfl-2Uzsgp9Yiu2z7Fg
    rrEU208KL1S6wA9gQ>
X-ME-Received: <xmr:frrJZ9clf9Zo0W4HBc5996oNTpzvsc0vO_pbYNofYlgAn61o6bOpTBrjHgudGfEk1wMqlh46GyUAMxgFEjy0ongqNrAf7XDcQLaIWvLsowsNXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:frrJZ7KyOSnhGHXtLSpQ1LzFAfu1J56gyD82Qmuwb4-iOhpHiDjNqw>
    <xmx:frrJZyLGeLiqwO9IuvqbpdJeoNy65SEEwBvjbwy9EOxIOmRYLjb8vw>
    <xmx:frrJZ8yErbGdNkR7I77lameXn1HRyLfxQVEiSrb98Uw_SL67N0ZX1Q>
    <xmx:frrJZ2Jk3lLfproTe1eU5W4oZEQM6Ct4JvTy6VNjbQeyaNjZsVY92g>
    <xmx:frrJZzoalLxtJJEhzlCdTASVPQldw3if7A3Cz9ccKXtiGmRYJg0o8kZk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9daacd11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:35 +0100
Subject: [PATCH v5 04/16] refs: introduce function to batch refname
 availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-4-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
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
2.49.0.rc0.416.g627208d89d.dirty

