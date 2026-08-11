Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E437268D
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470872; cv=none; b=gIrpCRZc1Qkv8fl/KBSro396u6aI/wfKXpOLvpVk5isO5DGcU54crx+oE4aUY7lx0w/cWWhO8ZBaykgAPCTJSVCh6To89aGdkaosNnE3ML6PappLKcwGMrduS2+XQIVDB1iA12ocV+8NPm1PsWOv+0/wTQDwC8n0UjoNazBQvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470872; c=relaxed/simple;
	bh=wga2D4It5Yk/hOj/AtpMHdCm/khtKdRLTgR1kpXUv5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdJqhIWLKLtkNrZDRUdfDWgzvMH17lBpNIBDDXg8hWzdxGKQCgF6+2cN4uUdF7334/XyjDxG7Bi+xyiCNljNizEo3rC7Xhzu6CwWDwNc7oFTQFbfTS25dJyjo4jOmiksEoFIgag0WTKqPyU38MrUiPflAcNId8O8K46ugKypNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT6L8z4V; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT6L8z4V"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a451915d8aso73077b6e.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786470870; x=1787075670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9m28gYC6LbiCSlKCARwDj5jY+j3c1AgDBKABjyx2eNA=;
        b=XT6L8z4V+Eig6lEGqJKu2zvumDU/8bQqVxatzqa2tEj50KZYSnJYRp9ZVRXQ7Mp/uQ
         bTMM1H00yXxVvCWNky2NaqyVGJzsgRC6BiKsxw7+HYC6ttNlWlXz4z6OYAZSdpQ3220L
         oUSH9m/zHj7Cma3g/++smgEheFkJlKsrBIh8698YaWclPCveuwU+zroSV4ebrUz/yG3t
         Yp1Hz6GkjoZFfAkMswn+Vyhgo7WHlptzqdI4kOowkZ8CsnAXJUaSQyBM7loFBCTYMAhp
         0n0Nc+75JWJnOtaa8UISGpWEfF919IBE2UagLROiNc88bNd7OPTVLj+VRQkxktbNq0rs
         7k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786470870; x=1787075670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9m28gYC6LbiCSlKCARwDj5jY+j3c1AgDBKABjyx2eNA=;
        b=np9G+JXvzno4f9n+CY8q34voB0sS5jR6umHrEp4+/U2INJOqDIGqiwTy4kPINheWP0
         wyC1+JDcR027onS714H7L9LtR1sLf2t/S0J7PxxALXkI9uBZgMBpi0AU15yFHGIXWNb2
         +jnrVw4+JiY6COPbnFWQhyUKmAUqjZyZSeSXvxmrctnHrF+2jDzC7j7yCQCUV+hQ/oVt
         SvI6UNmlZizV0uKlmBJ68X+Pl3mMqFaeI3Pr9Isr/jyCyIu+srFlVmLeNsnen0tjRt//
         TczCj4GSZhXBZducKD+aX5r2MuC3njCRe9H72ZS8GrciipD/R4p+vof0OQNCIJaaTNlg
         KkQA==
X-Gm-Message-State: AOJu0YxPDCl2OBc7f8A9Fj+86iXWWlC16F1thJq0Nhydewa+AloEbir2
	vmGXJw9EbsxnJsTbhCz+CDTgAVeuqoIoQdi/hYplkrJQlCpPV9LPwx1BaN062A==
X-Gm-Gg: AR+sD131E6FXDAfcO6TpbGf2W9zSt1RrCP+RQ26JGCpCfUqq1MWOBvbnKJfbaSsu04L
	P/1rcj++q8TH9bG3JEjuekQwdSjnbZ+dUGYvG+IRgLSUyDlaAk0Ufz4e7F1fUAy1eSCFaG4ybga
	u7UtXxdmhBY4GQN3Jx9zdwuK8lfmzcED5kaTlsQPRXSKyQ59B9H9WeGi1z3K57xtVwWvBsjW+hq
	qLlPoPq5vTED0SNRK3cH9GC3+r1Gkm7KM/KDDCbPO5MX0ooE0q0xLLlYSsUQEdHAfmdows0Y0BC
	skyCBnvDEVAyEhktQFFJNa1CT2E386R9Gom/v2+ZORGF6rwkw+uGaFrtqTdzyyS4iaHDsSpk2oz
	W0eZdFyGOgkXa6a1gVRiISJm4IYN7ata1MR3b/zTANkufDlF7JVlD78uoBXeWs4RJLypYCvI3zR
	LusH1HU8GmdKD9D4hjl2hLUKxMyLQaJPn9Nk8cZmG4k1GW3dcc2AABQkoLdBDCJxwV+LFdp+TKW
	BlFBCSq
X-Received: by 2002:a05:6808:308e:b0:4af:57e9:4ec6 with SMTP id 5614622812f47-4b1fd831fbamr3999273b6e.15.1786470870147;
        Tue, 11 Aug 2026 10:54:30 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2001331d2sm1241489b6e.11.2026.08.11.10.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:54:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 6/9] builtin/receive-pack: report unpack errors via strbuf
Date: Tue, 11 Aug 2026 12:54:12 -0500
Message-ID: <20260811175415.2044235-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260811175415.2044235-1-jltobler@gmail.com>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
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

