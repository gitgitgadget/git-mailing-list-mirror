Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F411DF732
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053856; cv=none; b=O95DnbZ4fw5vEzoflqxFwU/vW52PDDmTYfWvLLi6FsrMoF9PpqaASg8ZXPg1MzJExA8l2PNM9Kk+ziD1UPwvaFRk4em6iW4ddPEj43NNpVZR5XfY7WwPtdctaiC+tCgYLUy3TVTQfk/TOOXZYE5vWkIMqRuVJi7CmYvVzoaNlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053856; c=relaxed/simple;
	bh=5sUiPa4WXr4W3vfGd4V/1ksnYij8ciDGzdZvRAt65i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvwkd4DdWpaSKJUGM0dGPkgrIk+b4kR/KBfFLqQUd65+ziK20j8s50tsc9u2FrvBn0VECTE9xbpJkrC3RdNWqOHWkKBQOtCos63cM1TsXI5MIHC1HA5YpT4MvVGkBxPpd8jbP2CvxV0MCa6aY2BMFtQpJtYI/R51pXpCdc24Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=okQcjrDe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqkduGRZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="okQcjrDe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqkduGRZ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 53D7E114018F;
	Fri,  8 Nov 2024 03:17:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 03:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731053853; x=1731140253; bh=7usdpGQp90
	9tCT8eS1CT6+ZO8udLxSs0HlQJaIPi2no=; b=okQcjrDeK+My0v6c9FJ2KYzOW2
	PJ+b2fi5zGcZ+X9ODijyLO1KQwIdRcV2iG08UIwkgu+o+37nCccHwb8HlGpvsD4y
	3rocqT8NmPqd2hCHswpb1KpwBYECXstBXoD7dW2iRG5woqGCF10lJd3otFdCbs8B
	pgZGSVhJHaFXpOdibnmRzTZpeIBmQRvTA8GRBu10IBv+XPnrnLpx3Be7NC85Kvgj
	ESdm1F+zUxpj55GcP8ni7fdQG40TAprQzyqKomqP9d4eNaxNsMykc9lKGsfKTMdJ
	q4xYqEsgMJNpuI6WfvzPcKLZwJg+ISK2lswJNnp6bNum6UwHXpZzk2wh5Diw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731053853; x=1731140253; bh=7usdpGQp909tCT8eS1CT6+ZO8udLxSs0HlQ
	JaIPi2no=; b=eqkduGRZ036Rhb81hPk2hnyEdMTzQCGMiYbFAD8S6T6QDWxd9US
	YliMGhpTzGwOKiYvetrWkrt0on4XKNiDVm5CAmvW91oq+XrQEIVFZU0Cv/1Yidp1
	GbzqZqUv9S+eVJanMt1jhp/NndnNihLHjs7YVA4ELCLU5HV91jlZuepRrmZ2U42W
	R1Idxmx0EVTmSVBxhYejoKn3ANRVlciUhgTK+jg81TqtO2tM52MlqHJ9Fo9fVSdb
	AzmnxLpx5+XdhbL2HqndTMXWAUcHWF9HMMoE5nnraI/jMK+Xpoq3/FPQLKKJKS3k
	NbtDY9IrPDEDK/ffCYt2kQ8JpVRJDD3ROrQ==
X-ME-Sender: <xms:HcktZxtnvGSwqHN5Wzbb7imsHTOEp1rApld7W5GvMfpga4km2ebPEg>
    <xme:HcktZ6dEtOetUnVIwCS_eBDZWw25sqDg4ugydKekWSTRL6FDzGudQH8YLoEhGoMo0
    eRcOE45tddEaX8jdg>
X-ME-Received: <xmr:HcktZ0ydw7Bo0l_oWSh4yFVogvAdRqiv0FZQ-NFYGzR9hrv_y0veMktV2p9ghOCRKjPWhenyKIjxCpuZHIVKVHQOsnp3nf52GpIG08srgWNMlDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfevhefhtddvueeugeeuueduffeuieegueejleehvdfg
    heduhfefveejteejueefnecuffhomhgrihhnpehlihhsthdrrghsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HcktZ4OtjzHYKl663muD0b6cqmnHRnliUM3DDvuZud8Bs8XcpmMr2Q>
    <xmx:HcktZx9XGPty_jsiZ0dh8c72wQWxfHZn67f2qqOFNBxgDzBjJbByKg>
    <xmx:HcktZ4WOHXsEaDivcNCDSXTfe214KLIMhQNBfJOhz5GiHwa9QVVeeg>
    <xmx:HcktZye-2iSbHGFTreKIrBGBX7RpxRDWvmIMuBnPvsFFjH3p3EVL_g>
    <xmx:HcktZ9ZK4aVEKSytWh6ydNIvXO-RYX9ZTqrgKlHsiKTNdofAyT_yECKq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:17:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5175bd04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 08:17:03 +0000 (UTC)
Date: Fri, 8 Nov 2024 09:17:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 7/7] reftable/system: provide thin wrapper for lockfile
 subsystem
Message-ID: <80fe5bc5e109ecc23e582f014585c8110bb404da.1731047193.git.ps@pks.im>
References: <cover.1729677003.git.ps@pks.im>
 <cover.1731047193.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731047193.git.ps@pks.im>

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
2.47.0.229.g8f8d6eee53.dirty

