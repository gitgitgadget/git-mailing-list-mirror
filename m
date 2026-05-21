Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE81DDC2B
	for <git@vger.kernel.org>; Thu, 21 May 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403211; cv=none; b=H8xxBq0eSjv3M6nCQClfCZS84+iG8H586aSVNN3rvA74UfwkWBNlO0HJr/4dGmXN1mJCj9Sr1bR/IRxgqP78oxo/Mi1vn4pNB5vjQwgGCZydCuOLIIm2/sO1W6JFmQdcmhOWFE8DJbylDM2KeYzuaj3z3b4RJd9nAGKaPwuhEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403211; c=relaxed/simple;
	bh=0cZ6Kh1yqXppziw+iB0pKbnNCrMTNpnifBdgRuVuJyA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fKWbKtkgN+K12ANh9pITMccGKnKs8c5keotrC9pSXj7VT7oW9XOomBiEDaucFF6UZx9sNQlnFwH3OKnhSoOCk8nxt+7BK5KhVWF40bW/1q/l7cop7aBxUiLdegUdJtpepTOpmhjLI5ScvBOKdLeUxDejTl1jzYPJRKpH1qwVQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCuf29YR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCuf29YR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso8215842eec.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779403208; x=1780008008; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LB024uRB0zIsS0f0VYr/ALi0l6+d+sZrEg+upVPzVjU=;
        b=jCuf29YRgOBbfmlnkEoxNPCQxfheNLBVNkVaWZyvZicNX5OpAPMdwkeYY6/BPafaqq
         YJmla1DiEUQM8zJxSIhngyKfgpuzcYu7gg3uznJHBnf+CI/Ijta2yvxAnm/aVm67bMV0
         AfOd9jwlh6TRZYnsAaW3sdQrtuE+/YH8joQvpxPV+xEs1BOzJDS6x9bO9lMTcRz8k5lH
         5uhm351QaWJ0pvwsvE7ceXvOWTt59U6fLnONdYr9c/ZEBiYv9E4GtSfuATQTrvgeACUM
         PtUa8HvQHeZUVMS+Qc35WAyQu+XlQpAtIem5oxgD9dzrXaPW/4JkCYmdvLEyE7OahlgC
         YHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779403208; x=1780008008;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LB024uRB0zIsS0f0VYr/ALi0l6+d+sZrEg+upVPzVjU=;
        b=lUsnqOLggEHnjJLinTgXFMRPygyXOCqrgC3jv05XSTF9X7xzvK5JrfER8an0nELj8e
         ONsUEJyS4bRownm/ShHnLFpMvm77Gye5Y4cwy8vj9feFDZK5vZAUAMDKU5mAZyJtO5o7
         riMxUndSF8C7xHDZ0AJ1F7gQw5Q9PWgfSTTHGFPXwpZHVie6xDcIfIuIb8rt6CGuduKY
         mYUG333CS9ZZ7rErdLOAU+an7KAB45UsomB/wEX2KV7tYdkdArG4F19G/T9CJvtYjVx+
         f+JX3/Z4Kf1P1W1OaUJLnX7S7iVOybwRp/7dr4aqtcHkf0+LA1gJqX4sATvP52SvJv8J
         3Adg==
X-Gm-Message-State: AOJu0YzI1gnKJcZEbtxuAW7IIxF518rbKQexoBIoozKnP+FYlIC7t94y
	7dmbvEHNJMrF1zO2ESEl5nzYMC4w0ZVD/ysWhjw6wlBzrbA9hPbLP1KGw+rQ8A==
X-Gm-Gg: Acq92OECqTvRYjrZG2DyvWMmkhnkpeIVJ65Rye6BONRkPNti5Zvaljtr6bhXfoyZFd+
	to5dCJGjfy8DzVeTu8SNu+u7peXmOGf7FrIqy6D+SZndlh+q25OHxpeR8XlcUYmW01j6ra0KEQk
	/45G/NnjrS0nccAwd1FY7Fq4d+/aEhC+DDG12E7wNAHG6KNCg64/n5AljGte7f6UR1U11sPsaso
	KKx0HEXp/5jmplpuj1UIySSHf+oYXhAev1hY+l8fc18rYIsct9XID+UlZY4+CFmr1FUHTGP2BxJ
	Hx5nQZVVqZlm9zOCRdh7V5QGptvwcxwJcWvXS6LlvDVTmVudFeGQPHmaGfAplOXhCnYOrpiv7As
	5CsU3e1BGGqjPpXc3GM1AQEAkNTIwTmgn6Pu/OZS9EE03cX9FZUh7F29hyvrIbDJertuw9tXEIP
	Wp4F6hFsMh5RPiET0IdoEh8TU9Ug==
X-Received: by 2002:a05:7300:6919:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-30449035bf9mr763090eec.5.1779403208345;
        Thu, 21 May 2026 15:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.62.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3044b912005sm341324eec.15.2026.05.21.15.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 15:40:07 -0700 (PDT)
Message-Id: <f2df15983067ce39b6c33ab81115863d5c3567f4.1779403204.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
References: <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
	<pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 22:40:01 +0000
Subject: [PATCH v10 1/4] branch: add --forked <branch>
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

	git branch --forked <branch>...

lists local branches whose configured upstream matches any
of the given <branch> arguments.

Each <branch> is resolved to the same kind of ref that
branch.<name>.remote and branch.<name>.merge together point at:
a remote-tracking branch (e.g. origin/master), or, for branches
tracking a local upstream, a local branch (e.g. master).
Shell-style globs are also accepted (e.g. 'origin/*'). Multiple
arguments are unioned.

This is the building block for --prune-merged.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |   7 ++
 builtin/branch.c              | 137 +++++++++++++++++++++++++++++++---
 t/t3200-branch.sh             |  81 ++++++++++++++++++++
 3 files changed, 214 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index c0afddc424..3a421f6663 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -24,6 +24,7 @@ git branch (-m|-M) [<old-branch>] <new-branch>
 git branch (-c|-C) [<old-branch>] <new-branch>
 git branch (-d|-D) [-r] <branch-name>...
 git branch --edit-description [<branch-name>]
+git branch --forked <branch>...
 
 DESCRIPTION
 -----------
@@ -199,6 +200,12 @@ This option is only applicable in non-verbose mode.
 	Print the name of the current branch. In detached `HEAD` state,
 	nothing is printed.
 
+`--forked`::
+	List local branches whose configured upstream matches any
+	of the given _<branch>_ arguments. Each argument is either
+	a ref (e.g. `origin/master`, `master`) or a shell-style
+	glob (e.g. `'origin/*'`). Multiple arguments are unioned.
+
 `-v`::
 `-vv`::
 `--verbose`::
diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..1e24c95a69 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,6 +28,7 @@
 #include "help.h"
 #include "advice.h"
 #include "commit-reach.h"
+#include "wildmatch.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
@@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
+	N_("git branch [<options>] --forked <branch>..."),
 	NULL
 };
 
@@ -191,7 +193,8 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int warn_only,
+			       int *n_not_merged)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
@@ -199,10 +202,18 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (warn_only) {
+			warning(_("the branch '%s' is not fully merged"),
+				branchname);
+		} else {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
+		if (n_not_merged)
+			(*n_not_merged)++;
 		return -1;
 	}
 	return 0;
@@ -218,7 +229,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+			   int quiet, int warn_only, int *n_not_merged)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -308,8 +319,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					force, warn_only, n_not_merged)) {
+			if (!warn_only)
+				ret = 1;
 			goto next;
 		}
 
@@ -673,6 +685,102 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	free_worktrees(worktrees);
 }
 
+static void parse_forked_args(int argc, const char **argv,
+			      struct string_list *upstream_patterns)
+{
+	int i;
+
+	for (i = 0; i < argc; i++) {
+		const char *arg = argv[i];
+		struct object_id oid;
+		char *full_ref = NULL;
+		const char *short_ref;
+
+		if (has_glob_specials(arg)) {
+			string_list_insert(upstream_patterns, arg);
+			continue;
+		}
+
+		if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
+				  &full_ref, 0) == 1 &&
+		    (skip_prefix(full_ref, "refs/heads/", &short_ref) ||
+		     skip_prefix(full_ref, "refs/remotes/", &short_ref))) {
+			string_list_insert(upstream_patterns, short_ref);
+			free(full_ref);
+			continue;
+		}
+		free(full_ref);
+
+		die(_("'%s' is not a valid branch or pattern"), arg);
+	}
+}
+
+struct forked_cb {
+	const struct string_list *upstream_patterns;
+	struct string_list *out;
+};
+
+static int collect_forked_branch(const struct reference *ref, void *cb_data)
+{
+	struct forked_cb *cb = cb_data;
+	struct branch *branch;
+	const char *upstream, *short_upstream;
+	const struct string_list_item *item;
+
+	if (ref->flags & REF_ISSYMREF)
+		return 0;
+	branch = branch_get(ref->name);
+	if (!branch)
+		return 0;
+	upstream = branch_get_upstream(branch, NULL);
+	if (!upstream)
+		return 0;
+	short_upstream = upstream;
+	(void)(skip_prefix(short_upstream, "refs/heads/", &short_upstream) ||
+	       skip_prefix(short_upstream, "refs/remotes/", &short_upstream));
+
+	for_each_string_list_item(item, cb->upstream_patterns)
+		if (!wildmatch(item->string, short_upstream, WM_PATHNAME)) {
+			string_list_append(cb->out, ref->name)->util =
+				xstrdup(upstream);
+			return 0;
+		}
+	return 0;
+}
+
+static void collect_forked_set(int argc, const char **argv,
+			       struct string_list *out)
+{
+	struct string_list upstream_patterns = STRING_LIST_INIT_DUP;
+	struct forked_cb cb = {
+		.upstream_patterns = &upstream_patterns,
+		.out = out,
+	};
+
+	parse_forked_args(argc, argv, &upstream_patterns);
+
+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
+				 collect_forked_branch, &cb);
+
+	string_list_clear(&upstream_patterns, 0);
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
+	for_each_string_list_item(item, &out)
+		puts(item->string);
+
+	string_list_clear(&out, 1);
+	return 0;
+}
+
 static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
 
 static int edit_branch_description(const char *branch_name)
@@ -714,6 +822,7 @@ int cmd_branch(int argc,
 	/* possible actions */
 	int delete = 0, rename = 0, copy = 0, list = 0,
 	    unset_upstream = 0, show_current = 0, edit_description = 0;
+	int forked = 0;
 	const char *new_upstream = NULL;
 	int noncreate_actions = 0;
 	/* possible options */
@@ -767,6 +876,8 @@ int cmd_branch(int argc,
 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "forked", &forked,
+			N_("list local branches whose upstream matches the given <branch>...")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -811,7 +922,7 @@ int cmd_branch(int argc,
 			     0);
 
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
-	    !show_current && !unset_upstream && argc == 0)
+	    !show_current && !unset_upstream && !forked && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.no_commit ||
@@ -820,7 +931,7 @@ int cmd_branch(int argc,
 
 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
 			    !!show_current + !!list + !!edit_description +
-			    !!unset_upstream;
+			    !!unset_upstream + !!forked;
 	if (noncreate_actions > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -858,7 +969,11 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+				      quiet, 0, NULL);
+		goto out;
+	} else if (forked) {
+		ret = list_forked_branches(argc, argv);
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..45455cb8ce 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1717,4 +1717,85 @@ test_expect_success 'errors if given a bad branch name' '
 	test_cmp expect actual
 '
 
+test_expect_success '--forked: setup' '
+	test_create_repo forked-upstream &&
+	test_commit -C forked-upstream base &&
+	git -C forked-upstream branch one base &&
+	git -C forked-upstream branch two base &&
+
+	test_create_repo forked-other &&
+	test_commit -C forked-other other-base &&
+	git -C forked-other branch foreign other-base &&
+
+	git clone forked-upstream forked &&
+	git -C forked remote add other ../forked-other &&
+	git -C forked fetch other &&
+	git -C forked branch --track local-one origin/one &&
+	git -C forked branch --track local-two origin/two &&
+	git -C forked branch --track local-foreign other/foreign &&
+	git -C forked branch detached &&
+	git -C forked branch --track topic-on-main main
+'
+
+test_expect_success '--forked <remote-tracking-branch> lists matching branches' '
+	git -C forked branch --forked origin/one >actual &&
+	echo local-one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <local-branch> lists branches tracking that local branch' '
+	git -C forked branch --forked main >actual &&
+	echo topic-on-main >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--forked <glob> matches every upstream under the pattern' '
+	git -C forked branch --forked "origin/*" >actual &&
+	cat >expect <<-\EOF &&
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked unions multiple <branch> arguments' '
+	git -C forked branch --forked origin/one other/foreign >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked combines literal and glob arguments' '
+	git -C forked branch --forked main "other/*" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	topic-on-main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
+	git -C forked branch --forked "*/*" >actual &&
+	cat >expect <<-\EOF &&
+	local-foreign
+	local-one
+	local-two
+	main
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--forked rejects unknown branch/pattern' '
+	test_must_fail git -C forked branch --forked nope 2>err &&
+	test_grep "not a valid branch or pattern" err
+'
+
+test_expect_success '--forked requires at least one <branch>' '
+	test_must_fail git -C forked branch --forked 2>err &&
+	test_grep "at least one <branch>" err
+'
+
 test_done
-- 
gitgitgadget

