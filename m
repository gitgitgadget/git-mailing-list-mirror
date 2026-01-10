Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0130F94B
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768051842; cv=none; b=L3BEt6gnhcR32vA9YhV1KJbnnOJ4MSP3u/3w3faAhGdQpJF0heuR0WMovb/mInjUszF+hZQq195b7RY8fkJTPDXBqm+BNAw2MUhKCJtYtlgiLzqdUoPHxL2T41Xd5ewfY/6v1mSsZ5FupOoZAkj0zTbad+f6SZodUMTsH/3xwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768051842; c=relaxed/simple;
	bh=b/nGBRv6pt52pUgWjjJyulzoAST2lUjhTDeyENG2MiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SQuczcVBkTDj3HzcZHfnw29gDodTu/PLWQXoUOu8pyg6O4683ftgG/qiGOUjg9q+VHYOf+286O/ksChLf2qX4EF3q8txvhDlF0ceoFOlnbwXbig42ofU/6Y/P4kCa8/0bUZrAetXcVdvbXdq5BiuPBSZSxZ7kawsQY1X3IeRJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htnZSmWo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htnZSmWo"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c7660192b0so3610642a34.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768051839; x=1768656639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22mcsjyvkCsRkUE4FnivKWyJQ/xa4Nph8pUUcOADZiY=;
        b=htnZSmWo6nk7Fuu6hvmoWCwYEHaPdW9OUayp/NQct5wrBhC/Z7VEYKqSueJinjz6a3
         EqpnpH9t63nrjI/Nc+T6z9Vs9QZZ/gRB7yUMIxjUEaEXO7poMKhVYtNovxGQD3OuSLic
         l2bUn/uY/2jLKtU6kyN4OYYpo5+X/jPGIPd8TS6hewggoaIrvOtKo7Lg/O7jqACwpxhd
         GhLHOz35fOi6jTkTDFfvu/wL0KKZT41x+wgErcBXO59x6upUEMOik6Eb3tfvBVs3cFpX
         54dScO/HZ5/TI8m+bBVb1vyH4e8P8g6unlAqyki8rydN+xamj3fdgJXWKvlXeismAVZZ
         NQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768051839; x=1768656639;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22mcsjyvkCsRkUE4FnivKWyJQ/xa4Nph8pUUcOADZiY=;
        b=gDds9KM1S8Jy75sl3quzCMPm0UejUDytiOfHznp98tAsnrabXQmpSeC5GmlRk9EXzE
         6YwkyagEGCxOy3eZDKq4jRYfoyui+k2cqc/RfJ+N1wdkBygZmXKSbQdKtGTcHggWcf4q
         1pPl6xty8s0UpzdJ3Zj/OaI7I72uTZvV4wRGLYgDOrX6Abd0a8yApgU6htNFsGZxrzEV
         W+jtnzIhz3hgpOPk3bvaUaC4txfig0ytWT/KkPaE7AgmYe3LOk0z5+NKt3IXQLAmYWGr
         oUOiJYQv5XtVkF7kmYHyhkh2lVB483ONmfoht1V1lqn2o/XSRofXgYjmeA7zoTUZDzOA
         lIcQ==
X-Gm-Message-State: AOJu0YzVq6DoR8/dcu1LRRVkYW+F7o85DEHC2aEEWrqvrKFu/LEGhUds
	OThiYj+lFVSqcCezrf8mXFAvAyUycVHsXFwlHjAH5qLC6vZCUwEO4Dz1zOgM9/aa
X-Gm-Gg: AY/fxX6A4Pb+DIcivqCl4ecFd92pGwjI6r5biz3gx7Idw8iMR2RGPXFBx4vVr2uwZqL
	IZj61i1HUGmpeKvtc58Vgwr/Yzko6txUCoCj9B0ItvvEdIpnQ6oGYmDfo5Gy8z4eq6tQRThV+oM
	wMAGZOlG3b+AmwqfM+hBO79ca1oJ90jKrjoi07eoxJd/9XmEVwQ+x5mM+RcILVwVoQmFkVgDNmW
	EDN73SzqYImMrpPQEsiL0E6AGwNg1HcOTW2ULY4y6IW1jVdSR+3ZJWFe+JdAz3onEOaT33wigDV
	U4z/dN3fnjVjQ2UHDW3R+zVbECs4ub0bUGJwObOzymGm/SvwGlS6kifAuNxBauibNf2Fn4XqCah
	aMx+Qw4d138DugS6xMeaelg+4bU1vUpXbX5em5iwtUkjit0HWX4dN8gIMljXxxiujFsNVqhUqBJ
	0f22ZTMyNGHh+RwR5CEd8J2HvP
X-Google-Smtp-Source: AGHT+IEXc8Vk2GIbCZFozepuMVJ6SXblqOaSM86pUDw4jo03OxSw882dlH9CabtvsdqGHLomSCWCxg==
X-Received: by 2002:a05:6830:2e04:b0:7c7:63b6:89d8 with SMTP id 46e09a7af769-7ce508ea933mr9138022a34.14.1768051839175;
        Sat, 10 Jan 2026 05:30:39 -0800 (PST)
Received: from [127.0.0.1] ([132.196.82.130])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm9105805a34.12.2026.01.10.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 05:30:37 -0800 (PST)
Message-Id: <050197eac32278cefb01ace05e32de70ec36ad1f.1768051831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
References: <pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
	<pull.2138.v20.git.git.1768051831.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 13:30:31 +0000
Subject: [PATCH v20 2/2] status: show comparison with push remote tracking
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
 remote.c                 | 102 ++++++++++++++-
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 358 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index b053d4e443..dd8f94fa23 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,11 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum {
+	BRANCH_MODE_PULL = (1 << 0),
+	BRANCH_MODE_PUSH = (1 << 1),
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2237,13 +2242,75 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
+				     unsigned flags,
 				     bool show_divergence_advice)
 {
+	bool want_push_advice = (flags & BRANCH_MODE_PUSH) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool want_pull_advice = (flags & BRANCH_MODE_PULL) &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+	bool want_divergence_advice = (flags & BRANCH_MODE_PULL) &&
+		show_divergence_advice &&
+		advice_enabled(ADVICE_STATUS_HINTS);
+
 	if (up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
@@ -2252,7 +2319,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_push_advice)
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2261,7 +2328,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_push_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2272,7 +2339,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_pull_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2280,8 +2347,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			"Your branch and '%s' have diverged,\n"
 			       "and have %d and %d different commits each, respectively.\n",
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (want_divergence_advice)
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2298,6 +2364,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	unsigned base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
+	int push_ours, push_theirs, push_sti;
+	char *full_push = NULL;
+	char *push = NULL;
+	unsigned push_branch_modes = 0;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2309,6 +2380,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
@@ -2317,10 +2398,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, !sti, ours, theirs, base, abf, show_divergence_advice);
+		format_branch_comparison(sb, !sti, ours, theirs, base, abf,
+					 base_branch_modes, show_divergence_advice);
+	}
+
+	if (push_branch_modes & BRANCH_MODE_PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, !push_sti, push_ours, push_theirs, push, abf,
+					 push_branch_modes, show_divergence_advice);
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
