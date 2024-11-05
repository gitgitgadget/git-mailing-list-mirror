Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C51CFED8
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797938; cv=none; b=dDXojQhAOM+CPool4qjd4GhTHxq31mwbr8BJELAf1VzNzyQeTrI6Ioqjlud6UmyN/eJ5qsCZFVDq/GS070Fl2C8nC4i3mgZV7XEoMHN99ZOuyPTmE6YxeXH2kaX8/vbQWtUtDp5s83I0TmePNJJd3MQI9zWPAwIAW2rhnf19oR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797938; c=relaxed/simple;
	bh=LT5GHRbUqtwVWQrz2Y6GDIMwDH2WlA1n0ob8qLwzDBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdCQLSYZqA0iUCPFABDBxHL0nNsT+GWcKms1ONKJ+CGh7TFOr+KsnScZiia+2tHyMkiu2U0VlHchCv8ppEYjkeMVTQPWsT/xWv8Em1WShAYBf6dP5DIg+oER9BdbKK9qa6xQeBimooTuiFshu5OkqBCdDGfmtV/8tKQIIWQqZPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GXooCnJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChadOjt0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GXooCnJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChadOjt0"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E40F11401C6;
	Tue,  5 Nov 2024 04:12:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 04:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797935; x=1730884335; bh=XRJfM7IAqt
	AsDDRGdHQZuM8Y5hl/dAO8FO3S+/wSZYE=; b=GXooCnJkz1UXmbwbxDQE1EohLv
	JRnvAjA0jCOPgip9o59WTAohrX0ckIVuSLViV/lmvU2kRsgLHZdx1zHB1pKZiROs
	iF0LNlFjMEXNrRU1EZChuXv9BsZMttXnXQHnt4GIgUwrdT0z9IAcIvIocFgDB/2x
	RNO4Xk6m5d9cNqUyGTLAdKR4eQk//wTwbGOxQCHZowG0TDOF1PxTDGWT/KCUGwjU
	nxBR6dDIV/l76G1FKL64etuUhPhRiZvWaSXPBQUqQlyy7QF7EN/SO2QRu7chPuHP
	knhiT8EsR7n1pUnRjmNwQO7UUqNZM43PrXleSsTGbjisBszeHn1U8VNGPhGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797935; x=1730884335; bh=XRJfM7IAqtAsDDRGdHQZuM8Y5hl/dAO8FO3
	S+/wSZYE=; b=ChadOjt0aw3M5yjj59HBt5X+x2h5ZwZzSeyHrdQuymNL3I+vWfc
	MvP6/7OE/hNUOvJrZE5Gb8WkmlL1jUQna4cJkSemKAcfEjubi0eo4QjvEBY+MvJP
	o3VJSh+shGPXt44raJdFDrHdI60n06gPwWGahFTLYdCMxxH+f6kG36GOU1hZOxzE
	IBSyM6rze/dsCOsqJuZz85TpzLu+X1klC7JO7EWIRQCAj1KkPfcfuxYlQiqQqBDg
	2u2ZJkmC+ls2RBj5XtOjMxUH9AVHklYU/JUbTPUqtc0hT7M8VwOauC+dfAUnIoc+
	C97wv6D6vcrfV70btCH2+r0/e+P7Xj2LZww==
X-ME-Sender: <xms:b-EpZ8tAaqtF3o8KlGlSnzgxueVo-7SicCW3aO-Q2_oBmBPkOjw-QQ>
    <xme:b-EpZ5cUjn-NGR_TXnNNYzUd5mlYnBt7vm6Qe8bKoPD1dOJTBAwBFqH_1Y9yjFrrt
    4Pe7V4cJZdZSjs2mw>
X-ME-Received: <xmr:b-EpZ3zGktqCkkRgu5plwvOS3MLDxxcsRnelDrTF37RTrLIBEo1J_NnIUDTMSXTEkWzyCvupNdoQWHSoLpwasnieQb8wFR8ovq0St4_46-xAjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvvdehjeeuue
    ekhfeiieefteeiiefhfffgfffhkeeuhefgleduheffieeguefgfeenucffohhmrghinhep
    uhhpuggrthgvrdhtiienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:b-EpZ_NWBbYiQYptD5369NAV80WHaLPL_cx_dmmPcoX4YDSEivgayg>
    <xmx:b-EpZ88brGpA-sKHFk6CplkdxqCRw3iDW8yFq7yUraswoeokChqJKA>
    <xmx:b-EpZ3Vt_rHJm9t4c_fVo6ULT187hHrh97eN8_BgOjzrh5EDL0LFdA>
    <xmx:b-EpZ1dKJTAoPvYt_zJGWrSt-RHKywacu2ohsOLv-tIk2pHWCE15-g>
    <xmx:b-EpZ-IzK_gGlGzTI5MXBjimTc5E2e6P3QW3F3rKOQkXRWa3-FWS80mj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3b168cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:11:52 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/8] refs/reftable: read references via `struct
 reftable_backend`
Message-ID: <1b50655202f311c6a6ded61d4d50b1f287761d84.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730792627.git.ps@pks.im>

Refactor `read_ref_without_reload()` to accept a `struct reftable_stack`
as input instead of accepting a `struct reftable_stack`. This allows us
to implement an additional caching layer when reading refs where we can
reuse reftable iterators.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c   | 110 ++++++++++++++++++++------------------
 reftable/reftable-stack.h |   3 ++
 reftable/stack.c          |   5 ++
 3 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4a28dc8a9d..230adb690d 100644
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
@@ -1074,8 +1086,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	if (ret)
 		goto done;
 
-	ret = read_ref_without_reload(refs, be->stack, "HEAD",
-				      &head_oid, &head_referent, &head_type);
+	ret = reftable_backend_read_ref(be, "HEAD", &head_oid,
+					&head_referent, &head_type);
 	if (ret < 0)
 		goto done;
 	ret = 0;
@@ -1143,8 +1155,8 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
-					      &current_oid, &referent, &u->type);
+		ret = reftable_backend_read_ref(be, rewritten_ref,
+						&current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
 		if (ret > 0 && !ref_update_expects_existing_old_ref(u)) {
@@ -1602,7 +1614,7 @@ struct write_create_symref_arg {
 
 struct write_copy_arg {
 	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
+	struct reftable_backend *be;
 	const char *oldname;
 	const char *newname;
 	const char *logmsg;
@@ -1627,7 +1639,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	if (split_ident_line(&committer_ident, committer_info, strlen(committer_info)))
 		BUG("failed splitting committer info");
 
-	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
+	if (reftable_stack_read_ref(arg->be->stack, arg->oldname, &old_ref)) {
 		ret = error(_("refname %s not found"), arg->oldname);
 		goto done;
 	}
@@ -1666,7 +1678,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * the old branch and the creation of the new branch, and we cannot do
 	 * two changes to a reflog in a single update.
 	 */
-	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->stack);
+	deletion_ts = creation_ts = reftable_stack_next_update_index(arg->be->stack);
 	if (arg->delete_old)
 		creation_ts++;
 	reftable_writer_set_limits(writer, deletion_ts, creation_ts);
@@ -1709,8 +1721,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_RAWSZ);
 		logs_nr++;
 
-		ret = read_ref_without_reload(arg->refs, arg->stack, "HEAD", &head_oid,
-					      &head_referent, &head_type);
+		ret = reftable_backend_read_ref(arg->be, "HEAD", &head_oid,
+						&head_referent, &head_type);
 		if (ret < 0)
 			goto done;
 		append_head_reflog = (head_type & REF_ISSYMREF) && !strcmp(head_referent.buf, arg->oldname);
@@ -1753,7 +1765,7 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 	 * copy over all log entries from the old reflog. Last but not least,
 	 * when renaming we also have to delete all the old reflog entries.
 	 */
-	ret = reftable_stack_init_log_iterator(arg->stack, &it);
+	ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -1826,7 +1838,6 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1840,11 +1851,10 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1858,7 +1868,6 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.oldname = oldrefname,
@@ -1871,11 +1880,10 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
index 54787f2ef5..ae14270ea7 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -149,4 +149,7 @@ struct reftable_compaction_stats {
 struct reftable_compaction_stats *
 reftable_stack_compaction_stats(struct reftable_stack *st);
 
+/* Return the hash of the stack. */
+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st);
+
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index 1fffd75630..d97b64a40d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1791,3 +1791,8 @@ int reftable_stack_clean(struct reftable_stack *st)
 	reftable_addition_destroy(add);
 	return err;
 }
+
+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st)
+{
+	return reftable_merged_table_hash_id(st->merged);
+}
-- 
2.47.0.229.g8f8d6eee53.dirty

