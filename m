Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C1499F0C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965510; cv=none; b=Dnmb3InAod+aSVDjV+1MSV4Aol/OKSAuO6UsABNZX5hBM3wVugm0QOao7sfF8PatBizcGBpvDhfqtZ3wJaiRnFCwbyksozRLgQxBsrT7DWUXLMMPS89JTCIWmqUFDV+MLvJJva/muNj8pAWvqX/1/AEReAzfYKJhgkhUfX7B82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965510; c=relaxed/simple;
	bh=d2PdAAgHCXuc6zWaMBIRjqzlaqXGbmx1VFGKAAhFK9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNBEBg/PlhtR4w359RXo6UNs99SuyoZ55fqstCM1VZrz5pYMCMjQRi+Eh8TFJ0VBTKRf6qHiHbVpqOsR+ja+STfXlf3e2jrTuI8q12Bj2dtt+/xECd8hVS41YghUqbUUbuqKVCoVe2vqYZHPCMXhFpyzZLepFCyAWZVN7KUruZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/f1RH22; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/f1RH22"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so59282475e9.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965503; x=1789570303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e0T7VKfLPXU7CxW1/oFVCqlAoEwd6NpgNUJW8JDIxr8=;
        b=E/f1RH22ptZVZioZ9v5YMnZzUkn/vgZegGlp+HNYGwRgCJGrjQWCGCidV7nFfArIoI
         XlqLMhar7tfAzA9DU5gUEHufChrh3df3ReBztaiHeJEX/Dj9CdKbbeYEKabBiJcoFXis
         YqiWNJs8XBPCIvgfPmeFNDoHM/xXE/OLjaU+MZm7P332j+s7M8tG2TkCU9AmlXX2PaVh
         KWMD8XcNphUCa9PclSxbHR6rxmhO32ZKrUnuKl/vhU8TtNFhTAr1RJWzDscQDFtNO+vp
         /uTWcICBrDP/ykfEwBqq72icLsuAE01UZ/h2J/jCIbqT35I0QlYbVZ4tYTob65ZbpqFT
         KMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965503; x=1789570303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0T7VKfLPXU7CxW1/oFVCqlAoEwd6NpgNUJW8JDIxr8=;
        b=RRHG5d2bGIGz5aeQn4bjzijGGolnygXm/zs9r8yOkkneawnPLkPdeLZalanpgNgJh2
         l4OSsvvF3SEQNPfaootexXKiBOz0BAv1/yxyMdOBQaxaSzM1KZKL9+gtIDDnB9ub4C3y
         Atn8nkBhcLF5qZXhTP4NsT09VGKbW+cN8aMCJM5EMWq8cKc4zRGd7aSvrIPlJF1wCfKk
         K1Gwi2zqBTpsuMkwGq6+0/FRUkcopCpPodpt03TrnyFEVxqC2cYIC67rboB+0n5nA91x
         M4DKNR5Ui6zN9CqKKE3yXCA7GCzmwa76DXnGWJkXlpnZ/Evl55FTY6GrHRKr4kTQmhZ2
         HolQ==
X-Gm-Message-State: AFuF++n5aRQJNYNk/0Tjk/F4TIzc+AKyVcHi2uzcsLgSMqG8k2Dw0t19
	5bWWGvP+QKvrQQEjFY9ucxeb4Hj56feKtfV1cf2Ft0nuDqH5rEqKi9V3
X-Gm-Gg: AYBFou02DGhC7hVTM8c3js5HhNY3yjBJiBlulhRZ5ieHnQWmsiwMVFQ184P21kYEOu9
	i0VtsbL+3sqiSctBTDUjMFukNwAptCt1x/ZSLgtxPkLYQAxaj+Rz5HKaolXwhG/xHzcYv0llseZ
	LgBqf4FpCBZJYs3qmqoSl/j2/6GJzR+GGaRT/qvRwDT8gIccCeaRYYAEXxViG2aVsMoM4KCzEWP
	mRUFFqe3Iv6xGYXxrAb1sklL8ShTKQn9bM19lhXyv9bxAIFvoifF4aHAZR++kdNPg0yICZB0AhS
	3QvRWqFe4KFnV9u7CjF2DjQmhFvNMvfge9ieuBoZ0DmYH7gPPutPcbtz1cbcKnFZLnXnpagL9RN
	STBBG9tJKzgS1E8e5FHyNY/Q3DErkGGjwFapn6YI0qBdXnLIZvoozHWZ0E7yCETR/JmAvCPzC84
	e1/WrRnbgv/CPv66AdjGJPvFvKCXHb+A58x1sBOBTXOkDOMSMflpJ6h7lTaAPByUpgsyBSw8uAH
	o1/WvvG5QVF2eIsdzZKdM/iTLi0grfx+oecDg==
X-Received: by 2002:a05:600c:4e87:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49d1df625b8mr90887295e9.21.1788965503199;
        Wed, 09 Sep 2026 07:51:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:a4c9:a6b9:39b9:91bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm661451095e9.13.2026.09.09.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:51:42 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 09 Sep 2026 16:51:39 +0200
Subject: [PATCH v9 4/4] hook: introduce the receive-report hook
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-758-introduce-hook-v9-4-3043d417e0ee@gmail.com>
References: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
In-Reply-To: <20260909-758-introduce-hook-v9-0-3043d417e0ee@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19440;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=d2PdAAgHCXuc6zWaMBIRjqzlaqXGbmx1VFGKAAhFK9k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqhcnrijPjrpntJe67N4LZEyO9BtLdaovYMy
 VkyWvAXhfQlZ4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqoXJ6AAoJED7VnySO
 Rox/HLoL/3FCYiDzM/86vFCgOY1ijbqfZR4sivjgrr8vlEdLWTZQU72IKVf/sWsZuapY9X7P3/g
 apH+DN4764DmvdCc6D3mNhhnfya74w+SJkTL1jwlOr9bivvaO/TO/Hl99dsecneSDzhTq9kav3d
 XtF1y7wTRUJ4EM7GGeE538O8mMFdF9F/zV7/ZjdBaYA426vNTyHgRkB3qX6kacSoco4iMB2TILG
 z7Y4xKSlGO5UpblGV7rdVUVrHrSc7v+5eMspmIB9eINrbMMxQx03K1HZIQJLvMhXyPpWM+cFSCV
 NercAi4GfvRs/bMjfCdO1HDZA3bNbogYrWWL4Jiife7iH3q6MHtHU16fhHWFoNBP6mRfwHzLjac
 lADCBwWo17nPXoMWdscWJM65vYV1j/LJCEj+K7gRA/aULD3QzWVfEc4Z+DmAaZNpm1dU2l0RuSi
 LRv/xbDaYsczZEWvFLsLJ+bTAv9IbBEoi/D03YNKwxXmYExH72LL/AOslCynTdO/7sE23l6kar7
 yo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When running 'git-receive-pack(1)', there is no way for the server to
intercept and modify the status report before it is sent back to the
client. Servers with custom logic may need to transform or gate the
report based on the outcome of external logic post reference updates.

This is specially needed for our usecase at GitLab where we have custom
MVCC logic on top of Git which creates a new version for each push
operation. The new version is only committed when certain external
operations post reference transaction succeed. So reporting the correct
message based on the outcome of these operations is important.

The outcome of these operations is only known after `execute_commands()`
has returned and before the report is written. There is no point in
receive-pack where the server can act on that.

We cannot use any of the existing hooks as:

  - The pre-receive hook runs too early, as we haven't updated
    references at that point yet and we need to have the full view of
    all resulting updates (both objects and references).

  - The update hook is too inefficient as it runs once per reference,
    and we cannot trivially determine the last update.

  - The reference-transaction hook is not suited for this. It fires from
    within `ref_transaction_commit()`, which is before the outcome we
    need to report is known, so there is no phase at which it could give
    us the answer. It also does not contain any knowledge regarding the
    push and cannot communicate with the clients.

  - The proc-receive hook replaces execute_commands() for references
    matching 'receive.procReceiveRefs'. We need to gate the report for
    the push as a whole.

  - The post-receive and post-update hooks cannot be used as they run
    too late, at the point where we have already reported success to the
    client.

Introduce a new 'receive-report' hook. The hook receives the complete
pkt-line encoded status report on standard input, after all ref updates
have been applied to the repository by execute_commands() but before the
report is sent to the client. See linkgit:gitprotocol-pack[5] details on
the protocol structure.

The hook's stdout fully replaces the report sent to the client.
receive-pack fully buffers the hook's stdout before acting on the exit
status, so the exit code is known before the client receives anything.
This gives two distinct behaviors depending on exit status:

- Exit 0: the hook's stdout is used as the report. The hook can
  rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
  client while receive-pack itself exits cleanly. The client marks
  rejected refs as '[remote rejected]' and exits with a non-zero
  status if any ref is 'ng'.

- Non-zero exit: the hook's stdout is discarded, receive-pack modifies
  all references to be rejected with a 'receive-report hook failed'
  error.

In both cases, any output the hook writes to standard error is
forwarded to the client over the sideband channel and appears as
'remote:' lines on the client terminal. Writing to stderr alone does
not affect the push outcome.

Reference updates applied by execute_commands() are not rolled back in
either failure mode. The hook can cause the client to perceive the push
as failed, but cannot undo server-side changes. This creates a
divergence that the server cannot resolve: the client leaves its
remote-tracking reference at the old value while the update is in fact
applied, and a later fetch may reveal the update that the push reported
as rejected.

The hook is therefore only appropriate for servers which can guarantee
that a rejected update is not observable by any reader. In our case the
transaction committed by execute_commands() produces a candidate version
which is not visible to other readers and is only published once the
subsequent operations succeed, so a report of 'ng' corresponds to a
version that is discarded rather than published. On a repository where a
committed reference update is immediately visible, rejecting a push from
this hook would instead leave the pusher with a view that does not match
the server.

This hook does not use the config-based hook infrastructure, which
supports running multiple scripts per hook event. This hook is a
bidirectional filter: it receives the report on stdin and writes a
modified version to stdout. Running multiple such scripts sequentially
would require piping the output of one into the input of the next,
which the current hook infrastructure does not support. A single-script
design is therefore a natural fit, and is consistent with how
'proc-receive' is structured for the same reason.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc |   9 ++
 Documentation/githooks.adoc         |  61 ++++++++++
 builtin/receive-pack.c              |  47 ++++++++
 t/meson.build                       |   1 +
 t/t5412-receive-report-hook.sh      | 224 ++++++++++++++++++++++++++++++++++++
 5 files changed, 342 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 5806792ba7..ab668ffa0c 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -245,6 +245,15 @@ commands will be executed by this hook, instead of by the internal
 `execute_commands()` function.  This hook is responsible for updating
 the relevant references and reporting the results back to 'receive-pack'.
 
+RECEIVE-REPORT HOOK
+-------------------
+This hook is invoked by 'git-receive-pack' after all the ref updates
+have been applied but before the report is sent to the client. The hook
+receives the complete report in pkt-line format on stdin and its stdout
+replaces the report sent to the client, which allows the hook to rewrite
+the outcomes or abort the push completely. See linkgit:githooks[5] for
+the full protocol description.
+
 QUARANTINE ENVIRONMENT
 ----------------------
 
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..145642bf05 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -527,6 +527,67 @@ The exit status of the hook is ignored for any state except for the
 status will cause the transaction to be aborted. The hook will not be
 called with "aborted" state in that case.
 
+receive-report
+~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates references in its repository. It executes on
+the repository once after all refs have been updated and after all
+accepted ref changes are applied to the repository, but before the
+pkt-line encoded status report is sent back to the client.
+
+The hook receives the complete pkt-line encoded status report on
+standard input, see linkgit:gitprotocol-pack[5] for details on the
+structure. The hook's standard output entirely replaces the report
+that is sent to the client. The hook must write a valid pkt-line
+encoded report in the same format it received. The hook's stdout is
+fully buffered by `receive-pack` before any data is sent to the client,
+so the hook's exit status is known before the client receives anything.
+
+There are three distinct ways the hook can affect the push outcome:
+
+* To reject the push, modify the unpack status from `ok` to the required
+  error message. While `git-push` will fail, individual references may
+  still show success messages unless modified.
+
+* To reject individual ref updates while keeping `receive-pack` alive,
+  rewrite the corresponding `ok <refname>` lines to
+  `ng <refname>[ <reason>]` lines in the output and exit with status 0.
+  The client will then mark those specific refs as rejected while
+  treating any `ok` refs as successful. The push as a whole is
+  considered failed if any ref is `ng`, and `git push` will exit with
+  a non-zero status on the client side.
+
+* To abort the entire push unconditionally, exit with a non-zero
+  status. In this case the hook's stdout is discarded, `receive-pack`
+  modifies all references to be rejected with a 'receive-report hook
+  failed' error.
+
+Any output written to standard error is forwarded to the client over
+the sideband channel and will appear as `remote:` lines on clients
+using 'git-push(1)', regardless of the hook's exit status. Writing to
+standard error alone does not affect the push outcome.
+
+Note that by the time this hook runs, all ref updates have already been
+applied to the repository. Neither a non-zero exit nor rewriting refs
+to `ng` rolls back any ref changes that were already committed
+server-side. The hook can cause the client to perceive the push as
+failed, but cannot undo the server-side updates.
+
+This means that reporting a reference as `ng` makes the client believe
+the update did not happen while the server has in fact applied it. The
+client leaves its remote-tracking reference at its old value, and a
+later `git fetch` may reveal the very update that the push reported as
+rejected. Neither Git nor the server can reconcile this; only the user,
+by fetching again, will find out.
+
+This hook is therefore only appropriate for servers which can guarantee
+that a rejected update is not observable by any reader, for example
+because the committed transaction produces a candidate state that is
+discarded rather than published. On a repository where a committed
+reference update is immediately visible, using this hook to reject a
+push will leave the pusher with a view that does not match the server.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8b1ae4f7f3..8bd95c41dd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -992,6 +992,41 @@ static int run_update_hook(struct command *cmd)
 	return code;
 }
 
+static int run_receive_report_hook(struct strbuf *report)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	struct async sideband_async;
+	int sideband_async_started = 0;
+	int saved_stderr = -1;
+	struct strbuf out = STRBUF_INIT;
+	const char *hook_path;
+	int ret;
+
+	hook_path = find_hook(the_repository, "receive-report");
+	if (!hook_path)
+		return 0;
+
+	strvec_push(&proc.args, hook_path);
+	proc.trace2_hook_name = "receive-report";
+
+	prepare_sideband_async(&sideband_async, &saved_stderr,
+			       &sideband_async_started);
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+	ret = pipe_command(&proc, report->buf, report->len, &out,
+			   report->len, NULL, 0);
+	sigchain_pop(SIGPIPE);
+
+	finish_sideband_async(&sideband_async, saved_stderr,
+			      sideband_async_started);
+
+	if (!ret)
+		strbuf_swap(&out, report);
+
+	strbuf_release(&out);
+	return ret;
+}
+
 static struct command *find_command_by_refname(struct command *list,
 					       const char *refname)
 {
@@ -2414,6 +2449,12 @@ static void update_shallow_info(struct command *commands,
 	free(ref_status);
 }
 
+static void override_cmds_error(struct command *commands, const char *err)
+{
+	for (struct command *cmd = commands; cmd; cmd = cmd->next)
+		cmd->error_string = err;
+}
+
 /*
  * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
  */
@@ -2467,6 +2508,12 @@ static void report(struct command *commands, const struct strbuf *unpack_status,
 
 	generate_report(&buf, commands, unpack_status, version);
 
+	if (run_receive_report_hook(&buf)) {
+		strbuf_reset(&buf);
+		override_cmds_error(commands, "receive-report hook failed");
+		generate_report(&buf, commands, unpack_status, version);
+	}
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
diff --git a/t/meson.build b/t/meson.build
index 7f53cca7d1..692e6011c5 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -652,6 +652,7 @@ integration_tests = [
   't5409-colorize-remote-messages.sh',
   't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
+  't5412-receive-report-hook.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/t5412-receive-report-hook.sh b/t/t5412-receive-report-hook.sh
new file mode 100755
index 0000000000..24679de37b
--- /dev/null
+++ b/t/t5412-receive-report-hook.sh
@@ -0,0 +1,224 @@
+#!/bin/sh
+
+test_description='test receive-report hook'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/t5411/common-functions.sh
+
+URL_PREFIX="\.\."
+
+test_expect_success "setup workbench" '
+	git init workbench &&
+	create_commits_in workbench A B
+'
+
+test_expect_success "no report hook, push succeeds" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+	git init --bare upstream &&
+
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "passthrough does not alter report" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+	git init --bare upstream &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	cat
+	EOF
+
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "non-zero exit reports as hook failed" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	 ! [remote rejected] <COMMIT-B> -> main (receive-report hook failed)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook is invoked and receives report on stdin" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	test_hook -C upstream --setup receive-report <<-EOF &&
+	tee raw
+	EOF
+
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual &&
+
+	test-tool pkt-line unpack <upstream/raw >actual-report &&
+	cat >expect-report <<-EOF &&
+	unpack ok
+	ok refs/heads/main
+	0000
+	EOF
+	test_cmp expect-report actual-report
+'
+
+test_expect_success "hook can modify the report sent to client" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	test-tool pkt-line unpack |
+	sed "s/^ok /ng /" |
+	test-tool pkt-line pack
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	 ! [remote rejected] <COMMIT-B> -> main (failed)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook can modify the unpack status" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	test-tool pkt-line unpack |
+	sed "s/^unpack ok$/unpack push failed due to server error/" |
+	test-tool pkt-line pack
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "error: remote unpack failed: push failed due to server error" out &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	   <COMMIT-A>..<COMMIT-B>  <COMMIT-B> -> main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook can report a custom failure message" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	echo "push rejected: service X is down" >&2
+	test-tool pkt-line unpack |
+	sed "s/^ok \(.*\)/ng \1 service-x-is-down/" |
+	test-tool pkt-line pack |
+	tee raw
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "push rejected: service X is down" out &&
+
+	test-tool pkt-line unpack <upstream/raw >actual-report &&
+	cat >expect-report <<-\EOF &&
+	unpack ok
+	ng refs/heads/main service-x-is-down
+	0000
+	EOF
+	test_cmp expect-report actual-report
+'
+
+test_expect_success "hook stderr with zero exit status code" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	echo "push rejected: service X is down" >&2
+	tee raw
+	EOF
+
+	git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "push rejected: service X is down" out &&
+
+	test-tool pkt-line unpack <upstream/raw >actual-report &&
+	cat >expect-report <<-\EOF &&
+	unpack ok
+	ok refs/heads/main
+	0000
+	EOF
+	test_cmp expect-report actual-report
+'
+
+test_expect_success "hook stderr is relayed to client via sideband" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup receive-report <<-\EOF &&
+	echo "hook-stderr-message" >&2
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	test_grep "remote: hook-stderr-message" out
+'
+
+test_done

-- 
2.55.GIT

