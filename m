Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B726E704
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059694; cv=none; b=nlg+uvCA/QpkCpVYUGAp1cvIr42dbnGYJc1JlQovml/qQ+4w596nFi3I2ZlL6PjbNNOdrXDJPLiFDSw0vFCndq38ouOON40uvNW4b2WxkI+cLOFXbnoPDR2mBUq33cE0c9igvZDOmJWGWrvTDMWf71MNUCUvzrCtFkwW1OGcwr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059694; c=relaxed/simple;
	bh=gGvfvDt7aOoNIFwmYwMHiovkK0M4SF3o1rOzLMeXDoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAA3QHHnX9BVUpDsLlYkot/fxe5PoEyl1aonHeWm6gC+4KaerBKOcnrQTC4t24NxrcXBUVzEkhpVxzdSHMHIK4TnPqHcF/bhpJBzP7TTUW7c9CEtLukKkSClz5pLFIDPNiCXxwCp9+wSgGE0Qd34JCryDMF3piJKqR1QPr4sjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lhUna33v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NF/pRoI+; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lhUna33v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NF/pRoI+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BE211D008A3
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:48:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 01 Aug 2025 10:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754059691;
	 x=1754146091; bh=5NMdmzUWw66UuI1/5opTokf/dL1nMJDinNF+zZ+ZnGk=; b=
	lhUna33volSVoLd91pOyhtA3eFK+8Aoxd5fo+nPzuLRscwHMkVpQ+I9Ay6fotfb/
	qE9SQUBAlYvwQMI9pss3UnAeUEO03EjGfP+NQeX79wdJDpI2krqrQiDY6UJlFSbx
	fn45Lxv/c3nI5BhJekYEfNBQeMWvvEMeUVGlffbMWTEuMKKsTGZFXPYYyQ4X11H4
	JzTpT645ypHy2dB+M5FSHmwB77Omez0A0LzxX/N2RqGr2afzorly+Eu2+z+qn5W1
	CIKAf3DcF/eGJKfpt5WEYWqrmTejcCYEbp8k/98WTiydpHbLBnCz2mdoaIM2A9fi
	K7Rfx78OAN8qZxhxChqhvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059691; x=
	1754146091; bh=5NMdmzUWw66UuI1/5opTokf/dL1nMJDinNF+zZ+ZnGk=; b=N
	F/pRoI+S0QPBSFtYJCiOUdpltXrpvoZtCRKIceiHSr9dIr1c6ZUFoW6J6kdyuPCr
	vsNwpTesCW0lVGUeO1ADXpORRHvXJuPqy4uHa7d6wtmPyh8kP8rCy+1Lj7Wt0czK
	sojA0KLwj2O8ymm+hXu95sTShMNDBM2F72fwas0MOpOuWmIPtACUGiak9zob8ROg
	aZbcoqBJ9cfJVajtbjplo7UTC+BQ4aSeYhOsfYxEjlszGP4ogENYuyem+w4xJ8/i
	KklBJ0BKkyonefUx7P/B1emJQuoEa2cuC/eF/+0DYUim/9XlR5Zeb1maa7lTIiF3
	j44JFbT83RVGtbih67h1Q==
X-ME-Sender: <xms:q9OMaMd4qbcai5jVXg-wNLeJGjWqZioJuVjereywywS_jP-aLHtAfQ>
    <xme:q9OMaAOiQducp87NtVbQcTeE-YHOmqGLRuMngvwv93J3cQhnVJ2ShLKPwG9Ch6FfK
    cjd1eEx9rZoiCDW4Q>
X-ME-Received: <xmr:q9OMaG4uuq9jqFjVIabysT4WETEK4tFF0UukPanRBJtI25C5jihIO9NsLdEtDQsZ_7JBQu_cxvxXHlHU_LK74ZX7JaWZHFH6PsLTWBEf9fim>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:q9OMaEKOieqRXkcW_PdpuOgMxxHOueZGd_6_I3E4lRwJwmakvlRDIA>
    <xmx:q9OMaAfL45TxJd414_NVv-EwGhPV5n1ddfco6J9Fd6R13d6iyhv6VQ>
    <xmx:q9OMaHfF2FjzN_ZPQTb9ac8fYCTUW6BGWbpbmGi-5XIez305qtKkmA>
    <xmx:q9OMaDOd_KnCZYKxH3ak4dVRWvWxlqFOQgH11OR56sIhxhKLK0Dt5w>
    <xmx:q9OMaLHHHKg9LzjG1wN2zcYBBlz-GI0Z37BN4_jVaPbEo1hWcJCcg5Nq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 1 Aug 2025 10:48:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c846493 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 1 Aug 2025 14:48:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 01 Aug 2025 16:47:51 +0200
Subject: [PATCH 5/5] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pks-reftable-fixes-for-libgit2-v1-5-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `reftable_stack_add()` function is a simple wrapper to lock the
stack, add records to it via a callback and then commit the
result. One problem with it though is that it doesn't accept any flags
for creating the addition. This makes it impossible to automatically
reload the stack in case it was modified before we managed to lock the
stack.

Add a `flags` field to plug this gap and pass it through accordingly.
For now this new flag won't be used by us, but it will be used by
libgit2.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c         |  8 +++----
 reftable/reftable-stack.h       |  9 +++++---
 reftable/stack.c                |  8 +++----
 t/unit-tests/t-reftable-stack.c | 50 ++++++++++++++++++++---------------------
 4 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4c3817f4ec..3f0deab338 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1960,7 +1960,7 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -1989,7 +1989,7 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -2360,7 +2360,7 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 		goto done;
 	arg.stack = be->stack;
 
-	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg);
+	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg, 0);
 
 done:
 	return ret;
@@ -2431,7 +2431,7 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 		return ret;
 	arg.stack = be->stack;
 
-	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg);
+	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg, 0);
 
 	assert(ret != REFTABLE_API_ERROR);
 	return ret;
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 910ec6ef3a..d70fcb705d 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -68,12 +68,15 @@ int reftable_addition_commit(struct reftable_addition *add);
  * transaction. Releases the lock if held. */
 void reftable_addition_destroy(struct reftable_addition *add);
 
-/* add a new table to the stack. The write_table function must call
- * reftable_writer_set_limits, add refs and return an error value. */
+/*
+ * Add a new table to the stack. The write_table function must call
+ * reftable_writer_set_limits, add refs and return an error value.
+ * The flags are passed through to `reftable_stack_new_addition()`.
+ */
 int reftable_stack_add(struct reftable_stack *st,
 		       int (*write_table)(struct reftable_writer *wr,
 					  void *write_arg),
-		       void *write_arg);
+		       void *write_arg, unsigned flags);
 
 struct reftable_iterator;
 
diff --git a/reftable/stack.c b/reftable/stack.c
index d6e4ea93a3..f77d7f58e8 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -737,10 +737,10 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 static int stack_try_add(struct reftable_stack *st,
 			 int (*write_table)(struct reftable_writer *wr,
 					    void *arg),
-			 void *arg)
+			 void *arg, unsigned flags)
 {
 	struct reftable_addition add = REFTABLE_ADDITION_INIT;
-	int err = reftable_stack_init_addition(&add, st, 0);
+	int err = reftable_stack_init_addition(&add, st, flags);
 	if (err < 0)
 		goto done;
 
@@ -756,9 +756,9 @@ static int stack_try_add(struct reftable_stack *st,
 
 int reftable_stack_add(struct reftable_stack *st,
 		       int (*write)(struct reftable_writer *wr, void *arg),
-		       void *arg)
+		       void *arg, unsigned flags)
 {
-	int err = stack_try_add(st, write, arg);
+	int err = stack_try_add(st, write, arg, flags);
 	if (err < 0) {
 		if (err == REFTABLE_OUTDATED_ERROR) {
 			/* Ignore error return, we want to propagate
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 2f49c97519..ce10247903 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -128,7 +128,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		ref.refname = buf;
 		t_reftable_set_hash(ref.value.val1, i, REFTABLE_HASH_SHA1);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, &write_test_ref, &ref, 0);
 		check(!err);
 	}
 
@@ -170,7 +170,7 @@ static void t_reftable_stack_add_one(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref);
+	err = reftable_stack_add(st, write_test_ref, &ref, 0);
 	check(!err);
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
@@ -235,16 +235,16 @@ static void t_reftable_stack_uptodate(void)
 	err = reftable_new_stack(&st2, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st1, write_test_ref, &ref1);
+	err = reftable_stack_add(st1, write_test_ref, &ref1, 0);
 	check(!err);
 
-	err = reftable_stack_add(st2, write_test_ref, &ref2);
+	err = reftable_stack_add(st2, write_test_ref, &ref2, 0);
 	check_int(err, ==, REFTABLE_OUTDATED_ERROR);
 
 	err = reftable_stack_reload(st2);
 	check(!err);
 
-	err = reftable_stack_add(st2, write_test_ref, &ref2);
+	err = reftable_stack_add(st2, write_test_ref, &ref2, 0);
 	check(!err);
 	reftable_stack_destroy(st1);
 	reftable_stack_destroy(st2);
@@ -428,7 +428,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref);
+	err = reftable_stack_add(st, write_test_ref, &ref, 0);
 	check(!err);
 	check_int(st->merged->tables_len, ==, 1);
 	check_int(st->stats.attempts, ==, 0);
@@ -446,7 +446,7 @@ static void t_reftable_stack_auto_compaction_fails_gracefully(void)
 	write_file_buf(table_path.buf, "", 0);
 
 	ref.update_index = 2;
-	err = reftable_stack_add(st, write_test_ref, &ref);
+	err = reftable_stack_add(st, write_test_ref, &ref, 0);
 	check(!err);
 	check_int(st->merged->tables_len, ==, 2);
 	check_int(st->stats.attempts, ==, 1);
@@ -484,10 +484,10 @@ static void t_reftable_stack_update_index_check(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref1);
+	err = reftable_stack_add(st, write_test_ref, &ref1, 0);
 	check(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref2);
+	err = reftable_stack_add(st, write_test_ref, &ref2, 0);
 	check_int(err, ==, REFTABLE_API_ERROR);
 	reftable_stack_destroy(st);
 	clear_dir(dir);
@@ -503,7 +503,7 @@ static void t_reftable_stack_lock_failure(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 	for (i = -1; i != REFTABLE_EMPTY_TABLE_ERROR; i--) {
-		err = reftable_stack_add(st, write_error, &i);
+		err = reftable_stack_add(st, write_error, &i, 0);
 		check_int(err, ==, i);
 	}
 
@@ -546,7 +546,7 @@ static void t_reftable_stack_add(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i], 0);
 		check(!err);
 	}
 
@@ -555,7 +555,7 @@ static void t_reftable_stack_add(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg, 0);
 		check(!err);
 	}
 
@@ -639,7 +639,7 @@ static void t_reftable_stack_iterator(void)
 	}
 
 	for (i = 0; i < N; i++) {
-		err = reftable_stack_add(st, write_test_ref, &refs[i]);
+		err = reftable_stack_add(st, write_test_ref, &refs[i], 0);
 		check(!err);
 	}
 
@@ -649,7 +649,7 @@ static void t_reftable_stack_iterator(void)
 			.update_index = reftable_stack_next_update_index(st),
 		};
 
-		err = reftable_stack_add(st, write_test_log, &arg);
+		err = reftable_stack_add(st, write_test_log, &arg, 0);
 		check(!err);
 	}
 
@@ -725,11 +725,11 @@ static void t_reftable_stack_log_normalize(void)
 	check(!err);
 
 	input.value.update.message = (char *) "one\ntwo";
-	err = reftable_stack_add(st, write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg, 0);
 	check_int(err, ==, REFTABLE_API_ERROR);
 
 	input.value.update.message = (char *) "one";
-	err = reftable_stack_add(st, write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg, 0);
 	check(!err);
 
 	err = reftable_stack_read_log(st, input.refname, &dest);
@@ -738,7 +738,7 @@ static void t_reftable_stack_log_normalize(void)
 
 	input.value.update.message = (char *) "two\n";
 	arg.update_index = 2;
-	err = reftable_stack_add(st, write_test_log, &arg);
+	err = reftable_stack_add(st, write_test_log, &arg, 0);
 	check(!err);
 	err = reftable_stack_read_log(st, input.refname, &dest);
 	check(!err);
@@ -792,7 +792,7 @@ static void t_reftable_stack_tombstone(void)
 		}
 	}
 	for (i = 0; i < N; i++) {
-		int err = reftable_stack_add(st, write_test_ref, &refs[i]);
+		int err = reftable_stack_add(st, write_test_ref, &refs[i], 0);
 		check(!err);
 	}
 
@@ -801,7 +801,7 @@ static void t_reftable_stack_tombstone(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg, 0);
 		check(!err);
 	}
 
@@ -855,7 +855,7 @@ static void t_reftable_stack_hash_id(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, write_test_ref, &ref);
+	err = reftable_stack_add(st, write_test_ref, &ref, 0);
 	check(!err);
 
 	/* can't read it with the wrong hash ID. */
@@ -927,7 +927,7 @@ static void t_reflog_expire(void)
 			.log = &logs[i],
 			.update_index = reftable_stack_next_update_index(st),
 		};
-		int err = reftable_stack_add(st, write_test_log, &arg);
+		int err = reftable_stack_add(st, write_test_log, &arg, 0);
 		check(!err);
 	}
 
@@ -978,7 +978,7 @@ static void t_empty_add(void)
 	err = reftable_new_stack(&st, dir, &opts);
 	check(!err);
 
-	err = reftable_stack_add(st, write_nothing, NULL);
+	err = reftable_stack_add(st, write_nothing, NULL, 0);
 	check(!err);
 
 	err = reftable_new_stack(&st2, dir, &opts);
@@ -1021,7 +1021,7 @@ static void t_reftable_stack_auto_compaction(void)
 		};
 		snprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref, 0);
 		check(!err);
 
 		err = reftable_stack_auto_compact(st);
@@ -1058,7 +1058,7 @@ static void t_reftable_stack_auto_compaction_factor(void)
 		};
 		xsnprintf(name, sizeof(name), "branch%04"PRIuMAX, (uintmax_t)i);
 
-		err = reftable_stack_add(st, &write_test_ref, &ref);
+		err = reftable_stack_add(st, &write_test_ref, &ref, 0);
 		check(!err);
 
 		check(i < 5 || st->merged->tables_len < 5 * fastlogN(i, 5));
@@ -1140,7 +1140,7 @@ static void t_reftable_stack_add_performs_auto_compaction(void)
 		snprintf(buf, sizeof(buf), "branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf;
 
-		err = reftable_stack_add(st, write_test_ref, &ref);
+		err = reftable_stack_add(st, write_test_ref, &ref, 0);
 		check(!err);
 
 		/*

-- 
2.50.1

