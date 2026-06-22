Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0662836D4FC
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113394; cv=none; b=D2M+GL/mxCFs6ZYUra8HkhFezgk0XQoJCPURwXvXrg5/PSfMeSpPQFSX/ylUmt3tPSKbwSHNqkcXdufetTQpD2RHhQ4gEj8W9FVM9bzWR3W+0+ncmZGk2WS6F3fIQxByjt4bZCB72CSoirt7wDhSngLzb4GGagfUWF8aamfq1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113394; c=relaxed/simple;
	bh=CBS5OoY+63QRGkW16MrciOMNEwLDdwnH4jLQ0RuDkV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BpceO5BKPgvSFCLlLAzaun8+IAGaweJM9BaLsMb1EXOBWjQk4KVpaRoJqWemiHdZ/ioT6wUlI3VwiuAQHPfI4XlwxS/xTkP5fznVPxnuReaedzeKlLbRissggK879A3VXzLs/qNC0zJkEzbkG09uC5xIxgHdKfUh6scwzfUmdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaLdfKd4; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaLdfKd4"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c0a352e33so1627464eec.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113392; x=1782718192; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foNaiqXcCOM6Qt27gNEHK862EILHSoj/EjyTPyYcbdU=;
        b=TaLdfKd4ORpeEUKjrZlzzbtncoeYWnIki/PFDPQUqCimTdQKjl7jyw6503bCMH/snJ
         eV6FXeRjPXxb5pFX3w7540KwzPtrLwvRecg8pSEYIYftJoHd8F6Z6/6PGSPssY6SoU4m
         m5klVy0axUKV8bz13+swqI+RSElfcP9odioI0/6cYwwj3PJGl1Fq98lGAF1gGPUvzyjx
         bo3PVDP/0eRk/GgNkXF4dEUwKm8DhNFuGiXrJb+rjaBXo2nlCPJsK3VmNUP4addK2x3G
         xVdNpP1Vfp6a4dlmIfs5x7tgoY1nofd/8ALE6scZAKgzn3dJrNsJhDSTPkfRs6ePSmU4
         CT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113392; x=1782718192;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=foNaiqXcCOM6Qt27gNEHK862EILHSoj/EjyTPyYcbdU=;
        b=lejeF+Lm2vSomDG8O8u8xksRNeGfeRzPqVHsxbhqZpzQLs7hP1N4X8Bxp0wMi94a+a
         KNgIaXTT6c397decIelucaRh14JpctcuPKgTcTxMLWBXfayXE5vUzzwk/UOBZwrdN9dK
         tLbhhZD4L0oWGSZc5ZcqPBOVh2JXdJOZYzh6jkhuafIpP6Y+FxG5cFfFUjcmw+2me6rR
         k+Mk9M4lma55KRUwdKPVSGQ667LRFgDBSulfYRYn7QS3vbM/8o7uAG02NB9QEEFZz9e/
         kvEVtBpiNczcGZ+/BtSM3/mKbC2F9PVwaBvqkr+epyB/Vnz33rX19+lftEBkLycrfcVf
         3Czg==
X-Gm-Message-State: AOJu0YwKwLp0mVVuv8vuiDH99f+il05YKySCYOTQZ0k2Cd4dUSyyxGi+
	dCGW2wmyrv4Agc9Q0luRI14SnplTgcFjAW4otyQVAxZeMFHY38Jsh8y6sN1lXw==
X-Gm-Gg: AfdE7cli2LtysFxgZQRu3iNxZYoXXNyDceQzOoN9bBxWXPTM+GgxbckSg03hXPztA8G
	NhOb/jh4gJcL/l89yIhjggJwpX4LcMpfR+LGzJ4FSMnxP9yoDMxv/rwwmxzGWDV5zvVqdKl0yef
	UAd2ra4NjVYo3Dc7zmkjZ1r8wBbT53M/jAASoNfp5bIAMXuT3vX9hFSudgbchSHnKYwq03guQCZ
	6rgH8sjdZePOF02d4MPMoE/8FwsQvrSF0KuP95UWaggKDxyBsgYZoWh53IJdivYkknSz2EyaABs
	OzuxJirk8dIBEkes/kZbRzu4SC9T1clHQQb4yCatb640/w/fI22Vsy8hq8nFBox35opnR6iLMkt
	wxqrk0g7hNyBLabS2/TFQpmS4FjF0xct33kRvYPxc5lnOo6trQAT7OaWgR6LIRxPQmi1nuBs0MG
	TeQk1zwLiZoJIGI5CDPQ==
X-Received: by 2002:a05:7300:5b9e:b0:304:dc2c:3280 with SMTP id 5a478bee46e88-30c079bb1fdmr7760129eec.14.1782113392131;
        Mon, 22 Jun 2026 00:29:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d6edsm9435247eec.14.2026.06.22.00.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:29:51 -0700 (PDT)
Message-Id: <d8cc17bd7fd28f7d4a541b734e9c61d0c8138043.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:42 +0000
Subject: [PATCH v17 1/7] branch: add --forked filter for --list mode
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
 builtin/branch.c              |  18 ++++-
 ref-filter.c                  |  70 +++++++++++++++++++
 ref-filter.h                  |  10 +++
 t/t3200-branch.sh             | 122 ++++++++++++++++++++++++++++++++++
 5 files changed, 229 insertions(+), 3 deletions(-)

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
index 1572a4f9ef..c159f45b4c 100644
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
@@ -770,6 +780,9 @@ int cmd_branch(int argc,
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
+		OPT_CALLBACK_F(0, "forked", &filter, N_("branch"),
+			N_("print only branches whose upstream matches <branch> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_forked),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_REF_SORT(&sorting_options),
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
@@ -815,7 +828,8 @@ int cmd_branch(int argc,
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
+	    filter.reachable_from || filter.unreachable_from ||
+	    filter.points_at.nr || filter.forked.nr)
 		list = 1;
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..1ddd5a3f6d 100644
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
@@ -3765,6 +3834,7 @@ void ref_filter_init(struct ref_filter *filter)
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
index e7829c2c4b..3104c555f6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,126 @@ test_expect_success 'errors if given a bad branch name' '
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
+		git remote set-head origin one &&
+		git branch local-base &&
+		git branch --track local-one origin/one &&
+		git branch --track local-two origin/two &&
+		git branch --track local-foreign other/foreign &&
+		git branch --track local-onbase local-base &&
+
+		git checkout local-one &&
+		test_commit --no-tag local-one-work local-one.t &&
+		git checkout local-foreign &&
+		test_commit --no-tag local-foreign-work local-foreign.t &&
+		git checkout --detach
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
+	test_when_finished "git -C forked checkout --detach" &&
+	git -C forked checkout local-one &&
+	test_commit -C forked local-only &&
+	git -C forked branch --forked "origin/*" --no-merged origin/one \
+		--format="%(refname:short)" >actual &&
+	echo local-one >expect &&
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
+test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
+	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
+	echo local-one >expect &&
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
 test_done
-- 
gitgitgadget

