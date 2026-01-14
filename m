Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381D33BBA4
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417144; cv=pass; b=fFV6MoKhDA7J0ARWU0RW5BcRIFrxGUG7ToXLdnH0aZN41dqV9/J4ZJKPckAaTHhuU5mWTx4YDNbJST2TM4/laYiHwLVuxfleS0RUX5l5UT8ZorzarAqVTwPOVPev0SeNiYeFrrHBTHaovPKOK4ES2NQ5AlAXAJ3PFitH92SkVcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417144; c=relaxed/simple;
	bh=pq40CMhYwWXWAaekMRBDmXMxG2RJGUm+Ca9MI7t4rQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC65+2A09wKaKad6PZT6BXv20DskmC2NtvxUgJhIvg1RPVtfSfFhmF67SGVJOesIsgg1Gk6WdszM/8ZlD4gK8cfuFFV7DqXIsRqge0LWZOY5vvCGMR+ySjD/w7tQhSi64kbbjbAqkdIUXpEES51fxFRp4IVTrpM2wqTjIJZFKdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=i2ZsAzgh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="i2ZsAzgh"
ARC-Seal: i=1; a=rsa-sha256; t=1768417122; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gQS16mYfJYU1gvv5LAwX9WFj7J5v8x67RdsYtTzItEK15Sv/ogoTwhOWf0oGNTlp9InxeF1PYIR432+Kk2l58YTrE9jZp5Ts7BuYcQEF2h1usx7s6uQ2jjdS4JWn1xLJ0BbZXAhMYe6htteJZHtGj67+i2KmrypGuB6N80DJI1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768417122; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8yzsP4HDk9lo/n3o1V4w58NQjme0vXTSFgCwgCrI7Go=; 
	b=beOvZO8/2l4v5N1Gt2EiV9LnWAhttLB0fmQ6PmjJdAbN3kj7qwA6lsGOtA2IFXkQTc9tLA7tyMYxYAdt8tfGyp0g+7APY+AOLwZ2RdHd8w5hS1EPwm0tFoy7MJua22zGJAFH+AKLGKnKD15NjRFEnKN4lIWP5DUvkHoxtIktqMc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768417122;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8yzsP4HDk9lo/n3o1V4w58NQjme0vXTSFgCwgCrI7Go=;
	b=i2ZsAzgh/vG+w10YEfxgz1OL6JHmc8B36kPjn3K9JC4wHAK3Vb2RO96E+xxspb/r
	7es1Ugv7YQX/mX//w18rNhUKeP9sKDLy9iJ3mzUuLF2MnLoN/FDAZedhJIPHPOlsPJg
	Exzkjd3Ny4C4FB8PO1ntYQEsy1bpn+Q3RFZDLZls=
Received: by mx.zohomail.com with SMTPS id 1768417121252142.84027394091595;
	Wed, 14 Jan 2026 10:58:41 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Jeff King <peff@peff.net>,
	Chris Darroch <chrisd@apache.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 1/2] hook: allow hooks to disable stdout_to_stderr
Date: Wed, 14 Jan 2026 20:57:30 +0200
Message-ID: <20260114185731.2381550-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260114185731.2381550-1-adrian.ratiu@collabora.com>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260114185731.2381550-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The last batch of hooks converted to the hook.[ch] API introduced
a regression because pick_next_hook() always sets stdout_to_stderr
for its child processes.

Pre-push is the only hook API user which requires stdout_to_stderr
to be 0, so it can be argued that pre-push needs fixing, however
this will likely break many pre-push hooks, so it's better to allow
it to be 0, i.e. to match the previous behavior.

To prevent such regressions in the future, extend the hook tests to
verify hooks write to the expected stdout vs stderr streams and
maintain backward compatibility with the hooks output assumptions.

The tests are independent of the actual hook implementations: I've
tested they work the same before and after the hook.[ch] conversion
and will continue to work after we eventually introduce parallel
hook execution and config-based hooks.

Fixes: 3e2836a742d8 ("transport: convert pre-push to hook API")
Reported-by: Chris Darroch <chrisd@apache.org>
Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c          |   2 +-
 hook.h          |   6 +++
 t/t1800-hook.sh | 127 ++++++++++++++++++++++++++++++++++++++++++++++++
 transport.c     |   6 +++
 4 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 35211e5ed7..ebd9d9e26e 100644
--- a/hook.c
+++ b/hook.c
@@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
 		cp->in = -1;
 	}
 
-	cp->stdout_to_stderr = 1;
+	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
diff --git a/hook.h b/hook.h
index ae502178b9..2488db7133 100644
--- a/hook.h
+++ b/hook.h
@@ -39,6 +39,11 @@ struct run_hooks_opt
 	 */
 	unsigned int ungroup:1;
 
+	/**
+	 * Send the hook's stdout to stderr.
+	 */
+	unsigned int stdout_to_stderr:1;
+
 	/**
 	 * Path to file which should be piped to stdin for each hook.
 	 */
@@ -93,6 +98,7 @@ struct run_hooks_opt
 #define RUN_HOOKS_OPT_INIT { \
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
+	.stdout_to_stderr = 1, \
 }
 
 struct hook_cb_data {
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 4feaf0d7be..0e4f93fb31 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -184,4 +184,131 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
 
+check_stdout_separate_from_stderr () {
+	for hook in "$@"
+	do
+		test_grep ! "Hook $hook stdout" stderr.actual &&
+		test_grep ! "Hook $hook stderr" stdout.actual &&
+		test_grep "Hook $hook stderr" stderr.actual &&
+		test_grep "Hook $hook stdout" stdout.actual || return 1
+	done
+}
+
+check_stdout_merged_to_stderr () {
+	test_grep ! "Hook .* stdout" stdout.actual &&
+	test_grep ! "Hook .* stderr" stdout.actual &&
+	for hook in "$@"
+	do
+		test_grep "Hook $hook stdout" stderr.actual &&
+		test_grep "Hook $hook stderr" stderr.actual || return 1
+	done
+}
+
+test_expect_success 'client pre-push hook expects separate stdout and stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote &&
+	git remote add origin remote &&
+	test_commit A &&
+
+	hook=pre-push &&
+	test_hook $hook <<-EOF &&
+	echo >&1 Hook $hook stdout
+	echo >&2 Hook $hook stderr
+	EOF
+
+	git push origin HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_separate_from_stderr pre-push
+'
+
+test_expect_success 'client hooks expect stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	for hook in pre-commit post-commit post-checkout pre-merge-commit \
+		prepare-commit-msg commit-msg post-merge post-rewrite reference-transaction \
+		applypatch-msg pre-applypatch post-applypatch pre-rebase post-index-change
+	do
+		test_hook $hook <<-EOF || return 1
+		echo >&1 Hook $hook stdout
+		echo >&2 Hook $hook stderr
+		EOF
+	done &&
+
+	git checkout -B main &&
+	git checkout -b branch-a &&
+	test_commit commit-on-branch-a &&
+
+	# Trigger pre-commit, prepare-commit-msg, commit-msg, post-commit, reference-transaction
+	git commit --allow-empty -m "Test" >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-commit prepare-commit-msg commit-msg post-commit reference-transaction &&
+
+	# Trigger post-checkout, reference-transaction
+	git checkout -b new-branch main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-checkout reference-transaction &&
+
+	# Trigger pre-merge-commit, post-merge, reference-transaction
+	test_commit new-branch-commit &&
+	git merge --no-ff branch-a >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-merge-commit post-merge reference-transaction &&
+
+	# Trigger post-rewrite, reference-transaction
+	git commit --amend --allow-empty --no-edit >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-rewrite reference-transaction &&
+
+	# Trigger applypatch-msg, pre-applypatch, post-applypatch
+	git checkout -b branch-b main &&
+	test_commit branch-b &&
+	git format-patch -1 --stdout >patch &&
+	git checkout -b branch-c main &&
+	git am patch >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr applypatch-msg pre-applypatch post-applypatch &&
+
+	# Trigger pre-rebase
+	git checkout -b branch-d main &&
+	test_commit branch-d &&
+	git checkout main &&
+	test_commit diverge-main &&
+	git checkout branch-d &&
+	git rebase main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-rebase &&
+
+	# Trigger post-index-change
+	oid=$(git hash-object -w --stdin </dev/null) &&
+	git update-index --add --cacheinfo 100644 $oid new-file >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-index-change
+'
+
+test_expect_success 'server hooks expect stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote-server &&
+	git remote add origin-server remote-server &&
+
+	for hook in pre-receive update post-receive post-update
+	do
+		write_script remote-server/hooks/$hook <<-EOF || return 1
+		echo >&1 Hook $hook stdout
+		echo >&2 Hook $hook stderr
+		EOF
+	done &&
+
+	# Trigger pre-receive update post-receive post-update
+	git push origin-server HEAD:new-branch >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-receive update post-receive post-update
+'
+
+test_expect_success 'server push-to-checkout hook expects stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init server &&
+	git -C server checkout -b main &&
+	test_config -C server receive.denyCurrentBranch updateInstead &&
+	git remote add origin-server-2 server &&
+
+	write_script server/.git/hooks/push-to-checkout <<-EOF &&
+	echo >&1 Hook push-to-checkout stdout
+	echo >&2 Hook push-to-checkout stderr
+	EOF
+
+	# Trigger push-to-checkout
+	git push origin-server-2 HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr push-to-checkout
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 6d0f02be5d..e876cc9189 100644
--- a/transport.c
+++ b/transport.c
@@ -1373,6 +1373,12 @@ static int run_pre_push_hook(struct transport *transport,
 	opt.feed_pipe = pre_push_hook_feed_stdin;
 	opt.feed_pipe_cb_data = &data;
 
+	/*
+	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
+	 * them to keep backwards compatibility with existing hooks.
+	 */
+	opt.stdout_to_stderr = 0;
+
 	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
 	strbuf_release(&data.buf);
-- 
2.52.0.732.gb351b5166d.dirty

