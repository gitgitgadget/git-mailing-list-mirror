Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872C3BED23
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492702; cv=none; b=SfzsV4YMJndhzrsIaa2Eeab7wG5958Fqzk/B2OLelV3BD1hOkeoSmKZfYxB1IrenvHy+iRcPYovtvhFKuW4SVaI9k6iva8Rn5ikaBT2I95WhZlc428vSISHKE9fR6X3RREhKHlrJmrbiFrViKUWxXPPPphIsajlopiKZpd6McuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492702; c=relaxed/simple;
	bh=ex4rT6YS/oKRY6qDawHHgPILuA6YJFp2wpX4/FxMZe4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=taRvmkDIpPOyj6z9amVS69EhWt3r1alB0rKF/cOQrxjm7oyEwjrGn68N53O1hsrXTpgjXF2kKmqprdsfRjKaiZtTCLnMAUC45vkkvq7vf4fedk1TJEsZxjk2oXFUKX5B63kFak8OGoBk1FgF/867s8oEfyDihCegYWDsvBPtDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdbv4INc; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdbv4INc"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7014673eec.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778492699; x=1779097499; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rABxqX1T9acagibUBXcl344o7x0syWLzl80VClDBJmc=;
        b=Rdbv4INc3VkSdeqHZVi566d7lDzft8apg3UBf+gkCxIq/L9JZjCTCcX46ydkPhK12X
         SARbjKdLivz5tIYDCRPK3ruW+GXV6468ZTzNtffyrprzj+tSlUJqjaSNJcX+WdHBQYHD
         uLZsVx+2dACmLzJiRG89UIhAzSMmslvWqFbNnV1L/1K3+FY38DnxBc9+Sn/hVR5hZomX
         37nP0BIqj8/o1lr4VN3fqPyxU4KluMnCMmPBf94y2FV4tYAyvf4yLj7o3aWvtke3k78+
         UoFyPyil20fgS8RLsL3PYIzl+7FuYgd1Vb/xI2/IT9UsXvY05QPR3QXPutwLPIXCZ/AG
         W9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778492699; x=1779097499;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rABxqX1T9acagibUBXcl344o7x0syWLzl80VClDBJmc=;
        b=dmUbPWxzVRmZ4HXM5qtku+VfE6m8vrJ/ETUQzhOMpFGnUe+cUfZyeWekA/8yqw9H5t
         Gql6cAzM6ZvAIiZLbkLG1zixVHdUtndpjgqMx8kymsM0Je4RITukL3jmoq7760zpAjHQ
         uy2zEixDZDbD4Mf8AyQggJUCmjn28VqQ+EzERrobZbqHFMQO11/ydnaas+6Jg9upomkF
         qKxkHdK2E+XOr4nuBYY19Wb57PVxNHBBSu4blSdvh/SX7jKlIYS2DbLNXdvJOTaEGrph
         G7MOCjIpG7nJy4cPlfwrGl3zf9WWPyHvgGkneHu3CEbqZBeJY6UWWIULAN/oL/IY2oem
         gi5Q==
X-Gm-Message-State: AOJu0YwLK8CnGpL+H8d97FQQZjWXOH/iR+bbmbRMyOjMkuXACOsdGH3O
	E5l1RXRsc/ptgh9xq4mbPCCgWrDE07WTglxmUU4gFW9rC2RXC/YciCp5yUww8J9n
X-Gm-Gg: Acq92OEwNUSbGyD8E1FzKbyrUtmYemJi2wAM3BHZDsLqQeGH/8X2/Bo5Hzn/RbDsyNb
	VGRQRYWCv+rqlfz7T0K5IOKnufdhynwCALV5myF1pYF82zZC7u7wEY8UbKJzC4TiYqz0wAA2b9C
	bSzRJDoKBORzsw8BaBO7XUdmDhujwmj8SykWIhu5lldbjTAc2poWnQfKa4Zlr6eTsGMwoKprm27
	cvCQfMV8lB0JAcJKORj33hBxr1KpY+mCBFc+VYrSBUq2uEzpoOh4wpelvNbkmD2lRUEMU6NJFvK
	QMFQO3zZXONY3foz6XW2PjKCDi9jxbJMcGNZGvRZp/u9CL0u61xkXwixwjXHl4OblcfIRp5jMCa
	GWPonx1O8J6XgNDvK4/QA0/OKX49uYw8oQILHIlylh2uO5mcpNN6lmr2dtJK/KE5yWjfwpTMjy4
	dI8Mc5sWZcrBRI+mGbS7U9DrsAv5f5
X-Received: by 2002:a05:7300:8608:b0:2ed:e14:e956 with SMTP id 5a478bee46e88-2f550e4b212mr10540927eec.32.1778492698994;
        Mon, 11 May 2026 02:44:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.217])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e3e285sm15019826eec.27.2026.05.11.02.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:44:58 -0700 (PDT)
Message-Id: <604ecb89650d87a9dbcf78e1c537ce8dc8c8995c.1778492691.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
References: <pull.2285.v5.git.git.1778482708.gitgitgadget@gmail.com>
	<pull.2285.v6.git.git.1778492691.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 09:44:49 +0000
Subject: [PATCH v6 3/5] branch: add --prune-merged <remote>
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
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Delete the local branches that --forked <remote> would list,
refusing any whose tip is not reachable from the remote's default
branch. With --force, delete unconditionally. The currently
checked-out branch in any worktree is always preserved.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  15 +++
 builtin/branch.c              | 193 +++++++++++++++++++++++++++++++---
 t/t3200-branch.sh             | 144 +++++++++++++++++++++++++
 3 files changed, 335 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5773104cd3..a5e869270d 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <remote>...
+git branch [-f] --prune-merged <remote>...
 
 DESCRIPTION
 -----------
@@ -211,6 +212,20 @@ Each _<remote>_ may be either the name of a configured remote
 `refs/remotes/origin/*` ref) or a specific remote-tracking branch
 (e.g. `origin/master`). Multiple _<remote>_ arguments are unioned.
 
+`--prune-merged`::
+	Delete the local branches that `--forked` would list for
+	the same _<remote>_ arguments, but only when the branch's
+	push destination remote-tracking branch (the branch `git push`
+	would update; see `branch_get_push` semantics) no longer
+	resolves locally. In other words: the branch was pushed
+	under some name on _<remote>_, and that name has since
+	been pruned upstream.
++
+As a safety check, branches with commits not yet integrated into
+the remote's default branch are refused. With `--force` (or `-f`),
+delete them regardless. The currently checked-out branch in any
+worktree is always preserved.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1941f8a9ad..d2f07cddd8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -21,6 +21,7 @@
 #include "branch.h"
 #include "path.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "column.h"
 #include "utf8.h"
 #include "ref-filter.h"
@@ -192,15 +193,29 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
+			       struct commit *head_rev_override,
+			       int use_head_rev_override,
 			       int kinds, int force, int warn_only,
 			       int *n_not_merged)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
+	int merged;
+
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
-	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
+	if (use_head_rev_override) {
+		if (!head_rev_override)
+			return 0;
+		merged = repo_in_merge_bases(the_repository, rev,
+					     head_rev_override);
+		if (merged < 0)
+			exit(128);
+	} else {
+		merged = branch_merged(kinds, branchname, rev, head_rev);
+	}
+	if (!force && !merged) {
 		if (warn_only) {
 			warning(_("the branch '%s' is not fully merged"),
 				branchname);
@@ -227,7 +242,9 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
+static int delete_branches(int argc, const char **argv,
+			   struct commit **head_rev_overrides,
+			   int force, int kinds,
 			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
@@ -317,8 +334,10 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		}
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
-		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force, warn_only, n_not_merged)) {
+		    check_branch_commit(bname.buf, name, &oid, head_rev,
+					head_rev_overrides ? head_rev_overrides[i] : NULL,
+					!!head_rev_overrides,
+					kinds, force, warn_only, n_not_merged)) {
 			if (!warn_only)
 				ret = 1;
 			goto next;
@@ -753,36 +772,169 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static void collect_default_branch_refs(const struct string_list *remote_names,
+					struct string_list *out)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, remote_names) {
+		struct strbuf head = STRBUF_INIT;
+		const char *target;
+
+		strbuf_addf(&head, "refs/remotes/%s/HEAD", item->string);
+		target = refs_resolve_ref_unsafe(refs, head.buf,
+						 RESOLVE_REF_NO_RECURSE,
+						 NULL, NULL);
+		if (target && starts_with(target, "refs/remotes/"))
+			string_list_insert(out, target);
+		strbuf_release(&head);
+	}
+}
+
+static void collect_forked_set(int argc, const char **argv,
+			       struct string_list *protected_default_refs,
+			       struct string_list *out)
 {
 	struct string_list remote_names = STRING_LIST_INIT_NODUP;
 	struct string_list tracking_refs = STRING_LIST_INIT_DUP;
-	struct string_list out = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
 	struct forked_cb cb = {
 		.remote_names = &remote_names,
 		.tracking_refs = &tracking_refs,
-		.out = &out,
+		.out = out,
 	};
 
-	if (!argc)
-		die(_("--forked requires at least one <remote>"));
-
 	parse_forked_args(argc, argv, &remote_names, &tracking_refs);
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
 
-	string_list_sort(&out);
-	for_each_string_list_item(item, &out)
-		puts(item->string);
+	string_list_sort(out);
+
+	if (protected_default_refs)
+		collect_default_branch_refs(&remote_names, protected_default_refs);
 
 	string_list_clear(&remote_names, 0);
 	string_list_clear(&tracking_refs, 0);
+}
+
+static int list_forked_branches(int argc, const char **argv)
+{
+	struct string_list out = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	if (!argc)
+		die(_("--forked requires at least one <remote>"));
+
+	collect_forked_set(argc, argv, NULL, &out);
+	for_each_string_list_item(item, &out)
+		puts(item->string);
+
 	string_list_clear(&out, 0);
 	return 0;
 }
 
+static struct commit *resolve_remote_head(const char *remote_name)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct strbuf head_ref = STRBUF_INIT;
+	struct object_id oid;
+	struct commit *commit = NULL;
+
+	strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remote_name);
+	if (refs_resolve_ref_unsafe(refs, head_ref.buf, RESOLVE_REF_READING,
+				    &oid, NULL))
+		commit = lookup_commit_reference(the_repository, &oid);
+	strbuf_release(&head_ref);
+	return commit;
+}
+
+static int prune_merged_branches(int argc, const char **argv, int force,
+				 int quiet)
+{
+	struct string_list candidates = STRING_LIST_INIT_DUP;
+	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
+	struct strvec deletable = STRVEC_INIT;
+	struct commit **head_rev_overrides = NULL;
+	size_t alloc = 0;
+	struct string_list_item *item;
+	int n_not_merged = 0;
+	int ret = 0;
+
+	if (!argc)
+		die(_("--prune-merged requires at least one <remote>"));
+
+	collect_forked_set(argc, argv, &protected_default_refs, &candidates);
+
+	for_each_string_list_item(item, &candidates) {
+		const char *short_name = item->string;
+		struct strbuf full = STRBUF_INIT;
+		struct branch *branch;
+		const char *push_ref;
+		const char *upstream;
+		const char *remote_name;
+		const char *slash;
+
+		strbuf_addf(&full, "refs/heads/%s", short_name);
+		if (branch_checked_out(full.buf)) {
+			strbuf_release(&full);
+			continue;
+		}
+		strbuf_release(&full);
+
+		branch = branch_get(short_name);
+		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
+		if (upstream &&
+		    string_list_has_string(&protected_default_refs, upstream)) {
+			const char *leaf = strrchr(upstream, '/');
+			if (leaf && !strcmp(leaf + 1, short_name))
+				continue;
+		}
+
+		push_ref = branch ? branch_get_push(branch, NULL) : NULL;
+		if (!push_ref)
+			continue;
+		if (refs_ref_exists(get_main_ref_store(the_repository),
+				    push_ref))
+			continue;
+		if (string_list_has_string(&protected_default_refs, push_ref))
+			continue;
+
+		ALLOC_GROW(head_rev_overrides, deletable.nr + 1, alloc);
+		remote_name = push_ref + strlen("refs/remotes/");
+		slash = strchr(remote_name, '/');
+		if (slash) {
+			char *name = xstrndup(remote_name, slash - remote_name);
+			head_rev_overrides[deletable.nr] = resolve_remote_head(name);
+			free(name);
+		} else {
+			head_rev_overrides[deletable.nr] = NULL;
+		}
+		strvec_push(&deletable, short_name);
+	}
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v,
+				      head_rev_overrides, force,
+				      FILTER_REFS_BRANCHES, quiet,
+				      1, &n_not_merged);
+
+	if (n_not_merged && !quiet)
+		fprintf(stderr,
+			Q_("Skipped %d branch that is not fully merged; "
+			   "re-run with --force to delete it anyway.\n",
+			   "Skipped %d branches that are not fully merged; "
+			   "re-run with --force to delete them anyway.\n",
+			   n_not_merged),
+			n_not_merged);
+
+	strvec_clear(&deletable);
+	free(head_rev_overrides);
+	string_list_clear(&candidates, 0);
+	string_list_clear(&protected_default_refs, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -825,6 +977,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +1033,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches forked from the given <remote>s")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -924,7 +1079,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -933,7 +1089,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -971,12 +1127,15 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+		ret = delete_branches(argc, argv, NULL, delete > 1, filter.kind,
 				      quiet, 0, NULL);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
 		goto out;
+	} else if (prune_merged) {
+		ret = prune_merged_branches(argc, argv, force, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 24a3ec44ee..ca3d06a1ec 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,4 +1771,148 @@ test_expect_success '--forked requires at least one <remote>' '
 	test_grep "at least one <remote>" err
 '
 
+test_expect_success '--prune-merged: setup' '
+	test_create_repo pm-upstream &&
+	test_commit -C pm-upstream base &&
+	git -C pm-upstream branch one base &&
+	git -C pm-upstream branch two base
+'
+
+test_expect_success '--prune-merged deletes branches whose push ref is gone' '
+	test_when_finished "rm -rf pm-clean" &&
+	git clone pm-upstream pm-clean &&
+	git -C pm-clean branch one --track origin/one &&
+	git -C pm-clean branch two --track origin/two &&
+
+	git -C pm-clean update-ref -d refs/remotes/origin/one &&
+	git -C pm-clean branch --prune-merged origin &&
+
+	test_must_fail git -C pm-clean rev-parse --verify refs/heads/one &&
+	git -C pm-clean rev-parse --verify refs/heads/two
+'
+
+test_expect_success '--prune-merged spares in-flight branches whose push ref still exists' '
+	test_when_finished "rm -rf pm-inflight" &&
+	git clone pm-upstream pm-inflight &&
+	git -C pm-inflight branch one --track origin/one &&
+
+	git -C pm-inflight branch --prune-merged origin &&
+
+	git -C pm-inflight rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged skips branches with unpushed commits' '
+	test_when_finished "rm -rf pm-unmerged" &&
+	git clone pm-upstream pm-unmerged &&
+	git -C pm-unmerged checkout -b one --track origin/one &&
+	test_commit -C pm-unmerged unpushed &&
+	git -C pm-unmerged checkout - &&
+
+	git -C pm-unmerged update-ref -d refs/remotes/origin/one &&
+	git -C pm-unmerged branch --prune-merged origin 2>err &&
+	test_grep "not fully merged" err &&
+	test_grep "Skipped 1 branch" err &&
+	test_grep "re-run with --force" err &&
+	test_grep ! "If you are sure you want to delete it" err &&
+	git -C pm-unmerged rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged --force deletes branches with unpushed commits' '
+	test_when_finished "rm -rf pm-force" &&
+	git clone pm-upstream pm-force &&
+	git -C pm-force checkout -b one --track origin/one &&
+	test_commit -C pm-force unpushed &&
+	git -C pm-force checkout - &&
+
+	git -C pm-force update-ref -d refs/remotes/origin/one &&
+	git -C pm-force branch --force --prune-merged origin &&
+
+	test_must_fail git -C pm-force rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged measures merged-ness against <remote>/HEAD, not local HEAD' '
+	test_when_finished "rm -rf pm-head-indep" &&
+	git clone pm-upstream pm-head-indep &&
+	git -C pm-head-indep branch one --track origin/one &&
+	git -C pm-head-indep update-ref -d refs/remotes/origin/one &&
+	# Detach HEAD to an unrelated commit so the candidate is not
+	# reachable from local HEAD; it is still reachable from
+	# refs/remotes/origin/HEAD, which is what should matter.
+	git -C pm-head-indep commit --allow-empty -m unrelated &&
+	git -C pm-head-indep checkout --detach &&
+	git -C pm-head-indep reset --hard HEAD^ &&
+
+	git -C pm-head-indep branch --prune-merged origin &&
+
+	test_must_fail git -C pm-head-indep rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged skips merged-ness check when <remote>/HEAD is unset' '
+	test_when_finished "rm -rf pm-no-head" &&
+	git clone pm-upstream pm-no-head &&
+	git -C pm-no-head checkout -b one --track origin/one &&
+	test_commit -C pm-no-head unpushed &&
+	git -C pm-no-head checkout - &&
+
+	git -C pm-no-head update-ref -d refs/remotes/origin/HEAD &&
+	git -C pm-no-head update-ref -d refs/remotes/origin/one &&
+	git -C pm-no-head branch --prune-merged origin &&
+
+	test_must_fail git -C pm-no-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged never deletes the checked-out branch' '
+	test_when_finished "rm -rf pm-head" &&
+	git clone pm-upstream pm-head &&
+	git -C pm-head checkout -b one --track origin/one &&
+
+	git -C pm-head update-ref -d refs/remotes/origin/one &&
+	git -C pm-head branch --force --prune-merged origin &&
+
+	git -C pm-head rev-parse --verify refs/heads/one
+'
+
+test_expect_success '--prune-merged deletes when push ref differs from upstream' '
+	test_when_finished "rm -rf pm-pushdiff" &&
+	git clone pm-upstream pm-pushdiff &&
+	git -C pm-pushdiff config push.default current &&
+	git -C pm-pushdiff branch --track topic-a origin/one &&
+
+	git -C pm-pushdiff branch --force --prune-merged origin &&
+
+	test_must_fail git -C pm-pushdiff rev-parse --verify refs/heads/topic-a
+'
+
+test_expect_success '--prune-merged spares the local default branch' '
+	test_when_finished "rm -rf pm-default" &&
+	git clone pm-upstream pm-default &&
+	git -C pm-default config push.default current &&
+	git -C pm-default checkout --detach &&
+	git -C pm-default branch --prune-merged origin &&
+	git -C pm-default rev-parse --verify refs/heads/main
+'
+
+test_expect_success '--prune-merged protects only the default branch by name, not by upstream' '
+	test_when_finished "rm -rf pm-default-alias" &&
+	git clone pm-upstream pm-default-alias &&
+	git -C pm-default-alias config push.default current &&
+	git -C pm-default-alias branch --track trunk origin/main &&
+	git -C pm-default-alias checkout --detach &&
+	git -C pm-default-alias branch --force --prune-merged origin &&
+	git -C pm-default-alias rev-parse --verify refs/heads/main &&
+	test_must_fail git -C pm-default-alias rev-parse --verify refs/heads/trunk
+'
+
+test_expect_success '--prune-merged spares branches whose push ref is the default branch' '
+	test_when_finished "rm -rf pm-pushdefault" &&
+	git clone pm-upstream pm-pushdefault &&
+	git -C pm-pushdefault branch --track topic origin/one &&
+	git -C pm-pushdefault config --add remote.origin.push refs/heads/topic:refs/heads/main &&
+	git -C pm-pushdefault update-ref -d refs/remotes/origin/one &&
+	git -C pm-pushdefault update-ref -d refs/remotes/origin/main &&
+	git -C pm-pushdefault checkout --detach &&
+	git -C pm-pushdefault branch --prune-merged origin &&
+	git -C pm-pushdefault rev-parse --verify refs/heads/topic
+'
+
 test_done
-- 
gitgitgadget

