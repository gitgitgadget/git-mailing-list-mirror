Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503CA1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeGBAZc (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:32 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:51950 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeGBAZN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:13 -0400
Received: by mail-it0-f51.google.com with SMTP id o5-v6so8853092itc.1
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffGWRn4Uks3YT9WKLS+kP/wqoex4l/0ydO4/XBwWlIo=;
        b=RkKt3qgF1FncgPRlDsLSiT17X2mUrrQZcKMBVJrWKCyQ50cEQ1KcQJbaReZO8+Cf70
         dw8haWNZPs6xPkIBB6OamM/aoV1arzdTkGVVgH5Q/SsJ0r1m7pwlB/Pqqa4XGQoOMRiG
         EYlNJn9g4kW/IJuVIc/boAD+I3CN0l4FlF2DmVPGunUgAGn8ketLNM12PFMb8Ix0M4OW
         9J+BD20Y+zuRyJRHqrQGctD4+gd9dr1AGSyIC2jbHAj5STgP9U+52Ecyi3mwX6uZJpPU
         ZIP09vjL80GTQTvGHeiVH7YaeKmIcrUqN6770LlZUKXeCW8v5YG55c7FKWGqshDkEyj3
         ECQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ffGWRn4Uks3YT9WKLS+kP/wqoex4l/0ydO4/XBwWlIo=;
        b=hAgFaYxanZEZPBJeGxWgN7khNEsL7Ci29E0NXqAU6cPrKAwnjKo5+sxzL34CtBUIDW
         tj86d0BZVa6YPxoU7p9OjqBIxZ2ktS5O/sKyDyC3s4hSazfdoTHrGDHSY7GNtOX5ID18
         saI5jpLirGYXOtYzKDalqWWecc0hSSh6a7ulQlqh0NKBicGuWWYijRa/tE93MAyAqxBi
         UqtAjYWZkT8TWxKzFnF5ziB3sj4wU1qVRGep1GbshINNzuhbnSqKO3VtPPrAa3x/ewK+
         Kh3SIyJqOYDhvT5PFfv9vaMOW3r3NBCkPvlRfI7fTCDVW+Ln8/JrsIEkumb0C1ua8yK8
         c0YA==
X-Gm-Message-State: APt69E2OdGdjMplrMwDfY7sDhRxT8clqUVjRu+FtxOsFNZIi1xveSKIW
        N5BDex2lXty3IMGd1iSE7ZTTWQ==
X-Google-Smtp-Source: AAOMgpdr8HPdOrVqotPLqJ7leU6EadJKvkfkonwZ3azIY6Myt+j3mUT8rnCOZQKR+YjssWs7hHR3lg==
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr4095343itf.70.1530491112775;
        Sun, 01 Jul 2018 17:25:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:12 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 24/25] t9000-t9999: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:24:04 -0400
Message-Id: <20180702002405.3042-25-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9001-send-email.sh                         |  6 +++---
 t/t9100-git-svn-basic.sh                      |  2 +-
 t/t9101-git-svn-props.sh                      |  2 +-
 t/t9122-git-svn-author.sh                     |  6 +++---
 t/t9129-git-svn-i18n-commitencoding.sh        |  2 +-
 t/t9130-git-svn-authors-file.sh               |  4 ++--
 t/t9134-git-svn-ignore-paths.sh               |  6 +++---
 t/t9137-git-svn-dcommit-clobber-series.sh     |  2 +-
 t/t9138-git-svn-authors-prog.sh               |  6 +++---
 t/t9146-git-svn-empty-dirs.sh                 | 20 +++++++++----------
 t/t9147-git-svn-include-paths.sh              |  6 +++---
 t/t9152-svn-empty-dirs-after-gc.sh            |  2 +-
 t/t9164-git-svn-dcommit-concurrent.sh         |  2 +-
 ...65-git-svn-fetch-merge-branch-of-branch.sh |  2 +-
 t/t9200-git-cvsexportcommit.sh                |  6 +++---
 t/t9302-fast-import-unpack-limit.sh           |  2 +-
 t/t9400-git-cvsserver-server.sh               |  6 +++---
 t/t9600-cvsimport.sh                          |  2 +-
 t/t9806-git-p4-options.sh                     |  2 +-
 t/t9810-git-p4-rcs.sh                         |  2 +-
 t/t9811-git-p4-label-import.sh                |  2 +-
 t/t9815-git-p4-submit-fail.sh                 |  2 +-
 t/t9830-git-p4-symlink-dir.sh                 |  2 +-
 t/t9831-git-p4-triggers.sh                    |  2 +-
 t/t9902-completion.sh                         |  4 ++--
 t/t9903-bash-prompt.sh                        |  2 +-
 26 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 776769fe0d..53314ff54e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -330,7 +330,7 @@ test_expect_success $PREREQ 'Show all headers' '
 
 test_expect_success $PREREQ 'Prompting works' '
 	clean_fake_sendmail &&
-	(echo "to@example.com"
+	(echo "to@example.com" &&
 	 echo ""
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
@@ -470,8 +470,8 @@ test_expect_success $PREREQ 'Invalid In-Reply-To' '
 
 test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	clean_fake_sendmail &&
-	(echo "From Example <from@example.com>"
-	 echo "To Example <to@example.com>"
+	(echo "From Example <from@example.com>" &&
+	 echo "To Example <to@example.com>" &&
 	 echo ""
 	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index c937330a5f..9af6078844 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -31,7 +31,7 @@ test_expect_success \
 	(
 		cd import &&
 		echo foo >foo &&
-		ln -s foo foo.link
+		ln -s foo foo.link &&
 		mkdir -p dir/a/b/c/d/e &&
 		echo "deep dir" >dir/a/b/c/d/e/file &&
 		mkdir bar &&
diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 07bfb63777..8a5c8dc1aa 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -149,7 +149,7 @@ test_expect_success 'test show-ignore' "
 		svn_cmd up &&
 		svn_cmd propset -R svn:ignore '
 no-such-file*
-' .
+' . &&
 		svn_cmd commit -m 'propset svn:ignore'
 	) &&
 	git svn show-ignore > show-ignore.got &&
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 30013b7bb9..9e8fe38e7e 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -7,8 +7,8 @@ test_expect_success 'setup svn repository' '
 	svn_cmd checkout "$svnrepo" work.svn &&
 	(
 		cd work.svn &&
-		echo >file
-		svn_cmd add file
+		echo >file &&
+		svn_cmd add file &&
 		svn_cmd commit -m "first commit" file
 	)
 '
@@ -17,7 +17,7 @@ test_expect_success 'interact with it via git svn' '
 	mkdir work.git &&
 	(
 		cd work.git &&
-		git svn init "$svnrepo"
+		git svn init "$svnrepo" &&
 		git svn fetch &&
 
 		echo modification >file &&
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 8dbd6476fa..2c213ae654 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -51,7 +51,7 @@ do
 		git add F &&
 		git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt &&
 		E=$(git cat-file commit HEAD | sed -ne "s/^encoding //p") &&
-		test "z$E" = "z$H"
+		test "z$E" = "z$H" &&
 		compare_git_head_with "$TEST_DIRECTORY"/t3900/$H.txt
 	)
 	'
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index d8262854bb..cb764bcadc 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -25,7 +25,7 @@ test_expect_success 'start import with incomplete authors file' '
 
 test_expect_success 'imported 2 revisions successfully' '
 	(
-		cd x
+		cd x &&
 		git rev-list refs/remotes/git-svn >actual &&
 		test_line_count = 2 actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
@@ -42,7 +42,7 @@ EOF
 
 test_expect_success 'continues to import once authors have been added' '
 	(
-		cd x
+		cd x &&
 		git svn fetch --authors-file=../svn-authors &&
 		git rev-list refs/remotes/git-svn >actual &&
 		test_line_count = 4 actual &&
diff --git a/t/t9134-git-svn-ignore-paths.sh b/t/t9134-git-svn-ignore-paths.sh
index 09ff10cd9b..fff49c4100 100755
--- a/t/t9134-git-svn-ignore-paths.sh
+++ b/t/t9134-git-svn-ignore-paths.sh
@@ -82,7 +82,7 @@ test_expect_success 'update git svn-cloned repo (option ignore)' '
 test_expect_success 'SVN-side change inside of ignored www' '
 	(
 		cd s &&
-		echo zaq >> www/test_www.txt
+		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
 		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
@@ -114,8 +114,8 @@ test_expect_success 'update git svn-cloned repo (option ignore)' '
 test_expect_success 'SVN-side change in and out of ignored www' '
 	(
 		cd s &&
-		echo cvf >> www/test_www.txt
-		echo ygg >> qqq/test_qqq.txt
+		echo cvf >> www/test_www.txt &&
+		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
 		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index 5fa07a369f..067b15bad2 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -7,7 +7,7 @@ test_description='git svn dcommit clobber series'
 test_expect_success 'initialize repo' '
 	mkdir import &&
 	(cd import &&
-	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file
+	awk "BEGIN { for (i = 1; i < 64; i++) { print i } }" > file &&
 	svn_cmd import -m "initial" . "$svnrepo"
 	) &&
 	git svn init "$svnrepo" &&
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 93ef44fae8..027b416720 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -38,7 +38,7 @@ test_expect_success 'import authors with prog and file' '
 
 test_expect_success 'imported 6 revisions successfully' '
 	(
-		cd x
+		cd x &&
 		git rev-list refs/remotes/git-svn >actual &&
 		test_line_count = 6 actual
 	)
@@ -46,7 +46,7 @@ test_expect_success 'imported 6 revisions successfully' '
 
 test_expect_success 'authors-prog ran correctly' '
 	(
-		cd x
+		cd x &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
 		grep "^author ee-foo <ee-foo@example\.com> " actual &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 >actual &&
@@ -62,7 +62,7 @@ test_expect_success 'authors-prog ran correctly' '
 
 test_expect_success 'authors-file overrode authors-prog' '
 	(
-		cd x
+		cd x &&
 		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
 		grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> " actual
 	)
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 6d3130e618..5f91c0d68b 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -21,7 +21,7 @@ test_expect_success 'empty directories exist' '
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
@@ -38,7 +38,7 @@ test_expect_success 'option automkdirs set to false' '
 		do
 			if test -d "$i"
 			then
-				echo >&2 "$i exists"
+				echo >&2 "$i exists" &&
 				exit 1
 			fi
 		done
@@ -63,7 +63,7 @@ test_expect_success 'git svn mkdirs recreates empty directories' '
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
@@ -79,21 +79,21 @@ test_expect_success 'git svn mkdirs -r works' '
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
-		done
+		done &&
 
 		if test -d "! !"
 		then
-			echo >&2 "$i should not exist"
+			echo >&2 "$i should not exist" &&
 			exit 1
-		fi
+		fi &&
 
 		git svn mkdirs -r8 &&
 		if ! test -d "! !"
 		then
-			echo >&2 "$i not exist"
+			echo >&2 "$i not exist" &&
 			exit 1
 		fi
 	)
@@ -115,7 +115,7 @@ test_expect_success 'empty directories in trunk exist' '
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
@@ -148,7 +148,7 @@ test_expect_success 'git svn gc-ed files work' '
 			do
 				if ! test -d "$i"
 				then
-					echo >&2 "$i does not exist"
+					echo >&2 "$i does not exist" &&
 					exit 1
 				fi
 			done
diff --git a/t/t9147-git-svn-include-paths.sh b/t/t9147-git-svn-include-paths.sh
index a90ff58629..d292bf9f55 100755
--- a/t/t9147-git-svn-include-paths.sh
+++ b/t/t9147-git-svn-include-paths.sh
@@ -84,7 +84,7 @@ test_expect_success 'update git svn-cloned repo (option include)' '
 test_expect_success 'SVN-side change inside of ignored www' '
 	(
 		cd s &&
-		echo zaq >> www/test_www.txt
+		echo zaq >> www/test_www.txt &&
 		svn_cmd commit -m "SVN-side change inside of www/test_www.txt" &&
 		svn_cmd up &&
 		svn_cmd log -v | fgrep "SVN-side change inside of www/test_www.txt"
@@ -116,8 +116,8 @@ test_expect_success 'update git svn-cloned repo (option include)' '
 test_expect_success 'SVN-side change in and out of included qqq' '
 	(
 		cd s &&
-		echo cvf >> www/test_www.txt
-		echo ygg >> qqq/test_qqq.txt
+		echo cvf >> www/test_www.txt &&
+		echo ygg >> qqq/test_qqq.txt &&
 		svn_cmd commit -m "SVN-side change in and out of ignored www" &&
 		svn_cmd up &&
 		svn_cmd log -v | fgrep "SVN-side change in and out of ignored www"
diff --git a/t/t9152-svn-empty-dirs-after-gc.sh b/t/t9152-svn-empty-dirs-after-gc.sh
index 301e779709..89f285d082 100755
--- a/t/t9152-svn-empty-dirs-after-gc.sh
+++ b/t/t9152-svn-empty-dirs-after-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'git svn mkdirs recreates empty directories after git svn gc
 		do
 			if ! test -d "$i"
 			then
-				echo >&2 "$i does not exist"
+				echo >&2 "$i does not exist" &&
 				exit 1
 			fi
 		done
diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
index d8464d4218..90346ff4e9 100755
--- a/t/t9164-git-svn-dcommit-concurrent.sh
+++ b/t/t9164-git-svn-dcommit-concurrent.sh
@@ -12,7 +12,7 @@ test_expect_success 'setup svn repository' '
 	svn_cmd checkout "$svnrepo" work.svn &&
 	(
 		cd work.svn &&
-		echo >file && echo > auto_updated_file
+		echo >file && echo > auto_updated_file &&
 		svn_cmd add file auto_updated_file &&
 		svn_cmd commit -m "initial commit"
 	) &&
diff --git a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
index fa3ef3b1f7..a4813c2b09 100755
--- a/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
+++ b/t/t9165-git-svn-fetch-merge-branch-of-branch.sh
@@ -39,7 +39,7 @@ test_expect_success 'initialize source svn repo' '
 		svn_cmd commit -m trunk &&
 		svn_cmd switch "$svnrepo"/branches/branch2 &&
 		svn_cmd merge "$svnrepo"/trunk &&
-		svn_cmd commit -m "merge trunk"
+		svn_cmd commit -m "merge trunk" &&
 		svn_cmd switch "$svnrepo"/trunk &&
 		svn_cmd merge --reintegrate "$svnrepo"/branches/branch2 &&
 		svn_cmd commit -m "merge branch2"
diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 1319415ba8..cd61288aa1 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -187,7 +187,7 @@ test_expect_success \
       git commit -a -m "Update with spaces" &&
       id=$(git rev-list --max-count=1 HEAD) &&
       (cd "$CVSWORK" &&
-      git cvsexportcommit -c $id
+      git cvsexportcommit -c $id &&
       check_entries "G g" "with spaces.png/1.2/-kb|with spaces.txt/1.2/"
       )'
 
@@ -245,7 +245,7 @@ test_expect_success FILEMODE \
       git add G/off &&
       git commit -a -m "Execute test" &&
       (cd "$CVSWORK" &&
-      git cvsexportcommit -c HEAD
+      git cvsexportcommit -c HEAD &&
       test -x G/on &&
       ! test -x G/off
       )'
@@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
     git add attic_gremlin &&
     git commit -m "Added attic_gremlin" &&
 	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
-    (cd "$CVSWORK"; cvs -Q update -d) &&
+    (cd "$CVSWORK" && cvs -Q update -d) &&
     test -f "$CVSWORK/attic_gremlin"
 '
 
diff --git a/t/t9302-fast-import-unpack-limit.sh b/t/t9302-fast-import-unpack-limit.sh
index a04de14677..bb1c39cfcc 100755
--- a/t/t9302-fast-import-unpack-limit.sh
+++ b/t/t9302-fast-import-unpack-limit.sh
@@ -80,7 +80,7 @@ test_expect_success 'lookups after checkpoint works' '
 		do
 			if test $n -gt 30
 			then
-				echo >&2 "checkpoint did not update branch"
+				echo >&2 "checkpoint did not update branch" &&
 				exit 1
 			else
 				n=$(($n + 1))
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 6b09da79bf..a5e5dca753 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -371,7 +371,7 @@ test_expect_success 'cvs update (merge)' \
   'echo Line 0 >expected &&
    for i in 1 2 3 4 5 6 7
    do
-     echo Line $i >>merge
+     echo Line $i >>merge &&
      echo Line $i >>expected
    done &&
    echo Line 8 >>expected &&
@@ -382,7 +382,7 @@ test_expect_success 'cvs update (merge)' \
    GIT_CONFIG="$git_config" cvs -Q update &&
    test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
    test_cmp merge ../merge &&
-   ( echo Line 0; cat merge ) >merge.tmp &&
+   ( echo Line 0 && cat merge ) >merge.tmp &&
    mv merge.tmp merge &&
    cd "$WORKDIR" &&
    echo Line 8 >>merge &&
@@ -410,7 +410,7 @@ do
 done
 
 test_expect_success 'cvs update (conflict merge)' \
-  '( echo LINE 0; cat merge ) >merge.tmp &&
+  '( echo LINE 0 && cat merge ) >merge.tmp &&
    mv merge.tmp merge &&
    git add merge &&
    git commit -q -m "Merge test (conflict)" &&
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 804ce3850f..5dfee07d9a 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -135,7 +135,7 @@ test_expect_success PERL 'second update has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1 HEAD^^ &&
-	 git log --format="o_fortuna 1.2 %H" -1 HEAD^
+	 git log --format="o_fortuna 1.2 %H" -1 HEAD^ &&
 	 git log --format="tick 1.1 %H" -1 HEAD) > expected &&
 	test_cmp expected module-git/.git/cvs-revisions
 '
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 1ab76c4246..3f5291b857 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -134,7 +134,7 @@ test_expect_success 'clone --changesfile' '
 	(
 		cd "$git" &&
 		git log --oneline p4/master >lines &&
-		test_line_count = 2 lines
+		test_line_count = 2 lines &&
 		test_path_is_file file1 &&
 		test_path_is_missing file2 &&
 		test_path_is_file file3
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index 8134ab439b..cc53debe19 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -161,7 +161,7 @@ test_expect_success 'cleanup after failure' '
 test_expect_success 'ktext expansion should not expand multi-line $File::' '
 	(
 		cd "$cli" &&
-		cat >lv.pm <<-\EOF
+		cat >lv.pm <<-\EOF &&
 		my $wanted = sub { my $f = $File::Find::name;
 				    if ( -f && $f =~ /foo/ ) {
 		EOF
diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index decb66ba30..602b0a5d5c 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -133,7 +133,7 @@ test_expect_success 'export git tags to p4' '
 		p4 labels ... | grep LIGHTWEIGHT_TAG &&
 		p4 label -o GIT_TAG_1 | grep "tag created in git:xyzzy" &&
 		p4 sync ...@GIT_TAG_1 &&
-		! test -f main/f10
+		! test -f main/f10 &&
 		p4 sync ...@GIT_TAG_2 &&
 		test -f main/f10
 	)
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 37b42d03a2..eaf03a6563 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -394,7 +394,7 @@ test_expect_success 'cleanup rename after submit cancel' '
 	(
 		cd "$cli" &&
 		test_path_is_missing text2 &&
-		p4 fstat -T action text2 2>&1 | grep "no such file"
+		p4 fstat -T action text2 2>&1 | grep "no such file" &&
 		test_path_is_file text &&
 		! p4 fstat -T action text
 	)
diff --git a/t/t9830-git-p4-symlink-dir.sh b/t/t9830-git-p4-symlink-dir.sh
index 3dc528bb1e..2ad1b0810d 100755
--- a/t/t9830-git-p4-symlink-dir.sh
+++ b/t/t9830-git-p4-symlink-dir.sh
@@ -30,7 +30,7 @@ test_expect_success 'symlinked directory' '
 	(
 		cd "$cli" &&
 		p4 sync &&
-		test -L some/sub/directory/subdir2
+		test -L some/sub/directory/subdir2 &&
 		test_path_is_file some/sub/directory/subdir2/file.t
 	)
 
diff --git a/t/t9831-git-p4-triggers.sh b/t/t9831-git-p4-triggers.sh
index bbcf14c664..be44c9751a 100755
--- a/t/t9831-git-p4-triggers.sh
+++ b/t/t9831-git-p4-triggers.sh
@@ -13,7 +13,7 @@ test_expect_success 'init depot' '
 		cd "$cli" &&
 		echo file1 >file1 &&
 		p4 add file1 &&
-		p4 submit -d "change 1"
+		p4 submit -d "change 1" &&
 		echo file2 >file2 &&
 		p4 add file2 &&
 		p4 submit -d "change 2"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3b3a7b66e4..5ff43b9cbb 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1103,7 +1103,7 @@ test_expect_success '__git_complete_refs - remote' '
 	master-in-other Z
 	EOF
 	(
-		cur=
+		cur= &&
 		__git_complete_refs --remote=other &&
 		print_comp
 	) &&
@@ -1122,7 +1122,7 @@ test_expect_success '__git_complete_refs - track' '
 	master-in-other Z
 	EOF
 	(
-		cur=
+		cur= &&
 		__git_complete_refs --track &&
 		print_comp
 	) &&
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index c3b89ae783..04440685a6 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -529,7 +529,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
 	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
 	(
 		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
+		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
 		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
 	) &&
 	test_cmp expected "$actual"
-- 
2.18.0.203.gfac676dfb9

