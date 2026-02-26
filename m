Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0171A08AF
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102030; cv=none; b=DDCod9IHLQpWycQN9pyxdDF1u3JMuGvhc69iH7mzfa7F0XUlro2kJFmOiazHN2Q8hzUISGJ3SjA8YK7p1vbtt2DrEbP+59GXjnI7O09fBiDAA76NAGph8EEud0DZCKNTG3/bakRbEVs/ZRudaGdwyEjaLPS7+qrM5P8tws18osM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102030; c=relaxed/simple;
	bh=siVHuAy07486Bo0w72Io7LkMpfMTvL9jakiEzHBuV7o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TmPrxgI5awBplFKEQfcXj6AiHpJ46sFPmZz56kfBTQkazRRGwm35KxihQtLYWOJhkG0PUKsK8HBA6+X7xbhEAputJo2uAa0n7vnzXQa9o7rLrLB266rvr6aadisdqZk86mkvmDzWcqVKa2mZCrno2Kqo1DUVTlzSiF86P4bVNnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3SsCEyO; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3SsCEyO"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb5138df1aso67962285a.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772102027; x=1772706827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJrTyIFXCk6Mzp6T7KIc0XuQELIW8J4ribX/jhDqXdY=;
        b=F3SsCEyOJiymrI+LDs2JMLb0I84wxpt0aDewBf0qmoNTK8eun/72ASyT27FH5moaSk
         yetqB64lnF+mvqmTs5201i/5Qvo2r6jY0KcLiuCaP32ja0LmgaS5lvv5qWb/Ybp81Mj9
         VRb4Y/iuzL8oQigmw+oXv08Q551bUS6hOgYfPX9ljY++JlbtV9v0TkiCFEBHibL6lXZ4
         +6KB4q7QgXSEnd2UnzO1NXph9XsNjAx5B2zrRzItr7B8ZolIe3aZe/5jX3mCRX7P0a1B
         4pq9Hil4UQ04aUAiMBmFymt2IackuL0dEr1dpHfJII0Yp+6BaPTkJKYLaYYPa4j3oFrR
         IpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772102027; x=1772706827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJrTyIFXCk6Mzp6T7KIc0XuQELIW8J4ribX/jhDqXdY=;
        b=W2vTRwspIjczJyyXpH1qMWeopXdnHMYCWiC7ToKG+Lm77nOuNSPj6U4AhzxP0RJ9ek
         ljVXz+SACxOWKqRlgmGeoBAMtqUCz1jGqqu/klrWjSZTnUOwrAczErcXxWGVdnTWlxNa
         li1zONEnghr9nr8fg6L3Xg61e83IoPtAhjOsyJxysG2H4qrCypIFJGPvuzN2D3WhsJyN
         pc37SICtwPS0PURWYv4onHPLNR1O6fF6R4SbDeBGAczISyq94uI3Ic2SmRrGpzIXiy0v
         ODtpKG76aoCzRM81N73tL/3BpbzvUv/FGYVBUQ8BUQBdti2mfZWtGgwhxFDR1L20py0l
         XTnQ==
X-Gm-Message-State: AOJu0YxMEM0hB2K8NM/56J9rgBDIpHAqIYJ4Zfzk9uY7EXAKpP6wLkOZ
	GnUqU+0OcqJltSf+KobpMeQjnbT1JBy55nRBFN/Lk2r43cnot9G4RT+ipPfQWIMs
X-Gm-Gg: ATEYQzyA3JeIBqgaScSBqJkyUYEQd9ToTJmV3LzNK9LQmiryVvgxMR0iw7MYvLKQErQ
	ehRM9IUXH69alAZ65GJCadRNB87gAojgAM4Z6AFboM6J9n0L408lcxk6KG2ps+ajwLkKlDeGP90
	3y9IdQyM3FFzwx2IXM+WKGnCoOtitZ9JXMPn9LpsxiQ2xfvt9uFEECzPttfW/ZIE8v1xudtXD26
	7rPA2Jm4ySY5c6uRPSZ/ASvAAk/KJtjt6SSX5OsO4v0XgIkcEaLiGLtMjJhasNw/t+SpXU6y1lQ
	5v3C8PALTNhpBwZCeaFQF4e1ZDoujoW3Bar40kZvCXG4Lcg/269kxrEAe0vHznkSYztK6XJwqu6
	mrJNF7iqC2vJiKxgFrsQWAAGHm4Uvqk8IkbV61jDsA9rSBpUmWP4vSYFYXb0LOibo7Wfp3V4Dav
	VB4oaW3LnHk5dlmc7LUHFQgT3/
X-Received: by 2002:a05:620a:3185:b0:8c7:15fc:2a23 with SMTP id af79cd13be357-8cbbd07a441mr488160185a.79.1772102026358;
        Thu, 26 Feb 2026 02:33:46 -0800 (PST)
Received: from [127.0.0.1] ([52.150.29.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6541f1sm169980485a.3.2026.02.26.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 02:33:45 -0800 (PST)
Message-Id: <501bd402944146aa02fb5515783f6745eede28d3.1772102022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
References: <pull.2138.v29.git.git.1772056263.gitgitgadget@gmail.com>
	<pull.2138.v30.git.git.1772102022.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 10:33:42 +0000
Subject: [PATCH v30 2/2] status: add status.compareBranches config for
 multiple branch comparisons
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

Add a new configuration variable status.compareBranches that allows
users to specify a space-separated list of branch comparisons in
git status output.

Supported values:
- @{upstream} for the current branch's upstream tracking branch
- @{push} for the current branch's push destination

Any other value is ignored and a warning is shown.

When not configured, the default behavior is equivalent to setting
`status.compareBranches = @{upstream}`, preserving backward
compatibility.

The advice messages shown are context-aware:
- "git pull" advice is shown only when comparing against @{upstream}
- "git push" advice is shown only when comparing against @{push}
- Divergence advice is shown for upstream branch comparisons

This is useful for triangular workflows where the upstream tracking
branch differs from the push destination, allowing users to see their
status relative to both branches at once.

Example configuration:
    [status]
        compareBranches = @{upstream} @{push}

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/status.adoc |  19 ++
 remote.c                         | 146 ++++++++++++---
 t/t6040-tracking-info.sh         | 310 +++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+), 28 deletions(-)

diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index 8caf90f51c..15ccd0116b 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -17,6 +17,25 @@ status.aheadBehind::
 	`--no-ahead-behind` by default in linkgit:git-status[1] for
 	non-porcelain status formats.  Defaults to true.
 
+status.compareBranches::
+	A space-separated list of branch comparison specifiers to use in
+	linkgit:git-status[1]. Currently, only `@{upstream}` and `@{push}`
+	are supported. They are interpreted as `branch@{upstream}` and
+	`branch@{push}` for the current branch.
++
+If not set, the default behavior is equivalent to `@{upstream}`, which
+compares against the configured upstream tracking branch.
++
+Example:
++
+----
+[status]
+	compareBranches = @{upstream} @{push}
+----
++
+This would show comparisons against both the configured upstream and push
+tracking branches for the current branch.
+
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
 	prefix before each output line (starting with
diff --git a/remote.c b/remote.c
index e9e2f56ed6..7ca2a6501b 100644
--- a/remote.c
+++ b/remote.c
@@ -29,6 +29,12 @@
 
 enum map_direction { FROM_SRC, FROM_DST };
 
+enum {
+	ENABLE_ADVICE_PULL       = (1 << 0),
+	ENABLE_ADVICE_PUSH       = (1 << 1),
+	ENABLE_ADVICE_DIVERGENCE = (1 << 2),
+};
+
 struct counted_string {
 	size_t len;
 	const char *s;
@@ -2234,13 +2240,40 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *resolve_compare_branch(struct branch *branch, const char *name)
+{
+	const char *resolved = NULL;
+
+	if (!branch || !name)
+		return NULL;
+
+	if (!strcasecmp(name, "@{upstream}")) {
+		resolved = branch_get_upstream(branch, NULL);
+	} else if (!strcasecmp(name, "@{push}")) {
+		resolved = branch_get_push(branch, NULL);
+	} else {
+		warning(_("ignoring value '%s' for status.compareBranches, "
+			  "only @{upstream} and @{push} are supported"),
+			name);
+		return NULL;
+	}
+
+	if (resolved)
+		return xstrdup(resolved);
+	return NULL;
+}
+
 static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
 				     enum ahead_behind_flags abf,
-				     bool show_divergence_advice)
+				     unsigned flags)
 {
+	bool use_push_advice = (flags & ENABLE_ADVICE_PUSH);
+	bool use_pull_advice = (flags & ENABLE_ADVICE_PULL);
+	bool use_divergence_advice = (flags & ENABLE_ADVICE_DIVERGENCE);
+
 	if (up_to_date) {
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
@@ -2249,7 +2282,7 @@ static void format_branch_comparison(struct strbuf *sb,
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
 			    branch_name);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (use_push_advice && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addf(sb, _("  (use \"%s\" for details)\n"),
 				    "git status --ahead-behind");
 	} else if (!theirs) {
@@ -2258,7 +2291,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			   "Your branch is ahead of '%s' by %d commits.\n",
 			   ours),
 			branch_name, ours);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (use_push_advice && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
 	} else if (!ours) {
@@ -2269,7 +2302,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
+		if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
 	} else {
@@ -2282,8 +2315,7 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (show_divergence_advice &&
-		    advice_enabled(ADVICE_STATUS_HINTS))
+		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
 	}
@@ -2296,34 +2328,92 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 			 enum ahead_behind_flags abf,
 			 int show_divergence_advice)
 {
-	int ours, theirs, cmp_fetch;
-	const char *full_base;
-	char *base;
-	int upstream_is_gone = 0;
+	char *compare_branches = NULL;
+	struct string_list branches = STRING_LIST_INIT_DUP;
+	struct strset processed_refs = STRSET_INIT;
+	int reported = 0;
+	size_t i;
+	const char *upstream_ref;
+	const char *push_ref;
 
-	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
-	if (cmp_fetch < 0) {
-		if (!full_base)
-			return 0;
-		upstream_is_gone = 1;
+	repo_config_get_string(the_repository, "status.comparebranches",
+			       &compare_branches);
+
+	if (compare_branches) {
+		string_list_split(&branches, compare_branches, " ", -1);
+		string_list_remove_empty_items(&branches, 0);
+	} else {
+		string_list_append(&branches, "@{upstream}");
 	}
 
-	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
-					    full_base, 0);
+	upstream_ref = branch_get_upstream(branch, NULL);
+	push_ref = branch_get_push(branch, NULL);
 
-	if (upstream_is_gone) {
-		strbuf_addf(sb,
-			_("Your branch is based on '%s', but the upstream is gone.\n"),
-			base);
-		if (advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
-	} else {
-		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
+	for (i = 0; i < branches.nr; i++) {
+		char *full_ref;
+		char *short_ref;
+		int ours, theirs, cmp;
+		int is_upstream, is_push;
+		unsigned flags = 0;
+
+		full_ref = resolve_compare_branch(branch,
+						  branches.items[i].string);
+		if (!full_ref)
+			continue;
+
+		if (!strset_add(&processed_refs, full_ref)) {
+			free(full_ref);
+			continue;
+		}
+
+		short_ref = refs_shorten_unambiguous_ref(
+			get_main_ref_store(the_repository), full_ref, 0);
+
+		is_upstream = upstream_ref && !strcmp(full_ref, upstream_ref);
+		is_push = push_ref && !strcmp(full_ref, push_ref);
+
+		if (is_upstream && (!push_ref || !strcmp(upstream_ref, push_ref)))
+			is_push = 1;
+
+		cmp = stat_branch_pair(branch->refname, full_ref,
+				       &ours, &theirs, abf);
+
+		if (cmp < 0) {
+			if (is_upstream) {
+				strbuf_addf(sb,
+					_("Your branch is based on '%s', but the upstream is gone.\n"),
+					short_ref);
+				if (advice_enabled(ADVICE_STATUS_HINTS))
+					strbuf_addstr(sb,
+						_("  (use \"git branch --unset-upstream\" to fixup)\n"));
+				reported = 1;
+			}
+			free(full_ref);
+			free(short_ref);
+			continue;
+		}
+
+		if (reported)
+			strbuf_addstr(sb, "\n");
+
+		if (is_upstream)
+			flags |= ENABLE_ADVICE_PULL;
+		if (is_push)
+			flags |= ENABLE_ADVICE_PUSH;
+		if (show_divergence_advice && is_upstream)
+			flags |= ENABLE_ADVICE_DIVERGENCE;
+		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
+					 abf, flags);
+		reported = 1;
+
+		free(full_ref);
+		free(short_ref);
 	}
 
-	free(base);
-	return 1;
+	string_list_clear(&branches, 0);
+	strset_clear(&processed_refs);
+	free(compare_branches);
+	return reported;
 }
 
 static int one_local_ref(const struct reference *ref, void *cb_data)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..c24f545036 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -292,4 +292,314 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+test_expect_success 'status.compareBranches from upstream has no duplicates' '
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout main &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch main
+	Your branch is up to date with ${SQ}origin/main${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature2 origin/main &&
+	git -C test push origin HEAD &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
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
+test_expect_success 'checkout with status.compareBranches shows both branches' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout feature2 >actual &&
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
+test_expect_success 'status.compareBranches shows diverged and ahead' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout feature4 &&
+	git -C test branch --set-upstream-to origin/main &&
+	git -C test push origin HEAD &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
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
+test_expect_success 'status --no-ahead-behind with status.compareBranches' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout feature4 &&
+	git -C test status --no-ahead-behind >actual &&
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
+		git fetch upstream
+	)
+'
+
+test_expect_success 'status.compareBranches with upstream and origin remotes' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature5 upstream/main &&
+	git -C test push origin &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
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
+test_expect_success 'status.compareBranches supports ordered upstream/push entries' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{push} @{upstream}" &&
+	git -C test checkout -b feature6 upstream/main &&
+	git -C test push origin &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature6
+	Your branch is ahead of ${SQ}origin/feature6${SQ} by 1 commit.
+	  (use "git push" to publish your local commits)
+
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with diverged push branch' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature7 upstream/main &&
+	(cd test && advance work71) &&
+	git -C test push origin &&
+	git -C test reset --hard upstream/main &&
+	(cd test && advance work72) &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature7
+	Your branch is ahead of ${SQ}upstream/main${SQ} by 1 commit.
+
+	Your branch and ${SQ}origin/feature7${SQ} have diverged,
+	and have 1 and 1 different commits each, respectively.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches shows up to date branches' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature8 upstream/main &&
+	git -C test push origin &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status --no-ahead-behind with status.compareBranches up to date' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout feature8 >actual &&
+	git -C test push origin &&
+	git -C test status --no-ahead-behind >actual &&
+	cat >expect <<-EOF &&
+	On branch feature8
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout with status.compareBranches shows up to date' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout feature8 >actual &&
+	cat >expect <<-EOF &&
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is up to date with ${SQ}origin/feature8${SQ}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with upstream behind and push up to date' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b ahead upstream/main &&
+	(cd test && advance work) &&
+	git -C test push upstream HEAD &&
+	git -C test checkout -b feature9 upstream/main &&
+	git -C test push origin &&
+	git -C test branch --set-upstream-to upstream/ahead &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature9
+	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull" to update your local branch)
+
+	Your branch is up to date with ${SQ}origin/feature9${SQ}.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with remapped push refspec' '
+	test_config -C test remote.origin.push refs/heads/feature10:refs/heads/remapped &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature10 origin/main &&
+	git -C test push &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature10
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
+test_expect_success 'status.compareBranches with remapped push and upstream remote' '
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test remote.origin.push refs/heads/feature11:refs/heads/remapped &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature11 upstream/main &&
+	git -C test push origin &&
+	(cd test && advance work) &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature11
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
