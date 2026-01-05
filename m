Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBA31354C
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608277; cv=none; b=MwS6Mz2osFY4QLW90xNHaZ4CQMmlsuYWoO6EE06USt6INFSBUZqOylis4mjju99QBCN8t96oehnWk4MTYLqotxIte+hfOB3dpNBLTurNrjFl8x+Y762uApgyI4UmIfK06wWDfYWCMHxbAgmhgYDL8sPQMsOZBPSbgZP+l4KbLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608277; c=relaxed/simple;
	bh=+jalk4CSBYJaIlP62ZbK6UANd6JXKkp8jzxFFcPPXbg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EoMXZZTX8pKXI6zPJTSlArs1JuQpL/wwVx17Ty6V4BjwAUU9XF1XbYD8T8PNBAJIMN62XDcrqyafabkfQqFP3aeaxeTcvo1Z4E0V9nEWhI90mk4cOHbHvHJbWgraFNc7h/bEYjKqbYh00p9Rn/Kj7We3IYmSEast6auPR7PrffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+Q7BZwD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Q7BZwD"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f8a6b37b2dso81629681cf.0
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767608273; x=1768213073; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFkUBf5c2IONlnSqv3dbv0cUfK9+1dnuM3PDR26KVic=;
        b=M+Q7BZwDIFPsGyGWDy/q8DTB90oAA/bchvDnyuMtLdWYdCOH7bvhTjdah/LvCmdjVr
         4rTfjRgHCo7Km+Wjj2wwn1QlpyGMihgtAYXYVg7h/kFN+345PY35jc/HmkzZwFzylPAk
         A8+qNAZ8Zp7k94iK2v92P3mZhrt+KOtDuWoDv7b3d160AfaMlZ6E0Sn/2XdW/g8rlt7d
         PT2bFNtxrrU1QlRmmNYeX46BY2I0FDnsukmadvEUj563fYLBKrlfQ2yLSSAFmSCK+VeE
         6HaI/7Rf4xr8u3Sk0ytztRliNKLNMP1KElAfrgQRyRy9qZAZJb5lTj50SfGJoyFqfa5M
         2W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767608273; x=1768213073;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IFkUBf5c2IONlnSqv3dbv0cUfK9+1dnuM3PDR26KVic=;
        b=vAAJWpSlOeP8NfvADqqGWhpjjSe04SzREFPOMZhPK5OPz94tUB8SJCt8CSRRyCyY5q
         25HAx+wIZlAid1rv2IIwYwQHdgoTtTXef8bV1kzgyGkNU0o6tUxF54xaXfRNMp8A+CJP
         QEeknJSixckfv0zbcLTL7sDC0eWWzZcs9JagAwanZAeg6b4CQAqNRAMeYWJw85F/m1Ya
         JnnkrVGN1D/BmfDVUkzMV1hri5z0pwZb8ttUv1VghSyhE1yZ2uVgyqlKoMDEgOGpIn42
         fYYf/Ot/n5zF310cWK1ehL4eq7QFYFWhhJuhmhBUALbbEPcQpPqycGnlCxsPcHGKk02l
         z/Rw==
X-Gm-Message-State: AOJu0YwzCIYhpyqRzAwXpKS7P+W3q6XB5SxQU9JnJ2AFuFT3RoPHDE1C
	gJpzB7bqhh9UGuEkZLf+2sVYW61Z4LmL8pqNRSyhcapvPUTTHzJjb2pz7zGBLg==
X-Gm-Gg: AY/fxX5R5p5ICsz+2aZ6SnL3aybGJZVFYgD+3LJBLhzgu2ZrFYsfJo+MFvks8NV+/sa
	qUEdBjMzADYOSEE0nj8uDE9zOYghg90J4xGhJAZbXMwsSkm+739TCMjd/9SZ/pNYNLuZAtWN1KA
	41FhuRwQ6RxZvttJ+eHBhaFHYc/dFFremrrSPoE6Zj0uHbzHTyFWcOk9Rk8wDfunEFqM3ljETf5
	zmHjfj1Ua27xWFaQPjCuNn824LvRqUfAuBqYBaQ4TwAccJPIelPHLvPLlKQXuwdpYKP6ZRAJ+bG
	s/GR4e8RKOHGnMiaOMQsnhe9rR6AxXNNUcIhv5U1tWrHRA4wK1ecUjyhGihugHjr26w0hN5+JAY
	FN0cjJucDMF1pultPJEI4FS7Qu4CGx5ldCzI4fPv+AfybkDwiFx9OPuWxfnMYDpmmTDJJ98lFas
	W6+aKK9Gjr+hO4Cg==
X-Google-Smtp-Source: AGHT+IE53CTwTY9JtePQEbolmmNLpc23GXEKF8H9g9/1J2cMwJ1CWSWkKaMCfH9NHXPeGwLEjFhmrw==
X-Received: by 2002:a05:622a:4106:b0:4ee:1913:9616 with SMTP id d75a77b69052e-4f4abd6e3camr720053621cf.51.1767608273197;
        Mon, 05 Jan 2026 02:17:53 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a83f6f3sm343566956d6.55.2026.01.05.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:17:52 -0800 (PST)
Message-Id: <1348542edced5d17c1220ee6bd30afd943acdbcf.1767608269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
References: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
	<pull.2138.v17.git.git.1767608269.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Jan 2026 10:17:49 +0000
Subject: [PATCH v17 2/2] status: show comparison with push remote tracking
 branch
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git status" on a branch that follows a remote branch compares
commits on the current branch and the remote-tracking branch it
builds upon, to show "ahead", "behind", or "diverged" status.

When working on a feature branch that tracks a remote feature branch,
but you also want to track progress relative to the push destination
tracking branch (which may differ from the upstream branch), git status
now shows an additional comparison.

When the upstream tracking branch differs from the push destination
tracking branch, git status shows both the comparison with the upstream
tracking branch (as before) and an additional comparison with the push
destination tracking branch. The push branch comparison appears on a
separate line after the upstream branch status, using the same format.

Example output when tracking origin/main but push destination is
origin/feature:
    On branch feature
    Your branch and 'origin/main' have diverged,
    and have 3 and 1 different commits each, respectively.
      (use "git pull" if you want to integrate the remote branch with yours)

    Your branch is ahead of 'origin/feature' by 1 commit.
      (use "git push" to publish your local commits)

The comparison is only shown when the push destination tracking branch
differs from the upstream tracking branch, even if they are on the same
remote.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 |  97 ++++++++++++++-
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 354 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 7163a8ec28..1f87b85b22 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,11 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum branch_mode_flags {
+	BRANCH_MODE_PULL = (1 << 0),
+	BRANCH_MODE_PUSH = (1 << 1),
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2237,11 +2242,65 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_remote_push_branch(struct branch *branch, char **full_ref_out)
+{
+	struct remote *remote;
+	const char *push_remote;
+	char *push_dst = NULL;
+	char *tracking_ref;
+	const char *resolved;
+	char *ret;
+
+	if (!branch)
+		return NULL;
+
+	push_remote = pushremote_for_branch(branch, NULL);
+	if (!push_remote)
+		return NULL;
+
+	remote = remotes_remote_get(the_repository, push_remote);
+	if (!remote)
+		return NULL;
+
+	push_dst = remote_ref_for_branch(branch, 1);
+	if (!push_dst) {
+		if (remote->push.nr)
+			return NULL;
+		push_dst = xstrdup(branch->refname);
+	}
+
+	tracking_ref = (char *)tracking_for_push_dest(remote, push_dst, NULL);
+	free(push_dst);
+
+	if (!tracking_ref)
+		return NULL;
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		tracking_ref,
+		RESOLVE_REF_READING,
+		NULL, NULL);
+
+	if (!resolved) {
+		free(tracking_ref);
+		return NULL;
+	}
+
+	if (full_ref_out)
+		*full_ref_out = xstrdup(resolved);
+
+	ret = refs_shorten_unambiguous_ref(
+		get_main_ref_store(the_repository), resolved, 0);
+	free(tracking_ref);
+	return ret;
+}
+
 static void format_branch_comparison(struct strbuf *sb,
 				     int sti,
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
+				     enum branch_mode_flags advice_flags,
 				     int show_divergence_advice)
 {
 	if (!sti) {
@@ -2252,7 +2311,8 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((advice_flags & BRANCH_MODE_PUSH) &&
+		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2261,7 +2321,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((advice_flags & BRANCH_MODE_PUSH) &&
+		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2272,7 +2333,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((advice_flags & BRANCH_MODE_PULL) &&
+		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2285,7 +2347,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
+		if ((advice_flags & BRANCH_MODE_PULL) &&
+		    show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
@@ -2303,6 +2366,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	enum branch_mode_flags base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
+	int push_ours, push_theirs, push_sti;
+	char *full_push = NULL;
+	char *push = NULL;
+	enum branch_mode_flags push_branch_modes = 0;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2314,6 +2382,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	push = get_remote_push_branch(branch, &full_push);
+	if (push && strcmp(base, push)) {
+		push_sti = stat_branch_pair(branch->refname, full_push,
+					   &push_ours, &push_theirs, abf);
+		if (push_sti >= 0) {
+			base_branch_modes = BRANCH_MODE_PULL;
+			push_branch_modes = BRANCH_MODE_PUSH;
+		}
+	}
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2322,10 +2400,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, sti, ours, theirs, base, abf, show_divergence_advice);
+		format_branch_comparison(sb, sti, ours, theirs, base, abf,
+					 base_branch_modes, show_divergence_advice);
+	}
+
+	if (push_branch_modes & BRANCH_MODE_PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, push_sti, push_ours, push_theirs, push, abf,
+					 push_branch_modes, 0);
 	}
 
 	free(base);
+	free(full_push);
+	free(push);
 	return 1;
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..cf5a926dcd 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,266 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'status tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch b4
+	Your branch is ahead of ${SQ}origin/main${SQ} by 2 commits.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch b4
+	Your branch and ${SQ}origin/main${SQ} refer to different commits.
+	  (use "git status --ahead-behind" for details)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows ahead of both origin/main and feature branch' '
+	(
+		cd test &&
+		git checkout -b feature2 origin/main &&
+		git push origin HEAD &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature2
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both origin/main and feature branch' '
+	(
+		cd test &&
+		git checkout feature2 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature2${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for ahead of tracked but diverged from main' '
+	(
+		cd test &&
+		git checkout -b feature4 origin/main &&
+		advance work1 &&
+		git checkout origin/main &&
+		advance work2 &&
+		git push origin HEAD:main &&
+		git checkout feature4 &&
+		advance work3
+	)
+'
+
+test_expect_success 'status shows diverged from origin/main and ahead of feature branch' '
+	(
+		cd test &&
+		git checkout feature4 &&
+		git branch --set-upstream-to origin/main &&
+		git push origin HEAD &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} have diverged,
+	and have 3 and 1 different commits each, respectively.
+	  (use "git pull" if you want to integrate the remote branch with yours)
+
+	Your branch is ahead of ${SQ}origin/feature4${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind shows diverged from origin/main and ahead of feature branch' '
+	(
+		cd test &&
+		git checkout feature4 &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature4
+	Your branch and ${SQ}origin/main${SQ} refer to different commits.
+
+	Your branch and ${SQ}origin/feature4${SQ} refer to different commits.
+	  (use "git status --ahead-behind" for details)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream remote' '
+	(
+		cd test &&
+		git remote add upstream ../. &&
+		git fetch upstream &&
+		git config remote.pushDefault origin
+	)
+'
+
+test_expect_success 'status with upstream remote and push.default set to origin' '
+	(
+		cd test &&
+		git checkout -b feature5 upstream/main &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature5
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/feature5${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with upstream remote and push.default set to origin and diverged' '
+	(
+		cd test &&
+		git checkout -b feature6 upstream/main &&
+		advance work &&
+		git push origin &&
+		git reset --hard upstream/main &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature6
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch and ${SQ}origin/feature6${SQ} have diverged,
+	and have 1 and 1 different commits each, respectively.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with upstream remote and push branch up to date' '
+	(
+		cd test &&
+		git checkout -b feature7 upstream/main &&
+		git push origin &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind with upstream remote and push branch up to date' '
+	(
+		cd test &&
+		git checkout feature7 &&
+		git push origin &&
+		git status --no-ahead-behind >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows push branch up to date' '
+	(
+		cd test &&
+		git checkout feature7 >../actual
+	) &&
+	cat >expect <<-EOF &&
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature7${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows remapped push refspec' '
+	(
+		cd test &&
+		git checkout -b feature8 origin/main &&
+		git config remote.origin.push refs/heads/feature8:refs/heads/remapped &&
+		git push &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status shows remapped push refspec with upstream remote' '
+	(
+		cd test &&
+		git checkout -b feature9 upstream/main &&
+		git config remote.origin.push refs/heads/feature9:refs/heads/remapped &&
+		git push origin &&
+		advance work &&
+		git status >../actual
+	) &&
+	cat >expect <<-EOF &&
+	On branch feature9
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch is ahead of ${SQ}origin/remapped${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
