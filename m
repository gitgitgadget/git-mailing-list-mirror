Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE2423EAD
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889383; cv=none; b=fxhwSNPE+2xe9G4+x+wzTp7aUnI+7YYJhlGLkPhyk9QcHccdhSyojq9ejwMyiS5FrlEELH0/EFN8+7uXFtTOdU6nRsOYlP/JMpaREUN2wecdw54m07hl8If35uXChch/gCdUK4DKaj4KnkfvbAqPMjc2z6b59qqzY/oXY8XXDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889383; c=relaxed/simple;
	bh=+qugCgwMh4R5oQw9IgUiXYmma8EGu4YJgHJ28HvUjgo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XkS8tLKHKiaJyqu1A+ndtFl4Ku5WAeKtmmAmFz+NRxyjMypjew9hNxFTtgIqYuC2BrPSTVGomxuBmU1GmGWeNmIn/JG+Po2kZ2tWIYprsmCgF3Y3YKl74+W/pOmG1e2977zgHSuutd48psxfV6t0rFZmFg+iMEVVu/6HN8Ht8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezM4Zh0L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezM4Zh0L"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso3035765ad.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889381; x=1785494181; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wWGxAIJL4933VBYdXKSVh/VK9aYVY9oiRorvzdRlynA=;
        b=ezM4Zh0LZ1WWOvS03r7JNHLEPXzR/5Y+4B50BrdHAiPRQwJ12oH4ylDoQnvd81oQH/
         i5Nn4BFUiYAYbTuZs8X8RVRcg5teYK9MRVGNT2hg4jMNeAmfISR6s+KAVJBwr1LOTy/1
         rj+rMMPAD8vCvIVdREwRO1/73JmIm5MkVdynRsdDWh7nufl2tWlK18G31TGdYYQkT8cp
         9PQ1rs5Lw/4gdnACZFiHuCMLLaDU3VOVwve+ewe8F21kThc4QCxIDoNNdB9rp6vQs0H3
         8kwPXqFoIek0WkuR1K3wWfEyCLKG7IMQeJMqPQUrPWZ/PHXFCXSPMMvUNK3vOpWH9nvu
         3h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889381; x=1785494181;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wWGxAIJL4933VBYdXKSVh/VK9aYVY9oiRorvzdRlynA=;
        b=hx8JCQyh4VfZ/WKwyOTSgvop4fTDyR/n+Ti+0gw4QRdl0wvNVgC6MWv8oqpgT82gcM
         ExjBheRmYMzBwOZSH0DVaXovtTqtn+8jfs9FIzWCBmvJffSYLv7enIBPjTStcWc17seF
         wWElwdcxFV6DPkE3wJcuQ6tf6NnCYrw4jMw1cZiHcq8PrvyTm6f0mOdrYNqkYcI6XOmQ
         vUP0dJmpKMJMDpMPeXZR8y8zHYK4lLWFf7jU9tHfTt5pGiCl6ALzHGS5J0qVPxV9i0B/
         5yZGwL+k2cYPZW/r71izhiyhOQZ5E+sLdpkq5T1irPhWuEOPNtIOdaa93FEPNRPd2CT1
         HCTg==
X-Gm-Message-State: AOJu0YwcjG+JiGn0fbvi9CofUCcXFcZX+wQamJA9/DStRYyDjFSfwe9a
	RxdQnM+5gjvcapRxB0ivqjIKxeEZ2X5SzJnf+0H1we7k5Y7/jyZSMGnstDiyjA==
X-Gm-Gg: AR+sD138xCy37mDV2KM0QzNLCjysqCsLbuTV++aHWk8FzsDaDhdVyQxOWaqGhk0oHCy
	24RzUTV3E8EuB/brEMsdnroaf4yVH6WWSlCDojzZp47qZ7e4K/WfGsf/t21sMTnCF/AJzRMM6Au
	I747b3ZRtedcwIXWs10kPYdhdD1P9tv+SQ6ElXV1NRjH0d0X6L/5OfrBUgKddmKiLQKFcbj1xj5
	h1ZkW/j7bt04TuYd10o140poQUOew1wsZ5JTFqqQLO+WDlBjPPdOroe3Ml+CUJ5U/pj62LwLDJM
	o83SRBFIM2xUOTdJ3mW5Jbm0gjFyHJ3yqkYDETHuAv4g6vzudeBYDmEUT6uqAu0ioeQawHwWcOZ
	SXEq+LW7zFXK5FG9GzDa/oKUJM4/wj/nXqSs/IJYEnZLeaqV6TpFpOROgh+C7BKx+bBB2cSCCxS
	D+atumlQ==
X-Received: by 2002:a17:903:1b07:b0:2c9:f44e:9942 with SMTP id d9443c01a7336-2cfa6b7a102mr85328705ad.13.1784889381035;
        Fri, 24 Jul 2026 03:36:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd80cfsm49107945ad.25.2026.07.24.03.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:20 -0700 (PDT)
Message-Id: <90aa528bef242851ca95794f06a9e9311b83a05d.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:11 +0000
Subject: [PATCH v21 1/7] branch: add --forked filter for --list mode
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a --forked option to "git branch" list mode that lists only
branches whose configured upstream matches <branch>. The argument
can be a ref (e.g. "origin/main", "master"), a remote name like
"origin" for the branch its origin/HEAD points at, or a shell glob
(e.g. "origin/*"), and may be repeated to widen the filter.

It is an ordinary list filter, so it combines with the others:

    git branch --merged origin/main --forked 'origin/*'

lists branches forked from origin that are already merged into
origin/main, and --no-merged inverts the question.

This is the building block for --delete-merged, which deletes the
listed branches once they have landed on their upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  12 +++-
 builtin/branch.c              |  18 +++++-
 ref-filter.c                  |  70 ++++++++++++++++++++
 ref-filter.h                  |  10 +++
 t/t3200-branch.sh             | 117 ++++++++++++++++++++++++++++++++++
 5 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..b0d66a6deb 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -13,6 +13,7 @@ git branch [--color[=<when>] | --no-color] [--show-current]
 	   [--column[=<options>] | --no-column] [--sort=<key>]
 	   [--merged [<commit>]] [--no-merged [<commit>]]
 	   [--contains [<commit>]] [--no-contains [<commit>]]
+	   [(--forked <branch>)...]
 	   [--points-at <object>] [--format=<format>]
 	   [(-r|--remotes) | (-a|--all)]
 	   [--list] [<pattern>...]
@@ -51,7 +52,8 @@ merged into the named commit (i.e. the branches whose tip commits are
 reachable from the named commit) will be listed.  With `--no-merged` only
 branches not merged into the named commit will be listed.  If the _<commit>_
 argument is missing it defaults to `HEAD` (i.e. the tip of the current
-branch).
+branch).  With `--forked`, only branches whose configured upstream matches
+the given branch or pattern will be listed.
 
 The command's second form creates a new branch head named _<branch-name>_
 which points to the current `HEAD`, or _<start-point>_ if given. As a
@@ -311,6 +313,14 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	Only list branches whose tips are not reachable from
 	_<commit>_ (`HEAD` if not specified). Implies `--list`.
 
+`--forked <branch>`::
+	Only list branches whose configured upstream matches
+	_<branch>_. The argument can be a ref (e.g. `origin/main`,
+	`master`), a remote name like `origin` for the branch its
+	`origin/HEAD` points at, or a shell-style glob (e.g.
+	`'origin/*'`). The option can be repeated to widen the
+	filter. Implies `--list`.
+
 `--points-at <object>`::
 	Only list branches of _<object>_.
 
diff --git a/builtin/branch.c b/builtin/branch.c
index dede60d27b..3ac1272d7e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -30,7 +30,7 @@
 #include "commit-reach.h"
 
 static const char * const builtin_branch_usage[] = {
-	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
+	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
 	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-l] [<pattern>...]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
@@ -673,6 +673,16 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static int parse_opt_forked(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_filter *filter = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (ref_filter_forked_add(filter, arg) < 0)
+		die(_("'%s' is not a valid branch or pattern"), arg);
+	return 0;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -793,6 +803,9 @@ int cmd_branch(int argc,
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
+		OPT_CALLBACK_F(0, "forked", &filter, N_("branch"),
+			N_("print only branches whose upstream matches <branch> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_forked),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
@@ -838,7 +851,8 @@ int cmd_branch(int argc,
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
+	    filter.reachable_from || filter.unreachable_from ||
+	    filter.points_at.nr || filter.forked.nr)
 		list = 1;
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
diff --git a/ref-filter.c b/ref-filter.c
index 284796c49b..cbdac1a19a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2744,6 +2744,72 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
 }
 
+static const char *short_upstream_name(const char *full_ref)
+{
+	const char *short_name = full_ref;
+	(void)(skip_prefix(short_name, "refs/heads/", &short_name) ||
+	       skip_prefix(short_name, "refs/remotes/", &short_name));
+	return short_name;
+}
+
+/*
+ * Match the configured upstream of a branch against the registered
+ * --forked patterns. Exact patterns are compared against the full
+ * upstream refname so they are unambiguous; glob patterns are matched
+ * against the abbreviated upstream so that a glob such as origin/...
+ * works as typed.
+ */
+static int filter_forked_match(struct ref_filter *filter, const char *refname)
+{
+	const char *short_name;
+	struct branch *branch;
+	const char *upstream;
+	int i;
+
+	if (!skip_prefix(refname, "refs/heads/", &short_name))
+		return 0;
+	branch = branch_get(short_name);
+	if (!branch)
+		return 0;
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream)
+		return 0;
+
+	for (i = 0; i < filter->forked.nr; i++) {
+		const char *pattern = filter->forked.v[i];
+		if (has_glob_specials(pattern)) {
+			if (!wildmatch(pattern, short_upstream_name(upstream),
+				       WM_PATHNAME))
+				return 1;
+		} else if (!strcmp(pattern, upstream)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int ref_filter_forked_add(struct ref_filter *filter, const char *arg)
+{
+	struct object_id oid;
+	char *full_ref = NULL;
+
+	if (has_glob_specials(arg)) {
+		strvec_push(&filter->forked, arg);
+		return 0;
+	}
+
+	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
+			  &full_ref, 0) == 1 &&
+	    (starts_with(full_ref, "refs/heads/") ||
+	     starts_with(full_ref, "refs/remotes/"))) {
+		strvec_push(&filter->forked, full_ref);
+		free(full_ref);
+		return 0;
+	}
+	free(full_ref);
+	return -1;
+}
+
 /*
  * We need to seek to the reference right after a given marker but excluding any
  * matching references. So we seek to the lexicographically next reference.
@@ -2979,6 +3045,9 @@ static struct ref_array_item *apply_ref_filter(const struct reference *ref,
 	if (filter->points_at.nr && !match_points_at(&filter->points_at, ref->oid, ref->name))
 		return NULL;
 
+	if (filter->forked.nr && !filter_forked_match(filter, ref->name))
+		return NULL;
+
 	/*
 	 * A merge filter is applied on refs pointing to commits. Hence
 	 * obtain the commit using the 'oid' available and discard all
@@ -3764,6 +3833,7 @@ void ref_filter_init(struct ref_filter *filter)
 void ref_filter_clear(struct ref_filter *filter)
 {
 	strvec_clear(&filter->exclude);
+	strvec_clear(&filter->forked);
 	oid_array_clear(&filter->points_at);
 	commit_list_free(filter->with_commit);
 	commit_list_free(filter->no_commit);
diff --git a/ref-filter.h b/ref-filter.h
index 120221b47f..9361296e2a 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -67,6 +67,7 @@ struct ref_filter {
 	const char **name_patterns;
 	const char *start_after;
 	struct strvec exclude;
+	struct strvec forked;
 	struct oid_array points_at;
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
@@ -110,6 +111,7 @@ struct ref_format {
 #define REF_FILTER_INIT { \
 	.points_at = OID_ARRAY_INIT, \
 	.exclude = STRVEC_INIT, \
+	.forked = STRVEC_INIT, \
 }
 #define REF_FORMAT_INIT {             \
 	.use_color = GIT_COLOR_UNKNOWN, \
@@ -172,6 +174,14 @@ void ref_sorting_release(struct ref_sorting *);
 struct ref_sorting *ref_sorting_options(struct string_list *);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*
+ * Register a --forked <branch> pattern on the filter. The argument is
+ * either a ref, which is resolved to its full refname, or a shell-style
+ * glob. Branches are kept only when their configured upstream matches
+ * one of the registered patterns. Returns -1 if the argument is not a
+ * valid ref or pattern.
+ */
+int ref_filter_forked_add(struct ref_filter *filter, const char *arg);
 /*  Get the current HEAD's description */
 char *get_head_description(void);
 /*  Set up translated strings in the output. */
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1ecbafbee1..4ffd224a71 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1755,4 +1755,121 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success '--forked: setup' '
+	test_create_repo forked-upstream &&
+	(
+		cd forked-upstream &&
+		test_commit base &&
+		git branch one base &&
+		git branch two base
+	) &&
+
+	test_create_repo forked-other &&
+	(
+		cd forked-other &&
+		test_commit other-base &&
+		git branch foreign other-base
+	) &&
+
+	git clone forked-upstream forked &&
+	(
+		cd forked &&
+		git remote add -f other ../forked-other &&
+		git branch local-base &&
+		git branch --track local-one origin/one &&
+		git branch --track local-two origin/two &&
+		git branch --track local-foreign other/foreign &&
+		git branch --track local-onbase local-base &&
+
+		git checkout local-one &&
+		test_commit --no-tag local-one-work local-one.t &&
+		git checkout local-foreign &&
+		test_commit --no-tag local-foreign-work local-foreign.t
+	)
+'
+
+test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
+	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <glob> filters by wildmatch' '
+	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <local-branch> matches branches with local upstream' '
+	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
+	echo local-onbase >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked can be repeated to widen the filter' '
+	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked combines literal and glob arguments' '
+	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-onbase
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
+	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked composes with --no-merged' '
+	git -C forked branch --forked "origin/*" --no-merged origin/one \
+		--format="%(refname:short)" >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
+	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
+	echo main >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked narrows a <pattern> argument' '
+	git -C forked branch --forked "origin/*" "local-*" \
+		--format="%(refname:short)" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked rejects unknown branch/pattern' '
+	test_must_fail git -C forked branch --forked nope 2>err &&
+	test_grep "not a valid branch or pattern" err
+'
+
+test_expect_success '--forked requires a value' '
+	test_must_fail git -C forked branch --forked 2>err &&
+	test_grep "requires a value" err
+'
+
 test_done
-- 
gitgitgadget

