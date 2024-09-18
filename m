Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1717C205
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653576; cv=none; b=lYTLkzn85wSxIgXAntzUrEqIi4+ItGfY3fWkmYsnieb1fsqahz36ykY3cnl1P0t2ZgWh/7R+XO76fF7bmzE/lXujL63CFDZEytWqQoWKc/V1TV4/gPDpKbpRhC2jZ6wBzLnYqFkU2DKe6MJATmKM+Ke37AOVqvgTyY/GaI/na5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653576; c=relaxed/simple;
	bh=bdq4Pypf62twOIws19Ib+8xsIc9VAExgoO9K/eeuRyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPklEQHu31hJH4RwkIprqdSyZZ7wz/JWx1PFFSZFtmL/15IyoFR34Hz6zlOspr8dqTYRkzO6ik9tAkiLCCCeRYKFdEKMJ2phMi3GrPw7FkqpouzFUtmterPSBfgycFXxB/U9HzErqsv/Ihho8K+hBSGqt/JpqXvhB8Un4Gf9peU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hCOTgjbw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9PPNK/N; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hCOTgjbw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9PPNK/N"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 918501380347;
	Wed, 18 Sep 2024 05:59:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Sep 2024 05:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726653573; x=1726739973; bh=l2EPn33XBZ
	Sp4RPAVg59w1OT5cgyy/H09iyJHfZ89KY=; b=hCOTgjbwtQthY1OjRDRRkptxgL
	UK1PT4vxX62N0le3Pk5ITlSabVauFCZeg5ekQSNNEjwRcFWfCnTt+nCq+LXbsFY4
	Oiljo/1UG3UbwaCUmVzqhqMCuYvcNdMrBIdZWF1ws1uUDYVjloqQt/Jri3GfWHp3
	L8EI4byvf06fvMjCAiReewOiJh0loW+2jg6PuL1yZlCi0F7Sb6Sxk74bsodWutPn
	7urRAbgjhMrg0J8sCWNkw2M50a70RaXDLUBUV6AWNqY50iVITEXobbxRrMjlWgdI
	cPzpuGRx1XJP9eceP2ICXrsy5M7ptM9Wh/uG0OEXwbJ2XxCdPbDwjnGlk+kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726653573; x=1726739973; bh=l2EPn33XBZSp4RPAVg59w1OT5cgy
	y/H09iyJHfZ89KY=; b=l9PPNK/NLBR1KvJnNSjtqbwTtArNW3ADfbYuWwNgvEqg
	uQi/DReCNIbDAsrtoIVy0F9Lm14D9T+3muCWvb3N8SAKcJXdcbK6Jv1wEQ0g78uS
	9qB3Yb6oEACOv5CZr3gFZSKpXI0X3GUd9JyZSHIqNTv5n23ViGxgRfhIke57dxBk
	rGxaogxpHEEjakLKY+TyPmpW0e3+BnlzLY2mozU1vojjDDALOmqend7w/RZ5BAaO
	RKwFNLdXIiTIIezVcoFXYyc4E/qATAtMf+FSfoj+7bxhW9KFTnnjydDy+Vp+vtCq
	Q/sGewe+YhCkAOvw/iTKozJ9bwDIUmEpD/xkgNjyhQ==
X-ME-Sender: <xms:haTqZiSQD0GU4eJe36nGcLNV6UDpoAMa9594LozvhJws8t5YQKpeoA>
    <xme:haTqZnzTRhASj_7l1ol0atM3gcBQv4c76V-gBbnukMdJjpPyYmgPiUHcw9OEsVzAT
    LTiRFGf38m4WNciuw>
X-ME-Received: <xmr:haTqZv3L2QVQiYQbbUEkfh8lfKSq7--Yo59txe1ASR_TnXK1hJ6sa58XEhDCgBjaIeQC6xX6-FHMpybs_uuMuf_KDoBM5AKAAuFXxtkLJ3EMuOpW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:haTqZuCUIOONfUxxD_3OD2Nc0nPMRT4Caqmqwn2x4VYWHyDihhdB4A>
    <xmx:haTqZrhnZLWyoqazI4gX7WZLHaEQCJm-13mSGC9KPg9wQOelkjtodA>
    <xmx:haTqZqoVdh-aNJom_ABhnQIBAdCSnc-I-w64atnbSGMFk8DxPLRweQ>
    <xmx:haTqZuiGE1RydkT7Chub-J4G2nVNWPbI4ob4tPTB6b_FPC4qPXs27g>
    <xmx:haTqZrcKyOONZ0aDA7nhdZWlHKVk-O6U3ETZAr4jL5mhHbZij-p0t2LF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:59:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 025cd804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 09:59:11 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:59:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: [PATCH v3 2/3] reftable/stack: allow locking of outdated stacks
Message-ID: <6130565498e51ce3228d6fe5bc5f0b83c0db9182.1726653185.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726653185.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726653185.git.ps@pks.im>

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

