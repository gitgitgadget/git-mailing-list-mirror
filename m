Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037F36729D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113402; cv=none; b=RFLyrkngO+7euOURXE5RnuQuKBKhKv5B8HV+LTxXahVvPpkgJWLNH3KBrZ8pPKH/aEAKTTZ07YUxgdria7m+U46A6LKuMaJuVnkSLwROV7IJhMFuskN85bgctDeJqlBuGp2bV+Opgvr+ssDKxrr0tieRY55yPI5GlP4scX3quo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113402; c=relaxed/simple;
	bh=TGadD6ZjPJ2CwgCiCmYzF3XZ5G7g3BbzhohggBTwkY8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dKQrtWPALxHPDVGD4mjkpYefHKrdCb0B4CX8A5Uu/IiCu4o0rnfLBX7AAsEOeCBRor5rEZi6m0s6HUn8LEVqGh7uZdS62wU5aCodLWQHsyZIdYE/aCYoCHE3Bf88C0Ct1HU2iP2liHeMTKK3uUPJTtwSTsznwg+o1bwEQ+rk6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mti6fqdM; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mti6fqdM"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139b914bab6so762156c88.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113400; x=1782718200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckCuX07zGQ2DBaBnbwbnuNHSNvbOcbGVroUbRukPVVc=;
        b=mti6fqdMAMyMSuBimQZo/8vIrb6iT3IZCdz7P9YbJEeu5zQk+NK3b0vJIMlIJ5DFtE
         BqJop5PPrgxBUtnsLt0pAXk+cnYgaUo5vfxUDc7EnxiK0JknIQnmqwyEnHnx+17t4bDK
         EQjZJb43cac1h22JyWCsecaEqRG+/7SfnYcDmweUbzko3xvt2pj3HHnzm6WGXjmgeusg
         UKAnJOk1EASY1ZPsZiN+uiX3li1K73TRAyvF4pnShKeHmWJzbp84TXm49iRSO0xQRsKE
         itUnSMqEV1bre9Q1d/vMBtmDekp7hXNjgts3/dIxxs/omeYEBNoMWhmKMJrXe4cQ5iMV
         BEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113400; x=1782718200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckCuX07zGQ2DBaBnbwbnuNHSNvbOcbGVroUbRukPVVc=;
        b=knbF/lqv1nbi1ZzZh5YmUEQVIiOBLbUtRvpAAav/pTQLtPzE6r+Go1mTwkNB6UsykJ
         5e68jn7LTn/maaLzOXjqt0QeWmDrJ1e1X/2XlRueNhySYwaw4crAHJLx7jhYGUAjP1xO
         bhDNNZRbYP196Q/JESIgnyd5O3LxX24cLY8DW6jHw/ZkXPK8XoFjRImrEBUWUzHwLyRX
         feeG57qhtRgOkWC39d11hMs89UG+JsWActgbA4aMj3C+2MFZ5FaPvAf+6amNACaisyRb
         EfnPXhptZlTYX310b/RdKd4d0CYr0ritVjBwDlSQQvwb2sqtFGMYeFRNA2W/xK/wYx+m
         KJ3Q==
X-Gm-Message-State: AOJu0YwMaU25IKfd3yjby2JLSXPomblTZ7NLwz7y9Vzp40ygD9RVyBmm
	MPIebvTIKMiirmlwWglvgh/j8d+97G66ITbiqLXAzTO8H70dFufIJ+R8wtGMUA==
X-Gm-Gg: AfdE7cnhWC/AHrf6fuWeWZiNcjrkryAPYwFeQKZwnAoPiGUkH1v7NfPt6sb7kSkoYLw
	S4esdC8cqJPAqXSh8Glm0uLf+UvN6UPPRcb4Iu1DPyDdzq4hmfyx3JcayBX4yzFZeussswdUJ8C
	jShd0q5Gd18OR8VQbPBL92pF6exFvcE31ogXn6LsjdPdGW1FJFFt+K5rTxuk9PSOnzuX0HyhYtL
	glw+i/vGiCMun4R05M9XadQ+P1+d8WN+8jG1XQS1QRlYv7R5IfRTyNTfdIhQmPkDfFH0VKFQoPX
	x8L6GRK1VRWhpBcidKKyNbqg9rOwmIbwcfa13NGPeilsDgQkjfMr6nNqSezhSJgZAKUGOTEJfsk
	cz2PQSZ9Vyl8PYEimuUEqSFCZLOjZ+t9q0S1LRhAx9ogR/RlOKwYOWFei9vfy9Cj0dAJ8saAcUJ
	ysRRjcr1XEh4vaItQS3w==
X-Received: by 2002:a05:7022:419:b0:137:fc94:9758 with SMTP id a92af1059eb24-139a210df39mr7808070c88.19.1782113399558;
        Mon, 22 Jun 2026 00:29:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcb7aabsm8321619c88.5.2026.06.22.00.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:29:56 -0700 (PDT)
Message-Id: <46da7c814056ddbc23accf19a61d0451b949127e.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:46 +0000
Subject: [PATCH v17 5/7] branch: add --delete-merged <branch>
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

	git branch --delete-merged <branch>...

deletes the local branches that "--forked <branch>" would list,
keeping only those whose tip is reachable from their configured
upstream. The work has already landed on the upstream they track,
so the local copy is no longer needed.

Three kinds of branches are not deleted:

  * any branch checked out in any worktree
  * any branch whose upstream remote-tracking branch no longer
    exists, since a missing upstream is not by itself a sign of
    integration
  * any branch whose push destination equals its upstream
    (<branch>@{push} is the same as <branch>@{upstream}), such as
    a local "main" that tracks and pushes to "origin/main". Right
    after a pull it just looks "fully merged", so it is kept. Only
    branches that push somewhere other than their upstream,
    typically topics in a fork workflow, are candidates.

A branch whose work is not yet merged into its upstream is silently
skipped, so one unmerged topic does not abort the whole sweep.

A branch that another, surviving branch tracks as its upstream is
also kept, so a branch is never deleted out from under one stacked
on top of it. Sparing such a base can in turn protect its own
upstream, so the check repeats until the set stops changing.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  28 +++++++
 builtin/branch.c              | 128 +++++++++++++++++++++++++++-
 t/t3200-branch.sh             | 151 ++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b0d66a6deb..56ff889447 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --delete-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -201,6 +202,33 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--delete-merged <branch>...`::
+	Delete the local branches that `--forked` would list for the
+	given _<branch>_ arguments, but only those whose tip is
+	reachable from their configured upstream. In other words, the
+	work on the branch has already landed on the upstream it
+	tracks, so the local copy is no longer needed. Several
+	_<branch>_ patterns may be given, e.g. `git branch
+	--delete-merged origin/main 'feature*'`.
++
+A branch is not deleted when:
++
+--
+* its upstream remote-tracking branch no longer exists,
+* it is checked out in any worktree, or
+* its push destination (`<branch>@{push}`) equals its upstream
+  (`<branch>@{upstream}`), so it cannot be distinguished from a
+  branch that just looks "fully merged" right after a pull.
+--
++
+A branch whose work has not yet been merged into its upstream is
+silently skipped. Delete it with `git branch -D` if you want to
+remove it anyway.
++
+A branch that another, surviving branch still tracks as its upstream
+is kept, so a branch is never deleted out from under one stacked on
+top of it.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 01c1f64c73..35fd3e9efc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -21,6 +21,7 @@
 #include "branch.h"
 #include "path.h"
 #include "string-list.h"
+#include "strmap.h"
 #include "column.h"
 #include "utf8.h"
 #include "ref-filter.h"
@@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --delete-merged <branch>..."),
 	NULL
 };
 
@@ -705,6 +707,120 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
+static int collect_upstream(const struct reference *ref, void *cb_data)
+{
+	struct string_list *upstreams = cb_data;
+	struct branch *branch = branch_get(ref->name);
+	const char *upstream = branch_get_upstream(branch, NULL);
+
+	string_list_append(upstreams, ref->name)->util =
+		xstrdup_or_null(upstream);
+	return 0;
+}
+
+/*
+ * Keep any branch that another, surviving branch tracks as its
+ * upstream, so we never delete a branch out from under one stacked on
+ * top of it.  Sparing a branch makes it a survivor whose own upstream
+ * then needs the same protection, so repeat until nothing changes.
+ */
+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
+{
+	struct string_list upstreams = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	bool spared;
+
+	refs_for_each_branch_ref(refs, collect_upstream, &upstreams);
+	do {
+		spared = false;
+		for_each_string_list_item(item, &upstreams) {
+			const char *up = item->util, *up_short;
+
+			if (!up || strset_contains(deletable, item->string))
+				continue;
+			if (!skip_prefix(up, "refs/heads/", &up_short) ||
+			    !strset_contains(deletable, up_short))
+				continue;
+
+			strset_remove(deletable, up_short);
+			spared = true;
+		}
+	} while (spared);
+
+	string_list_clear(&upstreams, 1);
+}
+
+static int delete_merged_branches(int argc, const char **argv,
+				 unsigned int flags)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array candidates = { 0 };
+	struct strset deletable = STRSET_INIT;
+	struct strvec to_delete = STRVEC_INIT;
+	int i, ret = 0;
+
+	if (!argc)
+		die(_("--delete-merged requires at least one <branch>"));
+
+	for (i = 0; i < argc; i++)
+		if (ref_filter_forked_add(&filter, argv[i]) < 0)
+			die(_("'%s' is not a valid branch or pattern"), argv[i]);
+
+	filter.kind = FILTER_REFS_BRANCHES;
+	filter_refs(&candidates, &filter, filter.kind);
+
+	for (i = 0; i < candidates.nr; i++) {
+		const char *full_name = candidates.items[i]->refname;
+		const char *short_name;
+		struct branch *branch;
+		const char *upstream, *push;
+
+		if (!skip_prefix(full_name, "refs/heads/", &short_name))
+			BUG("filter returned non-branch ref '%s'", full_name);
+		if (branch_checked_out(full_name))
+			continue;
+
+		branch = branch_get(short_name);
+		upstream = branch_get_upstream(branch, NULL);
+		if (!upstream || !refs_ref_exists(refs, upstream))
+			continue;
+		push = branch_get_push(branch, NULL);
+		if (!push || !strcmp(push, upstream))
+			continue;
+		if (check_branch_commit(short_name, short_name,
+					&candidates.items[i]->objectname, NULL,
+					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
+			continue;
+
+		strset_add(&deletable, short_name);
+	}
+
+	spare_stacked_bases(refs, &deletable);
+
+	for (i = 0; i < candidates.nr; i++) {
+		const char *short_name;
+
+		if (skip_prefix(candidates.items[i]->refname, "refs/heads/",
+				&short_name) &&
+		    strset_contains(&deletable, short_name))
+			strvec_push(&to_delete, short_name);
+	}
+
+	if (to_delete.nr)
+		ret = delete_branches(to_delete.nr, to_delete.v,
+				      FILTER_REFS_BRANCHES,
+				      DELETE_BRANCH_SKIP_UNMERGED |
+				      DELETE_BRANCH_NO_HEAD_FALLBACK |
+				      flags);
+
+	strvec_clear(&to_delete);
+	strset_clear(&deletable);
+	ref_array_clear(&candidates);
+	ref_filter_clear(&filter);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -746,6 +862,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int delete_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -799,6 +916,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "delete-merged", &delete_merged,
+			N_("delete local branches whose upstream matches <branch> and are merged")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -846,7 +965,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !delete_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -856,7 +976,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!delete_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -898,6 +1018,10 @@ int cmd_branch(int argc,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
+	} else if (delete_merged) {
+		ret = delete_merged_branches(argc, argv,
+					     quiet ? DELETE_BRANCH_QUIET : 0);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3104c555f6..1d372f95e8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1839,4 +1839,155 @@ test_expect_success '--forked narrows a <pattern> argument' '
 	test_cmp expect actual
 '
 
+test_expect_success '--delete-merged: setup' '
+	git init -b main upstream &&
+	(
+		cd upstream &&
+		test_commit base &&
+		git checkout -b next &&
+		test_commit next-work &&
+		git checkout main
+	) &&
+	git init -b main other &&
+	test_commit -C other other-base &&
+	git init -b main fork
+'
+
+setup_repo_for_delete_merged () {
+	rm -rf repo &&
+	git clone upstream repo &&
+	(
+		cd repo &&
+		git remote add fork ../fork &&
+		git remote add other ../other &&
+		git config remote.pushDefault fork &&
+		git config push.default current &&
+		git fetch other
+	)
+}
+
+merged_branch () {
+	(
+		cd repo &&
+		git checkout -b "$1" "$2" &&
+		git commit --allow-empty -m "$1 work" &&
+		git push origin "$1:next" &&
+		git fetch origin &&
+		git branch --set-upstream-to="$2" "$1"
+	)
+}
+
+test_expect_success '--delete-merged deletes merged branches and spares the rest' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch merged origin/next &&
+	(
+		cd repo &&
+		git checkout -b unmerged origin/next &&
+		git commit --allow-empty -m "unmerged work" &&
+		git branch --set-upstream-to=origin/next unmerged &&
+		git checkout -b tracks-other other/main &&
+		git branch --set-upstream-to=other/main tracks-other &&
+		git checkout --detach
+	) &&
+	sha=$(git -C repo rev-parse --short merged) &&
+
+	git -C repo branch --delete-merged origin/next >actual 2>&1 &&
+
+	echo "Deleted branch merged (was $sha)." >expect &&
+	test_cmp expect actual &&
+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	main
+	tracks-other
+	unmerged
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--delete-merged deletes merged branches and spares protected ones' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch on-next origin/next &&
+	merged_branch checked-out origin/next &&
+	merged_branch upstream-gone origin/next &&
+	(
+		cd repo &&
+		git checkout -b mainline main &&
+		git checkout -b on-local mainline &&
+		git branch --set-upstream-to=mainline on-local &&
+		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
+		git branch --set-upstream-to=origin/topic upstream-gone &&
+		git update-ref -d refs/remotes/origin/topic &&
+		git branch --set-upstream-to=origin/main main &&
+		git config branch.main.pushRemote origin &&
+		git checkout -b tracks-other other/main &&
+		git branch --set-upstream-to=other/main tracks-other &&
+		git checkout checked-out
+	) &&
+
+	git -C repo branch --delete-merged origin/next mainline &&
+
+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	checked-out
+	main
+	mainline
+	tracks-other
+	upstream-gone
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--delete-merged requires at least one <branch>' '
+	test_must_fail git -C forked branch --delete-merged 2>err &&
+	test_grep "requires at least one <branch>" err
+'
+
+test_expect_success '--delete-merged keeps a branch that is an upstream' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	merged_branch feature origin/next &&
+	(
+		cd repo &&
+		git checkout -b topic feature &&
+		git commit --allow-empty -m "topic work" &&
+		git branch --set-upstream-to=feature topic &&
+		git checkout --detach
+	) &&
+
+	git -C repo branch --delete-merged origin/next 2>err &&
+
+	test_must_be_empty err &&
+	git -C repo rev-parse --verify refs/heads/feature &&
+	git -C repo rev-parse --verify refs/heads/topic
+'
+
+test_expect_success '--delete-merged keeps a chain of upstreams of a kept branch' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch b3 origin/next &&
+		git branch --set-upstream-to=origin/next b3 &&
+		git branch b2 origin/next &&
+		git branch --set-upstream-to=b3 b2 &&
+		git checkout -b b1 b2 &&
+		git commit --allow-empty -m "b1 work" &&
+		git branch --set-upstream-to=b2 b1 &&
+		git checkout --detach
+	) &&
+
+	git -C repo branch --delete-merged origin/next &&
+
+	git -C repo for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	b1
+	b2
+	b3
+	main
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

