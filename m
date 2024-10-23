Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40519E960
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677372; cv=none; b=A15FQw/7QunQLsgPHMLBRhF0a31Px07GUYWCcWVwOBGq5+UcUbOi1CarrQ3gm5PKy6YEopeKEoZRWdqj8FXmdR0LKUJdFO5hocNR260RGPeaL1/mLAmargMm+BJS7RwFZGWSBb4y8W1an2q0wa4zwJHk3ykrxecFr4EBZ9N9exM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677372; c=relaxed/simple;
	bh=6vjWHYy3mDLBuSor17T2zV2HJaTBdcA+8MtgmEAT3C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHS8EVqCwAqmE6zPaE7/9PZfpNDCrhACl9xcx13ZDX+YArhJKbtZPOib0s47GLylGT/yJvGn8PBUN4s8twbOGdcaVP7ChadEef8F3Nvyn9K86hCto0G4P8G6NChrYTbPHGwWZ2mbMYwlobRPqWri6mAv/af4+uOG8A5/oLZPT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=avzelTvt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFnKP2JK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="avzelTvt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFnKP2JK"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 437B4138078E;
	Wed, 23 Oct 2024 05:56:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 05:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729677370; x=1729763770; bh=IFuof+tFee
	ot5fX7WO3qqpNQAkenrskmAVsC6HNbau8=; b=avzelTvt1QstxcURLOqXHW/j/a
	KMGIEbUPMy61o+/aAkwX6qF/Gy4D87XCW+y3JwKW/LvwqszVcaioIvOXny6TtN+u
	CyG4oddhTp4e7Czaw3keVHrSgfxRrUkNC6iceJWhDusT0o7zgftZpBT/G8Z0N60e
	ZoEYJLNNZhN0CJge7JK6RbcodCFQJDVN/1F9x7yslXTQOCGv+Y29KX4E2sV4t7LW
	rHhtx+PRHHfJ0hX44TlvesIP8Pcjx5rwyxyD1gIiKPrWFuwTdHmLInk35ybShiL3
	K8xT0uhga3Q/350/YwZp2mRVj3VHC2r152GlOUfC4f+GGyEr04NAPURsDVcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729677370; x=1729763770; bh=IFuof+tFeeot5fX7WO3qqpNQAken
	rskmAVsC6HNbau8=; b=ZFnKP2JKYjMxuyGRhA04tCF3Yj8Ec3spWtyrFRJMe3Xn
	bEpc48mRX7OEnm/e39R+bu5Ake2J52xhlPQ7C9DYiTSWFn65odkaiCAXCVbRGtoE
	jproKn4FZLIf/hR3FWPNbW6wACRexqCKezbUxB/zLlndcmW0hk4+juzO9rzFikmk
	L9vw29OmxpBZkefxfqHGtB/+uHuL5LwEYR60XWRwMSvbGXTf2PDtg+xDO6UOvWCX
	Em93w0vNSKZXFrcaqEdef6ED6EmG1/X5gXfdbcqNXhmGNAXVzMeOc+bRrjBpaoD/
	pja7S6E5+eGLPgjqEkBD2/Q5c4jFGAsDUVzPJDFAfw==
X-ME-Sender: <xms:OsgYZ02m9pyMLuOUp8aEF1sWggcYwYhvX9qfO27uVXleJGW07lP2aA>
    <xme:OsgYZ_EYYMuKdPFhXMTFvhRhMDJBT4ALS6POYHCzbzrfKkojNbl1QZmOI-N6IL0CT
    aaz_LvOepJrSlRHFQ>
X-ME-Received: <xmr:OsgYZ8583-Hw5vdbKcOx4hrsGOuCnQw7FAEjZrf8IOmvDbjP6ItD8ELPae_lUo3YFH6V41x-j60uLeVq2AyCD4-_jKO0skBrz5G0HluH5f-3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:OsgYZ92jFO0b5eufJBYWIx-bLIbvhXYeBb8o9p0ujpICAWwbC7zyNQ>
    <xmx:OsgYZ3EXAm8Fp6FmRW5YCz3FbuTpipK-ENqHHWRGcjnoiL0kt2gAjw>
    <xmx:OsgYZ28dBkASOti7MCfYK0kMOa52Wz-eCSY-nA9yx9pJJMPAwdfpHg>
    <xmx:OsgYZ8nT_Zfq_yQsUEZtw0bZLLhlqRXEIvBf5jKxbN0KpV9IoKX_Gw>
    <xmx:OsgYZ8RB9OpbhD46bXo_2QV9ebdTVlQIh0TNMiDNshf6Qg0lhz2m9mgq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 05:56:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3284ee9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 09:54:37 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:56:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 5/7] reftable/system: provide thin wrapper for tempfile
 subsystem
Message-ID: <aca1995556058b840b984dd1c3548214d791e3a6.1729677003.git.ps@pks.im>
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

We use the tempfile subsystem to write temporary tables, but given that
we're in the process of converting the reftable library to become
standalone we cannot use this subsystem directly anymore. While we could
in theory convert the code to use mkstemp(3p) instead, we'd lose access
to our infrastructure that automatically prunes tempfiles via atexit(3p)
or signal handlers.

Provide a thin wrapper for the tempfile subsystem instead. Like this,
the compatibility shim is fully self-contained in "reftable/system.c".
Downstream users of the reftable library would have to implement their
own tempfile shims by replacing "system.c" with a custom version.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile          |  1 +
 reftable/stack.c  | 57 +++++++++++++++++++----------------------------
 reftable/system.c | 49 ++++++++++++++++++++++++++++++++++++++++
 reftable/system.h | 41 +++++++++++++++++++++++++++++++++-
 4 files changed, 113 insertions(+), 35 deletions(-)
 create mode 100644 reftable/system.c

diff --git a/Makefile b/Makefile
index feeed6f9321..50a79ad83fc 100644
--- a/Makefile
+++ b/Makefile
@@ -2722,6 +2722,7 @@ REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
 REFTABLE_OBJS += reftable/record.o
 REFTABLE_OBJS += reftable/stack.o
+REFTABLE_OBJS += reftable/system.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
diff --git a/reftable/stack.c b/reftable/stack.c
index df4f3237007..67b2117a112 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -16,7 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reftable-record.h"
 #include "reftable-merged.h"
 #include "writer.h"
-#include "tempfile.h"
 
 static int stack_try_add(struct reftable_stack *st,
 			 int (*write_table)(struct reftable_writer *wr,
@@ -867,7 +866,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	struct reftable_buf tab_file_name = REFTABLE_BUF_INIT;
 	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_writer *wr = NULL;
-	struct tempfile *tab_file = NULL;
+	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
 	struct fd_writer writer = {
 		.stack = add->stack,
 	};
@@ -887,20 +886,18 @@ int reftable_addition_add(struct reftable_addition *add,
 	if (err < 0)
 		goto done;
 
-	tab_file = mks_tempfile(temp_tab_file_name.buf);
-	if (!tab_file) {
-		err = REFTABLE_IO_ERROR;
+	err = tmpfile_from_pattern(&tab_file, temp_tab_file_name.buf);
+	if (err < 0)
 		goto done;
-	}
 	if (add->stack->opts.default_permissions) {
-		if (chmod(get_tempfile_path(tab_file),
+		if (chmod(tab_file.path,
 			  add->stack->opts.default_permissions)) {
 			err = REFTABLE_IO_ERROR;
 			goto done;
 		}
 	}
 
-	writer.fd = get_tempfile_fd(tab_file);
+	writer.fd = tab_file.fd;
 	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
 				  &writer, &add->stack->opts);
 	if (err < 0)
@@ -918,11 +915,9 @@ int reftable_addition_add(struct reftable_addition *add,
 	if (err < 0)
 		goto done;
 
-	err = close_tempfile_gently(tab_file);
-	if (err < 0) {
-		err = REFTABLE_IO_ERROR;
+	err = tmpfile_close(&tab_file);
+	if (err < 0)
 		goto done;
-	}
 
 	if (wr->min_update_index < add->next_update_index) {
 		err = REFTABLE_API_ERROR;
@@ -945,11 +940,9 @@ int reftable_addition_add(struct reftable_addition *add,
 	  On windows, this relies on rand() picking a unique destination name.
 	  Maybe we should do retry loop as well?
 	 */
-	err = rename_tempfile(&tab_file, tab_file_name.buf);
-	if (err < 0) {
-		err = REFTABLE_IO_ERROR;
+	err = tmpfile_rename(&tab_file, tab_file_name.buf);
+	if (err < 0)
 		goto done;
-	}
 
 	REFTABLE_ALLOC_GROW(add->new_tables, add->new_tables_len + 1,
 			    add->new_tables_cap);
@@ -960,7 +953,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	add->new_tables[add->new_tables_len++] = reftable_buf_detach(&next_name);
 
 done:
-	delete_tempfile(&tab_file);
+	tmpfile_delete(&tab_file);
 	reftable_buf_release(&temp_tab_file_name);
 	reftable_buf_release(&tab_file_name);
 	reftable_buf_release(&next_name);
@@ -980,7 +973,7 @@ uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
 static int stack_compact_locked(struct reftable_stack *st,
 				size_t first, size_t last,
 				struct reftable_log_expiry_config *config,
-				struct tempfile **tab_file_out)
+				struct reftable_tmpfile *tab_file_out)
 {
 	struct reftable_buf next_name = REFTABLE_BUF_INIT;
 	struct reftable_buf tab_file_path = REFTABLE_BUF_INIT;
@@ -988,7 +981,7 @@ static int stack_compact_locked(struct reftable_stack *st,
 	struct fd_writer writer=  {
 		.stack = st,
 	};
-	struct tempfile *tab_file;
+	struct reftable_tmpfile tab_file = REFTABLE_TMPFILE_INIT;
 	int err = 0;
 
 	err = format_name(&next_name, reftable_reader_min_update_index(st->readers[first]),
@@ -1004,19 +997,17 @@ static int stack_compact_locked(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	tab_file = mks_tempfile(tab_file_path.buf);
-	if (!tab_file) {
-		err = REFTABLE_IO_ERROR;
+	err = tmpfile_from_pattern(&tab_file, tab_file_path.buf);
+	if (err < 0)
 		goto done;
-	}
 
 	if (st->opts.default_permissions &&
-	    chmod(get_tempfile_path(tab_file), st->opts.default_permissions) < 0) {
+	    chmod(tab_file.path, st->opts.default_permissions) < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
 
-	writer.fd = get_tempfile_fd(tab_file);
+	writer.fd = tab_file.fd;
 	err = reftable_writer_new(&wr, fd_writer_write, fd_writer_flush,
 				  &writer, &st->opts);
 	if (err < 0)
@@ -1030,15 +1021,15 @@ static int stack_compact_locked(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	err = close_tempfile_gently(tab_file);
+	err = tmpfile_close(&tab_file);
 	if (err < 0)
 		goto done;
 
 	*tab_file_out = tab_file;
-	tab_file = NULL;
+	tab_file = REFTABLE_TMPFILE_INIT;
 
 done:
-	delete_tempfile(&tab_file);
+	tmpfile_delete(&tab_file);
 	reftable_writer_free(wr);
 	reftable_buf_release(&next_name);
 	reftable_buf_release(&tab_file_path);
@@ -1171,7 +1162,7 @@ static int stack_compact_range(struct reftable_stack *st,
 	struct reftable_buf table_name = REFTABLE_BUF_INIT;
 	struct lock_file tables_list_lock = LOCK_INIT;
 	struct lock_file *table_locks = NULL;
-	struct tempfile *new_table = NULL;
+	struct reftable_tmpfile new_table = REFTABLE_TMPFILE_INIT;
 	int is_empty_table = 0, err = 0;
 	size_t first_to_replace, last_to_replace;
 	size_t i, nlocks = 0;
@@ -1439,11 +1430,9 @@ static int stack_compact_range(struct reftable_stack *st,
 		if (err < 0)
 			goto done;
 
-		err = rename_tempfile(&new_table, new_table_path.buf);
-		if (err < 0) {
-			err = REFTABLE_IO_ERROR;
+		err = tmpfile_rename(&new_table, new_table_path.buf);
+		if (err < 0)
 			goto done;
-		}
 	}
 
 	/*
@@ -1515,7 +1504,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		rollback_lock_file(&table_locks[i]);
 	reftable_free(table_locks);
 
-	delete_tempfile(&new_table);
+	tmpfile_delete(&new_table);
 	reftable_buf_release(&new_table_name);
 	reftable_buf_release(&new_table_path);
 	reftable_buf_release(&tables_list_buf);
diff --git a/reftable/system.c b/reftable/system.c
new file mode 100644
index 00000000000..01f96f03d84
--- /dev/null
+++ b/reftable/system.c
@@ -0,0 +1,49 @@
+#include "system.h"
+#include "basics.h"
+#include "reftable-error.h"
+#include "../tempfile.h"
+
+int tmpfile_from_pattern(struct reftable_tmpfile *out, const char *pattern)
+{
+	struct tempfile *tempfile;
+
+	tempfile = mks_tempfile(pattern);
+	if (!tempfile)
+		return REFTABLE_IO_ERROR;
+
+	out->path = tempfile->filename.buf;
+	out->fd = tempfile->fd;
+	out->priv = tempfile;
+
+	return 0;
+}
+
+int tmpfile_close(struct reftable_tmpfile *t)
+{
+	struct tempfile *tempfile = t->priv;
+	int ret = close_tempfile_gently(tempfile);
+	t->fd = -1;
+	if (ret < 0)
+		return REFTABLE_IO_ERROR;
+	return 0;
+}
+
+int tmpfile_delete(struct reftable_tmpfile *t)
+{
+	struct tempfile *tempfile = t->priv;
+	int ret = delete_tempfile(&tempfile);
+	*t = REFTABLE_TMPFILE_INIT;
+	if (ret < 0)
+		return REFTABLE_IO_ERROR;
+	return 0;
+}
+
+int tmpfile_rename(struct reftable_tmpfile *t, const char *path)
+{
+	struct tempfile *tempfile = t->priv;
+	int ret = rename_tempfile(&tempfile, path);
+	*t = REFTABLE_TMPFILE_INIT;
+	if (ret < 0)
+		return REFTABLE_IO_ERROR;
+	return 0;
+}
diff --git a/reftable/system.h b/reftable/system.h
index 38d3534620e..e7595800907 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,6 +13,45 @@ license that can be found in the LICENSE file or at
 
 #include "git-compat-util.h"
 #include "lockfile.h"
-#include "tempfile.h"
+
+/*
+ * An implementation-specific temporary file. By making this specific to the
+ * implementation it becomes possible to tie temporary files into any kind of
+ * signal or atexit handlers for cleanup on abnormal situations.
+ */
+struct reftable_tmpfile {
+	const char *path;
+	int fd;
+	void *priv;
+};
+#define REFTABLE_TMPFILE_INIT ((struct reftable_tmpfile) { .fd = -1, })
+
+/*
+ * Create a temporary file from a pattern similar to how mkstemp(3p) would.
+ * The `pattern` shall not be modified. On success, the structure at `out` has
+ * been initialized such that it is ready for use. Returns 0 on success, a
+ * reftable error code on error.
+ */
+int tmpfile_from_pattern(struct reftable_tmpfile *out, const char *pattern);
+
+/*
+ * Close the temporary file's file descriptor without removing the file itself.
+ * This is a no-op in case the file has already been closed beforehand. Returns
+ * 0 on success, a reftable error code on error.
+ */
+int tmpfile_close(struct reftable_tmpfile *t);
+
+/*
+ * Close the temporary file and delete it. This is a no-op in case the file has
+ * already been deleted or renamed beforehand. Returns 0 on success, a reftable
+ * error code on error.
+ */
+int tmpfile_delete(struct reftable_tmpfile *t);
+
+/*
+ * Rename the temporary file to the provided path. The temporary file must be
+ * active. Return 0 on success, a reftable error code on error.
+ */
+int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
 
 #endif
-- 
2.47.0.118.gfd3785337b.dirty

