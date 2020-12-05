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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622CC0018C
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2969722DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbgLEBvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbgLEBvS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:18 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B4BC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:17 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a68so383933qke.9
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=laI+uaEe5qVGexpios/bNivrDFPmGSTg0P4eL31+qu4=;
        b=HvMm7FVNLobbIxbZHiNbrvhxkRKoqjN0TDvCC+dRxEPo3QbJxZy056h7YS7HMNVQ8x
         DogpuLdZ3mlFGbTk9dM9mONfwS9TmGYvj81f9XaXxkrp9TruvGpP9eX0tqrIUUUG9Nce
         282hezfqrmArCYlAFMiQjAXGKo+HvVUJNyDn41CHCe9ojq7qcN1fV3sMdmBPeY0Tt6L3
         FYj7WZpNMobeqCvNXGHUujqa6MtU5YInPvx8SvFY11SBrDXHajRl+JartcPwgZkawJ4f
         +/yKkdXph/wRfI1BMn2/vcqD5dohoyNEeXXcPE+jTW6gzK1w2Kt95BRrc94ZhixpWdzt
         LsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=laI+uaEe5qVGexpios/bNivrDFPmGSTg0P4eL31+qu4=;
        b=cXmfVT/sjNJAhdFo2sHAV2cMCwiXCM5j15AqBosWhGnwtgAa9FGE6TlKT/mZmW7aw8
         LoEHsvu8W0N2dIEdCJ4sI/4Jgau+vWVMuoQwDzc05SH5RWNKYtbaDnA0fVqMWMR2cI4r
         KGW/ZvzE8FKHWCjRlhPij2QkfeGMceXX7lq2Z5IxKNJdPbUuMQoxKseWGxV25XlNIRDW
         EBwhfTJ9EqwCZr31p1lyr/n+TSTl+aBgyL34jR/667ChLqDYMarR3rLk9jRAw3SQnI88
         35+4/n4vHWpJWy6DCUGzXFG2Oq8vwBsm3QN4lLD0545KYVMLWzYu77vblkpAJLKTvbFh
         gfyg==
X-Gm-Message-State: AOAM533zY24fXaTJGH8iEDDvYckPSgxvDZGEJ6XPSkwhVzLOueaIxaoa
        AAJFycUD4Ahsa7vxB1sfiU5szpn7WBzlB3QaQNAWdj4J8wE52QUQxl5s1fT5tF4CvjPaTNcZzWv
        vtmgGSNa43iuvTEierUTcFSBSLKl71ba+Bl19SluR8joHe7Zmi96YnjyZ4RG+KQhclNfWxFR0KA
        ==
X-Google-Smtp-Source: ABdhPJxQZQhQrHVpnHXtDB2JGGfH9Byqfcrsi0HzWpUzjB7wrS8CTgUDnPY349NyGB9J0xMATP11fLc0W+m0b2f5lKQ=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:aed4:: with SMTP id
 n20mr9007235qvd.16.1607133016573; Fri, 04 Dec 2020 17:50:16 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:42 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-15-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 14/17] proc-receive: acquire hook list from hook.h
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
index 2b3a74f249..2c59c537f9 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -423,6 +423,10 @@ the input.  The exit status of the 'proc-receive' hook only determines
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
index cd79ad6bdc..b929a3505c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1137,11 +1137,40 @@ static int run_proc_receive_hook(struct command *commands,
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
+			case hookdir_interactive:
+			case hookdir_no:
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
index 0000000000..de07b27b88
--- /dev/null
+++ b/t/t5411/test-0015-too-many-hooks-error.sh
@@ -0,0 +1,47 @@
+test_expect_success "setup too  many proc-receive hooks (ok, $PROTOCOL)" '
+	write_script "proc-receive" <<-EOF &&
+	printf >&2 "# proc-receive hook\n"
+	test-tool proc-receive -v \
+		-r "ok refs/for/master/topic"
+	EOF
+
+	git -C "$upstream" config --add "hook.proc-receive.command" proc-receive &&
+	cp proc-receive "$upstream/hooks/proc-receive"
+'
+
+# Refs of upstream : master(A)
+# Refs of workbench: master(A)  tags/v123
+# git push         :                       next(A)  refs/for/master/topic(A)
+test_expect_success "proc-receive: reject more than one configured hook" '
+	test_must_fail git -C workbench push origin \
+		HEAD:next \
+		HEAD:refs/for/master/topic \
+		>out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	remote: # pre-receive hook
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: error: only one "proc-receive" hook can be specified
+	remote: # post-receive hook
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/next
+	To <URL/of/upstream.git>
+	 * [new branch] HEAD -> next
+	 ! [remote rejected] HEAD -> refs/for/master/topic (fail to run proc-receive hook)
+	EOF
+	test_cmp expect actual &&
+	git -C "$upstream" show-ref >out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	<COMMIT-A> refs/heads/master
+	<COMMIT-A> refs/heads/next
+	EOF
+	test_cmp expect actual
+'
+
+# Refs of upstream : master(A)             next(A)
+# Refs of workbench: master(A)  tags/v123
+test_expect_success "cleanup ($PROTOCOL)" '
+	git -C "$upstream" config --unset "hook.proc-receive.command" "proc-receive" &&
+	git -C "$upstream" update-ref -d refs/heads/next
+'
-- 
2.28.0.rc0.142.g3c755180ce-goog

