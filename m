Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51824288522
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767527641; cv=none; b=Ovo3L48S5bac8PtJSG72xyuB2VygNvUdQphakGyPg693vYHv29QSZt/2g5DH5DTHKqr1pRXGZNGX95137SXkGnC43dcnST0U76m+7iB4ff514IM39HiKLCzjak55EhWY+qITU/K5RrKg/ot1Nq9SrB7mLu1uVMKuUukC2SgMUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767527641; c=relaxed/simple;
	bh=KSMv08hhzBy0Df2cQVEniNnzdSLgkgVCMsAswryWusg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aUODH3wdQiI6RX2H6GQQ1R1/EfJ+0F86sg8IstiteLTGbwuHJq8OH1ygs4VFvThqrPKjOWbqtgCerFmTWu0NcBMizdbK+oanDDWWiTI/HGhGVvs2QoUtyAPDLbANsFqXE8rbCAidiQaypPU4BFUGKTj4wIHbLIavCKBwCc7C8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCApcTgQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCApcTgQ"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a367a1db0so229081766d6.3
        for <git@vger.kernel.org>; Sun, 04 Jan 2026 03:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767527638; x=1768132438; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMDriWQH+fmo4Wle6s8xl907Yl4hge6cU+Xhfz0U3kY=;
        b=NCApcTgQgm61j9uaiIcG5t3JxOXX4we2CopMqKCf0oAY5Mu631hL+zuY+KAEE390/Y
         kuClm0Q807ivVUgMA/VEteo9D+y/y0OgEMNfLum7o9KkBoB00PX17pE+Mttkp8al36He
         JcY5iKUKl+srMzi8wDMb0nMgUHsRHeOnnWmY6fAAPPToxl0bEcvG59nfkQgoL9HGZlyg
         eNvrBtJDXMqZmsWKvUuBqLFwvOnIrCfibC+sNTjIs4PQC0GKepA5iCdrt6sOSig9vPJJ
         FqF0cD7Pc4StKU9Je1bXGxHPBmRLDOcm0z3hHy2KMZfwSaXuqwqbDzGxsnjI+c8eRNy3
         lMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767527638; x=1768132438;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMDriWQH+fmo4Wle6s8xl907Yl4hge6cU+Xhfz0U3kY=;
        b=lm9yhjipqLit8DEgvjMCiWoP4Bol3nRBsVYZzHBb2z2BpdKcuup7doQuagq0YJ4VgV
         P7B6BIxQiW/RlDQDwoYBDKCmpLlVdqVDiJLyTNesh+VzqeHhEw6aqRSVL0FnLzcXSUFo
         6aXUwZlg+7KahXqAHHpu6Dpfg6QecpL1OejJgMoBx2tUaGymHlBBNOvm/RaBi5xWxqXN
         M3qQ2b1WF9muSFAVAo9WpFHcFDynUgJG8C31HyFqASgjeJryOSy7sm6xKQSEvsOhNtOI
         8uXIpR103QcB2+t1YW023QOc/9Gp6lzjZVR2EM8UyY/Y/suduoN2a/SJscpOCbU4XQWe
         XwXQ==
X-Gm-Message-State: AOJu0YzOYec+Ry8c19H02iOl83DhO7miVOD4gkaefjU4d/T/7/lWDgo4
	cH8fgKEhU/YruCUhKP0mciK6BQSQIpFjymFR1jwl+kX4nVa92cT++GNpsBQXxdIM
X-Gm-Gg: AY/fxX7QFRh/l6kSFJ721NXMZ2ojAPg1dDsmDUtyfPS2kZTEDXbcSZUX0w8RP4YQTJc
	2rR8jzjCPnDL9PVS8lOm2Y4C4TRSrfgOREYXIu/INMB3X/w0qdjbQpxtqQ/UPgp4aa70rbq8wSz
	BHE8kf+c2WEC1I1wJfS8MR39oQyA4p4KNM7OdjcrCgfwGAyGVtUulNsbPAzD3JoEJDBtw6iDXi1
	76QIH4ituigcq0Lp3Uv21yLySZlFZ/FZFoBrdK5cBLQYmSDnz1nJnj/EaeCZ0VcZmrXHHsHWhrL
	H5g4pn1fZwKAbC2v4nioSjnjCV8a8TB9aRbLWzACfUjI+Z7adF/3VTdMEDB6wGlqyA1SC7bSlvA
	5gT7t/NJGUHCgibvFYtoRq4gXXKvFdtawCkggVSAZFnLlx4vjCzBWgUCK+j8HCF4kOryJsOTzzi
	Lra5t8N7t+alk=
X-Google-Smtp-Source: AGHT+IEySfCM/2zgrevypfmtCWe444aNmwI7Z5qYUezuAMnI2zO2awk77UuQLMTzAnFiDap+8+7MjA==
X-Received: by 2002:a05:620a:2a07:b0:89f:7109:185f with SMTP id af79cd13be357-8c08fbba649mr7211993985a.31.1767527637752;
        Sun, 04 Jan 2026 03:53:57 -0800 (PST)
Received: from [127.0.0.1] ([74.249.78.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0973f0807sm3519116785a.41.2026.01.04.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:53:57 -0800 (PST)
Message-Id: <a435cf4ce42e18ef3b1d4b7fc5f9ecef7151f57e.1767527634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
References: <pull.2138.v14.git.git.1767445236.gitgitgadget@gmail.com>
	<pull.2138.v15.git.git.1767527634.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 11:53:54 +0000
Subject: [PATCH v15 2/2] status: show comparison with push remote tracking
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
 remote.c                 |  91 ++++++++++++++++-
 t/t6040-tracking-info.sh | 210 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 297 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index b6a9e14376..3a8706395a 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,11 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum branch_type {
+	PUSH = 1 << 0,
+	PULL = 1 << 1
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2237,10 +2242,63 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
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
+				     enum branch_type bt,
 				     int show_divergence_advice)
 {
 	if (abf == AHEAD_BEHIND_QUICK) {
@@ -2260,7 +2318,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((bt & PUSH) && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2271,7 +2329,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if ((bt & PULL) && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2284,7 +2342,8 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
+		if ((bt & PULL) &&
+		    show_divergence_advice &&
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
@@ -2302,6 +2361,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	enum branch_type base_bt = PUSH | PULL;
+	int push_ours, push_theirs, push_sti;
+	char *full_push = NULL;
+	char *push = NULL;
+	enum branch_type push_bt = 0;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2313,6 +2377,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
 
+	push = get_remote_push_branch(branch, &full_push);
+	if (push && strcmp(base, push)) {
+		push_sti = stat_branch_pair(branch->refname, full_push,
+					   &push_ours, &push_theirs, abf);
+		if (push_sti >= 0) {
+			base_bt = PULL;
+			push_bt = PUSH;
+		}
+	}
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2321,10 +2395,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			strbuf_addstr(sb,
 				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
 	} else {
-		format_branch_comparison(sb, ours, theirs, base, abf, show_divergence_advice);
+		format_branch_comparison(sb, ours, theirs, base, abf, base_bt,
+					 show_divergence_advice);
+	}
+
+	if (push_bt & PUSH) {
+		strbuf_addstr(sb, "\n");
+		format_branch_comparison(sb, push_ours, push_theirs, push, abf,
+					 push_bt, 0);
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
