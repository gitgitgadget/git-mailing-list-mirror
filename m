Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC72556E
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226455; cv=pass; b=tzJFR87su25JOcXzJz7PTHO42EVyZauG+bRGvCTpDujOyRR967Akz2/coBSsQZ/xbjKukfH9zn9q8qm8ZiQA6lpm/TXPRxATi/5j4l/XL+kl/5GMtYhn3szjeNwGiNNH5rXtK/i+JprRMkmtRQtmdsPulk2Upk4upsvUjosKHWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226455; c=relaxed/simple;
	bh=9mxJ/pLC0n4sp9TiplPV7RgNVZ9115xDmxPDa8xtmd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGZv9FM9oW4pYUyJdGVHkgK1RzwpUn3QYt9ADVLdTnz1YWihxlFWx0mQpB/jK51pWJoGnzBSJ86L6/0hhDzUScYfbuvw6BwyB+BtAnD//GPbRD1pgY7gk1bCeMkCGWWZRNRv8ttoiqJAUN9XBBoHJttNfX68LZA517vVnpDx9Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=RGVNuoxa; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="RGVNuoxa"
ARC-Seal: i=1; a=rsa-sha256; t=1770226441; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GHotFgcIfgkinMJru8/5uHoLk9Ptj29lX3MY91qx6w/AwVk1zx2iVsN6BhnTJJi90k1LigKo2XplDGRl/R43X9dHy3dN59dljvFVmjVpWNCDRmu8zSo938BtJhBx1pMoOZtNvmP55FpV4hL8hE/fgQTf9fzO/+vRoj7i46ngeGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770226441; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p9AcJ2iycsS0niuAjZMOkzk6mzp7dnUdcNCghJvXGQ0=; 
	b=mVHyCDbwaIxA73CCTxmCGV+x26FV1tJYHaFp/4KCnolTRBgs19Nkz5h2LLg7YhmS+k44bubGK7QjZdRXDjZsISmmQerxIiaPgN9560KcPYps88QQrOrKWqt29XxWz0vjqm+KmpDhwDmSM80hLsqsnMSjezgzuZlA+95IisOHsNc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770226441;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=p9AcJ2iycsS0niuAjZMOkzk6mzp7dnUdcNCghJvXGQ0=;
	b=RGVNuoxaUuKZj7bsn6fRU1TlwpHnspCauYmS+zv3orY+dT3fc0TYN1KxaByFOD+0
	t62Wui3DOETEUQ46xkvPx+bpgYOVnBCtYDH3sdp4AVZ2Tx7h6xV25eXDgGn7Z/QGvTx
	jVAYt+XtL4ImZlBuWK8eWAxa11w1mUIlcM8l7ui8=
Received: by mx.zohomail.com with SMTPS id 1770226439514933.3243161578347;
	Wed, 4 Feb 2026 09:33:59 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 3/4] hook: introduce extensions.hookStdoutToStderr
Date: Wed,  4 Feb 2026 19:33:27 +0200
Message-ID: <20260204173328.1601807-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

All hooks already redirect stdout to stderr with the exception of
pre-push which has a known user who depends on the separate stdout
versus stderr outputs (the git-lfs project).

The pre-push behavior was a surprise which we found out about after
causing a regression for git-lfs. Notably, it might not be the only
exception (it's the one we know about). There might be more.

This presents a challenge because stdout_to_stderr is required for
hook parallelization, so run-command can buffer and de-interleave
the hook outputs using ungroup=0, when hook.jobs > 1.

Introduce an extension to enforce consistency: all hooks merge stdout
into stderr and can be safely parallelized. This provides a clean
separation and avoids breaking existing stdout vs stderr behavior.

When this extension is disabled, the `hook.jobs` config has no
effect for pre-push, to prevent garbled (interleaved) parallel
output, so it runs sequentially like before.

Alternatives I've considered to this extension include:
1. Allowing pre-push to run in parallel with interleaved output.
2. Always running pre-push sequentially (no parallel jobs for it).
3. Making users (only git-lfs? maybe more?) fix their hooks to read
   stderr not stdout.

Out of all these alternatives, I think this extension is the most
reasonable compromise, to not break existing users, allow pre-push
parallel jobs for those who need it (with correct outputs) and also
future-proofing in case there are any more exceptions to be added.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/extensions.adoc | 12 ++++++++
 Documentation/config/hook.adoc       |  3 ++
 repository.c                         |  1 +
 repository.h                         |  1 +
 setup.c                              |  7 +++++
 setup.h                              |  1 +
 t/t1800-hook.sh                      | 42 ++++++++++++++++++++++++++++
 transport.c                          |  7 ++---
 8 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 532456644b..de47d97f6d 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -73,6 +73,18 @@ relativeWorktrees:::
 	repaired with either the `--relative-paths` option or with the
 	`worktree.useRelativePaths` config set to `true`.
 
+hookStdoutToStderr:::
+	If enabled, the stdout of all hooks is redirected to stderr. This
+	enforces consistency, since by default most hooks already behave
+	this way, with pre-push being the only known exception.
++
+This is useful for parallel hook execution (see the `hook.jobs` config in
+linkgit:git-config[1]), as it allows the output of multiple hooks running
+in parallel to be grouped (de-interleaved) correctly.
++
+Defaults to disabled. When disabled, `hook.jobs` has no effect for pre-push
+hooks, which will always be run sequentially.
+
 worktreeConfig:::
 	If enabled, then worktrees will load config settings from the
 	`$GIT_DIR/config.worktree` file in addition to the
diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index c394756328..56e6b4e5c3 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -20,3 +20,6 @@ hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to the number of processors on
 	the current system.
++
+This has no effect for hooks requiring separate output streams (like `pre-push`)
+unless `extensions.hookStdoutToStderr` is enabled.
diff --git a/repository.c b/repository.c
index c7e75215ac..36317cafa7 100644
--- a/repository.c
+++ b/repository.c
@@ -281,6 +281,7 @@ int repo_init(struct repository *repo,
 	repo->repository_format_worktree_config = format.worktree_config;
 	repo->repository_format_relative_worktrees = format.relative_worktrees;
 	repo->repository_format_precious_objects = format.precious_objects;
+	repo->repository_format_hook_stdout_to_stderr = format.hook_stdout_to_stderr;
 
 	/* take ownership of format.partial_clone */
 	repo->repository_format_partial_clone = format.partial_clone;
diff --git a/repository.h b/repository.h
index 6063c4b846..f358fdc877 100644
--- a/repository.h
+++ b/repository.h
@@ -165,6 +165,7 @@ struct repository {
 	int repository_format_worktree_config;
 	int repository_format_relative_worktrees;
 	int repository_format_precious_objects;
+	int repository_format_hook_stdout_to_stderr;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index b723f8b339..cf4949c086 100644
--- a/setup.c
+++ b/setup.c
@@ -686,6 +686,9 @@ static enum extension_result handle_extension(const char *var,
 	} else if (!strcmp(ext, "relativeworktrees")) {
 		data->relative_worktrees = git_config_bool(var, value);
 		return EXTENSION_OK;
+	} else if (!strcmp(ext, "hookstdouttostderr")) {
+		data->hook_stdout_to_stderr = git_config_bool(var, value);
+		return EXTENSION_OK;
 	}
 	return EXTENSION_UNKNOWN;
 }
@@ -1947,6 +1950,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				repo_fmt.worktree_config;
 			the_repository->repository_format_relative_worktrees =
 				repo_fmt.relative_worktrees;
+			the_repository->repository_format_hook_stdout_to_stderr =
+				repo_fmt.hook_stdout_to_stderr;
 			/* take ownership of repo_fmt.partial_clone */
 			the_repository->repository_format_partial_clone =
 				repo_fmt.partial_clone;
@@ -2047,6 +2052,8 @@ void check_repository_format(struct repository_format *fmt)
 		fmt->worktree_config;
 	the_repository->repository_format_relative_worktrees =
 		fmt->relative_worktrees;
+	the_repository->repository_format_hook_stdout_to_stderr =
+		fmt->hook_stdout_to_stderr;
 	the_repository->repository_format_partial_clone =
 		xstrdup_or_null(fmt->partial_clone);
 	clear_repository_format(&repo_fmt);
diff --git a/setup.h b/setup.h
index d55dcc6608..929a2e0ba8 100644
--- a/setup.h
+++ b/setup.h
@@ -167,6 +167,7 @@ struct repository_format {
 	char *partial_clone; /* value of extensions.partialclone */
 	int worktree_config;
 	int relative_worktrees;
+	int hook_stdout_to_stderr;
 	int is_bare;
 	int hash_algo;
 	int compat_hash_algo;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 4db1fac862..bf19579f3a 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -395,6 +395,48 @@ test_expect_success 'client hooks: pre-push expects separate stdout and stderr'
 	check_stdout_separate_from_stderr pre-push
 '
 
+test_expect_success 'client hooks: extension makes pre-push merge stdout to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote2 &&
+	git remote add origin2 remote2 &&
+	test_commit B &&
+	# repositoryformatversion=1 might be already set (eg default sha256)
+	# so check before using test_config to set it
+	{ test "$(git config core.repositoryformatversion)" = 1 ||
+	  test_config core.repositoryformatversion 1; } &&
+	git config set core.repositoryformatversion 1 &&
+	test_config extensions.hookStdoutToStderr true &&
+	setup_hooks pre-push &&
+	git push origin2 HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-push
+'
+
+test_expect_success 'client hooks: pre-push defaults to serial execution' '
+	test_when_finished "rm -rf repo-serial" &&
+	git init --bare remote-serial &&
+	git init repo-serial &&
+	git -C repo-serial remote add origin ../remote-serial &&
+	test_commit -C repo-serial A &&
+
+	# Setup 2 pre-push hooks
+	write_script repo-serial/.git/hooks/pre-push <<-EOF &&
+	sleep 2
+	echo "Hook 1" >&2
+	EOF
+	git -C repo-serial config hook.hook-2.event pre-push &&
+	git -C repo-serial config hook.hook-2.command "sleep 2; echo Hook 2 >&2" &&
+
+	git -C repo-serial config hook.jobs 2 &&
+
+	start=$(date +%s) &&
+	git -C repo-serial push origin HEAD >out 2>err &&
+	end=$(date +%s) &&
+
+	duration=$((end - start)) &&
+	# Serial >= 4s, parallel < 4s.
+	test $duration -ge 4
+'
+
 test_expect_success 'client hooks: commit hooks expect stdout redirected to stderr' '
 	hooks="pre-commit prepare-commit-msg \
 		commit-msg post-commit \
diff --git a/transport.c b/transport.c
index 477a598eec..708118f439 100644
--- a/transport.c
+++ b/transport.c
@@ -1394,11 +1394,8 @@ static int run_pre_push_hook(struct transport *transport,
 	opt.copy_feed_pipe_cb_data = copy_pre_push_hook_data;
 	opt.free_feed_pipe_cb_data = free_pre_push_hook_data;
 
-	/*
-	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
-	 * them to keep backwards compatibility with existing hooks.
-	 */
-	opt.stdout_to_stderr = 0;
+	/* merge stdout to stderr only when extensions.StdoutToStderr is enabled */
+	opt.stdout_to_stderr = the_repository->repository_format_hook_stdout_to_stderr;
 
 	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-- 
2.52.0.732.gb351b5166d.dirty

