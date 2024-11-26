Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92017CA17
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603394; cv=none; b=C6LlAWhBxaLYH7lQYBuG/MtHF9I5x6pmdHrb8E++TvA/vp9SzyuIHfqEsSOcNeL+WrhHETIPth/AzwyoGrDKAXq1S22lBV/XmCbNPG2573EKK2CBqH87WYjcYa/7az2TChHOTuGEkqQ0gm8xhrvIV0QiY/sfbToichBfAqy+OHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603394; c=relaxed/simple;
	bh=hvRMD0+vP2mFq5CwXaA8uS4HvDpj0aFPiTQ4GYbKA+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bY3DQSyD039JlTV74ISz8g4SrHFQsdeFAzIEQKBhrmX400mPwjFDiJn/P8yKuaHcTOlT0LNVvrBmNwdXbUQy72P0ZWjGOM7AIFm8ELWDMuGoZNAB04rsbsncG4VKyeDk00xVMdwCLqok/TdAtfQbtEYfLEPysn8ZrXoXqi62olo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K2nrkKTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9a3QdvB; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K2nrkKTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9a3QdvB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7832411401D2;
	Tue, 26 Nov 2024 01:43:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 26 Nov 2024 01:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603391;
	 x=1732689791; bh=JpL1DK9kU8ndm+YSA6TWQL5xZVARfwZ9Ykp30gjS3lA=; b=
	K2nrkKTlzdokfiJQj+Ea2qyKU0gxtM5irZaPcztZJGP1O7lMWji6l5VCar9U8CDR
	10DOzcJeVczGzIpvUEJUOSAtnLbL7SzpQRbAKg7KbdudjtwqRfcu8DjHB9/zTLgV
	a4RV17a9BQvaasi+oQUgHxUsBzc6Qo01VsNqDMM/GH8+/Xc33huAmGMzbs1vlYEh
	uUTCwfcFzfWRJfpIE0R4YfZDT+royTAbGa0gihEAziihUzDJQwAPZH6PXTcI9B5T
	XhYUsxJNm/PxPcuooR3Nhlo1IyUtkAE5uILGffNJfmCL2psbwF4M6TzXYQ3Qh1+G
	0cKHslE17qTSbDBsTDCkUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603391; x=
	1732689791; bh=JpL1DK9kU8ndm+YSA6TWQL5xZVARfwZ9Ykp30gjS3lA=; b=j
	9a3QdvBo9mRdA030BCVmjpV64C5fDJKqfWMwcgVEA9GCp5g1l8i9hmFqkDOaVCLM
	2TZ+v/qVPN+6t9ajCtH7XbaQXhqtfqL8EBU4PjE0LWPo7ndqDMyQP5PXczsOu9KK
	dLIW7W6Bhyeszp9HDFD3t1QAKiFH/inLrBPWWALPTBjywUmFqJbOtM6A3E7l8F+y
	gX3helr40yNlo199eMIaD4zDOambqJgJq58hsDtzVbBO9wNuiAKUnIAw/XsrYiFh
	be2DWFkDNMVw7YcO5zvwfySY2qCvozC9ziDwuot9Lr7E/P1yvB6k7iqylJkpT59J
	YGxucjZIDSBB4TSXIlM+w==
X-ME-Sender: <xms:_21FZ9ay5BmFAj66iFULV3dsP1BKv38ScZoE9mDEIOTh-tw6uInhdw>
    <xme:_21FZ0aFSjhMav8kUdi2FYN0fkE0XwOlm2SnyKkuRcDYHG5WJCxYVh5O7jPz0o4rj
    G9rN45XfYaLJQhngw>
X-ME-Received: <xmr:_21FZ__6X3O9Vb-EXM3JXfFG0zMv2HlaR95Qo31m9UXhe-od337jzY7HtSbXlpuDM106hDzO5u3LHvtxoNSWewiw6iHG7gY73Ii-laZ5aXX_zGCu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_21FZ7pkViXFE42IBW_gsEQUD8Byf4uZNAlJ2cLQFnlOFyfI70ae_A>
    <xmx:_21FZ4rDA-iVs4C2zy7pWPzp3ZaDl7hKEtygyr3oeqAIfY-DMGRfFg>
    <xmx:_21FZxTaZpvl1Vpbus09JaFZa4gKYMvKLAagzKU66iuqG2kftTHZvQ>
    <xmx:_21FZwpkxmdaXURVRGoETAILvfpf9JbA89rav7B3iMu2LbFVEQ2pSg>
    <xmx:_21FZzXuQMAbih2E8QXxPmX0QXgjeGTO5ufkDyI5Fix5cKjXoiD12Dj4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id caf1e51c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:53 +0100
Subject: [PATCH v4 02/10] refs/reftable: handle reloading stacks in the
 reftable backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-2-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When accessing a stack we almost always have to reload the stack before
reading data from it. This is mostly because Git does not have a
notification mechanism for when underlying data has been changed, and
thus we are forced to opportunistically reload the stack every single
time to account for any changes that may have happened concurrently.

Handle the reload internally in `backend_for()`. For one this forces
callsites to think about whether or not they need to reload the stack.
But second this makes the logic to access stacks more self-contained by
letting the `struct reftable_backend` manage themselves.

Update callsites where we don't reload the stack to document why we
don't. In some cases it's unclear whether it is the right thing to do in
the first place, but fixing that is outside of the scope of this patch
series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 184 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 126 insertions(+), 58 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index acd26f8928d18396f78a2d39ad0e0c1796d5a409..8be9cc43c990212b0b4f8d0b473f84270ff4787d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -114,21 +114,25 @@ static struct reftable_ref_store *reftable_be_downcast(struct ref_store *ref_sto
  * like `worktrees/$worktree/refs/heads/foo` as worktree stacks will store
  * those references in their normalized form.
  */
-static struct reftable_backend *backend_for(struct reftable_ref_store *store,
-					    const char *refname,
-					    const char **rewritten_ref)
+static int backend_for(struct reftable_backend **out,
+		       struct reftable_ref_store *store,
+		       const char *refname,
+		       const char **rewritten_ref,
+		       int reload)
 {
+	struct reftable_backend *be;
 	const char *wtname;
 	int wtname_len;
 
-	if (!refname)
-		return &store->main_backend;
+	if (!refname) {
+		be = &store->main_backend;
+		goto out;
+	}
 
 	switch (parse_worktree_ref(refname, &wtname, &wtname_len, rewritten_ref)) {
 	case REF_WORKTREE_OTHER: {
 		static struct strbuf wtname_buf = STRBUF_INIT;
 		struct strbuf wt_dir = STRBUF_INIT;
-		struct reftable_backend *be;
 
 		/*
 		 * We're using a static buffer here so that we don't need to
@@ -162,7 +166,7 @@ static struct reftable_backend *backend_for(struct reftable_ref_store *store,
 		}
 
 		strbuf_release(&wt_dir);
-		return be;
+		goto out;
 	}
 	case REF_WORKTREE_CURRENT:
 		/*
@@ -170,14 +174,27 @@ static struct reftable_backend *backend_for(struct reftable_ref_store *store,
 		 * main worktree. We thus return the main stack in that case.
 		 */
 		if (!store->worktree_backend.stack)
-			return &store->main_backend;
-		return &store->worktree_backend;
+			be = &store->main_backend;
+		else
+			be = &store->worktree_backend;
+		goto out;
 	case REF_WORKTREE_MAIN:
 	case REF_WORKTREE_SHARED:
-		return &store->main_backend;
+		be = &store->main_backend;
+		goto out;
 	default:
 		BUG("unhandled worktree reference type");
 	}
+
+out:
+	if (reload) {
+		int ret = reftable_stack_reload(be->stack);
+		if (ret)
+			return ret;
+	}
+	*out = be;
+
+	return 0;
 }
 
 static int should_write_log(struct reftable_ref_store *refs, const char *refname)
@@ -828,17 +845,17 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
+	struct reftable_backend *be;
 	int ret;
 
 	if (refs->err < 0)
 		return refs->err;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret)
 		return ret;
 
-	ret = read_ref_without_reload(refs, stack, refname, oid, referent, type);
+	ret = read_ref_without_reload(refs, be->stack, refname, oid, referent, type);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -855,15 +872,15 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_symbolic_ref");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_ref_record ref = {0};
+	struct reftable_backend *be;
 	int ret;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret)
 		return ret;
 
-	ret = reftable_stack_read_ref(stack, refname, &ref);
+	ret = reftable_stack_read_ref(be->stack, refname, &ref);
 	if (ret == 0 && ref.value_type == REFTABLE_REF_SYMREF)
 		strbuf_addstr(referent, ref.value.symref);
 	else
@@ -880,7 +897,7 @@ struct reftable_transaction_update {
 
 struct write_transaction_table_arg {
 	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
+	struct reftable_backend *be;
 	struct reftable_addition *addition;
 	struct reftable_transaction_update *updates;
 	size_t updates_nr;
@@ -915,27 +932,37 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 				      struct ref_update *update,
 				      struct strbuf *err)
 {
-	struct reftable_stack *stack = backend_for(refs, update->refname, NULL)->stack;
 	struct write_transaction_table_arg *arg = NULL;
+	struct reftable_backend *be;
 	size_t i;
 	int ret;
 
+	/*
+	 * This function gets called in a loop, and we don't want to repeatedly
+	 * reload the stack for every single ref update. Instead, we manually
+	 * reload further down in the case where we haven't yet prepared the
+	 * specific `reftable_backend`.
+	 */
+	ret = backend_for(&be, refs, update->refname, NULL, 0);
+	if (ret)
+		return ret;
+
 	/*
 	 * Search for a preexisting stack update. If there is one then we add
 	 * the update to it, otherwise we set up a new stack update.
 	 */
 	for (i = 0; !arg && i < tx_data->args_nr; i++)
-		if (tx_data->args[i].stack == stack)
+		if (tx_data->args[i].be == be)
 			arg = &tx_data->args[i];
 
 	if (!arg) {
 		struct reftable_addition *addition;
 
-		ret = reftable_stack_reload(stack);
+		ret = reftable_stack_reload(be->stack);
 		if (ret)
 			return ret;
 
-		ret = reftable_stack_new_addition(&addition, stack,
+		ret = reftable_stack_new_addition(&addition, be->stack,
 						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
@@ -947,7 +974,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 			   tx_data->args_alloc);
 		arg = &tx_data->args[tx_data->args_nr++];
 		arg->refs = refs;
-		arg->stack = stack;
+		arg->be = be;
 		arg->addition = addition;
 		arg->updates = NULL;
 		arg->updates_nr = 0;
@@ -1002,6 +1029,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
+	struct reftable_backend *be;
 	struct object_id head_oid;
 	unsigned int head_type = 0;
 	size_t i;
@@ -1048,7 +1076,22 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		goto done;
 	}
 
-	ret = read_ref_without_reload(refs, backend_for(refs, "HEAD", NULL)->stack, "HEAD",
+	/*
+	 * TODO: it's dubious whether we should reload the stack that "HEAD"
+	 * belongs to or not. In theory, it may happen that we only modify
+	 * stacks which are _not_ part of the "HEAD" stack. In that case we
+	 * wouldn't have prepared any transaction for its stack and would not
+	 * have reloaded it, which may mean that it is stale.
+	 *
+	 * On the other hand, reloading that stack without locking it feels
+	 * wrong, too, as the value of "HEAD" could be modified concurrently at
+	 * any point in time.
+	 */
+	ret = backend_for(&be, refs, "HEAD", NULL, 0);
+	if (ret)
+		goto done;
+
+	ret = read_ref_without_reload(refs, be->stack, "HEAD",
 				      &head_oid, &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
@@ -1057,10 +1100,18 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *u = transaction->updates[i];
 		struct object_id current_oid = {0};
-		struct reftable_stack *stack;
 		const char *rewritten_ref;
 
-		stack = backend_for(refs, u->refname, &rewritten_ref)->stack;
+		/*
+		 * There is no need to reload the respective backends here as
+		 * we have already reloaded them when preparing the transaction
+		 * update. And given that the stacks have been locked there
+		 * shouldn't have been any concurrent modifications of the
+		 * stack.
+		 */
+		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
+		if (ret)
+			goto done;
 
 		/* Verify that the new object ID is valid. */
 		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1116,7 +1167,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, stack, rewritten_ref,
+		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
@@ -1318,7 +1369,7 @@ static int transaction_update_cmp(const void *a, const void *b)
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)
 {
 	struct write_transaction_table_arg *arg = cb_data;
-	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	uint64_t ts = reftable_stack_next_update_index(arg->be->stack);
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
@@ -1354,7 +1405,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
-			ret = reftable_stack_init_log_iterator(arg->stack, &it);
+			ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 			if (ret < 0)
 				goto done;
 
@@ -1799,10 +1850,9 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
+	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
-		.stack = stack,
 		.oldname = oldrefname,
 		.newname = newrefname,
 		.logmsg = logmsg,
@@ -1814,10 +1864,11 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(stack, &write_copy_table, &arg);
+	arg.stack = be->stack;
+	ret = reftable_stack_add(be->stack, &write_copy_table, &arg);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -1831,10 +1882,9 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
+	struct reftable_backend *be;
 	struct write_copy_arg arg = {
 		.refs = refs,
-		.stack = stack,
 		.oldname = oldrefname,
 		.newname = newrefname,
 		.logmsg = logmsg,
@@ -1845,10 +1895,11 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(stack, &write_copy_table, &arg);
+	arg.stack = be->stack;
+	ret = reftable_stack_add(be->stack, &write_copy_table, &arg);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -2012,15 +2063,23 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_reverse");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record log = {0};
 	struct reftable_iterator it = {0};
+	struct reftable_backend *be;
 	int ret;
 
 	if (refs->err < 0)
 		return refs->err;
 
-	ret = reftable_stack_init_log_iterator(stack, &it);
+	/*
+	 * TODO: we should adapt this callsite to reload the stack. There is no
+	 * obvious reason why we shouldn't.
+	 */
+	ret = backend_for(&be, refs, refname, &refname, 0);
+	if (ret)
+		goto done;
+
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -2052,16 +2111,24 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record *logs = NULL;
 	struct reftable_iterator it = {0};
+	struct reftable_backend *be;
 	size_t logs_alloc = 0, logs_nr = 0, i;
 	int ret;
 
 	if (refs->err < 0)
 		return refs->err;
 
-	ret = reftable_stack_init_log_iterator(stack, &it);
+	/*
+	 * TODO: we should adapt this callsite to reload the stack. There is no
+	 * obvious reason why we shouldn't.
+	 */
+	ret = backend_for(&be, refs, refname, &refname, 0);
+	if (ret)
+		goto done;
+
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -2101,20 +2168,20 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record log = {0};
 	struct reftable_iterator it = {0};
+	struct reftable_backend *be;
 	int ret;
 
 	ret = refs->err;
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_init_log_iterator(stack, &it);
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -2186,10 +2253,9 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
+	struct reftable_backend *be;
 	struct write_reflog_existence_arg arg = {
 		.refs = refs,
-		.stack = stack,
 		.refname = refname,
 	};
 	int ret;
@@ -2198,11 +2264,12 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret)
 		goto done;
+	arg.stack = be->stack;
 
-	ret = reftable_stack_add(stack, &write_reflog_existence_table, &arg);
+	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg);
 
 done:
 	return ret;
@@ -2260,17 +2327,18 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
+	struct reftable_backend *be;
 	struct write_reflog_delete_arg arg = {
-		.stack = stack,
 		.refname = refname,
 	};
 	int ret;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret)
 		return ret;
-	ret = reftable_stack_add(stack, &write_reflog_delete_table, &arg);
+	arg.stack = be->stack;
+
+	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg);
 
 	assert(ret != REFTABLE_API_ERROR);
 	return ret;
@@ -2369,13 +2437,13 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	 */
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
-	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record *logs = NULL;
 	struct reftable_log_record *rewritten = NULL;
 	struct reftable_ref_record ref_record = {0};
 	struct reftable_iterator it = {0};
 	struct reftable_addition *add = NULL;
 	struct reflog_expiry_arg arg = {0};
+	struct reftable_backend *be;
 	struct object_id oid = {0};
 	uint8_t *last_hash = NULL;
 	size_t logs_nr = 0, logs_alloc = 0, i;
@@ -2384,11 +2452,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (refs->err < 0)
 		return refs->err;
 
-	ret = reftable_stack_reload(stack);
+	ret = backend_for(&be, refs, refname, &refname, 1);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_init_log_iterator(stack, &it);
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -2396,11 +2464,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_new_addition(&add, stack, 0);
+	ret = reftable_stack_new_addition(&add, be->stack, 0);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_read_ref(stack, refname, &ref_record);
+	ret = reftable_stack_read_ref(be->stack, refname, &ref_record);
 	if (ret < 0)
 		goto done;
 	if (reftable_ref_record_val1(&ref_record))
@@ -2479,8 +2547,8 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	arg.refs = refs;
 	arg.records = rewritten;
 	arg.len = logs_nr;
-	arg.stack = stack,
-	arg.refname = refname,
+	arg.stack = be->stack;
+	arg.refname = refname;
 
 	ret = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
 	if (ret < 0)

-- 
2.47.0.366.gd4f858ca17.dirty

