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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D973C4332E
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E1064FDC
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCKCML (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCKCLl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E623C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v196so23762077ybv.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fdrNjGSbgR3/k0inoRDYCwzDeCzZNtFZVESEGgQH1Xs=;
        b=en5T94YvrFd3luglCzx3sqWtRmXZjDONjL3gYZR6AwNlaIymTcl6iMn0qKU+bKEE6b
         ABYHQ4sqpa0VqIg22UtPCCiSVH+N8G+amx5+THqsUEzxMG4lPrmxarw16fDcvw6tR+RI
         TjAZJGCzZsxPo0uXBOkd3Hj2XO98Y7ca7Nn2EwWddpBcS/rESV1IpFASkfXYvqvpx9Ec
         S0Wd+uUFS1TI0fJ3EpesGegaLWkP4BurJhun74aYFmFzrKr/xJGdIC4fDwNPed4SzVNb
         tp0lyrh6mVxBPveQy+Rsom1+ZASN8R6ALr5yikeHYQ8eGfaWgMEa30FJcfMTckf0XuZu
         9EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fdrNjGSbgR3/k0inoRDYCwzDeCzZNtFZVESEGgQH1Xs=;
        b=NgahSYvvEu2yMxEcQ74otSlwhXsDC7p2HbkUWc5OF6t/SuOiwkrDU3tYI587D2FTA6
         6+cQt/TiRD49HQy+5fFw6nVEYNw+9+0B7qGc+hBOX1q2x2S0CeWZIdWKQS68GuFu1/aF
         a1fnF4EKQbQybBx+MUDPIF+OfzDzDDrd6N2whYaCi1s+N4z00FFC/0ggGC1emPX2a+vI
         kzi2WJZf2o9hFHxS5KAvtUn1c69OUegyeAdWo476ff1Dg7/fEruTuWsoRKVRebg6HJwH
         F/qIhSQ5S7e+0fnUVBTNbQD7qUJ8yaAy2k8SwtZ5Vllf0EYD1jkBrRC7p4kxW78jGcey
         TuZw==
X-Gm-Message-State: AOAM530/wDCi0FbIUzEHc8IZ/MhgQ9E1UTye73NYcZHpQ7Rgu8DWV1ro
        PuwbZvsB8yPuW84Pwm/q/wTqujTRY0OBamXEGqnzPo/GYJOhVLMpM/7hcQB6VIWQI0ET2uq6196
        xH0s7ZUZV/+OcEpCgESVxd7D7EM9QTzWvQz2nHro9Iq0u4SEuSZPW/psJhXY1kc43VLhF7NDkmA
        ==
X-Google-Smtp-Source: ABdhPJxdjWVHYhNA2NaCsc2nFA+AA5VxGb3ebkhUa47Q5mtsjGH/t6pdVzgeHS/hzfCCLI7q4GIqpU0kII/PRiAZQbY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:d251:: with SMTP id
 j78mr7804221ybg.480.1615428700686; Wed, 10 Mar 2021 18:11:40 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:28 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-29-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 28/37] transport: convert pre-push hook to use config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By using the hook.h:run_hooks API, pre-push hooks can be specified in
the config as well as in the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt |  3 ++
 transport.c                | 59 +++++++++++---------------------------
 2 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 544238b381..489c93a7cb 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -279,6 +279,9 @@ If this hook exits with a non-zero status, `git push` will abort without
 pushing anything.  Information about why the push is rejected may be sent
 to the user by writing to standard error.
 
+Hooks executed during 'pre-push' will run in parallel, unless hook.jobs is
+configured to 1.
+
 [[pre-receive]]
 pre-receive
 ~~~~~~~~~~~
diff --git a/transport.c b/transport.c
index b13fab5dc3..286b73881b 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "hook.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1172,31 +1173,15 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
-	int ret = 0, x;
+	int ret = 0;
+	struct run_hooks_opt opt;
+	struct strbuf tmp = STRBUF_INIT;
 	struct ref *r;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct strbuf buf;
-	const char *argv[4];
-
-	if (!(argv[0] = find_hook("pre-push")))
-		return 0;
-
-	argv[1] = transport->remote->name;
-	argv[2] = transport->url;
-	argv[3] = NULL;
-
-	proc.argv = argv;
-	proc.in = -1;
-	proc.trace2_hook_name = "pre-push";
-
-	if (start_command(&proc)) {
-		finish_command(&proc);
-		return -1;
-	}
-
-	sigchain_push(SIGPIPE, SIG_IGN);
+	struct string_list to_stdin = STRING_LIST_INIT_DUP;
+	run_hooks_opt_init_async(&opt);
 
-	strbuf_init(&buf, 256);
+	strvec_push(&opt.args, transport->remote->name);
+	strvec_push(&opt.args, transport->url);
 
 	for (r = remote_refs; r; r = r->next) {
 		if (!r->peer_ref) continue;
@@ -1205,30 +1190,20 @@ static int run_pre_push_hook(struct transport *transport,
 		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
-		strbuf_reset(&buf);
-		strbuf_addf( &buf, "%s %s %s %s\n",
+		strbuf_reset(&tmp);
+		strbuf_addf(&tmp, "%s %s %s %s",
 			 r->peer_ref->name, oid_to_hex(&r->new_oid),
 			 r->name, oid_to_hex(&r->old_oid));
-
-		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			/* We do not mind if a hook does not read all refs. */
-			if (errno != EPIPE)
-				ret = -1;
-			break;
-		}
+		string_list_append(&to_stdin, tmp.buf);
 	}
 
-	strbuf_release(&buf);
-
-	x = close(proc.in);
-	if (!ret)
-		ret = x;
-
-	sigchain_pop(SIGPIPE);
+	opt.feed_pipe = pipe_from_string_list;
+	opt.feed_pipe_ctx = &to_stdin;
 
-	x = finish_command(&proc);
-	if (!ret)
-		ret = x;
+	ret = run_hooks("pre-push", &opt);
+	run_hooks_opt_clear(&opt);
+	strbuf_release(&tmp);
+	string_list_clear(&to_stdin, 0);
 
 	return ret;
 }
-- 
2.31.0.rc2.261.g7f71774620-goog

