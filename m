Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F954C43603
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8601864FCC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhCKCMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhCKCLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:45 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A3BC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:45 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id h126so14302890qkd.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BdbSVFpR8MOs/iFa2drop73T1SvXVSje6F7PUX2Ry3c=;
        b=JdsgtcB55c9i+rq13jWWR8IJCaQDnm5YhOIc+eWIRkJmbKyeHCXnPWJKy7n7dCouhK
         V3mXPAEu3GlFW2lQGLHOhzx+Y4jt5WKtRIeKKapjTmbMvjQfDaw3o00Wc+pwSSPHO3Vl
         mWxZXBurvUMiFWKTvfrTpcIslkCZJIEqKV6avmECTlOcfZCsAg+FnIXHM3nDmi/dmL18
         jwM+IsbLSqHVFYazocfG8+1OSpufuaJIsojpc3V2gv4QIAO/ep45cafBEL9N6IBaeOwE
         AHo4sI0PiEO6HJMUbqnxWo4nTxKEZGnmPIqhAif14yYoeig2EIg8Y6YMDthmXbNwDZg3
         BQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BdbSVFpR8MOs/iFa2drop73T1SvXVSje6F7PUX2Ry3c=;
        b=mer/PROMD0JJ8pD09JjdYj5wN0OSyb2SqmudivaUV+OKBmXkexZdDAP9v5PQ9u57as
         KjbrLI4aLoOJ3tB0TLoTVqSlljNVmV9BLZ7aVXwku7WNfehzrt9A/aYUibls0vluaibV
         c173y8Z8jsZWm+/LSTVlfEQAPgFhwSZ+TBWMMWUVDZHqqKvb7gEZnkauPzPRz45E7AYs
         MqTpJjtv1mS3LMBOUbPAO1UzdYXXJ75lEgqt8A7YdALDOlWIAVBlZ3r3s7QC9qzSXoRC
         ugvOjVzFRnSITx++g8FoPdHw9C31+7Ak36flLsAGiofhd9br+nWCrZ7a0VS7l30XdP0y
         uo1Q==
X-Gm-Message-State: AOAM531MJp7K3S0nOmvThXyUnbl2urzvqSWH4+c8bv2NEzW0h6NkHzv5
        XdzIJEqV9DEKUxwul0SZKd/hNFUL+4p/Cp+KGfTi78nlSWXfSjHyhTh4u5bhWsrWXfMmPMfdGCX
        ok3X8jPXna0d6z/SokEwXegL+5qOChFYuMItGw3/0zR8t3IrsW2tbPTr8WHwudSZ6cNYZXi9m6g
        ==
X-Google-Smtp-Source: ABdhPJz2MR1LNB1YP+Emhtd4azm57PdVWGdWUnoHwrPjbHUwIzpQR417HbJQGZE/f03wunPGczZ5Gtf/SxcQKvZpkaY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:b611:: with SMTP id
 f17mr5907300qve.42.1615428704263; Wed, 10 Mar 2021 18:11:44 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:30 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-31-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 30/37] receive-pack: convert 'update' hook to hook.h
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
 Documentation/githooks.txt       |  3 ++
 builtin/receive-pack.c           | 66 ++++++++++++++++++++++----------
 t/t1416-ref-transaction-hooks.sh |  4 +-
 3 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index dc8b7111d5..60fd43d1da 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -368,6 +368,9 @@ The default 'update' hook, when enabled--and with
 `hooks.allowunannotated` config option unset or set to false--prevents
 unannotated tags to be pushed.
 
+Hooks executed during 'update' are run in parallel, unless hook.jobs is
+configured to 1.
+
 [[proc-receive]]
 proc-receive
 ~~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 234b70f0d1..b34a27a303 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -938,33 +938,57 @@ static int run_receive_hook(struct command *commands,
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
+	struct run_hooks_opt opt;
+	int code;
+	run_hooks_opt_init_async(&opt);
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
index 3a90a59143..0a3c3e4a86 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -124,10 +124,10 @@ test_expect_success 'interleaving hook calls succeed' '
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
2.31.0.rc2.261.g7f71774620-goog

