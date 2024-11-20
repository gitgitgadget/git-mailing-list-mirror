Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2233B176228
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089112; cv=none; b=j6Q1bIL5zp0foT+tdmB2QPkHMg53oxLtmpbjdEkRWcbfnSaFzFlQwG5wYmc5LPRfWvIItR+/DbGI5WgryrYKH4JnAHu6gFm82WGiJl0ym2Y/Cl6x+ZzRy6ZEO0Vu5X+K4HrskiDUh6AW/hekqP88UdkTSTbsS6GHWMEjI3Lx2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089112; c=relaxed/simple;
	bh=+Uwc3xjLWJvRePpSjVTFQL5k03DdN+oHOd19nvQebaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hafJdirwbAt5Q3hax3rvl7UtvKpXN1cvRpNI2wC1OeMwH7ysmoNS+y2ywO007Sm3MOWWlDJzsMmW2DQ91+GCCTIR13F77KDcr4I+362KFyLn6ptUl4HoE4E8hC7a+NaGOLz+1tZhU3rx/wMN83slA8CKQSX4Bw6V310v/YUnY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BRRhTAlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oesFgWd3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BRRhTAlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oesFgWd3"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 103B61380145;
	Wed, 20 Nov 2024 02:51:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 02:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089107;
	 x=1732175507; bh=mUHpaGqWxOABI7aboTea5JRKBbCXIxBofeVwe0KNTQk=; b=
	BRRhTAlPkkS0wOnL2U5ovaRjUai76R8gaRrtgtSfc6ID8oigLWhhn/H79MUOTK0Z
	3y5x9n5Vu3EYLBPyaGHjAH0x6p2+/gOenuYgSGZnHle2Gy51Q3tPwBqrPPvilPWG
	uz37c8kWUzOixAY8O6+t4lGnxFyyEsR+qcFqqRfyCBwzwl8jBj1fTkrQen9yDnpZ
	Pt+0K0+H/vEouILEvu0ri9qD0tENEopZ0eGE03ma7xzNe6uYeeSGXNTpzoZlgwjF
	DPM8tUTksz5ASLK92cHi9h6MjFxlzuTwUUciQal+AaMj7xdB0VlW4jmHH2j6NcER
	yFLha7kIyh/e0X0eK/fmEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089107; x=
	1732175507; bh=mUHpaGqWxOABI7aboTea5JRKBbCXIxBofeVwe0KNTQk=; b=o
	esFgWd3sLcBuuliAnxwaoh3zPPTlyIk7lHfFuIn+myLuzrlyDXC7pkrBO8sZwxC3
	mQ9Y8Ll1TP/3nyv2YGMEB1oxs+J7UJ7pGnBx9IxCjfh/THZcthYz4t4E2Fc11GBt
	Sq+Z7SL+JxtNy+ZD+du5v4LK8Jgk5w+EtwofyAa4QeRdp4u5bHFboP9xdvtZBUTP
	fIaznko1MquoHrYopcTNkwqhSd2e4s1ul8mIq5MBvFLLYS2gC+UdwcT/vry06tFS
	z6ujWViJEJfVxWXrJKNcnuzowGwdbKKhi7fy4BM08VG43Isx3h4oTLLhvnkTVR1/
	WvVHNk4L1st3HcxHP+TjQ==
X-ME-Sender: <xms:EpU9Z8s3U7rzIvFFWgyE6M0RU5a50KIe9v8vVHZKGdvVwIYJ_lMqGA>
    <xme:EpU9Z5c_qdpefoKiQIbFFdt67kVELcj7faqnsNih-g_P7ylydqgTT1CODiPcoBpDI
    u3yASHytTkiBcBYng>
X-ME-Received: <xmr:EpU9Z3wVxrF8Y-HMXxREuIQWnx8tFUPUiT1tGtchYStnrd9TxG2mT5rObFYBc4XWG57Gk5qfQgKKveNHg3E3SMb5TQvBGStEe_CpuMJKO-M-QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EpU9Z_P510Nwvra0YKqrGEbjeaHpasMprORnVthcrIoNuiL3OoIWdg>
    <xmx:EpU9Z8-CzU84ECFjZrhAY7AV5vN4AgsQGKzkdpvrvjeL9OilrYKXSg>
    <xmx:EpU9Z3VIwTeUlm6j1aAT1kXeiBgMdmwiBW7hWwInyqKjU3u8mDtNlg>
    <xmx:EpU9Z1eJ3hgjol-B7C9TBSFHR5pO6CzPbxSB_TQwwN4uooYnzZGmIQ>
    <xmx:E5U9Z7ZnfEVjpbeqB2naBBFbuwrtnRUBuym6BOwENJALd2GKhYZFJOSv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c735bbf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:32 +0100
Subject: [PATCH v2 03/10] refs: introduce "initial" transaction flag
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-3-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.47.0.274.g962d0b743d.dirty

