Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996C61F404
	for <e@80x24.org>; Thu, 28 Dec 2017 04:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbdL1EOl (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 23:14:41 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:35761 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbdL1EOg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 23:14:36 -0500
Received: by mail-it0-f52.google.com with SMTP id f143so27500515itb.0
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 20:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXhNKliERVr+wOKJWvOmQoh8/q7to+SfbS4ndZBhPqs=;
        b=vCmgW9MsbhkqR5hiD8m5gnxHHK5NwI2H7mQcSHOT4cGu4WpLc92AZ6b1er8/3Po1Yx
         21BGk3J7+Xr07sJl0bjyT/ikIr1/G0nlJ8e+1yqMCCogxIXtKA6FHsBv6tCo4UfL91x+
         qCgqD9SvA4OuGILFOYP4mBlgKeaJCHb5ERtpcIE6lKxqoab2M3Vu6qjvRqNRGTwHDy8r
         G+wjYAkldWU94ia3sgv85XxYHmwiCQEuQ3MZ5+S7LrjMFV8IeHarFwjSzEzy19UVXov3
         zafa94fZ/uzhSZGANUvxJgYPS48rVSI+PHPZX1N6ar3JJGeYsVrI93kUxyQnyYXztr2Z
         51Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PXhNKliERVr+wOKJWvOmQoh8/q7to+SfbS4ndZBhPqs=;
        b=gd6fWpxnkNFbwB3V4QBznPfLHWYnF3kJj9ZGPcsVovfzTi7JC8t4ZWAuVvRzlAN8wA
         vIA8AHVbkiDsd21PKONjcdQmXg90ydinfHUlxHlY6Xz+DKSp9VYnixklRi3evuewOAE/
         4zRqh7KDRNbCd7uQLw5Fj4sPaXD/pP+Rb9OwKVYElXyNX4RpxW6pxFLvJtXcQlzDH6zi
         d/923qYjaolAsgKqto0IaKxm4uLMMo6nXUisy/3o99nTpJgvhz2TJqca4QxaOVRDRbyN
         YeiCLYKKfi8tyueBjzUGON3xh9D3rVyhehZ5vSR1ASyFIaf+1l/pLeRCHLo9Twn5bSgx
         b77A==
X-Gm-Message-State: AKGB3mIyi6q//D+3yAlZfhETOpjaMSlxLFXi5rAO8r8qR9RVmMrXEcvQ
        l9df4uHrETNzDVwupxkeemfTQQ==
X-Google-Smtp-Source: ACJfBosnuFIJ8nyJ4VG9ZS0tmAjWvzbvl96+6y3UMDYZ5I1liZe67Qd2Ja3Xk/TxQY1Uk2UqQVNdDw==
X-Received: by 10.36.222.68 with SMTP id d65mr42212357itg.67.1514434474844;
        Wed, 27 Dec 2017 20:14:34 -0800 (PST)
Received: from localhost.localdomain (170-72-6-219.ut.vivintwireless.net. [170.72.6.219])
        by smtp.gmail.com with ESMTPSA id f207sm11201841ita.26.2017.12.27.20.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 20:14:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 32/34] directory rename detection: new testcases showcasing a pair of bugs
Date:   Wed, 27 Dec 2017 20:13:50 -0800
Message-Id: <20171228041352.27880-33-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.408.g8e199d483
In-Reply-To: <20171228041352.27880-1-newren@gmail.com>
References: <20171228041352.27880-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a testcase showing spurious rename/rename(1to2) conflicts occurring
due to directory rename detection.

Also add a pair of testcases dealing with moving directory hierarchies
around that were suggested by Stefan Beller as "food for thought" during
his review of an earlier patch series, but which actually uncovered a
bug.  Round things out with a test that is a cross between the two
testcases that showed existing bugs in order to make sure we aren't
merely addressing problems in isolation but in general.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6043-merge-rename-directories.sh | 284 ++++++++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)

diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 556029ef5..0c205fac5 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -153,6 +153,7 @@ test_expect_success '1b-check: Merge a directory with another' '
 # Testcase 1c, Transitive renaming
 #   (Related to testcases 3a and 6d -- when should a transitive rename apply?)
 #   (Related to testcases 9c and 9d -- can transitivity repeat?)
+#   (Related to testcase 12b -- joint-transitivity?)
 #   Commit O: z/{b,c},   x/d
 #   Commit A: y/{b,c},   x/d
 #   Commit B: z/{b,c,d}
@@ -2760,6 +2761,67 @@ test_expect_failure '9g-check: Renamed directory that only contained immediate s
 	)
 '
 
+# Testcase 9h, Avoid implicit rename if involved as source on other side
+#   (Extremely closely related to testcase 3a)
+#   Commit O: z/{b,c,d_1}
+#   Commit A: z/{b,c,d_2}
+#   Commit B: y/{b,c}, x/d_1
+#   Expected: y/{b,c}, x/d_2
+#   NOTE: If we applied the z/ -> y/ rename to z/d, then we'd end up with
+#         a rename/rename(1to2) conflict (z/d -> y/d vs. x/d)
+test_expect_success '9h-setup: Avoid dir rename on merely modified path' '
+	test_create_repo 9h &&
+	(
+		cd 9h &&
+
+		mkdir z &&
+		echo b >z/b &&
+		echo c >z/c &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nd\n" >z/d &&
+		git add z &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		test_tick &&
+		echo more >>z/d &&
+		git add z/d &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		mkdir y &&
+		mkdir x &&
+		git mv z/b y/ &&
+		git mv z/c y/ &&
+		git mv z/d x/ &&
+		rmdir z &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '9h-check: Avoid dir rename on merely modified path' '
+	(
+		cd 9h &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 3 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:y/b HEAD:y/c HEAD:x/d &&
+		git rev-parse >expect \
+			O:z/b O:z/c A:z/d &&
+		test_cmp expect actual
+	)
+'
+
 ###########################################################################
 # Rules suggested by section 9:
 #
@@ -3541,4 +3603,226 @@ test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rena
 	)
 '
 
+###########################################################################
+# SECTION 12: Everything else
+#
+# Tests suggested by others.  Tests added after implementation completed
+# and submitted.  Grab bag.
+###########################################################################
+
+# Testcase 12a, Moving one directory hierarchy into another
+#   (Related to testcase 9a)
+#   Commit O: node1/{leaf1,leaf2}, node2/{leaf3,leaf4}
+#   Commit A: node1/{leaf1,leaf2,node2/{leaf3,leaf4}}
+#   Commit B: node1/{leaf1,leaf2,leaf5}, node2/{leaf3,leaf4,leaf6}
+#   Expected: node1/{leaf1,leaf2,leaf5,node2/{leaf3,leaf4,leaf6}}
+
+test_expect_success '12a-setup: Moving one directory hierarchy into another' '
+	test_create_repo 12a &&
+	(
+		cd 12a &&
+
+		mkdir -p node1 node2 &&
+		echo leaf1 >node1/leaf1 &&
+		echo leaf2 >node1/leaf2 &&
+		echo leaf3 >node2/leaf3 &&
+		echo leaf4 >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		echo leaf5 >node1/leaf5 &&
+		echo leaf6 >node2/leaf6 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_success '12a-check: Moving one directory hierarchy into another' '
+	(
+		cd 12a &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 6 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:node1/leaf1 HEAD:node1/leaf2 HEAD:node1/leaf5 HEAD:node1/node2/leaf3 HEAD:node1/node2/leaf4 HEAD:node1/node2/leaf6 &&
+		git rev-parse >expect \
+			O:node1/leaf1 O:node1/leaf2 B:node1/leaf5 O:node2/leaf3 O:node2/leaf4 B:node2/leaf6 &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12b, Moving two directory hierarchies into each other
+#   (Related to testcases 1c and 12c)
+#   Commit O: node1/{leaf1, leaf2}, node2/{leaf3, leaf4}
+#   Commit A: node1/{leaf1, leaf2, node2/{leaf3, leaf4}}
+#   Commit B: node2/{leaf3, leaf4, node1/{leaf1, leaf2}}
+#   Expected: node1/node2/node1/{leaf1, leaf2},
+#             node2/node1/node2/{leaf3, leaf4}
+#   NOTE: Without directory renames, we would expect
+#                   node2/node1/{leaf1, leaf2},
+#                   node1/node2/{leaf3, leaf4}
+#         with directory rename detection, we note that
+#             commit A renames node2/ -> node1/node2/
+#             commit B renames node1/ -> node2/node1/
+#         therefore, applying those directory renames to the initial result
+#         (making all four paths experience a transitive renaming), yields
+#         the expected result.
+#
+#         You may ask, is it weird to have two directories rename each other?
+#         To which, I can do no more than shrug my shoulders and say that
+#         even simple rules give weird results when given weird inputs.
+
+test_expect_success '12b-setup: Moving one directory hierarchy into another' '
+	test_create_repo 12b &&
+	(
+		cd 12b &&
+
+		mkdir -p node1 node2 &&
+		echo leaf1 >node1/leaf1 &&
+		echo leaf2 >node1/leaf2 &&
+		echo leaf3 >node2/leaf3 &&
+		echo leaf4 >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv node1/ node2/ &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '12b-check: Moving one directory hierarchy into another' '
+	(
+		cd 12b &&
+
+		git checkout A^0 &&
+
+		git merge -s recursive B^0 &&
+
+		test 4 -eq $(git ls-files -s | wc -l) &&
+
+		git rev-parse >actual \
+			HEAD:node1/node2/node1/leaf1 \
+			HEAD:node1/node2/node1/leaf2 \
+			HEAD:node2/node1/node2/leaf3 \
+			HEAD:node2/node1/node2/leaf4 &&
+		git rev-parse >expect \
+			O:node1/leaf1 O:node1/leaf2 \
+			O:node2/leaf3 O:node2/leaf4 &&
+		test_cmp expect actual
+	)
+'
+
+# Testcase 12c, Moving two directory hierarchies into each other w/ content merge
+#   (Related to testcase 12b)
+#   Commit O: node1/{       leaf1_1, leaf2_1}, node2/{leaf3_1, leaf4_1}
+#   Commit A: node1/{       leaf1_2, leaf2_2,  node2/{leaf3_2, leaf4_2}}
+#   Commit B: node2/{node1/{leaf1_3, leaf2_3},        leaf3_3, leaf4_3}
+#   Expected: Content merge conflicts for each of:
+#               node1/node2/node1/{leaf1, leaf2},
+#               node2/node1/node2/{leaf3, leaf4}
+#   NOTE: This is *exactly* like 12c, except that every path is modified on
+#         each side of the merge.
+
+test_expect_success '12c-setup: Moving one directory hierarchy into another w/ content merge' '
+	test_create_repo 12c &&
+	(
+		cd 12c &&
+
+		mkdir -p node1 node2 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf1\n" >node1/leaf1 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf2\n" >node1/leaf2 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf3\n" >node2/leaf3 &&
+		printf "1\n2\n3\n4\n5\n6\n7\n8\nleaf4\n" >node2/leaf4 &&
+		git add node1 node2 &&
+		test_tick &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		git mv node2/ node1/ &&
+		for i in `git ls-files`; do echo side A >>$i; done &&
+		git add -u &&
+		test_tick &&
+		git commit -m "A" &&
+
+		git checkout B &&
+		git mv node1/ node2/ &&
+		for i in `git ls-files`; do echo side B >>$i; done &&
+		git add -u &&
+		test_tick &&
+		git commit -m "B"
+	)
+'
+
+test_expect_failure '12c-check: Moving one directory hierarchy into another w/ content merge' '
+	(
+		cd 12c &&
+
+		git checkout A^0 &&
+
+		test_must_fail git merge -s recursive B^0 &&
+
+		test 12 -eq $(git ls-files -u | wc -l) &&
+
+		git rev-parse >actual \
+			:1:node1/node2/node1/leaf1 \
+			:1:node1/node2/node1/leaf2 \
+			:1:node2/node1/node2/leaf3 \
+			:1:node2/node1/node2/leaf4 \
+			:2:node1/node2/node1/leaf1 \
+			:2:node1/node2/node1/leaf2 \
+			:2:node2/node1/node2/leaf3 \
+			:2:node2/node1/node2/leaf4 \
+			:3:node1/node2/node1/leaf1 \
+			:3:node1/node2/node1/leaf2 \
+			:3:node2/node1/node2/leaf3 \
+			:3:node2/node1/node2/leaf4 &&
+		git rev-parse >expect \
+			O:node1/leaf1 \
+			O:node1/leaf2 \
+			O:node2/leaf3 \
+			O:node2/leaf4 \
+			A:node1/leaf1 \
+			A:node1/leaf2 \
+			A:node1/node2/leaf3 \
+			A:node1/node2/leaf4 \
+			B:node2/node1/leaf1 \
+			B:node2/node1/leaf2 \
+			B:node2/leaf3 \
+			B:node2/leaf4 &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.15.0.408.g8e199d483

