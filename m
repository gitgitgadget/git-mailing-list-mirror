Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCD17ADE3
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580614; cv=none; b=DF1/uIPGev8z9hbb9Es0ukT7rwHJL5ToLwkDiRGiogJ222e3QKYmqVC8NTtheLJUgJFMcrvk3jIaALVnmydCh9Eyy+1XPC1T+mRj50wPI2UIScOK3cQTj0bn3ibHM8ZZQrfb1DOB++xz+gleca2XCTNlC1FOSxRASc1WT7SiEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580614; c=relaxed/simple;
	bh=Toe0Nncee/deQWgdEDeUbcuu4qjG4oAdhay48kS4OFY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIiGA1CHoq5onYgXmC7zlKfjSNhJllXJ7466wu5hg9dYsBGR+7lFy8a8LDj4bm8S2kyuPGp78SVVuWzFHwEi0n7/x6/zsiZbQjRlduiD7tOPrq+hdL861XGlqO8JTwa82H6zsUkw3C+oIrsAtwmPbTi3QH3fFCzedsxFdEnbc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NR6ls8ie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bG94JPWH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NR6ls8ie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bG94JPWH"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C20EC138022D
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Sep 2024 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726580610; x=1726667010; bh=Cyqe4MnGVt
	UyenYM4cS2UED3kFM+V7hy4ans973Eps4=; b=NR6ls8ie9aHFthAWa3O98E10eN
	/x0+UdT7zxhChH5gY4WG56/qLq8H9X4MIFmEVRuF7vJQmV4UYOS23LoCVbegWd4H
	Se5JAqrRbS72FwYy5FmboPPNM2zn6x4C4Jho3sAv5VBFil+4Cz/fQsIksheyxpwD
	DwZcHp6dOzi1GzPVpre8fiIdSG3KTgZh34Yehn6IJ16A7diH017koHTPRtCIOwN0
	Yr7unWaqx8OKkZBMM241B3GCqscYbswj+24SIyFGHki2Zg4aRSsS8gx52C3CROVm
	sjk63gYGqVkOGHKUbiVfgagPUFTIs1/L+uGc6N8aVc4wKn+v0efFjp53JMdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726580610; x=1726667010; bh=Cyqe4MnGVtUyenYM4cS2UED3kFM+
	V7hy4ans973Eps4=; b=bG94JPWHz5ZjSf4v4Awj4NwcAm3T2YhJIkVQ/GJ+3L/K
	773kxjWsdlVb0D5VXYesjtRjBVgbqTtzVJQhLc/xbu3uyMJcVmWxrWwc5zy2Owfe
	C0Z4i0YUbaU4qAedaoJZ0iJIzAvCN3Uhd6acR1TCLEiKe5kNXaQyQJIzyTEMuk+D
	6eo7qp7bTJaGBT+Unx72P77xwUIlgxhwLBBOgqWUqWhS3oI7+mtxHiepzgwy1HXa
	IL3IqGKGdP6z5B0cN4zIrCXsTSRko9bd6DntXPpTayzvEGAzVRPZaWSKcDCddTLN
	bBNnC6kWax8teGs/qBbFa9NSkz5ViiuaC+GQzE9s1A==
X-ME-Sender: <xms:gofpZlcnhK0eJAXlfu-Jwq2vfG00OVRYRYsm2G1J06e7ITlEgD-6SQ>
    <xme:gofpZjMGx5oT77afWvojINPu-k7roI3iGWcnG5XcWORmJv1lDx7kyXApGDtKLPAxd
    hVhyuB3pQ2ERMpJsA>
X-ME-Received: <xmr:gofpZujNs55rVpTGs6vgMoxN_UguOZW-y3Mk9z56zFBeUN-ntxYf8iuSWH1KgFIOfDxOMAJwaM6Dj_fAfKPodGXEuAKS8hgA1_modpgJXAyb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gofpZu-HUGT238rEeJ3y86dTXRdwgeipLyFt9lwRT_0e58ZO8ihvxg>
    <xmx:gofpZhtfAt9tkaj6vCOvaDhAP3bT994RM_IW83a-fKRTuFcxIr32RQ>
    <xmx:gofpZtFcP619xRBeMLhMhwzx0cSC6fjK70m-WmyCTOzcyXwDjXvM2w>
    <xmx:gofpZoPcp_ITPDceFfY7_DUSLIjKq1DTSxdHeqA9JQs69h5Pnpo3Kg>
    <xmx:gofpZiUCsSSlTDGxwxnT03eoe7yNfLE6NiyoBRmwD3gEJM1q-_evm4qs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a28cff7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 13:43:04 +0000 (UTC)
Date: Tue, 17 Sep 2024 15:43:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/3] reftable/stack: allow locking of outdated stacks
Message-ID: <cd65e6d57b06fb7f74baf3882da9353fdb8d86bc.1726578382.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726578382.git.ps@pks.im>

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

