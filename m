Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91FA202B1
	for <e@80x24.org>; Wed,  5 Jul 2017 23:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbdGEXPb (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 19:15:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33090 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdGEXPa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 19:15:30 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so907062wrb.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yymzVtWTGk/CAGjHedPMYysDhKnlSuY4bM/RkNPFbtQ=;
        b=aGt/+PxsuIQLYaOd6w8NgsaR4ofLzjU639RiivArer82XKp0WgfkNtlmkkYZqqig3Q
         xzsw0xDFE9Cow9UNWk2WhtDyfW8lSWo5+PWebB9Ph3KiTidZXtkEa59dQ9Q+q4JBhWOs
         70t1euuangbs766ZGVdgM1GEqxu1+5rioaLTiNE2wdicl1YCZhvlOVOd7dYcIAIV0W6K
         I6a1N2Raf5kC7/e8/P2Gv0ppsKn3g07fRffaesEPBFoyhnp4h/p/asgIKGi12b8tpjK1
         oKPaiV55vsRXG/y3PyMcRvXXVZnQqSfYUd49f8NqVZ/8UyT67VWJ8AVcr14hVsuySpM8
         ynzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yymzVtWTGk/CAGjHedPMYysDhKnlSuY4bM/RkNPFbtQ=;
        b=NUN2JkRSTAFwtxmRk9gL614Jqs0coNg0hv+BIFgiBND3okVZ07dBkhN/hrmoBXNTbs
         Xd+TkGB93Z5b8m0vwnIQfBIf+rQUbk/zbGo779Ns1TahsbOJSV4MmTMFQsOrDYDepC1G
         51v5Rmm8Rxnc5N6pfiGrOT+KSJurfyfJRK9YNkJLBojbZ0uoZljyQIWy+df3Qhn7CV6M
         NhMtrTaaCCtyv8kkduqzP69ZmDuOWzAN0MTkrs0i833ZTq+hMBCRN5y09n+TVHmgQAM6
         NgrctBBxtm2ctgv9apmS52+tYtx+dLk3fN6WywJ+oIyIhNgOszfZ3Beeb/ooGPAnEk42
         lZSw==
X-Gm-Message-State: AKS2vOyfIETnAjQCqimL78tVp3GSNsbeGoaISN/Cvpkc4ukAKS/pLL/x
        Fh1/YdF4+ohAJMXZTDI=
X-Received: by 10.80.179.109 with SMTP id r42mr20609276edd.1.1499296527782;
        Wed, 05 Jul 2017 16:15:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x36sm8834938edb.64.2017.07.05.16.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 16:15:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] branch: add a --copy (-c) option to go with --move (-m)
Date:   Wed,  5 Jul 2017 23:14:54 +0000
Message-Id: <20170705231454.15666-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170705231454.15666-1-avarab@gmail.com>
References: <20170705231454.15666-1-avarab@gmail.com>
In-Reply-To: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sahil Dua <sahildua2305@gmail.com>

Add the ability to --copy a branch and its reflog and configuration,
this uses the same underlying machinery as the --move (-m) option
except the reflog and configuration is copied instead of being moved.

This is useful for e.g. copying a topic branch to a new version,
e.g. work to work-2 after submitting the work topic to the list, while
preserving all the tracking info and other configuration that goes
with the branch, and unlike --move keeping the other already-submitted
branch around for reference.

Like --move, when the source branch is the currently checked out
branch the HEAD is moved to the destination branch. In the case of
--move we don't really have a choice (other than remaining on a
detached HEAD) and in order to keep the functionality consistent, we
are doing it in similar way for --copy too.

The most common usage of this feature is expected to be moving to a
new topic branch which is a copy of the current one, in that case
moving to the target branch is what the user wants, and doesn't
unexpectedly behave differently than --move would.

One outstanding caveat of this implementation is that:

    git checkout maint &&
    git checkout master &&
    git branch -c topic &&
    git checkout -

Will check out 'maint' instead of 'master'. This is because the @{-N}
feature (or its -1 shorthand "-") relies on HEAD reflogs created by
the checkout command, so in this case we'll checkout maint instead of
master, as the user might expect. What to do about that is left to a
future change.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 Documentation/git-branch.txt |  14 ++-
 builtin/branch.c             |  67 ++++++++++----
 config.c                     | 102 ++++++++++++++++----
 config.h                     |   2 +
 refs.c                       |  11 +++
 refs.h                       |   9 +-
 refs/files-backend.c         |  46 +++++++--
 refs/refs-internal.h         |   4 +
 t/t3200-branch.sh            | 215 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 424 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 81bd0a7b77..94fd89ddc5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -18,6 +18,7 @@ SYNOPSIS
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
+'git branch' (-c | -C) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
 
@@ -64,6 +65,10 @@ If <oldbranch> had a corresponding reflog, it is renamed to match
 renaming. If <newbranch> exists, -M must be used to force the rename
 to happen.
 
+The `-c` and `-C` options have the exact same semantics as `-m` and
+`-M`, except instead of the branch being renamed it along with its
+config and reflog will be copied to a new name.
+
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
@@ -104,7 +109,7 @@ OPTIONS
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new
-	branch name already exists.
+	branch name already exists, the same applies for `-c` (or `--copy`).
 
 -m::
 --move::
@@ -113,6 +118,13 @@ OPTIONS
 -M::
 	Shortcut for `--move --force`.
 
+-c::
+--copy::
+	Copy a branch and the corresponding reflog.
+
+-C::
+	Shortcut for `--copy --force`.
+
 --color[=<when>]::
 	Color branches to highlight current, local, and
 	remote-tracking branches.
diff --git a/builtin/branch.c b/builtin/branch.c
index c958e93257..684f2c4f42 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -28,6 +28,7 @@ static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 	N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 	N_("git branch [<options>] [-r | -a] [--points-at]"),
 	N_("git branch [<options>] [-r | -a] [--format]"),
 	NULL
@@ -450,15 +451,19 @@ static void reject_rebase_or_bisect_branch(const char *target)
 	free_worktrees(worktrees);
 }
 
-static void rename_branch(const char *oldname, const char *newname, int force)
+static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	int recovery = 0;
 	int clobber_head_ok;
 
-	if (!oldname)
-		die(_("cannot rename the current branch while not on any."));
+	if (!oldname) {
+		if (copy)
+			die(_("cannot copy the current branch while not on any."));
+		else
+			die(_("cannot rename the current branch while not on any."));
+	}
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -481,17 +486,33 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 
 	reject_rebase_or_bisect_branch(oldref.buf);
 
-	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
-		 oldref.buf, newref.buf);
+	if (copy)
+		strbuf_addf(&logmsg, "Branch: copied %s to %s",
+			    oldref.buf, newref.buf);
+	else
+		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
+			    oldref.buf, newref.buf);
 
-	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
+	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
+	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
+		die(_("Branch copy failed"));
 
-	if (recovery)
-		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
+	if (recovery) {
+		if (copy)
+			warning(_("Copied a misnamed branch '%s' away"),
+				oldref.buf + 11);
+		else
+			warning(_("Renamed a misnamed branch '%s' away"),
+				oldref.buf + 11);
+	}
 
-	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf)) {
+		if (copy)
+			die(_("Branch copied to %s, but HEAD is not updated!"), newname);
+		else
+			die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+	}
 
 	strbuf_release(&logmsg);
 
@@ -499,8 +520,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
 	strbuf_release(&newref);
-	if (git_config_rename_section(oldsection.buf, newsection.buf) < 0)
+	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
 		die(_("Branch is renamed, but update of config-file failed"));
+	if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
+		die(_("Branch is copied, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
 }
@@ -538,7 +561,7 @@ static int edit_branch_description(const char *branch_name)
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force = 0, list = 0;
+	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
 	int reflog = 0, edit_description = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
@@ -575,6 +598,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
+		OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
+		OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
 		OPT_BOOL(0, "list", &list, N_("list branch names")),
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
@@ -618,14 +643,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !copy && !edit_description && !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
 	    filter.no_commit)
 		list = 1;
 
-	if (!!delete + !!rename + !!new_upstream +
+	if (!!delete + !!rename + !!copy + !!new_upstream +
 	    list + unset_upstream > 1)
 		usage_with_options(builtin_branch_usage, options);
 
@@ -643,6 +668,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (force) {
 		delete *= 2;
 		rename *= 2;
+		copy *= 2;
 	}
 
 	if (delete) {
@@ -697,13 +723,22 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (edit_branch_description(branch_name))
 			return 1;
+	} else if (copy) {
+		if (!argc)
+			die(_("branch name required"));
+		else if (argc == 1)
+			copy_or_rename_branch(head, argv[0], 1, copy > 1);
+		else if (argc == 2)
+			copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
+		else
+			die(_("too many branches for a copy operation"));
 	} else if (rename) {
 		if (!argc)
 			die(_("branch name required"));
 		else if (argc == 1)
-			rename_branch(head, argv[0], rename > 1);
+			copy_or_rename_branch(head, argv[0], 0, rename > 1);
 		else if (argc == 2)
-			rename_branch(argv[0], argv[1], rename > 1);
+			copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
 		else
 			die(_("too many branches for a rename operation"));
 	} else if (new_upstream) {
diff --git a/config.c b/config.c
index b7afb5941b..9ee3fcafcf 100644
--- a/config.c
+++ b/config.c
@@ -2713,8 +2713,8 @@ static int section_name_is_ok(const char *name)
 }
 
 /* if new_name == NULL, the section is removed instead */
-int git_config_rename_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name)
+static int git_config_copy_or_rename_section_in_file(const char *config_filename,
+				      const char *old_name, const char *new_name, int copy)
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
@@ -2723,6 +2723,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	char buf[1024];
 	FILE *config_file = NULL;
 	struct stat st;
+	struct strbuf copystr = STRBUF_INIT;
 
 	if (new_name && !section_name_is_ok(new_name)) {
 		ret = error("invalid section name: %s", new_name);
@@ -2761,12 +2762,30 @@ int git_config_rename_section_in_file(const char *config_filename,
 	while (fgets(buf, sizeof(buf), config_file)) {
 		int i;
 		int length;
+		int is_section = 0;
 		char *output = buf;
 		for (i = 0; buf[i] && isspace(buf[i]); i++)
 			; /* do nothing */
 		if (buf[i] == '[') {
 			/* it's a section */
-			int offset = section_name_match(&buf[i], old_name);
+			int offset;
+			is_section = 1;
+
+			/*
+			 * When encountering a new section under -c we
+			 * need to flush out any section we're already
+			 * coping and begin anew. There might be
+			 * multiple [branch "$name"] sections.
+			 */
+			if (copystr.len > 0) {
+				if (write_in_full(out_fd, copystr.buf, copystr.len) != copystr.len) {
+					ret = write_error(get_lock_file_path(lock));
+					goto out;
+				}
+				strbuf_reset(&copystr);
+			}
+
+			offset = section_name_match(&buf[i], old_name);
 			if (offset > 0) {
 				ret++;
 				if (new_name == NULL) {
@@ -2774,25 +2793,30 @@ int git_config_rename_section_in_file(const char *config_filename,
 					continue;
 				}
 				store.baselen = strlen(new_name);
-				if (!store_write_section(out_fd, new_name)) {
-					ret = write_error(get_lock_file_path(lock));
-					goto out;
-				}
-				/*
-				 * We wrote out the new section, with
-				 * a newline, now skip the old
-				 * section's length
-				 */
-				output += offset + i;
-				if (strlen(output) > 0) {
+				if (!copy) {
+					if (!store_write_section(out_fd, new_name)) {
+						ret = write_error(get_lock_file_path(lock));
+						goto out;
+					}
+
 					/*
-					 * More content means there's
-					 * a declaration to put on the
-					 * next line; indent with a
-					 * tab
+					 * We wrote out the new section, with
+					 * a newline, now skip the old
+					 * section's length
 					 */
-					output -= 1;
-					output[0] = '\t';
+					output += offset + i;
+					if (strlen(output) > 0) {
+						/*
+						 * More content means there's
+						 * a declaration to put on the
+						 * next line; indent with a
+						 * tab
+						 */
+						output -= 1;
+						output[0] = '\t';
+					}
+				} else {
+					copystr = store_create_section(new_name);
 				}
 			}
 			remove = 0;
@@ -2800,11 +2824,30 @@ int git_config_rename_section_in_file(const char *config_filename,
 		if (remove)
 			continue;
 		length = strlen(output);
+
+		if (!is_section && copystr.len > 0) {
+			strbuf_add(&copystr, output, length);
+		}
+
 		if (write_in_full(out_fd, output, length) != length) {
 			ret = write_error(get_lock_file_path(lock));
 			goto out;
 		}
 	}
+
+	/*
+	 * Copy a trailing section at the end of the config, won't be
+	 * flushed by the usual "flush because we have a new section
+	 * logic in the loop above.
+	 */
+	if (copystr.len > 0) {
+		if (write_in_full(out_fd, copystr.buf, copystr.len) != copystr.len) {
+			ret = write_error(get_lock_file_path(lock));
+			goto out;
+		}
+		strbuf_reset(&copystr);
+	}
+
 	fclose(config_file);
 	config_file = NULL;
 commit_and_out:
@@ -2820,11 +2863,30 @@ int git_config_rename_section_in_file(const char *config_filename,
 	return ret;
 }
 
+int git_config_rename_section_in_file(const char *config_filename,
+				      const char *old_name, const char *new_name)
+{
+	return git_config_copy_or_rename_section_in_file(config_filename,
+					 old_name, new_name, 0);
+}
+
 int git_config_rename_section(const char *old_name, const char *new_name)
 {
 	return git_config_rename_section_in_file(NULL, old_name, new_name);
 }
 
+int git_config_copy_section_in_file(const char *config_filename,
+				      const char *old_name, const char *new_name)
+{
+	return git_config_copy_or_rename_section_in_file(config_filename,
+					 old_name, new_name, 1);
+}
+
+int git_config_copy_section(const char *old_name, const char *new_name)
+{
+	return git_config_copy_section_in_file(NULL, old_name, new_name);
+}
+
 /*
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
diff --git a/config.h b/config.h
index 0352da117b..e9bdecbf88 100644
--- a/config.h
+++ b/config.h
@@ -71,6 +71,8 @@ extern int git_config_set_multivar_in_file_gently(const char *, const char *, co
 extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, const char *);
+extern int git_config_copy_section(const char *, const char *);
+extern int git_config_copy_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
diff --git a/refs.c b/refs.c
index 88658ba769..8a334a2ff0 100644
--- a/refs.c
+++ b/refs.c
@@ -2045,3 +2045,14 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
 	return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
 }
+
+int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg)
+{
+	return refs->be->copy_ref(refs, oldref, newref, logmsg);
+}
+
+int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
+{
+	return refs_copy_existing_ref(get_main_ref_store(), oldref, newref, logmsg);
+}
diff --git a/refs.h b/refs.h
index 6daa78eb50..80da9fe389 100644
--- a/refs.h
+++ b/refs.h
@@ -443,7 +443,14 @@ char *shorten_unambiguous_ref(const char *refname, int strict);
 /** rename ref, return 0 on success **/
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg);
-int rename_ref(const char *oldref, const char *newref, const char *logmsg);
+int rename_ref(const char *oldref, const char *newref,
+			const char *logmsg);
+
+/** copy ref, return 0 on success **/
+int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+		    const char *newref, const char *logmsg);
+int copy_existing_ref(const char *oldref, const char *newref,
+			const char *logmsg);
 
 int refs_create_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0404f2c233..000362b9d8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1748,9 +1748,9 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err);
 
-static int files_rename_ref(struct ref_store *ref_store,
+static int files_copy_or_rename_ref(struct ref_store *ref_store,
 			    const char *oldrefname, const char *newrefname,
-			    const char *logmsg)
+			    const char *logmsg, int copy)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
@@ -1782,8 +1782,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (flag & REF_ISSYMREF) {
-		ret = error("refname %s is a symbolic ref, renaming it is not supported",
-			    oldrefname);
+		if (copy)
+			ret = error("refname %s is a symbolic ref, copying it is not supported",
+				    oldrefname);
+		else
+			ret = error("refname %s is a symbolic ref, renaming it is not supported",
+				    oldrefname);
 		goto out;
 	}
 	if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
@@ -1791,13 +1795,19 @@ static int files_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
+	if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
 		ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
 			    oldrefname, strerror(errno));
 		goto out;
 	}
 
-	if (refs_delete_ref(&refs->base, logmsg, oldrefname,
+	if (copy && log && copy_file(tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
+		ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
+			    oldrefname, strerror(errno));
+		goto out;
+	}
+
+	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
 			    orig_oid.hash, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
@@ -1810,7 +1820,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!refs_read_ref_full(&refs->base, newrefname,
+	if (!copy && !refs_read_ref_full(&refs->base, newrefname,
 				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				oid.hash, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
@@ -1841,7 +1851,10 @@ static int files_rename_ref(struct ref_store *ref_store,
 	lock = lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
 				   REF_NODEREF, NULL, &err);
 	if (!lock) {
-		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
+		if (copy)
+			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
+		else
+			error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
 	}
@@ -1892,6 +1905,22 @@ static int files_rename_ref(struct ref_store *ref_store,
 	return ret;
 }
 
+static int files_rename_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
+{
+	return files_copy_or_rename_ref(ref_store, oldrefname,
+				 newrefname, logmsg, 0);
+}
+
+static int files_copy_ref(struct ref_store *ref_store,
+			    const char *oldrefname, const char *newrefname,
+			    const char *logmsg)
+{
+	return files_copy_or_rename_ref(ref_store, oldrefname,
+				 newrefname, logmsg, 1);
+}
+
 static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
@@ -3397,6 +3426,7 @@ struct ref_storage_be refs_be_files = {
 	files_create_symref,
 	files_delete_refs,
 	files_rename_ref,
+	files_copy_ref,
 
 	files_ref_iterator_begin,
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 192f9f85c9..3c51194edb 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -543,6 +543,9 @@ typedef int delete_refs_fn(struct ref_store *ref_store, const char *msg,
 typedef int rename_ref_fn(struct ref_store *ref_store,
 			  const char *oldref, const char *newref,
 			  const char *logmsg);
+typedef int copy_ref_fn(struct ref_store *ref_store,
+			  const char *oldref, const char *newref,
+			  const char *logmsg);
 
 /*
  * Iterate over the references in `ref_store` whose names start with
@@ -641,6 +644,7 @@ struct ref_storage_be {
 	create_symref_fn *create_symref;
 	delete_refs_fn *delete_refs;
 	rename_ref_fn *rename_ref;
+	copy_ref_fn *copy_ref;
 
 	ref_iterator_begin_fn *iterator_begin;
 	read_raw_ref_fn *read_raw_ref;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 596fbc8483..5402933877 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -399,6 +399,221 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch -c dumps usage' '
+	test_expect_code 128 git branch -c 2>err &&
+	test_i18ngrep "branch name required" err
+'
+
+test_expect_success 'git branch --copy dumps usage' '
+	test_expect_code 128 git branch --copy 2>err &&
+	test_i18ngrep "branch name required" err
+'
+
+test_expect_success 'git branch -c d e should work' '
+	git branch -l d &&
+	git reflog exists refs/heads/d &&
+	git config branch.d.dummy Hello &&
+	git branch -c d e &&
+	git reflog exists refs/heads/d &&
+	git reflog exists refs/heads/e &&
+	echo Hello >expect &&
+	git config branch.e.dummy >actual &&
+	test_cmp expect actual &&
+	echo Hello >expect &&
+	git config branch.d.dummy >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch --copy is a synonym for -c' '
+	git branch -l copy &&
+	git reflog exists refs/heads/copy &&
+	git config branch.copy.dummy Hello &&
+	git branch --copy copy copy-to &&
+	git reflog exists refs/heads/copy &&
+	git reflog exists refs/heads/copy-to &&
+	echo Hello >expect &&
+	git config branch.copy.dummy >actual &&
+	test_cmp expect actual &&
+	echo Hello >expect &&
+	git config branch.copy-to.dummy >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
+	git checkout -b ee &&
+	git reflog exists refs/heads/ee &&
+	git config branch.ee.dummy Hello &&
+	git branch -c ee ef &&
+	git reflog exists refs/heads/ee &&
+	git reflog exists refs/heads/ef &&
+	test $(git config branch.ee.dummy) = Hello &&
+	test $(git config branch.ef.dummy) = Hello &&
+	test $(git rev-parse --abbrev-ref HEAD) = ef
+'
+
+test_expect_success 'git branch -c f/f g/g should work' '
+	git branch -l f/f &&
+	git reflog exists refs/heads/f/f &&
+	git config branch.f/f.dummy Hello &&
+	git branch -c f/f g/g &&
+	git reflog exists refs/heads/f/f &&
+	git reflog exists refs/heads/g/g &&
+	test $(git config branch.f/f.dummy) = Hello &&
+	test $(git config branch.g/g.dummy) = Hello
+'
+
+test_expect_success 'git branch -c m2 m2 should work' '
+	git branch -l m2 &&
+	git reflog exists refs/heads/m2 &&
+	git config branch.m2.dummy Hello &&
+	git branch -c m2 m2 &&
+	git reflog exists refs/heads/m2 &&
+	test $(git config branch.m2.dummy) = Hello
+'
+
+test_expect_success 'git branch -c zz zz/zz should fail' '
+	git branch -l zz &&
+	git reflog exists refs/heads/zz &&
+	test_must_fail git branch -c zz zz/zz
+'
+
+test_expect_success 'git branch -c b/b b should fail' '
+	git branch -l b/b &&
+	test_must_fail git branch -c b/b b
+'
+
+test_expect_success 'git branch -C o/q o/p should work when o/p exists' '
+	git branch -l o/q &&
+	git reflog exists refs/heads/o/q &&
+	git reflog exists refs/heads/o/p &&
+	git branch -C o/q o/p
+'
+
+test_expect_success 'git branch -c -f o/q o/p should work when o/p exists' '
+	git reflog exists refs/heads/o/q &&
+	git reflog exists refs/heads/o/p &&
+	git branch -c -f o/q o/p
+'
+
+test_expect_success 'git branch -c qq rr/qq should fail when r exists' '
+	git branch qq &&
+	git branch rr &&
+	test_must_fail git branch -c qq rr/qq
+'
+
+test_expect_success 'git branch -C b1 b2 should fail when b2 is checked out' '
+	git branch b1 &&
+	git checkout -b b2 &&
+	test_must_fail git branch -C b1 b2
+'
+
+test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out' '
+	git checkout -b c1 &&
+	git branch c2 &&
+	git branch -C c1 c2 &&
+	test $(git rev-parse --abbrev-ref HEAD) = c2
+'
+
+test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/HEAD' '
+	msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
+	grep "$msg$" .git/logs/HEAD
+'
+
+test_expect_success 'git branch -C master should work when master is checked out' '
+	git checkout master &&
+	git branch -C master
+'
+
+test_expect_success 'git branch -C master master should work when master is checked out' '
+	git checkout master &&
+	git branch -C master master
+'
+
+test_expect_success 'git branch -C master5 master5 should work when master is checked out' '
+	git checkout master &&
+	git branch master5 &&
+	git branch -C master5 master5
+'
+
+test_expect_success 'git branch -C ab cd should overwrite existing config for cd' '
+	git branch -l cd &&
+	git reflog exists refs/heads/cd &&
+	git config branch.cd.dummy CD &&
+	git branch -l ab &&
+	git reflog exists refs/heads/ab &&
+	git config branch.ab.dummy AB &&
+	git branch -C ab cd &&
+	git reflog exists refs/heads/ab &&
+	git reflog exists refs/heads/cd &&
+	test $(git config branch.ab.dummy) = AB &&
+	test $(git config branch.cd.dummy) = AB
+'
+
+test_expect_success 'git branch -c correctly copies multiple config sections' '
+	FOO=1 &&
+	export FOO &&
+	test_when_finished "git checkout master" &&
+	git checkout -b source2 master &&
+
+	# Assert that a config file with multiple config sections has
+	# those sections preserved...
+	cat >expect <<-\EOF &&
+	branch.source2.key1=value1
+	branch.dest2.key1=value1
+	more.gar.b=age
+	branch.source2.key2=value2
+	branch.dest2.key2=value2
+	EOF
+	cat >config.branch <<\EOF &&
+;; Note the lack of -\EOF above & mixed indenting here. This is
+;; intentional, we are also testing that the formatting of copied
+;; sections is preserved.
+
+;; Comment for source2. Tabs
+[branch "source2"]
+	;; Comment for the source2 value
+	key1 = value1
+;; Comment for more.gar. Spaces
+[more "gar"]
+    ;; Comment for the more.gar value
+    b = age
+;; Comment for source2, again. Mixed tabs/spaces.
+[branch "source2"]
+    ;; Comment for the source2 value, again
+	key2 = value2
+EOF
+	cat config.branch >>.git/config &&
+	git branch -c source2 dest2 &&
+	git config -f .git/config -l | grep -F -e source2 -e dest2 -e more.gar >actual &&
+	test_cmp expect actual &&
+
+	# ...and that the comments and formatting for those sections
+	# is also preserved.
+	cat >expect <<\EOF &&
+;; Comment for source2. Tabs
+[branch "source2"]
+	;; Comment for the source2 value
+	key1 = value1
+;; Comment for more.gar. Spaces
+[branch "dest2"]
+	;; Comment for the source2 value
+	key1 = value1
+;; Comment for more.gar. Spaces
+[more "gar"]
+    ;; Comment for the more.gar value
+    b = age
+;; Comment for source2, again. Mixed tabs/spaces.
+[branch "source2"]
+    ;; Comment for the source2 value, again
+	key2 = value2
+[branch "dest2"]
+    ;; Comment for the source2 value, again
+	key2 = value2
+EOF
+	sed -n -e "/Comment for source2/,\$p" .git/config >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'deleting a symref' '
 	git branch target &&
 	git symbolic-ref refs/heads/symref refs/heads/target &&
-- 
2.13.1.611.g7e3b11ae1

