Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2A3E5A3F
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449519; cv=none; b=CNfZ616S8ndSnFPK06oky1H/3HnyLQ0txsY3osMNkn3QjXw7QJX2gl4qHNp6msWLtGxPDyQvpFkGfLT0otJf2ixJt6m97tQh1VBAk5GdeO5nBE5AbIZygk3i1wAp3rY03rno84ob7zYAzQmzsZtDyme/RGY5f9vvsHhu3lKsM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449519; c=relaxed/simple;
	bh=1UIVVQoJLAdY/BYFwKPrhHNkAEMj5wOSr+v4lvXl3gc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QI14gSLf8U4sj7FgPoC5eXXumbnGf6norRZgo73B2IjaUn8MkTbDDuw7EJRrE0xiife/Gt8s8TwALwyOwUjbliSWF6S7EOURFcRKmHAA107pRArwCzGz/sEOr6e3Z/8jqK1+UXUc70HxcJjxFhNh9pYs5O8GKKFvAijmc1x83/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdczTMNK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdczTMNK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-911449d9d03so841331385a.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449506; x=1780054306; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzrGy4c/CUc7vAPKGIV3TGfDAYEHTHhXEdfCDsYadO8=;
        b=bdczTMNKl3BP+alxoMJpiLh4vsfrAaoflh900Qpx79sQe+OQFDrf1Gv8ZqESo0y9AL
         fablXEv5w8ghfCDRGK2cZtClUhaUwJWjLUSU3InQPN1eOqbK4ALoA695L5fiMmtYA1bv
         sKxF2lmpNJf70Wh+M9eeAj876t9JLJpsT6jcy6c+1glkwOmpyWhaqfMqZ1wZ3eAwdNJG
         FP75mwwdL3kqWFu9uVBV0/2vcuv2vdHkubgjknlWw8ku5vfi7To3gMNAICcAfueCz2dC
         p2Vd/y+ADaWLFzSHBXX4SNWGoENN2m/yyxkKb7LwyMQ3BPc/IiEiVaUrydIzssEwSnjs
         hu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449506; x=1780054306;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzrGy4c/CUc7vAPKGIV3TGfDAYEHTHhXEdfCDsYadO8=;
        b=ZEJ05pWB2RBaiO7apCnV3e/vyBmXk8ac8PHuW7Yt4LBiO5tL/5LWqWTr4bjdiV9o+a
         6biBEIxNRrWYE4hiUV0AmQIhiv7TJUgZxxY1z2yYdg57e0FiVwHhiwX5aYg7iUPn3BXn
         84C9hZ6+j1Nl767yM9D2fUk850W6fOOjSJjCLaDogcCLdGWdlFylmVRje0IS1bSi4sJz
         bZPZidSDFaRm8MaGSBSBe3dqyYPJXQTOzWNFYDwIqHbaRnFtzubLxcn/XnX64F8KGLoL
         JywvqPe5Q87BmGXLCY1dLN59lEp3uJs3sY4Q6MxsH+yrRgNuW3yMjhuqu5rqCbHYCnli
         OrCg==
X-Gm-Message-State: AOJu0YzMjS5EwvWf55aP1xWJE+Q57skHffvUvDeylGK5WDqylq70flEd
	o62TUnXwwC84CDy8ZZ0sIJCpJNmtF0Koav6ZpUhl1vJFh9opGAU187qvrvo/Co3v
X-Gm-Gg: Acq92OE/lY7KlLze9c2Daq00W4x8cqkrJidU6cRb8iC2ja74w3sXjnfecjzYIddHS2A
	JEXEhzXT0WNxC4mOq8PTQZysZZJPZUdiMflbg8rl8MlQ573Df8x7pC2Ix/1HEa1SwoiqHvgEtOo
	8YprUo6w3WobsaRjwxnGimMTrFSI3UWuhydsJSgo7CYHoPj5JQR13qzvuDZ6cYS4R/MYs8fMczW
	aSQZm9bw5aIDDfhPqaqoqw8BNs1URb4fE8wOeFFES5l8Pa0qffpUNKtCPWlLrYL9RU0WyReDSkG
	cpvQUtR6YOu0WUlxHpSZXXSPLidYsZ5U74GwwSePWfkyR9TXIYvT3r7ltBq5pmOc0cUdXpuCswv
	rFZWhZNztmJNVi2rZA4dXuHov2b/bFEAk5Wn/uUBy4rCTMp2vs8UDhT5kPT8qaw/uMZNPFg9R82
	NGP+OPaXMLsS7qhLUIiowV5eplANxjJ+EfFXh/
X-Received: by 2002:a05:620a:2589:b0:90f:4900:756 with SMTP id af79cd13be357-914b491f148mr507689385a.24.1779449506088;
        Fri, 22 May 2026 04:31:46 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bba0b6c8sm91107185a.41.2026.05.22.04.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:31:45 -0700 (PDT)
Message-Id: <e7e03c13385d2a27a3c332a78c204dc48ad65f69.1779449498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 11:31:36 +0000
Subject: [PATCH v11 4/6] branch: add --prune-merged <branch>
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
restricted to those whose tip is reachable from their configured
upstream: the work has already landed on the upstream they track,
so the local copy is no longer needed.

Reachability is read from the local refs only -- nothing is
fetched. Users who want fresh upstream refs run "git fetch" first;
the deletion path stays a separate, idempotent step that also
works offline.

Three classes of branches are spared:

  * any branch checked out in any worktree;
  * any branch whose upstream no longer resolves locally (its
    disappearance is not, on its own, evidence of integration);
  * any branch whose push destination equals its upstream
    (<branch>@{push} == <branch>@{upstream}). Such a branch
    cannot be distinguished from a freshly pulled trunk that
    just looks "fully merged" -- e.g. local "main" tracking and
    pushing to "origin/main" right after a pull. Only branches
    that push somewhere other than their upstream (typically
    topics in a fork-based workflow) are treated as candidates.

Deletion goes through the existing delete_branches() in warn-only
mode and with the HEAD-fallback disabled: a branch that is not
yet fully merged to its upstream is reported as a one-line warning
and skipped, so a single un-mergeable topic does not abort the
whole sweep, and there is no fallback to "merged into the
currently checked out branch" -- we only act on upstream-merged
status.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  22 ++++
 builtin/branch.c              |  87 ++++++++++++++--
 t/t3200-branch.sh             | 183 ++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index a37d3a12cb..c521b5f4ca 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -25,6 +25,7 @@ git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
 git branch --forked <branch>...
+git branch --prune-merged <branch>...
 
 DESCRIPTION
 -----------
@@ -212,6 +213,27 @@ wildmatch pattern like `'origin/*'`.  A bare configured-remote name
 to match the way `git checkout -b topic origin` picks a starting
 point.  Multiple _<branch>_ arguments are unioned.
 
+`--prune-merged`::
+	Delete the local branches that `--forked` would list for the
+	same _<branch>_ arguments, but only those whose tip is
+	reachable from their configured upstream.  In other words,
+	the work on the branch has already landed on the upstream it
+	tracks, so the local copy is no longer needed.
++
+Reachability is checked against whatever the upstream refs say
+locally; nothing is fetched.  Run `git fetch` first if you want
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
index 08c1237624..1569f29573 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -821,34 +821,92 @@ static int collect_forked_branch(const struct reference *ref, void *cb_data)
 	return 0;
 }
 
-static int list_forked_branches(int argc, const char **argv)
+static void collect_forked_set(int argc, const char **argv,
+			       struct string_list *out)
 {
 	struct upstream_pattern *patterns = NULL;
 	size_t nr_patterns = 0;
-	struct string_list out = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
 	struct forked_cb cb;
 
-	if (!argc)
-		die(_("--forked requires at least one <branch>"));
-
 	parse_forked_args(argc, argv, &patterns, &nr_patterns);
 	cb.patterns = patterns;
 	cb.nr_patterns = nr_patterns;
-	cb.out = &out;
+	cb.out = out;
 
 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
 				 collect_forked_branch, &cb);
 
-	string_list_sort(&out);
+	string_list_sort(out);
+
+	upstream_pattern_list_clear(patterns, nr_patterns);
+}
+
+static int list_forked_branches(int argc, const char **argv)
+{
+	struct string_list out = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+
+	if (!argc)
+		die(_("--forked requires at least one <branch>"));
+
+	collect_forked_set(argc, argv, &out);
 	for_each_string_list_item(item, &out)
 		puts(item->string);
 
-	upstream_pattern_list_clear(patterns, nr_patterns);
 	string_list_clear(&out, 0);
 	return 0;
 }
 
+static int prune_merged_branches(int argc, const char **argv, int quiet)
+{
+	struct ref_store *refs = get_main_ref_store(the_repository);
+	struct string_list candidates = STRING_LIST_INIT_DUP;
+	struct strvec deletable = STRVEC_INIT;
+	struct string_list_item *item;
+	int ret = 0;
+
+	if (!argc)
+		die(_("--prune-merged requires at least one <branch>"));
+
+	collect_forked_set(argc, argv, &candidates);
+
+	for_each_string_list_item(item, &candidates) {
+		const char *short_name = item->string;
+		struct branch *branch = branch_get(short_name);
+		const char *upstream, *push;
+		struct strbuf full = STRBUF_INIT;
+		int skip;
+
+		strbuf_addf(&full, "refs/heads/%s", short_name);
+		skip = !!branch_checked_out(full.buf);
+		strbuf_release(&full);
+		if (skip)
+			continue;
+
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
+				      0, /* force */
+				      FILTER_REFS_BRANCHES,
+				      quiet,
+				      1, /* warn_only */
+				      1, /* no_head_fallback */
+				      0  /* dry_run */);
+
+	strvec_clear(&deletable);
+	string_list_clear(&candidates, 0);
+	return ret;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -891,6 +949,7 @@ int cmd_branch(int argc,
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
 	int forked = 0;
+	int prune_merged = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -946,6 +1005,8 @@ int cmd_branch(int argc,
 			 N_("edit the description for the branch")),
 		OPT_BOOL(0, "forked", &forked,
 			N_("list local branches whose upstream matches the given <branch>...")),
+		OPT_BOOL(0, "prune-merged", &prune_merged,
+			N_("delete local branches whose upstream matches the given <branch>... and is merged")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -990,7 +1051,8 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && !forked && argc == 0)
+	    !show_current && !unset_upstream && !forked && !prune_merged &&
+	    argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -999,7 +1061,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream + !!forked;
+			    !!unset_upstream + !!forked + !!prune_merged;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -1043,6 +1105,9 @@ int cmd_branch(int argc,
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
 		goto out;
+	} else if (prune_merged) {
+		ret = prune_merged_branches(argc, argv, quiet);
+		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
 		ret = 0;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 013ddfb65d..ad87946081 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1807,4 +1807,187 @@ test_expect_success '--forked requires at least one <branch>' '
 	test_grep "at least one <branch>" err
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
+	test_grep "at least one <branch>" err
+'
+
 test_done
-- 
gitgitgadget

