Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09D1C07EE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944062; cv=none; b=ACC2xagsb5qfyGpE6VW7h2Jfr26bMe2YSNJNNXKnr4bPNaDYPRpCzH+ec1Ok+OKj4bBzJ7TmrGctwRLU1DS+NYEavGMi6MYtvCMXWAOS4LKX4HIgqSOJZR/1zAlvpVaccTs/8aNTTTwQL2vesx7y8doJpbILWllQHLLFsv9/t2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944062; c=relaxed/simple;
	bh=eu3WG6u6M+17btjeZu9/w+FpQqIgll4Tl2SZNbUMjJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF5kL/c11YRvXBRyYMv3gGA+Zsur1NDfiMuKtUiQ5tjMafzV+kn8osR6uByZHi9GQFujQjk62xHJjrKBFoSUBvfqfTefy14rANXjjnut5yTuF1wo+rOtoYTeXNeV3s20l693G7xlJWy7jv7ZHcKAfNRf/vRG2PCGaHWc7X+huBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SMAuHfeB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RB11zRtB; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SMAuHfeB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RB11zRtB"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8043413805D0;
	Mon, 18 Nov 2024 10:34:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 Nov 2024 10:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944059; x=1732030459; bh=Fb+r1ZGTT9
	An23xD91iurwxlU7+WaRITYVfg9k1XSlo=; b=SMAuHfeBDyFGoXK+Y9jeYxlObA
	KbGzJPbCacCGIrhM8e3MDRabxgd6Z+7QVjR/VfWWQfms8AG1cfCdv7HQ6DY/zFTW
	+5N04SMngoXpvCppuYXSmk4zOWdxmqzXOISbSaKWhxQlmkzpPJLZ9TP5unLEE7na
	/PKovqkMxZU3qf5o+hGghGA25t6UiVNDfTBTtE+QCafID1ut6yCYvuxFjM+MXJCw
	CelcsYBDqNOJZPee78IQxkX7Yufbr0pDDxhshzrgLcXfbJi9bWs7KRnecw4yg0PO
	eqN5LqFxoqfmV2uN2/mnAlj92NzuSU+ILv9Y3E6Fbn2CxTNGwq8NlmS4j5bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944059; x=1732030459; bh=Fb+r1ZGTT9An23xD91iurwxlU7+WaRITYVf
	g9k1XSlo=; b=RB11zRtBg9fcQzBOkNsHKIiKuXl6O7LtMOtxakaJwDPT7gtJvAG
	ytQuqs8T4Zc6STmt4Yh7INe8KoQNKiCV1CtGpk8su9I/shvvFgfeBj5PfjJMZGEt
	/fFlzSdZWDMBzd4A8Q7I8URFFMUfUARWbTQyK/IiKCG40r86QWOMNEteypXxP3Sr
	87JBiIronf3epHYLFKE+XD4Zxq7Ugzu8htJXlovzsDKiybW52vE/00dEqYKxYMq3
	a7TxaLJ69O64FpgyF3PxGdpTJwVa2a0vfMA2SfPgPzw8cM+eFdW3H8Q0Wv1g80A8
	Csh+H1ev5xJT1sOv0cTVjYprRf6I6X96y1w==
X-ME-Sender: <xms:e147Z-A0SUTDGI1dlVlTFxSk8y_TxcLd8KTbEfsORM7L7pfHgpKSYA>
    <xme:e147Z4jfIh99Uli3BFuHUtf0qdtMRdMxztD1MpA5EzPIfJAxWN9_6ud_ffW-TjQvv
    5yHdBJkY4kW4AOeiQ>
X-ME-Received: <xmr:e147Zxm1bY_WJ7QQd3RW6hYIasbAvXNVw7E7gaRtCncXeCSHoOFwF5uUHB0iebkFUlaO-7QHw604RA0YGX7qRy06pX3RGTuOf_P9GiInWntfQJPX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpefhveehhfdtvdeuueegueeuudffueeigeeujeelhedvgfeh
    udfhfeevjeetjeeufeenucffohhmrghinheplhhishhtrdgrshenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonh
    esvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:e147Z8z9WYi8LAp8fxhvcnll967u6oPn-wM8wFlAgY1sVqSVPlH8bg>
    <xmx:e147ZzQcqgSivDzs6s_3ZOWcsNUZ7O1-yQ-dXr-D9Jadmg-bRrNiiw>
    <xmx:e147Z3ZWm2rIKSf5CgUD5VrLSngLHMAvjajdq36N_tFBLfrgQoYMag>
    <xmx:e147Z8RlN28bUPW2uJ-6kToJ3Yq9ReBWDYm6lMCqT98x4x5qr6QWmg>
    <xmx:e147ZyGS7YnvfuAtq34eynv99UIhQ_8yBYzzg-cG3f-ogsZNuTEIyrp4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6a40eb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:30 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:34:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 7/7] reftable/system: provide thin wrapper for lockfile
 subsystem
Message-ID: <e1ac1cc2e677fddb03cb3bc37952b7be55652287.1731943954.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731943954.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731943954.git.ps@pks.im>

We use the lockfile subsystem to write lockfiles for "tables.list". As
with the tempfile subsystem, the lockfile subsystem also hooks into our
infrastructure to prune stale locks via atexit(3p) or signal handlers.

Furthermore, the lockfile subsystem also handles locking timeouts, which
do add quite a bit of logic. Having to reimplement that in the context
of Git wouldn't make a whole lot of sense, and it is quite likely that
downstream users of the reftable library may have a better idea for how
exactly to implement timeouts.

So again, provide a thin wrapper for the lockfile subsystem instead such
that the compatibility shim is fully self-contained.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c                    | 63 ++++++++++-------------
 reftable/system.c                   | 77 +++++++++++++++++++++++++++++
 reftable/system.h                   | 45 ++++++++++++++++-
 t/unit-tests/lib-reftable.c         |  1 +
 t/unit-tests/t-reftable-block.c     |  1 +
 t/unit-tests/t-reftable-pq.c        |  1 +
 t/unit-tests/t-reftable-readwrite.c |  1 +
 t/unit-tests/t-reftable-stack.c     |  2 +
 8 files changed, 154 insertions(+), 37 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 223d7c622d9..10d45e89d00 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -657,7 +657,7 @@ static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 }
 
 struct reftable_addition {
-	struct lock_file tables_list_lock;
+	struct reftable_flock tables_list_lock;
 	struct reftable_stack *stack;
 
 	char **new_tables;
@@ -676,10 +676,8 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 
 	add->stack = st;
 
-	err = hold_lock_file_for_update_timeout(&add->tables_list_lock,
-						st->list_file,
-						LOCK_NO_DEREF,
-						st->opts.lock_timeout_ms);
+	err = flock_acquire(&add->tables_list_lock, st->list_file,
+			    st->opts.lock_timeout_ms);
 	if (err < 0) {
 		if (errno == EEXIST) {
 			err = REFTABLE_LOCK_ERROR;
@@ -689,7 +687,7 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 		goto done;
 	}
 	if (st->opts.default_permissions) {
-		if (chmod(get_lock_file_path(&add->tables_list_lock),
+		if (chmod(add->tables_list_lock.path,
 			  st->opts.default_permissions) < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
@@ -733,7 +731,7 @@ static void reftable_addition_close(struct reftable_addition *add)
 	add->new_tables_len = 0;
 	add->new_tables_cap = 0;
 
-	rollback_lock_file(&add->tables_list_lock);
+	flock_release(&add->tables_list_lock);
 	reftable_buf_release(&nm);
 }
 
@@ -749,7 +747,6 @@ void reftable_addition_destroy(struct reftable_addition *add)
 int reftable_addition_commit(struct reftable_addition *add)
 {
 	struct reftable_buf table_list = REFTABLE_BUF_INIT;
-	int lock_file_fd = get_lock_file_fd(&add->tables_list_lock);
 	int err = 0;
 	size_t i;
 
@@ -767,20 +764,20 @@ int reftable_addition_commit(struct reftable_addition *add)
 			goto done;
 	}
 
-	err = write_in_full(lock_file_fd, table_list.buf, table_list.len);
+	err = write_in_full(add->tables_list_lock.fd, table_list.buf, table_list.len);
 	reftable_buf_release(&table_list);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
-	err = stack_fsync(&add->stack->opts, lock_file_fd);
+	err = stack_fsync(&add->stack->opts, add->tables_list_lock.fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
-	err = commit_lock_file(&add->tables_list_lock);
+	err = flock_commit(&add->tables_list_lock);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -1160,8 +1157,8 @@ static int stack_compact_range(struct reftable_stack *st,
 	struct reftable_buf new_table_name = REFTABLE_BUF_INIT;
 	struct reftable_buf new_table_path = REFTABLE_BUF_INIT;
 	struct reftable_buf table_name = REFTABLE_BUF_INIT;
-	struct lock_file tables_list_lock = LOCK_INIT;
-	struct lock_file *table_locks = NULL;
+	struct reftable_flock tables_list_lock = REFTABLE_FLOCK_INIT;
+	struct reftable_flock *table_locks = NULL;
 	struct reftable_tmpfile new_table = REFTABLE_TMPFILE_INIT;
 	int is_empty_table = 0, err = 0;
 	size_t first_to_replace, last_to_replace;
@@ -1179,10 +1176,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * Hold the lock so that we can read "tables.list" and lock all tables
 	 * which are part of the user-specified range.
 	 */
-	err = hold_lock_file_for_update_timeout(&tables_list_lock,
-						st->list_file,
-						LOCK_NO_DEREF,
-						st->opts.lock_timeout_ms);
+	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
 	if (err < 0) {
 		if (errno == EEXIST)
 			err = REFTABLE_LOCK_ERROR;
@@ -1205,19 +1199,20 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * older process is still busy compacting tables which are preexisting
 	 * from the point of view of the newer process.
 	 */
-	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
+	REFTABLE_ALLOC_ARRAY(table_locks, last - first + 1);
 	if (!table_locks) {
 		err = REFTABLE_OUT_OF_MEMORY_ERROR;
 		goto done;
 	}
+	for (i = 0; i < last - first + 1; i++)
+		table_locks[i] = REFTABLE_FLOCK_INIT;
 
 	for (i = last + 1; i > first; i--) {
 		err = stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
 		if (err < 0)
 			goto done;
 
-		err = hold_lock_file_for_update(&table_locks[nlocks],
-						table_name.buf, LOCK_NO_DEREF);
+		err = flock_acquire(&table_locks[nlocks], table_name.buf, 0);
 		if (err < 0) {
 			/*
 			 * When the table is locked already we may do a
@@ -1253,7 +1248,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * run into file descriptor exhaustion when we compress a lot
 		 * of tables.
 		 */
-		err = close_lock_file_gently(&table_locks[nlocks++]);
+		err = flock_close(&table_locks[nlocks++]);
 		if (err < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
@@ -1265,7 +1260,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * "tables.list" lock while compacting the locked tables. This allows
 	 * concurrent updates to the stack to proceed.
 	 */
-	err = rollback_lock_file(&tables_list_lock);
+	err = flock_release(&tables_list_lock);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -1288,10 +1283,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * "tables.list". We'll then replace the compacted range of tables with
 	 * the new table.
 	 */
-	err = hold_lock_file_for_update_timeout(&tables_list_lock,
-						st->list_file,
-						LOCK_NO_DEREF,
-						st->opts.lock_timeout_ms);
+	err = flock_acquire(&tables_list_lock, st->list_file, st->opts.lock_timeout_ms);
 	if (err < 0) {
 		if (errno == EEXIST)
 			err = REFTABLE_LOCK_ERROR;
@@ -1301,7 +1293,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	}
 
 	if (st->opts.default_permissions) {
-		if (chmod(get_lock_file_path(&tables_list_lock),
+		if (chmod(tables_list_lock.path,
 			  st->opts.default_permissions) < 0) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
@@ -1456,7 +1448,7 @@ static int stack_compact_range(struct reftable_stack *st,
 			goto done;
 	}
 
-	err = write_in_full(get_lock_file_fd(&tables_list_lock),
+	err = write_in_full(tables_list_lock.fd,
 			    tables_list_buf.buf, tables_list_buf.len);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -1464,14 +1456,14 @@ static int stack_compact_range(struct reftable_stack *st,
 		goto done;
 	}
 
-	err = stack_fsync(&st->opts, get_lock_file_fd(&tables_list_lock));
+	err = stack_fsync(&st->opts, tables_list_lock.fd);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
 		goto done;
 	}
 
-	err = commit_lock_file(&tables_list_lock);
+	err = flock_commit(&tables_list_lock);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1492,12 +1484,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * readers, so it is expected that unlinking tables may fail.
 	 */
 	for (i = 0; i < nlocks; i++) {
-		struct lock_file *table_lock = &table_locks[i];
-		const char *lock_path = get_lock_file_path(table_lock);
+		struct reftable_flock *table_lock = &table_locks[i];
 
 		reftable_buf_reset(&table_name);
-		err = reftable_buf_add(&table_name, lock_path,
-				       strlen(lock_path) - strlen(".lock"));
+		err = reftable_buf_add(&table_name, table_lock->path,
+				       strlen(table_lock->path) - strlen(".lock"));
 		if (err)
 			continue;
 
@@ -1505,9 +1496,9 @@ static int stack_compact_range(struct reftable_stack *st,
 	}
 
 done:
-	rollback_lock_file(&tables_list_lock);
+	flock_release(&tables_list_lock);
 	for (i = 0; table_locks && i < nlocks; i++)
-		rollback_lock_file(&table_locks[i]);
+		flock_release(&table_locks[i]);
 	reftable_free(table_locks);
 
 	tmpfile_delete(&new_table);
diff --git a/reftable/system.c b/reftable/system.c
index 01f96f03d84..adf8e4d30b8 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -1,6 +1,7 @@
 #include "system.h"
 #include "basics.h"
 #include "reftable-error.h"
+#include "../lockfile.h"
 #include "../tempfile.h"
 
 int tmpfile_from_pattern(struct reftable_tmpfile *out, const char *pattern)
@@ -47,3 +48,79 @@ int tmpfile_rename(struct reftable_tmpfile *t, const char *path)
 		return REFTABLE_IO_ERROR;
 	return 0;
 }
+
+int flock_acquire(struct reftable_flock *l, const char *target_path,
+		  long timeout_ms)
+{
+	struct lock_file *lockfile;
+	int err;
+
+	lockfile = reftable_malloc(sizeof(*lockfile));
+	if (!lockfile)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+	err = hold_lock_file_for_update_timeout(lockfile, target_path, LOCK_NO_DEREF,
+						timeout_ms);
+	if (err < 0) {
+		reftable_free(lockfile);
+		if (errno == EEXIST)
+			return REFTABLE_LOCK_ERROR;
+		return -1;
+	}
+
+	l->fd = get_lock_file_fd(lockfile);
+	l->path = get_lock_file_path(lockfile);
+	l->priv = lockfile;
+
+	return 0;
+}
+
+int flock_close(struct reftable_flock *l)
+{
+	struct lock_file *lockfile = l->priv;
+	int ret;
+
+	if (!lockfile)
+		return REFTABLE_API_ERROR;
+
+	ret = close_lock_file_gently(lockfile);
+	l->fd = -1;
+	if (ret < 0)
+		return REFTABLE_IO_ERROR;
+
+	return 0;
+}
+
+int flock_release(struct reftable_flock *l)
+{
+	struct lock_file *lockfile = l->priv;
+	int ret;
+
+	if (!lockfile)
+		return 0;
+
+	ret = rollback_lock_file(lockfile);
+	reftable_free(lockfile);
+	*l = REFTABLE_FLOCK_INIT;
+	if (ret < 0)
+		return REFTABLE_IO_ERROR;
+
+	return 0;
+}
+
+int flock_commit(struct reftable_flock *l)
+{
+	struct lock_file *lockfile = l->priv;
+	int ret;
+
+	if (!lockfile)
+		return REFTABLE_API_ERROR;
+
+	ret = commit_lock_file(lockfile);
+	reftable_free(lockfile);
+	*l = REFTABLE_FLOCK_INIT;
+	if (ret < 0)
+		return REFTABLE_IO_ERROR;
+
+	return 0;
+}
diff --git a/reftable/system.h b/reftable/system.h
index 858189fd55d..7d5f803eeb1 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -12,7 +12,6 @@ license that can be found in the LICENSE file or at
 /* This header glues the reftable library to the rest of Git */
 
 #include "git-compat-util.h"
-#include "lockfile.h"
 
 /*
  * An implementation-specific temporary file. By making this specific to the
@@ -55,4 +54,48 @@ int tmpfile_delete(struct reftable_tmpfile *t);
  */
 int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
 
+/*
+ * An implementation-specific file lock. Same as with `reftable_tmpfile`,
+ * making this specific to the implementation makes it possible to tie this
+ * into signal or atexit handlers such that we know to clean up stale locks on
+ * abnormal exits.
+ */
+struct reftable_flock {
+	const char *path;
+	int fd;
+	void *priv;
+};
+#define REFTABLE_FLOCK_INIT ((struct reftable_flock){ .fd = -1, })
+
+/*
+ * Acquire the lock for the given target path by exclusively creating a file
+ * with ".lock" appended to it. If that lock exists, we wait up to `timeout_ms`
+ * to acquire the lock. If `timeout_ms` is 0 we don't wait, if it is negative
+ * we block indefinitely.
+ *
+ * Retrun 0 on success, a reftable error code on error.
+ */
+int flock_acquire(struct reftable_flock *l, const char *target_path,
+		  long timeout_ms);
+
+/*
+ * Close the lockfile's file descriptor without removing the lock itself. This
+ * is a no-op in case the lockfile has already been closed beforehand. Returns
+ * 0 on success, a reftable error code on error.
+ */
+int flock_close(struct reftable_flock *l);
+
+/*
+ * Release the lock by unlinking the lockfile. This is a no-op in case the
+ * lockfile has already been released or committed beforehand. Returns 0 on
+ * success, a reftable error code on error.
+ */
+int flock_release(struct reftable_flock *l);
+
+/*
+ * Commit the lock by renaming the lockfile into place. Returns 0 on success, a
+ * reftable error code on error.
+ */
+int flock_commit(struct reftable_flock *l);
+
 #endif
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
index c1631f45275..d795dfb7c99 100644
--- a/t/unit-tests/lib-reftable.c
+++ b/t/unit-tests/lib-reftable.c
@@ -2,6 +2,7 @@
 #include "test-lib.h"
 #include "reftable/constants.h"
 #include "reftable/writer.h"
+#include "strbuf.h"
 
 void t_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
 {
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 13e10807dae..22040aeefa5 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/reftable-error.h"
+#include "strbuf.h"
 
 static void t_ref_block_read_write(void)
 {
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 272da05bea6..f3f8a0cdf38 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #include "test-lib.h"
 #include "reftable/constants.h"
 #include "reftable/pq.h"
+#include "strbuf.h"
 
 static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 {
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 57896922eb1..91c881aedfa 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -13,6 +13,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-writer.h"
+#include "strbuf.h"
 
 static const int update_index = 5;
 
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 13fd8d8f941..b2f6c1c37e9 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -13,6 +13,8 @@ license that can be found in the LICENSE file or at
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
 #include "reftable/stack.h"
+#include "strbuf.h"
+#include "tempfile.h"
 #include <dirent.h>
 
 static void clear_dir(const char *dirname)
-- 
2.47.0.274.g962d0b743d.dirty

