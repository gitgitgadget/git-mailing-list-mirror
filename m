Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C31AA7AA
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677380; cv=none; b=r3nVAdqopcy7/o7lXc/DOJ4wtZiDYTFK+DncVrqeoSHS/TxjmEeISgn2dyJYoABJ6CCXQn0AM3clAgbg8+idSGVf0gEPEeRncVzrszKdY6gNovgIQgTZ88VOQpQ3XwXkhABRPbrnMTQ1BxM5lJJE0eejZhECHDGIwQRe+FX19cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677380; c=relaxed/simple;
	bh=nC8z5kBK9iHcyulfGhQPPdXb9e0G+NxDhT4zJfrV1go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT6cAju7VwNRZMM637c9GogsCUrjnXJ5hQk7MhcNaXxW7CL17CSh2EpMRBg13LQw39Lj7jJqdSSMrhI9yqibBqOoiZdOI8MrLGy9sJ3KV14jwudD+kbki1AqK/406S7ULoBb2VHj2ZV1EmlC9YyVxCNrKbZGxklppMmaNOY6bWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0FYiiF4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFTPNp6w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0FYiiF4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFTPNp6w"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 58ABE13800E4;
	Wed, 23 Oct 2024 05:56:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Oct 2024 05:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677377; x=1729763777; bh=6b9hxuCRV2
	FCNvSshZhrBLTI9FRAutChZqLWnxBZUtQ=; b=0FYiiF4Q/EbTH1yoK5eUX5UDX1
	d1lzELbNNNKNh8KzqgE/eZeykhxCt/uXmT1J5v6fiYvv/Meck7IA5PoaU+uWUPYk
	3bdxvOW7FYkYwcwYjUQl8JYUhlUqM+jo3k+EvqCbbishcBjBA19KN7p5kO39O6j2
	+wJDWPwtiyvs4pktyF+SNaRnVpHYQTBCskkp7VKGgBseaDghhb79a91kHnZW4HIX
	IHYdwHf5tNiirVsNHy5ELU8E06uaf17nE8NA/DMQvZjbsZt7G0+/6ZQJ+l69pbVh
	itEhLYiIAPMCkaUf20b4x1FrHwUP7eKbrecROdFAN5WnOkRUUpESXiFNLneQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677377; x=1729763777; bh=6b9hxuCRV2FCNvSshZhrBLTI9FRA
	utChZqLWnxBZUtQ=; b=UFTPNp6w+v/ccS3625LdtECz0JY8A9vGfaTjR31ygvpg
	7fRaDfAfNrrmF6FaUaeOXJRI9XVikeeCdFIcL813GpxPwvP/S2E+JlTDy4F2n6i4
	8mqtA5FKaQ37jXFiaQBrMGowQs2KplZBdRvLeIDeynQrKTZvvYeHuQF8Bo4UAjnX
	0fm0LBqBAb4cgw7/GKgOLvyg7b0UhEWqFA+AaezmqeG6M0XohkcegZO+x4AcQluM
	laAhrDBYjr7gQtyW/jPap9YLmlMfydMOeXAoUzfAdxXCiwTba4kCUx92f8ptnmbT
	WDDS7z8QCcG/eYG3OEUwr7rST3xhAvKLNqt9dzLE0g==
X-ME-Sender: <xms:QcgYZ-NX97Jw54TK3UvAsT6PIHLlwnTHqUjMB7MwHdiE-T-__wpTYg>
    <xme:QcgYZ895gJP1WIkMt2bqJvCS1lC_MA9Nc69uMJuv_p29xj40payUn3x56smSdHOUn
    qrUN8wEQ2bIKr4UdA>
X-ME-Received: <xmr:QcgYZ1QvWP8tnOEVBqd_6jfHW1F8UEYFHt70CX5INYhV9HD2hJlLOhU_hVm5NsGLQTRmYrnkG4j4-fcS6dyFcWXoFFGOAw9oBgoi-5QZtemT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfevhefhtddvueeugeeuueduffeuieegueejleehvdfg
    heduhfefveejteejueefnecuffhomhgrihhnpehlihhsthdrrghsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomh
    hsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QcgYZ-sKZbFAwQ1-sXOWHCLuuvTgYpWloPNn6YwqaBjzmr4ILEgrwA>
    <xmx:QcgYZ2eMvGamM_FMYTBUCzxGkmvPxLQNBuPkXzJUtFrQT-BEs3cIMg>
    <xmx:QcgYZy3uRmYPqEoMLOp-lXc1nfdrVTgV3PeJhX01-zyPMp20dkAyHw>
    <xmx:QcgYZ69oSVAR-4ptELLqNJJwFk3ujzvd5o4m-ULI_Iw0NiL8YGiK2A>
    <xmx:QcgYZ3ofMFrXjvaOTR6C5jEWYtpSFySRmViu08Z1tO47r0fDEc9l-Cxu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:56:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3af936b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:45 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:56:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 7/7] reftable/system: provide thin wrapper for lockfile
 subsystem
Message-ID: <71b213d6f8af725b73b5b9950667668f7c699bef.1729677003.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729677003.git.ps@pks.im>

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
index c1a4e25e3a2..1fffd756302 100644
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
 
-	err = stack_fsync(add->stack, lock_file_fd);
+	err = stack_fsync(add->stack, add->tables_list_lock.fd);
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
 
-	err = stack_fsync(st, get_lock_file_fd(&tables_list_lock));
+	err = stack_fsync(st, tables_list_lock.fd);
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
index e7595800907..0859c3539c6 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -12,7 +12,6 @@ license that can be found in the LICENSE file or at
 /* This header glues the reftable library to the rest of Git */
 
 #include "git-compat-util.h"
-#include "lockfile.h"
 
 /*
  * An implementation-specific temporary file. By making this specific to the
@@ -54,4 +53,48 @@ int tmpfile_delete(struct reftable_tmpfile *t);
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
2.47.0.118.gfd3785337b.dirty

