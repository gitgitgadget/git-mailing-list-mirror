Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7A1BD01D
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733109; cv=none; b=HLKJsGwxgm1g8WLn75b7CAZqknG54oejRUmknbLgX5nIVlr+B9kTTObX9UQi+8R+6aq/WZ6jVArrewRae9TIu2c81WztyCBzqlX56r706OwSp7490MgMXRsYl4UkY7tzRqqpINRkNEFIfRR527L+i5uZobbaZsw50nLDPaUNVCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733109; c=relaxed/simple;
	bh=biABmWLtj27X3gnYRok2vif172a+h4Xaapcxa+zNEmg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT5N2R2P1pJRlMU5gf1j5Kh+j0ZIqm2h08hQqLDhzDie1F/YhWut0TXEh2vUj/7/v3q41X0YuGeFP0vv+nQNHTfxIMpKB7924gKBZnSQvKMqUJkVLrJB+W1gI1f9s1dEi0iV0+GfmUd3O0bUQku9ZAhUKI1aWNYtTy5LDJAUojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ShhIeUMx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bMQEeJbw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ShhIeUMx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMQEeJbw"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC22511400CC
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 04 Nov 2024 10:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733105; x=1730819505; bh=pAkD9zD8l8
	fI5tNIJ8+mUK8w3T6W+j0SXSqyTFDOKYM=; b=ShhIeUMxDpRQT8OYLH4bQmuFgs
	MAVkc81e+XTiciNH/ydfRFNF3L5TBw8DkwvX6owj6Q1f0iRIcFPEw4ylmff6e6LH
	thhJwIWSlvWb7017/HPmU1i6vLLE9AZ8dpfdQdVEWb7WZkxBNGXsYTbQVIv8cO6N
	9VrWgswDAxlaYEgd1YK5Y3VgzRA1Q6AJrIbZYXzu8LUnSUCOfbV061KAOCFOiD0g
	A1EmrbsGCggdi9P/cGZpjzx9qk3hhSoJoGI02k1P8wtMYrCJI2E/v2aPzBKFHP0p
	RqGa3kxrq+C95i1eMUBnDJx5VA9rog0AWPX3IJyG80Kyzoo1k6UJS3TWFawg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733105; x=1730819505; bh=pAkD9zD8l8fI5tNIJ8+mUK8w3T6W+j0SXSq
	yTFDOKYM=; b=bMQEeJbw/c75lUVmYElpByd0wetGQ/wa/CJu/so3ddWMB4LpFwU
	LM/no9ARMubG+pPG8GbkkZTgyPndC2irSPbP13IWVb0noYOg8u+inrL32P8yB4Nw
	3vz8if26dkoBnGpN1qfUcQ910aLps/xpAAuz6+s77HhczB8PTPUlEpAJvfIFYND6
	lmXX8wb2yqIXrBulFvWoiKfUUyQO7oEK+lHKQRKejgucdE2qbxZgzGyWIUoPcsxI
	0P+e2Vjob62kLiAojt46d++VTXHkRNT+TGci1wNJK2SGZ+KAVjwXtLgQOFpWyutu
	KUCoDcSryqiuL0OWFThRx9aiV+kn2i4pghQ==
X-ME-Sender: <xms:MeQoZ2Hj9uNaJAHdEhi1dyZSQb2T_NEm9-yijbq-hRyHzmdnmWDnGQ>
    <xme:MeQoZ3USyuO5pfZK5E9sp_mp37Y6ys5M92ZwR1of8pnjQn555S1eB3bXS4Zz4BhPu
    5KwwD8TYMN253QC2g>
X-ME-Received: <xmr:MeQoZwJS2_q-ocEN4VCqKWnOGwa8LsT-K--RYnebeAz6M8zlCx43xNBoUeBWFoknXO5PdEbsVj9gRwcKbvpGdTic5AM-w_W2idGiJ9ZpPmr4eyRcew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MeQoZwEjy3UQF6Jd8K3uL382STzOobTSQw0xb0VG2kcGs7438kwmxw>
    <xmx:MeQoZ8WRIAg__uB0p0xGtOS5HCLXiqmGbH8-4_3nHzFQR0Cmwu1VTg>
    <xmx:MeQoZzOrV3FAxn8046sL5uD-t0IfdEi8TCE-JUZOlmgvIuaFnbi6xA>
    <xmx:MeQoZz1IxYXVbFyomWueAjgFG30uHT9cpgGzrxz1zQsJ-L4Rm2qluA>
    <xmx:MeQoZ3ctaSOLqQTNXfc-XtFrR0kSvpb0ydcLortK9YAZcpD9g6bxbuwV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2784631 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:24 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/8] refs/reftable: handle reloading stacks in the reftable
 backend
Message-ID: <b81ce63589e0380baf2b977a6abd706a66b08bee.1730732881.git.ps@pks.im>
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

When accessing a stack we almost always have to reload the stack before
reading data from it. This is mostly because Git does not have a
notification mechanism for when underlying data has been changed, and
thus we are forced to opportunistically reload the stack every single
time to account for any changes that may have happened concurrently.

Handle the reload internally in `backend_for()`. For one this forces
callsites to think about whether or not they need to reload the stack.
But second this makes the logic to access stacks more self-contained by
letting the `struct reftable_backend` manage themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 150 +++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 57 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 43cba53cb1..93f3602faa 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -112,21 +112,25 @@ static struct reftable_ref_store *reftable_be_downcast(struct ref_store *ref_sto
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
@@ -160,7 +164,7 @@ static struct reftable_backend *backend_for(struct reftable_ref_store *store,
 		}
 
 		strbuf_release(&wt_dir);
-		return be;
+		goto out;
 	}
 	case REF_WORKTREE_CURRENT:
 		/*
@@ -168,14 +172,27 @@ static struct reftable_backend *backend_for(struct reftable_ref_store *store,
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
@@ -811,17 +828,17 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
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
@@ -838,15 +855,15 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
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
@@ -863,7 +880,7 @@ struct reftable_transaction_update {
 
 struct write_transaction_table_arg {
 	struct reftable_ref_store *refs;
-	struct reftable_stack *stack;
+	struct reftable_backend *be;
 	struct reftable_addition *addition;
 	struct reftable_transaction_update *updates;
 	size_t updates_nr;
@@ -898,27 +915,31 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 				      struct ref_update *update,
 				      struct strbuf *err)
 {
-	struct reftable_stack *stack = backend_for(refs, update->refname, NULL)->stack;
 	struct write_transaction_table_arg *arg = NULL;
+	struct reftable_backend *be;
 	size_t i;
 	int ret;
 
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
+		ret = backend_for(&be, refs, update->refname, NULL, 1);
 		if (ret)
 			return ret;
 
-		ret = reftable_stack_new_addition(&addition, stack,
+		ret = reftable_stack_new_addition(&addition, be->stack,
 						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
@@ -930,7 +951,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 			   tx_data->args_alloc);
 		arg = &tx_data->args[tx_data->args_nr++];
 		arg->refs = refs;
-		arg->stack = stack;
+		arg->be = be;
 		arg->addition = addition;
 		arg->updates = NULL;
 		arg->updates_nr = 0;
@@ -985,6 +1006,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
+	struct reftable_backend *be;
 	struct object_id head_oid;
 	unsigned int head_type = 0;
 	size_t i;
@@ -1031,7 +1053,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		goto done;
 	}
 
-	ret = read_ref_without_reload(refs, backend_for(refs, "HEAD", NULL)->stack, "HEAD",
+	ret = backend_for(&be, refs, "HEAD", NULL, 0);
+	if (ret)
+		goto done;
+
+	ret = read_ref_without_reload(refs, be->stack, "HEAD",
 				      &head_oid, &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
@@ -1040,10 +1066,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *u = transaction->updates[i];
 		struct object_id current_oid = {0};
-		struct reftable_stack *stack;
 		const char *rewritten_ref;
 
-		stack = backend_for(refs, u->refname, &rewritten_ref)->stack;
+		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
+		if (ret)
+			goto done;
 
 		/* Verify that the new object ID is valid. */
 		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1099,7 +1126,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, stack, rewritten_ref,
+		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
@@ -1301,7 +1328,7 @@ static int transaction_update_cmp(const void *a, const void *b)
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)
 {
 	struct write_transaction_table_arg *arg = cb_data;
-	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	uint64_t ts = reftable_stack_next_update_index(arg->be->stack);
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
@@ -1337,7 +1364,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
-			ret = reftable_stack_init_log_iterator(arg->stack, &it);
+			ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 			if (ret < 0)
 				goto done;
 
@@ -1782,10 +1809,9 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1797,10 +1823,11 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1814,10 +1841,9 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
@@ -1828,10 +1854,11 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
@@ -1995,15 +2022,19 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
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
+	ret = backend_for(&be, refs, refname, &refname, 0);
+	if (ret)
+		goto done;
+
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -2035,16 +2066,20 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
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
+	ret = backend_for(&be, refs, refname, &refname, 0);
+	if (ret)
+		goto done;
+
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
@@ -2084,20 +2119,20 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
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
 
@@ -2169,10 +2204,9 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
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
@@ -2181,11 +2215,12 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
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
@@ -2243,17 +2278,18 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
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
@@ -2352,13 +2388,13 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2367,11 +2403,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
 
@@ -2379,11 +2415,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2462,7 +2498,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	arg.refs = refs;
 	arg.records = rewritten;
 	arg.len = logs_nr;
-	arg.stack = stack,
+	arg.stack = be->stack,
 	arg.refname = refname,
 
 	ret = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
-- 
2.47.0.229.g8f8d6eee53.dirty

