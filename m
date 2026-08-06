Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72F376A04
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052351; cv=none; b=lioEO5aLK93MlfgSOe0NeS0CsyyEloeYy8LFB7WprqZMLYTEzVyf7K+4/WX3rEZmv3PwnwtCvkC8EV04Euz19kV39wh080SGRPuilkA6ztswxFDLT6YfCjiiDGIUgZvkxzr2YGOtUmXx5hzITfyBX6tEo7UVA5YF/RsrKbr9rS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052351; c=relaxed/simple;
	bh=LVx8LeAc8lm8R0iy43wXxe0cqVCKyJ0NO/x25xBzWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tikDT+UotpivEbXcCXYXc9vjNJYpO6rIK802Z8BoBB5+0vP7trSX2uYKGb7gcVBnA0itwRGgI/V0RKLvH/apbSAU2PovCm1ny1f9cOgNIsPlLAOGHLFoi34dFeVsef7QJpgbf1Cmp9QwddHwH0mSEdAgYHZRIpHp2UfLJUOFgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxRxMvyX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxRxMvyX"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7ee37dc91f5so1778807a34.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786052347; x=1786657147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l23ZwgT33CqxWTfSO8iFFA6V03Bvl4LSidgYg+M0Cao=;
        b=gxRxMvyXnw64512EVWHzPzbpHVZKkO4pS8buClAqsBBxWOuMqUCp1M6Nn9UJ9MGkYF
         ArSr0VagJVUcQoE+VE/cdax1dtXxa6/D6eEp9nDKocTzQBxWgIOq924bVr0czujb0o6C
         ap3WHz2AB0V6xs9Ndo4cijFq2zha2Esrmu7UBeuSUIIASRhd1ROzUrTdFjHttZE5+y3Z
         LfS3HuXFLiPRmXoF+3XBqCk3xZxJkQsxtMgrRQB+0wleXSzkFmsO5J4TJ/IfkhhYmk+X
         CKEz9PKvUnG1KYJcMjsjbiwvi93EghHRI+z5Jmss0k8tdVMNnilhbzUZoDJYiGovqeBw
         LGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786052347; x=1786657147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l23ZwgT33CqxWTfSO8iFFA6V03Bvl4LSidgYg+M0Cao=;
        b=FsFap0JHtuA+tj7ZLMxY9gtBxuGD+ChyXdRepkBS0kdVHKu+vmj/5Qx1r3l5MEKmdO
         2OUh2shdJ8fTnwbJEo+8Mwf8jMKstdwLgLeRll2j1FiyG08vnScxMnGN1QpImBW7BCX0
         e4asEpsmBW+bDn0qhoQLtSGLbFZFQVV/1bgTi71Ohpei6ioLvu5eqBYCI66JkptB0K3X
         1IcalwD1iyWINtQqHzNmUCl6DTYfsOnkH5qnXx+jKPNPXdRO24jmsnXJ6isRKoE973FU
         59XwDqzYwUIy7ofjEOtqfMNfUCKx0k1hUREqxTXQ/5ILOV5j+Jv3oyvcMVWOTw0CCysV
         4lGQ==
X-Gm-Message-State: AOJu0YyF8E7o8THeo4X9s5kKSmqu4OSJf0toLU60gtUDnbRoCgO9icRx
	zZUOjTyOMO00k1fARFzz6X1FOfX6VtWopU5XuaWNX0duOzL7IPxk9336BUFflA==
X-Gm-Gg: AR+sD13TD2ZtW1WBBus3Tk8lFUFcm0smPgl6EBFP+cFvd02bmV8zMTDEZ1t0wxKUncF
	tY76NSy0OpBU8ve+OJRLVwPdRHuPZqA/1BcbUcbPIhcVOTvlAfBf767wmKhWkYs5NreN7+kwmkZ
	8pb3++M+FeWkw5FgBo7brlLrsN5GHpm2++4Rhrd4hCHC2flO1in1BmebuLNJoLYnlkNoF63m1xW
	vz6/0wuXVkwOHsQZU9a1tXhbkO8y1bC5QEpnGi64vMzBFN4Xl/axQUvIJOwfZaizPIzLbKbh55+
	GWi8Vrblz0jYBoI1TzeZJ4ANgDN8oDdyh5vsyawbxVw8skG7ohPKHMPre+LsTPXcugiuHlpHlxy
	sBGtq2N2TJup3m5oXwnlrV5Srg2vb3q910qEurzb6s0b0YsMQL5M/VrEr9vPIueF4o0n4OPmLvo
	UU+X9nI4k9KNXZ1v5Sbyzgc+S5vdpGi4+ZXJ/lq24jIGc3QK2LOQYUkL3T5zssnvRlrvud
X-Received: by 2002:a05:6820:2909:b0:6ae:8ee4:e01f with SMTP id 006d021491bc7-6ae96c1003amr9244874eaf.4.1786052346988;
        Thu, 06 Aug 2026 14:39:06 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02be475b6sm587078eaf.11.2026.08.06.14.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:39:06 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/6] builtin/receive-pack: report unpack errors via strbuf
Date: Thu,  6 Aug 2026 16:38:57 -0500
Message-ID: <20260806213859.816157-5-jltobler@gmail.com>
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
index 8c2d6e5789..7635b82bd3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2028,7 +2028,7 @@ static void execute_commands_atomic(struct command *commands,
 }
 
 static void execute_commands(struct command *commands,
-			     const char *unpacker_error,
+			     int unpacker_error,
 			     struct shallow_info *si,
 			     struct odb_transaction *transaction,
 			     const struct string_list *push_options)
@@ -2344,8 +2344,8 @@ struct unpack_opts {
 	int quiet;
 };
 
-static const char *unpack(struct odb_transaction *transaction,
-			  const struct unpack_opts *opts)
+static int unpack(struct odb_transaction *transaction, struct strbuf *err_msg,
+		  const struct unpack_opts *opts)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2357,7 +2357,8 @@ static const char *unpack(struct odb_transaction *transaction,
 	if (hdr_err) {
 		if (err_fd > 0)
 			close(err_fd);
-		return hdr_err;
+		strbuf_addstr(err_msg, hdr_err);
+		return -1;
 	}
 
 	if (opts->shallow_file) {
@@ -2382,8 +2383,10 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2414,8 +2417,10 @@ static const char *unpack(struct odb_transaction *transaction,
 		child.err = err_fd;
 		child.git_cmd = 1;
 		status = start_command(&child);
-		if (status)
-			return "index-pack fork failed";
+		if (status) {
+			strbuf_addstr(err_msg, "index-pack fork failed");
+			return -1;
+		}
 
 		lockfile = index_pack_lockfile(the_repository, child.out, NULL);
 		if (lockfile) {
@@ -2425,15 +2430,18 @@ static const char *unpack(struct odb_transaction *transaction,
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
@@ -2449,20 +2457,20 @@ static const char *unpack_with_sideband(struct odb_transaction *transaction,
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
@@ -2551,13 +2559,13 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
-static void report(struct command *commands, const char *unpack_status)
+static void report(struct command *commands, struct strbuf *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 
 	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
+			 unpack_status->len ? unpack_status->buf : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
 			packet_buf_write(&buf, "ok %s\n",
@@ -2575,14 +2583,14 @@ static void report(struct command *commands, const char *unpack_status)
 	strbuf_release(&buf);
 }
 
-static void report_v2(struct command *commands, const char *unpack_status)
+static void report_v2(struct command *commands, struct strbuf *unpack_status)
 {
 	struct command *cmd;
 	struct strbuf buf = STRBUF_INIT;
 	struct ref_push_report *report;
 
 	packet_buf_write(&buf, "unpack %s\n",
-			 unpack_status ? unpack_status : "ok");
+			 unpack_status->len ? unpack_status->buf : "ok");
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		int count = 0;
 
@@ -2711,8 +2719,8 @@ int cmd_receive_pack(int argc,
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
 	if ((commands = read_head_info(&reader, &shallow))) {
-		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
+		struct strbuf unpack_status = STRBUF_INIT;
 
 		if (use_push_options)
 			read_push_options(&reader, &push_options);
@@ -2732,22 +2740,22 @@ int cmd_receive_pack(int argc,
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
 		odb_transaction_release(transaction);
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
@@ -2772,6 +2780,7 @@ int cmd_receive_pack(int argc,
 		if (auto_update_server_info)
 			update_server_info(the_repository, 0);
 		clear_shallow_info(&si);
+		strbuf_release(&unpack_status);
 	}
 	if (use_sideband)
 		packet_flush(1);
-- 
2.55.0.424.g13c7afec21

