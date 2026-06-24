Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DC31717C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338124; cv=none; b=OB/MqFPBU2uC9WyZ6dM8O5Rq0vYn0f+AgZbmMyxJWMaZM/we6i++RJZPg9X4n5sgvyQFj/2h+TfSHF9z4MBN35jF+BMytumqgwLACM7uD7VluvW61vI2KrfFaG7okkdt8BUDbcPlyU527bQffvYK0U8vF24jkmOoAxi4NRUpSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338124; c=relaxed/simple;
	bh=bqWq+NM1s4/nw5qPf0+n3PvpNOdQSVzsU2kPJgcXJ/8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dDV5y3TxY4QgfuECriNVsSvDBsOy98hfaTJOco+waE40zNYvRogp2fh8BeLpoT6zFKvIGvjHcJeEXurZHnFJw529q78nmlncOYfgIKmN5PU5nN5IhgLt942ydb99iS7v4ZJM6paJDy5WsxbVeHDC0VZ4F35o6MZCuulH/GdzGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9j1yd5/; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9j1yd5/"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-139986373b8so2141133c88.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782338121; x=1782942921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67OgQkGSnOpDKjIANFS0+95wNrmG2Mu0KwvlXD9c5L8=;
        b=j9j1yd5/ra1nKhPzL3Ib7VuDinYbrn3nzP6IIprIZGaMHW04os+4cSNj1kZV1o/sjo
         Wx01kvPvUNbPLKtm2BerThFVzmKp+7DAYctYIC4DmH9ZCIoHNAMBxbEque5aU92cPL3i
         xJ2BVDE2CS/iCZ/Z6e4tY279IxFy4NetYrk4/WKP+yBSPJy+f6nDEqkfHBuLHaCN7X0J
         RuyGNq673AXawOJWL+O9E3Fn+TARZtLJEpvGx7Z2RNwGkhhMG+uIox0qtL/1zvVueuap
         kslHTGQRAU/CTzVppBK/vJWhXfdTRa1rUVnurnL8KwbVJddinw4ut7CnuLPAF/+4ODYo
         JGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338121; x=1782942921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67OgQkGSnOpDKjIANFS0+95wNrmG2Mu0KwvlXD9c5L8=;
        b=Pc4/CoNIZNSih8JUxRNn7FZxhNbqRDr4XfHrJhKLXjA6ZIp3bgHDKdGdXUyZ/a86zb
         FWrLj6GLPsi6rj9rU0/NQ9TOXqT5d+b9AMwObFrcxYl4pro1X7qeNCZkWDQfPvZArzVV
         ek/m8bc41XrgJ50iARWnpoDqexyv/VhjBXNalXXSmI60w/h5QLI8mmUzEheynLFMF/3R
         k8nsAwU+4IAAkP/X+ew869DKuosVmhNN367nQSpxuXqdaGsTd3yeCz3QvOalgDfM6DGZ
         eD7R4RzQir+NkNB1b8f1cLzToTWe2WeKUXafshDuZJhERUw1viBfRtVxboZwqEdf92nx
         ZAsQ==
X-Gm-Message-State: AOJu0Yyv+07XuOUwu3g2RHFoxgCr8KlAS1RUBSg9ESZ0kgUMxpYuG40v
	D+zf8iWQT0BgxE7AnkNZMzgXmHZn3RfeXQAQJnuI9RaeHOaRjXLrUO9w+OeaCKPa
X-Gm-Gg: AfdE7clG61goZ/lvwgVyfk33RGoo6jKXKjzoLRf75r9KLNHnpJvfnJrzAFKh+pY0rcz
	Jj+OHp/1yvLq0ETzlGRnXOYKiCH6ZGii3voimOnr+tCAgOCqbrOlEXQXuisAdFrXSkmIKe4fZrV
	dvob9AeEmMY9Gz25UmHOn7PrPkxqZRyCkgN3D5eCsy1ZM3BP1+GY7ox9hXuasaUqpUdYzg7FSdQ
	t66wwUSvg0ZKF+UZxQ5Ay+H58D7BYmZCLGCCTu2kejc292RL+n5KfJA0Ew0o9nqhIAHsjzeU7z0
	fvZUehwK5QF5V55zkYtmQycVfA1R23zr5dCJX1zEq1mzX53Bua9HfxBHBPZxZXd3kLmRwVCqYDe
	jDipj8S0DctTDJTABbQ9Z860tTTXoyZf7ByX5ZuIU2ciDwCM9O3g7cGovfJDpvBkDNE6/8L/PUt
	+hfzfCBF+fOWLufxEo
X-Received: by 2002:a05:7022:f9f:b0:136:c77a:6509 with SMTP id a92af1059eb24-139d0c81e1cmr3953211c88.25.1782338116475;
        Wed, 24 Jun 2026 14:55:16 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.149.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006afsm1893303c88.12.2026.06.24.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:55:15 -0700 (PDT)
Message-Id: <a84c555d99c98abcd4618833c14fa35b191fbda2.1782338106.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
	<pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 21:55:04 +0000
Subject: [PATCH v18 5/7] branch: add --delete-merged <branch>
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

A branch is not deleted when:

  * it is checked out in any worktree
  * its upstream remote-tracking branch no longer exists, since a
    missing upstream is not by itself a sign of integration
  * its push destination equals its upstream (<branch>@{push} is
    the same as <branch>@{upstream}), such as a local "main" that
    tracks and pushes to "origin/main". Right after a pull it just
    looks "fully merged", so it is kept. Only branches that push
    somewhere other than their upstream, typically topics in a fork
    workflow, are candidates.

A branch whose work is not yet merged into its upstream is silently
skipped, so one unmerged topic does not abort the whole sweep.

A branch that another, surviving branch tracks as its upstream is
also kept, so a branch is never deleted out from under one stacked
on top of it. Such a kept branch is itself merged, so when its own
upstream is being deleted, clear its now-stale upstream config.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  29 ++++++
 builtin/branch.c              | 147 ++++++++++++++++++++++++++-
 t/t3200-branch.sh             | 185 ++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b0d66a6deb..66b1c87c55 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --delete-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -201,6 +202,34 @@ This option is only applicable in non-verbose mode.
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
+A branch that another, surviving branch tracks as its upstream is
+kept, so a branch is never deleted out from under one stacked on top
+of it. If that kept branch in turn tracks a branch that is being
+deleted, its now-stale upstream configuration is cleared.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 01c1f64c73..d12a2f57ea 100644
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
 
@@ -705,6 +707,139 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
+struct spare_data {
+	struct strset *deletable;
+	struct strset *spared;
+};
+
+/*
+ * A surviving branch stacked on a deletion candidate would lose its
+ * upstream, so drop that candidate from the delete set and remember it
+ * in "spared" so its own upstream can be tidied up afterwards.
+ */
+static int spare_stacked_base(const struct reference *ref, void *cb_data)
+{
+	struct spare_data *data = cb_data;
+	struct branch *branch;
+	const char *upstream, *up_short;
+
+	if (strset_contains(data->deletable, ref->name))
+		return 0;
+	branch = branch_get(ref->name);
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
+	    !strset_contains(data->deletable, up_short))
+		return 0;
+
+	strset_remove(data->deletable, up_short);
+	strset_add(data->spared, up_short);
+	return 0;
+}
+
+/*
+ * Keep any branch that a surviving branch tracks as its upstream, so we
+ * never delete a branch out from under one stacked on top of it.  Such a
+ * base is itself merged, so when its own upstream is also going away
+ * (no surviving branch tracks it), clear the base's now-stale upstream.
+ */
+static void spare_stacked_bases(struct ref_store *refs, struct strset *deletable)
+{
+	struct strset spared = STRSET_INIT;
+	struct spare_data data = { .deletable = deletable, .spared = &spared };
+	struct strbuf key = STRBUF_INIT;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	refs_for_each_branch_ref(refs, spare_stacked_base, &data);
+
+	strset_for_each_entry(&spared, &iter, entry) {
+		struct branch *branch = branch_get(entry->key);
+		const char *upstream = branch_get_upstream(branch, NULL);
+		const char *up_short;
+
+		if (!upstream || !skip_prefix(upstream, "refs/heads/", &up_short) ||
+		    !strset_contains(deletable, up_short))
+			continue;
+
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.merge", branch->name);
+		repo_config_set_gently(the_repository, key.buf, NULL);
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.remote", branch->name);
+		repo_config_set_gently(the_repository, key.buf, NULL);
+	}
+
+	strbuf_release(&key);
+	strset_clear(&spared);
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
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
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
+	strset_for_each_entry(&deletable, &iter, entry)
+		strvec_push(&to_delete, entry->key);
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
@@ -746,6 +881,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int delete_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -799,6 +935,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "delete-merged", &delete_merged,
+			N_("delete local branches whose upstream matches <branch> and are merged")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -846,7 +984,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !delete_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -856,7 +995,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!delete_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -898,6 +1037,10 @@ int cmd_branch(int argc,
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
index 3104c555f6..047ba54778 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1839,4 +1839,189 @@ test_expect_success '--forked narrows a <pattern> argument' '
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
+	git -C repo branch --dry-run --delete-merged origin/next >out &&
+	test_grep ! "feature" out &&
+
+	git -C repo branch --delete-merged origin/next 2>err &&
+
+	test_must_be_empty err &&
+	git -C repo rev-parse --verify refs/heads/feature &&
+	git -C repo rev-parse --verify refs/heads/topic &&
+	echo origin/next >expect &&
+	git -C repo rev-parse --abbrev-ref feature@{upstream} >actual &&
+	test_cmp expect actual &&
+	echo feature >expect &&
+	git -C repo rev-parse --abbrev-ref topic@{upstream} >actual &&
+	test_cmp expect actual
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
+test_expect_success '--delete-merged clears the upstream of a kept base whose own base is deleted' '
+	test_when_finished "rm -rf repo" &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch lower origin/next &&
+		git branch --set-upstream-to=origin/next lower &&
+		git branch mid origin/next &&
+		git branch --set-upstream-to=lower mid &&
+		git checkout -b tip mid &&
+		git commit --allow-empty -m "tip work" &&
+		git branch --set-upstream-to=mid tip &&
+		git checkout --detach
+	) &&
+
+	git -C repo branch --delete-merged origin/next lower &&
+
+	test_must_fail git -C repo rev-parse --verify refs/heads/lower &&
+	git -C repo rev-parse --verify refs/heads/mid &&
+	test_must_fail git -C repo rev-parse mid@{upstream} &&
+	echo mid >expect &&
+	git -C repo rev-parse --abbrev-ref tip@{upstream} >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

