Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE651F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeGDWNU (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 18:13:20 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42871 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeGDWNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 18:13:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id n84-v6so13116124oib.9
        for <git@vger.kernel.org>; Wed, 04 Jul 2018 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zaiJ5I/LKxHKYuDxw2Hk+KLqodA4oD0mQAIbuTO0aT0=;
        b=WezlBs8obmeqwVGksFWSXw5Xx9CRt6weBHB9jDZ54I1M46qtkHJOmUTzjhCmgNt7tL
         jxC085M+asIkYuIxKZI6klBBaNbIY1hyzTBdHR7SFGpWT3SOzjb3ow2i6QxzyjbtADz/
         bRCo4ZQuMG4S4guzi9r+x4wrxB9q15QFMZW4DOMTLdaKJB/GVTSwVICBF3vjaRD6DB/v
         4kCSo8MjEDnPt+9AcytDh4vIEoJqy8rYrPitLYmkYon5AqHk6J8CY5ydaxTHKQNBH7Y2
         yEF5zvc8GBvSxgdzUwQqvRp+gE34yrynGgUaBdod2k7TF4dL2JmFNBnXh5LMTN88D7TC
         qjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zaiJ5I/LKxHKYuDxw2Hk+KLqodA4oD0mQAIbuTO0aT0=;
        b=Wx5y2T9InILml7z3WhBcDiKL1Id8fm28W5eZQAxCSuVTZ2ms5hJ/UyXnmxuyYIq2AO
         oteRrPSrGch6RFGNO65u0eb+18CWGLG0w9o27l3HavcXEjDM/6W8yE+CIKebqXOXqcZm
         5eO1fCkmdytbPI7TEp9fXqL61GFDHCrHag+6qYg7e3EBblO5DsO6JPLSttrVHot6Z2OK
         LXIWESjgTja4/rELL7hll6YA2GlY30onUEQYqMV40lD8gsNmomXvXdqTwJuAvWygiW+g
         iqHjxuA/xk2Ghf/JNu7cR6b8I9i6DZsYb9iJeycnXcIXoFUDZEW4Cc7L1GHsPWzJSo92
         2Hzg==
X-Gm-Message-State: APt69E2Q/7rslXlzhrxyOm7FCjfwjA6k6IMWj5WsApdeW4hSUBylr8Ty
        FgNRklII7gr9DEi+YTvnmh8AbA==
X-Google-Smtp-Source: AAOMgpdCRCPkrzJHQdnHRupFDpruw383RINmVVvC9qv5bgGI1zsxMzqMAleHcb9dYF4/9Qjnh5O1Lg==
X-Received: by 2002:aca:3e84:: with SMTP id l126-v6mr4083075oia.231.1530742398413;
        Wed, 04 Jul 2018 15:13:18 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id l133-v6sm2704870oif.48.2018.07.04.15.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 15:13:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH] t6036: add lots of detail for directory/file conflicts in recursive case
Date:   Wed,  4 Jul 2018 15:13:11 -0700
Message-Id: <20180704221311.11004-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.131.g7487c9a82.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was a discussion of problematic directory/file conflicts with
virtual merge bases on the mailing list years ago at
  https://public-inbox.org/git/AANLkTimwUQafGDrjxWrfU9uY1uKoFLJhxYs=vssOPqdf@mail.gmail.com/
Part of these corresponding tests made it into this testsuite.  However,
the more problematic one didn't.  And there are others that showcase the
problems even more.  Add a very lengthy explanation, some of it from that
email, describing the tradeoffs in picking a recursive merge-base when
you're dealing with an add/add directory/file conflict.

The solution picked years ago is relatively good, but there is the
potential to do even better, assuming we're willing to pay a certain
performance cost.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 256 +++++++++++++++++++++++-------
 1 file changed, 201 insertions(+), 55 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b5621303d..74e5920bc 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -345,40 +345,97 @@ test_expect_success 'git detects conflict merging criss-cross+modify/delete, rev
 	)
 '
 
+#      SORRY FOR THE SUPER LONG DESCRIPTION, BUT THIS NEXT ONE IS HAIRY
 #
 # criss-cross + d/f conflict via add/add:
 #   Commit A: Neither file 'a' nor directory 'a/' exists.
 #   Commit B: Introduce 'a'
 #   Commit C: Introduce 'a/file'
-#   Commit D: Merge B & C, keeping 'a' and deleting 'a/'
-#
-# Two different later cases:
+#   Commit D1: Merge B & C, keeping 'a'    and deleting 'a/'
 #   Commit E1: Merge B & C, deleting 'a' but keeping 'a/file'
-#   Commit E2: Merge B & C, deleting 'a' but keeping a slightly modified 'a/file'
 #
-#      B   D
+#      B   D1 or D2
 #      o---o
 #     / \ / \
 #  A o   X   ? F
 #     \ / \ /
 #      o---o
-#      C   E1 or E2
-#
-# Merging D & E1 requires we first create a virtual merge base X from
-# merging A & B in memory.  Now, if X could keep both 'a' and 'a/file' in
-# the index, then the merge of D & E1 could be resolved cleanly with both
-# 'a' and 'a/file' removed.  Since git does not currently allow creating
-# such a tree, the best we can do is have X contain both 'a~<unique>' and
-# 'a/file' resulting in the merge of D and E1 having a rename/delete
-# conflict for 'a'.  (Although this merge appears to be unsolvable with git
-# currently, git could do a lot better than it currently does with these
-# d/f conflicts, which is the purpose of this test.)
-#
-# Merge of D & E2 has similar issues for path 'a', but should always result
-# in a modify/delete conflict for path 'a/file'.
-#
-# We run each merge in both directions, to check for directional issues
-# with D/F conflict handling.
+#      C   E1 or E2 or E3
+#
+# I'll describe D2, E2, & E3 (which are alternatives for D1 & E1) more below...
+#
+# Merging D1 & E1 requires we first create a virtual merge base X from
+# merging A & B in memory.  There are several possibilities for the merge-base:
+#   1: Keep both 'a' and 'a/file' (assuming crazy filesystem allowing a tree
+#      with a directory and file at same path): results in merge of D1 & E1
+#      being clean with both files deleted.  Bad (no conflict detected).
+#   2: Keep 'a' but not 'a/file': Merging D1 & E1 is clean and matches E1.  Bad.
+#   3: Keep 'a/file' but not 'a': Merging D1 & E1 is clean and matches D1.  Bad.
+#   4: Keep neither file: Merging D1 & E1 reports the D/F add/add conflict.
+#
+# So 4 sounds good for this case, but if we were to merge D1 & E3, where E3
+# is defined as:
+#   Commit E3: Merge B & C, keeping modified a, and deleting a/
+# then we'd get an add/add conflict for 'a', which seems suboptimal.  A little
+# creativity leads us to an alternate choice:
+#   5: Keep 'a' as 'a~$UNIQUE' and a/file; results:
+#        Merge D1 & E1: rename/delete conflict for 'a'; a/file silently deleted
+#        Merge D1 & E3 is clean, as expected.
+#
+# So choice 5 at least provides some kind of conflict for the original case,
+# and can merge cleanly as expected with D1 and E3.  It also made things just
+# slightly funny for merging D1 and e$, where E4 is defined as:
+#   Commit E4: Merge B & C, modifying 'a' and renaming to 'a2', and deleting 'a/'
+# in this case, we'll get a rename/rename(1to2) conflict because a~$UNIQUE
+# gets renamed to 'a' in D1 and to 'a2' in E4.  But that's better than having
+# two files (both 'a' and 'a2') sitting around without the user being notified
+# that we could detect they were related and need to be merged.  Also, choice
+# 5 makes the handling of 'a/file' seem suboptimal.  What if we were to merge
+# D2 and E4, where D2 is:
+#   Commit D2: Merge B & C, renaming 'a'->'a2', keeping 'a/file'
+# This would result in a clean merge with 'a2' having three-way merged
+# contents (good), and deleting 'a/' (bad) -- it doesn't detect the
+# conflict in how the different sides treated a/file differently.
+# Continuing down the creative route:
+#   6: Keep 'a' as 'a~$UNIQUE1' and keep 'a/' as 'a~$UNIQUE2/'; results:
+#        Merge D1 & E1: rename/delete conflict for 'a' and each path under 'a/'.
+#        Merge D1 & E3: clean, as expected.
+#        Merge D1 & E4: rename/rename(1to2) conflict on 'a' vs 'a2'.
+#        Merge D2 & E4: clean for 'a2', rename/delete for a/file
+#
+# Choice 6 could cause rename detection to take longer (providing more targets
+# that need to be searched).  Also, the conflict message for each path under
+# 'a/' might be annoying unless we can detect it at the directory level, print
+# it once, and then suppress it for individual filepaths underneath.
+#
+#
+# As of time of writing, git uses choice 5.  Directory rename detection and
+# rename detection performance improvements might make choice 6 a desirable
+# improvement.  But we can at least document where we fall short for now...
+#
+#
+# Historically, this testcase also used:
+#   Commit E2: Merge B & C, deleting 'a' but keeping slightly modified 'a/file'
+# The merge of D1 & E2 is very similar to D1 & E1 -- it has similar issues for
+# path 'a', but should always result in a modify/delete conflict for path
+# 'a/file'.  These tests ran the two merges
+#   D1 & E1
+#   D1 & E2
+# in both directions, to check for directional issues with D/F conflict
+# handling. Later we added
+#   D1 & E3
+#   D1 & E4
+#   D2 & E4
+# for good measure, though we only ran those one way because we had pretty
+# good confidence in merge-recursive's directional handling of D/F issues.
+#
+# Just to summarize all the intermediate merge commits:
+#   Commit D1: Merge B & C, keeping a    and deleting a/
+#   Commit D2: Merge B & C, renaming a->a2, keeping a/file
+#   Commit E1: Merge B & C, deleting a but keeping a/file
+#   Commit E2: Merge B & C, deleting a but keeping slightly modified a/file
+#   Commit E3: Merge B & C, keeping modified a, and deleting a/
+#   Commit E4: Merge B & C, modifying 'a' and renaming to 'a2', and deleting 'a/'
 #
 
 test_expect_success 'setup differently handled merges of directory/file conflict' '
@@ -395,56 +452,70 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 		git branch B &&
 		git checkout -b C &&
 		mkdir a &&
-		echo 10 >a/file &&
+		test_write_lines a b c d e f g >a/file &&
 		git add a/file &&
 		test_tick &&
 		git commit -m C &&
 
 		git checkout B &&
-		echo 5 >a &&
+		test_write_lines 1 2 3 4 5 6 7 >a &&
 		git add a &&
 		test_tick &&
 		git commit -m B &&
 
 		git checkout B^0 &&
-		test_must_fail git merge C &&
-		git clean -f &&
-		rm -rf a/ &&
-		echo 5 >a &&
-		git add a &&
-		test_tick &&
-		git commit -m D &&
-		git tag D &&
+		git merge -s ours -m D1 C^0 &&
+		git tag D1 &&
+
+		git checkout B^0 &&
+		test_must_fail git merge C^0 &&
+		git clean -fd &&
+		git rm -rf a/ &&
+		git rm a &&
+		git cat-file -p B:a >a2 &&
+		git add a2 &&
+		git commit -m D2 &&
+		git tag D2 &&
 
 		git checkout C^0 &&
-		test_must_fail git merge B &&
-		git clean -f &&
-		git rm --cached a &&
-		echo 10 >a/file &&
-		git add a/file &&
-		test_tick &&
-		git commit -m E1 &&
+		git merge -s ours -m E1 B^0 &&
 		git tag E1 &&
 
 		git checkout C^0 &&
-		test_must_fail git merge B &&
-		git clean -f &&
-		git rm --cached a &&
-		printf "10\n11\n" >a/file &&
+		git merge -s ours -m E2 B^0 &&
+		test_write_lines a b c d e f g h >a/file &&
 		git add a/file &&
-		test_tick &&
-		git commit -m E2 &&
-		git tag E2
+		git commit --amend -C HEAD &&
+		git tag E2 &&
+
+		git checkout C^0 &&
+		test_must_fail git merge B^0 &&
+		git clean -fd &&
+		git rm -rf a/ &&
+		test_write_lines 1 2 3 4 5 6 7 8 >a &&
+		git add a &&
+		git commit -m E3 &&
+		git tag E3
+
+		git checkout C^0 &&
+		test_must_fail git merge B^0 &&
+		git clean -fd &&
+		git rm -rf a/ &&
+		git rm a &&
+		test_write_lines 1 2 3 4 5 6 7 8 >a2 &&
+		git add a2 &&
+		git commit -m E4 &&
+		git tag E4
 	)
 '
 
-test_expect_success 'merge of D & E1 fails but has appropriate contents' '
+test_expect_success 'merge of D1 & E1 fails but has appropriate contents' '
 	test_when_finished "git -C directory-file reset --hard" &&
 	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
 		cd directory-file &&
 
-		git checkout D^0 &&
+		git checkout D1^0 &&
 
 		test_must_fail git merge -s recursive E1^0 &&
 
@@ -463,7 +534,7 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
 	)
 '
 
-test_expect_success 'merge of E1 & D fails but has appropriate contents' '
+test_expect_success 'merge of E1 & D1 fails but has appropriate contents' '
 	test_when_finished "git -C directory-file reset --hard" &&
 	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
@@ -471,7 +542,7 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 
 		git checkout E1^0 &&
 
-		test_must_fail git merge -s recursive D^0 &&
+		test_must_fail git merge -s recursive D1^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 2 out &&
@@ -488,13 +559,13 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 	)
 '
 
-test_expect_success 'merge of D & E2 fails but has appropriate contents' '
+test_expect_success 'merge of D1 & E2 fails but has appropriate contents' '
 	test_when_finished "git -C directory-file reset --hard" &&
 	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
 		cd directory-file &&
 
-		git checkout D^0 &&
+		git checkout D1^0 &&
 
 		test_must_fail git merge -s recursive E2^0 &&
 
@@ -515,7 +586,7 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 	)
 '
 
-test_expect_success 'merge of E2 & D fails but has appropriate contents' '
+test_expect_success 'merge of E2 & D1 fails but has appropriate contents' '
 	test_when_finished "git -C directory-file reset --hard" &&
 	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
@@ -523,7 +594,7 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 
 		git checkout E2^0 &&
 
-		test_must_fail git merge -s recursive D^0 &&
+		test_must_fail git merge -s recursive D1^0 &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
@@ -538,7 +609,82 @@ test_expect_success 'merge of E2 & D fails but has appropriate contents' '
 			:3:a  :2:a/file  :1:a/file  :0:ignore-me &&
 		test_cmp expect actual
 
-		test_path_is_file a~D^0
+		test_path_is_file a~D1^0
+	)
+'
+
+test_expect_success 'merge of D1 & E3 succeeds' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
+	(
+		cd directory-file &&
+
+		git checkout D1^0 &&
+
+		git merge -s recursive E3^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect    \
+			A:ignore-me  E3:a &&
+		git rev-parse   >actual   \
+			:0:ignore-me :0:a &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'merge of D1 & E4 notifies user a and a2 are related' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
+	(
+		cd directory-file &&
+
+		git checkout D1^0 &&
+
+		test_must_fail git merge -s recursive E4^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 3 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect                  \
+			A:ignore-me  B:a   D1:a  E4:a2 &&
+		git rev-parse   >actual                \
+			:0:ignore-me :1:a~Temporary\ merge\ branch\ 2  :2:a  :3:a2 &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'merge of D2 & E4 merges a2s & reports conflict for a/file' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
+	(
+		cd directory-file &&
+
+		git checkout D2^0 &&
+
+		test_must_fail git merge -s recursive E4^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect                 \
+			A:ignore-me  E4:a2  D2:a/file &&
+		git rev-parse   >actual               \
+			:0:ignore-me :0:a2  :2:a/file &&
+		test_cmp expect actual
 	)
 '
 
-- 
2.18.0.131.g7487c9a82.dirty

