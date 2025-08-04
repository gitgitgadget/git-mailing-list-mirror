Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD69246BCF
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300451; cv=none; b=qXFCr3L/GepeWOJdU+nbO+GdnYJBeTDYdnG1eL2ZllbvHSN/5lWJueDCNXoGhNPPh7DtqVOL8C0Y3JuNeaMnn5v9jqMXCIHfYlc/Cg6xdEREAUFdGhZBya8zJ/IFWTgSeFAyP6M1UMhZ20ot79RIqu0utby34wUpKzXY5dS+TN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300451; c=relaxed/simple;
	bh=cKsWp6mPksJK8uUvu8j1jNUFLHc3ivBbtysPzZSNSVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtrM0UUWLUQKlXsItDpGK73/we/r38v86rG5WfPGqC1IK5ooclGkH8JLitSuikHOy8+RIDuQJFVmAUni7/rdwWUxma1FVUddlcr9osqUQHr2lrRGhGrzmP/oIoCKA69X49nGpCZxsZpZ9wf1pcqW4V9GQlxiz+eYrt24g7+WddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R8n58rEy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezhFQ6ih; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R8n58rEy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezhFQ6ih"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C0DF1D000ED;
	Mon,  4 Aug 2025 05:40:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 05:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300448;
	 x=1754386848; bh=lRA/z1OgQiknuHFYo/6spua7gF2og0pAY/raQvI/jTI=; b=
	R8n58rEynoS77b1lpFUQMVPb2L2dAfPyPRn5N1YGEAizJoUtf7Brkj7s8TqlDMwC
	rWFjeJYLzVrh4Nn2IJTlZ4RL016gBLUGhk9gepnBpcywxDj30QM1hgxOoOgM2hQh
	lSV/3MVdyfUwWMleByN/oSJgy6x3CiIwY5eoBrEg7IcktNlGx2CRzZpq39WvamCJ
	AX2xPAX7EC4Yt1HdV6AnljRI3MQ+n1E+ngQN5Dc2R/W2V6Qg9AZ2XRKRO7jf7RVj
	/y2j/4tqUB+LHUdL5zUaho5RF7nFaVHTYzs8KrJ9qdXo0mZPvR7y2lj36Qo0hU9l
	WrNXX8LOkFjfRN1AaDrnrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300448; x=
	1754386848; bh=lRA/z1OgQiknuHFYo/6spua7gF2og0pAY/raQvI/jTI=; b=e
	zhFQ6ih+jYmWZ4XSBvavBL3Qro6y70D77gcRRe2MX43NKSEs2D7elpXPW34CR3E4
	AVuRdZ8MqWZ2xVwuGd+qhVc/745/edJUvISWCZNosiYbnjcOYTtyFGOOO1JSLgPv
	ffoIpoNqZXJ4sW85Kz00uyDsAOQvs2rFyT3bfAJ2jwRX5uR6hdo98Ywsox88+aRm
	9z671ZglmYW+x6nkIH1S12i547XVdG0yVMBECS9/+FUeKqIVS3kJGHl+sVUHnvJi
	hKpLI40hrsuO/woflvioXjbuj0WmZZXaMxPS73dQTsnGvit80QFTqwUZhAmzs5sS
	jB1V+h+Z1n/mZ+d7Fq0jA==
X-ME-Sender: <xms:IICQaLU66KJWe7tfv_b0f9FywIYt8wPFO1GU4aMLRJEPI8GQpdV6Lg>
    <xme:IICQaDyTxErGyK-3p-eDmCyHX1IGGj58JvIx-alyRVNBqtJViEMY8LFSfxz6gWnqN
    sxBYPTiB6LWjOV2gQ>
X-ME-Received: <xmr:IICQaJPhJF2zyvLe8XKtAWWYETErhoOBZDoiPr3iraGjYZ4bTCGdUmjeHAUwjFFa8epQnmqJzWyyWHK1oP9AMsq_ZXSRyLEJO8QPKwifdW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:IICQaE6bqCJVkP2NGlrj61MFFQ7eY_4sh5_6fwo00gDIWBO-BcIVfQ>
    <xmx:IICQaKMf0qp_ShE28_0IivL7l2Q4wUl1qgvtqHU5HIUQw1c9tFsCTw>
    <xmx:IICQaCmdvOOot-5ISc3MY3dMgqWNbU6CJlEpo8OcKGbwsRpDG8FHcQ>
    <xmx:IICQaBS4H46cK6wv20A_lW6VgsDAHbKuTzLAJx0Ma1r4v5CM12Kc_Q>
    <xmx:IICQaN603XTFK9ogkhkpP2Ax-miU1w73nSYoTH9aPDnCOkd7qDRYILpm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d05ba6c2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:40:25 +0200
Subject: [PATCH v2 4/6] reftable/stack: reorder code to avoid forward
 declarations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-4-fef06209a984@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
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
index 3480ad21c3..d6e4ea93a3 100644
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
 
 #define REFTABLE_ADDITION_INIT {{0}}
 
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
2.50.1.723.g3e08bea96f.dirty

