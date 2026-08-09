Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2082882C5
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786302085; cv=none; b=tIFbGfSuGXuHHBNVm2x47ebIb/LPJ0ERV+FrE2PeaURNnmBY+9XNDaiUU2TaKhH/iyYOSi1ElFTlqKZLdM5D1ls6IuB/RbY8eLztv8gwicQ9/bhy4gSiiOSzSoVchgU2vZBBn7yobVb3hyTX/ZQniRSVjzkfUQTjU7F9hph6uPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786302085; c=relaxed/simple;
	bh=w+DDq11YBcGpxcMwufUt6qLkxelqCHY8bhboZZqkzdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOX/1D5AX1cPX7OeGBlB9cgsn8HF84neN9YOpYg9occH+5YOn85sOHy7kMTtzoquNFVW6P710ouSkEF5li+MZY0YpVgsZF/wBM2xdhstB37+LOgK8qViBjKm/xFp4DJO2T+g5+VkGwJkSCand6/flAhkhWfFKYKfpU6cCRJeaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgwR+oeW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgwR+oeW"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb64085c45so950369a34.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786302078; x=1786906878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L69kxm/n7L9fmjHZLDQI03Dl3wMLvv2mWHi7cAsIiGo=;
        b=DgwR+oeWGZFCNi87/dVxY6p0fgOZAagEh0cDEGVvPtau1siUjqYXKms0NLsCmnS/r/
         gIah4Y4tSJ1kGrNrDOOkmSCsA51wIYsxgDM5l7xw+LHdynDyCAMwsTxP8ghY8/ZpRa5j
         8lfAeryrQkW2HTjxl2hwGWtLJfySSKo43QZDhvna2uyITkhwy2M34hlRBeQFmxehtNHS
         TZq67o6WMHPlrBixYmSw0thAn3trmIGjUfqkDXIbdXa9t5Nz89enWDxUaxZXMEeQpcc9
         5M1REfyNV492lCBsAyjxz7FR8OEIPVRqt/vjL0yu/wX2Z+X5voOHYFEbD2pG1SczIXvM
         6xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786302078; x=1786906878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L69kxm/n7L9fmjHZLDQI03Dl3wMLvv2mWHi7cAsIiGo=;
        b=Oa2oqinATWmNLblUv1hH2FuVS2mhzG6clASVSZ/gcLq6KckTy5YVxR/UMPcTW9vAbT
         dXJAgyMuzss9meEEFIJ1mTBIrYpMRZ/3fWEEvnGXJc4/Bdkt7FefBCIqqY7FsEVpecg0
         HniHkH9lm+twSsLja3B+7RxwJfmV9abM7gsJ4If8m5vIUs7J++6W4m+qNNPur9Eaqlni
         Saq9i5BN6Lgs9Pw1KQatIFxiom+vSSwIn/jAHGTg31AW8IgRcU7Z8qQxCR9X0PG9ENoX
         IOLuRHOwwyeB4nXkZIlY2T+tc7dZQwm2TiQq+6taji9MnHyE8OpAowAIp0XGKwZclhrV
         WGbQ==
X-Gm-Message-State: AOJu0YzfaQvmyBaJjnZ3Wh+HBlasZXujYWTuD51ZmRCqBBXgl93w7z9i
	rc5nD8NRSwqqyCzAr4nxhZhwJLko7GqdvuXC388px6zLEP7CppwLF3H4LrM7IQ==
X-Gm-Gg: AR+sD12ToZVruMoBHSZWoBhYdjjpuKn/BvPu87QppYHie2/OA+vC9AZX1khbJPI5hns
	Y7ZBVh0yE3b4H4WOija4bxyD+0j+sJSdnA1nAfuE++dD9N3OfByxfYFXxky6W6ZAWobd7/KMXzZ
	qGijBZfOBvwvqSVM/Brrw+nez9UoFQkNCwziNLHEh6OE7WvevsJ7NfQ36QDs5l7j/iiPnFGh8Y4
	mUI+T3uRTQAkNxUoMT8yMHVqdsSs2UJT3IA5jv/U0N7IHie/8TVf2gMZLrLzgEVc29HIsoygr3v
	2Uykz0NaXjZcEyyEl//uokbPal4VcrAGzOLR11qL6C/+hZc79gymFaX4g4mbaxDrtEGheWS+mO6
	+06kuGPXnPVniXC1oqbFJxkTosTtO5CuCY65uwdWWFDI6bdKgNrMnzt8Etcu3AgzRlARwjp6HqR
	/O8qteT9/aIXKqa2xTDkj84tl17zSSZL5t54sJvmPbPPgUNPUl8YzExW+cLQKkf9icu3J/
X-Received: by 2002:a05:6808:6f88:b0:495:fa73:2e44 with SMTP id 5614622812f47-4b1ab9fe7eamr9084735b6e.15.1786302077835;
        Sun, 09 Aug 2026 12:01:17 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af5e7b77sm4872188b6e.10.2026.08.09.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:01:17 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 7/7] odb/transaction: add transaction interface to write packfiles
Date: Sun,  9 Aug 2026 14:01:06 -0500
Message-ID: <20260809190106.1565882-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260809190106.1565882-1-jltobler@gmail.com>
References: <20260806213859.816157-1-jltobler@gmail.com>
 <20260809190106.1565882-1-jltobler@gmail.com>
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
 builtin/receive-pack.c | 168 +-------------------------------------
 object-file.c          | 180 +++++++++++++++++++++++++++++++++++++++++
 odb/transaction.c      |   7 ++
 odb/transaction.h      |  63 +++++++++++++++
 4 files changed, 253 insertions(+), 165 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 76e8f4216c..e6e54ba55f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -15,7 +15,6 @@
 #include "gpg-interface.h"
 #include "hex.h"
 #include "hook.h"
-#include "lockfile.h"
 #include "object.h"
 #include "object-file.h"
 #include "object-name.h"
@@ -23,7 +22,6 @@
 #include "oid-array.h"
 #include "oidset.h"
 #include "pack.h"
-#include "packfile.h"
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "protocol.h"
@@ -2292,170 +2290,11 @@ static void read_push_options(struct packet_reader *reader,
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
-static int get_unpack_limit(struct repository *repo)
-{
-	static int limit = -1;
-
-	if (limit < 0) {
-		int receive_limit = -1;
-		int transfer_limit = -1;
-
-		repo_config_get_int(repo, "receive.unpacklimit",
-				    &receive_limit);
-		repo_config_get_int(repo, "transfer.unpacklimit",
-				    &transfer_limit);
-
-		if (receive_limit >= 0)
-			limit = receive_limit;
-		else if (transfer_limit >= 0)
-			limit = transfer_limit;
-		else
-			limit = 100;
-	}
-
-	return limit;
-}
-
-struct unpack_opts {
-	const char *fsck_msg_types;
-	const char *shallow_file;
-	off_t max_input_size;
-	int fsck_objects;
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
-	if (ntohl(hdr.hdr_entries) < get_unpack_limit(the_repository)) {
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
@@ -2471,7 +2310,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, 0, err_msg, &opts);
+		return odb_transaction_write_pack(transaction, 0, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2481,7 +2320,7 @@ static int unpack_with_sideband(struct odb_transaction *transaction,
 		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, 0, err_msg, &opts);
+	ret = odb_transaction_write_pack(transaction, 0, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
@@ -2756,7 +2595,6 @@ int cmd_receive_pack(int argc,
 		execute_commands(commands, !!unpack_status.len, &si, transaction,
 				 &push_options);
 		odb_transaction_finalize(transaction);
-		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
 			report_v2(commands, &unpack_status);
diff --git a/object-file.c b/object-file.c
index f993d58056..424f5f148c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -10,6 +10,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "config.h"
 #include "convert.h"
 #include "dir.h"
 #include "environment.h"
@@ -26,6 +27,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
+#include "run-command.h"
 #include "setup.h"
 #include "strvec.h"
 #include "tempfile.h"
@@ -487,6 +489,10 @@ struct odb_transaction_files {
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
 	const char *prefix;
+
+	struct tempfile **pack_lockfiles;
+	size_t pack_lockfiles_nr;
+	size_t pack_lockfiles_alloc;
 };
 
 int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -1292,6 +1298,178 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
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
+static int get_unpack_limit(struct repository *repo)
+{
+	static int limit = -1;
+
+	if (limit < 0) {
+		int receive_limit = -1;
+		int transfer_limit = -1;
+
+		repo_config_get_int(repo, "receive.unpacklimit",
+				    &receive_limit);
+		repo_config_get_int(repo, "transfer.unpacklimit",
+				    &transfer_limit);
+
+		if (receive_limit >= 0)
+			limit = receive_limit;
+		else if (transfer_limit >= 0)
+			limit = transfer_limit;
+		else
+			limit = 100;
+	}
+
+	return limit;
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
+	if (ntohl(hdr.hdr_entries) < (unsigned int)get_unpack_limit(repo)) {
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
+
+		odb_source_prepare(repo->objects->sources,
+				   ODB_PREPARE_FLUSH_CACHES);
+	}
+
+	return 0;
+}
+
+static int odb_transaction_files_finalize(struct odb_transaction *base)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+	int ret = 0;
+
+	for (size_t i = 0; i < transaction->pack_lockfiles_nr; i++)
+		ret |= delete_tempfile(&transaction->pack_lockfiles[i]);
+
+	free(transaction->pack_lockfiles);
+
+	return ret;
+}
+
 static int odb_transaction_files_env(struct odb_transaction *base,
 				     struct strvec *env)
 {
@@ -1315,7 +1493,9 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
+	transaction->base.finalize = odb_transaction_files_finalize;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.write_pack = odb_transaction_files_write_pack;
 	transaction->base.env = odb_transaction_files_env;
 
 	transaction->prefix = "bulk-fsync";
diff --git a/odb/transaction.c b/odb/transaction.c
index 9e9a982778..c9144e6cd6 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -59,6 +59,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
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
index 89f6902caf..e77807c593 100644
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
+
+	/*
+	 * Path to an alternative shallow file describing the shallow boundaries
+	 * to honor while ingesting the pack.
+	 */
+	const char *shallow_file;
+
+	/*
+	 * The max size in bytes of the incoming packfile allowed. No limit is
+	 * enforced when set to 0.
+	 */
+
+	off_t max_input_size;
+
+	/*
+	 * Whether the validity of incoming objects should be verified.
+	 */
+	int fsck_objects;
+
+	/*
+	 * Whether to reject an incoming packfile if it is "thin".
+	 */
+	int reject_thin;
+
+	/*
+	 * Optional file descriptor for reporting progress and errors. Set to 0
+	 * for none.
+	 */
+	int err_fd;
+
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
@@ -99,6 +153,15 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
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

