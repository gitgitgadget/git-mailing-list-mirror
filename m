Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2539422E2E
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052355; cv=none; b=UDEdY8nahiqXhJrIy1HvnsCsVxZlDnsimg27H9ftLGYvqo84c+aA9vWUVdyxCYoEMR8+R4MBSXG8LWCdUuyJwYZv+d916XQAedMWHMu19bG3PWdloOFPS/wcF1F4jYAop5FuH/jaU1rv+/+HMh5fam1dOFYZSdrH307XtEDvDOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052355; c=relaxed/simple;
	bh=4jcWa9qfMtiFeq8YMFmjOCaCFv+C3rGr+lPn4v28z9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seUplM1TXUjuG+VtQzR1kdGqgsQ4GGf3tMalGgC33zoWfvYMNqCLPrm5U9a94Gp7bcPkz3dr/kUsT2n1/iKZmuuDttJ1etIkE9Z73LEGsheFg/K/shHavYkMmzaG63XLJZiXXNHhSD3/nsmCyvRRCIFm8xvI0WXfJPFkStUgJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg4pOTvf; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg4pOTvf"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f0167e59a3so1527208a34.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052348; x=1786657148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+lXoIYbWCcvpSWDUtRDpZEChmaY6+OR2xSxf5uUGOM=;
        b=jg4pOTvfTPc2FIMYr1arFLP6+HZ5TRO5GJLxOZfLdabC0km3jQVxSAEQ4AfVNIAens
         koZSvpZw3cBKsgeuHqCF2kF8m4naCn/Fh3RFrKldxz+VYTXUXevwxc7W5yPRhe79/BXV
         fQ5bJ3qz8n47eABJGH7QyGCEGN4AfDI83SzoJI7JwzV+j6Ccs6i+m7tHZeZnaU2jJ+Nd
         348zG+ttZPLD8bi2ACaec/HWPcZc7xz6mvf24MC1dtxpLeDBdeJgNISaBtB/IZ7MSgSk
         8vQAlsiz3t8hWJNDOCHD7zImT0qL1SQEI7CARj9y0IiqzkOew0XTOd+FfZKZ6DeuR2KP
         igIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052348; x=1786657148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F+lXoIYbWCcvpSWDUtRDpZEChmaY6+OR2xSxf5uUGOM=;
        b=tG5Ci1JXe+o6bvWIsTN/EB664fH7+KTpDszHcDYmkohjd1/oSN6GdcbPBXJxLqdzK5
         oqaM7UjjGt2A8WqCigh/pp/lntkYh7zf2athmyCY3Ga1ePZ85zte48SUS++uIXhvqfp6
         p3NcacV+B1lDgj/+HsLPK69PbLrCKdi/9jEBYkhvx+K8clSDIO5g0GB68b2Bx+7friCk
         gaP1G1Ck+JaAb6TIP8YY/4Cb+/kFCJ8G8AR38rZN0wUPpaYPIUptng5eJ9OiMGOQUymc
         FkBY1PAZHKOnwLHoFmaT7TInzGXQP8q0n6E9hJ/xsqORHJ53v9CsDIWFqL89Lk/8Bqd0
         WD1Q==
X-Gm-Message-State: AOJu0Ywq0lAgn4AX8mIbbRBnsewY6QrGLvXiHH268kq8P04aklmkaVwQ
	dKCiZrX6L2XTp+4D8a2/N/lbx7qb4flpnLZQM/vLh0oV4noSEAiEAM6bQXO9Kg==
X-Gm-Gg: AR+sD13shTKTP9ctPGtWIiPxf/4ubZH/KDnkao/Wg3drVYWBqDtCWVR7e+3GgNI4B6X
	x0DM928v3t23CZRJ67TzIdgQkUn12GemS3m1w6TfwdG7pBkJoXS3KN3q0TQLAEJEfVCzidy4RFD
	KiNsyo4oUAEwxitxtmqx6K6wIn0E8QdpTmgGvvgf89jrtUXrMnqmH9e6ipWxbwCBLFJz9HSS8PI
	HjGck/zhfeenGJ9PsNsx/0pAtqf+ZHq5fB41QdRm1PQSknUx3P+uAvDJO+HfUCe1LLzMDg81m7C
	FAPUbZpD6PXBGE5F61+b/PXvrgtSGT+FJWUzJa2SRf3I4D8JQFr0fyZCy0dasJ9ag8GO+T1os5U
	4JPVOgYUWMzPyaH0t+lb6UsLkHR5Ft8qolyXMudFQ3QHdpPneMjCpBw1JNoM9P/FLKf4LO16OxX
	KhihP//C3zqQuA36IgcmwxFcMYsNS56JfHoNkKPmioDLgFxa4zy+wCnE4vL4H2jZLNjYSZ
X-Received: by 2002:a05:6820:a03:b0:6ad:ee80:91d9 with SMTP id 006d021491bc7-6ae96e8c619mr8809147eaf.17.1786052348118;
        Thu, 06 Aug 2026 14:39:08 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:07 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 6/6] odb/transaction: add transaction interface to write packfiles
Date: Thu,  6 Aug 2026 16:38:59 -0500
Message-ID: <20260806213859.816157-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260806213859.816157-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-receive-pack(1), the incoming packfile is written to the ODB via
`unpack()`, which spawns git-index-pack(1) or git-unpack-objects(1)
directly. With pluggable object databases, an alternative backend may
need to handle writing packfile data differently though.

Introduce `odb_transaction_write_pack()` as a generic interface to
handle writing a packfile to a transaction and use the logic from
`unpack()` as the "files" backend implementation. Note that a packfile
written via git-index-pack(1) is kept in place by a ".keep" lockfile
that must be retained until references are updated. To faciliate this in
an ODB backend agnostic manner, the "files" transaction backend takes
ownership of these lockfiles and removes them post-commit through its
release callback.

Call sites in git-receive-pack(1) are updated accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 143 +--------------------------------------
 object-file.c          | 149 +++++++++++++++++++++++++++++++++++++++++
 odb/transaction.c      |   7 ++
 odb/transaction.h      |  63 +++++++++++++++++
 4 files changed, 222 insertions(+), 140 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 743005f1f5..3069b53509 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2305,147 +2305,11 @@ static void read_push_options(struct packet_reader *reader,
 	}
 }
 
-static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
-{
-	switch (read_pack_header(pack_fd, hdr)) {
-	case PH_ERROR_EOF:
-		return "eof before pack header was fully read";
-
-	case PH_ERROR_PACK_SIGNATURE:
-		return "protocol error (pack signature mismatch detected)";
-
-	case PH_ERROR_PROTOCOL:
-		return "protocol error (pack version unsupported)";
-
-	default:
-		return "unknown error in parse_pack_header";
-
-	case 0:
-		return NULL;
-	}
-}
-
-static struct tempfile *pack_lockfile;
-
-static void push_header_arg(struct strvec *args, struct pack_header *hdr)
-{
-	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
-		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
-}
-
-struct unpack_opts {
-	const char *fsck_msg_types;
-	const char *shallow_file;
-	off_t max_input_size;
-	int fsck_objects;
-	int unpack_limit;
-	int reject_thin;
-	int err_fd;
-	int quiet;
-};
-
-static int unpack(struct odb_transaction *transaction, int pack_fd,
-		  struct strbuf *err_msg, const struct unpack_opts *opts)
-{
-	struct pack_header hdr;
-	const char *hdr_err;
-	int status;
-	struct child_process child = CHILD_PROCESS_INIT;
-	int err_fd = opts->err_fd;
-
-	hdr_err = parse_pack_header(&hdr, pack_fd);
-	if (hdr_err) {
-		if (err_fd > 0)
-			close(err_fd);
-		strbuf_addstr(err_msg, hdr_err);
-		return -1;
-	}
-
-	if (opts->shallow_file) {
-		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, opts->shallow_file);
-	}
-
-	odb_transaction_env(transaction, &child.env);
-
-	if (ntohl(hdr.hdr_entries) < opts->unpack_limit) {
-		strvec_push(&child.args, "unpack-objects");
-		push_header_arg(&child.args, &hdr);
-		if (opts->quiet)
-			strvec_push(&child.args, "-q");
-		if (opts->fsck_objects)
-			strvec_pushf(&child.args, "--strict%s",
-				     opts->fsck_msg_types);
-		if (opts->max_input_size)
-			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)opts->max_input_size);
-		child.no_stdout = 1;
-		child.in = pack_fd;
-		child.err = err_fd;
-		child.git_cmd = 1;
-		status = run_command(&child);
-		if (status) {
-			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
-			return -1;
-		}
-	} else {
-		char hostname[HOST_NAME_MAX + 1];
-		char *lockfile;
-
-		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
-		push_header_arg(&child.args, &hdr);
-
-		if (xgethostname(hostname, sizeof(hostname)))
-			xsnprintf(hostname, sizeof(hostname), "localhost");
-		strvec_pushf(&child.args,
-			     "--keep=receive-pack %"PRIuMAX" on %s",
-			     (uintmax_t)getpid(),
-			     hostname);
-
-		if (!opts->quiet && err_fd)
-			strvec_push(&child.args, "--show-resolving-progress");
-		if (err_fd)
-			strvec_push(&child.args, "--report-end-of-input");
-		if (opts->fsck_objects)
-			strvec_pushf(&child.args, "--strict%s",
-				     opts->fsck_msg_types);
-		if (!opts->reject_thin)
-			strvec_push(&child.args, "--fix-thin");
-		if (opts->max_input_size)
-			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
-				     (uintmax_t)opts->max_input_size);
-		child.out = -1;
-		child.in = pack_fd;
-		child.err = err_fd;
-		child.git_cmd = 1;
-		status = start_command(&child);
-		if (status) {
-			strbuf_addstr(err_msg, "index-pack fork failed");
-			return -1;
-		}
-
-		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
-		if (lockfile) {
-			pack_lockfile = register_tempfile(lockfile);
-			free(lockfile);
-		}
-		close(child.out);
-
-		status = finish_command(&child);
-		if (status) {
-			strbuf_addstr(err_msg, "index-pack abnormal exit");
-			return -1;
-		}
-		odb_reprepare(the_repository->objects);
-	}
-	return 0;
-}
-
 static int unpack_with_sideband(struct odb_transaction *transaction,
 				const char *shallow_file,
 				struct strbuf *err_msg)
 {
-	struct unpack_opts opts = {
+	struct odb_transaction_write_pack_opts opts = {
 		.fsck_objects = (receive_fsck_objects >= 0
 				 ? receive_fsck_objects
 				 : transfer_fsck_objects >= 0
@@ -2462,7 +2326,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, 0, err_msg, &opts);
+		return odb_transaction_write_pack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2472,7 +2336,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, 0, err_msg, &opts);
+	ret = odb_transaction_write_pack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
@@ -2752,7 +2616,6 @@ int cmd_receive_pack(int argc,
 		execute_commands(commands, !!unpack_status.len, &si, transaction,
 				 &push_options);
 		odb_transaction_release(transaction);
-		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
 			report_v2(commands, &unpack_status);
diff --git a/object-file.c b/object-file.c
index 30b4717d3e..ec3b9a185e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -26,6 +26,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
+#include "run-command.h"
 #include "setup.h"
 #include "strvec.h"
 #include "tempfile.h"
@@ -487,6 +488,10 @@ struct odb_transaction_files {
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
 	const char *prefix;
+
+	struct tempfile **pack_lockfiles;
+	size_t pack_lockfiles_nr;
+	size_t pack_lockfiles_alloc;
 };
 
 int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -1292,6 +1297,148 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	return 0;
 }
 
+static const char *parse_pack_header(struct pack_header *hdr, int pack_fd)
+{
+	switch (read_pack_header(pack_fd, hdr)) {
+	case PH_ERROR_EOF:
+		return "eof before pack header was fully read";
+
+	case PH_ERROR_PACK_SIGNATURE:
+		return "protocol error (pack signature mismatch detected)";
+
+	case PH_ERROR_PROTOCOL:
+		return "protocol error (pack version unsupported)";
+
+	default:
+		return "unknown error in parse_pack_header";
+
+	case 0:
+		return NULL;
+	}
+}
+
+static void push_header_arg(struct strvec *args, struct pack_header *hdr)
+{
+	strvec_pushf(args, "--pack_header=%"PRIu32",%"PRIu32,
+		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
+}
+
+static int odb_transaction_files_write_pack(struct odb_transaction *base,
+					    int pack_fd, struct strbuf *err_msg,
+					    const struct odb_transaction_write_pack_opts *opts)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+	struct repository *repo = base->source->odb->repo;
+	struct child_process child = CHILD_PROCESS_INIT;
+	struct pack_header hdr;
+	const char *hdr_err;
+	int err_fd = opts->err_fd;
+	int status;
+
+	hdr_err = parse_pack_header(&hdr, pack_fd);
+	if (hdr_err) {
+		if (err_fd > 0)
+			close(err_fd);
+		strbuf_addstr(err_msg, hdr_err);
+		return -1;
+	}
+
+	if (opts->shallow_file) {
+		strvec_push(&child.args, "--shallow-file");
+		strvec_push(&child.args, opts->shallow_file);
+	}
+
+	odb_transaction_env(base, &child.env);
+
+	if (ntohl(hdr.hdr_entries) < (unsigned int)opts->unpack_limit) {
+		strvec_push(&child.args, "unpack-objects");
+		push_header_arg(&child.args, &hdr);
+		if (opts->quiet)
+			strvec_push(&child.args, "-q");
+		if (opts->fsck_objects)
+			strvec_pushf(&child.args, "--strict%s",
+				     opts->fsck_msg_types);
+		if (opts->max_input_size)
+			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				     (uintmax_t)opts->max_input_size);
+		child.no_stdout = 1;
+		child.in = pack_fd;
+		child.err = err_fd;
+		child.git_cmd = 1;
+		status = run_command(&child);
+		if (status) {
+			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
+			return -1;
+		}
+	} else {
+		char hostname[HOST_NAME_MAX + 1];
+		char *lockfile;
+
+		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
+		push_header_arg(&child.args, &hdr);
+
+		if (xgethostname(hostname, sizeof(hostname)))
+			xsnprintf(hostname, sizeof(hostname), "localhost");
+		strvec_pushf(&child.args,
+			     "--keep=receive-pack %"PRIuMAX" on %s",
+			     (uintmax_t)getpid(),
+			     hostname);
+
+		if (!opts->quiet && err_fd)
+			strvec_push(&child.args, "--show-resolving-progress");
+		if (err_fd)
+			strvec_push(&child.args, "--report-end-of-input");
+		if (opts->fsck_objects)
+			strvec_pushf(&child.args, "--strict%s",
+				     opts->fsck_msg_types);
+		if (!opts->reject_thin)
+			strvec_push(&child.args, "--fix-thin");
+		if (opts->max_input_size)
+			strvec_pushf(&child.args, "--max-input-size=%"PRIuMAX,
+				     (uintmax_t)opts->max_input_size);
+		child.out = -1;
+		child.in = pack_fd;
+		child.err = err_fd;
+		child.git_cmd = 1;
+		status = start_command(&child);
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack fork failed");
+			return -1;
+		}
+
+		lockfile = index_pack_lockfile(repo, child.out, NULL);
+		if (lockfile) {
+			ALLOC_GROW(transaction->pack_lockfiles,
+				   transaction->pack_lockfiles_nr + 1,
+				   transaction->pack_lockfiles_alloc);
+			transaction->pack_lockfiles[transaction->pack_lockfiles_nr++] =
+				register_tempfile(lockfile);
+			free(lockfile);
+		}
+		close(child.out);
+
+		status = finish_command(&child);
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack abnormal exit");
+			return -1;
+		}
+		odb_reprepare(repo->objects);
+	}
+
+	return 0;
+}
+
+static void odb_transaction_files_release(struct odb_transaction *base)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+
+	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
+		delete_tempfile(&transaction->pack_lockfiles[i]);
+	free(transaction->pack_lockfiles);
+}
+
 static int odb_transaction_files_env(struct odb_transaction *base,
 				     struct strvec *env)
 {
@@ -1315,7 +1462,9 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
+	transaction->base.release = odb_transaction_files_release;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.write_pack = odb_transaction_files_write_pack;
 	transaction->base.env = odb_transaction_files_env;
 
 	transaction->prefix = "bulk-fsync";
diff --git a/odb/transaction.c b/odb/transaction.c
index ce1e24f3ed..de03116ca0 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -55,6 +55,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 	return transaction->write_object_stream(transaction, stream, len, oid);
 }
 
+int odb_transaction_write_pack(struct odb_transaction *transaction, int pack_fd,
+			       struct strbuf *err_msg,
+			       const struct odb_transaction_write_pack_opts *opts)
+{
+	return transaction->write_pack(transaction, pack_fd, err_msg, opts);
+}
+
 int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env)
 {
 	if (!transaction)
diff --git a/odb/transaction.h b/odb/transaction.h
index ec0b27c449..491026e815 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -4,6 +4,51 @@
 #include "gettext.h"
 #include "odb.h"
 
+/*
+ * Options controlling how odb_transaction_write_pack() ingests a packfile.
+ */
+struct odb_transaction_write_pack_opts {
+	/*
+	 * Optional fsck severity configuration to apply when incoming objects
+	 * are verified.
+	 */
+	const char *fsck_msg_types;
+	/*
+	 * Path to an alternative shallow file describing the shallow boundaries
+	 * to honor while ingesting the pack.
+	 */
+	const char *shallow_file;
+	/*
+	 * The max size in bytes of the incoming packfile allowed. No limit is
+	 * enforced when set to 0.
+	 */
+	off_t max_input_size;
+	/*
+	 * Whether the validity of incoming objects should be verified.
+	 */
+	int fsck_objects;
+	/*
+	 * The threshold for the number of incoming objects required to store
+	 * the objects in a packfile. This option may not be relevant to
+	 * backends that do not store obejcts in loose/packed formats and can be
+	 * ignored.
+	 */
+	int unpack_limit;
+	/*
+	 * Whether to reject an incoming packfile if it is "thin".
+	 */
+	int reject_thin;
+	/*
+	 * Optional file descriptor for reporting progress and errors. Set to 0
+	 * for none.
+	 */
+	int err_fd;
+	/*
+	 * Suppresses progress reporting.
+	 */
+	int quiet;
+};
+
 /*
  * A transaction may be started for an object database prior to writing new
  * objects via odb_transaction_begin(). These objects are not committed until
@@ -40,6 +85,15 @@ struct odb_transaction {
 	int (*write_object_stream)(struct odb_transaction *transaction,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+	/*
+	 * This callback is expected to ingest the packfile readable via
+	 * `pack_fd` into the transaction. Returns 0 on success, a negative
+	 * error code otherwise. On failure, a human-readable description is
+	 * appended to `err_msg`.
+	 */
+	int (*write_pack)(struct odb_transaction *transaction, int pack_fd,
+			  struct strbuf *err_msg,
+			  const struct odb_transaction_write_pack_opts *opts);
 
 	/*
 	 * This callback is expected to populate the provided strvec with the
@@ -98,6 +152,15 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
 					size_t len, struct object_id *oid);
 
+/*
+ * Ingests the packfile readable via `pack_fd` into the transaction. Returns 0
+ * on success, a negative error code otherwise. On failure, a human-readable
+ * description is appended to `err_msg`.
+ */
+int odb_transaction_write_pack(struct odb_transaction *transaction, int pack_fd,
+			       struct strbuf *err_msg,
+			       const struct odb_transaction_write_pack_opts *opts);
+
 /*
  * Populates the provided strvec with the environment variables that a child
  * process should inherit so that its object writes participate in the
-- 
2.55.0.424.g13c7afec21

