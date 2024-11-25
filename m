Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114F2119
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520322; cv=none; b=oDQA1CUecaNndHbY6UpDbUl1PiAyBYhOUsY8C6L/l6uy1vsJx61+bBEvQ89E36je51Muc80fyGN3YbQe+haoWeRS3uFOkNLXz7jz+JfMU8C6dxHFuUXxG5rB5bLP5f5hfSKujd6KAHaLD/Jvl737ajUNzTsv639411KBfn3qE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520322; c=relaxed/simple;
	bh=AfO9yVn5jQrgZJTsv6qryfOxMOQkBmiHLRVh1RAdzhU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=k0BNQfTZFjgg8ISnUc4zDsoQlXv+Sf5F1NcQUKTOl8M6wGo8ybecB9Fj/mQ17Ig8g8RBQ/4nHUO74wJjeeGX7BpBFGQGiwYzQofU20jBZPSqyBXDg+su35W5MQXSVX85D6kouNyW0hlpQWDKMwawWaJ0OKU5MCWa6ruDfl6f1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f2jz1pkx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yaVz5l9y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f2jz1pkx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yaVz5l9y"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60A87254014C;
	Mon, 25 Nov 2024 02:38:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 25 Nov 2024 02:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520319;
	 x=1732606719; bh=7vZfeTPqVoudkc9Y4MAjuNAe1tEz1hOHYtRBXU7h+yw=; b=
	f2jz1pkxEG/pgCpNqP5aLUoXg05pGKg17OzCp/gIvtAT03f1DzQ2u7UCkk8LCvvp
	poGVfbo8OID3NfqilvFN+PUx7LpUl00GxnLsmnTDxdQNsDab3FlAb3W3axjJTD86
	Z0uPOGVRrRyqcVHoOU29pTigj0O8ktbaf8y0K7Vsh2D3FgCtzqlQ9WRfjkNfIGLD
	cmalcq/BFXKAVyNzBWkrHQtva/9P0jCgaQyNtDeqPqHfBslLAzSC2W78/4bLX9kG
	goruWSD+1XgG01Q79Fe0UyMPpVjFr1x9dQWYIPnK2dHjK+r89YzCBPk/RZLuBTlO
	KQc7RrGSjT5u03sNzsczyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520319; x=
	1732606719; bh=7vZfeTPqVoudkc9Y4MAjuNAe1tEz1hOHYtRBXU7h+yw=; b=y
	aVz5l9y7dQhkyj2BPotOdN1OtDZ+PXuKHGeJyf14V/FgnF+3fvRZcBtguOaVE9Hx
	8LUAju1tYSQjU8jmqcS2Yq/4FJcGYnJGclcd7fCplW/d2lpQwA87K9YZ3kpGESTq
	EXnTDdoFmm0b26lMnczi/0HFnYpbxvI+gZYRJSluOU6qDSmwlMkr+/1fknEEwLtV
	c6ctz4xNqRT/kMdwuBXnZn10Gb/2KZZosUjGFxUpSW1gt/ugi6gnM5UKNCX6BCDT
	//pTl71JfDH9kAPyUoG5vdDPko8BmTCJUPEugIO8TuZL7ZkZiqFX6LaUJ+9SOLOO
	fCYR1J6o+X7HEGdTHAgvQ==
X-ME-Sender: <xms:fylEZxTvlUi6NNywxUIOOnt7vD18xD9p6p-5yfXHTcMGuedJwOlxpA>
    <xme:fylEZ6zfCKNkqcGaiCtVSoBRy3NUjjvIv4QyCn3MFkd9tLQdcBrHfsg8sex2PKWZb
    SYuuevK81UtwJ3ryQ>
X-ME-Received: <xmr:fylEZ20crLXCCuX1DFz69Q_oSB9KhYMFZWhpR_hiflcCr1eTNbTcnunLVW5KaL2lfxdo4EHH5ebzJkYooGdBFfLlgVoEuVo4085JWHVHjG-FnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeek
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:fylEZ5B0Mfs-4Bm8knd9ZS76HQgc9h5Sj_aIZ6OAmMIkV5kJS6wEAg>
    <xmx:fylEZ6jFy_PeCI70AfwWMDnqlIbc_-1ocJFiZJT95tHrj0oBNy4Akw>
    <xmx:fylEZ9q0Hkm6sq94HWtUU9jYSRLyGL7SJRo5mlEssyMAeQmCk39fag>
    <xmx:fylEZ1huJPDfGvr7oAuD3lfjfW8Df8EAdtGpcS0RG7vhd29lCyIFqw>
    <xmx:fylEZ7sbc-7gDWJEexA0f0_zoomiq4Nothp28HOuSKEZWnzQxliHtXGv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b58392fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] refs/reftable: reuse iterators when reading refs
Date: Mon, 25 Nov 2024 08:38:22 +0100
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG4pRGcC/12NQQ6CMBBFr0JmbRs6RQuuvIdxUWCEBgXS1kZDu
 LsDS5bv5828BQJ5RwGu2QKekgtuGhn0KYOmt2NHwrXMgDkWSuFZzEMQnp7R1i8StW0GGlsePoH
 NSF5oi1RhgaUpK+AvM8vuuxfuD+behTj53x5MaluhmRJ5qYzOjcayVLJzUc7hxinp3rBdJTyaF
 V7QHM11Xf/09qPC0gAAAA==
X-Change-ID: 20241125-pks-reftable-backend-reuse-iter-3a2e92428789
In-Reply-To: <cover.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this is the second version of my patch series that refactors the
reftable backend to reuse iterators when reading random references. This
removes the overhead of having to recreate the iterator on every read
and thus leads to better performance and less allocation churn.

Changes in v3:

  - Adapt some comments to refer to the "backend" instead of to the
    "stack".
  - Fix indentation of a statement while at it.
  - Explain why callsites don't want to reload the stack.
  - Optimize `prepare_transaction_update()` by not using `backend_for()`
    twice, but instead reload the stack manually.
  - Split out the change that adds `reftable_stack_hash_id()` into a
    separate commit.
  - Link to v2: https://lore.kernel.org/r/cover.1730792627.git.ps@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (9):
      refs/reftable: encapsulate reftable stack
      refs/reftable: handle reloading stacks in the reftable backend
      reftable/stack: add accessor for the hash ID
      refs/reftable: read references via `struct reftable_backend`
      refs/reftable: refactor reading symbolic refs to use reftable backend
      refs/reftable: refactor reflog expiry to use reftable backend
      reftable/stack: add mechanism to notify callers on reload
      reftable/merged: drain priority queue on reseek
      refs/reftable: reuse iterators when reading refs

 refs/reftable-backend.c          | 409 +++++++++++++++++++++++++--------------
 reftable/merged.c                |   2 +
 reftable/reftable-stack.h        |   3 +
 reftable/reftable-writer.h       |   9 +
 reftable/stack.c                 |   9 +
 t/unit-tests/t-reftable-merged.c |  73 +++++++
 6 files changed, 357 insertions(+), 148 deletions(-)

Range-diff versus v2:

 1:  9854214fe9 !  1:  21071ae5a5 refs/reftable: encapsulate reftable stack
    @@ refs/reftable-backend.c
      struct reftable_ref_store {
      	struct ref_store base;
      
    -@@ refs/reftable-backend.c: struct reftable_ref_store {
    - 	 * The main stack refers to the common dir and thus contains common
    + 	/*
    +-	 * The main stack refers to the common dir and thus contains common
    ++	 * The main backend refers to the common dir and thus contains common
      	 * refs as well as refs of the main repository.
      	 */
     -	struct reftable_stack *main_stack;
     +	struct reftable_backend main_backend;
      	/*
    - 	 * The worktree stack refers to the gitdir in case the refdb is opened
    +-	 * The worktree stack refers to the gitdir in case the refdb is opened
    ++	 * The worktree backend refers to the gitdir in case the refdb is opened
      	 * via a worktree. It thus contains the per-worktree refs.
      	 */
     -	struct reftable_stack *worktree_stack;
     +	struct reftable_backend worktree_backend;
      	/*
    - 	 * Map of worktree stacks by their respective worktree names. The map
    +-	 * Map of worktree stacks by their respective worktree names. The map
    ++	 * Map of worktree backends by their respective worktree names. The map
      	 * is populated lazily when we try to resolve `worktrees/$worktree` refs.
      	 */
     -	struct strmap worktree_stacks;
    @@ refs/reftable-backend.c: static struct ref_iterator *reftable_be_iterator_begin(
      	 * iterator, only.
      	 */
     -	 if (!refs->worktree_stack)
    -+	 if (!refs->worktree_backend.stack)
    ++	if (!refs->worktree_backend.stack)
      		return &main_iter->base;
      
      	/*
 2:  18265dfafc !  2:  a9588125c7 refs/reftable: handle reloading stacks in the reftable backend
    @@ Commit message
         But second this makes the logic to access stacks more self-contained by
         letting the `struct reftable_backend` manage themselves.
     
    +    Update callsites where we don't reload the stack to document why we
    +    don't. In some cases it's unclear whether it is the right thing to do in
    +    the first place, but fixing that is outside of the scope of this patch
    +    series.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs/reftable-backend.c ##
    @@ refs/reftable-backend.c: static int prepare_transaction_update(struct write_tran
      	size_t i;
      	int ret;
      
    ++	/*
    ++	 * This function gets called in a loop, and we don't want to repeatedly
    ++	 * reload the stack for every single ref update. Instead, we manually
    ++	 * reload further down in the case where we haven't yet prepared the
    ++	 * specific `reftable_backend`.
    ++	 */
     +	ret = backend_for(&be, refs, update->refname, NULL, 0);
     +	if (ret)
     +		return ret;
    @@ refs/reftable-backend.c: static int prepare_transaction_update(struct write_tran
      		struct reftable_addition *addition;
      
     -		ret = reftable_stack_reload(stack);
    -+		ret = backend_for(&be, refs, update->refname, NULL, 1);
    ++		ret = reftable_stack_reload(be->stack);
      		if (ret)
      			return ret;
      
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      	}
      
     -	ret = read_ref_without_reload(refs, backend_for(refs, "HEAD", NULL)->stack, "HEAD",
    ++	/*
    ++	 * TODO: it's dubious whether we should reload the stack that "HEAD"
    ++	 * belongs to or not. In theory, it may happen that we only modify
    ++	 * stacks which are _not_ part of the "HEAD" stack. In that case we
    ++	 * wouldn't have prepared any transaction for its stack and would not
    ++	 * have reloaded it, which may mean that it is stale.
    ++	 *
    ++	 * On the other hand, reloading that stack without locking it feels
    ++	 * wrong to, as the value of "HEAD" could be modified concurrently at
    ++	 * any point in time.
    ++	 */
     +	ret = backend_for(&be, refs, "HEAD", NULL, 0);
     +	if (ret)
     +		goto done;
    @@ refs/reftable-backend.c: static int reftable_be_transaction_prepare(struct ref_s
      		const char *rewritten_ref;
      
     -		stack = backend_for(refs, u->refname, &rewritten_ref)->stack;
    ++		/*
    ++		 * There is no need to reload the respective backends here as
    ++		 * we have already reloaded them when preparing the transaction
    ++		 * update. And given that the stacks have been locked there
    ++		 * shouldn't have been any concurrent modifications of the
    ++		 * stack.
    ++		 */
     +		ret = backend_for(&be, refs, u->refname, &rewritten_ref, 0);
     +		if (ret)
     +			goto done;
    @@ refs/reftable-backend.c: static int reftable_be_for_each_reflog_ent_reverse(stru
      		return refs->err;
      
     -	ret = reftable_stack_init_log_iterator(stack, &it);
    ++	/*
    ++	 * TODO: we should adapt this callsite to reload the stack. There is no
    ++	 * obvious reason why we shouldn't.
    ++	 */
     +	ret = backend_for(&be, refs, refname, &refname, 0);
     +	if (ret)
     +		goto done;
    @@ refs/reftable-backend.c: static int reftable_be_for_each_reflog_ent(struct ref_s
      		return refs->err;
      
     -	ret = reftable_stack_init_log_iterator(stack, &it);
    ++	/*
    ++	 * TODO: we should adapt this callsite to reload the stack. There is no
    ++	 * obvious reason why we shouldn't.
    ++	 */
     +	ret = backend_for(&be, refs, refname, &refname, 0);
     +	if (ret)
     +		goto done;
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct ref_store *
      	arg.records = rewritten;
      	arg.len = logs_nr;
     -	arg.stack = stack,
    -+	arg.stack = be->stack,
    - 	arg.refname = refname,
    +-	arg.refname = refname,
    ++	arg.stack = be->stack;
    ++	arg.refname = refname;
      
      	ret = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
    + 	if (ret < 0)
 -:  ---------- >  3:  76f7ff40d2 reftable/stack: add accessor for the hash ID
 3:  c33093e73a !  4:  19da5f587c refs/reftable: read references via `struct reftable_backend`
    @@ refs/reftable-backend.c: static int reftable_be_copy_ref(struct ref_store *ref_s
      
      done:
      	assert(ret != REFTABLE_API_ERROR);
    -
    - ## reftable/reftable-stack.h ##
    -@@ reftable/reftable-stack.h: struct reftable_compaction_stats {
    - struct reftable_compaction_stats *
    - reftable_stack_compaction_stats(struct reftable_stack *st);
    - 
    -+/* Return the hash of the stack. */
    -+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st);
    -+
    - #endif
    -
    - ## reftable/stack.c ##
    -@@ reftable/stack.c: int reftable_stack_clean(struct reftable_stack *st)
    - 	reftable_addition_destroy(add);
    - 	return err;
    - }
    -+
    -+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st)
    -+{
    -+	return reftable_merged_table_hash_id(st->merged);
    -+}
 4:  8489e32d87 =  5:  ff4f02dda7 refs/reftable: refactor reading symbolic refs to use reftable backend
 5:  b1afd63785 =  6:  ed8963a520 refs/reftable: refactor reflog expiry to use reftable backend
 6:  1e754ccde8 =  7:  5b91ca48e3 reftable/stack: add mechanism to notify callers on reload
 7:  6755cf9ec9 =  8:  613f794fe6 reftable/merged: drain priority queue on reseek
 8:  e3b29b2035 =  9:  a44911e4a4 refs/reftable: reuse iterators when reading refs

---
base-commit: 455ddbf8c6a694968c1089fb6c7ffb1d31d97e9d
change-id: 20241125-pks-reftable-backend-reuse-iter-3a2e92428789

