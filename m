Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5364A08
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733110; cv=none; b=ANaJ1z9ouQoIzU2X39rzFrWJE06C1B9Kh4r8K+y2FRmNqL5DYVJ9JrAF7md19qRjckL4xAjykozsf+Mh1BEhK4RvFXnHnbEcwej2bj0Og+LTif5fqdBkuReMDRiIOtWpdLqxc4kYD4ZILllP47QHGEAKPtkbzrHEqmOsa8V5c4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733110; c=relaxed/simple;
	bh=hyjoCrjjobOzHf7yw0j8HoHsOl/U0LemCIR4fHWKQyo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVnVB9EpLOgDyKqzWkjmLyRPXE0De2xQFkPh/I7QpVLd5js0pGrxT0FwRzCW6NOlqK9m6/KP+7mpxUAnknw+9yYEEzOitAl1SnO9efO3xtmtfVQDDCcky0j8meTB9/klurJVp9IMHXuc1YA/xrQNmtqC5Oei1Enm72aCi7H+/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XrShpyi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dW2untfP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XrShpyi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dW2untfP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C7E8114010D
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 04 Nov 2024 10:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733107; x=1730819507; bh=zxb235a7u0
	aKZfXNr2K4n9yATAjoq56t+MG7gnfpEFo=; b=XrShpyi3K/a1SDOl123s908wor
	JQG1AFfZ+7g3bO9b4g9Nr3cr5I9A55Vt5J8i0CGMTMUOAQ0nWTM7velaSkJHHXpN
	kk5nzdmGQ9WGBaZqWL6mG6SIUXcf5qcUFKt+eUeynxQ/Y2HtmhNb2XuIBERgCpag
	RyQje0cZHd0Awy2u1sBAoD/4ZiSwOlDzhgumTkYJk+3RtqyYLtcTfZYXsjJw0Yxl
	G5kk0RjchehKYO9e1OpnhstzXvMZfRadpdjV4JTk2x9zOXjcS8VutyqimmTY6R46
	86xokgl8CWu1hvWNUUdZEJ/OZBf+oNFYEqqcCDGHN0YLbomg1npIc0MfzopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733107; x=1730819507; bh=zxb235a7u0aKZfXNr2K4n9yATAjoq56t+MG
	7gnfpEFo=; b=dW2untfPvfhKe8oTBWfAnJ2QnTpT6YKiGDECEXeIkbT84jGk41B
	0rFE+7iP3A4YffsmwGInPpjvq7TnZBF6iInSrrbHbOqPmF2KE7Y/gNUBr/b7QN8L
	ZxL3HGxP9LFJjeLc9Sjp8VeoItdcVZ2+hqm4whE2CQgP0i7gAr234/wGdZgdYcn5
	I0XYHTlT2uEAcBCZ+ViXPkEz5qGtWwrSeCq1sSS/XqV2LSXbHhQwhX+RbKSK8AM/
	HnrJ4LkS3+hPCGumqbQsokt/AWGvZURr/fgD1NmgvnIP9Dvm5HpeT/rJvZDai615
	XrY2HZ65KQnHc/0+DG0M4ZjM3ipYTLqURLQ==
X-ME-Sender: <xms:M-QoZwEBqawEchlnc8JfuiKnTMQW_4CQ8m0pl49FwsyvhKNasQ1JOQ>
    <xme:M-QoZ5Vvvm37CYEuv0zoSRpgnHYJc5-qSxoL5ovcyHNZVQE45rzgCbW_MsfGN-oz3
    IUbkudxpOY09tRyLw>
X-ME-Received: <xmr:M-QoZ6K4Ed351CVFWUKqcKYpSWjtnw8TErfqFzNYBiy2-0XGhGiLu6pdqP556Oen70pEBdy4HLJ_aAQCwKZfpS088TYiUVxuRQ0uP0gvrD_Ob3kK8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepledtveevuefhue
    euveduveevudehtdeuhefgueegudfhueduheeiffeggfeuveeunecuffhomhgrihhnpehu
    phgurghtvgdrthiinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M-QoZyGVqAJ-yX3-epXAXfKaXiR7ErU8ckP5ReACannuKt2rZ9DCTg>
    <xmx:M-QoZ2XpcuyF0fQDZcW-bf-wJcwWfFlmIEhhA3CM8Ku28pPsmlZbng>
    <xmx:M-QoZ1O6oCqRfi229KEHdK67MZ-57neLGqV1A-REKoa-OwvrSGHMAw>
    <xmx:M-QoZ914976SyARJyQJz3uNadzlFXZFzcr8RvVS3WARNzCl6dGZoUw>
    <xmx:M-QoZ5fDdjQ7GdO-IlhKzhDOyzDzRr2cqC1HaUd4M0P_Ezz_M9nEYMIP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1b80a2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:27 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/8] refs/reftable: read references via `struct
 reftable_backend`
Message-ID: <00fdf392a64f2b0f2e9bb7b398565a87c2e187b5.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730732881.git.ps@pks.im>

Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
as input instead of accepting a `struct reftable_stack`. This allows us
to implement an additional caching layer when reading refs where we can
reuse reftable iterators.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c   | 97 +++++++++++++++++++--------------------
 reftable/reftable-stack.h |  3 ++
 reftable/stack.c          |  5 ++
 3 files changed, 54 insertions(+), 51 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 93f3602faa..99caa9d5e6 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -49,6 +49,37 @@ static void reftable_backend_release(struct reftable_backend *be)
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
+		oidread(oid, reftable_ref_record_val1(&ref),
+			&hash_algos[hash_algo_by_id(reftable_stack_hash_id(be->stack))]);
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
 
@@ -241,38 +272,6 @@ static void fill_reftable_log_record(struct reftable_log_record *log, const stru
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
@@ -838,7 +837,7 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 	if (ret)
 		return ret;
 
-	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);
+	ret = reftable_backend_read_ref(be, refname, oid, referent, type);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -1057,8 +1056,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 
-	ret = read_ref_without_reload(refs, be->stack, "HEAD",
-				      &head_oid, &head_referent, &head_type);
+	ret = reftable_backend_read_ref(be, "HEAD", &head_oid,
+					&head_referent, &head_type);
 	if (ret < 0)
 		goto done;
 	ret = 0;
@@ -1126,8 +1125,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
-					      &current_oid, &referent, &u->type);
+		ret = reftable_backend_read_ref(be, rewritten_ref,
+						&current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
 		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
@@ -1585,7 +1584,7 @@ struct write_create_symref_arg {
 
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
+	struct reftable_backend *be;
 	const char *oldname;
 	const char *newname;
 	const char *logmsg;
@@ -1610,7 +1609,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
 		BUG("failed splitting committer info");
 
-	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
+	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
 		ret = error(_("refname %s not found"), arg->oldname);
 		goto done;
 	}
@@ -1649,7 +1648,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * the old branch and the creation of the new branch, and we cannot do
 	 * two changes to a reflog in a single update.
 	 */
-	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->stack);
+	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
 	if (arg->delete_old)
 		creation_ts++;
 	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
@@ -1692,8 +1691,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 		logs_nr++;
 
-		ret = read_ref_without_reload(arg->refs, arg->stack, "HEAD", &head_oid,
-					      &head_referent, &head_type);
+		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
+						&head_referent, &head_type);
 		if (ret < 0)
 			goto done;
 		append_head_reflog = (head_type & REF_ISSYMREF) && !strcmp(head_referent.buf, arg->oldname);
@@ -1736,7 +1735,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * copy over all log entries from the old reflog. Last but not least,
 	 * when renaming we also have to delete all the old reflog entries.
 	 */
-	ret = reftable_stack_init_log_iterator(arg->stack, &it);
+	ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -1809,7 +1808,6 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1823,11 +1821,10 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1841,7 +1838,6 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1854,11 +1850,10 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 54787f2ef5..6dfd22e3f5 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -149,4 +149,7 @@ struct reftable_compaction_stats {
 struct reftable_compaction_stats *
 reftable_stack_compaction_stats(struct reftable_stack *st);
 
+/* return the hash ID of the merged table. */
+uint32_t reftable_stack_hash_id(struct reftable_stack *st);
+
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index c33979536e..530ba2d927 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1790,3 +1790,8 @@ int reftable_stack_clean(struct reftable_stack *st)
 	reftable_addition_destroy(add);
 	return err;
 }
+
+uint32_t reftable_stack_hash_id(struct reftable_stack *st)
+{
+	return reftable_merged_table_hash_id(st->merged);
+}
-- 
2.47.0.229.g8f8d6eee53.dirty

