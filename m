Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A41E1029
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058508; cv=none; b=KaY/1iBw/LL43CLikCHCQBPmih0W97B9Sb1X1bhwcjnDQtplSxwtvfZMpPumXGPuu3R21OopR06o3EpbihOSZfEsdit1HXgrwaEPPJWUukZ0TGWHCxXmREIZgvfuxlfZbfnWAIrcF2fePgQpb/aDf6NVBAbHf3xeJGCqUcT0SbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058508; c=relaxed/simple;
	bh=GVKapJcgBvEcwx9/o1xT+n205JH/lWlojRNYCjUViM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gk3XQeU3HmhpxENH2p1aG+XPLqe2UuKDb/5GORhC2FKvp0r8mNykOeMn1ilSdHnCk6+dt3bf6pxJY5W0kkv2+3KhVQfB3aThR9liiNFweYAPiOtFyVAQJz6cIMcqaCCjqjkrru2IhzzmiN+A1wAVvwLpFNVt9voxSGKi/mnXLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DTngErek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvBJ6lbM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DTngErek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvBJ6lbM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E279114014D
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 08 Nov 2024 04:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058505;
	 x=1731144905; bh=XmGzx5NozQ/6eT31AcMmb5ZlMbswWAmPRqJZntiYMM8=; b=
	DTngErek3Vk14TbUhSrJ7oDsVkhpdpylpyvD326xpY3ocOPw6vi+AoJmCpn8Sb2V
	1x1I3v0uLlRo/W6J5ikdgHvbuOTxYOiN+1sa/obimUBUZu5x7VBGe3eUx5pCMCwR
	lLJQ4CkJmxc96a+UY41d1MVHD+9a4aokPah512zo9hJLaBcKYm6GEfimrSYoF/iK
	97gbZV1FGuqKb/AL6h0CvA+UY01psGGazMU3x+FtIthBF6qab69cH4P/vJRKQ1im
	+0i/qhNGufI9K7nPR6CHBRvRabGtXdWSgPXW05PV1tx7cgu2br3DTCHP6OFfkQis
	27ZHyv6Vz7oRod2nnxsPsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058505; x=
	1731144905; bh=XmGzx5NozQ/6eT31AcMmb5ZlMbswWAmPRqJZntiYMM8=; b=P
	vBJ6lbMf9zk1w//qG+49QsPBv7YzRfVLr9NsIFIrTiPu8KD5nuocrxLG4SNiJz5U
	aOqdN2GPCKLKaxPuh9/CAM1XEIHMpI8gNJW+TGqbNFfXUE78xegMiTc3sAkKWBIQ
	mhCMG1mZhEI8u0Z8YW4T0nHmrZD3kjX5bls53cR2FrCLUMSpb3XVjWa7tXT4EjZ8
	tG+R5DFf6vUSZTCAjqmg8MHHipXqDyeXHK34v2Di9lwmecsnIBcKuoc6QcZq+8nx
	0+nXQnLf7P51VcmsmsUCJOvSn/TL3onNpZFRjGzyBIOcyOPx6bsto6HQPcNA7Dxn
	Mcsb8SV/GetmOy+r4Hh1g==
X-ME-Sender: <xms:SdstZ9W-oDuKFLTBIHVAInPQxa2A3OLVVhE1Bx-OJj9RqSs0q9VOMw>
    <xme:SdstZ9m6NrnElVUd4wLIL84VJnj1AeqA7XGYqoV2LenKb4f1qkfydRz1v1VFrtUhC
    7dE4liCfQUDwSX3WA>
X-ME-Received: <xmr:SdstZ5bcmG1_DkJSlNeeqNFK1RLWzbgaeZY75bRYRM1o_tdNE5bBgVR8byY9xldgomH9H0LkGXbm5zp5E_bUme1d97JasKI8ERp9FR3W0JA7h0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SdstZwUccLPZKJVlEEHBNb_pWdvrE-vzZIyLVN4x8Ck0jnqBgCNF1g>
    <xmx:SdstZ3kwyIZzdLzVbTP1CKy2Hicsd3OBTR9KOhyAE2yHVcA6nMt_7g>
    <xmx:SdstZ9f1O134hOQccJnnqEr95eZ4Tio0LIT1XtGuJEm8hLy6w6pBZA>
    <xmx:SdstZxFoOBjGECmTYAO_UD5yy4ZOgingVi8HaIMxqSVrVtZkw02JQw>
    <xmx:SdstZ_vC6gVYg2XOAkCBUZQJL0L-7gC4MVeRfrXCPXNDYirr-cPYybC4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1c217df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:43 +0100
Subject: [PATCH 03/10] refs: introduce "initial" transaction flag
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-3-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

There are two different ways to commit a transaction:

  - `ref_transaction_commit()` can be used to commit a regular
    transaction and is what almost every caller wants.

  - `initial_ref_transaction_commit()` can be used when it is known that
    the ref store that the transaction is committed for is empty and
    when there are no concurrent processes. This is used when cloning a
    new repository.

Implementing this via two separate functions has a couple of downsides.
First, every reference backend needs to implement a separate callback
even in the case where they don't special-case the initial transaction.
Second, backends are basically forced to reimplement the whole logic for
how to commit the transaction like the "files" backend does, even though
backends may wish to only tweak certain behaviour of a "normal" commit.
Third, it is awkward that callers must never prepare the transaction as
this is somewhat different than how a transaction typically works.

Refactor the code such that we instead mark initial transactions via a
separate flag when starting the transaction. This addresses all of the
mentioned painpoints, where the most important part is that it will
allow backends to have way more leeway in how exactly they want to
handle the initial transaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c         |  4 ++--
 refs.c                  | 10 +---------
 refs.h                  | 37 ++++++++++++++++++-------------------
 refs/debug.c            | 13 -------------
 refs/files-backend.c    | 16 ++++++++--------
 refs/packed-backend.c   |  8 --------
 refs/refs-internal.h    |  1 -
 refs/reftable-backend.c |  8 --------
 8 files changed, 29 insertions(+), 68 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d963cc6eb5181e1af5bb29c07c3ee2fa24ad04ca..8427ccec17e77b23ee1a7f526b80a52d79a71873 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -574,7 +574,7 @@ static void write_remote_refs(const struct ref *local_refs)
 	struct strbuf err = STRBUF_INIT;
 
 	t = ref_store_transaction_begin(get_main_ref_store(the_repository),
-					0, &err);
+					REF_TRANSACTION_FLAG_INITIAL, &err);
 	if (!t)
 		die("%s", err.buf);
 
@@ -586,7 +586,7 @@ static void write_remote_refs(const struct ref *local_refs)
 			die("%s", err.buf);
 	}
 
-	if (initial_ref_transaction_commit(t, &err))
+	if (ref_transaction_commit(t, &err))
 		die("%s", err.buf);
 
 	strbuf_release(&err);
diff --git a/refs.c b/refs.c
index 9effeb01eb45728514eab0ca92404ea8cf2158d9..8b9dfc6173fd144fe9a172cb81cf33057ae31368 100644
--- a/refs.c
+++ b/refs.c
@@ -2315,7 +2315,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	}
 
 	ret = refs->be->transaction_finish(refs, transaction, err);
-	if (!ret)
+	if (!ret && !(transaction->flags & REF_TRANSACTION_FLAG_INITIAL))
 		run_transaction_hook(transaction, "committed");
 	return ret;
 }
@@ -2486,14 +2486,6 @@ int refs_reflog_expire(struct ref_store *refs,
 				       cleanup_fn, policy_cb_data);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
-{
-	struct ref_store *refs = transaction->ref_store;
-
-	return refs->be->initial_transaction_commit(refs, transaction, err);
-}
-
 void ref_transaction_for_each_queued_update(struct ref_transaction *transaction,
 					    ref_transaction_for_each_queued_update_fn cb,
 					    void *cb_data)
diff --git a/refs.h b/refs.h
index 9821f3e80d900b31c3dede489c2f415d968233d7..024a370554e013d66febee635e4c0415ba061fe6 100644
--- a/refs.h
+++ b/refs.h
@@ -214,11 +214,9 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  *
  *   Or
  *
- *   - Call `initial_ref_transaction_commit()` if the ref database is
- *     known to be empty and have no other writers (e.g. during
- *     clone). This is likely to be much faster than
- *     `ref_transaction_commit()`. `ref_transaction_prepare()` should
- *     *not* be called before `initial_ref_transaction_commit()`.
+ *   - Call `ref_transaction_begin()` with REF_TRANSACTION_FLAG_INITIAL if the
+ *     ref database is known to be empty and have no other writers (e.g. during
+ *     clone). This is likely to be much faster than without the flag.
  *
  * - Then finally, call `ref_transaction_free()` to free the
  *   `ref_transaction` data structure.
@@ -579,6 +577,21 @@ enum action_on_err {
 	UPDATE_REFS_QUIET_ON_ERR
 };
 
+enum ref_transaction_flag {
+	/*
+	 * The ref transaction is part of the initial creation of the ref store
+	 * and can thus assume that the ref store is completely empty. This
+	 * allows the backend to perform the transaction more efficiently by
+	 * skipping certain checks.
+	 *
+	 * It is a bug to set this flag when there might be other processes
+	 * accessing the repository or if there are existing references that
+	 * might conflict with the ones being created. All old_oid values must
+	 * either be absent or null_oid.
+	 */
+	REF_TRANSACTION_FLAG_INITIAL = (1 << 0),
+};
+
 /*
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
@@ -798,20 +811,6 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 int ref_transaction_abort(struct ref_transaction *transaction,
 			  struct strbuf *err);
 
-/*
- * Like ref_transaction_commit(), but optimized for creating
- * references when originally initializing a repository (e.g., by "git
- * clone"). It writes the new references directly to packed-refs
- * without locking the individual references.
- *
- * It is a bug to call this function when there might be other
- * processes accessing the repository or if there are existing
- * references that might conflict with the ones being created. All
- * old_oid values must either be absent or null_oid.
- */
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err);
-
 /*
  * Execute the given callback function for each of the reference updates which
  * have been queued in the given transaction. `old_oid` and `new_oid` may be
diff --git a/refs/debug.c b/refs/debug.c
index 45e2e784a0f8c49f492eaa9d371aa44f8c7916c3..cbac62c8a4f924580e80f106f87639daf77cef5c 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -118,18 +118,6 @@ static int debug_transaction_abort(struct ref_store *refs,
 	return res;
 }
 
-static int debug_initial_transaction_commit(struct ref_store *refs,
-					    struct ref_transaction *transaction,
-					    struct strbuf *err)
-{
-	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
-	int res;
-	transaction->ref_store = drefs->refs;
-	res = drefs->refs->be->initial_transaction_commit(drefs->refs,
-							  transaction, err);
-	return res;
-}
-
 static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
 {
 	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
@@ -443,7 +431,6 @@ struct ref_storage_be refs_be_debug = {
 	.transaction_prepare = debug_transaction_prepare,
 	.transaction_finish = debug_transaction_finish,
 	.transaction_abort = debug_transaction_abort,
-	.initial_transaction_commit = debug_initial_transaction_commit,
 
 	.pack_refs = debug_pack_refs,
 	.rename_ref = debug_rename_ref,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f37c805a34167b3749fbe724788180975abdae90..3ed18475a72aa4798d15b2912c37b4caabd47aac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2781,6 +2781,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 
 	assert(err);
 
+	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
+		goto cleanup;
 	if (!transaction->nr)
 		goto cleanup;
 
@@ -2985,13 +2987,10 @@ static int ref_present(const char *refname, const char *referent UNUSED,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-static int files_initial_transaction_commit(struct ref_store *ref_store,
+static int files_transaction_finish_initial(struct files_ref_store *refs,
 					    struct ref_transaction *transaction,
 					    struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		files_downcast(ref_store, REF_STORE_WRITE,
-			       "initial_ref_transaction_commit");
 	size_t i;
 	int ret = 0;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
@@ -2999,8 +2998,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 
 	assert(err);
 
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		BUG("commit called for transaction that is not open");
+	if (transaction->state != REF_TRANSACTION_PREPARED)
+		BUG("commit called for transaction that is not prepared");
 
 	/* Fail if a refname appears more than once in the transaction: */
 	for (i = 0; i < transaction->nr; i++)
@@ -3063,7 +3062,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
-	if (initial_ref_transaction_commit(packed_transaction, err)) {
+	if (ref_transaction_commit(packed_transaction, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 	}
 
@@ -3091,6 +3090,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
 
 	assert(err);
 
+	if (transaction->flags & REF_TRANSACTION_FLAG_INITIAL)
+		return files_transaction_finish_initial(refs, transaction, err);
 	if (!transaction->nr) {
 		transaction->state = REF_TRANSACTION_CLOSED;
 		return 0;
@@ -3617,7 +3618,6 @@ struct ref_storage_be refs_be_files = {
 	.transaction_prepare = files_transaction_prepare,
 	.transaction_finish = files_transaction_finish,
 	.transaction_abort = files_transaction_abort,
-	.initial_transaction_commit = files_initial_transaction_commit,
 
 	.pack_refs = files_pack_refs,
 	.rename_ref = files_rename_ref,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 07c57fd541a5039d5fcb93d9bf78e1916f67b219..794471de60c78494f1f2b0e9de013422e3e7625d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1730,13 +1730,6 @@ static int packed_transaction_finish(struct ref_store *ref_store,
 	return ret;
 }
 
-static int packed_initial_transaction_commit(struct ref_store *ref_store UNUSED,
-					    struct ref_transaction *transaction,
-					    struct strbuf *err)
-{
-	return ref_transaction_commit(transaction, err);
-}
-
 static int packed_pack_refs(struct ref_store *ref_store UNUSED,
 			    struct pack_refs_opts *pack_opts UNUSED)
 {
@@ -1769,7 +1762,6 @@ struct ref_storage_be refs_be_packed = {
 	.transaction_prepare = packed_transaction_prepare,
 	.transaction_finish = packed_transaction_finish,
 	.transaction_abort = packed_transaction_abort,
-	.initial_transaction_commit = packed_initial_transaction_commit,
 
 	.pack_refs = packed_pack_refs,
 	.rename_ref = NULL,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index dbc6360c5a1d410c192e7eee1bffb1d423e1f9ee..33335d54c9162755c70174093017439c0018f36d 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -666,7 +666,6 @@ struct ref_storage_be {
 	ref_transaction_prepare_fn *transaction_prepare;
 	ref_transaction_finish_fn *transaction_finish;
 	ref_transaction_abort_fn *transaction_abort;
-	ref_transaction_commit_fn *initial_transaction_commit;
 
 	pack_refs_fn *pack_refs;
 	rename_ref_fn *rename_ref;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 38eb14d591ec0c7c221b6b0f7483e547748e7f1c..8e914afc817f198bed3199630b430e179cabc740 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1490,13 +1490,6 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	return ret;
 }
 
-static int reftable_be_initial_transaction_commit(struct ref_store *ref_store UNUSED,
-						  struct ref_transaction *transaction,
-						  struct strbuf *err)
-{
-	return ref_transaction_commit(transaction, err);
-}
-
 static int reftable_be_pack_refs(struct ref_store *ref_store,
 				 struct pack_refs_opts *opts)
 {
@@ -2490,7 +2483,6 @@ struct ref_storage_be refs_be_reftable = {
 	.transaction_prepare = reftable_be_transaction_prepare,
 	.transaction_finish = reftable_be_transaction_finish,
 	.transaction_abort = reftable_be_transaction_abort,
-	.initial_transaction_commit = reftable_be_initial_transaction_commit,
 
 	.pack_refs = reftable_be_pack_refs,
 	.rename_ref = reftable_be_rename_ref,

-- 
2.47.0.229.g8f8d6eee53.dirty

