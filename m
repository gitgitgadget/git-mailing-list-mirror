Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E15C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B2720795
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxcEWns7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgKJMBt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJMBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 07:01:48 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1EEC0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 04:01:47 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g11so6356370pll.13
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6ZcTDTmfR5pL/aDxGslxzja+Ab+clZ5Ll+MXu9xSpg=;
        b=PxcEWns7akGbSO95k7gZ2OOIANtp7HILJk8frHfzqNsyMZKuM4LrP12+7jd6IOH/9v
         iVR1nv7jGTXIiMbeWuRlYgJp+5NEhQPk8vc1u/vKj+fMtXOiLfav61ezK8rI6YNkKpp+
         DSLoliin/aAJuGtJeRQohS79hTInr+YlTK3zDFdQ9hP2CQWzpzwvC4Tz6CNDcwKfaWbc
         +MEIVejtSUosqsUxFnps/xCLKH1QitcxzbDut0OjzYI+tDrhxQHFNWc+J0qYUSe9/n0L
         7jpyn/VVu5FUFs2o4ZxR048uIKY8ehA8jNKzAcwjxsG7nt/UbPYHYsV7+xH0k6yIka2B
         IilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6ZcTDTmfR5pL/aDxGslxzja+Ab+clZ5Ll+MXu9xSpg=;
        b=Yo5WaR6zcg+0WERaCgZRhxGmtHp7z0ztuCcJ1uLjM5sbalCtbn+kCUvjNbreHve0Db
         GHt4uS+j3tlkkxrMfRPaA5NkRLkoV/htTPnj3crjsRiKX5LlZX67csRvi/jPm9L1Nd/5
         CdF2p79dGU0TSJS5UeQZSOZPuIIqZtIa1kml3MysGR+z2QKcEm30JTE9qeSkHCoXs0oQ
         PpRUQzyAHc2801vYfzdnMISsEg1JL/p7F0fz5xbooNW8xJHgcgAQwDTvJWEYADm9Q8MW
         81UX4AFkERpNE9W3OfZDdYoOVzNJiJKly9ko+hoGn3emYbvtPSoheWDRySk4KZfm63ui
         Db4A==
X-Gm-Message-State: AOAM530GgdfeFTJZEPOHnWhma/UIJvvpmgLGZUKhpbiu14CP8MnDi1y0
        XEEpO68mZMeT9sEkBne8yVU=
X-Google-Smtp-Source: ABdhPJxSde9xCpFCyc2qhnFaEAAh83LakCmkC96Yki++KOPxnWgb5HVWDu1ICo+sJvgZ/LRPv794mg==
X-Received: by 2002:a17:902:bd03:b029:d6:89e2:5b5e with SMTP id p3-20020a170902bd03b02900d689e25b5emr573537pls.70.1605009705036;
        Tue, 10 Nov 2020 04:01:45 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.4])
        by smtp.gmail.com with ESMTPSA id i2sm3098731pjl.15.2020.11.10.04.01.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 04:01:44 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 2/2] receive-pack: gently write messages to proc-receive
Date:   Tue, 10 Nov 2020 20:01:35 +0800
Message-Id: <20201110120135.42025-2-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.29.0.dirty
In-Reply-To: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes found a flaky hang in `t5411/test-0013-bad-protocol.sh` in the
osx-clang job of the CI/PR builds, and ran into an issue when using
the `--stress` option with the following error messages:

    fatal: unable to write flush packet: Broken pipe
    send-pack: unexpected disconnect while reading sideband packet
    fatal: the remote end hung up unexpectedly

In this test case, the "proc-receive" hook sends an error message and
dies earlier. While "receive-pack" on the other side of the pipe
should forward the error message of the "proc-receive" hook to the
client side, but it fails to do so. This is because "receive-pack"
uses `packet_write_fmt()` and `packet_flush()` to write pkt-line
message to "proc-receive" hook, and these functions die immediately
when pipe is broken. Using "gently" forms for these functions will get
more predicable output.

Add more "--die-*" options to test helper to test different stages of
the protocol between "receive-pack" and "proc-receive" hook.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                       |  62 +++++--
 t/helper/test-proc-receive.c                 |  42 +++--
 t/t5411/test-0013-bad-protocol.sh            | 141 +++++++++++++--
 t/t5411/test-0014-bad-protocol--porcelain.sh | 176 ++++++++++++++++++-
 4 files changed, 380 insertions(+), 41 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..697a4e8802 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -974,9 +974,10 @@ static int read_proc_receive_report(struct packet_reader *reader,
 	struct command *cmd;
 	struct command *hint = NULL;
 	struct ref_push_report *report = NULL;
-	int new_report = 0;
 	int code = 0;
+	int new_report = 0;
 	int once = 0;
+	int response = 0;
 
 	for (;;) {
 		struct object_id old_oid, new_oid;
@@ -984,8 +985,14 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		const char *refname;
 		char *p;
 
-		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
+		if (packet_reader_read(reader) != PACKET_READ_NORMAL) {
+			if (!response) {
+				strbuf_addstr(errmsg, "no response from proc-receive hook");
+				return -1;
+			}
 			break;
+		}
+		response++;
 
 		head = reader->line;
 		p = strchr(head, ' ');
@@ -1100,7 +1107,7 @@ static int run_proc_receive_hook(struct command *commands,
 	struct strbuf cap = STRBUF_INIT;
 	struct strbuf errmsg = STRBUF_INIT;
 	int hook_use_push_options = 0;
-	int version = 0;
+	int version = -1;
 	int code;
 
 	argv[0] = find_hook("proc-receive");
@@ -1145,12 +1152,17 @@ static int run_proc_receive_hook(struct command *commands,
 	if (use_push_options)
 		strbuf_addstr(&cap, " push-options");
 	if (cap.len) {
-		packet_write_fmt(proc.in, "version=1%c%s\n", '\0', cap.buf + 1);
+		code = packet_write_fmt_gently(proc.in, "version=1%c%s\n", '\0', cap.buf + 1);
 		strbuf_release(&cap);
 	} else {
-		packet_write_fmt(proc.in, "version=1\n");
+		code = packet_write_fmt_gently(proc.in, "version=1\n");
+	}
+	if (!code)
+		code = packet_flush_gently(proc.in);
+	if (code) {
+		strbuf_addstr(&errmsg, "fail to negotiate version with proc-receive hook");
+		goto cleanup;
 	}
-	packet_flush(proc.in);
 
 	for (;;) {
 		int linelen;
@@ -1169,7 +1181,11 @@ static int run_proc_receive_hook(struct command *commands,
 		}
 	}
 
-	if (version != 1) {
+	if (version == -1) {
+		strbuf_addstr(&errmsg, "fail to negotiate version with proc-receive hook");
+		code = -1;
+		goto cleanup;
+	} else if (version != 1) {
 		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
 			    version);
 		code = -1;
@@ -1180,20 +1196,36 @@ static int run_proc_receive_hook(struct command *commands,
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->run_proc_receive || cmd->skip_update || cmd->error_string)
 			continue;
-		packet_write_fmt(proc.in, "%s %s %s",
-				 oid_to_hex(&cmd->old_oid),
-				 oid_to_hex(&cmd->new_oid),
-				 cmd->ref_name);
+		code = packet_write_fmt_gently(proc.in, "%s %s %s",
+					       oid_to_hex(&cmd->old_oid),
+					       oid_to_hex(&cmd->new_oid),
+					       cmd->ref_name);
+		if (code)
+			break;
+	}
+	if (!code)
+		code = packet_flush_gently(proc.in);
+	if (code) {
+		strbuf_addstr(&errmsg, "fail to write commands to proc-receive hook");
+		goto cleanup;
 	}
-	packet_flush(proc.in);
 
 	/* Send push options */
 	if (hook_use_push_options) {
 		struct string_list_item *item;
 
-		for_each_string_list_item(item, push_options)
-			packet_write_fmt(proc.in, "%s", item->string);
-		packet_flush(proc.in);
+		for_each_string_list_item(item, push_options) {
+			code = packet_write_fmt_gently(proc.in, "%s", item->string);
+			if (code)
+				break;
+		}
+		if (!code)
+			code = packet_flush_gently(proc.in);
+		if (code) {
+			strbuf_addstr(&errmsg,
+				      "fail to write push-options to proc-receive hook");
+			goto cleanup;
+		}
 	}
 
 	/* Read result from proc-receive */
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 42164d9898..6652cedcee 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -10,8 +10,11 @@ static const char *proc_receive_usage[] = {
 	NULL
 };
 
-static int die_version;
-static int die_readline;
+static int die_read_version;
+static int die_write_version;
+static int die_read_commands;
+static int die_read_push_options;
+static int die_write_report;
 static int no_push_options;
 static int use_atomic;
 static int use_push_options;
@@ -33,6 +36,9 @@ struct command {
 static void proc_receive_verison(struct packet_reader *reader) {
 	int server_version = 0;
 
+	if (die_read_version)
+		die("die with the --die-read-version option");
+
 	for (;;) {
 		int linelen;
 
@@ -52,9 +58,12 @@ static void proc_receive_verison(struct packet_reader *reader) {
 		}
 	}
 
-	if (server_version != 1 || die_version)
+	if (server_version != 1)
 		die("bad protocol version: %d", server_version);
 
+	if (die_write_version)
+		die("die with the --die-write-version option");
+
 	packet_write_fmt(1, "version=%d%c%s\n",
 			 version, '\0',
 			 use_push_options && !no_push_options ? "push-options": "");
@@ -75,11 +84,13 @@ static void proc_receive_read_commands(struct packet_reader *reader,
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
 
+		if (die_read_commands)
+			die("die with the --die-read-commands option");
+
 		if (parse_oid_hex(reader->line, &old_oid, &p) ||
 		    *p++ != ' ' ||
 		    parse_oid_hex(p, &new_oid, &p) ||
-		    *p++ != ' ' ||
-		    die_readline)
+		    *p++ != ' ')
 			die("protocol error: expected 'old new ref', got '%s'",
 			    reader->line);
 		refname = p;
@@ -99,6 +110,9 @@ static void proc_receive_read_push_options(struct packet_reader *reader,
 	if (no_push_options || !use_push_options)
 	       return;
 
+	if (die_read_push_options)
+		die("die with the --die-read-push-options option");
+
 	while (1) {
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
@@ -117,10 +131,16 @@ int cmd__proc_receive(int argc, const char **argv)
 	struct option options[] = {
 		OPT_BOOL(0, "no-push-options", &no_push_options,
 			 "disable push options"),
-		OPT_BOOL(0, "die-version", &die_version,
-			 "die during version negotiation"),
-		OPT_BOOL(0, "die-readline", &die_readline,
-			 "die when readline"),
+		OPT_BOOL(0, "die-read-version", &die_read_version,
+			 "die when reading version"),
+		OPT_BOOL(0, "die-write-version", &die_write_version,
+			 "die when writing version"),
+		OPT_BOOL(0, "die-read-commands", &die_read_commands,
+			 "die when reading commands"),
+		OPT_BOOL(0, "die-read-push-options", &die_read_push_options,
+			 "die when reading push-options"),
+		OPT_BOOL(0, "die-write-report", &die_write_report,
+			 "die when writing report"),
 		OPT_STRING_LIST('r', "return", &returns, "old/new/ref/status/msg",
 				"return of results"),
 		OPT__VERBOSE(&verbose, "be verbose"),
@@ -136,7 +156,7 @@ int cmd__proc_receive(int argc, const char **argv)
 		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_DIE_ON_ERR_PACKET);
+			   PACKET_READ_GENTLE_ON_EOF);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 	proc_receive_verison(&reader);
@@ -166,6 +186,8 @@ int cmd__proc_receive(int argc, const char **argv)
 				fprintf(stderr, "proc-receive> %s\n", item->string);
 	}
 
+	if (die_write_report)
+		die("die with the --die-write-report option");
 	if (returns.nr)
 		for_each_string_list_item(item, &returns)
 			packet_write_fmt(1, "%s\n", item->string);
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index 854c3e884a..550ceaaf4b 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -16,7 +16,8 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 
 	# Check status report for git-push
 	sed -n \
-		-e "/^To / { p; n; p; }" \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
 		<actual >actual-report &&
 	cat >expect <<-EOF &&
 	To <URL/of/upstream.git>
@@ -41,32 +42,98 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL)" '
 	test_cmp expect actual
 '
 
-test_expect_success "setup proc-receive hook (hook --die-version, $PROTOCOL)" '
+test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
-	test-tool proc-receive -v --die-version
+	test-tool proc-receive -v --die-read-version
 	EOF
 '
 
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/main/topic(A)
-test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)" '
+test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTOCOL)" '
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-read-version option" out &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+
+	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-write-version
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-write-version option" out &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
 
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-read-commands
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
 	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
-	remote: # proc-receive hook
-	remote: fatal: bad protocol version: 1
-	remote: error: proc-receive version "0" is not supported
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-read-commands option" out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -76,23 +143,65 @@ test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)"
 	test_cmp expect actual
 '
 
-test_expect_success "setup proc-receive hook (hook --die-readline, $PROTOCOL)" '
+test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
-	test-tool proc-receive -v --die-readline
+	test-tool proc-receive -v --die-read-push-options
 	EOF
 '
 
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/main/topic(A)
-test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)" '
+test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $PROTOCOL)" '
+	git -C "$upstream" config receive.advertisePushOptions true &&
 	test_must_fail git -C workbench push origin \
+		-o reviewers=user1,user2 \
 		HEAD:refs/for/main/topic \
 		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-read-push-options option" out &&
+
+	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
 
-	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\"" actual &&
+test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-write-report
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; }" \
+		-e "/^ ! / { p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-write-report option" out &&
 
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
@@ -123,13 +232,15 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL)" '
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: error: no response from proc-receive hook
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
 	 * [new branch] HEAD -> next
-	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
+
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
@@ -173,6 +284,7 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL)" '
 	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
+
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
@@ -208,6 +320,7 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL)" '
 	 ! [remote rejected] HEAD -> refs/for/main/topic (proc-receive failed to report status)
 	EOF
 	test_cmp expect actual &&
+
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index 88c56311da..5aeebe7553 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -42,6 +42,175 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 	test_cmp expect actual
 '
 
+test_expect_success "setup proc-receive hook (hook --die-read-version, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-read-version
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-read-version, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; n; p; n; p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-read-version option" out &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-write-version, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-write-version
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-write-version, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; n; p; n; p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-write-version option" out &&
+	grep "remote: error: fail to negotiate version with proc-receive hook" out &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-read-commands, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-read-commands
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-read-commands, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; n; p; n; p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-read-commands option" out &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-read-push-options, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-read-push-options
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-read-push-options, $PROTOCOL/porcelain)" '
+	git -C "$upstream" config receive.advertisePushOptions true &&
+	test_must_fail git -C workbench push --porcelain origin \
+		-o reviewers=user1,user2 \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; n; p; n; p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-read-push-options option" out &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-write-report, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-write-report
+	EOF
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       refs/for/main/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-write-report, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output -n \
+		-e "/^To / { p; n; p; n; p; }" \
+		<out >actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	grep "remote: fatal: die with the --die-write-report option" out &&
+
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
@@ -63,14 +232,16 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
 	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
 	remote: # proc-receive hook
 	remote: proc-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: error: no response from proc-receive hook
 	remote: # post-receive hook
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
 	To <URL/of/upstream.git>
 	*    HEAD:refs/heads/next    [new branch]
-	!    HEAD:refs/for/main/topic    [remote rejected] (proc-receive failed to report status)
+	!    HEAD:refs/for/main/topic    [remote rejected] (fail to run proc-receive hook)
 	Done
 	EOF
 	test_cmp expect actual &&
+
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
@@ -84,7 +255,6 @@ test_expect_success "proc-receive: bad protocol (no report, $PROTOCOL/porcelain)
 # Refs of workbench: main(A)  tags/v123
 test_expect_success "cleanup ($PROTOCOL/porcelain)" '
 	git -C "$upstream" update-ref -d refs/heads/next
-
 '
 
 test_expect_success "setup proc-receive hook (no ref, $PROTOCOL/porcelain)" '
@@ -115,6 +285,7 @@ test_expect_success "proc-receive: bad protocol (no ref, $PROTOCOL/porcelain)" '
 	Done
 	EOF
 	test_cmp expect actual &&
+
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
@@ -151,6 +322,7 @@ test_expect_success "proc-receive: bad protocol (unknown status, $PROTOCOL/porce
 	Done
 	EOF
 	test_cmp expect actual &&
+
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
-- 
2.29.0.dirty

