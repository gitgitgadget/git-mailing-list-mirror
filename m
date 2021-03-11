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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E872BC43619
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93B964F95
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhCKCMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCKCLr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8226C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q77so23901209ybq.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wv0bagwdGF+ihtw9M+5GyHkA/IifsGG8RsRqefVeV7c=;
        b=TDrcpKxVqDjbM6bciyTAJDnSTpjTJ8Q0Hl7hECUnuHdvVgbRZts6VWw5d7x5D8pCKX
         8IzFUSksj4ayQSXIldJMZVCt5VcPbdPalJRPyfOCGpo7KumokmbIcThwqefiUMMmW4CN
         dOQG4Rf7j7sdUdNMdo0ZJ/vsclvNKr7evMjzqBtjTdIjxIhGW8yBvYIgTnf/6RTJxiNx
         5y3TZXrTWrjMCdLuGMNtXFGttePZhQa/1WNg8sOIgvWRFbNjA5H9RE+pXJJCQeLiwXK7
         2XTzGrL7PeLOdhplUilOJlVpPO9TAeNpyDjzx/jg/RUoATooB1D43LogAGYKGZssxdcF
         pINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wv0bagwdGF+ihtw9M+5GyHkA/IifsGG8RsRqefVeV7c=;
        b=Rjxy1yxoy9Wth2VVKtppDqcyrr8rNwd+1biqbpRL8bE+yB+HXakF/zaAckAZVt/qCx
         TKbjJuvjoSgWXggTZERPkkv9PmuWucId04Uyj99W7KFDv6Q13vd2pBUXwNGsiFoNMBwf
         ZTc0HlCoVGLx5C57ksYfqaSKA7wHVlc7hWI+bGDUrwiFXF4m4qBoZFDuYMEtD+leJnkv
         ts4bZoJ2rBaqJpbxmxaOljjcQ6SFgXFt/s313vTqBWRihesxdTR/CxiN8W9sf30vMXDE
         W7lvVlWmqTKRs2X0doAvWWBSoZDLYyell5PqhI2ggOW3XADvdJGckJXUe6pjHoxZsrb8
         QDvg==
X-Gm-Message-State: AOAM530JFbwcRy4CStmWklJ/4nEzJUdObKYlXpaKaDoa//wrhKvHlmc9
        kfzha73EXCejcWcIeS1+3heoY3mR4SEHO0y23kI9LSW6EsebsK8K20esNYZR+b8UispRUqGrP/0
        S8gEOrKUbVi2NrbljVqg2V089iTN3mmhhw3nBtkcbyaqohTdOWBLMw8Ft4oe9TeyhCfJ5m7fOJQ
        ==
X-Google-Smtp-Source: ABdhPJzC92YdYxUPJg0lPdFdosmCSai05FiBsPlD2ZAPCfmsYeI8RXc94sxT5fUgG8roM4NFMxhPSmpMq8I+q9E1gJ0=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6902:6ac:: with SMTP id
 j12mr8190920ybt.440.1615428706072; Wed, 10 Mar 2021 18:11:46 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:31 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-32-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 31/37] proc-receive: acquire hook list from hook.h
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proc-receive hook differs from most other hooks Git invokes because
the hook and the parent Git process engage in bidirectional
communication via stdin/stdout. This bidirectional communication is
unsuitable for multiple hooks, whether they are in series or in
parallel, and is incompatible with run-command.h:run_processes_parallel:

- The proc-receive hook is intended to modify the state of the Git repo.
  From 'git help githooks':
    This [proc-receive] hook is responsible for updating the relevant
    references and reporting the results back to 'receive-pack'.
  This prevents parallelization and implies, at least, specific ordering
  of hook execution.
- The proc-receive hook can reject a push by aborting early with an
  error code. If a former hook ran through the entire push contents
  successfully but a later hook rejects some of the push, the repo may
  be left in a partially-updated (and corrupt) state.
- The callback model of the run_processes_parallel() API is unsuited to
  the current implementation of proc-receive, which loops through
  "send-receive-consider" with the child process. proc-receive today
  relies on stateful communication with the child process, which would be
  unwieldy to implement with callbacks and saved state.
- Additionally, run_processes_parallel() is designed to collate the
  output of many child processes into a single output (stderr or callback),
  and would require significant work to tell the caller which process sent
  the output, and indeed to collect any output before the child process
  has exited.

So, rather than using hook.h:run_hooks() to invoke the proc-receive
hook, receive-pack.c can learn to ask hook.h:hook_list() for the
location of a hook to run. This allows users to configure their
proc-receive in a global config for all repos if they want, or a local
config if they just don't want to use the hookdir. Because running more
than one proc-receive hook doesn't make sense from a repo state
perspective, we can explicitly ban configuring more than one
proc-receive hook at a time.

If a user wants to globally configure one proc-receive hook for most of
their repos, but override that hook in a single repo, they should use
'skip' to manually remove the global hook in their special repo:

~/.gitconfig:
[hook.proc-receive]
  command = /usr/bin/usual-proc-receive

~/special-repo/.git/config:
[hookcmd./usr/bin/usual-proc-receive]
  skip = true
[hook.proc-receive]
  command = /usr/bin/special-proc-receive

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/githooks.txt                |  4 ++
 builtin/receive-pack.c                    | 33 +++++++++++++++-
 t/t5411/test-0015-too-many-hooks-error.sh | 47 +++++++++++++++++++++++
 3 files changed, 82 insertions(+), 2 deletions(-)
 create mode 100644 t/t5411/test-0015-too-many-hooks-error.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 60fd43d1da..c16353be2d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -433,6 +433,10 @@ the input.  The exit status of the 'proc-receive' hook only determines
 the success or failure of the group of commands sent to it, unless
 atomic push is in use.
 
+It is forbidden to specify more than one hook for 'proc-receive'. If a
+globally-configured 'proc-receive' must be overridden, use
+'hookcmd.<global-hook>.skip = true' to ignore it.
+
 [[post-receive]]
 post-receive
 ~~~~~~~~~~~~
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b34a27a303..e448956a32 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1146,11 +1146,40 @@ static int run_proc_receive_hook(struct command *commands,
 	int version = 0;
 	int code;
 
-	argv[0] = find_hook("proc-receive");
-	if (!argv[0]) {
+	struct strbuf hookname = STRBUF_INIT;
+	struct hook *proc_receive = NULL;
+	struct list_head *pos, *hooks;
+
+	strbuf_addstr(&hookname, "proc-receive");
+	hooks = hook_list(&hookname);
+
+	list_for_each(pos, hooks) {
+		if (proc_receive) {
+			rp_error("only one 'proc-receive' hook can be specified");
+			return -1;
+		}
+		proc_receive = list_entry(pos, struct hook, list);
+		/* check if the hookdir hook should be ignored */
+		if (proc_receive->from_hookdir) {
+			switch (configured_hookdir_opt()) {
+			case HOOKDIR_INTERACTIVE:
+			case HOOKDIR_NO:
+				proc_receive = NULL;
+				break;
+			default:
+				break;
+			}
+		}
+
+	}
+
+	if (!proc_receive) {
 		rp_error("cannot find hook 'proc-receive'");
 		return -1;
 	}
+
+
+	argv[0] = proc_receive->command.buf;
 	argv[1] = NULL;
 
 	proc.argv = argv;
diff --git a/t/t5411/test-0015-too-many-hooks-error.sh b/t/t5411/test-0015-too-many-hooks-error.sh
new file mode 100644
index 0000000000..2d64534510
--- /dev/null
+++ b/t/t5411/test-0015-too-many-hooks-error.sh
@@ -0,0 +1,47 @@
+test_expect_success "setup too  many proc-receive hooks (ok, $PROTOCOL)" '
+	write_script "proc-receive" <<-EOF &&
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/main/topic"
+	EOF
+
+	git -C "$upstream" config --add "hook.proc-receive.command" proc-receive &&
+	cp proc-receive "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
+# git push         :                       next(A)  refs/for/main/topic(A)
+test_expect_success "proc-receive: reject more than one configured hook" '
+	test_must_fail git -C workbench push origin \
+		HEAD:next \
+		HEAD:refs/for/main/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
+	remote: error: only one "proc-receive" hook can be specified
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 ! [remote rejected] HEAD -> refs/for/main/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/main
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : main(A)             next(A)
+# Refs of workbench: main(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" config --unset "hook.proc-receive.command" "proc-receive" &&
+	git -C "$upstream" update-ref -d refs/heads/next
+'
-- 
2.31.0.rc2.261.g7f71774620-goog

