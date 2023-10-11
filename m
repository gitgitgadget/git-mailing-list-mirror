Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE94CD6E7D
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 15:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjJKPYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJKPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 11:24:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E892
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:24:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50307acd445so8858396e87.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697037873; x=1697642673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sdFeVtWLR97cbxyXai14pvkh4jBFPGDUNbCQt8bVg8=;
        b=AI2rS1TWkPLNSlsJDfR5hBz6zkfYrePzTi47oInbjQaoF2VrODUalE7Kp1lrcQwHqU
         IeUtdqvL+NDV0cIZSH8w4ds0y67+sDuWXtz+jUGaWHgAXcg8A4jDMG4KnIIfGvUaxFP0
         gxPL+lrHaR0OD1ShoDWgV/pkq4XQNQ8SEOJ5CkJNr9NnWvvjcq+XlI767Nx14vYCMyFx
         qMS6sqS+V6AQo7x9i9oiXbvYtohxHHTFwzxiCdT0PPA3Sn9mKoReDxwYW7D6LglhoZXH
         hmxb16oCjWfm6CZGHRFpZo64C5/QfbuDumfALFQN8islhNIZCUMhAQ3Mxh3Ylb/clGGa
         s1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037873; x=1697642673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sdFeVtWLR97cbxyXai14pvkh4jBFPGDUNbCQt8bVg8=;
        b=u7nTz87kRZ70ATaZiAE/153Q79tvb23r288brjdzG+CffHkpUlQjlXLGK56JSVWYMe
         NTfknCCYcz7lranKYN/WWe4CKIOCE21qaLM+YfbOaQ+fWRVU6jQ2YZP44hs6PoBDfEXL
         A23gheBJSN0SEjMO91xOZg1lL8MkTodZbQsyA67yQ6U6HWoFeBMUegJm8yU9SU/QBhKB
         B7FJmnx+9XLozM0fVgfxvziWCFlAC6ClOHwkWMvYkSIvxKKn06N5Jto4UFDjWq2zZg7N
         1DikNUVyiXCAoSrn1xlFQc1yaUmKk+nsKssW38lIY0ZAEKqbu+ywAxH8FGl0kZ8dgvtw
         JtRw==
X-Gm-Message-State: AOJu0Yy894/9cgdiDpnwj9JLmZx8S7h4PL81Y0B2Tb5s1oY+KvHVdUMq
        e9ZWE53SDU7NJnqQwJl7PQIRyxJCYDJM/A14WDQ=
X-Google-Smtp-Source: AGHT+IHs4zHYJ/lVLpdufA2KyPxVPCBUMOH5evgHzkGKHLIFPmljNjZZJg/EGWgZk4+6dWN4UYv5wQ==
X-Received: by 2002:a05:6512:ba3:b0:4f9:51ac:41eb with SMTP id b35-20020a0565120ba300b004f951ac41ebmr21919349lfv.16.1697037873200;
        Wed, 11 Oct 2023 08:24:33 -0700 (PDT)
Received: from isoken-VirtualBox.. ([197.211.58.63])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064ec300b00997d7aa59fasm10112856ejv.14.2023.10.11.08.24.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:24:32 -0700 (PDT)
From:   Isoken June Ibizugbe <isokenjune@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/1] branch.c: ammend error messages for die()
Date:   Wed, 11 Oct 2023 16:24:20 +0100
Message-ID: <20231011152424.6957-2-isokenjune@gmail.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20231011152424.6957-1-isokenjune@gmail.com>
References: <20231011152424.6957-1-isokenjune@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
---
 builtin/branch.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2ec190b14a..a756543d64 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -518,11 +518,11 @@ static void reject_rebase_or_bisect_branch(struct worktree **worktrees,
 			continue;
 
 		if (is_worktree_being_rebased(wt, target))
-			die(_("Branch %s is being rebased at %s"),
+			die(_("branch %s is being rebased at %s"),
 			    target, wt->path);
 
 		if (is_worktree_being_bisected(wt, target))
-			die(_("Branch %s is being bisected at %s"),
+			die(_("branch %s is being bisected at %s"),
 			    target, wt->path);
 	}
 }
@@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		if (ref_exists(oldref.buf))
 			recovery = 1;
 		else
-			die(_("Invalid branch name: '%s'"), oldname);
+			die(_("invalid branch name: '%s'"), oldname);
 	}
 
 	for (int i = 0; worktrees[i]; i++) {
@@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
 		if (oldref_usage & IS_HEAD)
-			die(_("No commit on branch '%s' yet."), oldname);
+			die(_("no commit on branch '%s' yet"), oldname);
 		else
-			die(_("No branch named '%s'."), oldname);
+			die(_("no branch named '%s'"), oldname);
 	}
 
 	/*
@@ -624,9 +624,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch rename failed"));
+		die(_("branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
-		die(_("Branch copy failed"));
+		die(_("branch copy failed"));
 
 	if (recovery) {
 		if (copy)
@@ -640,16 +640,16 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (!copy && (oldref_usage & IS_HEAD) &&
 	    replace_each_worktree_head_symref(worktrees, oldref.buf, newref.buf,
 					      logmsg.buf))
-		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+		die(_("branch renamed to %s, but HEAD is not updated!"), newname);
 
 	strbuf_release(&logmsg);
 
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
 	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is renamed, but update of config-file failed"));
+		die(_("branch is renamed, but update of config-file failed"));
 	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
-		die(_("Branch is copied, but update of config-file failed"));
+		die(_("branch is copied, but update of config-file failed"));
 	strbuf_release(&oldref);
 	strbuf_release(&newref);
 	strbuf_release(&oldsection);
@@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
 	if (!head)
-		die(_("Failed to resolve HEAD as a valid ref."));
+		die(_("failed to resolve HEAD as a valid ref"));
 	if (!strcmp(head, "HEAD"))
 		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
@@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (!argc) {
 			if (filter.detached)
-				die(_("Cannot give description to detached HEAD"));
+				die(_("cannot give description to detached HEAD"));
 			branch_name = head;
 		} else if (argc == 1) {
 			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
@@ -892,7 +892,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!argc)
 			die(_("branch name required"));
 		else if ((argc == 1) && filter.detached)
-			die(copy? _("cannot copy the current branch while not on any.")
+			die(copy? _("cannot copy the current branch while not on any")
 				: _("cannot rename the current branch while not on any."));
 		else if (argc == 1)
 			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
@@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not set upstream of HEAD to %s when "
-				      "it does not point to any branch."),
+				      "it does not point to any branch"),
 				    new_upstream);
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!ref_exists(branch->refname)) {
 			if (!argc || branch_checked_out(branch->refname))
-				die(_("No commit on branch '%s' yet."), branch->name);
+				die(_("no commit on branch '%s' yet"), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
@@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
 				die(_("could not unset upstream of HEAD when "
-				      "it does not point to any branch."));
+				      "it does not point to any branch"));
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
 		if (!branch_has_merge_config(branch))
-			die(_("Branch '%s' has no upstream information"), branch->name);
+			die(_("branch '%s' has no upstream information"), branch->name);
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
@@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		const char *start_name = argc == 2 ? argv[1] : head;
 
 		if (filter.kind != FILTER_REFS_BRANCHES)
-			die(_("The -a, and -r, options to 'git branch' do not take a branch name.\n"
+			die(_("the -a, and -r, options to 'git branch' do not take a branch name\n"
 				  "Did you mean to use: -a|-r --list <pattern>?"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
+			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
 
 		if (recurse_submodules) {
 			create_branches_recursively(the_repository, branch_name,
-- 
2.42.0.325.g3a06386e31

