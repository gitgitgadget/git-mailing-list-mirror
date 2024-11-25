Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107614375C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520325; cv=none; b=DbZoUGbF+pLo5Lbz61ocKInp8A5B9oDG57oonwmSdGx4lrNzP0MfithIM+ahlVA87VU0evfLtG/SujnJ002RxaXHEM168sWFJ/s5SlmWmMRmd63mHuK97V+crwPWiJyQgdrRJk7Oeh22/+HXM/pHAoEUv0HpuAIfYlhZmJKftQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520325; c=relaxed/simple;
	bh=djinglvGjGUjMyozJsNU9/ud5PlE+1+eTYZ4F9T7nKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InMgmGjSSr/hbjv9ZH7VSKMVF5mmKhF+WwY8cQfrjLGZqyBTajo1YY4+rN3FVqBUxfeQb+3VOfFQ6iKTcaP8rBMjSr3Ki4+9YTsKBfIo8kQgcNtAj4LkBeAGJVMdyJyKGNWFlyIZrZ3A/Uf/7rZILHF2DZN0x5/bDYV6LgrnQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EaSZ4LVJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKtiZ2bz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EaSZ4LVJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKtiZ2bz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 518182540118;
	Mon, 25 Nov 2024 02:38:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 25 Nov 2024 02:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520322;
	 x=1732606722; bh=g0PLolSF2eKo9g5kXgNeG88ogXaZdr7ijAEaPkFBQqQ=; b=
	EaSZ4LVJasECZ47zNaZddqd4Mbx+xIdUlgUamiujWprX4aHdKKSf6aIfyeqbbMGb
	xY0uJ+1i89EleqlnHpsWSgdjAEyOPH6pN4YSVof0Fmd93MRyIJecPbd//Cewb0gy
	yQICrzAR8OwxUZ+kq+NPrmjX04WKq5JzU7FIUbi8deLBtX2P6EI5XUOwbMz8ieMb
	7E5sMdhOY0f6uENSAox7QyJBZn96sQGX94mMWhmtQYq/YoAOum3BkAVfybkJIi68
	fqnqEYkZp4jIDPYxA0w9c7H9eEcAa6Nopq13Uhtq9AdR+bl1jlSXMGJO1Y/qf5Fc
	rYJZJbt3uFu9Ebf1DUrCCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520322; x=
	1732606722; bh=g0PLolSF2eKo9g5kXgNeG88ogXaZdr7ijAEaPkFBQqQ=; b=I
	KtiZ2bzKjF7TnodEtB9jnO6BSZ5pUaCVXJQUT7FPkSMgUp+IUFqwJ5fmi3dglD/h
	C1vMdeGfQGWnqF6hTOu9q7reRpKiD74gBeOqgsmoRJP76YWd7uXPTMcUo4oEZ5io
	e51Ueob+2maRB82kT5PBYKF4XE5eAZ0S95zcqI9DLHI9iAFsCzbS2XOPCL7DgfCA
	PSl8KMwA48cTCbCIl4aVqt1SpQNS/kHYYwm79FIxbmvMYO0hYfuJqiRT3J4vU3Ql
	IGZt4r6zRl7XRDOsyDoVR+7e/EJDyDTOO/CxkLAYTVUsI4l73y0oWlD/BGSg0VpC
	ZZxD5uZnFXbtagcsreoIA==
X-ME-Sender: <xms:gSlEZzdpDjiJFx7-GL-I3qCbVgbG0JF-YzL59uaZL6tbRBJzDRZSTw>
    <xme:gSlEZ5NSVMnUuZZ2lJVbvqDc7C-tFbQ-HCdrksUXqIVia2ir45zBW-LdDo2FEo8vB
    uKHGtZRYf42rZAg-A>
X-ME-Received: <xmr:gSlEZ8iS-ws8aL-S__ntB6kVqCEzN6ZioUYUzqtyMDHgV22RykG9G1YMLM3YFerycF91Rj5qm4oYyGYj1klOxqm2EAtByz2la-efIK1Yw0ebwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gilEZ0-bQCUQdJ0cwIKgqiALolTs5_oWd8dvSRMm5QIJq-pHx6EvHQ>
    <xmx:gilEZ_veItPAfBtO6FYQiAj0TO1QROrzt0i9Edlm3Ow1hEZiQ-KdDg>
    <xmx:gilEZzEPefT8rwabPkIjOtJsZeq4kvq-_4vFjKPVyb1lfYnPL_Jjjg>
    <xmx:gilEZ2MP-8wS4e7_kQ15Q4xZ0OQnQjMpZyySGYkA24wqWIdjUMAyqw>
    <xmx:gilEZ_LJxzol-as22sOPeyxLuG8QWcT2qewUfSX0vu9_mC1ke0pUrfvb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98ca0c99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:24 +0100
Subject: [PATCH v3 2/9] refs/reftable: handle reloading stacks in the
 reftable backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-2-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
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
index acd26f8928d18396f78a2d39ad0e0c1796d5a409..64fe8fd02d8ec932f7980cdb7d7d5223c3c83b73 100644
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
+	 * wrong to, as the value of "HEAD" could be modified concurrently at
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
2.47.0.274.g962d0b743d.dirty

