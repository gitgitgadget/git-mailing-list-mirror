Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220F1D0178
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797930; cv=none; b=UcninI+L9G2YhI3Ag588vl28Lze6zkTsewEmVVebNxWYnwTOfcyRnaJbH+50LDy0+wYCLdpHn7tZLVqNrA9qx5aR3bRO7uShRqZCZZ2CRK8uXWBgcYzvQP2RMrgoi4X6Sn5LfDF1CSCEk+SS9wpEYqKctaEndthbyu022Mv46Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797930; c=relaxed/simple;
	bh=Tm1oNdX9U6in/xWokSHxBUDwSGLPW+NLibKjijzcEEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK9l0HBUuk/IXplPVtks5HNlWcmRtJtBC3kODYHO37vDhq9WJFCr/eQpwV4MHo5Mk6avcTPifxvij9yim1XkLu/BHeX87aptu5dwd8v6UW1rJLljc+Kj+dJbqxGkYXefhRqWbcyQhpry28JtrKWdLeam115oBlNWoxM+C6yxeus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JGiDuFXA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iqCN7wmW; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JGiDuFXA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iqCN7wmW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04884254012F;
	Tue,  5 Nov 2024 04:12:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 05 Nov 2024 04:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797926; x=1730884326; bh=wYHPK8fOUi
	o7+oxZJpDpyLQkA6xgtH6hjFcp9Fy2bMU=; b=JGiDuFXA6LHpM5Qan+16RmaYhp
	nSGpyYlhVKKtV+y99wbxTdeoZI235ILgP7Gqyl4aQHHW5pjFdx4pm6KcHjCkQqpD
	Up2377C+Wb6lE88znnhSGNR4ze8Y6J5nZZdju1OdXkYzq5zVq/N2M+tVzwicNS+b
	RcNbbs1QcfqR1zhuIU25Qh52zEMo8RdglI8zgJJblpiUL2g2+4xmuBbOlqzwqRxO
	TvyIspMGF6S0DwsjtXPfktkw6Zi4OZog/wxWz3tYcWq7ih+1rpSHEvj7UcCGwMhG
	wJ9S4vFUTmrvOUnZyGzbpGjpdtVUNekDduTzJ2z/BcDlQH7dCb3OjXmMaLxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797926; x=1730884326; bh=wYHPK8fOUio7+oxZJpDpyLQkA6xgtH6hjFc
	p9Fy2bMU=; b=iqCN7wmW7owe9R60m41yD5agJ5VgTgrwet1ueToglooGIBrUqnf
	FBSfhF3tOB61meSwqkzUTJdgWM5nXU8V6XbPG1aww3FCesi18xzBakZXwZ35ObsJ
	tlGm1RvHy3eRJPXPvNbO+odx+YxljmyGIhY7Fh0DV2nXkDdDYEYUMgCqvEyQNP/R
	lOzkTLU6B9EEpHJIZJhQyL6y9nd9XKIoJz2pwHFJxwf4xLoDP09Ualu2ZNwRieHI
	aPNk9i3DdDysMEzvvPZ94fK2Grb06rX81t5SApptuBzj3ZOScGbVRUG43BDz+11a
	XJ4kbYsiNIclyHX8zMixrjPkm3KEE0Ar+IQ==
X-ME-Sender: <xms:ZuEpZ8viA7s0s8eeGk7EkHg4HAmzEelDpTfwYoPfIPbt7IbD-5gysQ>
    <xme:ZuEpZ5cOhINgmJBRNwHaZeqg7qXXmKAd6Fn_d2TcDcz_hX0c_tghun_eDOzUr7fKN
    4mkU5HYOMd36YQ7WQ>
X-ME-Received: <xmr:ZuEpZ3w46gAC2shIveI-VQl7BAhMk4WnDf-zkzRPj5ZIFaX_NHEfjnazZTji88VY3dvrs_uMmrpYB7NR1zo-OoqQbN5cCHpmiK_0_50f63Z-2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:ZuEpZ_PgrLGf7Zob5t1FZHE2ZRxPFdgtuuNJ8YO1xCI434Gg-u_ewA>
    <xmx:ZuEpZ8_d_U49U18HS2D-D4tyfJSo7EvgEnmuDkqy8A4DAWbTMrG7sw>
    <xmx:ZuEpZ3UHGjWvULiJvpbstFlqsuHbXi-0iV_cSmarb8nD_oRdFOGQGQ>
    <xmx:ZuEpZ1fcQcdGfZdN2WhNzmf8AHUukxJK2mOTBFcFajIHWW3T3Eob6A>
    <xmx:ZuEpZ-I1MzhFCYkwcBYdO5_bdEa34EtvWDunblARTy0NvHo8HyAqq-8x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfd7a2c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:11:44 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:11:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] refs/reftable: encapsulate reftable stack
Message-ID: <ac01c06c4177d1b07678972115648d125c2bdc66.1730792627.git.ps@pks.im>
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

The reftable ref store needs to keep track of multiple stacks, one for
the main worktree and an arbitrary number of stacks for worktrees. This
is done by storing pointers to `struct reftable_stack`, which we then
access directly.

Wrap the stack in a new `struct reftable_backend`. This will allow us to
attach more data to each respective stack in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 129 +++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 56 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f560bc2b67..116cc5ec23 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -34,6 +34,23 @@
  */
 #define REF_UPDATE_VIA_HEAD (1 << 8)
 
+struct reftable_backend {
+	struct reftable_stack *stack;
+};
+
+static int reftable_backend_init(struct reftable_backend *be,
+				 const char *path,
+				 const struct reftable_write_options *opts)
+{
+	return reftable_new_stack(&be->stack, path, opts);
+}
+
+static void reftable_backend_release(struct reftable_backend *be)
+{
+	reftable_stack_destroy(be->stack);
+	be->stack = NULL;
+}
+
 struct reftable_ref_store {
 	struct ref_store base;
 
@@ -41,17 +58,17 @@ struct reftable_ref_store {
 	 * The main stack refers to the common dir and thus contains common
 	 * refs as well as refs of the main repository.
 	 */
-	struct reftable_stack *main_stack;
+	struct reftable_backend main_backend;
 	/*
 	 * The worktree stack refers to the gitdir in case the refdb is opened
 	 * via a worktree. It thus contains the per-worktree refs.
 	 */
-	struct reftable_stack *worktree_stack;
+	struct reftable_backend worktree_backend;
 	/*
 	 * Map of worktree stacks by their respective worktree names. The map
 	 * is populated lazily when we try to resolve `worktrees/$worktree` refs.
 	 */
-	struct strmap worktree_stacks;
+	struct strmap worktree_backends;
 	struct reftable_write_options write_options;
 
 	unsigned int store_flags;
@@ -97,21 +114,21 @@ static struct reftable_ref_store *reftable_be_downcast(struct ref_store *ref_sto
  * like `worktrees/$worktree/refs/heads/foo` as worktree stacks will store
  * those references in their normalized form.
  */
-static struct reftable_stack *stack_for(struct reftable_ref_store *store,
-					const char *refname,
-					const char **rewritten_ref)
+static struct reftable_backend *backend_for(struct reftable_ref_store *store,
+					    const char *refname,
+					    const char **rewritten_ref)
 {
 	const char *wtname;
 	int wtname_len;
 
 	if (!refname)
-		return store->main_stack;
+		return &store->main_backend;
 
 	switch (parse_worktree_ref(refname, &wtname, &wtname_len, rewritten_ref)) {
 	case REF_WORKTREE_OTHER: {
 		static struct strbuf wtname_buf = STRBUF_INIT;
 		struct strbuf wt_dir = STRBUF_INIT;
-		struct reftable_stack *stack;
+		struct reftable_backend *be;
 
 		/*
 		 * We're using a static buffer here so that we don't need to
@@ -125,37 +142,39 @@ static struct reftable_stack *stack_for(struct reftable_ref_store *store,
 		/*
 		 * There is an edge case here: when the worktree references the
 		 * current worktree, then we set up the stack once via
-		 * `worktree_stacks` and once via `worktree_stack`. This is
+		 * `worktree_backends` and once via `worktree_backend`. This is
 		 * wasteful, but in the reading case it shouldn't matter. And
 		 * in the writing case we would notice that the stack is locked
 		 * already and error out when trying to write a reference via
 		 * both stacks.
 		 */
-		stack = strmap_get(&store->worktree_stacks, wtname_buf.buf);
-		if (!stack) {
+		be = strmap_get(&store->worktree_backends, wtname_buf.buf);
+		if (!be) {
 			strbuf_addf(&wt_dir, "%s/worktrees/%s/reftable",
 				    store->base.repo->commondir, wtname_buf.buf);
 
-			store->err = reftable_new_stack(&stack, wt_dir.buf,
-							&store->write_options);
+			CALLOC_ARRAY(be, 1);
+			store->err = reftable_backend_init(be, wt_dir.buf,
+							   &store->write_options);
 			assert(store->err != REFTABLE_API_ERROR);
-			strmap_put(&store->worktree_stacks, wtname_buf.buf, stack);
+
+			strmap_put(&store->worktree_backends, wtname_buf.buf, be);
 		}
 
 		strbuf_release(&wt_dir);
-		return stack;
+		return be;
 	}
 	case REF_WORKTREE_CURRENT:
 		/*
 		 * If there is no worktree stack then we're currently in the
 		 * main worktree. We thus return the main stack in that case.
 		 */
-		if (!store->worktree_stack)
-			return store->main_stack;
-		return store->worktree_stack;
+		if (!store->worktree_backend.stack)
+			return &store->main_backend;
+		return &store->worktree_backend;
 	case REF_WORKTREE_MAIN:
 	case REF_WORKTREE_SHARED:
-		return store->main_stack;
+		return &store->main_backend;
 	default:
 		BUG("unhandled worktree reference type");
 	}
@@ -292,7 +311,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	umask(mask);
 
 	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
-	strmap_init(&refs->worktree_stacks);
+	strmap_init(&refs->worktree_backends);
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 
@@ -337,8 +356,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 		strbuf_realpath(&path, gitdir, 0);
 	}
 	strbuf_addstr(&path, "/reftable");
-	refs->err = reftable_new_stack(&refs->main_stack, path.buf,
-				       &refs->write_options);
+	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
+					  &refs->write_options);
 	if (refs->err)
 		goto done;
 
@@ -354,8 +373,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 		strbuf_reset(&path);
 		strbuf_addf(&path, "%s/reftable", gitdir);
 
-		refs->err = reftable_new_stack(&refs->worktree_stack, path.buf,
-					       &refs->write_options);
+		refs->err = reftable_backend_init(&refs->worktree_backend, path.buf,
+						  &refs->write_options);
 		if (refs->err)
 			goto done;
 	}
@@ -374,19 +393,17 @@ static void reftable_be_release(struct ref_store *ref_store)
 	struct strmap_entry *entry;
 	struct hashmap_iter iter;
 
-	if (refs->main_stack) {
-		reftable_stack_destroy(refs->main_stack);
-		refs->main_stack = NULL;
-	}
+	if (refs->main_backend.stack)
+		reftable_backend_release(&refs->main_backend);
+	if (refs->worktree_backend.stack)
+		reftable_backend_release(&refs->worktree_backend);
 
-	if (refs->worktree_stack) {
-		reftable_stack_destroy(refs->worktree_stack);
-		refs->worktree_stack = NULL;
+	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
+		struct reftable_backend *be = entry->value;
+		reftable_backend_release(be);
+		free(be);
 	}
-
-	strmap_for_each_entry(&refs->worktree_stacks, &iter, entry)
-		reftable_stack_destroy(entry->value);
-	strmap_clear(&refs->worktree_stacks, 0);
+	strmap_clear(&refs->worktree_backends, 0);
 }
 
 static int reftable_be_create_on_disk(struct ref_store *ref_store,
@@ -781,7 +798,7 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 		required_flags |= REF_STORE_ODB;
 	refs = reftable_be_downcast(ref_store, required_flags, "ref_iterator_begin");
 
-	main_iter = ref_iterator_for_stack(refs, refs->main_stack, prefix,
+	main_iter = ref_iterator_for_stack(refs, refs->main_backend.stack, prefix,
 					   exclude_patterns, flags);
 
 	/*
@@ -789,14 +806,14 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 	 * right now. If we aren't, then we return the common reftable
 	 * iterator, only.
 	 */
-	 if (!refs->worktree_stack)
+	 if (!refs->worktree_backend.stack)
 		return &main_iter->base;
 
 	/*
 	 * Otherwise we merge both the common and the per-worktree refs into a
 	 * single iterator.
 	 */
-	worktree_iter = ref_iterator_for_stack(refs, refs->worktree_stack, prefix,
+	worktree_iter = ref_iterator_for_stack(refs, refs->worktree_backend.stack, prefix,
 					       exclude_patterns, flags);
 	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					ref_iterator_select, NULL);
@@ -811,7 +828,7 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	int ret;
 
 	if (refs->err < 0)
@@ -838,7 +855,7 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_symbolic_ref");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_ref_record ref = {0};
 	int ret;
 
@@ -898,7 +915,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 				      struct ref_update *update,
 				      struct strbuf *err)
 {
-	struct reftable_stack *stack = stack_for(refs, update->refname, NULL);
+	struct reftable_stack *stack = backend_for(refs, update->refname, NULL)->stack;
 	struct write_transaction_table_arg *arg = NULL;
 	size_t i;
 	int ret;
@@ -1031,7 +1048,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		goto done;
 	}
 
-	ret = read_ref_without_reload(refs, stack_for(refs, "HEAD", NULL), "HEAD",
+	ret = read_ref_without_reload(refs, backend_for(refs, "HEAD", NULL)->stack, "HEAD",
 				      &head_oid, &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
@@ -1043,7 +1060,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		struct reftable_stack *stack;
 		const char *rewritten_ref;
 
-		stack = stack_for(refs, u->refname, &rewritten_ref);
+		stack = backend_for(refs, u->refname, &rewritten_ref)->stack;
 
 		/* Verify that the new object ID is valid. */
 		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1525,9 +1542,9 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	if (refs->err)
 		return refs->err;
 
-	stack = refs->worktree_stack;
+	stack = refs->worktree_backend.stack;
 	if (!stack)
-		stack = refs->main_stack;
+		stack = refs->main_backend.stack;
 
 	if (opts->flags & PACK_REFS_AUTO)
 		ret = reftable_stack_auto_compact(stack);
@@ -1782,7 +1799,7 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_stack *stack = stack_for(refs, newrefname, &newrefname);
+	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.stack = stack,
@@ -1814,7 +1831,7 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_stack *stack = stack_for(refs, newrefname, &newrefname);
+	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.stack = stack,
@@ -1952,11 +1969,11 @@ static struct ref_iterator *reftable_be_reflog_iterator_begin(struct ref_store *
 		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_iterator_begin");
 	struct reftable_reflog_iterator *main_iter, *worktree_iter;
 
-	main_iter = reflog_iterator_for_stack(refs, refs->main_stack);
-	if (!refs->worktree_stack)
+	main_iter = reflog_iterator_for_stack(refs, refs->main_backend.stack);
+	if (!refs->worktree_backend.stack)
 		return &main_iter->base;
 
-	worktree_iter = reflog_iterator_for_stack(refs, refs->worktree_stack);
+	worktree_iter = reflog_iterator_for_stack(refs, refs->worktree_backend.stack);
 
 	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					ref_iterator_select, NULL);
@@ -1995,7 +2012,7 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_reverse");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record log = {0};
 	struct reftable_iterator it = {0};
 	int ret;
@@ -2035,7 +2052,7 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record *logs = NULL;
 	struct reftable_iterator it = {0};
 	size_t logs_alloc = 0, logs_nr = 0, i;
@@ -2084,7 +2101,7 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record log = {0};
 	struct reftable_iterator it = {0};
 	int ret;
@@ -2169,7 +2186,7 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct write_reflog_existence_arg arg = {
 		.refs = refs,
 		.stack = stack,
@@ -2243,7 +2260,7 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct write_reflog_delete_arg arg = {
 		.stack = stack,
 		.refname = refname,
@@ -2352,7 +2369,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	 */
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record *logs = NULL;
 	struct reftable_log_record *rewritten = NULL;
 	struct reftable_ref_record ref_record = {0};
-- 
2.47.0.229.g8f8d6eee53.dirty

