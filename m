Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED371C07CA
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733107; cv=none; b=NTDjG3speQSnlxXrw2B78YPWBQsfwG9Oa94/0Bmi5aXmtjO68WbRX9QzG8ZZvjpe5qLzWn9bSotIiIVy7wIF+CwqAmy7szmVDeh6MCLKPqKXyHLHDefSM2u8FcZKoD5KcsSzqu51q/ZFaRhfUJ5PoSsDmwM0LQ4z4kuIPUYO0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733107; c=relaxed/simple;
	bh=zQlMAAMws6ymqqtGyjfT4kS/QrzVVQ1AyaPNEy4sPB0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el/27qsIkqTqlo1v/5icRNOnhprYjAHg35X850cBajCIAJN7DxkPH9snLeg5TLQcQVWsvuUhAPhXwohvcDMPW+zTPtDRcEfRmbT/AMT+uW+SgDyI8RosEX0RD/TCkQXXyQ6W0xo4MQy4m0NtNsTgQNPbyx9ujztEIsnhKsT0O4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gtWPN9j/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZh0bxLn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gtWPN9j/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZh0bxLn"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA4DE1140105
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 04 Nov 2024 10:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733103; x=1730819503; bh=jD5TH/dyUW
	fHId9idibHRTaTqxCbNPcmvzJsX3mKvMo=; b=gtWPN9j/berVjLfLI1gLuEgMTq
	Hz9IXUjk2Za6s5mT82nf7NnrxQYR/hPEp+xhhCegzvT/i3LaRCtGemJiaYnFFKS3
	YsFV4tGyFi2aIvNPCULAPXkaMbzAKZhqn2/VXZmbF0lqVQ83KtS2SNf/29wBIZRc
	PaaS126cSr5BG/fQMvigt43/Hxj42JPl7cWgZrul60ITkwVNig6u+H5OXJPswQXs
	Mh27Mc2C2A/UP11PvzKpZffxHfEF5V9BznYsWQTsyViQddxEcpQTKfmTvxjc4HfH
	Y8/qPS8Bf43Y8+gctVsL6DNlUIneL6Yhk23q+SqEbyVgFCnc6XCiNudTmhHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733103; x=1730819503; bh=jD5TH/dyUWfHId9idibHRTaTqxCbNPcmvzJ
	sX3mKvMo=; b=fZh0bxLnyQzBb5tAAENxgzi32ke5akHb8D1kcqEPSU51pMEa6OF
	zfkeVFuSiAJxxI60nkhzcAHoRi/Kv8q29+qybMyvLKKM/XJxXFiHNiT7WbsAT4Q9
	V5AZsudUgbyH7XJcpT3f5dtUcymLKsxB8ml0iLtC+A79pwtyYsimK0BFAv1Zg/oY
	TgzvdNGoBjb06ShITW0wb39FRP4BND3W+H4h8c7mbF4tyc1a+yR0H1qVdg3q5+Bl
	WIyjIMviYbsbObkYBM2YiJl4fuoma950XabWz1BWWdi5I1Kv+msXejL7tqMs3f8X
	QVCR4yUMmO6UHXfyrNnGmzn4LxnyHaRoD9A==
X-ME-Sender: <xms:L-QoZ46m9IgPz3rqKKeeFrF26FBQfTYsThC61IJLHSKY75sWVsC2vA>
    <xme:L-QoZ56arBTHXzV9r6cd7HROki1tKQ-v1tlXuGKJId28h7DPYKtMBZecvtNyzq6wd
    _HBB8zIRQfHedgJEQ>
X-ME-Received: <xmr:L-QoZ3chcGXaXwxHIWsURzeX7imj7W5N8HzWyyHkH9Ry45hD1jeow316E0bjHYOQVGdb4OSQJORy7MKgudhjWsTdYCbm7zZw0GNCzIs4mipuELuTsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:L-QoZ9KVZj_v6ZwtxYpjP_tj1BO_pOeo16E2D8zVUP_Fc7k_KF0P4w>
    <xmx:L-QoZ8I6JJ8YVFjsrSRwlX-CqF4VnUf3ZIeY0CIF3s80uATiXLnP0w>
    <xmx:L-QoZ-zs9Tb4HoOpjYj-sAl9SUZ6xmdjN-csEjllyiNtNzREQ0bk6w>
    <xmx:L-QoZwJ6v91WMGLfQeFr450eXCUJz2lSDaA3STl3pjftHNl0bcpC5g>
    <xmx:L-QoZ2jJ9xMPnoCfm7QSsesnitRZx-0d_3oddHZLp2TTYJn6xuviLSII>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 287dfcbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:21 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/8] refs/reftable: encapsulate reftable stack
Message-ID: <b599bcdac191fd3cfb7797accebd79211e757c47.1730732881.git.ps@pks.im>
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
index 38eb14d591..43cba53cb1 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -32,6 +32,23 @@
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
 
@@ -39,17 +56,17 @@ struct reftable_ref_store {
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
@@ -95,21 +112,21 @@ static struct reftable_ref_store *reftable_be_downcast(struct ref_store *ref_sto
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
@@ -123,37 +140,39 @@ static struct reftable_stack *stack_for(struct reftable_ref_store *store,
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
@@ -285,7 +304,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	umask(mask);
 
 	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
-	strmap_init(&refs->worktree_stacks);
+	strmap_init(&refs->worktree_backends);
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 
@@ -320,8 +339,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 		strbuf_realpath(&path, gitdir, 0);
 	}
 	strbuf_addstr(&path, "/reftable");
-	refs->err = reftable_new_stack(&refs->main_stack, path.buf,
-				       &refs->write_options);
+	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
+					  &refs->write_options);
 	if (refs->err)
 		goto done;
 
@@ -337,8 +356,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 		strbuf_reset(&path);
 		strbuf_addf(&path, "%s/reftable", gitdir);
 
-		refs->err = reftable_new_stack(&refs->worktree_stack, path.buf,
-					       &refs->write_options);
+		refs->err = reftable_backend_init(&refs->worktree_backend, path.buf,
+						  &refs->write_options);
 		if (refs->err)
 			goto done;
 	}
@@ -357,19 +376,17 @@ static void reftable_be_release(struct ref_store *ref_store)
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
@@ -764,7 +781,7 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 		required_flags |= REF_STORE_ODB;
 	refs = reftable_be_downcast(ref_store, required_flags, "ref_iterator_begin");
 
-	main_iter = ref_iterator_for_stack(refs, refs->main_stack, prefix,
+	main_iter = ref_iterator_for_stack(refs, refs->main_backend.stack, prefix,
 					   exclude_patterns, flags);
 
 	/*
@@ -772,14 +789,14 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
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
@@ -794,7 +811,7 @@ static int reftable_be_read_raw_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	int ret;
 
 	if (refs->err < 0)
@@ -821,7 +838,7 @@ static int reftable_be_read_symbolic_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "read_symbolic_ref");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_ref_record ref = {0};
 	int ret;
 
@@ -881,7 +898,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 				      struct ref_update *update,
 				      struct strbuf *err)
 {
-	struct reftable_stack *stack = stack_for(refs, update->refname, NULL);
+	struct reftable_stack *stack = backend_for(refs, update->refname, NULL)->stack;
 	struct write_transaction_table_arg *arg = NULL;
 	size_t i;
 	int ret;
@@ -1014,7 +1031,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		goto done;
 	}
 
-	ret = read_ref_without_reload(refs, stack_for(refs, "HEAD", NULL), "HEAD",
+	ret = read_ref_without_reload(refs, backend_for(refs, "HEAD", NULL)->stack, "HEAD",
 				      &head_oid, &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
@@ -1026,7 +1043,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 		struct reftable_stack *stack;
 		const char *rewritten_ref;
 
-		stack = stack_for(refs, u->refname, &rewritten_ref);
+		stack = backend_for(refs, u->refname, &rewritten_ref)->stack;
 
 		/* Verify that the new object ID is valid. */
 		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
@@ -1508,9 +1525,9 @@ static int reftable_be_pack_refs(struct ref_store *ref_store,
 	if (refs->err)
 		return refs->err;
 
-	stack = refs->worktree_stack;
+	stack = refs->worktree_backend.stack;
 	if (!stack)
-		stack = refs->main_stack;
+		stack = refs->main_backend.stack;
 
 	if (opts->flags & PACK_REFS_AUTO)
 		ret = reftable_stack_auto_compact(stack);
@@ -1765,7 +1782,7 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct reftable_stack *stack = stack_for(refs, newrefname, &newrefname);
+	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.stack = stack,
@@ -1797,7 +1814,7 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "copy_ref");
-	struct reftable_stack *stack = stack_for(refs, newrefname, &newrefname);
+	struct reftable_stack *stack = backend_for(refs, newrefname, &newrefname)->stack;
 	struct write_copy_arg arg = {
 		.refs = refs,
 		.stack = stack,
@@ -1935,11 +1952,11 @@ static struct ref_iterator *reftable_be_reflog_iterator_begin(struct ref_store *
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
@@ -1978,7 +1995,7 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_reverse");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record log = {0};
 	struct reftable_iterator it = {0};
 	int ret;
@@ -2018,7 +2035,7 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record *logs = NULL;
 	struct reftable_iterator it = {0};
 	size_t logs_alloc = 0, logs_nr = 0, i;
@@ -2067,7 +2084,7 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "reflog_exists");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct reftable_log_record log = {0};
 	struct reftable_iterator it = {0};
 	int ret;
@@ -2152,7 +2169,7 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct write_reflog_existence_arg arg = {
 		.refs = refs,
 		.stack = stack,
@@ -2226,7 +2243,7 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "delete_reflog");
-	struct reftable_stack *stack = stack_for(refs, refname, &refname);
+	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
 	struct write_reflog_delete_arg arg = {
 		.stack = stack,
 		.refname = refname,
@@ -2335,7 +2352,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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

