Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE525CC71
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734814; cv=none; b=Dx/gggA/4FgnFtLwMuCF9OHIiACrO/pEmunIkYmS9qeS7J745fEaspw3Bk152KByCKvKLQXQ0wiIglwVKMdRCDvgQ8CvXyQv5Co0KOTnCpIWTdlE3lVrTV0oO9o4JLMRr4gmKu0PCblnKb4+DqBXcs8prvwe+N0aTZwFMPlFoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734814; c=relaxed/simple;
	bh=0qawj0E4jta5o8sE1eDpIqHhagoOjxlHxN+DG6Qep1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=An6CHuaHiydVYsjh8oRqcCnzl9CXEV4bRu/MVzHrRpsIh1TPcn2b7U0e8SFay3ZZoWcAGhLQzf0jgOvSIAD9jpNxbcg9c7kl6yhyGs5/1yqWFndv161EKG7YTLtGQ5xwBwPMqWZ4Crdaji1lddpOyUsztfxM37JqLGRvnBxJV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TMDb6Zt4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EA86q4bb; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TMDb6Zt4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EA86q4bb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CB441382774;
	Fri, 28 Feb 2025 04:26:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 04:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734811;
	 x=1740821211; bh=j30QANnJYLd5SE0LGqA6iJXgRSo9UPh0EEit02YNLe0=; b=
	TMDb6Zt4azTCb9eVRLZ9zM+swgzaj7Sl6llPXybXzkrcGwIMVrwxevINQ4uIozkP
	KpODpkkeIU7bErp9OLXCt5q5JrM51D8b8OL4S6TKCIJ/5AucJl075PlS4CAEe3Co
	FtuFGXQDp5bhl4tytmWZCIl7FitmxffvLNT9HU0QQbu54oPBgR6aJcPf8zmZ8v6W
	SNTGwGjcoE+1NGx9pWmd6c28RgXVyUla+L1eilmITlYN83OuNFdBB00jzw3D0unI
	eTZYyrtLc2xNfd+mQgOPCgtqco546EkMZgf/egGlPtt5svQeP39JOAAuyejMjo4D
	XpWqY2YDFXeia1SlK3aBiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734811; x=
	1740821211; bh=j30QANnJYLd5SE0LGqA6iJXgRSo9UPh0EEit02YNLe0=; b=E
	A86q4bbEOsFajIDtRhYy7+T5jWTp9LvwUAUwzQkUZWQFYRG7PZpJIoaijlnFdpFB
	jxL3kKeG+RCzfh1enoaAqRg4gdjYlGciz0/rRjGQ113bVWRd0bIchTKyZ6RtBhDR
	vDem1Lr3whnL19GhtSpfq7yq0o2/BL7jY/uTctLasFOcbaGcdxk8CqVRvf4A6Ior
	YNH28UhsW9gtclm/EHC/jck1DDdjkVAxPUpktAbjsPj+VXU3dqdNUyjEB07/EaD+
	LvSGRXAGXKj0wFRUNYkeZnl1fFawtJ1ldt+5Rr1HGFFlK/5MfNK/D2il7q5UrsPS
	SETbh49uCFtwLLuWUyoCg==
X-ME-Sender: <xms:W4HBZ6kjXjGialoSd6afpZVGlV8y7G-HNaD6CvrsEFdURUiK5YTRzw>
    <xme:W4HBZx0h4U6NcdhUXZ9FO2lOg7HeILUHKygjt7Hgl5WViYRl09F-XfiOFlJyimeQn
    MWYx_vm7Uwemml4Uw>
X-ME-Received: <xmr:W4HBZ4p_t32wYIfY7t5NsScy3wykM5BhNUg4VCxkObGqT1bpqJ1j1Hjfmqd3gwEcBaBZuw0SeOC0ucy-jQmrHxsSDdFhTwBbWDXzmjtPJKF8WUDN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:W4HBZ-m10uccC-r2wY2QzCtxmgxjMyE6FWK5f4tuyvnlsaL8SRxv9w>
    <xmx:W4HBZ42ONgHburqgr0HHWOhW-S8ggApqM_fXHOIhl_K-aAm20-Q6Pw>
    <xmx:W4HBZ1v8L7nRaoo1QDGWXVY9VxuRjfSFG-dwE1QyZorlvIqJovBwig>
    <xmx:W4HBZ0XGqfZpEhrJfB_Q3UBxlumhYR0kD1EqYPaIeGbtzkEEICh45A>
    <xmx:W4HBZ5ks-ZxhtfHs9hjWG28WJTJJ-tBhgm1o2Cgam3I1OC9ZTXizNwXI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee8bef25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:41 +0100
Subject: [PATCH v4 04/16] refs: introduce function to batch refname
 availability checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-4-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

