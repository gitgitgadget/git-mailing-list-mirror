Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36AF14A4CC
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633951; cv=none; b=lEKgZ3hXJDVf5XlU+uACbb0VQxch5H1k88eCGizn5h9llnuGnim9X4x9SiUapCBZcq3egwUfH/bhJrI+eTOQhWxqh4gNZCIwWPc6uQahj/LF9dSTLS4LFKDdfHOYcYEfI11d16BwoJOuPW4Bg78berB2JaTlQE+nW2W2jcE8UVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633951; c=relaxed/simple;
	bh=Toe0Nncee/deQWgdEDeUbcuu4qjG4oAdhay48kS4OFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbG4dIPOmu8SoTrUn5oO5ExFVP0XEzdwdMLoPRC6fjLTIl/xBqVcppe4wqeCAhcUSikZvcKRQNl4zVxnT3f8WWGzDNlEykrrk5tmd+tCj9WDkcs9vo+2HYQcj9Qi5a6pL/UYZgEHmdM2lFoo1+SZHknvTY4RwvdYKUWeVoxTS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UXxnBp9R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQprggxX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UXxnBp9R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQprggxX"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D9408138026E;
	Wed, 18 Sep 2024 00:32:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Sep 2024 00:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726633948; x=1726720348; bh=Cyqe4MnGVt
	UyenYM4cS2UED3kFM+V7hy4ans973Eps4=; b=UXxnBp9R5zY8lpau/GpmDd2t94
	4JTBE/Yad9mK+IA8Fj00Jzj6JeMwBmWfV7zIxZXeiH//3PTA6OU/Qcp1FI4fljap
	FYECSj81tYjtOm+W5bPnIl01JgDLj606XV8B8S4upWQ83Qet4NKABVA/IcSVBhq6
	X20dyAi6UqeSzo1ApmYxhiofpmgkxJO0YPpbWjZfzv9xD2eVdn5Hp45LBpHmIqp3
	veyX/V6PA/Jg4UokzmpOY15tDJu0GAnUJsv1qad0ZPdBhyl7Ew5VTkmI27FLYpbg
	78I+Tqymz5Hig+b23+HzSBhWjOjDxK419SQc7TUZ47K7QlwUdtxO8Kssu17g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726633948; x=1726720348; bh=Cyqe4MnGVtUyenYM4cS2UED3kFM+
	V7hy4ans973Eps4=; b=WQprggxXcANboS8+uyxYtFD6mVTabXYLkiq8+STG7eTx
	z5SmypfU0hAQc/d5NuDE4MkVqB34J1gbfHoGWQFesbqdW2XvcF3ccAO1adWXPNkw
	DxSy9uwqsc/rFFMnlZ8SSGAUb0+GaZzW/S8RxzcBmvo01L8+tl6xUh78zK3in6vk
	Dz6idEkSOzaOmm5G9mBS63GdIiRIom3hlRtzmtAtNd4pe62pMSoi/YUs8R3ZraL+
	z8fXQi6/6EhcT384o/yWb9CUk2STiILV6tYH+5serfcnxeWQNjbD76477j8zvSYM
	U1b26F0uxDH8kLScFZ/G6QyqqKXiDMWT1oo5rDSKJg==
X-ME-Sender: <xms:3FfqZmMFDIn7vtL21KjUIz9iYRZp0n9luT1WYFhLww1XeKR2IGzXsA>
    <xme:3FfqZk9ZL0Bp9L4EABIA47QuRBO6BKThauiy7Zlwm6tg9R64TETlqbD9Zpx1wGekK
    KgYcvVrl7OPo0DPNQ>
X-ME-Received: <xmr:3FfqZtRYmqz6MsR8O1P_vRPa-osxY3pgIkq_Cs6xt6tHq7cZxV00roD9mPwsXp-De7-6coMRxzjYQY5z1the64OFGJY5vQdrDT5G2LrQPUH5OG-->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3FfqZmu22SkFryrJ5AjyiMd81Tdy9qFAlnppyZYxBszPXnxevw4GoA>
    <xmx:3FfqZueRfpwf_r95p0oXc2dxei0_5tkX6OcHLsm8dzd9GmUHHfKMjg>
    <xmx:3FfqZq1F1KxclZ_JkTCCOLwrKj0h4CDtjtL9KbZ8M1rtFi7xqti3pQ>
    <xmx:3FfqZi-qFAEhl0eBTyDABC6D784eumEdlOklROhX1F_2AsS5IfuEmA>
    <xmx:3FfqZu7TTInLj5o8BK0Y4OTwdchlJagcTdG5PGppiIDbUbfbHdTPRMbU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:32:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f17de6a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:32:07 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:32:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] reftable/stack: allow locking of outdated stacks
Message-ID: <f4be0966e17600602b1057a6ae219711994df128.1726633812.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726633812.git.ps@pks.im>

In `reftable_stack_new_addition()` we first lock the stack and then
check whether it is still up-to-date. If it is not we return an error to
the caller indicating that the stack is outdated.

This is overly restrictive in our ref transaction interface though: we
lock the stack right before we start to verify the transaction, so we do
not really care whether it is outdated or not. What we really want is
that the stack is up-to-date after it has been locked so that we can
verify queued updates against its current state while we know that it is
locked for concurrent modification.

Introduce a new flag `REFTABLE_STACK_NEW_ADDITION_RELOAD` that alters
the behaviour of `reftable_stack_init_addition()` in this case: when we
notice that it is out-of-date we reload it instead of returning an error
to the caller.

This logic will be wired up in the reftable backend in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c         |  4 +-
 reftable/reftable-stack.h       | 13 ++++++-
 reftable/stack.c                | 20 ++++++----
 t/unit-tests/t-reftable-stack.c | 67 ++++++++++++++++++++++++++++++++-
 4 files changed, 91 insertions(+), 13 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e90ddfb98dd..c500fb820a7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -766,7 +766,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		if (ret)
 			return ret;
 
-		ret = reftable_stack_new_addition(&addition, stack);
+		ret = reftable_stack_new_addition(&addition, stack, 0);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
 				strbuf_addstr(err, "cannot lock references");
@@ -2203,7 +2203,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_new_addition(&add, stack);
+	ret = reftable_stack_new_addition(&add, stack, 0);
 	if (ret < 0)
 		goto done;
 
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index f4f8cabc7fb..67316b215ed 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -37,12 +37,21 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
 /* holds a transaction to add tables at the top of a stack. */
 struct reftable_addition;
 
+enum {
+	/*
+	 * Reload the stack when the stack is out-of-date after locking it.
+	 */
+	REFTABLE_STACK_NEW_ADDITION_RELOAD = (1 << 0),
+};
+
 /*
  * returns a new transaction to add reftables to the given stack. As a side
- * effect, the ref database is locked.
+ * effect, the ref database is locked. Accepts REFTABLE_STACK_NEW_ADDITION_*
+ * flags.
  */
 int reftable_stack_new_addition(struct reftable_addition **dest,
-				struct reftable_stack *st);
+				struct reftable_stack *st,
+				int flags);
 
 /* Adds a reftable to transaction. */
 int reftable_addition_add(struct reftable_addition *add,
diff --git a/reftable/stack.c b/reftable/stack.c
index 5ccad2cff31..f9c95d5fa62 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -596,7 +596,8 @@ struct reftable_addition {
 #define REFTABLE_ADDITION_INIT {0}
 
 static int reftable_stack_init_addition(struct reftable_addition *add,
-					struct reftable_stack *st)
+					struct reftable_stack *st,
+					int flags)
 {
 	struct strbuf lock_file_name = STRBUF_INIT;
 	int err;
@@ -626,6 +627,11 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	err = stack_uptodate(st);
 	if (err < 0)
 		goto done;
+	if (err > 0 && flags & REFTABLE_STACK_NEW_ADDITION_RELOAD) {
+		err = reftable_stack_reload_maybe_reuse(add->stack, 1);
+		if (err)
+			goto done;
+	}
 	if (err > 0) {
 		err = REFTABLE_OUTDATED_ERROR;
 		goto done;
@@ -633,9 +639,8 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 
 	add->next_update_index = reftable_stack_next_update_index(st);
 done:
-	if (err) {
+	if (err)
 		reftable_addition_close(add);
-	}
 	strbuf_release(&lock_file_name);
 	return err;
 }
@@ -739,13 +744,14 @@ int reftable_addition_commit(struct reftable_addition *add)
 }
 
 int reftable_stack_new_addition(struct reftable_addition **dest,
-				struct reftable_stack *st)
+				struct reftable_stack *st,
+				int flags)
 {
 	int err = 0;
 	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
 	**dest = empty;
-	err = reftable_stack_init_addition(*dest, st);
+	err = reftable_stack_init_addition(*dest, st, flags);
 	if (err) {
 		reftable_free(*dest);
 		*dest = NULL;
@@ -759,7 +765,7 @@ static int stack_try_add(struct reftable_stack *st,
 			 void *arg)
 {
 	struct reftable_addition add = REFTABLE_ADDITION_INIT;
-	int err = reftable_stack_init_addition(&add, st);
+	int err = reftable_stack_init_addition(&add, st, 0);
 	if (err < 0)
 		goto done;
 
@@ -1608,7 +1614,7 @@ static int reftable_stack_clean_locked(struct reftable_stack *st)
 int reftable_stack_clean(struct reftable_stack *st)
 {
 	struct reftable_addition *add = NULL;
-	int err = reftable_stack_new_addition(&add, st);
+	int err = reftable_stack_new_addition(&add, st, 0);
 	if (err < 0) {
 		goto done;
 	}
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index d62a9c1bed5..a37cc698d87 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -271,7 +271,7 @@ static void t_reftable_stack_transaction_api(void)
 
 	reftable_addition_destroy(add);
 
-	err = reftable_stack_new_addition(&add, st);
+	err = reftable_stack_new_addition(&add, st, 0);
 	check(!err);
 
 	err = reftable_addition_add(add, write_test_ref, &ref);
@@ -292,6 +292,68 @@ static void t_reftable_stack_transaction_api(void)
 	clear_dir(dir);
 }
 
+static void t_reftable_stack_transaction_with_reload(void)
+{
+	char *dir = get_tmp_dir(__LINE__);
+	struct reftable_stack *st1 = NULL, *st2 = NULL;
+	int err;
+	struct reftable_addition *add = NULL;
+	struct reftable_ref_record refs[2] = {
+		{
+			.refname = (char *) "refs/heads/a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { '1' },
+		},
+		{
+			.refname = (char *) "refs/heads/b",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { '1' },
+		},
+	};
+	struct reftable_ref_record ref = { 0 };
+
+	err = reftable_new_stack(&st1, dir, NULL);
+	check(!err);
+	err = reftable_new_stack(&st2, dir, NULL);
+	check(!err);
+
+	err = reftable_stack_new_addition(&add, st1, 0);
+	check(!err);
+	err = reftable_addition_add(add, write_test_ref, &refs[0]);
+	check(!err);
+	err = reftable_addition_commit(add);
+	check(!err);
+	reftable_addition_destroy(add);
+
+	/*
+	 * The second stack is now outdated, which we should notice. We do not
+	 * create the addition and lock the stack by default, but allow the
+	 * reload to happen when REFTABLE_STACK_NEW_ADDITION_RELOAD is set.
+	 */
+	err = reftable_stack_new_addition(&add, st2, 0);
+	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
+	err = reftable_stack_new_addition(&add, st2, REFTABLE_STACK_NEW_ADDITION_RELOAD);
+	check(!err);
+	err = reftable_addition_add(add, write_test_ref, &refs[1]);
+	check(!err);
+	err = reftable_addition_commit(add);
+	check(!err);
+	reftable_addition_destroy(add);
+
+	for (size_t i = 0; i < ARRAY_SIZE(refs); i++) {
+		err = reftable_stack_read_ref(st2, refs[i].refname, &ref);
+		check(!err);
+		check(reftable_ref_record_equal(&refs[i], &ref, GIT_SHA1_RAWSZ));
+	}
+
+	reftable_ref_record_release(&ref);
+	reftable_stack_destroy(st1);
+	reftable_stack_destroy(st2);
+	clear_dir(dir);
+}
+
 static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 {
 	char *dir = get_tmp_dir(__LINE__);
@@ -322,7 +384,7 @@ static void t_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 */
 		st->opts.disable_auto_compact = i != n;
 
-		err = reftable_stack_new_addition(&add, st);
+		err = reftable_stack_new_addition(&add, st, 0);
 		check(!err);
 
 		err = reftable_addition_add(add, write_test_ref, &ref);
@@ -1314,6 +1376,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_reftable_stack_reload_with_missing_table(), "stack iteration with garbage tables");
 	TEST(t_reftable_stack_tombstone(), "'tombstone' refs in stack");
 	TEST(t_reftable_stack_transaction_api(), "update transaction to stack");
+	TEST(t_reftable_stack_transaction_with_reload(), "transaction with reload");
 	TEST(t_reftable_stack_transaction_api_performs_auto_compaction(), "update transaction triggers auto-compaction");
 	TEST(t_reftable_stack_update_index_check(), "update transactions with equal update indices");
 	TEST(t_reftable_stack_uptodate(), "stack must be reloaded before ref update");
-- 
2.46.0.551.gc5ee8f2d1c.dirty

