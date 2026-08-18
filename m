Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0840E8D3
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039764; cv=none; b=LtqriCO2tqIcjc7QY2uNsem3Rsn1vblj4fhEqvfu6KGMNpa+5EbLEBB0s13q10GOW/6aBChjQpB/1YZQ4u7xEHgNTnGQTf74fXQ8eWdG4OuklwKeLTtOvpNLUMM22XI1YcXxLzr4IHRRQodEgsvSZzcH+OHMuH2NjE1myZQWPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039764; c=relaxed/simple;
	bh=IAYDsL1sd4o+4O8rFK0eMnlMAc1GX6jxwNKoDKzhu8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NUAVRPqsZUtN3wmZULLouJjo/U9M88oGLsvgk4vp96MgqbFlGL2biNzpEDBDvlKsvbDPHmH8FY2UFHKeeelnGfnUo06oWnZX9Qm9sY7I4VG6YScH3PRpY74+CaI6unvUXNaBp5rdt/uU5LQ6FTRVB9EhfYv9a3T8SRxxHpX5iBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH8G15kj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH8G15kj"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so4045255e9.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787039759; x=1787644559; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6IZMhE4xq7VeWc8ZWi9sXtCSULqCiUzf+cZIEm+r5Bo=;
        b=LH8G15kjxLkmJ63QhuCDlC0N6FoSPkCuNJknQRcRrP2+EZURJAjArYubFTWLwhCLyS
         dsr5cx+ooRLoeV6wVCs3luxMBPWfXUVx04P7kM0a0xJsKWyRCLGMniDBW1Helmk+3Tqu
         WTgBBgetNIe9xqKybuZLBJrokB/svY0ufcP1z2UQWJJN0pPQik2tJyZyeL/l9uicGNs0
         YL9QfG20jaBfGiTGFG710rguvNhA671JD3w6dHHo2KPxWh0cQFzgDOFELPFP0V0YKzlY
         PaIOppAQw1BGR13rZau2SiN/x4W4hOvTk1xueAO48KDaz12u8f1ddWRWKGeAev/jJHpe
         Y/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787039759; x=1787644559;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6IZMhE4xq7VeWc8ZWi9sXtCSULqCiUzf+cZIEm+r5Bo=;
        b=fdr/YgcBS06zYQmxAcCbN3Es7Ui6tiN77Jaey9Dqidx5TUmFThbwklvl4Wiv8PMpM7
         l8g7bumgokWB90F5iyBI/vACZb09qKMvjdmmiz5MKjfgJ5qzPJo114SB4Zvkibl6hTDc
         ggYG/WJCQLIyy+oN5khmXoi3OoGvzgJPTnlsvL+b9akAQn+ey4JwOzv8JZ1Ml7aTvpPY
         bLefKZa1vz4ayFwIZ9/6IEyk0kVq7fBYTEaCaUZkqW6iYRtN7fBzw+2guJEtcbIsWKgp
         PZNcKJWQdqevhBVHPVuOBLRPy7I2kGgkjpD2YCWMzXz0bkMT3a140bw2fJySnIw14cqN
         zwQw==
X-Gm-Message-State: AOJu0Yz0Of16lQZbsRTDMqMmDyFgs5Kl6RKsXH/oXPWAIuAOUeofZKk+
	itqQ4dR/wOwDHelXpCNngaKvgwm07/5DoUhZD1K04RI1FpnkbVVv18zRe+qZ9yic
X-Gm-Gg: AR+sD12HOcn7vtP++L6BElUnFuHDQ7x/jVI0fWpt5Zb1oRhR93rfTEvkrKLgI2ADtGf
	jreWABk6nOaMWLAdrRWRzSqKdY/pN2mYD7gthDUOIhbaZIg+QTpxzZuirEy0yXLfYDGs/rws2Fi
	V0VoOAfcdagxv/pb5gUHVEcCHJfUURP3HjRKxeD+MykC0laLWqrIdviQQWcywH8cf4DH4585Wgf
	ad1Txs9hXtSdd2qe78nSlIhXedj4I4+6HYM8VhFMyehZjYJqwuuq959MNYVZhL1dWzU5ms3+KmE
	8Rekg3C9IrR83ahM39whR8Y0HY0WU1Zc0IHlHBt52xfr/idWL4mzfMSQjaVzqivq2nX1glFzOXj
	iaf4aWMVK1CdkjzdKM0Xfn+bGoss5n4s2xqclrhOMXkSyghGtnaKZHzcKaWpVrraz0g+J0yRKha
	PYi+r9tY5SBG0LcHL1+ZqUWbV8X1AG1Dt3MatzTcgrwfJAQ2HGt/ZLOkM7bDFNG1gtKEJ2GXE6f
	X3ppRaTHAhunsD90hKfcLdFRBc=
X-Received: by 2002:a05:600c:8b10:b0:499:7f37:cb74 with SMTP id 5b1f17b1804b1-499a082c640mr83508215e9.1.1787039758590;
        Tue, 18 Aug 2026 00:55:58 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:8f07:ec4e:fa07:f595])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81748sm10062200f8f.37.2026.08.18.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:55:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 18 Aug 2026 09:55:55 +0200
Subject: [PATCH] hook: introduce the report hook for git-receive-pack(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5EMBCA4VeROZtEKyivIg5V0zUraaVFNhHvv
 sXxO/z/CZECU4QuOyHQwZG9SxB5BmbW7kPIUzLIQtaFEhKbSiG7LfhpN4Sz9wtWY6lta4VuSEE
 K10CWf8+0H17HffyS2e4TXNcf/RHG4HYAAAA=
X-Change-ID: 20260812-758-introduce-hook-5b3af9f1a7e8
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11156;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=IAYDsL1sd4o+4O8rFK0eMnlMAc1GX6jxwNKoDKzhu8c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqEEA0DHXAWKmz4sU7Kh80LTPxw7DfQERKvG
 AEFccW0MZKcaokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqhBANAAoJED7VnySO
 Rox/mi0L+warnRF1Nh5z+Hyk2FQYsvqQG9DElb8+3ewO9cS61ha+cyCUmaNeoQWZL4GWXTcyptz
 YaRZOCoIQmO67E/lahtcPVMC89JA30KLWjSKrqZK+Ul3TauzPDtM7vMRBQfb00/b9W0JMyriVeG
 RZJ9SBgmQsV0M47dgkHI5Nk42kEv+Xi5ClP3wGpZ4ACC4Ad9xJEyVOON1MVxJDKZTVUy8j0SF/c
 7sL4Gls101z80Y279yzCdJWfIeEZbY7tJBRzY8oNMTy7QUiiOwCmkTgBkIh8kGBH4KyQKtzXcEe
 oHhu7ANZUvnLeYODabWs6/pUyd0Q+SxJGLiJYARzQs2E98fiktKEN/ZRp4cpR6MeaEue7gYiruI
 hg4kgUltO8uvH8yUbXptlCbSVDlwLdEZG5MvIBNpJrqlzAEGi35lIWpyCBN9QLlW0iU9wWZAdKh
 l3t/4Bycm/fU6Pm0uXGCjOqccXfvjkZoXpMJ7Jyon1Ic9Md+dznMosXl3AktSpbK1QS6nvq96g5
 Kw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When running 'git-receive-pack(1)', there is currently no way for the
server to intercept and modify the status report before it is sent back
to the client. This is useful for servers with custom logic that need
to transform or gate the report based on the outcome of external logic
post reference updates.

Introduce a new 'report' hook which receives the pkt-line encoded
status report on stdin and whose stdout replaces the report sent to the
client. A non-zero exit status causes `receive-pack` to die and the
client to treat the push as failed.

Similar to the 'proc-receive' hook, this does not use the config-based
hook infrastructure. That infrastructure is designed for parallelizable
notification hooks. As this hook is a bidirectional filter, it would
require significant modifications to that infrastructure and this hook
cannot be parallelized anyway.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
To give some context, we at GitLab are building a custom MVCC around
Git. Each git-push would initialize a new version which is then
committed as the default post some operations. These operations take
place after the reference transaction and based on the output status of
those operations, we want to propagate the status to the user. There
currently exists no good mechanism to do so.

Having a report hook which allows us to modify the report being
propagated to the user, allows us to modify the report based on the
status of our MVCC commit phase.
---
 Documentation/githooks.adoc |  23 ++++++
 builtin/receive-pack.c      |  41 +++++++++++
 t/meson.build               |   1 +
 t/t5412-report-hook.sh      | 176 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..7e6643ad89 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
 status will cause the transaction to be aborted. The hook will not be
 called with "aborted" state in that case.
 
+report
+~~~~~~
+
+This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
+`git push` and updates reference(s) in its repository. It executes on
+the remote repository once after all refs have been updated, but before
+the status report is sent back to the client.
+
+The hook receives the pkt-line encoded status report on standard input
+and its standard output replaces the report sent to the client. Any
+output written to standard error is forwarded to the client over the
+sideband channel and will appear as `remote:` lines on the client's
+terminal. To reject individual ref updates, rewrite the corresponding
+`ok` lines to `ng` lines in the output report (with an explanatory
+error string) and exit zero; standard error can accompany this to
+provide a human-readable explanation. A non-zero exit status causes
+`receive-pack` to die.
+
+Note that by the time this hook runs, all ref updates have already been
+applied to the repository. A non-zero exit causes the client to see the
+push as failed, but does *not* roll back any ref changes that were
+already committed server-side.
+
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..bc22b3ec31 100644
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
+	int code;
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
+	code = pipe_command(&proc, report->buf, report->len, &out,
+			    report->len, NULL, 0);
+	sigchain_pop(SIGPIPE);
+
+	finish_sideband_async(&sideband_async, saved_stderr,
+			      sideband_async_started);
+
+	if (!code)
+		strbuf_swap(&out, report);
+
+	strbuf_release(&out);
+	return code;
+}
+
 static struct command *find_command_by_refname(struct command *list,
 					       const char *refname)
 {
@@ -2547,6 +2582,9 @@ static void report(struct command *commands, const char *unpack_status)
 	}
 	packet_buf_flush(&buf);
 
+	if (run_report_hook(&buf))
+		die("report hook failed");
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
@@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands, const char *unpack_status)
 	}
 	packet_buf_flush(&buf);
 
+	if (run_report_hook(&buf))
+		die("report hook failed");
+
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
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
index 0000000000..47f20e8d67
--- /dev/null
+++ b/t/t5412-report-hook.sh
@@ -0,0 +1,176 @@
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
+test_expect_success "non-zero exit causes receive-pack to die" '
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
+	fatal: report hook failed
+	send-pack: unexpected disconnect while reading sideband packet
+	fatal: the remote end hung up unexpectedly
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
+	test_grep "hook-stderr-message" out
+'
+
+test_done

---
base-commit: 11c6700f10234578d10523faf35656ca491425c9
change-id: 20260812-758-introduce-hook-5b3af9f1a7e8


Thanks
- Karthik

