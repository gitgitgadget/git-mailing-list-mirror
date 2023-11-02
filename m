Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBF1B274
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpR9G2LE"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39178A6
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d849cc152so583250f8f.1
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933131; x=1699537931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCTfbpJ9YSQELTO6bIbyTJdoRXU5Hj3snN1UMYp4gUA=;
        b=SpR9G2LEv4QciYHhRughv7d6sfawd3mGD88M0EfE6YFzcn6WdvWbvjvQ2cOE0999cV
         E+soiZZWAUfPUr5HsLXYrRKtZJI0JyGbpSbuUBxXThDxw78d7YM2thEFAJnFjRzUPha1
         oUUliEeP7cGBaBVluAVnwjDUhRqUvgTofwnRpBedTanfys8WIlaSlkzV0l2rcxZAhtDU
         XXj99C6S5gpYB67ztPo7S0/2XGyn5ggFHT9CBtjF4P+QRJhHlh24abkhJ6YGMY1OZx/o
         1uX5VDMPkWPlU3oDWiHvCICvo1yHw7D4dFQ/W2mW4ooyVx1Azrw9xh379LrKW9i284oI
         ot4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933131; x=1699537931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCTfbpJ9YSQELTO6bIbyTJdoRXU5Hj3snN1UMYp4gUA=;
        b=wZoaqcg8wzXTPGZddMUb8CKrE1ZySVNdgiYq5N9wT0VtNDtUaccCjLKKRUwyjrPfTH
         icabhsiyR87iq50eRxal7Ber32Ab0mRtGoHNUQI+1+dbXXD6EjEA+j95AYNQXvJgekzP
         xhDVLH2yNudPEuFp1Qimqbn+jD1xDstXKg9ppqVcziZcRzUz9ZM7y1qqk7pkf2Hj/Zqx
         99hLtBqbhLXevPKWp1mU/2ZLqQpqm9sxyC3NSx/MJGNMlLgV0pX4zc+e1+y8SrGLE8Ke
         Rv0P75mgRhHbyoXCl3FwVYJ9VD747GcoVG/xp0dF8Q6epL2lsOQOpAcHG0tKoUpu42eF
         AziA==
X-Gm-Message-State: AOJu0YyX2uakuz4MI4/1EderzzOpUDXwOq/H0uZrvZNnSPQV7WkQOIpg
	P9LmOrhWZ235q9osn6crKZS6xGQfXII=
X-Google-Smtp-Source: AGHT+IEFINqRgV5PA1Nx6hh/Hf3auWCHrGz0TVcRsb+6X4B1gqH3hDZZ9ArkLbCqZyAezji0RKGn3Q==
X-Received: by 2002:a05:6000:1882:b0:32f:7f03:9a with SMTP id a2-20020a056000188200b0032f7f03009amr12145143wri.55.1698933131385;
        Thu, 02 Nov 2023 06:52:11 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:09 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 02/14] replay: introduce new builtin
Date: Thu,  2 Nov 2023 14:51:39 +0100
Message-ID: <20231102135151.843758-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

For now, this is just a rename from `t/helper/test-fast-rebase.c` into
`builtin/replay.c` with minimal changes to make it build appropriately.

Let's add a stub documentation and a stub test script though.

Subsequent commits will flesh out the capabilities of the new command
and make it a more standard regular builtin.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore                                    |  1 +
 Documentation/git-replay.txt                  | 38 ++++++++++++
 Makefile                                      |  2 +-
 builtin.h                                     |  1 +
 .../test-fast-rebase.c => builtin/replay.c    | 29 +++------
 command-list.txt                              |  1 +
 git.c                                         |  1 +
 t/helper/test-tool.c                          |  1 -
 t/helper/test-tool.h                          |  1 -
 t/t3650-replay-basics.sh                      | 60 +++++++++++++++++++
 t/t6429-merge-sequence-rename-caching.sh      | 27 +++------
 11 files changed, 121 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 rename t/helper/test-fast-rebase.c => builtin/replay.c (87%)
 create mode 100755 t/t3650-replay-basics.sh

diff --git a/.gitignore b/.gitignore
index 5e56e471b3..612c0f6a0f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -135,6 +135,7 @@
 /git-remote-ext
 /git-repack
 /git-replace
+/git-replay
 /git-request-pull
 /git-rerere
 /git-reset
diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
new file mode 100644
index 0000000000..44bf584fed
--- /dev/null
+++ b/Documentation/git-replay.txt
@@ -0,0 +1,38 @@
+git-replay(1)
+=============
+
+NAME
+----
+git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos too
+
+
+SYNOPSIS
+--------
+[verse]
+'git replay' --onto <newbase> <oldbase> <branch> # EXPERIMENTAL
+
+DESCRIPTION
+-----------
+
+Takes a range of commits and replays them onto a new location.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+OPTIONS
+-------
+
+--onto <newbase>::
+	Starting point at which to create the new commits.  May be any
+	valid commit, and not just an existing branch name.
+
+EXIT STATUS
+-----------
+
+For a successful, non-conflicted replay, the exit status is 0.  When
+the replay has conflicts, the exit status is 1.  If the replay is not
+able to complete (or start) due to some kind of error, the exit status
+is something other than 0 or 1.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 03adcb5a48..3834bc1544 100644
--- a/Makefile
+++ b/Makefile
@@ -799,7 +799,6 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-env-helper.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
-TEST_BUILTINS_OBJS += test-fast-rebase.o
 TEST_BUILTINS_OBJS += test-find-pack.o
 TEST_BUILTINS_OBJS += test-fsmonitor-client.o
 TEST_BUILTINS_OBJS += test-genrandom.o
@@ -1290,6 +1289,7 @@ BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/repack.o
 BUILTIN_OBJS += builtin/replace.o
+BUILTIN_OBJS += builtin/replay.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index d560baa661..28280636da 100644
--- a/builtin.h
+++ b/builtin.h
@@ -211,6 +211,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
 int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 int cmd_repack(int argc, const char **argv, const char *prefix);
+int cmd_replay(int argc, const char **argv, const char *prefix);
 int cmd_rerere(int argc, const char **argv, const char *prefix);
 int cmd_reset(int argc, const char **argv, const char *prefix);
 int cmd_restore(int argc, const char **argv, const char *prefix);
diff --git a/t/helper/test-fast-rebase.c b/builtin/replay.c
similarity index 87%
rename from t/helper/test-fast-rebase.c
rename to builtin/replay.c
index 2bfab66b1b..f2d8444417 100644
--- a/t/helper/test-fast-rebase.c
+++ b/builtin/replay.c
@@ -1,17 +1,11 @@
 /*
- * "git fast-rebase" builtin command
- *
- * FAST: Forking Any Subprocesses (is) Taboo
- *
- * This is meant SOLELY as a demo of what is possible.  sequencer.c and
- * rebase.c should be refactored to use the ideas here, rather than attempting
- * to extend this file to replace those (unless Phillip or Dscho say that
- * refactoring is too hard and we need a clean slate, but I'm guessing that
- * refactoring is the better route).
+ * "git replay" builtin command
  */
 
 #define USE_THE_INDEX_VARIABLE
-#include "test-tool.h"
+#include "git-compat-util.h"
+
+#include "builtin.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "environment.h"
@@ -27,7 +21,8 @@
 #include "sequencer.h"
 #include "setup.h"
 #include "strvec.h"
-#include "tree.h"
+#include <oidset.h>
+#include <tree.h>
 
 static const char *short_commit_name(struct commit *commit)
 {
@@ -94,7 +89,7 @@ static struct commit *create_commit(struct tree *tree,
 	return (struct commit *)obj;
 }
 
-int cmd__fast_rebase(int argc, const char **argv)
+int cmd_replay(int argc, const char **argv, const char *prefix)
 {
 	struct commit *onto;
 	struct commit *last_commit = NULL, *last_picked_commit = NULL;
@@ -110,14 +105,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	struct strbuf branch_name = STRBUF_INIT;
 	int ret = 0;
 
-	/*
-	 * test-tool stuff doesn't set up the git directory by default; need to
-	 * do that manually.
-	 */
-	setup_git_directory();
-
 	if (argc == 2 && !strcmp(argv[1], "-h")) {
-		printf("Sorry, I am not a psychiatrist; I can not give you the help you need.  Oh, you meant usage...\n");
+		printf("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL\n");
 		exit(129);
 	}
 
@@ -136,7 +125,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (repo_read_index(the_repository) < 0)
 		BUG("Could not read index");
 
-	repo_init_revisions(the_repository, &revs, NULL);
+	repo_init_revisions(the_repository, &revs, prefix);
 	revs.verbose_header = 1;
 	revs.max_parents = 1;
 	revs.cherry_mark = 1;
diff --git a/command-list.txt b/command-list.txt
index 54b2a50f5f..c4cd0f352b 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -160,6 +160,7 @@ git-reflog                              ancillarymanipulators           complete
 git-remote                              ancillarymanipulators           complete
 git-repack                              ancillarymanipulators           complete
 git-replace                             ancillarymanipulators           complete
+git-replay                              plumbingmanipulators
 git-request-pull                        foreignscminterface             complete
 git-rerere                              ancillaryinterrogators
 git-reset                               mainporcelain           history
diff --git a/git.c b/git.c
index c67e44dd82..7068a184b0 100644
--- a/git.c
+++ b/git.c
@@ -594,6 +594,7 @@ static struct cmd_struct commands[] = {
 	{ "remote-fd", cmd_remote_fd, NO_PARSEOPT },
 	{ "repack", cmd_repack, RUN_SETUP },
 	{ "replace", cmd_replace, RUN_SETUP },
+	{ "replay", cmd_replay, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
 	{ "restore", cmd_restore, RUN_SETUP | NEED_WORK_TREE },
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 876cd2dc31..37ba996539 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -30,7 +30,6 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "env-helper", cmd__env_helper },
 	{ "example-decorate", cmd__example_decorate },
-	{ "fast-rebase", cmd__fast_rebase },
 	{ "find-pack", cmd__find_pack },
 	{ "fsmonitor-client", cmd__fsmonitor_client },
 	{ "genrandom", cmd__genrandom },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 70dd4eba11..8a1a7c63da 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -24,7 +24,6 @@ int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__dump_reftable(int argc, const char **argv);
 int cmd__env_helper(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
-int cmd__fast_rebase(int argc, const char **argv);
 int cmd__find_pack(int argc, const char **argv);
 int cmd__fsmonitor_client(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
new file mode 100755
index 0000000000..36c1b5082a
--- /dev/null
+++ b/t/t3650-replay-basics.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='basic git replay tests'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+GIT_AUTHOR_NAME=author@name
+GIT_AUTHOR_EMAIL=bogus@email@address
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+
+	git switch -c topic1 &&
+	test_commit C &&
+	git switch -c topic2 &&
+	test_commit D &&
+	test_commit E &&
+	git switch topic1 &&
+	test_commit F &&
+	git switch -c topic3 &&
+	test_commit G &&
+	test_commit H &&
+	git switch -c topic4 main &&
+	test_commit I &&
+	test_commit J &&
+
+	git switch -c next main &&
+	test_commit K &&
+	git merge -m "Merge topic1" topic1 &&
+	git merge -m "Merge topic2" topic2 &&
+	git merge -m "Merge topic3" topic3 &&
+	>evil &&
+	git add evil &&
+	git commit --amend &&
+	git merge -m "Merge topic4" topic4 &&
+
+	git switch main &&
+	test_commit L &&
+	test_commit M &&
+
+	git switch -c conflict B &&
+	test_commit C.conflict C.t conflict
+'
+
+test_expect_success 'using replay to rebase two branches, one on top of other' '
+	git switch main &&
+
+	git replay --onto main topic1 topic2 >result &&
+
+	git log --format=%s $(cut -f 3 -d " " result) >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 75d3fd2dba..7670b72008 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -71,9 +71,8 @@ test_expect_success 'caching renames does not preclude finding new ones' '
 
 		git switch upstream &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream~1..topic
 
 		git ls-files >tracked-files &&
 		test_line_count = 2 tracked-files &&
@@ -141,8 +140,7 @@ test_expect_success 'cherry-pick both a commit and its immediate revert' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
-		#git cherry-pick upstream~1..topic &&
+		git replay --onto HEAD upstream~1 topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls
@@ -200,9 +198,8 @@ test_expect_success 'rename same file identically, then reintroduce it' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 2 tracked &&
@@ -278,9 +275,8 @@ test_expect_success 'rename same file identically, then add file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream~1..topic &&
 
 		git ls-files >tracked &&
 		test_line_count = 4 tracked &&
@@ -356,8 +352,7 @@ test_expect_success 'cached dir rename does not prevent noticing later conflict'
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test_must_fail test-tool fast-rebase --onto HEAD upstream~1 topic >output &&
-		#git cherry-pick upstream..topic &&
+		test_must_fail git replay --onto HEAD upstream~1 topic >output &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls
@@ -456,9 +451,8 @@ test_expect_success 'dir rename unneeded, then add new file to old dir' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
@@ -523,9 +517,8 @@ test_expect_success 'dir rename unneeded, then rename existing file into old dir
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 3 calls &&
@@ -626,9 +619,8 @@ test_expect_success 'caching renames only on upstream side, part 1' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 1 calls &&
@@ -685,9 +677,8 @@ test_expect_success 'caching renames only on upstream side, part 2' '
 		GIT_TRACE2_PERF="$(pwd)/trace.output" &&
 		export GIT_TRACE2_PERF &&
 
-		test-tool fast-rebase --onto HEAD upstream~1 topic &&
+		git replay --onto HEAD upstream~1 topic &&
 		git reset --hard topic &&
-		#git cherry-pick upstream..topic &&
 
 		grep region_enter.*diffcore_rename trace.output >calls &&
 		test_line_count = 2 calls &&
-- 
2.42.0.496.g529a7fda40

