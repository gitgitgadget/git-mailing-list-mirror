Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6702D839C
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269794; cv=none; b=eFPUXqR7dVIHfGbtbGzuq++tHj2qntZxKufy8a6xJZeVkUSr7O8NTYNoALiShFxHBw54AfFepJjnkI1Yq6VvHjY/P/GLM2yWMmZu7xhfTpsMKLjNwM4v51bqJc4sghihRUGLJsbRxBYRCPqOo5UPPs1NDKpfSlOzoXiEsMtShpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269794; c=relaxed/simple;
	bh=wga2D4It5Yk/hOj/AtpMHdCm/khtKdRLTgR1kpXUv5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST1OSW+RxM+tFfSkJLo9BlezM9DoBN02IDzIF/NAWtOKeY9Y5rhkIzRCjp8SoT1DbPyDCLFeSiAPQEGLLXSHyJpxcIUhem1Ih3G4wH0qLj96EEBJ6j2DXYuLxWlM5g+oIz8qbtYqwAsl0CHuSrvgFRl2/fxxSS1jDkY6fqUfTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVNUQ/Qc; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVNUQ/Qc"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-45eb688c891so146289fac.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269791; x=1787874591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9m28gYC6LbiCSlKCARwDj5jY+j3c1AgDBKABjyx2eNA=;
        b=eVNUQ/Qc+rcB16QaVkFIrdhFqtcrbMnHyCtcHqL2vPhNa2ilVkm9uPOeOVsvZdcput
         D56WdVLLCtNkhJ7a2AJ5k81gYjJ0TPqwVdsfcAq8tYAquxad5v/O8TB8A/IXOxFqHcZC
         tKLYM20XX2eGUcVmw9/36JlGr0HSu4PAIY0VJTpVx2lea83xRLvnYybpDGahVH2qLvMW
         jZi0m0ChKgC68os/8fP8Eurmgmen29q8jV3XMyC3quri/hfdch/Ap9XD6bxMKvm3WEDT
         cC0rWtsw3MS6siIOtWTRlrnzQ2zvZkAcqOaDvCtj4UM0vdYOqygg98Ry3r/CoxdZT5Ha
         61vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269791; x=1787874591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9m28gYC6LbiCSlKCARwDj5jY+j3c1AgDBKABjyx2eNA=;
        b=eohhGWAEMdJHHWGJTgrDyemEq2amhLBBbHCTMpzGsu5dX+GFfeid4X/TM8MuLGDhaw
         yNRLB59KiBZ4szfEzsutQZ93FODnjP9NbWaSL3KhKWUCR0nRngt5Soouhq0yPFduDmRw
         rMghXFHH0xy4xdZq/h1HBL4jrw6sUzVIKEbDjW1snR212V3o1CEVOWMbvi+4VSlQ65zL
         ZA1BSU4wyQy80RqA7YPxa1U6DWfUtNfBabMHSdxyp5mdMOJrfXSnV5gV6UJEfBjomaNN
         5jL1Fr+VSs6n2+KrVlNfDomsQGf/nGdemknK3ZAAii9nWDz66J6Bxmrh0/CZJfKicBqT
         BTfg==
X-Gm-Message-State: AFuF++nqLlN/TmpOdXmojubRB0gCBpHhMG+m1xEujg2Cj44yZ01sdi9Z
	bDmcgeTjYiKwNXxeW63LI2qze8kGK2qfQQdmG3aKSbw6bJ9lbMTBqGwIfLIwVQ==
X-Gm-Gg: AR+sD11O9vx7dIjYQbm4lmNG2WI6MroGGLPy9gHwjNk8l9N+CdGvb/8hqhdRso+MWAU
	EzCyQ+G6QMS3rJiXbU8AfPuttn3G3dkHKVz8Dz3VFOx7lWZ+YrpZ8fDNkyEFF5gDR6Y+KCFUPv4
	KUt94my+qiFvlb3v9ezuIkZiSkSIdWP2MjVxhu5sa0NcISGDkVnmH9CO9bu/lY3LkdqeDTUQRBS
	2/eKdwaMjKsPDfL9/0mQMxQozZPsgbB3hn0C2hPcSIsBdZUYkUtvGnI4pq142IZo1ztI5M7ISgL
	boOOjFqQSqV8/Qb8EnZK8Zoz0CLHh8QgDDxK6hEoLF74G1cRYrTF0iyORxecsMOMbSFwX4hMIaD
	EWbcCl+707OnAsKHKlqMvizkGLmDzNZp3Wf3cLrnhc3dW8twl1Py3+EmYTRTCLt6eQ/tvHQO/9Q
	h5WssclwtHu8En4oHehJdzPi4OU0xVIPRJrIyis/Lu/T1NqZpy0nlcyB0DGIL9jVCbl0QU
X-Received: by 2002:a05:6870:c2ad:b0:463:3935:9c30 with SMTP id 586e51a60fabf-4635149e73dmr2060706fac.18.1787269790865;
        Thu, 20 Aug 2026 16:49:50 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:50 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 6/9] builtin/receive-pack: report unpack errors via strbuf
Date: Thu, 20 Aug 2026 18:49:37 -0500
Message-ID: <20260820234940.894624-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing packfiles via `unpack()`, error messages are returned
directly by the function. In preparation for `unpack()` logic being
moved behind a generic ODB transaction interface, update the function to
instead write any error messages to a caller provided strbuf and return
a negative value on error. Call sites are updated to use the error
strbuf accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 63 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f062b93b8d..6df872697b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2015,7 +2015,7 @@ static void execute_commands_atomic(struct command *commands,
 }
 
 static void execute_commands(struct command *commands,
-			     const char *unpacker_error,
+			     int unpacker_error,
 			     struct shallow_info *si,
 			     struct odb_transaction *transaction,
 			     const struct string_list *push_options)
@@ -2340,8 +2340,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static const char *unpack(struct odb_transaction *transaction,
-			  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
+		  const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2353,7 +2353,8 @@ static const char *unpack(struct odb_transaction *transaction,
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
-		return hdr_err;
+		strbuf_addstr(err_msg, hdr_err);
+		return -1;
 	}
 
 	if (opts->shallow_file) {
@@ -2378,8 +2379,10 @@ static const char *unpack(struct odb_transaction *transaction,
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = run_command(&child);
-		if (status)
-			return "unpack-objects abnormal exit";
+		if (status) {
+			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
+			return -1;
+		}
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
 		char *lockfile;
@@ -2410,8 +2413,10 @@ static const char *unpack(struct odb_transaction *transaction,
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
-		if (status)
-			return "index-pack fork failed";
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack fork failed");
+			return -1;
+		}
 
 		/*
 		 * The lockfile filepath is expected to be the final location of
@@ -2427,15 +2432,18 @@ static const char *unpack(struct odb_transaction *transaction,
 		close(child.out);
 
 		status = finish_command(&child);
-		if (status)
-			return "index-pack abnormal exit";
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack abnormal exit");
+			return -1;
+		}
 		odb_reprepare(the_repository->objects);
 	}
-	return NULL;
+	return 0;
 }
 
-static const char *unpack_with_sideband(struct odb_transaction *transaction,
-					const char *shallow_file)
+static int unpack_with_sideband(struct odb_transaction *transaction,
+				const char *shallow_file,
+				struct strbuf *err_msg)
 {
 	struct unpack_opts opts = {
 		.fsck_objects = (receive_fsck_objects >= 0
@@ -2450,20 +2458,20 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
 		.quiet = quiet,
 	};
 	struct async muxer;
-	const char *ret;
+	int ret;
 
 	if (!use_sideband)
-		return unpack(transaction, &opts);
+		return unpack(transaction, err_msg, &opts);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
 	muxer.proc = copy_to_sideband;
 	muxer.in = -1;
 	if (start_async(&muxer))
-		return NULL;
+		return 0;
 
 	opts.err_fd = muxer.in;
-	ret = unpack(transaction, &opts);
+	ret = unpack(transaction, err_msg, &opts);
 
 	finish_async(&muxer);
 	return ret;
@@ -2552,13 +2560,13 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+static void report(struct command *commands, const struct strbuf *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 
 	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
+			 unpack_status->len ? unpack_status->buf : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
 			packet_buf_write(&buf, "ok %s\n",
@@ -2576,14 +2584,14 @@ static void report(struct command *commands, const char *unpack_status)
 	strbuf_release(&buf);
 }
 
-static void report_v2(struct command *commands, const char *unpack_status)
+static void report_v2(struct command *commands, const struct strbuf *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref_push_report *report;
 
 	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
+			 unpack_status->len ? unpack_status->buf : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		int count = 0;
 
@@ -2707,8 +2715,8 @@ int cmd_receive_pack(int argc,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if ((commands = read_head_info(&reader, &shallow))) {
-		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
+		struct strbuf unpack_status = STRBUF_INIT;
 
 		if (use_push_options)
 			read_push_options(&reader, &push_options);
@@ -2728,22 +2736,22 @@ int cmd_receive_pack(int argc,
 				alt_shallow_file = setup_temporary_shallow(si.shallow);
 
 			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
-				unpack_status = "unable to start object transaction";
+				strbuf_addstr(&unpack_status, "unable to start object transaction");
 			else
-				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
+				unpack_with_sideband(transaction, alt_shallow_file, &unpack_status);
 
 			update_shallow_info(commands, &si, &ref, alt_shallow_file);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
-		execute_commands(commands, unpack_status, &si, transaction,
+		execute_commands(commands, !!unpack_status.len, &si, transaction,
 				 &push_options);
 		odb_transaction_finalize(transaction);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
-			report_v2(commands, unpack_status);
+			report_v2(commands, &unpack_status);
 		else if (report_status)
-			report(commands, unpack_status);
+			report(commands, &unpack_status);
 		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);
@@ -2768,6 +2776,7 @@ int cmd_receive_pack(int argc,
 		if (auto_update_server_info)
 			update_server_info(the_repository, 0);
 		clear_shallow_info(&si);
+		strbuf_release(&unpack_status);
 	}
 	if (use_sideband)
 		packet_flush(1);
-- 
2.55.0.424.g13c7afec21

