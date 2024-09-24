Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA544C68
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155993; cv=none; b=a9kW3w8UHJ0PHJFOm5Bk+LxojNeSDjQfmCBzISFUmK3MmGCpigrjRn3W3lvvbXET67OtiQ9Endq89HQndDK9smkpN51mDSFkCdBxKrlA7cpt71t8f3Bwqh6mZStsAG2mGOkGcumQvE5iRH9/XdO+U5t6RnTcFlYD4TzP1cJzyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155993; c=relaxed/simple;
	bh=W1Lo7MaVPazKghuou8iJkwWKPsVnPlV2WWBwpHSASXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIzNeMBlFoGUlQahxApW3TqfLhZsBjcZNaQyz2EtuB1FEtwDUJYNBJVJi8HzByGiB6i8zs6CpYXIGVK1HVSMPMtBI/41jENP22iL/Zbg+FVvaG5ptvZuMLIKyWahn8tcb6F/1JQ+w/IZPMb5+0m2KJKUCzySuemLQ8P1W8hcXPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWnpZhca; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/KE534A; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWnpZhca";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/KE534A"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B3C213802F2;
	Tue, 24 Sep 2024 01:33:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Sep 2024 01:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727155990; x=1727242390; bh=ok6m0JBIS6
	XCs7P8j6gwzg3Gz3Q0Mq6D9+b4UpU6c1c=; b=JWnpZhcaDcIFgrfk63PxP1OiE6
	hsEtkRpvGlamzlI5yLMkHjAgUNXWO5AbVT6PQNS2MfeOTqbmBOBkxmcp1wMNGVQH
	OD4DNbZ/JFrQCzw8e0MLDoMqjngVEEXVGV4YCq8qnI15JflXCnyT11nBlHPG4/iQ
	90k2c0uJDU03Qfxe3cGroOrhbCoVoEB+BVYyN6LCk9BHC/a3CHBz8X1vFA4CtF46
	5Eq9C5m6pY0gq6/E1kwEgKZRuvD5kboAsz+PrQjWetGQfia65uAuJiRSvfqlenFp
	FW92vl2NHW4V2ERO4Oug25HD/Bxs94ZrPL42Egn6wAgQY9wyn18ULB5IgaPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727155990; x=1727242390; bh=ok6m0JBIS6XCs7P8j6gwzg3Gz3Q0
	Mq6D9+b4UpU6c1c=; b=J/KE534A/gW9nSswAtvaxlIurgy6HlPRqQ5iy+1OP8TI
	EqxS76MUJ8rE7W51oA2SsQOl3UPEl4j4/KccqM1cXTrfs0tGi9XG+E7ouB1nicTP
	gwoPE4YISvUXrFCrmEwbD/fQqWXNyY395wI/S8Q6LL0BeJq6dn8YVoAMWuFjsAkL
	+mh9ghkb3DGbS60jKsnFXpQgn5MgCp7w3iOaH3oZxUe6Ge+/2HNAz9G9EPZ8140w
	O3XpU0FiCaJ9ACBmGl2eprpuJeeVDDuQ5ZF20aK6Tisgu/IJPyjNB8eF5TPnzXWy
	VoQOeI4MR/flbIlqqE8vE9kLfTGVN5AE0FAxWYfoow==
X-ME-Sender: <xms:Fk_yZoF2NjpwI3gXY_soBEZXN1OAi8RajMYQroPke1zxZsGiYiO82A>
    <xme:Fk_yZhV3ihz6Unfji-mch-T8xvEWEyQzyWCWrSyiOVhjgljhj9lwFI4CkRVeyrPvg
    zl2LWLPd6tInrbdgg>
X-ME-Received: <xmr:Fk_yZiLqrYL-nod9ewqb5FpGxEE4tE2Qkg-KNWnvjDle13FpDbp-xJtWObZjERsKRoHpCjdKnM_LMIJkCqrLF1Hi280uXtNnW980JnZF0l-Scw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhu
    rdhioh
X-ME-Proxy: <xmx:Fk_yZqGoonzihGGDbe4B63KHIQG7L3WHYl4-vvSoWETB1ll7foob5Q>
    <xmx:Fk_yZuU2coN1Xl96WDv1tkl9QwfQFBCZW43xTUqHX5gALiY6Qos9Ug>
    <xmx:Fk_yZtO59Ubftox6K4gZwVwtdbcq7o8Nk22iijhUQFTgW-wobQDonw>
    <xmx:Fk_yZl1CtbbSB5IvYKfnwX2y7cs8fPIBUYdRck6ZHdxACweOuZ-znA>
    <xmx:Fk_yZgJ-ovIuYDHC2c_LVav81M59bwczlqPobji6eMI0nZ7z-QQx9_3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:33:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2161ab3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:32:35 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:33:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/3] reftable/stack: allow locking of outdated stacks
Message-ID: <81a836062e95135b4700ed2de93b6f047592624e.1727155858.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727155858.git.ps@pks.im>

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
index ca281e39a29..6ca00627dd7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -770,7 +770,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		if (ret)
 			return ret;
 
-		ret = reftable_stack_new_addition(&addition, stack);
+		ret = reftable_stack_new_addition(&addition, stack, 0);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
 				strbuf_addstr(err, "cannot lock references");
@@ -2207,7 +2207,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_new_addition(&add, stack);
+	ret = reftable_stack_new_addition(&add, stack, 0);
 	if (ret < 0)
 		goto done;
 
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index f4f8cabc7fb..6370fe45ddf 100644
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
+				unsigned int flags);
 
 /* Adds a reftable to transaction. */
 int reftable_addition_add(struct reftable_addition *add,
diff --git a/reftable/stack.c b/reftable/stack.c
index 5ccad2cff31..84cf37a2ad0 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -596,7 +596,8 @@ struct reftable_addition {
 #define REFTABLE_ADDITION_INIT {0}
 
 static int reftable_stack_init_addition(struct reftable_addition *add,
-					struct reftable_stack *st)
+					struct reftable_stack *st,
+					unsigned int flags)
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
+				unsigned int flags)
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

