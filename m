Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EB12EBEA
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520327; cv=none; b=RKgnQCwQOo90p091+9CBkd9SFODt4rGjgB8pFEqP4K1JWL6G4p+dJz/5pQhGYXPmSMp+eFSqSVaGiuMvhVBxUTG1QpHquRqkMk/e5Zznn92Q4lKSUR3fXW6QU4IilRo0LgfhI6LsZOTvJtO0hm/+0F0E2/krB0Etsd2uLtvf6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520327; c=relaxed/simple;
	bh=rx8Zo1xiQZb7rRA9FLLTpIPA2wLrlSUPMetrQV/Ikls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYDcUw/Ej+ZCKlO1gf+qXSo8fAIEzOlRCS48GmQnDDdOjyS29Pds8kI3bvEvBRatGz2YpgHja5oMh5rCEtEDATHGYXtsXx3xICzVcYYh0VChOZCzdk2kw31msoKQAyYb10+T4R2xVNLxGhXditRRZUkJvMdfzcEXb68G9SJNMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ne5IbyUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/t+E1fp; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ne5IbyUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/t+E1fp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 18F671140155;
	Mon, 25 Nov 2024 02:38:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 25 Nov 2024 02:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520324;
	 x=1732606724; bh=OLA5H9133sZlQstEH4+LOJYQjs8G6WHWYCl8wFlpn3Q=; b=
	Ne5IbyUQXjf+xJb7z6FltOUT4dxwWPVzm80g8j60pOHbBOFBVDmVJ4WybaOVg6Ww
	ViZEA3ylwAEvjECzg9XNttUQappng1hS7ucm3eRtWsag7aS3bF/Z7t+8mPyb9FiA
	ed0iMlL5stO/84qWuOJKEGA+3H0KdjeDYXLlAut/nlr63RrAVADvajpLTvmicKzl
	VfuXOqAtmMwaOyF2riIYCoF7uJs20u+F8aWOpwJvUfjqRygjY6PpTlG1r6boBuuf
	aTFzS1pI/q0YIQhUKR0jmJAgM3kL15WDHj9HWEfBxbnRmEkiEO6onO3d7R9Cfbsk
	w4fPZRWRuda+JEbO38bkSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520324; x=
	1732606724; bh=OLA5H9133sZlQstEH4+LOJYQjs8G6WHWYCl8wFlpn3Q=; b=A
	/t+E1fpqUDuOLlXcPsmWN3aOFYjGNbQu0QScMFgJu6HgBfIWwjDTExK1IoEopDQa
	/rFwUc5D8NWiCd0G3sVA30pECzm1KMbs+gtItRgi/PKHqjXP8vE4ISKrmTPmRG/p
	vcJvuAcz8Jtk8KcEwyApZDY0aJve72rWL0b1Re9V+m7Dfyb90LbiwpsWMquDi8wZ
	oLS0/vPrbpduD34uVMZFdsTiHnVaqV924NrNWD36Z+4naWE0XlrBWFBPSDOmk0NN
	X0zhrZ6KB7e6lL3WbkgCN+BNJrRzb04Njr28qfiVyjBqKYym7wDNQfUpKXFvHNWp
	jrRvO/fXHGmW02S8b9rAg==
X-ME-Sender: <xms:hClEZz9WxQ-gX6Eb0TzJrZx0c2iL5vYc-y7M95HIWRVxIFI4kIXidw>
    <xme:hClEZ_tujG7MpHJrGTqXLxqsGpFO2VfwZ-96ADhGpXCOo3jGxhw__iadm1w_XYodS
    eTG9yHschJWXeIKDQ>
X-ME-Received: <xmr:hClEZxAbRS7maSdYs0h7Ug0sl5e6WTpJECR3lSfttkqkqmp-vbnxQlB0MUM2sg_my_uo-QVvxRWILP49FmI7_ysaWvOL4tPFCt1QBvXiG-iINA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhfeeiveffudfhjedvveffhfdukefhvdekveevgeeu
    ieetteevgeelgffhvedtgfenucffohhmrghinhepuhhpuggrthgvrdhtiienucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:hClEZ_dRYOENV1u9cAdJ5cSUw7lRweHLo2oiuO24NNxzCqk3Fxq3yQ>
    <xmx:hClEZ4OUnn1geK3_TER4a5y1ZSLDIWA6-eUHwgwVC_ExG9sb5Wp4Bw>
    <xmx:hClEZxmKnfmLi2X0x9qvRQ97XEIaxliBLLXslfa9soIJoRJXoHydcA>
    <xmx:hClEZyvUz0F64hku8oD8gmswAj67nj7O6KbenSbL2k_PSe-Lu1dzTQ>
    <xmx:hClEZ9q5WWgApFSYQnp1PMekS210fK2WsJIZ_VDftpmZ4vEksA7YfFqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 632cbfa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:26 +0100
Subject: [PATCH v3 4/9] refs/reftable: read references via `struct
 reftable_backend`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-4-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
as input instead of accepting a `struct reftable_stack`. This allows us
to implement an additional caching layer when reading refs where we can
reuse reftable iterators.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 110 ++++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 64fe8fd02d8ec932f7980cdb7d7d5223c3c83b73..5933c561f5c422d12b616514ed76b75c52a13477 100644
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
 
@@ -243,38 +287,6 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
 	log->value.update.tz_offset = sign * atoi(tz_begin);
 }
 
-static int read_ref_without_reload(struct reftable_ref_store *refs,
-				   struct reftable_stack *stack,
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
-		oidread(oid, reftable_ref_record_val1(&ref),
-			refs->base.repo->hash_algo);
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
@@ -855,7 +867,7 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 	if (ret)
 		return ret;
 
-	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);
+	ret = reftable_backend_read_ref(be, refname, oid, referent, type);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -1091,8 +1103,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 
-	ret = read_ref_without_reload(refs, be->stack, "HEAD",
-				      &head_oid, &head_referent, &head_type);
+	ret = reftable_backend_read_ref(be, "HEAD", &head_oid,
+					&head_referent, &head_type);
 	if (ret < 0)
 		goto done;
 	ret = 0;
@@ -1167,8 +1179,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
-					      &current_oid, &referent, &u->type);
+		ret = reftable_backend_read_ref(be, rewritten_ref,
+						&current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
 		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
@@ -1626,7 +1638,7 @@ struct write_create_symref_arg {
 
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
+	struct reftable_backend *be;
 	const char *oldname;
 	const char *newname;
 	const char *logmsg;
@@ -1651,7 +1663,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
 		BUG("failed splitting committer info");
 
-	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
+	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
 		ret = error(_("refname %s not found"), arg->oldname);
 		goto done;
 	}
@@ -1690,7 +1702,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * the old branch and the creation of the new branch, and we cannot do
 	 * two changes to a reflog in a single update.
 	 */
-	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->stack);
+	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
 	if (arg->delete_old)
 		creation_ts++;
 	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
@@ -1733,8 +1745,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 		logs_nr++;
 
-		ret = read_ref_without_reload(arg->refs, arg->stack, "HEAD", &head_oid,
-					      &head_referent, &head_type);
+		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
+						&head_referent, &head_type);
 		if (ret < 0)
 			goto done;
 		append_head_reflog = (head_type & REF_ISSYMREF) && !strcmp(head_referent.buf, arg->oldname);
@@ -1777,7 +1789,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * copy over all log entries from the old reflog. Last but not least,
 	 * when renaming we also have to delete all the old reflog entries.
 	 */
-	ret = reftable_stack_init_log_iterator(arg->stack, &it);
+	ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -1850,7 +1862,6 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1864,11 +1875,10 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1882,7 +1892,6 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1895,11 +1904,10 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
2.47.0.274.g962d0b743d.dirty

