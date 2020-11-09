Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3A5C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C277720678
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJA/HR52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKIK66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKIK66 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 05:58:58 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AF4C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 02:58:57 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so7772373pfb.10
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 02:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsnoxiBy0YqJwZpX+qnA04M7B3G03xy2ludh7gEtTBk=;
        b=nJA/HR52d1YF3PyrlFdD8o+AOti/kf6ygA9azU5SWMTuow9943dK1rY22ZvJYHYfd4
         WlVTvaVHfw6PxPlvz1NQw3PnqEsLA37Sl2MfDzrbV3VCJwjXeXj6IMDVK7gzNE+wLrzn
         vj/vZgfhEDufgqPojiqfgfbYUOT8i0v82xPTbOgV203LcC0bnSSqiW4Yk6WCcLHmIZ4k
         SqrpYdOwyVYwmsSYeDwWW6B4P0enfKA8RhOPCv/5CGC2gDNmTaQlddJhX5XrHepeICIU
         Wf92i/0iqe3jPpCqhgGvYt2mvJfwDTBysQpnDco9qx9HofTHAOwoZjkOkGy6Z3qkdLQU
         BA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsnoxiBy0YqJwZpX+qnA04M7B3G03xy2ludh7gEtTBk=;
        b=t2QAcp+OCU/aDo4WEa0nMQsltJrQweBts/7bz3mRHPCQupE1EoXaJXrhHGKGhtv+Kb
         9/NAkz9EUJ2eKoR/rIj29NWZe86dPFtjpz4EyV9gV29gcwDFdxZ/9UzocwhPA7W9N622
         xxMhjHo6VCA977wQw4AfU0EIY2ku5u9YVJi4/MJBS/wnh741xrFcXmQ1dHw2exsB6/XE
         +HFx3HJHQ/cUeVxrUsQcWlHPeoak6f25gKNI7KJGaEYys6pXqYOrWnGS0jsOyW7XiP+W
         SwudXvJxjTQWXiUN0WCWPQbnsS7Vrukvr9ZYTVak9znknP0xwn/0woNFf6ascxHZOiFk
         3vjg==
X-Gm-Message-State: AOAM533/sCAjG6JUXmdL8G4OOGaOfzfIK8rX0YokmBiY+0PVMjejpcmR
        uP7EWrX6WzaVhDEhIR0cg1c=
X-Google-Smtp-Source: ABdhPJw2XAHgD5B4fNGbYlruuC+LOVI+MYTaOhZnsWR/+f99fNGSGqiMqiI6lAuAJW9I6KH5B7nNpg==
X-Received: by 2002:a62:63c6:0:b029:18a:8d05:5bdc with SMTP id x189-20020a6263c60000b029018a8d055bdcmr13093216pfb.37.1604919536530;
        Mon, 09 Nov 2020 02:58:56 -0800 (PST)
Received: from localhost.localdomain ([47.89.83.3])
        by smtp.gmail.com with ESMTPSA id m13sm11719738pjr.30.2020.11.09.02.58.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:58:56 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2] t5411: consistent result for proc-receive broken test
Date:   Mon,  9 Nov 2020 18:58:46 +0800
Message-Id: <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.29.0.dirty
In-Reply-To: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
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
client side, but it fails to do so. Perhaps it depends on the size of
the pipe buffer and timing of the processes getting scheduled.

The way the exchange designed to happen in a successful case is that
"receive-pack" process feeds the commands, and optional push options
over the pipe, and after feeding all these information, "receive-pack"
starts reading the response of "proc-receive". Let "receive-pack" close
the input stream to "proc-receive" right before reading the response,
so that "proc-receive" may consume all the input from "receive-pack"
before sending an error message and closing the pipe.

The "proc-receive" hook may close the pipe at any time. Three options
(--die-version, --die-readline, and --die-report) can be used for the
test helper to simulate different broken cases. In order to keep the
test results consistent under stress test, only status reports are
matched.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                       |  4 +-
 t/helper/test-proc-receive.c                 | 21 ++++-
 t/t5411/test-0013-bad-protocol.sh            | 53 +++++++++--
 t/t5411/test-0014-bad-protocol--porcelain.sh | 96 ++++++++++++++++++++
 4 files changed, 160 insertions(+), 14 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..6bd402897c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1172,6 +1172,7 @@ static int run_proc_receive_hook(struct command *commands,
 	if (version != 1) {
 		strbuf_addf(&errmsg, "proc-receive version '%d' is not supported",
 			    version);
+		close(proc.in);
 		code = -1;
 		goto cleanup;
 	}
@@ -1196,11 +1197,12 @@ static int run_proc_receive_hook(struct command *commands,
 		packet_flush(proc.in);
 	}
 
+	close(proc.in);
+
 	/* Read result from proc-receive */
 	code = read_proc_receive_report(&reader, commands, &errmsg);
 
 cleanup:
-	close(proc.in);
 	close(proc.out);
 	if (use_sideband)
 		finish_async(&muxer);
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 42164d9898..9f7fbc5b7a 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -12,6 +12,7 @@ static const char *proc_receive_usage[] = {
 
 static int die_version;
 static int die_readline;
+static int die_report;
 static int no_push_options;
 static int use_atomic;
 static int use_push_options;
@@ -52,8 +53,10 @@ static void proc_receive_verison(struct packet_reader *reader) {
 		}
 	}
 
-	if (server_version != 1 || die_version)
+	if (server_version != 1)
 		die("bad protocol version: %d", server_version);
+	if (die_version)
+		die("die with the --die-version option");
 
 	packet_write_fmt(1, "version=%d%c%s\n",
 			 version, '\0',
@@ -79,9 +82,15 @@ static void proc_receive_read_commands(struct packet_reader *reader,
 		    *p++ != ' ' ||
 		    parse_oid_hex(p, &new_oid, &p) ||
 		    *p++ != ' ' ||
-		    die_readline)
+		    die_readline) {
+			char *bad_line = xstrdup(reader->line);
+			while (packet_reader_read(reader) != PACKET_READ_EOF)
+				; /* do nothing */
+			if (die_readline)
+				die("die with the --die-readline option");
 			die("protocol error: expected 'old new ref', got '%s'",
-			    reader->line);
+			    bad_line);
+		}
 		refname = p;
 		FLEX_ALLOC_STR(cmd, ref_name, refname);
 		oidcpy(&cmd->old_oid, &old_oid);
@@ -121,6 +130,8 @@ int cmd__proc_receive(int argc, const char **argv)
 			 "die during version negotiation"),
 		OPT_BOOL(0, "die-readline", &die_readline,
 			 "die when readline"),
+		OPT_BOOL(0, "die-report", &die_report,
+			 "die when reporting"),
 		OPT_STRING_LIST('r', "return", &returns, "old/new/ref/status/msg",
 				"return of results"),
 		OPT__VERBOSE(&verbose, "be verbose"),
@@ -136,7 +147,7 @@ int cmd__proc_receive(int argc, const char **argv)
 		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
-			   PACKET_READ_DIE_ON_ERR_PACKET);
+			   PACKET_READ_GENTLE_ON_EOF);
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 	proc_receive_verison(&reader);
@@ -166,6 +177,8 @@ int cmd__proc_receive(int argc, const char **argv)
 				fprintf(stderr, "proc-receive> %s\n", item->string);
 	}
 
+	if (die_report)
+		die("die with the --die-report option");
 	if (returns.nr)
 		for_each_string_list_item(item, &returns)
 			packet_write_fmt(1, "%s\n", item->string);
diff --git a/t/t5411/test-0013-bad-protocol.sh b/t/t5411/test-0013-bad-protocol.sh
index c5fe4cb37b..5c5241bc95 100644
--- a/t/t5411/test-0013-bad-protocol.sh
+++ b/t/t5411/test-0013-bad-protocol.sh
@@ -55,19 +55,16 @@ test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL)"
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/master/topic \
 		>out 2>&1 &&
-	make_user_friendly_and_stable_output <out >actual &&
-
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { s/   */ /g; p; }" \
+			-e "/^ ! / { s/   */ /g; p; }" \
+			>actual &&
 	cat >expect <<-EOF &&
-	remote: # pre-receive hook
-	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
-	remote: # proc-receive hook
-	remote: fatal: bad protocol version: 1
-	remote: error: proc-receive version "0" is not supported
 	To <URL/of/upstream.git>
 	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
 	EOF
 	test_cmp expect actual &&
-
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
@@ -90,10 +87,48 @@ test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL)
 	test_must_fail git -C workbench push origin \
 		HEAD:refs/for/master/topic \
 		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { s/   */ /g; p; }" \
+			-e "/^ ! / { s/   */ /g; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
 
-	grep "remote: fatal: protocol error: expected \"old new ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
+test_expect_success "setup proc-receive hook (hook --die-report, $PROTOCOL)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-report
+	EOF
+'
 
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-report, $PROTOCOL)" '
+	test_must_fail git -C workbench push origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { s/   */ /g; p; }" \
+			-e "/^ ! / { s/   */ /g; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	 ! [remote rejected] HEAD -> refs/for/master/topic (proc-receive failed to report status)
+	EOF
+	test_cmp expect actual &&
 	git -C "$upstream" show-ref >out &&
 	make_user_friendly_and_stable_output <out >actual &&
 	cat >expect <<-EOF &&
diff --git a/t/t5411/test-0014-bad-protocol--porcelain.sh b/t/t5411/test-0014-bad-protocol--porcelain.sh
index 53b47b0185..df19777ab0 100644
--- a/t/t5411/test-0014-bad-protocol--porcelain.sh
+++ b/t/t5411/test-0014-bad-protocol--porcelain.sh
@@ -42,6 +42,102 @@ test_expect_success "proc-receive: bad protocol (unknown version, $PROTOCOL/porc
 	test_cmp expect actual
 '
 
+test_expect_success "setup proc-receive hook (hook --die-version, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-version
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-version, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { p; n; p; n; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (fail to run proc-receive hook)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-readline, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-readline
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-readline, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { p; n; p; n; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "setup proc-receive hook (hook --die-report, $PROTOCOL/porcelain)" '
+	write_script "$upstream/hooks/proc-receive" <<-EOF
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v --die-report
+	EOF
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       refs/for/master/topic(A)
+test_expect_success "proc-receive: bad protocol (hook --die-report, $PROTOCOL/porcelain)" '
+	test_must_fail git -C workbench push --porcelain origin \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out |
+		sed -n \
+			-e "/^To / { p; n; p; n; p; }" \
+			>actual &&
+	cat >expect <<-EOF &&
+	To <URL/of/upstream.git>
+	!    HEAD:refs/for/master/topic    [remote rejected] (proc-receive failed to report status)
+	Done
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success "setup proc-receive hook (no report, $PROTOCOL/porcelain)" '
 	write_script "$upstream/hooks/proc-receive" <<-EOF
 	printf >&2 "# proc-receive hook\n"
-- 
2.29.0.dirty

