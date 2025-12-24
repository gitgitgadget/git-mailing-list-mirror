Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97092C11F0
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766619681; cv=none; b=Z4fdhCAXRwP/MvzJ9wXNm+aPbaPJXL3APSI2kDiaqW6151qYTjo29enxICC30UHLEdz3B5UhcWLhLzcg8H0qBPWQDiciMhhUB/PBVwlFVMhLWNFkBsJ6+/BysIG3NEQUbADjWaV4rhma6VcpMb/SscS+WMCd1KsEat9OkfoQvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766619681; c=relaxed/simple;
	bh=MMyGEqA2dNGnNngUW17cNMS6p/QxHG3zNwdVAxCJh8w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rkxidp3FXL9Ke8Ot/8mQ3Bp+kzzX3ceKcR+JwL2HclVfw+6SMk3dib3V+Sr7HrPXkqIKF00POxQlP4+WZjxX7FiX6Z2WjSwnkIB4zijkrOo29BAMIDb2tLKlWkAriY4fa5AtWdhVs5hcHtisCRS2DMdrBlhS1iq//qJWw5LNmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUH4aQnW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUH4aQnW"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b22b1d3e7fso614303385a.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766619678; x=1767224478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJM8Fvvm4JVu8q5tOpyLZwjaBbWHg/Q824d3a8dQF10=;
        b=ZUH4aQnWYcUElB5NIxPCG38zjRUBv8yXuBWp6JUayu/SMSgr+o9B2Z9Z/nWi7O/a0g
         uvn1KRA6M4WZrSAokWMnzaMOf1GNh7BOnIXnvz1fs0YQ4MRCqCrIhI7cCu1HmO9/49ly
         7iRwedi8O90IGxTyL9i4bdo6DIlG/kdg09vNDc2JFRUEtTOm9DLOQ1F0W6ij+D9g8SAk
         C2bLysnf01I7QIApONZuA90c3NcgxzDj6TDjHV7oZRI055/NTDrGif5ItHNnslLHFfGg
         tQYbWpz/5B8HaizMNJQgKwQMrSYO+F59INEKyU18GAs/8j6jeM5XJSL/3crGk46QDdOY
         YWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766619678; x=1767224478;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJM8Fvvm4JVu8q5tOpyLZwjaBbWHg/Q824d3a8dQF10=;
        b=qtJn8nFL2LMyjJkAl3Gofn1/fHqLVIs098qtPJBHde3TQuAyVO3qZqsdR95zCvSrZe
         Zi8yD4MhHWZ6itxzijhugl2koxJVtCgrXz2ZRtTYCLUdhixW6yPCZDCx/iPZF2plzFsf
         ocT1gua3VmDws95SwceMW1NPOhwgQ7e3dS23wRcSvGuUhwj/skhgELDGHXzRFztmtG0L
         i6vcFyQzK3SfDsI05GIMxZVGfqLwp03Oy+K8qKdzGzBbJQA/dUXKleB1eEAgnow+u3DG
         GUOclBToqkOLuqsqOhek8zCXCYmbT9rg/6ZQ5h3Ol8KXfd/vRdi2qV6WfsYudP62wFQW
         twQg==
X-Gm-Message-State: AOJu0Yz+hthK+JH8vGusb0DMKGzjgJxMZfQa3WfHyaM1BNEDHndQW/au
	ddBfpjkufBZIGklRE+mk3D1jw5KcQOb3LdLNp3Tp+Ds2SkfI6ROgqOVRd8ZeLA==
X-Gm-Gg: AY/fxX5bU20TpMkkbf/fZe+z5ybIxBkxVmr3McPkEFo9jm0c3f169YFzHfWHuhhYx7D
	YjAJMwTnKNKUTpvcpC0DHxwUcJeOu3LqFCGBDmhlBoayhhz1pVfcE0g21qllTczL1b/Bd3YRmhq
	T7G+8otGNUsuIqVxB1XEz3kjUmGi1qP3d4hWhToSwDWAIJlkucTtDzcRUPGsKeebUFylUtRel97
	+E0sJaWBN2OfjO4cK79b4XBttpOqyFIIS8ugMW1BhqnaC++o0HxhVYGrW7Wguq0KtcQr3zf9fFY
	VZk1qUBzll3VCF/3XQLQXpNSi4mkmJjYoRGEpYOKDrqYEFDSeqzSKcyN0m4OdKI8bx7u4+IS4j2
	4K9vkZenIVJXELhvJH1UcVp6iP7Btn2FSmvdbG7Cm1w/rRKNhvEZAWpWX956OSk9xN6ywD6nloc
	CR4/PXUbfOzfzZTw==
X-Google-Smtp-Source: AGHT+IHKukfMBC127n7Bn2lFS2xivl7YM+wT7Oq6YY4mQiT4D5BiB4hSRfCHefLFhhtgRwYsoggNWw==
X-Received: by 2002:a05:620a:4088:b0:8b2:eb66:c64 with SMTP id af79cd13be357-8c08f66de11mr3015016985a.29.1766619677948;
        Wed, 24 Dec 2025 15:41:17 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a44ea92sm144647276d6.48.2025.12.24.15.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 15:41:17 -0800 (PST)
Message-Id: <a3800aed18e576e42de273c9dae0e25bbe26ac6a.1766619672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
References: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
	<pull.2138.v6.git.git.1766619672.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 23:41:07 +0000
Subject: [PATCH v6 1/6] status: show comparison with upstream default branch
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
builds upon, to show "ahead" (i.e. you have built new history,
while others are not touching it), "behind" (i.e. you haven't
added any work since you were in-sync, while others have added
their work on the branch), "diverged" (i.e. you have commits
that you haven't pushed out, while others have added commits).

When you fork a branch 'feature' from the 'main' branch of the
remote, but then create 'feature' branch at the remote and push
there, while you still occasionally pull from or rebase onto
their 'main', you'd also want to know how much you have diverged
from 'main', in addition to how your 'feature' and their
'feature' compares. Currently the comparison with 'main' is not
given, making it hard to know when to start thinking about
rebasing onto the upstream default branch.

Show two sets of comparison: one with the tracking branch (as
before), and another with the upstream's default branch (what
their HEAD points to, typically 'main' or 'master'). The latter
comparison appears on a separate line after the tracking branch
status, using the same format:
- "Ahead of 'origin/main' by N commits" when purely ahead
- "Behind 'origin/main' by N commits" when purely behind
- "Diverged from 'origin/main' by N commits" when diverged

Example output when tracking a feature branch:
    On branch feature
    Your branch is ahead of 'origin/feature' by 2 commits.
      (use "git push" to publish your local commits)

    Ahead of 'origin/main' by 5 commits.

The upstream default branch is determined by checking symbolic refs:
1. refs/remotes/upstream/HEAD (if upstream remote exists)
2. refs/remotes/origin/HEAD (fallback)

This works with any default branch name (main, master, develop,
etc.) as long as the symbolic ref is configured. The comparison
is also shown when the branch is up-to-date with its tracking
branch but differs from the upstream default branch.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c                 | 104 +++++++++++++++++
 t/t6040-tracking-info.sh | 246 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+)

diff --git a/remote.c b/remote.c
index 59b3715120..b2a1e980b1 100644
--- a/remote.c
+++ b/remote.c
@@ -2237,6 +2237,98 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
 }
 
+static char *get_default_remote_ref(char **full_ref_out)
+{
+	int flag;
+	const char *resolved;
+	static const char *remotes[] = { "upstream", "origin", NULL };
+	int i;
+
+	for (i = 0; remotes[i]; i++) {
+		struct strbuf head_ref = STRBUF_INIT;
+		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remotes[i]);
+
+		resolved = refs_resolve_ref_unsafe(
+			get_main_ref_store(the_repository),
+			head_ref.buf,
+			RESOLVE_REF_READING,
+			NULL, &flag);
+
+		strbuf_release(&head_ref);
+
+		if (resolved && (flag & REF_ISSYMREF)) {
+			if (full_ref_out)
+				*full_ref_out = xstrdup(resolved);
+			return refs_shorten_unambiguous_ref(
+				get_main_ref_store(the_repository), resolved, 0);
+		}
+	}
+
+	return NULL;
+}
+
+static int is_default_remote_branch(const char *name)
+{
+	char *default_full = NULL;
+	char *default_short;
+	int result = 0;
+
+	default_short = get_default_remote_ref(&default_full);
+	if (!default_short)
+		return 0;
+
+	result = !strcmp(name, default_short);
+
+	free(default_short);
+	free(default_full);
+	return result;
+}
+
+static void format_default_branch_comparison(struct strbuf *sb,
+					     const char *branch_refname,
+					     enum ahead_behind_flags abf)
+{
+	int default_ours = 0, default_theirs = 0;
+	char *default_full = NULL;
+	char *default_short;
+
+	default_short = get_default_remote_ref(&default_full);
+	if (!default_short)
+		return;
+
+	if (stat_branch_pair(branch_refname, default_full,
+			     &default_ours, &default_theirs, abf) <= 0) {
+		free(default_short);
+		free(default_full);
+		return;
+	}
+
+	strbuf_addstr(sb, "\n");
+
+	if (default_ours > 0 && default_theirs == 0) {
+		strbuf_addf(sb,
+			Q_("Ahead of '%s' by %d commit.\n",
+			   "Ahead of '%s' by %d commits.\n",
+			   default_ours),
+			default_short, default_ours);
+	} else if (default_theirs > 0 && default_ours == 0) {
+		strbuf_addf(sb,
+			Q_("Behind '%s' by %d commit.\n",
+			   "Behind '%s' by %d commits.\n",
+			   default_theirs),
+			default_short, default_theirs);
+	} else if (default_ours > 0 && default_theirs > 0) {
+		strbuf_addf(sb,
+			Q_("Diverged from '%s' by %d commit.\n",
+			   "Diverged from '%s' by %d commits.\n",
+			   default_ours + default_theirs),
+			default_short, default_ours + default_theirs);
+	}
+
+	free(default_short);
+	free(default_full);
+}
+
 /*
  * Return true when there is anything to report, otherwise false.
  */
@@ -2248,6 +2340,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	const char *full_base;
 	char *base;
 	int upstream_is_gone = 0;
+	int show_default_branch_comparison;
 
 	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	if (sti < 0) {
@@ -2258,6 +2351,9 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 
 	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
 					    full_base, 0);
+
+	show_default_branch_comparison = !is_default_remote_branch(base);
+
 	if (upstream_is_gone) {
 		strbuf_addf(sb,
 			_("Your branch is based on '%s', but the upstream is gone.\n"),
@@ -2269,6 +2365,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		strbuf_addf(sb,
 			_("Your branch is up to date with '%s'.\n"),
 			base);
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (abf == AHEAD_BEHIND_QUICK) {
 		strbuf_addf(sb,
 			    _("Your branch and '%s' refer to different commits.\n"),
@@ -2285,6 +2383,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git push\" to publish your local commits)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else if (!ours) {
 		strbuf_addf(sb,
 			Q_("Your branch is behind '%s' by %d commit, "
@@ -2296,6 +2396,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" to update your local branch)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2310,6 +2412,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		    advice_enabled(ADVICE_STATUS_HINTS))
 			strbuf_addstr(sb,
 				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		if (show_default_branch_comparison)
+			format_default_branch_comparison(sb, branch->refname, abf);
 	}
 	free(base);
 	return 1;
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0b719bbae6..e2bd48f858 100755
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
@@ -292,4 +293,249 @@ test_expect_success '--set-upstream-to @{-1}' '
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
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Ahead of '\''origin/main'\'' by 3 commits.
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'checkout shows ahead of both tracked branch and origin/main' '
+	(
+		cd test &&
+		git checkout main >/dev/null &&
+		git checkout work 2>&1 | grep -E "(Switched|Your branch|Ahead of)" | head -3
+	) >actual &&
+	cat >expect <<-\EOF &&
+Switched to branch '\''work'\''
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
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
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2
+Your branch is ahead of '\''origin/oldfeature'\'' by 1 commit.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''origin/main'\'' by 3 commits.
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
+		git status --long -b | head -6
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work2b
+Your branch and '\''origin/oldfeature'\'' have diverged,
+and have 1 and 1 different commits each, respectively.
+  (use "git pull" if you want to integrate the remote branch with yours)
+
+Behind '\''origin/main'\'' by 1 commit.
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
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work3
+Your branch is behind '\''origin/feature3'\'' by 2 commits, and can be fast-forwarded.
+  (use "git pull" to update your local branch)
+
+Ahead of '\''origin/main'\'' by 1 commit.
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
+		git status --long -b | head -5
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch work
+Your branch is ahead of '\''origin/feature'\'' by 2 commits.
+  (use "git push" to publish your local commits)
+
+Diverged from '\''upstream/main'\'' by 5 commits.
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
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''upstream/main'\'' by 3 commits.
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
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature2
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
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
+		git status --long -b | head -4
+	) >actual &&
+	cat >expect <<-\EOF &&
+On branch synced_feature3
+Your branch is up to date with '\''origin/feature'\''.
+
+Diverged from '\''origin/main'\'' by 5 commits.
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

