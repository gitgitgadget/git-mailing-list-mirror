Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7C26D4F9
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059691; cv=none; b=gAhi0qC+T5MGhfwCBXFGqg/7HuLT93qhtiwsFD+o/Z/6RyjVF/eygCVTJ62Mwu+OlTU9c+LO9o72uFeJSz0IBle25VTRYgRATSDsH6tQPgyQoYf1fMo5oKKX4Y10BFKbnZc1dF685h+7SYqbrRCbzWRZpF3rVWEOND65hTo2/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059691; c=relaxed/simple;
	bh=r61iGCvn1is4CFU/Kj5P80hv1ruLjpBzYDet3ATaOsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFVx6cNp1IE0rjvCs5v1JLtJsyAJSh1/OgDma0rmEka/w+lsAf5vBMDkrL2GzTNBvcioL/KIotkevuKxHpDAjd/xOHsfOuDo+XfdDAorrtdJywIL2owc13Qp78fOK0FjCeGyxmEO+RUSYGzmcxBZ3+vA/7ePF9N9eeXu2dkLStg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S83V44i1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUheI/JW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S83V44i1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUheI/JW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FDE81D004EA
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:48:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 01 Aug 2025 10:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754059688;
	 x=1754146088; bh=Awsa1yFEejcTahKPlcsKsOfFj0fTJ3KvTDqBTfF90Ew=; b=
	S83V44i17eo7tD/kJFLRCDwtUKl1UCuf09cCMH/2q5pLj6zmqml8hCGA+z3CFkOl
	swuwwjhUoE2mG5BRhE/4NrOcqU2FquGab17FN0H54nIXjQhdgSUOB+pYyx2atwDi
	Fhc7dv1+LIw8qsYYb1Q4+PTzjM2970prOAqgbv68wl4Ka1GliPAVSGMS4xOBXols
	RHfSUEKyPohTp1XALcHskSX4kleZoPzRkvh//U6OI6iwg3Cj/1tdPUNUfwrkItyZ
	v7tCDs0FHTkIMjGZiF+9oHA6bE9Uq5ENOc2blleLhnRRMZFKT7Sw0imP+yPIbLpl
	ockJVotK84e41w8flYqO7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059688; x=
	1754146088; bh=Awsa1yFEejcTahKPlcsKsOfFj0fTJ3KvTDqBTfF90Ew=; b=S
	UheI/JWlzwk9Y/5Ja3rkYTLP3lboPkCpuvB1j4G659RBOapU54iCE/ap5SH1hulS
	QYV2Ie67lzEXwoNmkQWzHRkm9xZVBIF6NfHsAewOsoy14NTqJG8G27ceq2IttPIr
	GPju2wS6ZJzeuK7TumrFJCPvcDTKHOO7HL4m3ZTJCGfrvuVLvw4O3XrYlqraY8ag
	xnm7SMhYBiX10OaCR532ULp/3IEpOsmAyc3QQ+iURWxN0LK0I+Op5bwYqyr6S3Ps
	NEUutZGsBPhsALgxRktZC5qor0dCpNWfDVS7ZYvgsTw0Fr6hgOdDZRueJF20P6O8
	TNbCmvR1nQqds02Q1NVkg==
X-ME-Sender: <xms:qNOMaG_NAJu76oPP-oUCXKABzIicfQ_vlxolpVsQU2qf5ekVb5IrNw>
    <xme:qNOMaIudX9ja79Jszls5luabIT7CGDriPOQyEscTuwcS8dGEkZy0TLcT2Z4LjeE5C
    wgyiiUFzWIuiY5GKA>
X-ME-Received: <xmr:qNOMaFZ32jbZUK-CFX6GD2YnUSyDsej-MfbzF2od4kqDF0MtwEzszqlx6vpeSndKokrDiQ09KCL0CDamGj5cIcvu-ElM-wERyIcIKqkexumM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:qNOMaAoJqdqMLYVqDWhpI3nEpDiUZiSOYxxyIV49EFhq_QOFYNL9gw>
    <xmx:qNOMaC_C-rpY_gVaC33e1x4Ta3Rc1m6EJNuIiGKImSiAYsp5N6OCJg>
    <xmx:qNOMaH_xjbu3tUHfc_s5Dzl6bhBEm8ZnLyg8ZwNYQiUE06Ai2tUbRQ>
    <xmx:qNOMaJuMD_7FlGYEg7V0j9ovk7Ikh83fQTFCHVmAMzsz2IrHbdsKaA>
    <xmx:qNOMaHmEsIGnInqJmnukXowDHE8PI2FG9WfMi8a324Rj2G2HKPDj72r_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 1 Aug 2025 10:48:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 909d824c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 1 Aug 2025 14:48:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 01 Aug 2025 16:47:50 +0200
Subject: [PATCH 4/5] reftable/stack: reorder code to avoid forward
 declarations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pks-reftable-fixes-for-libgit2-v1-4-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.50.1

