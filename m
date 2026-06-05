Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E43D9049
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684564; cv=none; b=Sf8JWMFlY0poQ+cxoHD9WWRFLNo1NaiPh37JkIb1Brhp1xo1uYu6eM4n9PZc/wlVPsjx34Lb4TDmEw+xEAEvapoNqQaomtFG/ipsaPxR/txTg3ur0zlU80bwlwUUOuVemEE6fDg44Xurz9/IV+CgU1NlzQefZmSyHfxG7u5zRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684564; c=relaxed/simple;
	bh=BZW71ct9lzGjX7nQGmXLy/NXGJBkgsyjdfN3O8vFytM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kV0VkK4DxwzY25gxzs0SIWNAJIdzbwTSCq8XpNTi7DmznmQSr1T+oadq2SOYssEN6XDpNDcG/UNKUQY9iL02RmZGTKHDFhRBWJ4PcyZdMDKf+kXdCw8q6qp5LQ+63YwiNGZQSm4rZYmtFvlt2Z2hBUwG3w4Tym5baBn8ZM6Wnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biReO/Zf; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biReO/Zf"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30759632453so1740222eec.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684561; x=1781289361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgD2DO3tOSkKUfDOkO46q1Y88r7N8DwaXRFl8I3sM4I=;
        b=biReO/Zfa6p8wsEnWfJJRqpQ8SSRkShwARA1un9Wo6XXyADqrVN8+QQl4X6+fETFw1
         z2ECuxHNO+/YhuNbMRbXjICDDZFkmjUw2qJHi9HIy09RKBL0K5RbcWr3+cQn6efCgE7m
         cgoPwoOVcK0mYysknmi4B9VE9OT6Zuw+Ds+DwLOv9v6XHtHjWRjyw3ivbYxuW21bVkq6
         il9BoDADEYeGt1bKtj0Kq1lPl4MZjtZW8Breiw0I8MSA4aVhcamdoFCK0TOLn56RFXni
         gZ8SqhNkszr/azlD9wH+p5lUxdy2sX1mxjByDoN7Q+MVvWzaPkyqNSHgTZgIOwdEcbma
         d5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684561; x=1781289361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rgD2DO3tOSkKUfDOkO46q1Y88r7N8DwaXRFl8I3sM4I=;
        b=YVA127mbjUR0XdilUiSK1hy26Ko45dsWgU+LRSidOm8Y6m8/QNPCif+E2GtB5voQiA
         FDK8i7pyffNfubT5CsnBTX/7YquhlSCFbPitDcE3CrhlMZguvwKvAnnu8giNHa/hpdGc
         k/sDOOHAXoUMnH0kGz8S0OmbdnGEeLRl0dO/3ndIF5NIXJVFNMHJxUKig2U9neF/KoSR
         7A5xE5VBWl57YVU7+6XNkgCQQCOazvCace6LofM9kL6B/TAEq7V+k/3QgmR8QhP6+VM7
         AB6JSps00Z3BOj5zJshn0FulRg3dioo/yLVElEUM3jEONw5HEoorrf4xstrfkLo1kHvf
         xs5A==
X-Gm-Message-State: AOJu0YzCluVqhjzfF10VoLi+qsqpUfiMaPGI0wjdz/8yTlRB/C0u4x+/
	7oaI2DFwNF39oI9vBsYkyh/uW0oSq8hWeTaVwQuenUGvSCDuxevSGEmnqNwWZxG2
X-Gm-Gg: Acq92OFnEcurAAD6gXh3A0SH1VKBjHA3DPtzEYOmm314oekvmIbUfAud2TFEtTuwfqa
	dU128/aEE2DLwyM4ZamjGqiIo+1GDqDibIUz2bQRTQScvsaEnllQyAUAhOIapL209FArldRjFDG
	7FeNWS5KETL8C5eBLH772U42BSACgtgDkIIlnWtFVWtRa0BnqxomOAEoJeGGm7ViFLQtaV+I/pa
	+KrAJTT3YpqeD4pW+OT2P1s7SPQhA1RXqP5O5A1F5S7nGIPqm8gJCqmyw9/CgeioKRuwr2JDgU5
	Wf/mc3MHdO5du8uIXXDbJ2s9pvvMjGbwn//GCmFpC1l20qXQnIZA9y43vhHg0z4L5tKP/PRl+W6
	4GFXAJgSmc7dGa7b+r9xPgaxbJW0pUwOSC0fran9cLlUOFng2+RE6BhHR+mXPHzcaBMikLS9/8q
	cRK8qgtl00k6SAXT61zVGQdOG0ByGq5mt3UOBnHQTL6YG7Hw==
X-Received: by 2002:a05:7300:7fac:b0:304:dddb:f8 with SMTP id 5a478bee46e88-3077b357f7emr2641236eec.35.1780684561150;
        Fri, 05 Jun 2026 11:36:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm11026000eec.6.2026.06.05.11.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:59 -0700 (PDT)
Message-Id: <5f913c445cbd68a78c71b6430e29350d559a970e.1780684553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
	<pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:35:51 +0000
Subject: [PATCH v13 4/6] branch: add --prune-merged <branch>
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

	git branch --prune-merged <branch>...

deletes the local branches that "--forked <branch>" would list,
keeping only those whose tip is reachable from their configured
upstream: the work has already landed on the upstream they track,
so the local copy is no longer needed.

Reachability is read from local refs; nothing is fetched. Run
"git fetch" first if you want fresh upstream refs.

Three kinds of branches are spared:

  * any branch checked out in any worktree;
  * any branch whose upstream no longer resolves locally, since a
    missing upstream is not by itself a sign of integration;
  * any branch whose push destination equals its upstream
    (<branch>@{push} is the same as <branch>@{upstream}), such as
    a local "main" that tracks and pushes to "origin/main". Right
    after a pull it just looks "fully merged", so it is left
    alone. Only branches that push somewhere other than their
    upstream, typically topics in a fork workflow, are candidates.

Branches that are not yet merged into their upstream are reported
as a short warning and skipped, so one unmerged topic does not
abort the whole sweep.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  24 ++++
 builtin/branch.c              |  67 +++++++++++-
 t/t3200-branch.sh             | 201 ++++++++++++++++++++++++++++++++++
 3 files changed, 290 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 62ebab6051..fdaccc9662 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --prune-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -201,6 +202,29 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--prune-merged <branch>...`::
+	Delete the local branches that `--forked` would list for the
+	given _<branch>_ arguments, but only those whose tip is
+	reachable from their configured upstream. In other words, the
+	work on the branch has already landed on the upstream it
+	tracks, so the local copy is no longer needed. Several
+	_<branch>_ patterns may be given, e.g. `git branch
+	--prune-merged origin/main 'feature*'`.
++
+Reachability is checked against whatever the upstream refs say
+locally; nothing is fetched. Run `git fetch` first if you want
+the upstream refs refreshed.
++
+A branch is left alone if any of the following holds:
+its upstream no longer resolves locally; it is checked out in any
+worktree; or its push destination (`<branch>@{push}`) equals its
+upstream (`<branch>@{upstream}`), so it cannot be distinguished
+from a freshly pulled trunk that just looks "fully merged".
++
+Branches refused by the "fully merged" safety check are listed as
+warnings and skipped; pass them to `git branch -D` explicitly if
+you want them gone.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 9568bb8445..7a26447b2a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -38,6 +38,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --prune-merged <branch>..."),
 	NULL
 };
 
@@ -713,6 +714,61 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
+static int prune_merged_branches(int argc, const char **argv,
+				 int quiet)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array candidates;
+	struct strvec deletable = STRVEC_INIT;
+	int i, ret = 0;
+
+	if (!argc)
+		die(_("--prune-merged requires at least one <branch>"));
+
+	for (i = 0; i < argc; i++)
+		if (ref_filter_forked_add(&filter, argv[i]) < 0)
+			die(_("'%s' is not a valid branch or pattern"), argv[i]);
+
+	filter.kind = FILTER_REFS_BRANCHES;
+	memset(&candidates, 0, sizeof(candidates));
+	filter_refs(&candidates, &filter, filter.kind);
+
+	for (i = 0; i < candidates.nr; i++) {
+		const char *full_name = candidates.items[i]->refname;
+		const char *short_name;
+		struct branch *branch;
+		const char *upstream, *push;
+
+		if (!skip_prefix(full_name, "refs/heads/", &short_name))
+			continue;
+		if (branch_checked_out(full_name))
+			continue;
+
+		branch = branch_get(short_name);
+		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
+		if (!upstream || !refs_ref_exists(refs, upstream))
+			continue;
+		push = branch ? branch_get_push(branch, NULL) : NULL;
+		if (!push || !strcmp(push, upstream))
+			continue;
+
+		strvec_push(&deletable, short_name);
+	}
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v,
+				      FILTER_REFS_BRANCHES,
+				      DELETE_BRANCH_WARN_ONLY |
+				      DELETE_BRANCH_NO_HEAD_FALLBACK |
+				      (quiet ? DELETE_BRANCH_QUIET : 0));
+
+	strvec_clear(&deletable);
+	ref_array_clear(&candidates);
+	ref_filter_clear(&filter);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -754,6 +810,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -807,6 +864,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches whose upstream matches <branch> and is merged")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -854,7 +913,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -864,7 +924,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -906,6 +966,9 @@ int cmd_branch(int argc,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
+	} else if (prune_merged) {
+		ret = prune_merged_branches(argc, argv, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4e7deddc04..27ea1319bb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1809,4 +1809,205 @@ test_expect_success '--forked requires a value' '
 	test_grep "requires a value" err
 '
 
+test_expect_success '--prune-merged: setup' '
+	test_create_repo pm-upstream &&
+	test_commit -C pm-upstream base &&
+	git -C pm-upstream checkout -b next &&
+	test_commit -C pm-upstream one-commit &&
+	test_commit -C pm-upstream two-commit &&
+	git -C pm-upstream branch one HEAD~ &&
+	git -C pm-upstream branch two HEAD &&
+	git -C pm-upstream branch wip main &&
+	git -C pm-upstream checkout main &&
+	test_create_repo pm-fork
+'
+
+test_expect_success '--prune-merged deletes branches integrated into upstream' '
+	test_when_finished "rm -rf pm-merged" &&
+	git clone pm-upstream pm-merged &&
+	git -C pm-merged remote add fork ../pm-fork &&
+	test_config -C pm-merged remote.pushDefault fork &&
+	test_config -C pm-merged push.default current &&
+	git -C pm-merged branch one one-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next one &&
+	git -C pm-merged branch two two-commit &&
+	git -C pm-merged branch --set-upstream-to=origin/next two &&
+
+	git -C pm-merged branch --prune-merged "origin/*" &&
+
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-merged rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged accepts a literal upstream' '
+	test_when_finished "rm -rf pm-literal" &&
+	git clone pm-upstream pm-literal &&
+	git -C pm-literal remote add fork ../pm-fork &&
+	test_config -C pm-literal remote.pushDefault fork &&
+	test_config -C pm-literal push.default current &&
+	git -C pm-literal branch one one-commit &&
+	git -C pm-literal branch --set-upstream-to=origin/next one &&
+
+	git -C pm-literal branch --prune-merged origin/next &&
+
+	test_must_fail git -C pm-literal rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged unions multiple <branch> arguments' '
+	test_when_finished "rm -rf pm-union" &&
+	git clone pm-upstream pm-union &&
+	git -C pm-union remote add fork ../pm-fork &&
+	test_config -C pm-union remote.pushDefault fork &&
+	test_config -C pm-union push.default current &&
+	git -C pm-union branch one one-commit &&
+	git -C pm-union branch --set-upstream-to=origin/next one &&
+	git -C pm-union branch two base &&
+	git -C pm-union branch --set-upstream-to=origin/main two &&
+	git -C pm-union checkout --detach &&
+
+	git -C pm-union branch --prune-merged origin/next origin/main &&
+
+	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged accepts a local upstream' '
+	test_when_finished "rm -rf pm-local" &&
+	git clone pm-upstream pm-local &&
+	git -C pm-local remote add fork ../pm-fork &&
+	test_config -C pm-local remote.pushDefault fork &&
+	test_config -C pm-local push.default current &&
+	git -C pm-local checkout -b trunk &&
+	git -C pm-local branch one one-commit &&
+	git -C pm-local branch --set-upstream-to=trunk one &&
+	git -C pm-local merge --ff-only one-commit &&
+
+	git -C pm-local branch --prune-merged trunk &&
+
+	test_must_fail git -C pm-local rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
+	test_when_finished "rm -rf pm-unmerged" &&
+	git clone pm-upstream pm-unmerged &&
+	git -C pm-unmerged remote add fork ../pm-fork &&
+	test_config -C pm-unmerged remote.pushDefault fork &&
+	test_config -C pm-unmerged push.default current &&
+	git -C pm-unmerged checkout -b wip origin/wip &&
+	git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
+	test_commit -C pm-unmerged local-only &&
+	git -C pm-unmerged checkout - &&
+
+	git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
+	test_grep "not fully merged" err &&
+	test_grep ! "If you are sure you want to delete it" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/wip
+'
+
+test_expect_success '--prune-merged is silent about not-merged-to-HEAD' '
+	test_when_finished "rm -rf pm-nohead" &&
+	git clone pm-upstream pm-nohead &&
+	git -C pm-nohead remote add fork ../pm-fork &&
+	test_config -C pm-nohead remote.pushDefault fork &&
+	test_config -C pm-nohead push.default current &&
+	git -C pm-nohead branch topic one-commit &&
+	git -C pm-nohead branch --set-upstream-to=origin/next topic &&
+
+	git -C pm-nohead branch --prune-merged "origin/*" 2>err &&
+
+	test_grep ! "not yet merged to HEAD" err &&
+	test_must_fail git -C pm-nohead rev-parse --verify refs/heads/topic
+'
+
+test_expect_success '--prune-merged skips branches whose upstream is gone' '
+	test_when_finished "rm -rf pm-upstream-gone" &&
+	git clone pm-upstream pm-upstream-gone &&
+	git -C pm-upstream-gone remote add fork ../pm-fork &&
+	test_config -C pm-upstream-gone remote.pushDefault fork &&
+	test_config -C pm-upstream-gone push.default current &&
+	git -C pm-upstream-gone branch one one-commit &&
+	git -C pm-upstream-gone branch --set-upstream-to=origin/next one &&
+
+	git -C pm-upstream-gone update-ref -d refs/remotes/origin/next &&
+	git -C pm-upstream-gone branch --prune-merged "origin/*" &&
+
+	git -C pm-upstream-gone rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged never deletes the checked-out branch' '
+	test_when_finished "rm -rf pm-head" &&
+	git clone pm-upstream pm-head &&
+	git -C pm-head remote add fork ../pm-fork &&
+	test_config -C pm-head remote.pushDefault fork &&
+	test_config -C pm-head push.default current &&
+	git -C pm-head checkout -b one one-commit &&
+	git -C pm-head branch --set-upstream-to=origin/next one &&
+
+	git -C pm-head branch --prune-merged "origin/*" &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged spares branches that push back to their upstream' '
+	test_when_finished "rm -rf pm-push-eq" &&
+	git clone pm-upstream pm-push-eq &&
+	git -C pm-push-eq checkout --detach &&
+
+	git -C pm-push-eq branch --prune-merged "origin/*" &&
+
+	git -C pm-push-eq rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged spares a per-branch pushRemote==upstream remote' '
+	test_when_finished "rm -rf pm-push-branch" &&
+	git clone pm-upstream pm-push-branch &&
+	git -C pm-push-branch remote add fork ../pm-fork &&
+	test_config -C pm-push-branch remote.pushDefault fork &&
+	test_config -C pm-push-branch push.default current &&
+	test_config -C pm-push-branch branch.main.pushRemote origin &&
+	git -C pm-push-branch checkout --detach &&
+
+	git -C pm-push-branch branch --prune-merged "origin/*" &&
+
+	git -C pm-push-branch rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged prunes when @{push} differs from @{upstream}' '
+	test_when_finished "rm -rf pm-push-diff" &&
+	git clone pm-upstream pm-push-diff &&
+	git -C pm-push-diff remote add fork ../pm-fork &&
+	test_config -C pm-push-diff remote.pushDefault fork &&
+	test_config -C pm-push-diff push.default current &&
+	git -C pm-push-diff branch topic one-commit &&
+	git -C pm-push-diff branch --set-upstream-to=origin/next topic &&
+	git -C pm-push-diff checkout --detach &&
+
+	git -C pm-push-diff branch --prune-merged "origin/*" &&
+
+	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
+'
+
+test_expect_success '--prune-merged requires at least one <branch>' '
+	test_must_fail git -C forked branch --prune-merged 2>err &&
+	test_grep "requires at least one <branch>" err
+'
+
+test_expect_success '--prune-merged takes positional <branch> arguments' '
+	test_when_finished "rm -rf pm-positional" &&
+	git clone pm-upstream pm-positional &&
+	git -C pm-positional remote add fork ../pm-fork &&
+	test_config -C pm-positional remote.pushDefault fork &&
+	test_config -C pm-positional push.default current &&
+	git -C pm-positional branch one one-commit &&
+	git -C pm-positional branch --set-upstream-to=origin/next one &&
+	git -C pm-positional branch two base &&
+	git -C pm-positional branch --set-upstream-to=origin/main two &&
+	git -C pm-positional checkout --detach &&
+
+	git -C pm-positional branch --prune-merged origin/next origin/main &&
+
+	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
+	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
+'
+
 test_done
-- 
gitgitgadget

