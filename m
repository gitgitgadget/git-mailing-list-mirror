Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587B403B1F
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 10:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566872; cv=none; b=fXLclas3YetyA4SjLYl7+6tQ03+q7JutbrdJEmHEsX42GLvgUpByQZI0jJWQcc+/d6OzZ6FhjPIA9mK0lpeoWBjRI0CwUfdJlclrBXyjp3j8Lh9AnXh2DC/dTxMEfXFqRxqIMamWFXln+nOK+iwumCB3w7xNYctK91ABwCCHkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566872; c=relaxed/simple;
	bh=XVWx55nIwt3+iTiV3Avgzn5G5k9nc8zm3OiDf2QweQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbU4HUXoz+hVlzGXJ38otaQxEVxk4aLuD8+wHszt8gwodMv+dihl7VMWnfaG8Z15EpyYHno0b6j0oq1y8gldcA4Mav3Cf5sfi3e6h6C/ToD9ycKRPIikGft/P+36fm0UEWishaZsudR6NEu7ZEGnK3L3Dlg4iAQjIpiyvaAcsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSoIGqn7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSoIGqn7"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c169ae1cb26so854558666b.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787566868; x=1788171668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xcRG5pIKDNVrYe268rCPkXTZIcGprNi9tpEuE25/Q94=;
        b=VSoIGqn7vMvQbjb9ApoecWdjUqBiQpS4U5kSawyF2II5JqqAYEHzyn/c0rC8DcdSyw
         bqwz4JtgJYV7WEl7ZzCYbc24mUFaGnfwZmA6X9iwkqOxzHe4xhOtnTg78hIImtt/qCqi
         UqpgWW6VkGJA1tHdOS3w7+Y9Gaej4Ga8vCrT4mozBokv3bGKXN3zXBx86EkrYxFdkI5F
         kViZMaeGpLui6r1pjd/BV1HuK9yhD1bofAFk1vEcJAshwp41JJDQsDjwkprIpArrzPYW
         l2MY62I9lIIguAwA+ClK74XDoDGDpOlXeYsBa9xuilq7DKugv7CZGO7BXp+pptlMoP6e
         3WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787566868; x=1788171668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xcRG5pIKDNVrYe268rCPkXTZIcGprNi9tpEuE25/Q94=;
        b=e3BAwZWpoOor5kBU75LQ+joxeBCnh2Ydf8nux++lwFyuQhLKu+LdUAAC5pZBuRD/pS
         wnBVq5WKSYNKBUncwoWDm8lD8+5nvHccc+h8YFB+Bcn5TCe9VIIJyv0dM8RbmLJ39zQf
         f1oZAyCshUIUCkFQQDaoKnWT1wbhR7vUeo10iPmsiPgdJid7O/MgOlXxTo3R2eAgVo6F
         jS0ARI/NV9nnzcJaUWJjS9BD/FtNBzCDpJNoEImvCSvg0VECdYKcxcRD/z1cIEOU/5DS
         BI5pg2oajhkhOPyGa91vuQSaozO8IawxNOf0Y+yo2KcsGMtfEDcrvW6aX0bvorQtqV36
         2gzA==
X-Gm-Message-State: AFuF++nMLKl8ljLSt2CxEbs9HWQ/AJYh6HEMa3bLM+QDwYTfy5bP1K93
	q1Yk2GuTdRfTDHMaSDnBUoFksJw9vQKFbzcILiGWpm/nSw+jXwPQmHNcv66uvlvY
X-Gm-Gg: AR+sD11NAyQncC6dVxyoCDmy0DDpWMrSOFfckzxBmifnxLMMTbFtOk/C049CnHzBzsT
	L/LvCRcstM+M8yoVGmgtj+3TTmOPClTW6Wzh0bdwuiU2BvzHCdstcLfJYensQZ8NYaaDWU2XWCe
	3A8po6TFc1pD0TuvL78D/vLOcGdcFhyO08910XilDkFLRRBtjkTxlWBoi0rt+H6wnjJHSoKNQBc
	Ul9cokUE9usCSLBMrIX5WoWMh0v8euSefU6RzqVqfNX2AUFWzNYnjlTBcEWqBsBojQUAFwd28rs
	UaO4NCUhygxaFYkq9V43bLyygDKMPiXcx8pT0VbaqTCB304Z4PtrK+s8cmawOOnyyaq7UiXm2MC
	HYnNMLunyvqqJEVzvmh8ZNBocW3PR7q3axIOAACnJRqdqnr/RujHLFXarDCq0wYVFhrqJGAdbg2
	0nozmiRMgy3GaoNS3qK8cp+7Dvhmzt5n2dfxuauICnV3m1ur24FvKaXfOIUC7JLrKbNi5o9l+TC
	azojQ82BaFTi8/vc5Ncc5xqtbo7
X-Received: by 2002:a17:907:c408:b0:c20:a243:9a52 with SMTP id a640c23a62f3a-c246d3bc308mr2554935566b.0.1787566867828;
        Mon, 24 Aug 2026 03:21:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d6d5:360a:4ee9:3f53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1327677066b.25.2026.08.24.03.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 03:21:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 24 Aug 2026 12:21:01 +0200
Subject: [PATCH v3 3/3] hook: introduce the report hook for
 git-receive-pack(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-758-introduce-hook-v3-3-499526f0a062@gmail.com>
References: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
In-Reply-To: <20260824-758-introduce-hook-v3-0-499526f0a062@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 jltobler@gmail.com, kristofferhaugsbakk@fastmail.com, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=17432;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=XVWx55nIwt3+iTiV3Avgzn5G5k9nc8zm3OiDf2QweQ4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqMGw+2VnoMIGkfcPxXxLG9RmvUa3DzwRYXZ
 Gw0nwmvoyn0hokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjBsPAAoJED7VnySO
 Rox/MbIL/1AXhJsfHmehq+xSVLwilevfFTSit4fv1XMOLGCvqPgZYAdykZ4XN8uc5VMOr0LWn4c
 9kxpMuViiwT4F+r/I/adIjnDHHU9ivbvPCN6aIanPFzQ28kh/6EHHYtg85LsL9qLe0/kjEe+PLb
 pP7o9O7Vmall5TMxwo/tdLO+VsO7DUfAqepLdZ4Rco9bXxfW63TkK3QCs7LPNE90UDXOMtgSmkQ
 5n0u/e0VzgPdMKotdYYEMkPyJ26uDrV9dryhWh0OE3Y8raAjqw7iL4Q8GHFZR1K+pMepfajzkeh
 epEWN34ktmK5PBA6yodzrWTBUr2foEr3d6SBA9CnGQdUvmi97ogo9SEGLVxUPUWSO6azCOt8V91
 3L9juEBn/qqnqMhBS+bM8EKV47kB7LLj1Qi6hVYbEh5PnfWS9xXlFxACkIeuHVfE4u3AcSj2y19
 buifd133IqpbkLEqOTmcHSsWl6kzHE01YoeWQUq97Ahik9rNlW8+V/jOpN+nMDL1vargRMwCzr6
 70=
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

We cannot use any of the existing hooks as:

  - The pre-receive hook runs too early, as we haven't updated
    references at that point yet and we need to have the full view of
    all resulting updates (both objects and references).

  - The update hook is too inefficient as it runs once per reference,
    and we cannot trivially determine the last update.

  - The reference-transaction hook cannot be used by us because we care
    about the phase where it was committed already. And while the hook
    fires in that phase, it does not allow the caller to modify the
    result in any capacity.

  - The post-receive and post-update hooks cannot be used as they run
    too late, at the point where we have already reported success to the
    client.

Introduce a new 'report' hook. The hook receives the complete pkt-line
encoded status report on standard input, after all ref updates have
been applied to the repository by execute_commands() but before the
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
  all references to be rejected with a 'report hook failed' error.

In both cases, any output the hook writes to standard error is
forwarded to the client over the sideband channel and appears as
'remote:' lines on the client terminal. Writing to stderr alone does
not affect the push outcome.

Note that in either failure mode, ref updates already applied by
execute_commands() are not rolled back. The hook can cause the client
to perceive the push as failed, but cannot undo server-side changes.

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
 Documentation/githooks.adoc         |  43 ++++++++
 builtin/receive-pack.c              |  61 ++++++++++-
 t/meson.build                       |   1 +
 t/t5412-report-hook.sh              | 200 ++++++++++++++++++++++++++++++++++++
 5 files changed, 310 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 4349487e6a..e6cc0acaaf 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -243,6 +243,15 @@ requests. It handles refs whose names match the patterns defined by
 `receive.procReceiveRefs` and executes the actual ref updates. See
 linkgit:githooks[5] for the full protocol description.
 
+REPORT HOOK
+-----------
+This hook is invoked by 'git-receive-pack' after all the ref updates
+have been applied but before the report is sent to the client. The hook
+receives the complete report in pkt-line format on stdin and its stdout
+replaces the report sent to the client. Allowing the hook to rewrite
+the outcomes or abort the push completely. See linkgit:githooks[5] for
+the full protocol description.
+
 QUARANTINE ENVIRONMENT
 ----------------------
 
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..d148a4990c 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -527,6 +527,49 @@ The exit status of the hook is ignored for any state except for the
 status will cause the transaction to be aborted. The hook will not be
 called with "aborted" state in that case.
 
+report
+~~~~~~
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
+There are two distinct ways the hook can affect the push outcome:
+
+* To reject individual ref updates while keeping `receive-pack` alive,
+  rewrite the corresponding `ok <refname>` lines to
+  `ng <refname> <reason>` lines in the output and exit with status 0.
+  The client will then mark those specific refs as rejected while
+  treating any `ok` refs as successful. The push as a whole is
+  considered failed if any ref is `ng`, and `git push` will exit with
+  a non-zero status on the client side.
+
+* To abort the entire push unconditionally, exit with a non-zero
+  status. In this case the hook's stdout is discarded, `receive-pack`
+  modifies all references to be rejected with a 'report hook failed'
+  error.
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
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 70a686c142..138a432c15 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
 	return code;
 }
 
+static int run_report_hook(struct strbuf *report)
+{
+	struct child_process proc = CHILD_PROCESS_INIT;
+	struct async sideband_async;
+	int sideband_async_started = 0;
+	int saved_stderr = -1;
+	struct strbuf out = STRBUF_INIT;
+	const char *hook_path;
+	int ret;
+
+	hook_path = find_hook(the_repository, "report");
+	if (!hook_path)
+		return 0;
+
+	strvec_push(&proc.args, hook_path);
+	proc.trace2_hook_name = "report";
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
@@ -2534,9 +2569,12 @@ static void update_shallow_info(struct command *commands,
  * Generate the response to be sent to the client invoking 'git-receive-pack(1)'.
  * For v2 protocol, set `add_reports` to true, which will also add additional
  * report per reference update.
+ * If `ref_error` is set, then all references will be rejected with the given
+ * error message.
  */
 static void generate_response(struct strbuf *buf, struct command *commands,
-			      const char *unpack_status, bool add_reports)
+			      const char *unpack_status, bool add_reports,
+			      const char *ref_error)
 {
 	struct command *cmd;
 
@@ -2550,10 +2588,13 @@ static void generate_response(struct strbuf *buf, struct command *commands,
 		if (cmd->error_string)
 			packet_buf_write(buf, "ng %s %s\n",
 					 cmd->ref_name, cmd->error_string);
+		else if (ref_error)
+			packet_buf_write(buf, "ng %s %s\n",
+					 cmd->ref_name, ref_error);
 		else
 			packet_buf_write(buf, "ok %s\n", cmd->ref_name);
 
-		if (!add_reports || cmd->error_string)
+		if (!add_reports || cmd->error_string || ref_error)
 			continue;
 
 		for (report = cmd->report; report; report = report->next) {
@@ -2581,7 +2622,13 @@ static void report(struct command *commands, const char *unpack_status)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	generate_response(&buf, commands, unpack_status, false);
+	generate_response(&buf, commands, unpack_status, false, NULL);
+
+	if (run_report_hook(&buf)) {
+		strbuf_reset(&buf);
+		generate_response(&buf, commands, unpack_status, false,
+				  "report hook failed");
+	}
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
@@ -2594,7 +2641,13 @@ static void report_v2(struct command *commands, const char *unpack_status)
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	generate_response(&buf, commands, unpack_status, true);
+	generate_response(&buf, commands, unpack_status, true, NULL);
+
+	if (run_report_hook(&buf)) {
+		strbuf_reset(&buf);
+		generate_response(&buf, commands, unpack_status, true,
+			  "report hook failed");
+	}
 
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..7056e31326 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -651,6 +651,7 @@ integration_tests = [
   't5409-colorize-remote-messages.sh',
   't5410-receive-pack.sh',
   't5411-proc-receive-hook.sh',
+  't5412-report-hook.sh',
   't5500-fetch-pack.sh',
   't5501-fetch-push-alternates.sh',
   't5502-quickfetch.sh',
diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
new file mode 100755
index 0000000000..418f4a7155
--- /dev/null
+++ b/t/t5412-report-hook.sh
@@ -0,0 +1,200 @@
+#!/bin/sh
+
+test_description='test report hook'
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
+	test_hook -C upstream --setup report <<-\EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
+	exit 1
+	EOF
+
+	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
+	make_user_friendly_and_stable_output <out >actual &&
+	cat >expect <<-\EOF &&
+	To ../upstream
+	 ! [remote rejected] <COMMIT-B> -> main (report hook failed)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success "hook is invoked and receives report on stdin" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	test_hook -C upstream --setup report <<-EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
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
+test_expect_success "hook can report a custom failure message" '
+	test_when_finished "rm -rf upstream" &&
+	test_when_finished "git -C workbench remote remove origin" &&
+
+	git init --bare upstream &&
+	git -C workbench remote add origin ../upstream &&
+	git -C workbench push origin $A:refs/heads/main &&
+
+	test_hook -C upstream --setup report <<-\EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
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
+	test_hook -C upstream --setup report <<-\EOF &&
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

