Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3C1D07B0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797933; cv=none; b=qAXGTY1v10RfY8zuEQGIHcVjSWRVIZzwLzBl9icHK4rX5oPVSn2TTwSzDluKl+LjQrJAyYmuIpOtP9v7t6nd8kGSO8qsqovjVr2++rU1TR3Fl1GquhLSxVPCbVO5KbMd3qBfau6hjFugUmhPP4MZtuKVJeSb07sbbMVYNfDsfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797933; c=relaxed/simple;
	bh=Yn4p7Q8WIH37ChdXXj3XObX4pgHhw1o42zRfLr0za94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM32dpzujm5gQBj90i8HUN214Soe8o5O1wSwnlCBxYGHwHGI3+EefD2C1lDTZikW8sWRSLOBAyvJTzy+UlfYunlCxqABZyF52LeW7Tp+01u6JMAU7mYJ2JFnJQZzTDoEvqWjv2DfPOxkjTT4j+qLwKM8Y6aMcXL6ghmmPzp3rFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=208pCgK6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqroT7pU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="208pCgK6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqroT7pU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D8AB1140171;
	Tue,  5 Nov 2024 04:12:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 04:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797930; x=1730884330; bh=+DyBhWQ2HW
	W4E9RXpPWiQTGWgVF/ag8wbGrw8gTrYEA=; b=208pCgK6yjhQLKLILFUcjJU5vm
	tU7pJVoNdic1B6718jxvzA5o9e4KfMTa93+8f+JMQ29se93sasRfpsUs64Zz16eB
	0gtO7vlEWeER/d5sKzB4oRvvIkEf9dOCJYPNrvLHbUnkekCMYVQGen2awPoWZ178
	eonD2gijd069gJFrjZ2/qc8ZS5peQlc2MZu2LwcR8vA/TEp/nDaVzkG+eqUUD246
	acBzA0bdWjkNpPZZtXEuPZLkT0iEZfuav69lNgrxHBuVm52zsvCzPa8Wc7jjegZF
	FgZg+ZGYLto3m9UNzIDhIDfTczs4/JqnOUjE6y0AfBNHjwazlDMFZLXnUL4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797930; x=1730884330; bh=+DyBhWQ2HWW4E9RXpPWiQTGWgVF/ag8wbGr
	w8gTrYEA=; b=EqroT7pULTZscmEY1Mkd/gYdU3kFlQ+9FL96s000LVRLuHZYY65
	RWo9vhwz9aXgprhDAgcdC4hr9w1I9DYYoZDyfUT0IMpvjjxfw3TDAmwS+h4v0u5X
	uvaguHtfBxvmBPipnzeKrrT2NmcwVe225RxJUVt1ia2h7RUgLDdCTbocY9jLTY78
	ZoSkIVXJCCCAws/0X3StAHAXFE/uSPKhIdUDJIZxWndOxHQ/BFd87IamVGTUHb0T
	u3kMmREwwSMD9E+GrU+xxZMmPN8ODpVQFtqEPKqJxzIhhihMuWNNe308IV7irkbv
	sCm2Fq0asNVvUsdUPtwyXOSQ6nGhjJY5uGw==
X-ME-Sender: <xms:aeEpZ_FJ7zwVczPUviNcfqwmQWlJCZ9UU7N3DTY_rHsFDsPHAGpsSA>
    <xme:aeEpZ8Udc16HuBdhjUJWOy_lsm9ZzCslvRVRbaiq2ZKtio1s9ngWZhtzmIQrArrOE
    TE9ulerS6JdhqXyGA>
X-ME-Received: <xmr:aeEpZxIDv-KByH8NX20130A1RrS24236bVhyq7Zvx9TSv0QTjNm6VzOfQmnml168DYoAqvWzVIvu4y1RQEwz2uUzr-qrH0J67dm4aGGqBmmnIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:aeEpZ9Hmkd28udZN2y_ORVLX3tcjbKke9KHun9XnN1nKLaJXBCWVbA>
    <xmx:aeEpZ1XRbq8I3sE4jD5HbvbZyFc-UgA0N-rztBVp_ZoxvC2x1hHunA>
    <xmx:aeEpZ4MbhHNSuWunqge6FbYjdUmTuJFcb5_vKNL4OI1yve1Mu19unQ>
    <xmx:aeEpZ036WEmoC2jbE1WtBtGQxsOP0rHVSDW30t2yaNBEApeYe_gVFw>
    <xmx:auEpZyjUYDqu0KNEwAIiA3b65h3JOs6VwPdGqQHPnUneXNdYYKBurRSC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0efefcb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:11:47 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] refs/reftable: handle reloading stacks in the
 reftable backend
Message-ID: <bab837e3733a982973bb96eedca15d073089693a.1730792627.git.ps@pks.im>
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
index 116cc5ec23..4a28dc8a9d 100644
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
@@ -915,27 +932,31 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
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
@@ -947,7 +968,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 			   tx_data->args_alloc);
 		arg = &tx_data->args[tx_data->args_nr++];
 		arg->refs = refs;
-		arg->stack = stack;
+		arg->be = be;
 		arg->addition = addition;
 		arg->updates = NULL;
 		arg->updates_nr = 0;
@@ -1002,6 +1023,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT, head_referent = STRBUF_INIT;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 	struct reftable_transaction_data *tx_data = NULL;
+	struct reftable_backend *be;
 	struct object_id head_oid;
 	unsigned int head_type = 0;
 	size_t i;
@@ -1048,7 +1070,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
@@ -1057,10 +1083,11 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
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
@@ -1116,7 +1143,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
 
-		ret = read_ref_without_reload(refs, stack, rewritten_ref,
+		ret = read_ref_without_reload(refs, be->stack, rewritten_ref,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
@@ -1318,7 +1345,7 @@ static int transaction_update_cmp(const void *a, const void *b)
 static int write_transaction_table(struct reftable_writer *writer, void *cb_data)
 {
 	struct write_transaction_table_arg *arg = cb_data;
-	uint64_t ts = reftable_stack_next_update_index(arg->stack);
+	uint64_t ts = reftable_stack_next_update_index(arg->be->stack);
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
@@ -1354,7 +1381,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 			struct reftable_log_record log = {0};
 			struct reftable_iterator it = {0};
 
-			ret = reftable_stack_init_log_iterator(arg->stack, &it);
+			ret = reftable_stack_init_log_iterator(arg->be->stack, &it);
 			if (ret < 0)
 				goto done;
 
@@ -1799,10 +1826,9 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1814,10 +1840,11 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
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
@@ -1831,10 +1858,9 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
@@ -1845,10 +1871,11 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
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
@@ -2012,15 +2039,19 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
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
 
@@ -2052,16 +2083,20 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
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
 
@@ -2101,20 +2136,20 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
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
 
@@ -2186,10 +2221,9 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
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
@@ -2198,11 +2232,12 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
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
@@ -2260,17 +2295,18 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
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
@@ -2369,13 +2405,13 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2384,11 +2420,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
 
@@ -2396,11 +2432,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2479,7 +2515,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	arg.refs = refs;
 	arg.records = rewritten;
 	arg.len = logs_nr;
-	arg.stack = stack,
+	arg.stack = be->stack,
 	arg.refname = refname,
 
 	ret = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
-- 
2.47.0.229.g8f8d6eee53.dirty

