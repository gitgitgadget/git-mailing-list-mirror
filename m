Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674221F461
	for <e@80x24.org>; Sat, 18 May 2019 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfERLbC (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 07:31:02 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfERLbC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 07:31:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so4528863pgg.9
        for <git@vger.kernel.org>; Sat, 18 May 2019 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMeD2RMZN7eHU/i8+2ZFrt7TPdurQVsuylDSv3/fc5Q=;
        b=cX/PinX1T1GOJq/G+VcdJ4bys6yRKbRgBs2RFnTnvn75thtrSLCY7sZyGmdV/o6NbC
         KOpdfOLUdqA+JZ2K/QQ2/Vu7arA92pypsh9f0efSOaZI59EXW800/Gwzmg7OC0S9+EXQ
         /QfKUIoc9o9a5Kw6UfKIoRtI+OX7YV1BFraF+ne7NSxj78Mq/owj9cxx3UiMb4ptPgqv
         eU3Y/1uUH6cYIC8oMNTNI9lCB/CAH/xd7+oz8FneV2juj5XN4B2Kw0FnZ8Dnapnp4W5Q
         iipDUyrJJB8UxWacf8KEquIFfhO5WuXizvHp5szqlj6n1XS2to4lXdFEf+JZJJzgQVwS
         6d+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMeD2RMZN7eHU/i8+2ZFrt7TPdurQVsuylDSv3/fc5Q=;
        b=HY8umRRF3RYc/haxQHC6/EX+pFc47Q4QlCiJnOJIuFippQa6eOzui2r8ktHaBYRQvJ
         mkKCBMwjTlpIPUauABDAnqMHCTYDzj3YF26D5FBmYaad/KWJPV261nwLzI6GcYZxc/WK
         Ku8SqQrVHnFcZNx6xGN6KYZ7+CKnIWdx86Wi9As7vgXJ5tJuwKnoISn9zMM5hqe7HxWx
         PYag3mHDWwG3llx/oFP8QBEBaUij/ITMnJlZ5olQViiyp8+HdT+NnPXm9FgClfFyEdXq
         39opcFAgR0RzS2sG2y7l0MDZ2sgi4IK+B4G1dAFjA7TwKPpwr+de55AVUy/ps0TBeoeO
         2zJw==
X-Gm-Message-State: APjAAAU9+PLEk9fHyOtWa3gwFbaxGGOTGsDjhuDrYbzTdrVunWpLqqfI
        qbcV26AGfarze+o8nmNwN70=
X-Google-Smtp-Source: APXvYqxcHPX3LVsNGLj9luj1w5HbN21j0aHOjflDlNrbTEmXhzz9/Lmsc0rIv5P5wICRr7u7icazvg==
X-Received: by 2002:a63:c203:: with SMTP id b3mr32554720pgd.398.1558179061369;
        Sat, 18 May 2019 04:31:01 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id w194sm31082660pfd.56.2019.05.18.04.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 04:31:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 May 2019 18:30:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v4 2/2] merge: add --quit
Date:   Sat, 18 May 2019 18:30:43 +0700
Message-Id: <20190518113043.18389-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190518113043.18389-1-pclouds@gmail.com>
References: <20190514091322.12427-1-pclouds@gmail.com>
 <20190518113043.18389-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows to cancel the current merge without resetting worktree/index,
which is what --abort is for. Like other --quit(s), this is often used
when you forgot that you're in the middle of a merge and already
switched away, doing different things. By the time you've realized, you
can't even continue the merge anymore.

This also makes all in-progress commands, am, merge, rebase, revert and
cherry-pick, take all three --abort, --continue and --quit (bisect has a
different UI).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-merge.txt |  4 ++++
 builtin/merge.c             | 13 +++++++++++++
 t/t7600-merge.sh            | 26 ++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..b7d581fc76 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -99,6 +99,10 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.
 
+--quit::
+	Forget about the current merge in progress. Leave the index
+	and the working tree as-is.
+
 --continue::
 	After a 'git merge' stops due to conflicts you can conclude the
 	merge by running 'git merge --continue' (see "HOW TO RESOLVE
diff --git a/builtin/merge.c b/builtin/merge.c
index e9663f027a..598d56edfe 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -73,6 +73,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int quit_current_merge;
 static int continue_current_merge;
 static int allow_unrelated_histories;
 static int show_progress = -1;
@@ -267,6 +268,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "quit", &quit_current_merge,
+		N_("--abort but leave index and working tree alone")),
 	OPT_BOOL(0, "continue", &continue_current_merge,
 		N_("continue the current in-progress merge")),
 	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
@@ -1252,6 +1255,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
+	if (quit_current_merge) {
+		if (orig_argc != 2)
+			usage_msg_opt(_("--quit expects no arguments"),
+				      builtin_merge_usage,
+				      builtin_merge_options);
+
+		remove_merge_branch_state(the_repository);
+		goto done;
+	}
+
 	if (continue_current_merge) {
 		int nargc = 1;
 		const char *nargv[] = {"commit", NULL};
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..625a24a980 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -822,4 +822,30 @@ test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue'
 	verify_parents $c0 $c1
 '
 
+test_expect_success 'merge --quit' '
+	git init merge-quit &&
+	(
+		cd merge-quit &&
+		test_commit base &&
+		echo one >>base.t &&
+		git commit -am one &&
+		git branch one &&
+		git checkout base &&
+		echo two >>base.t &&
+		git commit -am two &&
+		test_must_fail git -c rerere.enabled=true merge one &&
+		test_path_is_file .git/MERGE_HEAD &&
+		test_path_is_file .git/MERGE_MODE &&
+		test_path_is_file .git/MERGE_MSG &&
+		git rerere status >rerere.before &&
+		git merge --quit &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_path_is_missing .git/MERGE_MODE &&
+		test_path_is_missing .git/MERGE_MSG &&
+		git rerere status >rerere.after &&
+		test_must_be_empty rerere.after &&
+		! test_cmp rerere.after rerere.before
+	)
+'
+
 test_done
-- 
2.22.0.rc0.322.g2b0371e29a

