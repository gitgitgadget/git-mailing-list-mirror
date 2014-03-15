From: Justin Lebar <jlebar@google.com>
Subject: [PATCH 6/6] Tests: Fix misuses of "nor"
Date: Sat, 15 Mar 2014 01:42:02 -0700
Message-ID: <1394872922-2000-7-git-send-email-jlebar@google.com>
References: <1394872922-2000-1-git-send-email-jlebar@google.com>
Cc: Justin Lebar <jlebar@google.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Justin Lebar <jlebar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 09:43:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkBe-0006NS-EP
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 09:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbaCOInN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 04:43:13 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:33832 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbaCOIm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 04:42:57 -0400
Received: by mail-pd0-f201.google.com with SMTP id x10so444988pdj.4
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=52DMsBHo0arvp8hV5HX9xeSJav6VvHnRUA360WHCnS8=;
        b=JvmzhaqyYZK4Zdb+m9hP4hMoF+bU0J+ZWEnO614py4TcNyqp374psAHaLEyykNxCme
         8/Rfy8wBT67K6jfPIc4Zla/OOIpej0DPV/kAbKKobKBzn1W5eYxAo4L4u6IfEDhodSCh
         /Y99p+n1JlqETK4YlkVk9Jgz7o0EoUKfhB40Bnq1pflUU900Or7OPHlYYoZV1c+KxzbW
         iDe9oJN5pBhR551GaBJrOTV17d1XJppwiH5OvUZ02tJaCgnB5RVqZ7iOoK1h9Nr9xjaH
         4Rthg6vyU2COZ6KOVkpFqukWUJZA7LyxIsi4uB80jD1HtJLGcfMNRQ9kCC9cnl2GrI1m
         KRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=52DMsBHo0arvp8hV5HX9xeSJav6VvHnRUA360WHCnS8=;
        b=gK/fJQl1usBhQ3r5hPvuhg7qPpBAW+K+VZ+RtWablsuVwv+bAOLbocs4MRBBMhxgQy
         UXF6YsHhwjouQ47nNkgOg2L1rpeJYt2DH1hsDo5P2V4ZTCB0jhfEp9QF9M/LoK6HzRtH
         xDXQwActb1DydSyTwg27PsnT8qjXk23Qn4J5aypXyrrUj/0ahXH4hgRfvwfgc/da3aHN
         o5bbMpFFs5j+Ze6mgm2g7lIY9YjHzI97HX7pcIBa3XCg9OyX2N1Ddy2p17/7NHH2q21J
         O4w1MO0C58nOxEsN2WsWwoYuBhtxc1gRAb4xCZuyddhWCgOft4WryhemzqsB7t7anDSN
         9cNQ==
X-Gm-Message-State: ALoCoQkmN8p8nc6WGMH8afnMc0SDpELWbDzi2gzn2cRdiTg+Mc5QJvhgIlU0tiUB5zqwLhmqvLGBVAS/CtYvC5O1avQ1TOX2zM2sqR2vsWYvCe4fNQ2GvIi1OTr9v+LxcFnKRThLS/JX6C8bhQT3hSCU/BJtR/+P6bShk7qdHkDkByQGbAPvLW1YMAVXb/BU3ngdz1cuuPtP
X-Received: by 10.69.29.33 with SMTP id jt1mr4779506pbd.7.1394872976772;
        Sat, 15 Mar 2014 01:42:56 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id s66si1295766yhs.6.2014.03.15.01.42.56
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Mar 2014 01:42:56 -0700 (PDT)
Received: from jlebar0.mtv.corp.google.com (jlebar0.mtv.corp.google.com [172.17.132.58])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6C9155A4241;
	Sat, 15 Mar 2014 01:42:56 -0700 (PDT)
Received: by jlebar0.mtv.corp.google.com (Postfix, from userid 214119)
	id 3165D1A0889; Sat, 15 Mar 2014 01:42:56 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.279.gdc9e3eb
In-Reply-To: <1394872922-2000-1-git-send-email-jlebar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244144>

Signed-off-by: Justin Lebar <jlebar@gmail.com>
---
 t/t1001-read-tree-m-2way.sh       | 2 +-
 t/t4005-diff-rename-2.sh          | 2 +-
 t/t4009-diff-rename-4.sh          | 2 +-
 t/t5304-prune.sh                  | 2 +-
 t/t6036-recursive-corner-cases.sh | 2 +-
 t/t7104-reset.sh                  | 2 +-
 t/t9400-git-cvsserver-server.sh   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index acaab07..1731383 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -18,7 +18,7 @@ In the test, these paths are used:
         frotz   - not in H added in M
         nitfol  - in H, stays in M unmodified
         rezrov  - in H, deleted in M
-        yomin   - not in H nor M
+        yomin   - not in H or M
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 77d7f49..7d2c6e1 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -66,7 +66,7 @@ test_expect_success \
 
 # tree has COPYING and rezrov.  work tree has the same COPYING and
 # copy-edited COPYING.1, and unchanged rezrov.  We should not say
-# anything about rezrov nor COPYING, since the revised again diff-raw
+# anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
 test_expect_success \
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index f22c8e3..57c094f 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -73,7 +73,7 @@ test_expect_success \
 
 # tree has COPYING and rezrov.  work tree has the same COPYING and
 # copy-edited COPYING.1, and unchanged rezrov.  We should not say
-# anything about rezrov nor COPYING, since the revised again diff-raw
+# anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
 test_expect_success \
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 66c9a41..377d3d3 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -213,7 +213,7 @@ test_expect_success 'garbage report in count-objects -v' '
 warning: garbage found: .git/objects/pack/fake.bar
 warning: garbage found: .git/objects/pack/foo
 warning: garbage found: .git/objects/pack/foo.bar
-warning: no corresponding .idx nor .pack: .git/objects/pack/fake2.keep
+warning: no corresponding .idx or .pack: .git/objects/pack/fake2.keep
 warning: no corresponding .idx: .git/objects/pack/foo.keep
 warning: no corresponding .idx: .git/objects/pack/foo.pack
 warning: no corresponding .pack: .git/objects/pack/fake3.idx
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index dfee7d1..a86087b 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -388,7 +388,7 @@ test_expect_failure 'git detects conflict w/ criss-cross+contrived resolution' '
 
 #
 # criss-cross + d/f conflict via add/add:
-#   Commit A: Neither file 'a' nor directory 'a/' exist.
+#   Commit A: Neither file 'a' nor directory 'a/' exists.
 #   Commit B: Introduce 'a'
 #   Commit C: Introduce 'a/file'
 #   Commit D: Merge B & C, keeping 'a' and deleting 'a/'
diff --git a/t/t7104-reset.sh b/t/t7104-reset.sh
index f136ee7..16faa07 100755
--- a/t/t7104-reset.sh
+++ b/t/t7104-reset.sh
@@ -33,7 +33,7 @@ test_expect_success 'reset --hard should restore unmerged ones' '
 
 '
 
-test_expect_success 'reset --hard did not corrupt index nor cached-tree' '
+test_expect_success 'reset --hard did not corrupt index or cached-tree' '
 
 	T=$(git write-tree) &&
 	rm -f .git/index &&
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 3edc408..1f06e25 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -512,7 +512,7 @@ test_expect_success 'cvs co -c (shows module database)' '
 # Known issues with git-cvsserver current log output:
 #  - Hard coded "lines: +2 -3" placeholder, instead of real numbers.
 #  - CVS normally does not internally add a blank first line
-#    nor a last line with nothing but a space to log messages.
+#    or a last line with nothing but a space to log messages.
 #  - The latest cvs 1.12.x server sends +0000 timezone (with some hidden "MT"
 #    tagging in the protocol), and if cvs 1.12.x client sees the MT tags,
 #    it converts to local time zone.  git-cvsserver doesn't do the +0000
-- 
1.9.0.279.gdc9e3eb
