Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9DFC1B0D9
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFC822DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbgLEBvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLEBvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:22 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D65C08E863
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:15 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o25so7083659qkj.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KfyNWTOqk9ML8wcpWDyF/xpuy7l+UvJ5ELVq1/XBd6E=;
        b=JD+AF3HJEWTyIMdlEi7WqaHdmn7bdJVNaGrVxsaet2YektLGfZDREC8aGXVKqC7KOo
         17h9VbrTFzq9+zhZ3QBFoiEbpvpe5417DBI9f4hM89pHk0JWAC2RcU+zlF9/+OL2tZKL
         2YoMsJCK7zfiYt/FOW8zUCmosxVVaQCe/JunvOpwPM6S7ek3wfbXwtm4CPJ3UrlxmGix
         IxB9ikeXBQem9NbSiWTlspnBuAuAC7iW5OjH89fF4oF0OZC96k7X2lAzjmYKZ154kt5j
         hGCAT3U6N4CwDm2jbnK4SXVqd7gpsjNlSo1mg0HYJBJVlwJm3TWiGOX/rhttGUGWiS1K
         N4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KfyNWTOqk9ML8wcpWDyF/xpuy7l+UvJ5ELVq1/XBd6E=;
        b=NjazkmNjGpW8WyPFNMLMkQgxnRzFHlcwbsE1cmoulZWeyhyQs8BbwKKdggTSa1Fe1o
         czucWX/8zuUDAf/3SgQuMK2tJ6AwFUora0FbmMDOeZ+KVSoXwOvlBDSo/rOmpp2P3ELA
         nchqP3ep1BDdqgA4h0/4R4b2eM6UhX++VByh/ZXvNgQBFeUs62aMSo3U5Qei1MS+ydAY
         CYIBGXAXXEA5Wct3b3REYB6s4pR9EJgmZbCbT31jQQcOZedgbYN01LbQcPkyCo/CKL6c
         u0qqJvICTFR+5SVlvsIjjIgtz5MlxLovc95g0dc/F89jMr1z37T7pYVX4vpyx2IPIVT9
         G5pw==
X-Gm-Message-State: AOAM5303KkIizMmTdV3YMzWq6LLjhXzeHPo+HPzAK0baarrvJfroH2EB
        ExgwaP00QY45MA4nvhPbfwAdDxOKTjRyPpn6Gie7a169k21GXUX9WtFmD+5cNLqYLzbCfrmwVy5
        OGtQil6QL3aCKvdHaimfqy6zvvwkTN983pcCt7wRoJcBUD8sI6umJNXkhyRh4MJbiFlXQyMyCoA
        ==
X-Google-Smtp-Source: ABdhPJzzoG+0vYhsi2w0p1Wmu7Otqnuaq34D1SeckwgKgJcKJPsRFOeKWsk4O0j35PZhaTZXsOTnPP5lrwwk7qNwJgo=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:ec41:: with SMTP id
 n1mr9162029qvq.42.1607133014559; Fri, 04 Dec 2020 17:50:14 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:41 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 13/17] receive-pack: convert 'update' hook to hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using hook.h to invoke the 'update' hook, now hooks can be specified
in the config in addition to the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt       |  2 +
 builtin/receive-pack.c           | 65 +++++++++++++++++++++-----------
 t/t1416-ref-transaction-hooks.sh |  4 +-
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 3a35500132..2b3a74f249 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -359,6 +359,8 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+Hooks executed during 'update' are run in parallel by default.
+
 [[proc-receive]]
 proc-receive
 ~~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d64a3076be..cd79ad6bdc 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -930,33 +930,56 @@ static int run_receive_hook(struct command *commands,
 	return status;
 }
 
-static int run_update_hook(struct command *cmd)
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
 {
-	const char *argv[5];
-	struct child_process proc = CHILD_PROCESS_INIT;
-	int code;
+	int keepalive_active = 0;
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
-		return 0;
+	if (keepalive_in_sec <= 0)
+		use_keepalive = KEEPALIVE_NEVER;
+	if (use_keepalive == KEEPALIVE_ALWAYS)
+		keepalive_active = 1;
 
-	argv[1] = cmd->ref_name;
-	argv[2] = oid_to_hex(&cmd->old_oid);
-	argv[3] = oid_to_hex(&cmd->new_oid);
-	argv[4] = NULL;
+	/* send a keepalive if there is no data to write */
+	if (keepalive_active && !output->len) {
+		static const char buf[] = "0005\1";
+		write_or_die(1, buf, sizeof(buf) - 1);
+		return;
+	}
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
-	proc.trace2_hook_name = "update";
+	if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
+		const char *first_null = memchr(output->buf, '\0', output->len);
+		if (first_null) {
+			/* The null bit is excluded. */
+			size_t before_null = first_null - output->buf;
+			size_t after_null = output->len - (before_null + 1);
+			keepalive_active = 1;
+			send_sideband(1, 2, output->buf, before_null, use_sideband);
+			send_sideband(1, 2, first_null + 1, after_null, use_sideband);
+
+			return;
+		}
+	}
+
+	send_sideband(1, 2, output->buf, output->len, use_sideband);
+}
+
+static int run_update_hook(struct command *cmd)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_ASYNC;
+	int code;
+
+	strvec_pushl(&opt.args,
+		     cmd->ref_name,
+		     oid_to_hex(&cmd->old_oid),
+		     oid_to_hex(&cmd->new_oid),
+		     NULL);
 
-	code = start_command(&proc);
-	if (code)
-		return code;
 	if (use_sideband)
-		copy_to_sideband(proc.err, -1, NULL);
-	return finish_command(&proc);
+		opt.consume_sideband = hook_output_to_sideband;
+
+	code = run_hooks("update", &opt);
+	run_hooks_opt_clear(&opt);
+	return code;
 }
 
 static struct command *find_command_by_refname(struct command *list,
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 17f11f5cb0..28359f6099 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -121,10 +121,10 @@ test_expect_success 'interleaving hook calls succeed' '
 	EOF
 
 	cat >expect <<-EOF &&
-		hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
+		$(pwd)/target-repo.git/hooks/update refs/tags/PRE $ZERO_OID $PRE_OID
 		$(pwd)/target-repo.git/hooks/reference-transaction prepared
 		$(pwd)/target-repo.git/hooks/reference-transaction committed
-		hooks/update refs/tags/POST $ZERO_OID $POST_OID
+		$(pwd)/target-repo.git/hooks/update refs/tags/POST $ZERO_OID $POST_OID
 		$(pwd)/target-repo.git/hooks/reference-transaction prepared
 		$(pwd)/target-repo.git/hooks/reference-transaction committed
 	EOF
-- 
2.28.0.rc0.142.g3c755180ce-goog

