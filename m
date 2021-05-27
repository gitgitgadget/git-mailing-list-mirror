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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08274C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD70C613BE
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhE0AMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhE0ALf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:11:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D6BC061355
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u13-20020a25f80d0000b029051d7fee31cfso3608481ybd.22
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EneeTqZADKMKCck0hLyFMbFE6wKTgQCUhaB2t5/Qwvo=;
        b=eoI2LE5K2ZtBveXSxqDhJMCAx9wQQdpY8gaH1l9KJckwwm6M399hRqs8JjBBUFmgto
         yJItAbTkgUdQB5+Sr98swa7vlXpcwLFBqKOxMnXish++i+nVQymdGmKBjrzfDK/kZ1+B
         cD9xbp4PMNP8SWYoG4xjkaxYLrUzg0G7sCx2VBIJjxf57zyJea6QHV3lJrkvNoh2kwzO
         nfw/k/Yh8euf/IV9uec9ZISZY6BNtrqf4r6o4sLXYYlA+l8t4U08Bb8oqleOicSCwHFv
         ep0MsXMPNMsKHvnLa2/AOguAqMSwbKQSDLpZ0JIrj3uPUTDq/SYhKZPe+ACHwZtwba4P
         EzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EneeTqZADKMKCck0hLyFMbFE6wKTgQCUhaB2t5/Qwvo=;
        b=qhovaMx6/cgekYrOTTTPdJPLdUf1YaQLnUvH+MkBaSv8HlFFVVtiZox3llkGreK8zR
         x7f1TDxiz1vOcWkv88++C6/SVRzA4TKG8gQraSp6qZ3mPAwtl3cbsuo+gu7qJJpgBa0/
         5PG15S4KOxdgXhJD3QECtRv68a1R6h7P/Vbf76PvetV6RwCPjMTD79gK5Cl6wgBQ+Sc8
         Umw4pAmeolKfxhcN8OZbcafC9FQJu6dtZgksv8EPwbLMwGv9MxiroxbeR64W1PMMZalE
         HKY8Hx6v9btBYezSq3KQcUelhtINW/YArBuKwJWv/SbCfgBuR6F3kljZUkngoXPkjzX7
         5E7A==
X-Gm-Message-State: AOAM533Dhyo8+IRBOpM5IuVsuSrMbVyKEMst9fipKONRiDzgJt8LreyQ
        rgJcUPavrLzDiNe0zvKWhCY04WSJes+N+EYN14Wf21gXsyX3D8M6TfIThZwgfpj1PXPDZull114
        wlX3sNmKlTuYtkk0TsOtbWUwCAfwXewOfI6I8s+iafaowzsyxT7pV+fq3zgddEdHNno7LCkZYtA
        ==
X-Google-Smtp-Source: ABdhPJwXxeYsv4UnDAcnyCUOd/AdUJpUgcOzgyeyDfbxOKUR+zvO/C2hHzHcpWBOG9plEpxOSgzW+xSlYMT4kCUFO7I=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ba0c:: with SMTP id
 t12mr893092ybg.158.1622074193240; Wed, 26 May 2021 17:09:53 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:46 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-28-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 27/37] transport: convert pre-push hook to use config
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
index 156e4809f6..543244ec0a 100644
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
index 6cf3da19eb..dbc7bb7820 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "hook.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -1196,31 +1197,15 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
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
@@ -1229,30 +1214,20 @@ static int run_pre_push_hook(struct transport *transport,
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
2.31.1.818.g46aad6cb9e-goog

