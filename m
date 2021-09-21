Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A72C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F9A611CE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhIUX11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhIUX1X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:27:23 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BBCC061756
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:25:54 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e2-20020ad45582000000b0037e7bdc88d4so8111895qvx.2
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJNsC0aQ1Y7hXcRacA9EvTL/0KnC6l83ztrs7ORw2a0=;
        b=V30rtlDH3LU8/3E8YC1pSBfCrferybylb1GOnwbWIV4wxNoGiQBXN0W+NjHQuqKb7l
         wU8I3J8j1nsbFrFGb4BQuL7V9uk78pPt62JG/AasRXvMMg36PLMuRUDBGh4D5jamz5PL
         jparagZR/bP3qjM+x3qOz0w4kM9430JQOX538avwgQmRYTIAHZGIZ66Px25+HsN0L0Ak
         FFIOM+pSlFaYvpzWQ6P+MLeFeFjFksgCdWkXGs9DuBWYCMhwloNTl/TyFM/gFgQ1sj26
         fKyJT7OV0XnQ/nKk9SlurdF/Brg62Ez70/JxDixNC7izC6pqIEzQSQzmV2ATxZ70Vjek
         I8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJNsC0aQ1Y7hXcRacA9EvTL/0KnC6l83ztrs7ORw2a0=;
        b=nyamp4DWTIFVl+CKiBuwdohXvcFr33zdT27MUKmX5st7SIxhJpDOhgz9A5FZeLUbT9
         9tAnBiihG+0FivkCEFqBLXslSs6hPqXYdal8IvKe1JPGXSy0zDOqcRrJ4TkRdy2Bc6mS
         +Xx4F/a9wHRL/n7NloSMgn1VcOEBYGOm5XFVj5hDrrCr414dlaESiiWN85UK8Zbp/sBN
         4RfCm8TLNX+2qFiuJbJSn2kyq5sgMtEsHp3h9vOH6gp+dnfOeClH8RDHaFe7N/12xGVF
         pbNDSqEk3WRQV8Qog2az/SB1QxVak2CxsSQ2BqBWHLggjjWVBIHIYYTNQXIG4X5amP36
         ez6w==
X-Gm-Message-State: AOAM532SkGCtbSZiW0J8tQwu1voDR5wsLA8iNXChaqxX6+KZfgspRFcQ
        mCcqUHzzjLqgiCUfIsGFQTpSPKggjZKAglRIgESlbulwn3qwF6nbukYjUHNPDRBJQ42GwL37Xw/
        DHMysEWm6xiil0Q54qUlIaRfok/Ta7677gtf/TBqsWV8vK1azUahxEh/+0J2Dq/k=
X-Google-Smtp-Source: ABdhPJxReVAD3Bhdv8YvxvscT/czvakyEpwdc4VzldbnWeO1C0hlT6ocJdivoyuIhvtsBrR1CU5gLx1hptRCrw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6214:12d3:: with SMTP id
 s19mr33985403qvv.10.1632266753456; Tue, 21 Sep 2021 16:25:53 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:25:29 -0700
In-Reply-To: <20210921232529.81811-1-chooglen@google.com>
Message-Id: <20210921232529.81811-3-chooglen@google.com>
Mime-Version: 1.0
References: <20210921232529.81811-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [RFC PATCH 2/2] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When working with a superproject and submodules, it can be helpful to
create topic branches to coordinate the work between each repository.

Teach cmd_branch to accept the --recurse-submodules option when creating
branches. When specified, like

  git branch --recurse-submodules topic

git-branch will create the "topic" branch in the superproject and all
submodules.

recurse_submodules is only supported for creating a branch. git-branch
will fail if the user attempts to use --recurse-submodules with anything
other than creating a branch. If a user has submodule.recurse in their
config, git-branch will use --recurse-submodules for creating a branch,
but will treat it as unset for any other operation.

There is no easy way to get the remotes of a submodule because remotes.c
stores state as static variables. As such, branch tracking is disabled
when using --recurse-submodules.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c           | 26 ++++++++++-------
 branch.h           |  4 +--
 builtin/branch.c   | 69 ++++++++++++++++++++++++++++++++++++++++++----
 builtin/checkout.c |  4 +--
 t/t3200-branch.sh  | 58 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 19 deletions(-)

diff --git a/branch.c b/branch.c
index 07a46430b3..1acf4aa407 100644
--- a/branch.c
+++ b/branch.c
@@ -137,6 +137,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 	struct tracking tracking;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
 
+	if (track == BRANCH_TRACK_NEVER)
+		return;
+
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	if (for_each_remote(find_tracked_branch, &tracking))
@@ -183,12 +186,12 @@ int read_branch_desc(struct strbuf *buf, const char *branch_name)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref)
+int validate_branchname(struct repository *r, const char *name, struct strbuf *ref)
 {
 	if (strbuf_check_branch_ref(ref, name))
 		die(_("'%s' is not a valid branch name."), name);
 
-	return ref_exists(ref->buf);
+	return refs_ref_exists(get_main_ref_store(r), ref->buf);
 }
 
 /*
@@ -197,11 +200,11 @@ int validate_branchname(const char *name, struct strbuf *ref)
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force)
+int validate_new_branchname(struct repository *r, const char *name, struct strbuf *ref, int force)
 {
 	const char *head;
 
-	if (!validate_branchname(name, ref))
+	if (!validate_branchname(r, name, ref))
 		return 0;
 
 	if (!force)
@@ -209,6 +212,9 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		    ref->buf + strlen("refs/heads/"));
 
 	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	/*
+	 * NEEDSWORK is_bare_repository() references the_repository.
+	 */
 	if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 		die(_("Cannot force update the current branch."));
 
@@ -260,8 +266,8 @@ void create_branch(struct repository *r,
 		explicit_tracking = 1;
 
 	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
-	    ? validate_branchname(name, &ref)
-	    : validate_new_branchname(name, &ref, force)) {
+	    ? validate_branchname(r, name, &ref)
+	    : validate_new_branchname(r, name, &ref, force)) {
 		if (!force)
 			dont_change_ref = 1;
 		else
@@ -269,7 +275,7 @@ void create_branch(struct repository *r,
 	}
 
 	real_ref = NULL;
-	if (get_oid_mb(start_name, &oid)) {
+	if (repo_get_oid_mb(r, start_name, &oid)) {
 		if (explicit_tracking) {
 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
 				error(_(upstream_missing), start_name);
@@ -281,7 +287,7 @@ void create_branch(struct repository *r,
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
 
-	switch (dwim_ref(start_name, strlen(start_name), &oid, &real_ref, 0)) {
+	switch (repo_dwim_ref(r, start_name, strlen(start_name), &oid, &real_ref, 0)) {
 	case 0:
 		/* Not branching from any existing branch */
 		if (explicit_tracking)
@@ -319,12 +325,12 @@ void create_branch(struct repository *r,
 		else
 			msg = xstrfmt("branch: Created from %s", start_name);
 
-		transaction = ref_transaction_begin(&err);
+		transaction = ref_store_transaction_begin(get_main_ref_store(r), &err);
 		if (!transaction ||
 		    ref_transaction_update(transaction, ref.buf,
 					   &oid, forcing ? NULL : null_oid(),
 					   0, msg, &err) ||
-		    ref_transaction_commit(transaction, &err))
+		    repo_ref_transaction_commit(r, transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		strbuf_release(&err);
diff --git a/branch.h b/branch.h
index df0be61506..5fb9ed7e03 100644
--- a/branch.h
+++ b/branch.h
@@ -50,7 +50,7 @@ void create_branch(struct repository *r,
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_branchname(const char *name, struct strbuf *ref);
+int validate_branchname(struct repository *r, const char *name, struct strbuf *ref);
 
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
@@ -58,7 +58,7 @@ int validate_branchname(const char *name, struct strbuf *ref);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(struct repository *r, const char *name, struct strbuf *ref, int force);
 
 /*
  * Remove information about the merge state on the current
diff --git a/builtin/branch.c b/builtin/branch.c
index 03c7b7253a..58a730b275 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -24,6 +24,7 @@
 #include "worktree.h"
 #include "help.h"
 #include "commit-reach.h"
+#include "submodule-config.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
@@ -38,6 +39,7 @@ static const char * const builtin_branch_usage[] = {
 
 static const char *head;
 static struct object_id head_oid;
+static int recurse_submodules = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -100,6 +102,11 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 			return config_error_nonbool(var);
 		return color_parse(value, branch_colors[slot]);
 	}
+	if (!strcmp(var, "submodule.recurse")) {
+		recurse_submodules = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_color_default_config(var, value, cb);
 }
 
@@ -190,6 +197,50 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
+static void create_branches(struct repository *r, const char *name,
+			   const char *start_name, int force,
+			   int clobber_head_ok, int reflog, int quiet,
+			   enum branch_track track)
+{
+	int i = 0;
+	struct repository subrepo;
+	const char *r_start_name;
+	const struct submodule *sub;
+
+	r_start_name = strcmp(start_name, "HEAD") ? start_name :
+		refs_resolve_refdup(get_main_ref_store(r), start_name, 0, NULL, NULL);
+	if (strcmp(r_start_name, "HEAD"))
+		skip_prefix(r_start_name, "refs/heads/", &r_start_name);
+	create_branch(r, name, r_start_name, force, clobber_head_ok, reflog,
+		      quiet, track);
+
+	if (!recurse_submodules) {
+		return;
+	}
+
+	if (repo_read_index(r) < 0)
+		die(_("index file corrupt"));
+
+	for (i = 0; i < r->index->cache_nr; i++) {
+		const struct cache_entry *ce = r->index->cache[i];
+		if (!S_ISGITLINK(ce->ce_mode))
+			continue;
+		sub = submodule_from_path(r, null_oid(), ce->name);
+		if (repo_submodule_init(&subrepo, r, sub) < 0) {
+			warning(_("Unable to initialize subrepo %s, skipping."), ce->name);
+			continue;
+		}
+		/*
+		 * NEEDSWORK: branch tracking is not supported for
+		 * submodules because it is not possible to get the
+		 * remotes of a submodule.
+		 */
+		create_branches(&subrepo, name, start_name, force,
+				clobber_head_ok, reflog, quiet, BRANCH_TRACK_NEVER);
+		repo_clear(&subrepo);
+	}
+}
+
 static int delete_branches(int argc, const char **argv, int force, int kinds,
 			   int quiet)
 {
@@ -531,9 +582,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
 	 */
 	if (!strcmp(oldname, newname))
-		validate_branchname(newname, &newref);
+		validate_branchname(the_repository, newname, &newref);
 	else
-		validate_new_branchname(newname, &newref, force);
+		validate_new_branchname(the_repository, newname, &newref, force);
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
@@ -626,6 +677,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int icase = 0;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	struct ref_format format = REF_FORMAT_INIT;
+	int recurse_submodules_explicit = 0;
 
 	struct option options[] = {
 		OPT_GROUP(N_("Generic options")),
@@ -669,6 +721,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
 			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
 	};
@@ -708,6 +761,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
 	    list + edit_description + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
+	else if (recurse_submodules_explicit &&
+		 (delete || rename || copy || new_upstream || show_current || list
+		  || edit_description || unset_upstream))
+		die(_("--recurse-submodules can only be used to create branches"));
+
+	recurse_submodules |= !!recurse_submodules_explicit;
 
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
@@ -857,9 +916,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
-		create_branch(the_repository,
-			      argv[0], (argc == 2) ? argv[1] : head,
-			      force, 0, reflog, quiet, track);
+		create_branches(the_repository,
+			      argv[0], (argc == 2) ? argv[1] : "HEAD",
+				force, 0, reflog, quiet, track);
 
 	} else
 		usage_with_options(builtin_branch_usage, options);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c69dcdf72..8859076a14 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1761,10 +1761,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		struct strbuf buf = STRBUF_INIT;
 
 		if (opts->new_branch_force)
-			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
+			opts->branch_exists = validate_branchname(the_repository, opts->new_branch, &buf);
 		else
 			opts->branch_exists =
-				validate_new_branchname(opts->new_branch, &buf, 0);
+				validate_new_branchname(the_repository, opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e575ffb4ff..858831d4cf 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1421,5 +1421,63 @@ test_expect_success 'invalid sort parameter in configuration' '
 		test_must_fail git branch
 	)
 '
+# Submodule tests
+
+test_expect_success 'setup superproject and submodule' '
+	git init parent &&
+	test_commit -C parent bar &&
+	git init child &&
+	test_commit -C child bar &&
+	git -C parent submodule add ../child sub &&
+	git -C parent commit -m "add submodule"
+'
+
+test_expect_success '--recurse-submodules should create branches' '
+	(
+		cd parent &&
+		git branch --recurse-submodules abc &&
+		test_path_is_file .git/refs/heads/abc &&
+		test_path_is_file .git/modules/sub/refs/heads/abc
+	)
+'
+
+test_expect_success '--recurse-submodules should fail when not creating branches' '
+	(
+		cd parent &&
+		test_must_fail git branch --recurse-submodules -D abc &&
+		test_path_is_file .git/refs/heads/abc &&
+		test_path_is_file .git/modules/sub/refs/heads/abc
+	)
+'
+
+test_expect_success 'should respect submodule.recurse when creating branches' '
+	(
+		cd parent &&
+		git -c submodule.recurse=true branch def &&
+		test_path_is_file .git/refs/heads/def &&
+		test_path_is_file .git/modules/sub/refs/heads/def
+	)
+'
+
+test_expect_success 'should ignore submodule.recurse when not creating branches' '
+	(
+		cd parent &&
+		git -c submodule.recurse=true branch -D def &&
+		test_path_is_missing .git/refs/heads/def &&
+		test_path_is_file .git/modules/sub/refs/heads/def
+	)
+'
+
+test_expect_success 'should not set up tracking for new submodule branches' '
+	(
+		cd parent &&
+		git -c branch.autoSetupMerge=always branch --recurse-submodules ghi main &&
+		test_path_is_file .git/modules/sub/refs/heads/ghi &&
+		test "$(git config branch.ghi.remote)" = . &&
+		test "$(git config branch.ghi.merge)" = refs/heads/main &&
+		test "z$(git -C ../child config branch.ghi.remote)" = z &&
+		test "z$(git -C ../child config branch.ghi.merge)" = z
+	)
+'
 
 test_done
-- 
2.33.0.464.g1972c5931b-goog

