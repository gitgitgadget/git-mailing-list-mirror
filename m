Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A414156C6
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053510; cv=none; b=Jlu/+k7pKnd8mvMrUx82uQL6gpw+OipSRR6spsGVFmPMVXT05pV1JPM3pOIhMVdGEUKZJYzc39XpPUz/iB37gNo3gh1kG/cvH6iyl3BhOFEw+0upxtW0h/ZMDqmHYjMyTG//GEaHOI0GT9Hw8EGBhbOQJIz3Jtk/2dSibQLuYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053510; c=relaxed/simple;
	bh=wRabIILznwIVhTOmRT2KT4iVOSfMAo9hfGfylAfVwws=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UJHyc0pfXmBcZ8IGK1cPejY3+TccK2uWY41hQaL5FncodUYIFr81WQbxZ2RhUqQj7OF7CJrlWjjyl9hojvmctf6jNDFd9JLw3NaWXegm+JK4loqSgELkm2Bx3httlY1dUjT0gfK/1BYBZBNW9Vw1yyk2vMxiZ8C47iChYmX03tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQln00vf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQln00vf"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c998fd549a8so3092160a12.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053504; x=1784658304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SGSsXTFldB2b1YssGm/FFGatxWhJ5O+cEAJwSHMYR0Y=;
        b=WQln00vfopdNY+x2z6WC2fjs2WMeEsfIfp6jtf7vzr8ILiJUYdZlrACXmu3Yi1Th9R
         BXby5T4Dwidv/GPo9FioAcV/7QK3+9MFVSbO73Lk7zI61urOFS8v7mhtKiPCsSTNFJih
         ckXN+ebpbyIkhELOFfNOHvPC57csUZHXud55V7fC1pGJ65cjlG4MbgONjev/0KMHVCUb
         NN08VwdhPgsCYwAycBgCsaH0ZNytUP1N0cz8eRcG2FMnNvp6qQ8TxKIfuvlQVlCkAWrU
         TIPjcfFsxNOgv6TuKq+5FMx7v1eC0ZmxAQA4uOFe/wfQJJVKRHZkA9cYhNnZeMuMutjW
         jPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053504; x=1784658304;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGSsXTFldB2b1YssGm/FFGatxWhJ5O+cEAJwSHMYR0Y=;
        b=WypGtk95EY4D9AbCK8ETcqOeB8qgVZWBepeDhge6yR4qtf5+B1WCbBNepZnbO90WFO
         qhqhTK+QKD7/QvPeNGC+UOGZJ0otg9Ucyvl7bG6Kz3fXGNCCYhxYOV4HGf+DpVO34ASy
         NNsIP99c1Iz9azX5GuZ+jiAw/mva+U9ujIOjMRxxSF+85CbLcwHZ2yjM5ZV8qS1OAYoV
         EIRAi0RszzvF9YGksKaR51x/072l5raIweN2lOiN9caGE7bSR/GTqtiBFXK01qYYvBPK
         XNcfX/0O58ap79D1VSvZZTXfHe62ltHtvv/v+HP1XwbgaYgC13qi8L2eCw5l9ZquWapl
         dung==
X-Gm-Message-State: AOJu0Yw3ZJpxtz9xpk9jGuAvOKCiV5jRUL8/A9gzPxAGcf+x1vI8o9G7
	3cuJF17ilRolXrz7VfcYqKwsSazBIYOhHUjLtpiy7vf9obBcZJ5w4rdjSOoWZQ==
X-Gm-Gg: AfdE7cnAqqNzsZ7wBwaqzrmL2DTys18gb3O1FqaD+AraRvYUxqMWlhoK3WiwYs0Z3Rf
	CnZlLs9xwx00iSyP1XeMhpjufmPcpfAAgnPnTzyrXlmisYFWU0NnT3QP6klrIsF0pQ6a7OfvJsQ
	NF+DWUc+aNLwC6TFQKCsJ5S5XAtj1HOs2GAmVIEGjD9JHpo0skHSHvB/X81dfmSI6bgJ83WAStG
	vJX/E4NARNK8uvtGLX4pLWFNwpmZor/gyskr49hV9su4efnz23efh8eJ2XsBRIAlcoKGa7O61RF
	Q8kx0KTB2aHqgi7MfUWVL3s9kNAD+b02vgPfPZKcBTdgB1YfJllnHPrOlKBMrj4ZU4TiRDeiT+1
	xy/xhhCnCbHyVxfXf8jvpvBzUBZhEfjI0ECTTv06vkutkEKnhbxc4YYVwo2q0ifBauU9PkzmZWr
	AAgtf0A1vaSvGU7V+r
X-Received: by 2002:a05:6a20:3d1f:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3c1108993efmr17715677637.41.1784053503495;
        Tue, 14 Jul 2026 11:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm59741072eec.24.2026.07.14.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:25:02 -0700 (PDT)
Message-Id: <a6caa5b397da8ea24eb97e6aa6dc92b437e456ef.1784053493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
References: <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
	<pull.2285.v19.git.git.1784053493.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:24:51 +0000
Subject: [PATCH v19 5/7] branch: add --delete-merged <branch>
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

A branch that another, surviving branch tracks as its upstream is
also kept, so a branch is never deleted out from under one stacked
on top of it. Such a kept branch is itself merged, so when its own
upstream is being deleted, clear its now-stale upstream config.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  31 +++++++
 builtin/branch.c              | 164 ++++++++++++++++++++++++++++++++-
 t/t3200-branch.sh             | 166 ++++++++++++++++++++++++++++++++++
 3 files changed, 359 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b0d66a6deb..cee3904cfd 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch (--delete-merged <branch>)... [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -201,6 +202,36 @@ This option is only applicable in non-verbose mode.
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
+A branch that another, surviving branch tracks as its upstream is
+kept, so a branch is never deleted out from under one stacked on top
+of it. If that kept branch in turn tracks a branch that is being
+deleted, its now-stale upstream configuration is cleared.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 23b2b7107c..8ce8840fa7 100644
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
 
@@ -699,6 +701,154 @@ static int parse_opt_forked(const struct option *opt, const char *arg, int unset
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
+	struct strset deletable = STRSET_INIT;
+	struct strvec to_delete = STRVEC_INIT;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+	size_t i;
+	int ret = 0;
+
+	for (i = 0; i < upstreams->nr; i++)
+		if (ref_filter_forked_add(&filter, upstreams->v[i]) < 0)
+			die(_("'%s' is not a valid branch or pattern"),
+			    upstreams->v[i]);
+
+	filter.kind = FILTER_REFS_BRANCHES;
+	filter.name_patterns = argv;
+	filter_refs(&candidates, &filter, filter.kind);
+
+	for (i = 0; i < (size_t)candidates.nr; i++) {
+		const char *full_name = candidates.items[i]->refname;
+		const char *short_name;
+		struct branch *branch;
+		const char *upstream;
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
+		if (branch_pushes_to_upstream(branch, upstream))
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
@@ -740,6 +890,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	struct strvec delete_merged = STRVEC_INIT;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -793,6 +944,9 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_CALLBACK_F(0, "delete-merged", &delete_merged, N_("branch"),
+			N_("delete merged branches whose upstream matches <branch> (repeatable)"),
+			PARSE_OPT_NONEG, parse_opt_strvec),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -840,7 +994,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !delete_merged.nr &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -850,7 +1005,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!delete_merged.nr;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -892,6 +1047,10 @@ int cmd_branch(int argc,
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
@@ -1051,6 +1210,7 @@ int cmd_branch(int argc,
 	ret = 0;
 
 out:
+	strvec_clear(&delete_merged);
 	string_list_clear(&sorting_options, 0);
 	return ret;
 }
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 0c5a4ca62b..fa8a60c9e7 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1834,4 +1834,170 @@ test_expect_success '--forked requires a value' '
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
+test_expect_success '--delete-merged clears the deleted upstream of a spared branch' '
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
+			--delete-merged lower &&
+
+		check_branches <<-\EOF &&
+		main
+		mid
+		tip
+		EOF
+
+		git config --local --get-regexp "branch\\.(mid|tip)\\.(merge|remote)" >actual &&
+		cat >expect <<-\EOF &&
+		branch.tip.remote .
+		branch.tip.merge refs/heads/mid
+		EOF
+		test_cmp expect actual
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

