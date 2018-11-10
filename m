Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C051F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbeKJPdW (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42777 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbeKJPdT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id q6-v6so2821069lfh.9
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9htDdsWDZDiEaeKbe45iy/qBCmpsA+DFW8jAifv3hc=;
        b=oE6YNRjlt1e+2KcaG278AoPW5zBgWB5t466Ol1tjOtHu/8ySKDpOYCCEQAdb2hKlIE
         FE6TQ/La1TtoS2/+iUpXIRRxdhANHA8KJ0PoLdN+kjeQNFsVEuYjCgQTZsxxlMqAlmym
         yn+IXaBFj9D0ou97Mch6x1h77xMS3Foiec+HMxefhmyCWDlyE7yRrlyX63lREByQddNg
         TL2f+VKL8GuNxDjkJmv3x+yHm9jPSN+OGjKSvo9o4DufRXMJYyuGOn52hWffH+f9SQee
         vVyVZRQZYRHNmUnn6sVaCBmn6VL03BrkRK4ZpotBLNFpne+et4viUJWFr4bwD/5Nzj0E
         Qtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9htDdsWDZDiEaeKbe45iy/qBCmpsA+DFW8jAifv3hc=;
        b=q3Z3jCXh/hfcy51QaxzjS2KXa+NPdhQgObT/MGnTv1zsf+tgFEeAkOZC0F4a5u7BXS
         3HHoqoXtEnaNpZfRLtqrNVU7qpHklYUbumTZLWwrw3VySuEv6uLSKUdQKeUg9qSy7fzn
         nG8QR05GhfHjmQtdMx5NHq8tIyNzUmETxIGtXuybwMk3ZaAs0usJ55YDmZaI0E/fpsnr
         fdeYRo8wjKsC2EP9horaduUpmr02rQlF+kvPqdBu/wJXLRTDTzYcKySPZXRi6q+Uz3Pt
         WCPL0d7iJtV+MzNzCpDUA2Q7LoYt/c9QxJ0M11TfkHNQs8tpTjtpGWdNE5/ugduOhtAw
         CP9Q==
X-Gm-Message-State: AGRZ1gJ1z45K7XUgO1eaOA+6z7g9J7gBqFAHi3xnBDEjehstwMNpCaDQ
        D7TVsU0jn632CGUVkWsDQSIv5oU6
X-Google-Smtp-Source: AJdET5fFVxDzO0gfzpBndYaxUPdEGfdW5XqMjPX1mfXaekdOJWpgPw3WaT/+50qLqda7uxUZ6gUezg==
X-Received: by 2002:a19:660a:: with SMTP id a10-v6mr6958888lfc.100.1541828972128;
        Fri, 09 Nov 2018 21:49:32 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:31 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/22] branch.c: remove the_repository reference
Date:   Sat, 10 Nov 2018 06:49:00 +0100
Message-Id: <20181110054910.10568-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c           | 21 +++++++++++----------
 branch.h           |  8 ++++++--
 builtin/am.c       |  2 +-
 builtin/branch.c   |  6 ++++--
 builtin/checkout.c |  5 +++--
 builtin/reset.c    |  2 +-
 builtin/revert.c   |  2 +-
 7 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/branch.c b/branch.c
index 776f55fc66..28b81a7e02 100644
--- a/branch.c
+++ b/branch.c
@@ -242,7 +242,8 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(const char *name, const char *start_name,
+void create_branch(struct repository *r,
+		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok, int reflog,
 		   int quiet, enum branch_track track)
 {
@@ -300,7 +301,7 @@ void create_branch(const char *name, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(the_repository, &oid)) == NULL)
+	if ((commit = lookup_commit_reference(r, &oid)) == NULL)
 		die(_("Not a valid branch point: '%s'."), start_name);
 	oidcpy(&oid, &commit->object.oid);
 
@@ -336,15 +337,15 @@ void create_branch(const char *name, const char *start_name,
 	free(real_ref);
 }
 
-void remove_branch_state(void)
+void remove_branch_state(struct repository *r)
 {
-	unlink(git_path_cherry_pick_head(the_repository));
-	unlink(git_path_revert_head(the_repository));
-	unlink(git_path_merge_head(the_repository));
-	unlink(git_path_merge_rr(the_repository));
-	unlink(git_path_merge_msg(the_repository));
-	unlink(git_path_merge_mode(the_repository));
-	unlink(git_path_squash_msg(the_repository));
+	unlink(git_path_cherry_pick_head(r));
+	unlink(git_path_revert_head(r));
+	unlink(git_path_merge_head(r));
+	unlink(git_path_merge_rr(r));
+	unlink(git_path_merge_msg(r));
+	unlink(git_path_merge_mode(r));
+	unlink(git_path_squash_msg(r));
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index 5cace4581f..29c1afa4d0 100644
--- a/branch.h
+++ b/branch.h
@@ -1,6 +1,7 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+struct repository;
 struct strbuf;
 
 enum branch_track {
@@ -19,6 +20,8 @@ extern enum branch_track git_branch_track;
 /*
  * Creates a new branch, where:
  *
+ *   - r is the repository to add a branch to
+ *
  *   - name is the new branch name
  *
  *   - start_name is the name of the existing branch that the new branch should
@@ -37,7 +40,8 @@ extern enum branch_track git_branch_track;
  *     that start_name is a tracking branch for (if any).
  *
  */
-void create_branch(const char *name, const char *start_name,
+void create_branch(struct repository *r,
+		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok,
 		   int reflog, int quiet, enum branch_track track);
 
@@ -60,7 +64,7 @@ extern int validate_new_branchname(const char *name, struct strbuf *ref, int for
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
-void remove_branch_state(void);
+void remove_branch_state(struct repository *r);
 
 /*
  * Configure local branch "local" as downstream to branch "remote"
diff --git a/builtin/am.c b/builtin/am.c
index 3ee9a9d2a9..232f3962d7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2022,7 +2022,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (merge_tree(remote_tree))
 		return -1;
 
-	remove_branch_state();
+	remove_branch_state(the_repository);
 
 	return 0;
 }
diff --git a/builtin/branch.c b/builtin/branch.c
index 0c55f7f065..1be727209b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -783,7 +783,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * create_branch takes care of setting up the tracking
 		 * info and making sure new_upstream is correct
 		 */
-		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		create_branch(the_repository, branch->name, new_upstream,
+			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
@@ -814,7 +815,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
-		create_branch(argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(the_repository,
+			      argv[0], (argc == 2) ? argv[1] : head,
 			      force, 0, reflog, quiet, track);
 
 	} else
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..169e797675 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -753,7 +753,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			free(refname);
 		}
 		else
-			create_branch(opts->new_branch, new_branch_info->name,
+			create_branch(the_repository,
+				      opts->new_branch, new_branch_info->name,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
@@ -811,7 +812,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				delete_reflog(old_branch_info->path);
 		}
 	}
-	remove_branch_state();
+	remove_branch_state(the_repository);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
diff --git a/builtin/reset.c b/builtin/reset.c
index 6d37a35e2e..5b4bbb0fb5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -400,7 +400,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
 	if (!pathspec.nr)
-		remove_branch_state();
+		remove_branch_state(the_repository);
 
 	return update_ref_status;
 }
diff --git a/builtin/revert.c b/builtin/revert.c
index 1fa75b2773..df662d4324 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -195,7 +195,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (cmd == 'q') {
 		int ret = sequencer_remove_state(opts);
 		if (!ret)
-			remove_branch_state();
+			remove_branch_state(the_repository);
 		return ret;
 	}
 	if (cmd == 'c')
-- 
2.19.1.1231.g84aef82467

