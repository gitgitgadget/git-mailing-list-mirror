Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9A1BDAA0
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944056; cv=none; b=Pq2uOGfJKXOZ8wgBQW3ONDyTtYAEFZCP5nSojgYEkV4wjOsDegz/n0lmBHEzopfiE6sjUCooB/lftxFjTgSbaa9YGf0PijItfapEuHuYgpJFli07p74b7CRYz9ct1T7YDB+wCwEfafrC0QRyIP+5JkQyDpB62RI3HxsYXzT5BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944056; c=relaxed/simple;
	bh=bELkNVfNB8JPG78groyTcXBE/23JDYT/gfif+4oh8Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuIKTdXH/7/ijWiFDxb8K8x8UTRK31BXeNFMRCvBMstaikWDwCcuaX84rWXmNhm44bfBkX19HD9JwI97HfNz+uaUBHSaPtbt3hZ1mz+Dz4f7VhYrCa19BpF/KKj666FB8qnF/e0gulFtVneASkqfEy84ZI6mJhQ86R3iBiDGezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UNrEbWMr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KUxUds11; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UNrEbWMr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KUxUds11"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31F57114022C;
	Mon, 18 Nov 2024 10:34:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 18 Nov 2024 10:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731944054; x=1732030454; bh=ejuqnsYRrN
	0wduGIZ9nwT0GInZCpwtkaeHA22CtSnmk=; b=UNrEbWMrrIyiA2R4wAro2fNUdA
	v4zo9BKKXL6KtZCsNoNxu2Px1g3XQY+QltRCLBhfRuq27VYlxNP8J+Arfd3FvWIp
	UOAzIKGV3Tew1LnIqpA03eU9XZ5qr0GUoZ89lrXxSTR8k9qdQXCLO7ZtQ+F+x8sj
	5m8MAkbK7haGtowfwYvr2L3AQ1SzHX03gWjj9NYf/jD9kahzf9u0vrxbm6lLw5ID
	UEAt0rEFSBEO9gJnQKhagagkA8pfxuaDLDZoSHF/x7cehCeJgmCPHOOMtg60L+Gm
	AvQkZN9KK7naY7uxl69cjBhAbvOst7LQ4P2X0O9MRa34Q0fsrvi1qg9UaZIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731944054; x=1732030454; bh=ejuqnsYRrN0wduGIZ9nwT0GInZCpwtkaeHA
	22CtSnmk=; b=KUxUds11TP/539/rwe0k1uu0IQistceM3oJkZVIbPi+cSalX0tC
	/cYUxoh3hpmM93Idbkf9sO55oxki/PsWmCNhT7EkLVEookH6LRZE83MjeVZ8Z/NQ
	usm0hSrnxQZieq5hoFK5BJPltk5ozI/KP2S6QJoinxkmIJuhC7SBrGCrShRkgmw3
	ud+9ROdOgEiOgdojnX9UKT30VAbxofTxN2IRzPXgKiloPmBECuRCTrWnTq++UCAy
	Ky+iNUC6HWpS2EW4N0CiC9UEqIzQdMzfVikYgwowmAU0eswwtu+KBjl4/ykytyA/
	wfyqYID8OcTN2wx9/zyO+WEFVGJQ1fQqJmQ==
X-ME-Sender: <xms:dl47ZwNErCVuPEIO80U-GSUi_SiKvNx9ESKx6pgU_0Nd_jV-y1L1OQ>
    <xme:dl47Z2_DLWQNyIHpPvoSi7RlR4gulwii_XLsWKFdTUmmq6AVxGm7BkMS19selLYYR
    A8gabKe0igKpzvGcA>
X-ME-Received: <xmr:dl47Z3RIxigNymNOisY-NsT_7HaFQVWzw1ESaRAktBVJmNGUfD-DdyAaPAiANFay_8fdzhzfGCcN008-wQnOMrdbdbI-IwKjB-ij97flq54KZyhz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrught
    hhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:dl47Z4t9WCkmen3Ayjo2WiM3viRyFLMEs5mX5XPGId1i3fpfDW8maA>
    <xmx:dl47Z4ca4J2WeUX26OhxQC8ytobNxO_UXbYsnoJFf9ABXuj_0xAznQ>
    <xmx:dl47Z80xm5e9Am7MuN_KLUJjndp8QjbaoYbUYH7oam4anWv39gaYtA>
    <xmx:dl47Z8_zax0XHAX2YtmD4q5Gy-OE3n89clqSlzW1U2U0U3jVH6vuCQ>
    <xmx:dl47ZwSwDoZ2ijX7-3kqqEGvAgb7o21Lw4NxVjECTbRtqKGB0JCiaAEC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 10:34:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65009d62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 15:33:24 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:34:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 5/7] reftable/system: provide thin wrapper for tempfile
 subsystem
Message-ID: <430be1045d6b9728748ed9dcabe0aab3a9b67859.1731943954.git.ps@pks.im>
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
 reftable/system.h | 42 +++++++++++++++++++++++++++++++++-
 4 files changed, 114 insertions(+), 35 deletions(-)
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
index c67bdd952ca..2ac6a371516 100644
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
 		.opts = &add->stack->opts,
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
 		.opts = &st->opts,
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
index 38d3534620e..858189fd55d 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -13,6 +13,46 @@ license that can be found in the LICENSE file or at
 
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
+ * active. Return 0 on success, a reftable error code on error. Deactivates the
+ * temporary file.
+ */
+int tmpfile_rename(struct reftable_tmpfile *t, const char *path);
 
 #endif
-- 
2.47.0.274.g962d0b743d.dirty

