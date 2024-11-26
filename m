Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B524539A
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603394; cv=none; b=RFG9wVC41pLE3ftrDB/UuE+3/bUrr7hzCIf38fxUvvxnf0PSUfYDEJgVuqkYOAppasF3ygshWmMUO2/NBPieRnTMzm0SDYjAjPcG253pjjiEa6TregkEl7JU1HCegPY2wSw4PFOYYYhoB7EuZZgnL8e/eN0P4vXW2/Gtrh5kygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603394; c=relaxed/simple;
	bh=RY7R45HryQCGEurXCC5y44erK3ifKcC6cc4buSp1nQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDtYy9Vi4gdSVrQDF702bap36NAGAQesABT8y+SJAWJp1TqLTw84gkeiUMkTy2kkNj/TzMmZGGiXyc2Tnx+v3pscVLEJV6z9Z79nyBWp5RJCZxyiWxrgvGtkTcjNGCVboyOSGdBt1b6irgTB1+F8qTvz4adb92q2WPr2toUJ7wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mEaIry8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLsEzAaL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mEaIry8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLsEzAaL"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 576781140195;
	Tue, 26 Nov 2024 01:43:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 01:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603390;
	 x=1732689790; bh=X/1UpB6qwXH7Qlu/+bguFnTwdCuZMyX56PW7CQkIpZQ=; b=
	mEaIry8Cde4k22FPpaNfbDjXmMzKVTK5b9Rv0QPGjJ3QFC07gJW4xmcST5coN3pR
	dsTJhn5MofkjsjxE7mptXhOxIitZmV+NEWaNdKZE64it+i142TNwZ3IfXiTioZPs
	rIYKT740qG0VyOM5irlahYBC9lViz3fnMPe2KKSM6T4ywufeZv88wee/qiqeQAZl
	JhzGG/BrC3bpKQ9nNIEd2nA2OY1Wbe9orPM5TpnGup609D5nMr74s0n1jndllEjc
	Cnwv1Dc37QRNYFy78HHj72yTsT+AvaMjdtN0wSuzXZZsd0+2vHDjLZkEM/xjW5yi
	OfehPMMBIE18i+Qe04mrAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603390; x=
	1732689790; bh=X/1UpB6qwXH7Qlu/+bguFnTwdCuZMyX56PW7CQkIpZQ=; b=x
	LsEzAaLaO39Ihm2ythKfwl2xXGhQXR8fH/lLnE555ROzkKtuWzqBLdH6lDunVieK
	6KUusvGRz4p6cMWZFifY4Pt4tv+GUFpp8VC8MjpL6EeOlCsb3vnmjIcFsgvdnkhX
	dgW67ERjFdpsHv2alLHdMZYKOz9fZDJoTeKe045wUvqDxH7JLiXSzGH+qdO1l0Nq
	p7snqBfGFF7TeGvCpACswrEs+q/gJ/YpodurkFbVmDZiyGAW0AcDySIXGZwkEejE
	16SEbjk0OWFRj2cChiNIJ6wrLUK1P/oW1CjnjrJ77Dyc5AQHpjDaixg58mTe9Wy2
	AgPaAWc0dBYnGcIVPzoxg==
X-ME-Sender: <xms:_m1FZ370S6Vn8I22dH5olnQ6pHdGn0ZXlx8tI-0wG-z3J7LiaK4dZg>
    <xme:_m1FZ85pHo_1YfHslsKUHf6hO98QCyjQ-Pq4omufFmQiFKEv6nLqRdH-WyEUK9KPr
    EbCSli5gKqyiDIYDQ>
X-ME-Received: <xmr:_m1FZ-d4Smjt_HcY0PDXeCxzluVEyA6OSGOd0jvk5QDe7CFWKgaAs1N_2Cq4iqqL5MVmOPr4_wPcrQVArh16bCOQT7y83vvJiyL1iBy9pZLd2hqX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_m1FZ4JwLFxktou15EBBFHRgCrSu4zcuJd3H_VELh8dq_idov9KR4Q>
    <xmx:_m1FZ7J3HNy84hWOFlmixw8cUYpphTb6peSka-dKRUFtC2Ljy90i7g>
    <xmx:_m1FZxx_p4A_BwSSjzS9JVZ4E_Dk3y8TJbjfi0JaE4NzU-kj6SET6Q>
    <xmx:_m1FZ3LY8Su30NqWewtXAt0hfVhj77ge8wzcSmgPBn-f3kvRv2AyuA>
    <xmx:_m1FZz0sPkZxDb-0YwHV3qS38vH0h7FzfoiUyVL36ScwYWf1K1hliwBd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f4f44ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:52 +0100
Subject: [PATCH v4 01/10] refs/reftable: encapsulate reftable stack
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-1-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The reftable ref store needs to keep track of multiple stacks, one for
the main worktree and an arbitrary number of stacks for worktrees. This
is done by storing pointers to `struct reftable_stack`, which we then
access directly.

Wrap the stack in a new `struct reftable_backend`. This will allow us to
attach more data to each respective stack in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 135 +++++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 59 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f560bc2b67857d785294e6b5699383a256f30813..acd26f8928d18396f78a2d39ad0e0c1796d5a409 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -34,24 +34,41 @@
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
 
 	/*
-	 * The main stack refers to the common dir and thus contains common
+	 * The main backend refers to the common dir and thus contains common
 	 * refs as well as refs of the main repository.
 	 */
-	struct reftable_stack *main_stack;
+	struct reftable_backend main_backend;
 	/*
-	 * The worktree stack refers to the gitdir in case the refdb is opened
+	 * The worktree backend refers to the gitdir in case the refdb is opened
 	 * via a worktree. It thus contains the per-worktree refs.
 	 */
-	struct reftable_stack *worktree_stack;
+	struct reftable_backend worktree_backend;
 	/*
-	 * Map of worktree stacks by their respective worktree names. The map
+	 * Map of worktree backends by their respective worktree names. The map
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
+	if (!refs->worktree_backend.stack)
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
2.47.0.366.gd4f858ca17.dirty

