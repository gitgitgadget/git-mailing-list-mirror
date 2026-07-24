Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9A425892
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889390; cv=none; b=Yputf/04kFnQB7vZMQJ6XGxBFBChZRwTAFveQvg5v0ulL5BgsTzIZvWNbFw3V2rEAd+4RYlxerz7qWGWdeuZI/BQUuDwzDYCwjCog6Tb+cqE4WPixbBBImJq/2eUlGSBseGuuCutXrgidDn9aNowtg4z/CU+PBd4bu0e6H9CJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889390; c=relaxed/simple;
	bh=yYiCUH8ner0GxglQ7O6CcvtrvrzYlU418rtEPu21MXk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jOqM1vcqtfPV3izEFfFfoYxO3+T3cadWh8/KAOBuQP4XV+fuyEL6wb9AfhaCT2MXPi7q1JwqH7eBKyMLOJyrywx/0U/ATPJv5JSJt/BHlLgk4mB4JrDgdtHm/WZWIiFcW3gZEEF8erH7Y0EXxRU11ODdBzQMheR7lrjwPU+LfUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNRKRnEN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNRKRnEN"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486672f03cso235120b3a.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889388; x=1785494188; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zV/oTMW+szmg5AGZuzE+pnhipA6hVsJPlIbfbLzZmc0=;
        b=lNRKRnENcrD+kD5KaOQ0meniCdX7q2MFWDlnvRlF5ecp245mZfZ+SqdTNkEFZHgLd6
         MJ8GvCOYM3jaRI01avwXpbQ19wDNLdp7QzA0ewnBqgS31sta0yCjhHBGZ5Vy2otRp1Q/
         RwW6ytTYFmnz1dUs9Zr8YbsmJ9YhHiFdM0jc0jaYeJFqDr4L/+ReP4keYQGhgVNfGeXV
         4cDUIFxJuGhD7AW6fsJLaFJ44SK3HA2GCmjjUk1Ue1EmSnconwqLPiWKC0aAAG+FK8A5
         rj1bGD0I5BNsIeyPz1IVfPJYymOe8xhp6hc+ddXbucnLHJ96h5odcD5wItQoqUnAREvn
         Y5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889388; x=1785494188;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zV/oTMW+szmg5AGZuzE+pnhipA6hVsJPlIbfbLzZmc0=;
        b=mUjntOjiBE16PvvstM62YTYukTqRcZaLucHU0XeU6AF7Vto1WiwKySnNKi4dkRtK6e
         m8Zs51E4xtk91sv/VecXzpUEDN+y/4kufz7TU11DrGpqzOCRi/U8oC6584Z1zqYGzpIA
         wOvG/0qH9LLjvsyc2354nTrAqiU6v4cx8GW9i1iFcscgLicRE5ta48t8+bZONp/XeIFk
         PZz6kA8zvR6+UmnsqSegPcXkeMuOviDBkMdJnpBVaglQleI9Rpr6fD/KHbSMopRYNL8u
         OHyFMZP7JYF4aAWcEnjJs1WvE72K79kqQ/46yZ9YflFzC0eGic7c/ub2coRNwezLneBT
         Owcg==
X-Gm-Message-State: AOJu0Yys0AmJuKIoCKJLAVD8n26XIOOIqk3ajTef9Sxmhy6LPwoCJ+8j
	pSHoPe6dMe0PEJIM3Z7FhZktrzW3j4KKjznt4GmQfjQ4endBNr18tO44r11TeQ==
X-Gm-Gg: AR+sD12bI8EGqC7WpyJEXSTnywwrxmU/MC8wx9ebTmTHI/MGEpfnXC6uOFG6jGPE9ix
	XyyDZ9a7bEY4YZaD5hqiKdwur9U5WVIWuChpU2VklS5peLZJSsE8Y0e5S3EcKhSHaJtCNdjEFlj
	fO3pPTJJhan98vvP9jifcRtMJrju4qd2Gmhtszd0YpjuCEXduzGApu71zDmTeMHO0KAiA2NrHoE
	CKKX5Y9zz8YEmfz6OrBOabwvoVW4xEC667CGFhAAsCDR0iHp1UZdG0dFwPOZSsd+by28ivHS7/V
	p8iMd1Fm75/4idpndhYY9UEQLxmRcAgwRjwlfBhTV4R7gmlg6EArwfkt9DImUPvMIsZCTTIQu1s
	RQKmXTABpzz466RNFtbIJ4g7hwHFsQwqCrZkcSdnb1YA9s7PmBRcpfz2sCgXLhRTAgfE3VwfqtC
	AOLF+tAHVpH8n5mdlv
X-Received: by 2002:a05:6a20:a11a:b0:3c0:9c19:65b4 with SMTP id adf61e73a8af0-3c44b2ae267mr7515486637.76.1784889387496;
        Fri, 24 Jul 2026 03:36:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f0ffe02sm4027900a12.14.2026.07.24.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 03:36:26 -0700 (PDT)
Message-Id: <598e68751e75931c7c1bd7f062e2957ecf8375be.1784889377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 10:36:15 +0000
Subject: [PATCH v21 5/7] branch: add --delete-merged <branch>
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

    git branch (--delete-merged <branch>)... [<pattern>...]

deletes local branches matching the optional patterns when their
configured upstream matches one of the --delete-merged arguments and
their tip is reachable from that upstream. The work has already landed
on the upstream they track, so the local copy is no longer needed.

The option can be repeated to widen the upstream match. Keeping the
candidate patterns as positional arguments lets users bound the set of
local branches that may be deleted independently of the upstream
selection.

A branch is not deleted when:

  * it is checked out in any worktree
  * its configured upstream ref no longer exists, since a missing
    upstream is not by itself a sign of integration
  * pushing it by name to the remote configured by
    branch.<name>.remote would update its upstream, as determined by
    mapping the branch ref through that remote's fetch refspec. For
    example, a local "main" that tracks "origin/main" is kept even when
    remote.pushDefault names a fork. Right after a pull it merely looks
    fully merged.

A branch whose work is not yet merged into its upstream is silently
skipped, so one unmerged topic does not abort the whole sweep.

A branch that a surviving branch depends on through a chain of local
upstreams is also kept, so no branch is deleted out from under stacked
work. Collect this transitive set without changing the candidate set
during ref iteration: walk upstream chains from surviving branches,
visit each branch at most once, and remove the collected bases only
after the iteration completes. This makes the result independent of
ref iteration order without repeated full scans.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  30 +++++
 builtin/branch.c              | 158 +++++++++++++++++++++++++-
 t/t3200-branch.sh             | 204 ++++++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b0d66a6deb..2a96cd7253 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch (--delete-merged <branch>)... [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -201,6 +202,35 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--delete-merged <branch>`::
+	Delete local branches whose configured upstream matches
+	_<branch>_, but only when their tip is reachable from that
+	upstream. In other words, the work on the branch has already
+	landed on the upstream it tracks, so the local copy is no longer
+	needed. The option can be repeated to widen the upstream match.
+	Optional _<pattern>_ arguments limit which local branches are
+	considered, e.g. `git branch --delete-merged 'origin/*'
+	'topic-*'`.
++
+A branch is not deleted when:
++
+--
+* its configured upstream ref no longer exists,
+* it is checked out in any worktree, or
+* pushing it by name to the remote configured by
+  `branch.<name>.remote` would update its upstream, so it cannot be
+  distinguished from a branch that just looks "fully merged" right
+  after a pull.
+--
++
+A branch whose work has not yet been merged into its upstream is
+silently skipped. Delete it with `git branch -D` if you want to
+remove it anyway.
++
+A branch that a surviving branch depends on through a chain of local
+upstreams is kept, so a branch is never deleted out from under stacked
+work.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1ef8362c12..e7677dcefa 100644
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
+	N_("git branch [<options>] (--delete-merged <branch>)... [<pattern>...]"),
 	NULL
 };
 
@@ -699,6 +701,148 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
 	return 0;
 }
 
+struct stacked_branch_data {
+	struct strset *deletable_branch_names;
+	struct strset *protected_branch_names;
+	struct strset *visited_branch_names;
+};
+
+static int collect_stacked_branch_bases(const struct reference *ref,
+					void *cb_data)
+{
+	struct stacked_branch_data *data = cb_data;
+	const char *branch_name;
+
+	if (!skip_prefix(ref->name, "refs/heads/", &branch_name))
+		BUG("expected local branch ref, got '%s'", ref->name);
+	if (strset_contains(data->deletable_branch_names, branch_name))
+		return 0;
+
+	while (strset_add(data->visited_branch_names, branch_name)) {
+		struct branch *branch = branch_get(branch_name);
+		const char *upstream_refname = branch_get_upstream(branch, NULL);
+		const char *upstream_branch_name;
+
+		if (!upstream_refname ||
+		    !skip_prefix(upstream_refname, "refs/heads/",
+				 &upstream_branch_name) ||
+		    !strset_contains(data->deletable_branch_names,
+				    upstream_branch_name))
+			break;
+
+		strset_add(data->protected_branch_names, upstream_branch_name);
+		branch_name = upstream_branch_name;
+	}
+
+	return 0;
+}
+
+static void protect_stacked_branch_bases(struct ref_store *refs,
+					 struct strset *deletable_branch_names)
+{
+	struct strset protected_branch_names = STRSET_INIT;
+	struct strset visited_branch_names = STRSET_INIT;
+	struct stacked_branch_data data = {
+		.deletable_branch_names = deletable_branch_names,
+		.protected_branch_names = &protected_branch_names,
+		.visited_branch_names = &visited_branch_names,
+	};
+	struct refs_for_each_ref_options opts = {
+		.prefix = "refs/heads/",
+	};
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	refs_for_each_ref_ext(refs, collect_stacked_branch_bases, &data, &opts);
+
+	strset_for_each_entry(&protected_branch_names, &iter, entry)
+		strset_remove(deletable_branch_names, entry->key);
+
+	strset_clear(&visited_branch_names);
+	strset_clear(&protected_branch_names);
+}
+
+static int branch_pushes_to_upstream(struct branch *branch,
+				     const char *upstream)
+{
+	struct remote *remote = remote_get(remote_for_branch(branch, NULL));
+	char *tracking = NULL;
+	int ret = 0;
+
+	if (remote)
+		tracking = apply_refspecs(&remote->fetch, branch->refname);
+	if (tracking && !strcmp(tracking, upstream))
+		ret = 1;
+
+	free(tracking);
+	return ret;
+}
+
+static int delete_merged_branches(const struct strvec *upstreams,
+				 const char **argv, unsigned int flags)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct ref_array candidates = { 0 };
+	struct strset deletable_branch_names = STRSET_INIT;
+	struct strvec branches_to_delete = STRVEC_INIT;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	int ret = 0;
+
+	for (size_t i = 0; i < upstreams->nr; i++)
+		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
+			die(_("'%s' is not a valid branch or pattern"),
+			    upstreams->v[i]);
+
+	filter.kind = FILTER_REFS_BRANCHES;
+	filter.name_patterns = argv;
+	filter_refs(&candidates, &filter, filter.kind);
+
+	for (size_t i = 0; i < (size_t)candidates.nr; i++) {
+		const char *branch_refname = candidates.items[i]->refname;
+		const char *branch_name;
+		struct branch *branch;
+		const char *upstream_refname;
+
+		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
+			BUG("filter returned non-branch ref '%s'", branch_refname);
+		if (branch_checked_out(branch_refname))
+			continue;
+
+		branch = branch_get(branch_name);
+		upstream_refname = branch_get_upstream(branch, NULL);
+		if (!upstream_refname || !refs_ref_exists(refs, upstream_refname))
+			continue;
+		if (branch_pushes_to_upstream(branch, upstream_refname))
+			continue;
+		if (check_branch_commit(branch_name, branch_name,
+					&candidates.items[i]->objectname, NULL,
+					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
+			continue;
+
+		strset_add(&deletable_branch_names, branch_name);
+	}
+
+	protect_stacked_branch_bases(refs, &deletable_branch_names);
+
+	strset_for_each_entry(&deletable_branch_names, &iter, entry)
+		strvec_push(&branches_to_delete, entry->key);
+
+	if (branches_to_delete.nr)
+		ret = delete_branches(branches_to_delete.nr, branches_to_delete.v,
+				      FILTER_REFS_BRANCHES,
+				      DELETE_BRANCH_SKIP_UNMERGED |
+				      DELETE_BRANCH_NO_HEAD_FALLBACK |
+				      flags);
+
+	strvec_clear(&branches_to_delete);
+	strset_clear(&deletable_branch_names);
+	ref_array_clear(&candidates);
+	ref_filter_clear(&filter);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -763,6 +907,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	struct strvec delete_merged = STRVEC_INIT;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -816,6 +961,9 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
+			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -863,7 +1011,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !delete_merged.nr &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -873,7 +1022,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!delete_merged.nr;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -915,6 +1064,10 @@ int cmd_branch(int argc,
 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
 				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
+	} else if (delete_merged.nr) {
+		ret = delete_merged_branches(&delete_merged, argv,
+					     quiet ? DELETE_BRANCH_QUIET : 0);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
@@ -1083,6 +1236,7 @@ int cmd_branch(int argc,
 	ret = 0;
 
 out:
+	strvec_clear(&delete_merged);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4ffd224a71..268203089b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1872,4 +1872,208 @@ test_expect_success '--forked requires a value' '
 	test_grep "requires a value" err
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
+		git config push.default current &&
+		git fetch other
+	)
+}
+
+create_merged_branch () {
+	(
+		cd repo &&
+		git checkout -b "$1" origin/next --track &&
+		git commit --allow-empty -m "$1 work" &&
+		git push origin "$1:next"
+	)
+}
+
+check_branches () {
+	git for-each-ref --format="%(refname:short)" refs/heads/ >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success '--delete-merged keeps cloned main without a default push remote' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout --detach &&
+
+		git branch --delete-merged */* &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged deletes only selected merged branches' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch also-merged &&
+	create_merged_branch merged &&
+	(
+		cd repo &&
+		git checkout -b unmerged origin/next --track &&
+		git commit --allow-empty -m "unmerged work" &&
+		git checkout -b tracks-other other/main --track &&
+		sha=$(git rev-parse --short merged) &&
+
+		git branch --delete-merged origin/next merged >actual 2>&1 &&
+		echo "Deleted branch merged (was $sha)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		also-merged
+		main
+		tracks-other
+		unmerged
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged keeps main despite a different default push remote' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch on-next &&
+	create_merged_branch checked-out &&
+	create_merged_branch upstream-gone &&
+	(
+		cd repo &&
+		git config remote.pushDefault fork &&
+		git checkout -b local-to-delete main --track &&
+		git update-ref refs/remotes/origin/topic refs/remotes/origin/next &&
+		git branch --set-upstream-to=origin/topic upstream-gone &&
+		git update-ref -d refs/remotes/origin/topic &&
+		git checkout -b tracks-other other/main --track &&
+		git checkout checked-out &&
+
+		git branch --delete-merged origin/* \
+			--delete-merged main &&
+
+		check_branches <<-\EOF
+		checked-out
+		main
+		tracks-other
+		upstream-gone
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged keeps the upstream of a surviving branch' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch feature &&
+	(
+		cd repo &&
+		git checkout -b topic feature --track &&
+		git commit --allow-empty -m "topic work" &&
+
+		git branch --delete-merged origin/next 2>err &&
+
+		test_must_be_empty err &&
+		check_branches <<-\EOF &&
+		feature
+		main
+		topic
+		EOF
+
+		git config --local --get-regexp "branch\\.(feature|topic)\\.(merge|remote)" >actual &&
+		cat >expect <<-\EOF &&
+		branch.feature.remote origin
+		branch.feature.merge refs/heads/next
+		branch.topic.remote .
+		branch.topic.merge refs/heads/feature
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--delete-merged keeps the upstream chain of a surviving branch' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git config remote.pushDefault fork &&
+		git branch lower origin/next --track &&
+		git branch mid lower --track &&
+		git checkout -b tip mid --track &&
+		git commit --allow-empty -m "tip work" &&
+
+		git branch --delete-merged origin/next \
+			--delete-merged lower >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		check_branches <<-\EOF &&
+		lower
+		main
+		mid
+		tip
+		EOF
+
+		git config --local --get-regexp "branch\\.(lower|mid|tip)\\.(merge|remote)" >actual &&
+		cat >expect <<-\EOF &&
+		branch.lower.remote origin
+		branch.lower.merge refs/heads/next
+		branch.mid.remote .
+		branch.mid.merge refs/heads/lower
+		branch.tip.remote .
+		branch.tip.merge refs/heads/mid
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--delete-merged result is independent of stacked branch names' '
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git branch c-lower origin/next --track &&
+		git branch b-mid c-lower --track &&
+		git checkout -b a-tip b-mid --track &&
+		git commit --allow-empty -m "tip work" &&
+
+		git branch --delete-merged origin/next \
+			--delete-merged "c-*" &&
+
+		check_branches <<-\EOF &&
+		a-tip
+		b-mid
+		c-lower
+		main
+		EOF
+
+		git branch --delete-merged origin/next \
+			--delete-merged "c-*" >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		check_branches <<-\EOF
+		a-tip
+		b-mid
+		c-lower
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-merged requires a value' '
+	test_must_fail git -C forked branch --delete-merged 2>err &&
+	test_grep "requires a value" err
+'
 test_done
-- 
gitgitgadget

