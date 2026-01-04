Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70931987B
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767568891; cv=none; b=RbIh1uSTa3qTHhzwo5LYDYe9eSzA5C5jtockMLLU0icrNeGK5sUqTL0hXGU3zjS622a6RNZnS/Hl8lyxIuesQy2vThg6QrcZaIkowPCS5U2Z4BEUxie89JciTFAELIibwtR52T5ltyDdDxZGslD+zcfYBlZU48AlssLhcuAVKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767568891; c=relaxed/simple;
	bh=fBHa+BiWIsguR1t9yKzDhiuJ1wdQf57/Tu5tLfh9lrA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z+eYgLaSmveOSRn3tyNdCabKdczpQB14qf2bhOpALICs/BRxeaxCX9yRWnb0MPaoQ4Nxzs8kiPqG/gYk0TywB1yl07gleOiTaO4dyizvUjkt9us9TdRDmXbTKsB4kL4nFVPNfP7hMBgVMSEzFGZ4/TNIFAgMvzRhokrcMZ4oKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvrOzCoP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvrOzCoP"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4f822b2df7aso85243421cf.2
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 15:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767568888; x=1768173688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJaz4Ye1/d8W/D0dsVPnFcoljZ/LinnoPEz3IIzDYQs=;
        b=ZvrOzCoP7tMgfDl8Qw8udVezP0DlXA6ED1nuUWrdzCro78cOVFWBqXGPrHhg4ywKaf
         0Krzh8giKmWVVr3gJaR+XZNPguGlAHGzrYNJmdbzYTdHmN9KG/bI8x59BC9LBr4yZWtV
         rj3zJe4oCe8K1b3KOTcnSR6kAzWojkpArWomsU0kP1Tqp1sxu35pEyyOv4rTFW4PjMNs
         YDYdOarZo/nEJFsJW5JRNpvwJ0k3QxCKdWqp7dF6V3wIGcSGFpF3XTWl2xPuog7QuFwe
         +IsZTI4I/DfueFQrUMTH1GnZEyPaqciq25aLmshFO38ZVtoEAFAYRze1eSzcZyW/KjPr
         tM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767568888; x=1768173688;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJaz4Ye1/d8W/D0dsVPnFcoljZ/LinnoPEz3IIzDYQs=;
        b=PqnQopMPFxGllxL4WlCAJhbpFvHGYct+a4OfZGSZ71KEddo5knBvTznX6Smw0qHSVw
         Yvm3r/Tnz8/8F6ULxvGGja8VG/nJjaU+YLjzuOG1L7okGYAt/ShOpktk6EtmcZJ69bWM
         nrg+Cqrt7xoWGJpD5c7SVVUwchYNkgv6WgOd1NCJL7uUhI6OXEtcoZHe/Nk7PCYdv757
         5Mbrwh2eXun7eFjk5J15u/FQ5GlQrTDXF0AY5pQL2fz8hrKTrk6A+lCuleOc49fFxyie
         Oy1cEoZkyAwF272o5v2RhsvZfUPrDHaTdADazQmhyIQJyCnI92nKmYhGg7g213gafIEF
         0hcg==
X-Gm-Message-State: AOJu0YxsnR9OMkdM5JDJkkqgk5ov0xgNjLVZq14sq3Ol/TJ2b2Ov/Osx
	71QstKXIWhtLPcv0dTz+D3MqGf9ArE1I0fuKv3/Nf3g7ySoznzjhC6kHf98qlURL
X-Gm-Gg: AY/fxX64e20RWYnKU5X3Ja9Tks0PQpWZcOAwXTIExJ+XvgLMZrkWJQcYtxvEkW1APFw
	2/EqrDRuSK8mWDVAtYs1W8gaFD0UXEhNWIEbvip1D2eOR46154i9mXcFDUqlTS4HFzC9SzSmsVQ
	2STTni/w6/m7AZ5+0Xvaicpd1PL6QhmzcZLyn9cvhK8LDCJVfcPWkrGVUfxr11Al6ZdIOXb1Lms
	wPg4uQgFC85FzRwirxuOePkonSrNqlEqH9YeazD/6ogeOCX7dUNd6iNcpwolbWg2+nyyknEtW0K
	w6JLOMTP5jjdviNWLH2GE71kJohvGh9NMayrNkaSXLooULiPU2nGGq16NjmkbkPFaP3Zdr/Zk2M
	4syogtBlDwJIXhvENJD0GAHz7tkM+dbSLe/kfh1/XPrA7lMNIARz1h68LCDEuLIjZpe+B9is5/0
	nEtERleTZ+wBAiow==
X-Google-Smtp-Source: AGHT+IFIPYeTJt+FppdepB7Knrqhq71dpluboc1MmHO4i3qpXev+b8lCcTCs+xtgh6N1XOgdjIdWQA==
X-Received: by 2002:a05:622a:1f95:b0:4f3:58e6:6246 with SMTP id d75a77b69052e-4f4abd8e3afmr622067991cf.58.1767568888333;
        Sun, 04 Jan 2026 15:21:28 -0800 (PST)
Received: from [127.0.0.1] ([20.102.223.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096787536sm3628415385a.4.2026.01.04.15.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 15:21:27 -0800 (PST)
Message-Id: <06cb483f615220490e75edcdad1606bd12b71868.1767568882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
References: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
	<pull.2138.v16.git.git.1767568882.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 23:21:22 +0000
Subject: [PATCH v16 2/2] status: show comparison with push remote tracking
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
 remote.c                 |  94 +++++++++++++++++-
 t/t6040-tracking-info.sh | 210 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index b6a9e14376..74a394c2a6 100644
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
@@ -2237,10 +2242,64 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
+				     enum branch_mode_flags advice_flags,
 				     int show_divergence_advice)
 {
 	if (abf == AHEAD_BEHIND_QUICK) {
@@ -2260,7 +2319,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((advice_flags & BRANCH_MODE_PUSH) &&
+		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2271,7 +2331,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((advice_flags & BRANCH_MODE_PULL) &&
+		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2284,7 +2345,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
+		if ((advice_flags & BRANCH_MODE_PULL) &&
+		    show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
@@ -2302,6 +2364,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
@@ -2313,6 +2380,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
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
@@ -2321,10 +2398,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
+		format_branch_comparison(sb, ours, theirs, base, abf,
+					 base_branch_modes, show_divergence_advice);
+	}
+
+	if (push_branch_modes & BRANCH_MODE_PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, push_ours, push_theirs, push, abf,
+					 push_branch_modes, 0);
 	}
 
 	free(base);
+	free(full_push);
+	free(push);
 	return 1;
 }
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..68f298bf3a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,214 @@ test_expect_success '--set-upstream-to @{-1}' '
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
