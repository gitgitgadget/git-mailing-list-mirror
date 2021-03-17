Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20307C43333
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9C564F3B
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhCQU5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbhCQU4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E91C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2110349wmj.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfI+B8c/j/DKBcunMpxpdlUQb8EDU5URlSOD6/hoA1Q=;
        b=kw9j9PZay7493iUddURl+1V02yhUDBorweDfQ6kFy0MCsxBagE7/4/K5GR3azVxMsJ
         h9EiFHpu67BUl9iQFfyiOj5ir5ZVD+u7KGGGoxvRQ9JTok0I2l/fHPesJtFZ7rpxkZUj
         /pwMQrDlLMjKcJJz+AQ9pZGkePduyLAtJQee+bcIAkNxgf4ye4ZTjvA4rdgbKK6h11WW
         wJm7PTZa2JeEeKyDW0wqOerARH/3vs6ieH9ncsXA7/fqCQBi756njhYcckpi1B+CQxY7
         0/5TO6n3cFN3/qYl8isG4Sr5xJBS7I733KFAD11RdmjflO65sTfxdnUz+n4m70WqCCbx
         MQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfI+B8c/j/DKBcunMpxpdlUQb8EDU5URlSOD6/hoA1Q=;
        b=KDkrRSpYZv5ZQjfR8OB2b+JHcC40V5F+SynrPI1jzz8SUvtsxKnWh7y7k/Vkf6lesq
         X5f8nQQjrvo9xIYHq2TWk59YknMlubtwPX1utQRDPP8WCSOIfukchuhgNRTruuAfXm6X
         ojpZvF5jGkVX3KZsy9KNNvpyvhyj6AfpTUwN+auF/9kw8EHLcmtVVK8ROLbaST/NapTn
         E8K0MusW5zhczRf6m9lGV/ghZ6AL1ahQy5JDkkMod3yBm1h61xOIl+iIXc4mBjaAhUbv
         0v0MECtVl9Dx5haWy0E+tY0bu+FoiXoaJjjlQwPkPaXa+PV8dv8WntYsWvmJDihOYaLv
         gUKg==
X-Gm-Message-State: AOAM531XbYkqXe/OxHVcl0iMWteZGYOwTu10v6g6lIT6kdEetyKp+6x0
        M24soIwOYSxn02J9WplPj99MQwPiW5I=
X-Google-Smtp-Source: ABdhPJzV+0eo4WVIEvzwHnEPD2CzG+VaKYV80gCTTF/jTkgT0TFHYY85TK/b9IW+to9aK/AliK1QyQ==
X-Received: by 2002:a1c:f406:: with SMTP id z6mr622018wma.24.1616014602666;
        Wed, 17 Mar 2021 13:56:42 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:42 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 06/15] merge-index: add a new way to invoke `git-merge-one-file'
Date:   Wed, 17 Mar 2021 21:49:30 +0100
Message-Id: <20210317204939.17890-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since `git-merge-one-file' will be rewritten and libified, there may be
cases where there is no executable named this way (ie. when git is
compiled with `SKIP_DASHED_BUILT_INS' enabled).  This adds a new way to
invoke this particular program even if it does not exist, by passing
`--use=merge-one-file' to merge-index.  For now, it still forks.

The test suite and shell scripts (git-merge-octopus.sh and
git-merge-resolve.sh) are updated to use this new convention.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 Documentation/git-merge-index.txt |  7 ++++---
 builtin/merge-index.c             | 25 ++++++++++++++++++++++---
 git-merge-octopus.sh              |  2 +-
 git-merge-resolve.sh              |  2 +-
 t/t6060-merge-index.sh            |  8 ++++----
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 2ab84a91e5..57e7e03b4c 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
+'git merge-index' [-o] [-q] (<merge-program> | --use=merge-one-file) (-a | [--] <file>*)
 
 DESCRIPTION
 -----------
@@ -44,8 +44,9 @@ code.
 Typically this is run with a script calling Git's imitation of
 the 'merge' command from the RCS package.
 
-A sample script called 'git merge-one-file' is included in the
-distribution.
+A sample script called 'git merge-one-file' used to be included in the
+distribution. This program must now be called with
+'--use=merge-one-file'.
 
 ALERT ALERT ALERT! The Git "merge object order" is different from the
 RCS 'merge' program merge object order. In the above ordering, the
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 49ddf3f9cd..fd5b1a5a92 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "lockfile.h"
 #include "merge-strategies.h"
 #include "run-command.h"
 
@@ -37,7 +38,10 @@ static int merge_one_file_spawn(struct index_state *istate,
 int cmd_merge_index(int argc, const char **argv, const char *prefix)
 {
 	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
+	merge_fn merge_action = merge_one_file_spawn;
+	struct lock_file lock = LOCK_INIT;
 	struct repository *r = the_repository;
+	const char *use_internal = NULL;
 
 	/* Without this we cannot rely on waitpid() to tell
 	 * what happened to our children.
@@ -45,7 +49,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage("git merge-index [-o] [-q] (<merge-program> | --use=merge-one-file) (-a | [--] [<filename>...])");
 
 	if (repo_read_index(r) < 0)
 		die("invalid index");
@@ -61,6 +65,14 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	}
 
 	pgm = argv[i++];
+	setup_work_tree();
+
+	if (skip_prefix(pgm, "--use=", &use_internal)) {
+		if (!strcmp(use_internal, "merge-one-file"))
+			pgm = "git-merge-one-file";
+		else
+			die(_("git merge-index: unknown internal program %s"), use_internal);
+	}
 
 	for (; i < argc; i++) {
 		const char *arg = argv[i];
@@ -71,13 +83,20 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "-a")) {
 				err |= merge_all_index(r->index, one_shot, quiet,
-						       merge_one_file_spawn, NULL);
+						       merge_action, NULL);
 				continue;
 			}
 			die("git merge-index: unknown option %s", arg);
 		}
 		err |= merge_index_path(r->index, one_shot, quiet, arg,
-					merge_one_file_spawn, NULL);
+					merge_action, NULL);
+	}
+
+	if (is_lock_file_locked(&lock)) {
+		if (err)
+			rollback_lock_file(&lock);
+		else
+			return write_locked_index(r->index, &lock, COMMIT_LOCK);
 	}
 
 	return err;
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 7d19d37951..2770891960 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -100,7 +100,7 @@ do
 	if test $? -ne 0
 	then
 		gettextln "Simple merge did not work, trying automatic merge."
-		git merge-index -o git-merge-one-file -a ||
+		git merge-index -o --use=merge-one-file -a ||
 		OCTOPUS_FAILURE=1
 		next=$(git write-tree 2>/dev/null)
 	fi
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index 343fe7bccd..0b4fc88b61 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -45,7 +45,7 @@ then
 	exit 0
 else
 	echo "Simple merge failed, trying Automatic merge."
-	if git merge-index -o git-merge-one-file -a
+	if git merge-index -o --use=merge-one-file -a
 	then
 		exit 0
 	else
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 0cbd8a1f7f..d0cdfeddc1 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -50,8 +50,8 @@ test_expect_success 'read-tree does not resolve content merge' '
 	test_cmp expect unmerged
 '
 
-test_expect_success 'git merge-index git-merge-one-file resolves' '
-	git merge-index git-merge-one-file -a &&
+test_expect_success 'git merge-index --use=merge-one-file resolves' '
+	git merge-index --use=merge-one-file -a &&
 	git diff-files --name-only --diff-filter=U >unmerged &&
 	test_must_be_empty unmerged &&
 	test_cmp expect-merged file &&
@@ -83,7 +83,7 @@ test_expect_success 'merge-one-file respects GIT_WORK_TREE' '
 	 export GIT_WORK_TREE &&
 	 GIT_INDEX_FILE=$PWD/merge.index &&
 	 export GIT_INDEX_FILE &&
-	 git merge-index git-merge-one-file -a &&
+	 git merge-index --use=merge-one-file -a &&
 	 git cat-file blob :file >work/file-index
 	) &&
 	test_cmp expect-merged bare.git/work/file &&
@@ -98,7 +98,7 @@ test_expect_success 'merge-one-file respects core.worktree' '
 	 export GIT_DIR &&
 	 git config core.worktree "$PWD/child" &&
 	 git read-tree -i -m base ten two &&
-	 git merge-index git-merge-one-file -a &&
+	 git merge-index --use=merge-one-file -a &&
 	 git cat-file blob :file >file-index
 	) &&
 	test_cmp expect-merged subdir/child/file &&
-- 
2.31.0

