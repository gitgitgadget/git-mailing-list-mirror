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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D2C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9A1613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbhE0AMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbhE0ALr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF41AC061760
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k34-20020a25b2a20000b02905149e86803eso3642840ybj.9
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I+L8k7IVYOdFyaHd+iQoVEM+WvZ0n/WN8+K97LewaOY=;
        b=tUhvWzbnJ+N98w16Gce7jw+anLHwwodjjA93L38VGn4gACFdsWGemEJW04DEnbL9zS
         rIwAkXH9+Ro213OotBPKHMVIAMYNeU+4fsWuYtzkIbKZwcDOOMErRATnGLJjRfSKY2gO
         jIV+UyVhiBZGKeyI3hqzrh+yPIy/KtMErW9iWyLMZ8Dupc5MqVUj7t2eejoZbwJdbktE
         xyvYvAOo/mk0TxwtoXRjx2CjvLh8QbM3g5MQrjJmkUrSgr1WkVEVfbyyNdFprnStLSqr
         HKTIKsptkqInUorsHvbU/JXT+hWccKQ3Sp4soOW9Kq0B12TFxv5xDIL1+hKyoaKD7ptB
         5DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I+L8k7IVYOdFyaHd+iQoVEM+WvZ0n/WN8+K97LewaOY=;
        b=RQOb8BfhLDNVKusw6+lO3zl6dVVmzP6/Q/L0QPX/fv4vBHQyLte8KI9XTJVNDqm9tR
         FvBw/ZKfVzuH71F689xR9HjIzSZ70xz29Y2FTrWiZeB1LnMt+DkSZ/oSsOkak3SxUwCe
         H1triNXmKP6jJ8iXYX5Ngz22PYfD8cqOmOzsPPh6NFSzZkYdONv1cwyCqekthC4mC8V6
         f0UuohTFkL22k/hbTfHvwgcDWejKREuO90x7rPqfhvN3WzwC1Y5AhjquiPYknJcgKyNs
         OnXlNnZZbxiIhMAMF6xSiG8WNtgnjx7JAOVLfPAAzz6lY1wfwmLX5TJPSSxd/y1cZLBo
         cwoQ==
X-Gm-Message-State: AOAM530w3gMeW8LRcZHPeuC48pY3l3BgGz0aeLVlRpoJLsPN/YVBitWj
        d5f4nHOYWm992uh0FN+V/3EE7PsHSYnGnt9D9CRZf4yYZVCKBOZJe/62l0vHE/FSjx9X0l8VIMA
        giHL+THR55jbVpOKR45PyeKGYHwBqW8vzU6ayo+/X5UHW2ird9+E6mEW3jne34lFV1hy564kksQ
        ==
X-Google-Smtp-Source: ABdhPJyOyVx64Zu1l5lBvtJPcQ0S23YHB8PEGFXEZPIYtg2Ksq/ILi0/vVSHPjRWRd1chDODPuAsgAVKQvH3rTESRII=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ba93:: with SMTP id
 s19mr866748ybg.161.1622074197102; Wed, 26 May 2021 17:09:57 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:48 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-30-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 29/37] receive-pack: convert 'update' hook to hook.h
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
 builtin/receive-pack.c           | 65 ++++++++++++++++++++++----------
 t/t1416-ref-transaction-hooks.sh |  4 +-
 3 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index edb840dcdd..1d731474ac 100644
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
index 09e7cdee45..0f6bc8653f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -938,33 +938,58 @@ static int run_receive_hook(struct command *commands,
 	return status;
 }
 
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data)
+{
+	int keepalive_active = 0;
+
+	if (keepalive_in_sec <= 0)
+		use_keepalive = KEEPALIVE_NEVER;
+	if (use_keepalive == KEEPALIVE_ALWAYS)
+		keepalive_active = 1;
+
+	/* send a keepalive if there is no data to write */
+	if (keepalive_active && !output->len) {
+		static const char buf[] = "0005\1";
+		write_or_die(1, buf, sizeof(buf) - 1);
+		return;
+	}
+
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
 static int run_update_hook(struct command *cmd)
 {
-	const char *argv[5];
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct run_hooks_opt opt;
 	int code;
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
-		return 0;
+	run_hooks_opt_init_async(&opt);
 
-	argv[1] = cmd->ref_name;
-	argv[2] = oid_to_hex(&cmd->old_oid);
-	argv[3] = oid_to_hex(&cmd->new_oid);
-	argv[4] = NULL;
+	strvec_pushl(&opt.args,
+		     cmd->ref_name,
+		     oid_to_hex(&cmd->old_oid),
+		     oid_to_hex(&cmd->new_oid),
+		     NULL);
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.argv = argv;
-	proc.trace2_hook_name = "update";
-
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
2.31.1.818.g46aad6cb9e-goog

