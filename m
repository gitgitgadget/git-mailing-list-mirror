Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8693D4122
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009048; cv=none; b=sfluHikNAEsc0RoZcmeXfqqb2dLT1lgDvGuC9p2lfWMT6qEs/kjGirneAX7H1iy5qcrykwL/aHRE5GLDRstfoacinJ4iCgUoMpdN0dzbfPQJEUlPxc/DlIm+/iPmzchB5TrEyxz7eFHfJOK9K7NXOWEKNSdTvYotF/2xwSs94lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009048; c=relaxed/simple;
	bh=oq69QBfug3KTiHZHpqBiLohdApALWidM/0zm32tF1fc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=toK6rt7An+N9G/CuhWjd9Kr5vgQWZRLvxTgNjdBqKjRxbKdw0yvlYG60LNFsmwJCu+IJp8M6KnjVa7m8hlCoEoSn2YEqwmnc7H75L0h2/HPauDE6EooJOtPuxcRL3vShuH06hn/xillxemQQuB0yE6LEG+ws0FqHCvmG6PzJ41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfzXQXn0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfzXQXn0"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-479ef2b7979so4112646b6e.3
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009045; x=1778613845; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6aG0xbBf+ub+SFv3f+d9XaMNNyYb7SvA/9LYoL9+1Y=;
        b=KfzXQXn0om1us3gCi+MlruJav8dGXUC6kMQMvF/MyMfw6gQyqaCPeXOtlH9BSoLRuC
         ry0+y54XOdOO2JU9Xoro1vWYqlb6blYvzvBSMmJ/OeZ4GKOdFMUvSFB7rigRXdWfHpje
         LRjBACYPqP5L3WTYXVtEDAnVqExMqWTlwODcchWQ4IyuTbvmJh8r6hkU2OKDaiF1Z/0f
         2OlBj5spbCAn3wcCDfvEfrkdbx1sv+69kZD5H4ssQcbrdbBhUijVq/8U/ktlvtgd25RD
         5kDfXokBldOeCME89C2z8oW5OTV+bFLXpOc85yDRCz5ZORJlUcDkfZiq09RPebUTx1IJ
         5bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009045; x=1778613845;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t6aG0xbBf+ub+SFv3f+d9XaMNNyYb7SvA/9LYoL9+1Y=;
        b=KnbQ682DZg/gFhuVZl6DeDr02/bmLsTZZKKaCyv3EfNwQkH6FOWtzEbIs9v5PtIwRE
         mSb/Td5LM12jaJpPaI0J1ANYwGTlDHIbDwdxcfQNqrrWKzCPo8H6LL+yAmCJ0dQr/fhE
         Zdy6t5704Bc/A9IEk/bBLB/9NrNI9BE2y3WmHLXL46hvOOVSkIa0DxRqecEPKXj12irT
         S9G7EfBhH+1GD6YZ4Y5RVIRGUx/mTytxB43o5dqodwq/NvQrG/99l2dak3CKrlrkBTkN
         HDbH4rJ7siFo9wuJ7Rgy/kydwVN2i7OmRnI5lEUkxOwDccJV9nQD/2oepYso2N141Hdz
         vhKw==
X-Gm-Message-State: AOJu0YxXEXY1WZ9iaNwb/3Dd7xk8m05V9kCABpWrOR7K6R+F9NFmOrWz
	Sx+Kq5kNBYtZfryvimGOY/3i30my/hXmiH/E8dxCGw27Qq0HjiYHYPsu45e2fg==
X-Gm-Gg: AeBDieshOUvE+6F22AYm+3mNjYkYLhpu5JaRxLhhDK7MHjWIqShrtHCTLyebzDTNm8M
	gIYSpxg/ZUKroZjug/1+vielj1SenrgN3YiwLA3MBVMwXH/1JfU50p7MODrK0Bk/dBV1q0TND14
	nT6KVWDB39v20vdhnOheWlvFfG7Z+AbbohA8vkARjzksnskO1et+C9VjiFbrDkZviFQepisOFol
	rFArOsGye8m3FNC3cigke7M+vicOh2akZqQs5m3qSQmnZKL5vtUnKlNCM3GL3xsKIjqPVDGuCXm
	2DlZARa4zkW4YEZsyJYQsS2sRFBznnT9GBsBImH05v9f4T3sxJ8b12krooypVrTGjyVEP2ojGa+
	53bvjTURYi+xogMVNsakMVMkvaOjGuXxqSRmcVTd0LT8sUKJeShS9b4P8I/zbEEvhqpK0pVubT4
	wH8j/atOoaJQhd4PDxpdsMOM0wIofYhslDqV4b
X-Received: by 2002:a05:6808:3084:b0:47c:be49:cf5f with SMTP id 5614622812f47-480422d905bmr289919b6e.30.1778009045135;
        Tue, 05 May 2026 12:24:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.108.21])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca826dbesm10630036a34.12.2026.05.05.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:24:03 -0700 (PDT)
Message-Id: <77beb620d7c5009f1b7511037eee30b8cc3cbe4a.1778009038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
References: <pull.2285.v3.git.git.1777965747.gitgitgadget@gmail.com>
	<pull.2285.v4.git.git.1778009038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 19:23:55 +0000
Subject: [PATCH v4 3/6] branch: add --prune-merged <remote>
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
refusing any whose tip is not reachable from its upstream
remote-tracking branch. With --force, delete unconditionally.
The currently checked-out branch in any worktree is always
preserved.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  16 ++++
 builtin/branch.c              | 134 +++++++++++++++++++++++++++++++---
 t/t3200-branch.sh             | 113 ++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 5773104cd3..80b20a55eb 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <remote>...
+git branch [-f] --prune-merged <remote>...
 
 DESCRIPTION
 -----------
@@ -211,6 +212,21 @@ Each _<remote>_ may be either the name of a configured remote
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
+By default, the local tip must also be reachable from the
+upstream remote-tracking branch (see `--no-merged`); branches with
+unpushed commits are refused. With `--force` (or `-f`), delete
+them regardless. The currently checked-out branch in any worktree
+is always preserved.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1941f8a9ad..f2ca7b64d3 100644
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
@@ -753,36 +754,138 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
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
 
+static int prune_merged_branches(int argc, const char **argv, int force,
+				 int quiet)
+{
+	struct string_list candidates = STRING_LIST_INIT_DUP;
+	struct string_list protected_default_refs = STRING_LIST_INIT_DUP;
+	struct strvec deletable = STRVEC_INIT;
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
+		strvec_push(&deletable, short_name);
+	}
+
+	if (deletable.nr)
+		ret = delete_branches(deletable.nr, deletable.v, force,
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
+	string_list_clear(&candidates, 0);
+	string_list_clear(&protected_default_refs, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -825,6 +928,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -880,6 +984,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches forked from the given <remote>s")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches forked from the given <remote>s that are merged into their upstream")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -924,7 +1030,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -933,7 +1040,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -977,6 +1084,9 @@ int cmd_branch(int argc,
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
index 24a3ec44ee..b41f8343b3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1771,4 +1771,117 @@ test_expect_success '--forked requires at least one <remote>' '
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

