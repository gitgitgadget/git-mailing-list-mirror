Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FE1885B8
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603395; cv=none; b=NS1nD+Cz6w9Xw6WCz4TektYaClsB20RfgtsPOPLveheZJs9hMsyUkW+FGIDTQL3kDw26AT8cbxR6xTxNSUVBClmwk6LZNc1TSKdJvsMZo90Hfbgs1/73KsoWh0dVJh/X3KBjcdmDxdiWhUiajMDUOHYyB9VlBnw2Y0JMuFOSgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603395; c=relaxed/simple;
	bh=vMaXWD6ttWCSMPHXBiy/O+nxK4ISvrAJ2Md30isUYzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dvSKs0zhSqkm0U/zjcPDswvhVM6+Q0B8KZLRA68cKXTQT8zBqLD/pMgTYJNv/gTUFRmfcFB7A4Q+Yd6VGvIVBi8Gc1U4ma56GDOn7IlSYICTIRRDt7ahK1rUdDL3vQeRyGB7zfpHa19GaN5s/5YEWMbwn84s69xi8YiPtV91Adw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PexhGmkJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aqdTmw93; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PexhGmkJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aqdTmw93"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C462911401DB;
	Tue, 26 Nov 2024 01:43:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 26 Nov 2024 01:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603392;
	 x=1732689792; bh=rrpKqUUtgI5A79upr2He4K8JA4XHxs+3PqRNii+aRuA=; b=
	PexhGmkJKyiKw8PhHroxN0Beey1fIher8lpYhRrZGTwpmJw8Qhz2K+oC/mvRmhN9
	UAOZlq4xT84e+WC8fNBBQCkMTP4kDSumYuSEcwBa+kMwf3433iUIu8WQrZo8aSzx
	VBFs2+WlGcSkLY3A17ICT7YDKxVDdW1V6Tp5HdXuOX97dBnn4GfBigR69mPJCs4s
	fULFh6cTXSrj3g1Lxy0fLywKlO1tpsf9Gt1/dgw6m8p2O2BxBDvfWinIMQKR7uk7
	Q3mvMoZj5w0F2hYKwmVAt0+iRpwXDfxPnIpHfehwNz/mVujzgtzRbVgkjberHL0L
	rc7gJ2/E6UexgKrLIyXaEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603392; x=
	1732689792; bh=rrpKqUUtgI5A79upr2He4K8JA4XHxs+3PqRNii+aRuA=; b=a
	qdTmw931GUfL8WOp8wRPd6xPp8diNHLaG0OgAAvgNZhR329G8Ligle21NVhIj5cc
	tR7CpFBum4lu7GJSYFiRTieUfrp11t2MXUJ0SmqnYeSBBZ92ptauKOZP17pBQHr6
	ny62Y/DPvMJ37qYPHGP9hyVmBxEUU4WTTmSicyagzIaCtnszPK9axK3SMyFkDv93
	/JJOz+4X6wV37aHfGV+dckXucFNOxIde3T+GWZTGm8MPY5JzsCGKAbAAy5nesJKC
	3q/Cb1i5gtr/PXDxZUsACo369xMjpR3rqUE/2pBdzKOnl80fMvP3OVbXjMjNAToh
	qbTNiBZpX4NeHAG2UUfTw==
X-ME-Sender: <xms:AG5FZ5XsVh1O4GRu9pfaBc8LVnuLSo0XeGnOeSQdg-ODsYfUE-x2IQ>
    <xme:AG5FZ5m14i1uFVyXMvD09edMIywUGlOOyh4I9_L-K5T_nh4IfjTdUdPGMmbnWHUgf
    T-HURdFYkNYihx_yg>
X-ME-Received: <xmr:AG5FZ1YgG0cy7VC2koiLCeqv_l2oMnsU49ha6azB57d9jFHO1wWFHjB-vmjwRmordyVoGT8Ld2GNnCAxxsIJI7-whe0JTo3G_hnfbVrBNnr7oo7l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfefieevffduhfejvdevfffhudekhfdvkeevveegueei
    teetveeglefghfevtdfgnecuffhomhgrihhnpehuphgurghtvgdrthiinecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AG5FZ8V0xU0hdup6dcdWHFQ5YF8foSQfTqx6pOrT8qLROlpksb3Kpg>
    <xmx:AG5FZzl62zvqqfHqKrn3paXc-3sPkGy6dlDzcDIWzBVCBeKJl_OxLg>
    <xmx:AG5FZ5fctEcDHkmiHF5PmMfhihW904Dvg9pxhWe8GAQT1--ian1HMg>
    <xmx:AG5FZ9EnA8YLZaUe5FxxtCRU3HjRPyfUkPrGY_ayyy5v3ZoeJU_QMw>
    <xmx:AG5FZxiezSOR29AGxzHI4QX8LFU7ykv9KOYsKSjunmmfWF7e-mhYTObf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c3a0c50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:56 +0100
Subject: [PATCH v4 05/10] refs/reftable: read references via `struct
 reftable_backend`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-5-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor `read_ref_without_reload()` to accept `struct reftable_backend`
as parameter instead of `struct reftable_stack`. Rename the function to
`reftable_backend_read_ref()` to clarify its scope and move it close to
other functions operating on `struct reftable_backend`.

This change allows us to implement an additional caching layer when
reading refs where we can reuse reftable iterators.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 122 +++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 63 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 302de622d44ccbe8eceee0654f11ad7184791eba..88910207b87b1fa5bbbedebc8817f8afab937b77 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -51,6 +51,50 @@ static void reftable_backend_release(struct reftable_backend *be)
 	be->stack = NULL;
 }
 
+static int reftable_backend_read_ref(struct reftable_backend *be,
+				     const char *refname,
+				     struct object_id *oid,
+				     struct strbuf *referent,
+				     unsigned int *type)
+{
+	struct reftable_ref_record ref = {0};
+	int ret;
+
+	ret = reftable_stack_read_ref(be->stack, refname, &ref);
+	if (ret)
+		goto done;
+
+	if (ref.value_type == REFTABLE_REF_SYMREF) {
+		strbuf_reset(referent);
+		strbuf_addstr(referent, ref.value.symref);
+		*type |= REF_ISSYMREF;
+	} else if (reftable_ref_record_val1(&ref)) {
+		unsigned int hash_id;
+
+		switch (reftable_stack_hash_id(be->stack)) {
+		case REFTABLE_HASH_SHA1:
+			hash_id = GIT_HASH_SHA1;
+			break;
+		case REFTABLE_HASH_SHA256:
+			hash_id = GIT_HASH_SHA256;
+			break;
+		default:
+			BUG("unhandled hash ID %d", reftable_stack_hash_id(be->stack));
+		}
+
+		oidread(oid, reftable_ref_record_val1(&ref),
+			&hash_algos[hash_id]);
+	} else {
+		/* We got a tombstone, which should not happen. */
+		BUG("unhandled reference value type %d", ref.value_type);
+	}
+
+done:
+	assert(ret != REFTABLE_API_ERROR);
+	reftable_ref_record_release(&ref);
+	return ret;
+}
+
 struct reftable_ref_store {
 	struct ref_store base;
 
@@ -243,50 +287,6 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
 	log->value.update.tz_offset = sign * atoi(tz_begin);
 }
 
-static int read_ref_without_reload(struct reftable_stack *stack,
-				   const char *refname,
-				   struct object_id *oid,
-				   struct strbuf *referent,
-				   unsigned int *type)
-{
-	struct reftable_ref_record ref = {0};
-	int ret;
-
-	ret = reftable_stack_read_ref(stack, refname, &ref);
-	if (ret)
-		goto done;
-
-	if (ref.value_type == REFTABLE_REF_SYMREF) {
-		strbuf_reset(referent);
-		strbuf_addstr(referent, ref.value.symref);
-		*type |= REF_ISSYMREF;
-	} else if (reftable_ref_record_val1(&ref)) {
-		unsigned int hash_id;
-
-		switch (reftable_stack_hash_id(stack)) {
-		case REFTABLE_HASH_SHA1:
-			hash_id = GIT_HASH_SHA1;
-			break;
-		case REFTABLE_HASH_SHA256:
-			hash_id = GIT_HASH_SHA256;
-			break;
-		default:
-			BUG("unhandled hash ID %d", reftable_stack_hash_id(stack));
-		}
-
-		oidread(oid, reftable_ref_record_val1(&ref),
-			&hash_algos[hash_id]);
-	} else {
-		/* We got a tombstone, which should not happen. */
-		BUG("unhandled reference value type %d", ref.value_type);
-	}
-
-done:
-	assert(ret != REFTABLE_API_ERROR);
-	reftable_ref_record_release(&ref);
-	return ret;
-}
-
 static int reftable_be_config(const char *var, const char *value,
 			      const struct config_context *ctx,
 			      void *_opts)
@@ -867,7 +867,7 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 	if (ret)
 		return ret;
 
-	ret = read_ref_without_reload(be->stack, refname, oid, referent, type);
+	ret = reftable_backend_read_ref(be, refname, oid, referent, type);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -1103,8 +1103,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 
-	ret = read_ref_without_reload(be->stack, "HEAD",
-				      &head_oid, &head_referent, &head_type);
+	ret = reftable_backend_read_ref(be, "HEAD", &head_oid,
+					&head_referent, &head_type);
 	if (ret < 0)
 		goto done;
 	ret = 0;
@@ -1179,8 +1179,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(be->stack, rewritten_ref,
-					      &current_oid, &referent, &u->type);
+		ret = reftable_backend_read_ref(be, rewritten_ref,
+						&current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
 		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
@@ -1638,7 +1638,7 @@ struct write_create_symref_arg {
 
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
+	struct reftable_backend *be;
 	const char *oldname;
 	const char *newname;
 	const char *logmsg;
@@ -1663,7 +1663,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
 		BUG("failed splitting committer info");
 
-	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
+	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
 		ret = error(_("refname %s not found"), arg->oldname);
 		goto done;
 	}
@@ -1702,7 +1702,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * the old branch and the creation of the new branch, and we cannot do
 	 * two changes to a reflog in a single update.
 	 */
-	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->stack);
+	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
 	if (arg->delete_old)
 		creation_ts++;
 	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
@@ -1745,8 +1745,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 		logs_nr++;
 
-		ret = read_ref_without_reload(arg->stack, "HEAD", &head_oid,
-					      &head_referent, &head_type);
+		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
+						&head_referent, &head_type);
 		if (ret < 0)
 			goto done;
 		append_head_reflog = (head_type & REF_ISSYMREF) && !strcmp(head_referent.buf, arg->oldname);
@@ -1789,7 +1789,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * copy over all log entries from the old reflog. Last but not least,
 	 * when renaming we also have to delete all the old reflog entries.
 	 */
-	ret = reftable_stack_init_log_iterator(arg->stack, &it);
+	ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -1862,7 +1862,6 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1876,11 +1875,10 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = backend_for(&be, refs, newrefname, &newrefname, 1);
+	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	arg.stack = be->stack;
-	ret = reftable_stack_add(be->stack, &write_copy_table, &arg);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -1894,7 +1892,6 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1907,11 +1904,10 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = backend_for(&be, refs, newrefname, &newrefname, 1);
+	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	arg.stack = be->stack;
-	ret = reftable_stack_add(be->stack, &write_copy_table, &arg);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);

-- 
2.47.0.366.gd4f858ca17.dirty

