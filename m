Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCA29A32D
	for <git@vger.kernel.org>; Sun, 28 Dec 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766936490; cv=none; b=m6FQe54ARt33+36Ruw+3PdzODaXfcaBhZwaKilqUiQ3LQ9kwU/oft1cGl1AZl3CAfAdDPt4xjNQM3jie+HACMuse65CpRViMrL2dbA53tXSzbiGkKACiOJmEVt3s1VqEDBg+JfcLg8AJSxwIv4IPSvdQGof/BFli1+fmfuOKi3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766936490; c=relaxed/simple;
	bh=GVfrgjpnn5zPNBYsA34yAKxzxoeB+T2aqYsH2rTHDsI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H16y/Be+l4U2GZ/tafzL0p+ivxW7xvnbSC0W9ksCh2ie5AiD8gd/hKk9FfBRbOsRaRKYADriT/jTjUG/HSCzbTisdtwg3C1mwyuSK2wUZXaGgVMJURxWpCYBw7TljA29G3wG0eafeC9TSY4kD+n+jjTtQQVvtG+oRF6nafxVXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKZOPguK; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKZOPguK"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2d6df99c5so906505385a.1
        for <git@vger.kernel.org>; Sun, 28 Dec 2025 07:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766936487; x=1767541287; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHSGQaS3Zo5rRPFXrC/1iTe5p06avWO/Cb6LuiU9o1Y=;
        b=KKZOPguKzd1HzScsz0ed8oVMuvg0gVJNVwfKSGSxxGL2tQWdsYJD2GNQn6UNpHvc7/
         o8OVjancqhVXveGNtZdOk/ipEpyAlxf2QiWtOWzHI6G/RTyH7nCVnfq2Gyb74ntFr5Kp
         LOSoOc3e+V7D97WVZCENXXffzzaRg6qSLjP32LH8RPb10EXkrUmdJFggNNuHsNaw9KeE
         uI6DpnJj4oXOGik4QtlS2RkfUSqzkQQd68pxetClnNrlkrc0U3DgbfapddjPHUF6pilA
         GNYB3gG6mc79EiYpUTfSG/9s2+NjPb4+mj1z2362HxRmrJyV7eYKJXBHWQOv0CI60SHN
         Ogtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766936487; x=1767541287;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CHSGQaS3Zo5rRPFXrC/1iTe5p06avWO/Cb6LuiU9o1Y=;
        b=dT0xog4KYzKFKzyC1AncozbVW301n9I09xeOFTISrbWHRsPfMX5XTfuCIv/76nzB08
         CQ7dCwU1WLWLmmphSlFGbwm7uGo5HbkNHcQTR1mslpAt8UtM73t3RDTX7t/vSIhj54L4
         uJw3FMYjgAxtoc8raS39PXi3/IC+U9BFDY56I2eQ3YYyokQuoXATFRaFzM4fm+vx+Q/u
         bfzGZ6brDL/gjPmPNnn2uGoSCtvn6Ac4GODDkI4WeMF8afyvCOP+2DRop207jS4AOEAt
         wcWNfgW413brFD98FzcaSZ3rfj3T8m259IKWJhKCN5Ru8O0vTapg4JFMZOumko1ug5UD
         T/yQ==
X-Gm-Message-State: AOJu0Yzee+sD7p1/bXtponrtuZO9nKeUJpFnmgvzzR6R0/oTNBat+y9u
	tuSOIhRvh7x1tvurd1kwbMOeBNQKsiMVbXKFzQb3dhDGRIjqhkeoy4ZObCB4UA==
X-Gm-Gg: AY/fxX4e88EAsZ1qQlHRbSBjrXax+1svUZ2XBqyF70jhZM6saHvRfUfibrYSyClyDLN
	QoCbMTs+7FzpIPLpApfIw6XqPp915kSzAJj0obMM4+M6DQREySySxaNgE9/E/g4gf5xgaMTGwL+
	YGkLAe+sTVOxSNYfFPjj20lmCYIBAZgq4uthzYf1hfKnPeuCZjsreUc9WSqNXDCDxtIxllOXaQc
	gU+pLviXorc+I7O1+/jx6Wj56JKUpSl2mTHgSCxV4BldiN/TqcCl9b1GSIvRpc417e4NLjbhpPv
	NqLmUCQt9xO6g2Cu2SNpZEE25O5Mw85oM8Rs8IoAQJswbUqElQrPhDdxrJGrff630MKRnsA5z/i
	V0lx9wG4Yr3yDhdI1DXa/Y/ECfDYrCUkyOd1DvmeIkDOfsoLRYQnqxTszbq36NiyLruYswuEp/g
	KFPbN5s7tDCGY=
X-Google-Smtp-Source: AGHT+IEU74B8fiYPySEqLIfrwmZ5NVYlTyAezy/95oQ1URqztcCCMJb2aoHL6dNW7X8K/lWDUyR/Yw==
X-Received: by 2002:a05:620a:400e:b0:8a3:90cb:9224 with SMTP id af79cd13be357-8bee670c438mr4879167385a.2.1766936486717;
        Sun, 28 Dec 2025 07:41:26 -0800 (PST)
Received: from [127.0.0.1] ([40.76.239.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96ce3907sm204730056d6.18.2025.12.28.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 07:41:26 -0800 (PST)
Message-Id: <ecfe122585617c1a1a3862fc787e9d099d69723e.1766936483.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
References: <pull.2138.v8.git.git.1766666006561.gitgitgadget@gmail.com>
	<pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Dec 2025 15:41:22 +0000
Subject: [PATCH v9 1/2] status: show comparison with configured goal branch
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
but you also want to track progress relative to a goal branch (e.g.,
upstream/main), you can configure status.goalBranch to show an
additional comparison.

Add support for status.goalBranch configuration option that specifies
a remote/branch to compare against. When set, git status shows both
the comparison with the tracking branch (as before) and an additional
comparison with the configured goal branch, if it differs from the
tracking branch. The goal branch comparison appears on a separate
line after the tracking branch status, using the same format:
- "Ahead of 'upstream/main' by N commits" when purely ahead
- "Behind 'upstream/main' by N commits" when purely behind
- "Diverged from 'upstream/main' by N commits" when diverged

Example output when tracking a feature branch with status.goalBranch
set to upstream/main:
    On branch feature
    Your branch is ahead of 'origin/feature' by 2 commits.
      (use "git push" to publish your local commits)

    Ahead of 'upstream/main' by 5 commits.

The comparison is only shown when status.goalBranch is configured
and the goal branch differs from the tracking branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 |  92 +++++++++++
 t/t6040-tracking-info.sh | 340 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 432 insertions(+)

diff --git a/remote.c b/remote.c
index 59b3715120..7e13c027b5 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,84 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_goal_branch_ref(char **full_ref_out)
+{
+	const char *config_value;
+	const char *resolved;
+	int flag;
+	struct strbuf ref_buf = STRBUF_INIT;
+	char *slash_pos;
+	char *ret = NULL;
+
+	if (repo_config_get_value(the_repository, "status.goalBranch", &config_value))
+		return NULL;
+
+	if (!config_value || !*config_value)
+		return NULL;
+
+	slash_pos = strchr(config_value, '/');
+	if (!slash_pos || slash_pos == config_value || !slash_pos[1]) {
+		warning(_("invalid value for status.goalBranch: '%s' (expected format: remote/branch)"),
+			config_value);
+		return NULL;
+	}
+
+	strbuf_addf(&ref_buf, "refs/remotes/%.*s/%s",
+		    (int)(slash_pos - config_value), config_value,
+		    slash_pos + 1);
+
+	resolved = refs_resolve_ref_unsafe(
+		get_main_ref_store(the_repository),
+		ref_buf.buf,
+		RESOLVE_REF_READING,
+		NULL, &flag);
+
+	if (resolved) {
+		if (full_ref_out)
+			*full_ref_out = xstrdup(resolved);
+		ret = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), resolved, 0);
+	}
+
+	strbuf_release(&ref_buf);
+	return ret;
+}
+
+static void format_goal_branch_comparison(struct strbuf *sb,
+					     const char *branch_refname,
+					     const char *goal_full,
+					     const char *goal_short,
+					     enum ahead_behind_flags abf)
+{
+	int goal_ahead = 0, goal_behind = 0;
+
+	if (stat_branch_pair(branch_refname, goal_full,
+			     &goal_ahead, &goal_behind, abf) <= 0)
+		return;
+
+	strbuf_addstr(sb, "\n");
+
+	if (goal_ahead > 0 && goal_behind == 0) {
+		strbuf_addf(sb,
+			Q_("Ahead of '%s' by %d commit.\n",
+			   "Ahead of '%s' by %d commits.\n",
+			   goal_ahead),
+			goal_short, goal_ahead);
+	} else if (goal_behind > 0 && goal_ahead == 0) {
+		strbuf_addf(sb,
+			Q_("Behind '%s' by %d commit.\n",
+			   "Behind '%s' by %d commits.\n",
+			   goal_behind),
+			goal_short, goal_behind);
+	} else if (goal_ahead > 0 && goal_behind > 0) {
+		strbuf_addf(sb,
+			Q_("Diverged from '%s' by %d commit.\n",
+			   "Diverged from '%s' by %d commits.\n",
+			   goal_ahead + goal_behind),
+			goal_short, goal_ahead + goal_behind);
+	}
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2258,6 +2336,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2311,6 +2390,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
+
+	if (!upstream_is_gone && sti >= 0 && abf != AHEAD_BEHIND_QUICK) {
+		char *goal_full = NULL;
+		char *goal_short = get_goal_branch_ref(&goal_full);
+
+		if (goal_short && strcmp(base, goal_short))
+			format_goal_branch_comparison(sb, branch->refname, goal_full,
+						     goal_short, abf);
+
+		free(goal_short);
+		free(goal_full);
+	}
+
 	free(base);
 	return 1;
 }
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..fe34ddf0ab 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -21,6 +21,7 @@ test_expect_success setup '
 	git clone . test &&
 	(
 		cd test &&
+		git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main &&
 		git checkout -b b1 origin &&
 		git reset --hard HEAD^ &&
 		advance d &&
@@ -292,4 +293,343 @@ test_expect_success '--set-upstream-to @{-1}' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for ahead of non-main tracking branch' '
+	(
+		cd test &&
+		git checkout -b feature origin/main &&
+		advance feature1 &&
+		git push origin feature &&
+		git checkout -b work --track origin/feature &&
+		advance work1 &&
+		advance work2
+	)
+'
+
+test_expect_success 'status shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Ahead of '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout main >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git checkout work 2>&1
+	) >actual &&
+	cat >expect <<-\EOF &&
+Switched to branch '\''work'\''
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Ahead of '\''origin/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status tracking origin/main shows only main' '
+	(
+		cd test &&
+		git checkout b4 >/dev/null &&
+		git status --long -b
+	) >actual &&
+	test_grep "ahead of .origin/main. by 2 commits" actual &&
+	test_grep ! "Ahead of" actual
+'
+
+test_expect_success 'setup for ahead of tracked but diverged from main' '
+	(
+		cd test &&
+		git checkout origin/main &&
+		git checkout -b oldfeature &&
+		advance oldfeature1 &&
+		git push origin oldfeature &&
+		git checkout origin/main &&
+		advance main_newer &&
+		git push origin HEAD:main &&
+		git checkout -b work2 --track origin/oldfeature &&
+		advance work2_commit
+	)
+'
+
+test_expect_success 'status shows ahead of tracked and diverged from origin/main' '
+	(
+		cd test &&
+		git checkout work2 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2
+Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''origin/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for diverged from tracked but behind main' '
+	(
+		cd test &&
+		git fetch origin &&
+		git checkout origin/main &&
+		git checkout -b work2b &&
+		git branch --set-upstream-to=origin/oldfeature &&
+		git checkout origin/main &&
+		advance main_extra &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows diverged from tracked and behind origin/main' '
+	(
+		cd test &&
+		git checkout work2b >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2b
+Your branch and '\''origin/oldfeature'\'' have diverged,
+and have 1 and 1 different commits each, respectively.
+  (use "git pull" if you want to integrate the remote branch with yours)
+
+Behind '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for behind tracked but ahead of main' '
+	(
+		cd test &&
+		git fetch origin &&
+		git checkout origin/main &&
+		git checkout -b feature3 &&
+		advance feature3_1 &&
+		advance feature3_2 &&
+		advance feature3_3 &&
+		git push origin feature3 &&
+		git checkout -b work3 --track origin/feature3 &&
+		git reset --hard HEAD~2
+	)
+'
+
+test_expect_success 'status shows behind tracked and ahead of origin/main' '
+	(
+		cd test &&
+		git checkout work3 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work3
+Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forwarded.
+  (use "git pull" to update your local branch)
+
+Ahead of '\''origin/main'\'' by 1 commit.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup upstream remote preference' '
+	(
+		cd test &&
+		git remote add upstream ../. &&
+		git fetch upstream &&
+		git symbolic-ref refs/remotes/upstream/HEAD refs/remotes/upstream/main
+	)
+'
+
+test_expect_success 'status prefers upstream remote over origin for comparison' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config status.goalBranch upstream/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''upstream/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but ahead of default' '
+	(
+		cd test &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature --track origin/feature &&
+		git checkout origin/main &&
+		advance main_ahead &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but diverged from default' '
+	(
+		cd test &&
+		git checkout synced_feature >/dev/null &&
+		git config status.goalBranch upstream/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''upstream/main'\'' by 3 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but ahead of origin/main' '
+	(
+		cd test &&
+		git remote remove upstream &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature2 --track origin/feature &&
+		git checkout origin/main &&
+		advance main_ahead2 &&
+		git push origin HEAD:main
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but diverged from origin/main' '
+	(
+		cd test &&
+		git checkout synced_feature2 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature2
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'setup for up to date with tracked but purely ahead of origin/main' '
+	(
+		cd test &&
+		git checkout origin/feature &&
+		git checkout -b synced_feature3 --track origin/feature
+	)
+'
+
+test_expect_success 'status shows up to date with tracked but shows default branch comparison' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch unset shows no default comparison' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config --unset status.goalBranch 2>/dev/null || true &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch set uses configured branch' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config status.goalBranch origin/main &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch set to different remote/branch' '
+	(
+		cd test &&
+		git checkout work >/dev/null &&
+		git config status.goalBranch origin/feature &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status with status.goalBranch set to non-existent branch' '
+	(
+		cd test &&
+		git checkout synced_feature3 >/dev/null &&
+		git config status.goalBranch origin/nonexistent &&
+		git status --long -b
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+nothing to commit, working tree clean
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

