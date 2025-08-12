Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934F2EA743
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992482; cv=none; b=N9GE+A8QP9810BGIjuLzw3CeRZj5HxaXu/gPBvkUVe+BJhikNkzzzwwTSpEk5wNANWtEUFHvlYDsbDcveT5t49DGq5YBdNQYg8G+5AsmwH0jw0AG6RNWaHslOMUf/pxHrhGdlaTr8OO6mj36oWOPXNBA4kqCDkgMV/Ij0UGbMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992482; c=relaxed/simple;
	bh=VBHFyJyb7R7O/QyZHjc19BVaiV36WPFIoofoxUtqlPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phOnwT6NbePzt91e/VQX4o+uNuAYAhuIGqeawbS97NgssNV1weuJCJD0hGP8A3d4+XeZ4nDa40qy1VQze8+p6lEkY3qbwjE7uLH4TEuVZ6z5Tuqr/Jf9MifebLpa51OWUpPp+PpTPttKMvANek6fBHlnl0sib1DLQYFvr6cwCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MiA3ACNX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WkiEsTrH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MiA3ACNX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkiEsTrH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B797EC01D1;
	Tue, 12 Aug 2025 05:54:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 05:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992479;
	 x=1755078879; bh=TWqcUyId7lWXyg6CsDnB6aoF0UGJiptG6F7IhjjhSkc=; b=
	MiA3ACNXf1yMME80nGeEBDbdzh6fQCZAda+FmoXoF6aZSJYy5vVjKSMwd74XMNV7
	aAavACj+N4qqA7lZtc2zvQ9tmtIEz5nC/6qvO+880AeoMRRp9tOXP88s23BPgR2I
	qCvvNwmCN6ot6elyAcjw949EXXoIDbKIZrv18AiUzGzIvNSnbs99SYYr9nbapLgS
	rExYyC7/n6wKqmR56CUToWqeoaK3nlVIfNF8l4QF4HY93qwBdxS7sSzXPvga+DD7
	SbTs/lC01bLpdV/Nl8MFUTo2oSBxtrLdLSIsMXWvqBSfWBrYvl1EgXwb8L37PE6H
	SUrHKotRI9IXPg9nuzoHHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992479; x=
	1755078879; bh=TWqcUyId7lWXyg6CsDnB6aoF0UGJiptG6F7IhjjhSkc=; b=W
	kiEsTrHGOlrSWmMFSy4pyFkQC1kEbBoWU0CxI7cmOPWJnoIPpG1z7hqv2kBdMrZi
	e/mbPWWzQYyRLIf5KUazui99AytTWONSOdOHdXqzEquvK6bYglrEN/Gwq/hpsWoL
	vEzFCSLh2u2a+ow1XTZ8m3+zZdWlBTSqNYc7/GcgSyxfBDPZK4nXlIy3cYJRuqyx
	2tmzCCPd8ALPJ6GP3HNskqisRBpYHnkvnW/kfMzYL46zZIqH4oUTddzkN2k34Jtp
	rdsu0+qx5NOkg7NmchkctAKVYXo5xacWWF6+Gl6RgQXGcffDvzRc/cLqlKszmNCT
	6itcJcGr/VhQcLmvLnqeQ==
X-ME-Sender: <xms:Xw-baO07V97L3maN2TQASdDgfl1RZOB1N5l9CPQVOKgFbvbkvDmERg>
    <xme:Xw-baMkEinIuDF8sic8thpsdoh0pMkessuSEKUfa4C8ipTIzZstLR18ZICSQlzgpg
    tFevCWx5NuxVS5nbw>
X-ME-Received: <xmr:Xw-baNXJ_QEoQP3ALjHw2sVdf7lQ8dSrDY5LG3HPp87zWq3bPCOjCm_EgSNHZgVxWBqV23F_qZuAZOxUAPdSQggs5HvH4Jy3gW7HMZMS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Xw-baKsK1tcgCsWSrkueeEdGvHD1xcDuF0LK6Cq_U4o5FzxL0UEjLA>
    <xmx:Xw-baIaGWFdXB0LeIttAGBYpP72_RKE9ESV2vnQN5Ho3PUgnJyI90Q>
    <xmx:Xw-baBXzTkfap_Y6fY3hN-Eft5sdpK31r7yJYkmzlCCswd5rUI-52A>
    <xmx:Xw-baFSfz49q8E9Pi7MWZU_sSe8T1aWIoOMVmAcDCACaQbpJQdu7ew>
    <xmx:Xw-baNCMpXrXr51QYGUF6uo8a3FiHz6_4GBHRPw-Yh2t1omVDdJsXvl_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3e6ecff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:17 +0200
Subject: [PATCH v3 3/8] reftable/stack: reorder code to avoid forward
 declarations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-3-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

We have a couple of forward declarations in the stack-related code of
the reftable library. These declarations aren't really required, but are
simply caused by unfortunate ordering.

Reorder the code and remove the forward declarations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 364 +++++++++++++++++++++++++++----------------------------
 1 file changed, 176 insertions(+), 188 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 4caf96aa1d..ed80710572 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -17,18 +17,6 @@
 #include "table.h"
 #include "writer.h"
 
-static int stack_try_add(struct reftable_stack *st,
-			 int (*write_table)(struct reftable_writer *wr,
-					    void *arg),
-			 void *arg);
-static int stack_write_compact(struct reftable_stack *st,
-			       struct reftable_writer *wr,
-			       size_t first, size_t last,
-			       struct reftable_log_expiry_config *config);
-static void reftable_addition_close(struct reftable_addition *add);
-static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
-					     int reuse_open);
-
 static int stack_filename(struct reftable_buf *dest, struct reftable_stack *st,
 			  const char *name)
 {
@@ -84,54 +72,6 @@ static int fd_writer_flush(void *arg)
 	return stack_fsync(writer->opts, writer->fd);
 }
 
-int reftable_new_stack(struct reftable_stack **dest, const char *dir,
-		       const struct reftable_write_options *_opts)
-{
-	struct reftable_buf list_file_name = REFTABLE_BUF_INIT;
-	struct reftable_write_options opts = { 0 };
-	struct reftable_stack *p;
-	int err;
-
-	p = reftable_calloc(1, sizeof(*p));
-	if (!p) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto out;
-	}
-
-	if (_opts)
-		opts = *_opts;
-	if (opts.hash_id == 0)
-		opts.hash_id = REFTABLE_HASH_SHA1;
-
-	*dest = NULL;
-
-	reftable_buf_reset(&list_file_name);
-	if ((err = reftable_buf_addstr(&list_file_name, dir)) < 0 ||
-	    (err = reftable_buf_addstr(&list_file_name, "/tables.list")) < 0)
-		goto out;
-
-	p->list_file = reftable_buf_detach(&list_file_name);
-	p->list_fd = -1;
-	p->opts = opts;
-	p->reftable_dir = reftable_strdup(dir);
-	if (!p->reftable_dir) {
-		err = REFTABLE_OUT_OF_MEMORY_ERROR;
-		goto out;
-	}
-
-	err = reftable_stack_reload_maybe_reuse(p, 1);
-	if (err < 0)
-		goto out;
-
-	*dest = p;
-	err = 0;
-
-out:
-	if (err < 0)
-		reftable_stack_destroy(p);
-	return err;
-}
-
 static int fd_read_lines(int fd, char ***namesp)
 {
 	char *buf = NULL;
@@ -591,6 +531,54 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 	return err;
 }
 
+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
+		       const struct reftable_write_options *_opts)
+{
+	struct reftable_buf list_file_name = REFTABLE_BUF_INIT;
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *p;
+	int err;
+
+	p = reftable_calloc(1, sizeof(*p));
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
+	if (_opts)
+		opts = *_opts;
+	if (opts.hash_id == 0)
+		opts.hash_id = REFTABLE_HASH_SHA1;
+
+	*dest = NULL;
+
+	reftable_buf_reset(&list_file_name);
+	if ((err = reftable_buf_addstr(&list_file_name, dir)) < 0 ||
+	    (err = reftable_buf_addstr(&list_file_name, "/tables.list")) < 0)
+		goto out;
+
+	p->list_file = reftable_buf_detach(&list_file_name);
+	p->list_fd = -1;
+	p->opts = opts;
+	p->reftable_dir = reftable_strdup(dir);
+	if (!p->reftable_dir) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
+	err = reftable_stack_reload_maybe_reuse(p, 1);
+	if (err < 0)
+		goto out;
+
+	*dest = p;
+	err = 0;
+
+out:
+	if (err < 0)
+		reftable_stack_destroy(p);
+	return err;
+}
+
 /* -1 = error
  0 = up to date
  1 = changed. */
@@ -667,34 +655,6 @@ int reftable_stack_reload(struct reftable_stack *st)
 	return err;
 }
 
-int reftable_stack_add(struct reftable_stack *st,
-		       int (*write)(struct reftable_writer *wr, void *arg),
-		       void *arg)
-{
-	int err = stack_try_add(st, write, arg);
-	if (err < 0) {
-		if (err == REFTABLE_OUTDATED_ERROR) {
-			/* Ignore error return, we want to propagate
-			   REFTABLE_OUTDATED_ERROR.
-			*/
-			reftable_stack_reload(st);
-		}
-		return err;
-	}
-
-	return 0;
-}
-
-static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
-{
-	char buf[100];
-	uint32_t rnd = reftable_rand();
-	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
-		 min, max, rnd);
-	reftable_buf_reset(dest);
-	return reftable_buf_addstr(dest, buf);
-}
-
 struct reftable_addition {
 	struct reftable_flock tables_list_lock;
 	struct reftable_stack *stack;
@@ -706,6 +666,26 @@ struct reftable_addition {
 
 #define REFTABLE_ADDITION_INIT {0}
 
+static void reftable_addition_close(struct reftable_addition *add)
+{
+	struct reftable_buf nm = REFTABLE_BUF_INIT;
+	size_t i;
+
+	for (i = 0; i < add->new_tables_len; i++) {
+		if (!stack_filename(&nm, add->stack, add->new_tables[i]))
+			unlink(nm.buf);
+		reftable_free(add->new_tables[i]);
+		add->new_tables[i] = NULL;
+	}
+	reftable_free(add->new_tables);
+	add->new_tables = NULL;
+	add->new_tables_len = 0;
+	add->new_tables_cap = 0;
+
+	flock_release(&add->tables_list_lock);
+	reftable_buf_release(&nm);
+}
+
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,
 					unsigned int flags)
@@ -754,24 +734,52 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
 	return err;
 }
 
-static void reftable_addition_close(struct reftable_addition *add)
+static int stack_try_add(struct reftable_stack *st,
+			 int (*write_table)(struct reftable_writer *wr,
+					    void *arg),
+			 void *arg)
 {
-	struct reftable_buf nm = REFTABLE_BUF_INIT;
-	size_t i;
+	struct reftable_addition add = REFTABLE_ADDITION_INIT;
+	int err = reftable_stack_init_addition(&add, st, 0);
+	if (err < 0)
+		goto done;
 
-	for (i = 0; i < add->new_tables_len; i++) {
-		if (!stack_filename(&nm, add->stack, add->new_tables[i]))
-			unlink(nm.buf);
-		reftable_free(add->new_tables[i]);
-		add->new_tables[i] = NULL;
+	err = reftable_addition_add(&add, write_table, arg);
+	if (err < 0)
+		goto done;
+
+	err = reftable_addition_commit(&add);
+done:
+	reftable_addition_close(&add);
+	return err;
+}
+
+int reftable_stack_add(struct reftable_stack *st,
+		       int (*write)(struct reftable_writer *wr, void *arg),
+		       void *arg)
+{
+	int err = stack_try_add(st, write, arg);
+	if (err < 0) {
+		if (err == REFTABLE_OUTDATED_ERROR) {
+			/* Ignore error return, we want to propagate
+			   REFTABLE_OUTDATED_ERROR.
+			*/
+			reftable_stack_reload(st);
+		}
+		return err;
 	}
-	reftable_free(add->new_tables);
-	add->new_tables = NULL;
-	add->new_tables_len = 0;
-	add->new_tables_cap = 0;
 
-	flock_release(&add->tables_list_lock);
-	reftable_buf_release(&nm);
+	return 0;
+}
+
+static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
+{
+	char buf[100];
+	uint32_t rnd = reftable_rand();
+	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
+		 min, max, rnd);
+	reftable_buf_reset(dest);
+	return reftable_buf_addstr(dest, buf);
 }
 
 void reftable_addition_destroy(struct reftable_addition *add)
@@ -874,26 +882,6 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 	return err;
 }
 
-static int stack_try_add(struct reftable_stack *st,
-			 int (*write_table)(struct reftable_writer *wr,
-					    void *arg),
-			 void *arg)
-{
-	struct reftable_addition add = REFTABLE_ADDITION_INIT;
-	int err = reftable_stack_init_addition(&add, st, 0);
-	if (err < 0)
-		goto done;
-
-	err = reftable_addition_add(&add, write_table, arg);
-	if (err < 0)
-		goto done;
-
-	err = reftable_addition_commit(&add);
-done:
-	reftable_addition_close(&add);
-	return err;
-}
-
 int reftable_addition_add(struct reftable_addition *add,
 			  int (*write_table)(struct reftable_writer *wr,
 					     void *arg),
@@ -1007,72 +995,6 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
 	return 1;
 }
 
-static int stack_compact_locked(struct reftable_stack *st,
-				size_t first, size_t last,
-				struct reftable_log_expiry_config *config,
-				struct reftable_tmpfile *tab_file_out)
-{
-	struct reftable_buf next_name = REFTABLE_BUF_INIT;
-	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
-	struct reftable_writer *wr = NULL;
-	struct fd_writer writer=  {
-		.opts = &st->opts,
-	};
-	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
-	int err = 0;
-
-	err = format_name(&next_name, reftable_table_min_update_index(st->tables[first]),
-			  reftable_table_max_update_index(st->tables[last]));
-	if (err < 0)
-		goto done;
-
-	err = stack_filename(&tab_file_path, st, next_name.buf);
-	if (err < 0)
-		goto done;
-
-	err = reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
-	if (err < 0)
-		goto done;
-
-	err = tmpfile_from_pattern(&tab_file, tab_file_path.buf);
-	if (err < 0)
-		goto done;
-
-	if (st->opts.default_permissions &&
-	    chmod(tab_file.path, st->opts.default_permissions) < 0) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
-	}
-
-	writer.fd = tab_file.fd;
-	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
-				  &writer, &st->opts);
-	if (err < 0)
-		goto done;
-
-	err = stack_write_compact(st, wr, first, last, config);
-	if (err < 0)
-		goto done;
-
-	err = reftable_writer_close(wr);
-	if (err < 0)
-		goto done;
-
-	err = tmpfile_close(&tab_file);
-	if (err < 0)
-		goto done;
-
-	*tab_file_out = tab_file;
-	tab_file = REFTABLE_TMPFILE_INIT;
-
-done:
-	tmpfile_delete(&tab_file);
-	reftable_writer_free(wr);
-	reftable_buf_release(&next_name);
-	reftable_buf_release(&tab_file_path);
-	return err;
-}
-
 static int stack_write_compact(struct reftable_stack *st,
 			       struct reftable_writer *wr,
 			       size_t first, size_t last,
@@ -1172,6 +1094,72 @@ static int stack_write_compact(struct reftable_stack *st,
 	return err;
 }
 
+static int stack_compact_locked(struct reftable_stack *st,
+				size_t first, size_t last,
+				struct reftable_log_expiry_config *config,
+				struct reftable_tmpfile *tab_file_out)
+{
+	struct reftable_buf next_name = REFTABLE_BUF_INIT;
+	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
+	struct reftable_writer *wr = NULL;
+	struct fd_writer writer=  {
+		.opts = &st->opts,
+	};
+	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
+	int err = 0;
+
+	err = format_name(&next_name, reftable_table_min_update_index(st->tables[first]),
+			  reftable_table_max_update_index(st->tables[last]));
+	if (err < 0)
+		goto done;
+
+	err = stack_filename(&tab_file_path, st, next_name.buf);
+	if (err < 0)
+		goto done;
+
+	err = reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
+	if (err < 0)
+		goto done;
+
+	err = tmpfile_from_pattern(&tab_file, tab_file_path.buf);
+	if (err < 0)
+		goto done;
+
+	if (st->opts.default_permissions &&
+	    chmod(tab_file.path, st->opts.default_permissions) < 0) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	writer.fd = tab_file.fd;
+	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
+				  &writer, &st->opts);
+	if (err < 0)
+		goto done;
+
+	err = stack_write_compact(st, wr, first, last, config);
+	if (err < 0)
+		goto done;
+
+	err = reftable_writer_close(wr);
+	if (err < 0)
+		goto done;
+
+	err = tmpfile_close(&tab_file);
+	if (err < 0)
+		goto done;
+
+	*tab_file_out = tab_file;
+	tab_file = REFTABLE_TMPFILE_INIT;
+
+done:
+	tmpfile_delete(&tab_file);
+	reftable_writer_free(wr);
+	reftable_buf_release(&next_name);
+	reftable_buf_release(&tab_file_path);
+	return err;
+}
+
 enum stack_compact_range_flags {
 	/*
 	 * Perform a best-effort compaction. That is, even if we cannot lock

-- 
2.51.0.rc1.163.g2494970778.dirty

