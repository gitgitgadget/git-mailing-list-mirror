Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A407244691
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300454; cv=none; b=AP/dVaVVgJru9drQzVMYVspAn1eifhHtasAOFXHDlGCc6eFiVsyH033PwJ0C42dsxcjMKtRTWhgmkTfGRdlM2WKqkRW4PukhokOfs+waLUFVF8DcHZyvvtUOSGlLZdbCKlFYbICrCfx7JM1ijgLy/ng8zts1jLNwz7ZHRNzuazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300454; c=relaxed/simple;
	bh=Ao48SK2hQTPetGQKHCDr14LllR6SNzH1z7Q8mQFfaTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO+FAmNUMd6ETlqIApKopHmFRPwHuQE7LE0sfzJfJh6DpeHrE9YMGXIO/L+DXOLtsBBSbS7hgwn744TzFwIpLNEM7HhyaYpOSMdy/eKt3cWcuFlN/gpJ2PdildA9uEGqJeccIX78rWYA8hWRbYq3684UZdUhe3y16lVYOpAS9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PJvFiQIr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ei5wyuFp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PJvFiQIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ei5wyuFp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 28C9F1D0008E;
	Mon,  4 Aug 2025 05:40:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 05:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300452;
	 x=1754386852; bh=lAtAQr/86yzREavOb6V0Al1sM9CG9CDFwgZfvb2tskE=; b=
	PJvFiQIr+6t/C5nL156Mo3F1mZDYSP/1dyNwPT6D3dHFSBwxlFLsyVXOfF2qo1xz
	SCCyr9js8AcRUWQa8Ml+3npsHLOFC47h/Au4KVFZaK8NuUZW0DcYekIvTDiNG0+f
	sWQAEtAEQ1VzjQWNgJZz5yQcwgCdxT+wraVxy6wxzG2+sJho6cgtJqytIcyyhgQX
	KPn/zL5YqK1QkJiyriQrpHGUaXo+Unnnxu1NzA7WfHnRmJMbDRn4dlIoUkEH+yWJ
	uP11STiuB7LOIBELcQkCywibk/fnT7jjnj5FifzeWYcIH1N1VDJmZ1pQJLuhDesW
	ECx90nkzqENtGYU7CArdsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300452; x=
	1754386852; bh=lAtAQr/86yzREavOb6V0Al1sM9CG9CDFwgZfvb2tskE=; b=e
	i5wyuFpzwDNr6u1Cfay4ANQmrEiHBYxxo7Io23l6TUMkgurpVGg8XqzRPRq84CuR
	BiYkS2ya07OcSnktQeqJC8qrHPgt8vX3qnzjxt3xM+jEdbRbETsES23TuaGVmaon
	CYQk/vawbsJGVWBvVqPzI+cFiZf8sPtcZpzuVFUwFzH4tLm2wPGTk3ImLXgZjKZP
	0C1k97kDKbYCGIuFt+dyfSxL+92JKeuipW4xQrx6qwboqLnb0lw1uXKNfi6ylN2H
	x9x9BJn5a/NML75T3v7xhguz+3l8trMmJQU1fKox1HdOrXwv4+pAu3Zl5YPAC4Of
	5XpIIXxpE4lmYhotO1dMA==
X-ME-Sender: <xms:I4CQaI14hCG79CpgFZzBtM6Rw9Nz_oCXHF893JuL2QbKgf8T8-ixUA>
    <xme:I4CQaDT4-uWsVoUHKz2CSAlgfBbfRhncKArOMP37yqttEHX-DiHm8S9hNYBa-pby_
    qRnNClvPOeiXnDXQg>
X-ME-Received: <xmr:I4CQaCuvpHazF7kp1CR9JDOVfnmn176khxJJCJMe-0-mNa8hBUkysajqmwHOYflZJ9-187UGaafOLkiJAGKPSrY2yY5MK3Rc3D4UabhgvRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:I4CQaAa16SgH_uUjJjIYzCheBW-v8_EUqtKw1PeeHwehwDa6MfsOxg>
    <xmx:I4CQaPtiRRdifPpK8pQ5gDrxiV6r4ZS7bhdgKiGpq99Jdq-16Q_b8A>
    <xmx:I4CQaKFZcQRdUu90bqfbr19ZjhKGIJyh_Gh2F-rUpfNkIeIeR1_kPA>
    <xmx:I4CQaCzHB6smkbtziE2_rDMUWLomAkY1WvfwOM6CaKQdMpj-D_QzPA>
    <xmx:I4CQaLa-ZSehQ1pCFcu_t48j2eY2Csc8htnycXI6x3-OdoN4rxYrP3yC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 430d5ea3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:40:26 +0200
Subject: [PATCH v2 5/6] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-5-fef06209a984@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
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
index 4c3817f4ec1..3f0deab338c 100644
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
index 910ec6ef3a2..d70fcb705dc 100644
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
index d6e4ea93a37..f77d7f58e8e 100644
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
index 2f49c975194..ce10247903c 100644
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
2.50.1.723.g3e08bea96f.dirty

