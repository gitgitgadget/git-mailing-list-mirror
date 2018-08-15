Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10AAB1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeHOTQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:16:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37775 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHOTQC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:16:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id j8-v6so1281867lfb.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1U3JI51tw6ikbAtaCUXFMMkeks1CGZMkuv4nz0AJlsc=;
        b=VwnOXP2CRr39X+NbhZXhgrQ+0QqfMzayVBbYOY+TXKGb6q+lo+u28gXGGYeZb8fMdx
         hTkTsjZcKHU/KCQkk1hLTisZrjSCjYAhFvUCEKSjZSajUNHrYBI+4rAs/gksM8X3P+ko
         WdjqwiCEKkNdF18qzB3SxqeeC7VLOqb6wCaS5m9SaPaeqnOHxEoi/y80T2WlzNrluUq/
         Uzp+Tw/1kJNs6QnpQD0XF+7k3sCclQuzgSO5Y1IkuNBNZzZkUaXiyuCmpu6JL+G9pGEa
         oxsvHNvM0NdP1CKcf3wRBdmxM12w9BuWbYRnUNQ8oiPioV4v2fqNLWExElN+nmNXDsb1
         XsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1U3JI51tw6ikbAtaCUXFMMkeks1CGZMkuv4nz0AJlsc=;
        b=UDeLb2qRWMfHrVInvHG9IfMtsppcPogIKSbozBGbWP5EvpgFf8GLNYtrEDkVNvMp39
         yno9BKXkar/ccCVVGrwkPkgya+OvNp4YAYvDDpVrqtfg6IE4yb3CzxzO6A9SbmpC+iEv
         tTKqieFEMVL+KhAgvjk7A+QKVws9kTyGsF7TA8PsWSti2R1YYKNBdve6aZtb/H78fOxD
         588LQZTjaPKiwgkN38tu8Wq0HfDLCpFqSaeymXMu2XNdFUsS5IseVvLp9BFvxrIDWOz4
         yh+94l5hvV4r81ipZ27qub+rK24GXLcDOYhdJNUsclHbmcUunDTJzz/pIOIcJog/agGv
         C73A==
X-Gm-Message-State: AOUpUlETm6BcR5z0JVPwgBoksPyt93Wz39dSSZIs4SsBKceFjc4aNr2m
        l+qeD3BswhzhjuvqKJW4ahYJNtVr
X-Google-Smtp-Source: AA+uWPzu43CWjiim/vnmdSiHR7qAAU3sdAH3UYmrLJ2RJbg+oHDi39sH+aIh9AOipJB3fW5h/BsXsA==
X-Received: by 2002:a19:b598:: with SMTP id g24-v6mr16689462lfk.129.1534350191829;
        Wed, 15 Aug 2018 09:23:11 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h9-v6sm4501354lfc.47.2018.08.15.09.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 09:23:10 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/2] branch.c: remove explicit reference to the_repository
Date:   Wed, 15 Aug 2018 18:23:07 +0200
Message-Id: <20180815162308.17747-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c           | 22 ++++++++++++----------
 branch.h           |  7 +++++--
 builtin/am.c       |  2 +-
 builtin/branch.c   |  6 ++++--
 builtin/checkout.c |  5 +++--
 builtin/reset.c    |  2 +-
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/branch.c b/branch.c
index ecd710d730..0baa1f6877 100644
--- a/branch.c
+++ b/branch.c
@@ -244,7 +244,8 @@ N_("\n"
 "will track its remote counterpart, you may want to use\n"
 "\"git push -u\" to set the upstream config as you push.");
 
-void create_branch(const char *name, const char *start_name,
+void create_branch(struct repository *repo,
+		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok, int reflog,
 		   int quiet, enum branch_track track)
 {
@@ -302,7 +303,8 @@ void create_branch(const char *name, const char *start_name,
 		break;
 	}
 
-	if ((commit = lookup_commit_reference(the_repository, &oid)) == NULL)
+	commit = lookup_commit_reference(repo, &oid);
+	if (!commit)
 		die(_("Not a valid branch point: '%s'."), start_name);
 	oidcpy(&oid, &commit->object.oid);
 
@@ -338,15 +340,15 @@ void create_branch(const char *name, const char *start_name,
 	free(real_ref);
 }
 
-void remove_branch_state(void)
+void remove_branch_state(struct repository *repo)
 {
-	unlink(git_path_cherry_pick_head(the_repository));
-	unlink(git_path_revert_head(the_repository));
-	unlink(git_path_merge_head(the_repository));
-	unlink(git_path_merge_rr(the_repository));
-	unlink(git_path_merge_msg(the_repository));
-	unlink(git_path_merge_mode(the_repository));
-	unlink(git_path_squash_msg(the_repository));
+	unlink(git_path_cherry_pick_head(repo));
+	unlink(git_path_revert_head(repo));
+	unlink(git_path_merge_head(repo));
+	unlink(git_path_merge_rr(repo));
+	unlink(git_path_merge_msg(repo));
+	unlink(git_path_merge_mode(repo));
+	unlink(git_path_squash_msg(repo));
 }
 
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
diff --git a/branch.h b/branch.h
index 473d0a93e9..14d8282927 100644
--- a/branch.h
+++ b/branch.h
@@ -3,6 +3,8 @@
 
 /* Functions for acting on the information about branches. */
 
+struct repository;
+
 /*
  * Creates a new branch, where:
  *
@@ -24,7 +26,8 @@
  *     that start_name is a tracking branch for (if any).
  *
  */
-void create_branch(const char *name, const char *start_name,
+void create_branch(struct repository *repo,
+		   const char *name, const char *start_name,
 		   int force, int clobber_head_ok,
 		   int reflog, int quiet, enum branch_track track);
 
@@ -47,7 +50,7 @@ extern int validate_new_branchname(const char *name, struct strbuf *ref, int for
  * Remove information about the state of working on the current
  * branch. (E.g., MERGE_HEAD)
  */
-void remove_branch_state(void);
+void remove_branch_state(struct repository *);
 
 /*
  * Configure local branch "local" as downstream to branch "remote"
diff --git a/builtin/am.c b/builtin/am.c
index 2c19e69f58..7abe39939e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2017,7 +2017,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 	if (merge_tree(remote_tree))
 		return -1;
 
-	remove_branch_state();
+	remove_branch_state(the_repository);
 
 	return 0;
 }
diff --git a/builtin/branch.c b/builtin/branch.c
index 4fc55c3508..e04d528ce1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -795,7 +795,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		 * create_branch takes care of setting up the tracking
 		 * info and making sure new_upstream is correct
 		 */
-		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
+		create_branch(the_repository, branch->name, new_upstream,
+			      0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
 	} else if (unset_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 		struct strbuf buf = STRBUF_INIT;
@@ -831,7 +832,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (track == BRANCH_TRACK_OVERRIDE)
 			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
-		create_branch(argv[0], (argc == 2) ? argv[1] : head,
+		create_branch(the_repository,
+			      argv[0], (argc == 2) ? argv[1] : head,
 			      force, 0, reflog, quiet, track);
 
 	} else
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 516136a23a..4756018272 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -653,7 +653,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			free(refname);
 		}
 		else
-			create_branch(opts->new_branch, new_branch_info->name,
+			create_branch(the_repository,
+				      opts->new_branch, new_branch_info->name,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_force ? 1 : 0,
 				      opts->new_branch_log,
@@ -711,7 +712,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 				delete_reflog(old_branch_info->path);
 		}
 	}
-	remove_branch_state();
+	remove_branch_state(the_repository);
 	strbuf_release(&msg);
 	if (!opts->quiet &&
 	    (new_branch_info->path || (!opts->force_detach && !strcmp(new_branch_info->name, "HEAD"))))
diff --git a/builtin/reset.c b/builtin/reset.c
index 11cd0dcb8c..d90ccdb839 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -399,7 +399,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 			print_new_head_line(lookup_commit_reference(the_repository, &oid));
 	}
 	if (!pathspec.nr)
-		remove_branch_state();
+		remove_branch_state(the_repository);
 
 	return update_ref_status;
 }
-- 
2.18.0.1004.g6639190530

