Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9F1E130D
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058507; cv=none; b=uOfnxvRreTmEDfHY8/pmNy0jOEhD7f9tnMApsiC00rfGVpbeHCIfxyfeyeGokc5bf2WGIWQEFUHna/GU/0w16AjpDGFWlQRSXQKuLQx293xJs2yJl75wCCMPdUc29p6KNgyXUIcUTPAF/+IbtDdJ973EZQGsbiUMzuCZAPNrFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058507; c=relaxed/simple;
	bh=A//RT7ZSKUzbCXM/PtKZGnFj6RdvlHMafWhWDuKdetA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mO/sJVcPtyPFhyJrvHSWnrVg3c5/gvNEmB2HM6cwkm1vPL6D9Wvrq5ODR+vQi2YrUvTEU4tDTFACSM0HF187xpna/O9ag0E0chez8xh/V/bM6iU2wZR8TdKryoBpS1wK0FP9P84HJaIanHtuRldzcZpAOPOEm5p3tDq5KplTJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kjm2r6WB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiHJGqah; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kjm2r6WB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiHJGqah"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 688DE11400D1
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 08 Nov 2024 04:35:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058504;
	 x=1731144904; bh=PbBEe3j678u+fe4h3+u9ugbFyjGEI7LV5pCsCFDhhAg=; b=
	Kjm2r6WBbe3O88HvVTVWM6xytuTDq/4tz9+mZjBvcfMb3Zto5EgkQgNzHtH8oJkB
	Nju2FkK7kFpmfwljQfw7JupjdxGvoP9YtWJ+XnCBkcFlNEi84N33nmoV7Si+icf1
	vJt3t05xiIJTrNS8XMxtGXI7BWCK9YxgWtJPI8AXNlbyhlD/iVAy6JmOdCFodwyH
	RAFwucZ7TOFZtTV1KRxNdJc9KmdsHLbkqfJAlT4fBtZDKS9ARLWfQAD/9c1YYAhJ
	RMhscaVcO0CfX+xAWz4gheEY44l/CEmj3B3yvSRn8Yr+yz9CSVi5mwDrUlu9xUGy
	ODLNNDqqvJqW6ecB2XGDGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058504; x=
	1731144904; bh=PbBEe3j678u+fe4h3+u9ugbFyjGEI7LV5pCsCFDhhAg=; b=T
	iHJGqahr6nkZFytAac8IADksJhAyp2EkdmJgeY5eB+XiWGs7IyKr2Mylv0BtFxAW
	pV7bxnF2dik0qcEDYbVlTbIPnkl+5KHYOHovFhicy0vCl0TaV5pg1BfdKEUi6MNh
	0DURVh8b933Mfk9OqMvDIeHzN+qaIv1hNB5NP4KZA+IfDcZ+PCVoUV4oI/zskG76
	1WDGOAa1hFA4VXQZJSydT6gtGkVoFhMn85k35B4NCZvXvKD6ZG1+ThA204Q8/9QA
	A7LqWXXAt5Nf2hrKke2fVV1O8rlrMthlRTSqbZyoVj88nQ+BySoqhaLFQoUhtEGf
	FTh8qnoo2NxS9kVXUWsMA==
X-ME-Sender: <xms:SNstZ3qjPpaAxckNW5h8qUoe2dw6CmV9POY0GRWQqd4hnOE8vu60Kw>
    <xme:SNstZxpT-QdjWJTF0GGxD0uzmGXR7dGobOq0GzzmC4ArSrdF71USbv-KeiGy-zss5
    o9Sd8k3Q0pJPUsBLQ>
X-ME-Received: <xmr:SNstZ0MWKoVALlhrDDfMmr_CmdUfgU6mTjnNWc3PNnbaAcn3d5osYoVwxQoTzij5E5geBbyAMHxzUmJbIZxORrxwA6oczeJYyIyrWSEe-eQd-PM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SNstZ64Yk2cKEn0ENr0p3FfSfzz-q5Q9n4BcHeglNsEge8fxmyxpzg>
    <xmx:SNstZ26aeSKU8mq_36kesyA5LzsuOy_hZvPGbTh4kIP9yEij__DsnA>
    <xmx:SNstZygx1DBi5dFpyJQBz7zJRq_zcaWukna5ZoXq49RjRkY0siTPAQ>
    <xmx:SNstZ45vAOIRbGjijndIQ5XCZpw9837XAQvij8MmrYNBV1K6WLO9Bg>
    <xmx:SNstZ8RLx3SJFEJp9C0IZd4aa322Rohm6xPYOfHUscn0vC9FgF29XW__>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d42c868 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:41 +0100
Subject: [PATCH 01/10] refs: allow passing flags when setting up a
 transaction
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-1-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

Allow passing flags when setting up a transaction such that the
behaviour of the transaction itself can be altered. Adapt callers
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c               |  2 +-
 builtin/clone.c        |  2 +-
 builtin/fast-import.c  |  4 ++--
 builtin/fetch.c        |  4 ++--
 builtin/receive-pack.c |  4 ++--
 builtin/replace.c      |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  4 ++--
 refs.c                 | 12 +++++++-----
 refs.h                 |  3 ++-
 refs/files-backend.c   | 11 +++++++----
 refs/refs-internal.h   |  1 +
 sequencer.c            |  6 +++---
 walker.c               |  2 +-
 14 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index 44977ad0aadbd40c878a0475ef2df2a20798936b..ebaa870c018747358255d3f150d136f0df447d5d 100644
--- a/branch.c
+++ b/branch.c
@@ -627,7 +627,7 @@ void create_branch(struct repository *r,
 	else
 		msg = xstrfmt("branch: Created from %s", start_name);
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction ||
 		ref_transaction_update(transaction, ref.buf,
 					&oid, forcing ? NULL : null_oid(),
diff --git a/builtin/clone.c b/builtin/clone.c
index 59fcb317a68a77eee3ca96a60720c556e044c369..d963cc6eb5181e1af5bb29c07c3ee2fa24ad04ca 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -574,7 +574,7 @@ static void write_remote_refs(const struct ref *local_refs)
 	struct strbuf err = STRBUF_INIT;
 
 	t = ref_store_transaction_begin(get_main_ref_store(the_repository),
-					&err);
+					0, &err);
 	if (!t)
 		die("%s", err.buf);
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 76d5c20f141f42da988dddae0e549144d1379031..db82c37a06f05d25e0a8c34cbec055e6f9717191 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1634,7 +1634,7 @@ static int update_branch(struct branch *b)
 		}
 	}
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, &b->oid, &old_oid,
 				   NULL, NULL, 0, msg, &err) ||
@@ -1669,7 +1669,7 @@ static void dump_tags(void)
 	struct ref_transaction *transaction;
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction) {
 		failure |= error("%s", err.buf);
 		goto cleanup;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d9027e4dc9245a32a87c47d89f9a29fcfd42534c..68d291c7dd0a4fe805e3b006cc68b185481fba6b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -669,7 +669,7 @@ static int s_update_ref(const char *action,
 	 */
 	if (!transaction) {
 		transaction = our_transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-									    &err);
+									    0, &err);
 		if (!transaction) {
 			ret = STORE_REF_ERROR_OTHER;
 			goto out;
@@ -1671,7 +1671,7 @@ static int do_fetch(struct transport *transport,
 
 	if (atomic_fetch) {
 		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-							  &err);
+							  0, &err);
 		if (!transaction) {
 			retcode = -1;
 			goto cleanup;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ab5b20e39c5038cdf6e6f05f4d66278a9c1ac156..9d2c07f68dafb6fce87cb59abc1cbf27db9aae09 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1849,7 +1849,7 @@ static void execute_commands_non_atomic(struct command *commands,
 			continue;
 
 		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-							  &err);
+							  0, &err);
 		if (!transaction) {
 			rp_error("%s", err.buf);
 			strbuf_reset(&err);
@@ -1878,7 +1878,7 @@ static void execute_commands_atomic(struct command *commands,
 	const char *reported_error = "atomic push failure";
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction) {
 		rp_error("%s", err.buf);
 		strbuf_reset(&err);
diff --git a/builtin/replace.c b/builtin/replace.c
index a44f4e7ea9ff55dbd1f102aca5e5f5a046391328..a4eaadff91f1be107a8e0e25a701d2006ff8cac2 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -201,7 +201,7 @@ static int replace_object_oid(const char *object_ref,
 	}
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, repl, &prev,
 				   NULL, NULL, 0, NULL, &err) ||
diff --git a/builtin/tag.c b/builtin/tag.c
index 93d10d59157d2ee1b41f90640bd162917f1eb162..3fa0ab111344dda477763a74d26076b6fb71a5ab 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -681,7 +681,7 @@ int cmd_tag(int argc,
 	}
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, &object, &prev,
 				   NULL, NULL,
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 8a98615dc8613a1be3b17c6d688ab9c0208ed003..670e7812d60ea88a20cd1c5cd113643095cb3be1 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -612,7 +612,7 @@ static void update_refs_stdin(void)
 	int i, j;
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction)
 		die("%s", err.buf);
 
@@ -680,7 +680,7 @@ static void update_refs_stdin(void)
 			 */
 			state = cmd->state;
 			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-								  &err);
+								  0, &err);
 			if (!transaction)
 				die("%s", err.buf);
 
diff --git a/refs.c b/refs.c
index 5f729ed4124f7fe8fa9df7fd1f1ce951abefc585..9effeb01eb45728514eab0ca92404ea8cf2158d9 100644
--- a/refs.c
+++ b/refs.c
@@ -918,7 +918,7 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	transaction = ref_store_transaction_begin(refs, &err);
+	transaction = ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
 				   NULL, flags, msg, &err) ||
@@ -1116,6 +1116,7 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 }
 
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    unsigned int flags,
 						    struct strbuf *err)
 {
 	struct ref_transaction *tr;
@@ -1123,6 +1124,7 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
 
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store = refs;
+	tr->flags = flags;
 	return tr;
 }
 
@@ -1309,7 +1311,7 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	t = ref_store_transaction_begin(refs, &err);
+	t = ref_store_transaction_begin(refs, 0, &err);
 	if (!t ||
 	    ref_transaction_update(t, refname, new_oid, old_oid, NULL, NULL,
 				   flags, msg, &err) ||
@@ -2120,7 +2122,7 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	transaction = ref_store_transaction_begin(refs, &err);
+	transaction = ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, NULL, NULL,
 				   target, NULL, REF_NO_DEREF,
@@ -2527,7 +2529,7 @@ int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 	 * individual updates can't fail, so we can pack all of the
 	 * updates into a single transaction.
 	 */
-	transaction = ref_store_transaction_begin(refs, &err);
+	transaction = ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction) {
 		ret = error("%s", err.buf);
 		goto out;
@@ -2833,7 +2835,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	if (ret < 0)
 		goto done;
 
-	transaction = ref_store_transaction_begin(new_refs, errbuf);
+	transaction = ref_store_transaction_begin(new_refs, 0, errbuf);
 	if (!transaction)
 		goto done;
 
diff --git a/refs.h b/refs.h
index 108dfc93b3428db491916ad8a55daea649d83ffd..9821f3e80d900b31c3dede489c2f415d968233d7 100644
--- a/refs.h
+++ b/refs.h
@@ -234,7 +234,7 @@ char *repo_default_branch_name(struct repository *r, int quiet);
  *         struct strbuf err = STRBUF_INIT;
  *         int ret = 0;
  *
- *         transaction = ref_store_transaction_begin(refs, &err);
+ *         transaction = ref_store_transaction_begin(refs, 0, &err);
  *         if (!transaction ||
  *             ref_transaction_update(...) ||
  *             ref_transaction_create(...) ||
@@ -584,6 +584,7 @@ enum action_on_err {
  * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    unsigned int flags,
 						    struct strbuf *err);
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0824c0b8a946909791da36ddb4171db4ad98913b..df61057c9f24972b72644407cc95057891338d96 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1252,7 +1252,7 @@ static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_store_transaction_begin(&refs->base, &err);
+	transaction = ref_store_transaction_begin(&refs->base, 0, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1396,7 +1396,8 @@ static int files_pack_refs(struct ref_store *ref_store,
 	if (!should_pack_refs(refs, opts))
 		return 0;
 
-	transaction = ref_store_transaction_begin(refs->packed_ref_store, &err);
+	transaction = ref_store_transaction_begin(refs->packed_ref_store,
+						  0, &err);
 	if (!transaction)
 		return -1;
 
@@ -2867,7 +2868,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			 */
 			if (!packed_transaction) {
 				packed_transaction = ref_store_transaction_begin(
-						refs->packed_ref_store, err);
+						refs->packed_ref_store,
+						transaction->flags, err);
 				if (!packed_transaction) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3174,7 +3176,8 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 				 &affected_refnames))
 		BUG("initial ref transaction called with existing refs");
 
-	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store, err);
+	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store,
+							 transaction->flags, err);
 	if (!packed_transaction) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8facaa17b0b4b073df0de958023062a..dbc6360c5a1d410c192e7eee1bffb1d423e1f9ee 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -193,6 +193,7 @@ struct ref_transaction {
 	size_t nr;
 	enum ref_transaction_state state;
 	void *backend_data;
+	unsigned int flags;
 };
 
 /*
diff --git a/sequencer.c b/sequencer.c
index 353d804999b88d5fd5dcf1254d80781f20e62f2e..287f4e5e8766327da6f31e87ce0c20f63b302b77 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -662,7 +662,7 @@ static int fast_forward_to(struct repository *r,
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  &err);
+						  0, &err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn && !is_rebase_i(opts) ?
@@ -1297,7 +1297,7 @@ int update_head_with_reflog(const struct commit *old_head,
 	}
 
 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-						  err);
+						  0, err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", new_head,
 				   old_head ? &old_head->object.oid : null_oid(),
@@ -3890,7 +3890,7 @@ static int do_label(struct repository *r, const char *name, int len)
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase (label) '%.*s'", len, name);
 
-	transaction = ref_store_transaction_begin(refs, &err);
+	transaction = ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction) {
 		error("%s", err.buf);
 		ret = -1;
diff --git a/walker.c b/walker.c
index 5ea7e5b392b2bd49f249a9acc8d7ce8779357e1b..7cc9dbea46d64d6bd3336025d640f284a6202157 100644
--- a/walker.c
+++ b/walker.c
@@ -290,7 +290,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 
 	if (write_ref) {
 		transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
-							  &err);
+							  0, &err);
 		if (!transaction) {
 			error("%s", err.buf);
 			goto done;

-- 
2.47.0.229.g8f8d6eee53.dirty

