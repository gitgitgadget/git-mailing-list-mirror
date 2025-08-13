Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AA2D372D
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066352; cv=none; b=Xq4lEWSbHwjHYEhMJGZhopMWfw8hekwHswNjH+YrOhfGr40hSy8dJVsKcfC9fXeN+yd5VGc49ExSne5419J/VbECEWlGwVUBb3c6wDJk8lMWKASwmeCM/587Xd90zUfvm1Livkm0Mlm3kqCmLY11AJGBrWMD30o6ve3JzYkzJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066352; c=relaxed/simple;
	bh=HVY8jVevefex71jg/iSI+uQ9d7No1IALa2VsaDLlLNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHh7+BgPtIKjMwbj3PxwCEz/FaZktlxN6amq2xeqlAWvD4iYEALb8WcTrbcWisZ3EmA6cXBM2+yomECfewimz1qgV+kJmTS6bWrzr0EKbOtoHkfzSBFkyaK+jrMxvpPA77oLufbLuigIK0DDKp+4PxW7HHrW8id7944w9Ag494g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OreY11B0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PnoIhc4H; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OreY11B0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PnoIhc4H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 50CC51D0010E;
	Wed, 13 Aug 2025 02:25:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 13 Aug 2025 02:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755066349;
	 x=1755152749; bh=yvarWN7KyML8wipfZUNaIA05xrUJJSFLhYYG4RtaKeE=; b=
	OreY11B0P0i8FXpZM/PWKQBXo9fgsQbhRuTM9rDjLYiB+6pH2YIU98jjKgc0GAZ9
	5pLsFo1uB1YHUHoUd9TrxTzaO1oz2XrYechdlFalw1QCQ+4AA34KnnGF9jRUJpA3
	300Exwu4fT6KM2NoNsUxbpLuotow7ERbXUwBKfcGm+IhnSl6KryHH92G6ioDAZ77
	xCb3cJVMMXrnAWWnvleHEp/dPY87zj7F4xZJovpFv2FYlGnQm9hUp9t/aWo5owKu
	obzjBhX3DS2PDRVud0SuXj3ngp3H41CbTsyWAN04FBqUS29kR6vQDaFeFIKZDjER
	wQ0sRDkAKBbM5b6WyS4QTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755066349; x=
	1755152749; bh=yvarWN7KyML8wipfZUNaIA05xrUJJSFLhYYG4RtaKeE=; b=P
	noIhc4HyvYTRMQiUYZJSVv6oL5kbPqw5LzaUd16uJtqo1zwIdOKSh9Iykdh45An8
	qo93adc6cGpXs+tCPJbT4goOSyp1tK8UOvlcka+8TiYeR1LUKI4fJSGoPP+au0JX
	HwQ3T3NCBmCl6HJzj/p3OzHjzDNjXz1W9+ifKXlCMRlmN+i4Bo99Lb5Uye8lnSfQ
	39hWcrbO5uDvAD1oqIZ8cAeaBsPIGdaQfRp+yWXZRyML/2VmtQbMRc5kwukA5UyU
	Lsyt8YRphdNQGokBMroIlS7ABXb/7yNSyVOa61if/C4CCiPHZG9KxMwb9DdtOo8h
	ZmZcNQYYWKUu0qYWUfRsg==
X-ME-Sender: <xms:7S-caMhcmfuHI7ncUNQsNzz6pYDKEC4mbfeE5qK4F1N9TIdl8nhMVg>
    <xme:7S-caAjEGoXY74fgMndkBmy-ki-QSzN4b-i-W4THOj1fWoxi5nvOMeA6b55L2Jyib
    u0-v0jh6tdw6R5_gA>
X-ME-Received: <xmr:7S-caKjRheWj0clYgY6Nf35-c-O_e3qCPpAkKiojodu5zb4drH1wn6XeqOFShZiEELBEXpOmQmyQOb3-pw99tvMPYkf-JnpECkWeP00FMnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7S-caILxTCAZLjq4N-MdjtuDjI-I6Su0JBH5eSHXq8jjrKOg7H_tJg>
    <xmx:7S-caBH6kUU5MHXUwMJ2xqJq4-f7Y48AZGMawdDSOgF2dLBVumUyZg>
    <xmx:7S-caEQHuGEvOoQX8Urmt9-lv0OTQXpsFlgI0paAlh9C2aX8Zc4cag>
    <xmx:7S-caFdxA5T5COC2-AuXBYGcPR31IOofW2iL2qvZtfN6EoIh7ZDytA>
    <xmx:7S-caLdClwrWUiqkcQkAVnISxVD5VDlyCgXEfeoYygbht2LbXmlzXjle>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Aug 2025 02:25:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8cbbb36 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 13 Aug 2025 06:25:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Aug 2025 08:25:29 +0200
Subject: [PATCH v4 5/8] reftable/stack: allow passing flags to
 `reftable_stack_add()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-pks-reftable-fixes-for-libgit2-v4-5-42b5544c8e2a@pks.im>
References: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
In-Reply-To: <20250813-pks-reftable-fixes-for-libgit2-v4-0-42b5544c8e2a@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

The `reftable_stack_add()` function is a simple wrapper to lock the
stack, add records to it via a callback and then commit the
result. One problem with it though is that it doesn't accept any flags
for creating the addition. This makes it impossible to automatically
reload the stack in case it was modified before we managed to lock the
stack.

Add a `flags` field to plug this gap and pass it through accordingly.
This flag will be used in a subsequent patch and by libgit2.

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
index 9db90cf4ed0..1ce4d90cb82 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -736,12 +736,12 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 static int stack_try_add(struct reftable_stack *st,
 			 int (*write_table)(struct reftable_writer *wr,
 					    void *arg),
-			 void *arg)
+			 void *arg, unsigned flags)
 {
 	struct reftable_addition add;
 	int err;
 
-	err = reftable_stack_init_addition(&add, st, 0);
+	err = reftable_stack_init_addition(&add, st, flags);
 	if (err < 0)
 		goto done;
 
@@ -757,9 +757,9 @@ static int stack_try_add(struct reftable_stack *st,
 
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
2.51.0.rc1.215.g0f929dcec7.dirty

