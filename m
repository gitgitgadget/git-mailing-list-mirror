Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4761F404
	for <e@80x24.org>; Tue, 27 Mar 2018 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbeC0RcH (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 13:32:07 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34537 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC0RcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 13:32:03 -0400
Received: by mail-pg0-f53.google.com with SMTP id q6so727015pgr.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx+szRbFAdMxB8372NSyzAJMZCIwL1NJKOZEdyC9I7s=;
        b=Zu2UCWw3xlLzXjKO6QAbLYWtNnWZFCkcDlfm5f7g37otg5a7vRD076ZGikDpDrua+I
         3gYQFvXi1Sjd25lDWOy9VlApwYq7Ej6G+9ijKR3xJQGxNKWjpCg+4awBhlVj5mNq7Zhg
         7/cn05M3F7BIYwBEdB+HyNbEbZZb8IPiLZo/tP2UGEqrzxrMitZVG0LY7C1ewqajyFRO
         yIqZMLI5JC8Lp/X4D4KN+GrWU/Ia0kKiHRJDEqTnzP8N/6bljNVz+8rsQss46etqzF04
         gPq2KnkQ6gtzBfCKmFNQmgcfB+CO5iWmBMzFtRnuIqOGoIbizL7+PGPgDPag9IBwbnDa
         u5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx+szRbFAdMxB8372NSyzAJMZCIwL1NJKOZEdyC9I7s=;
        b=Mb9dhfJ5Z6zHS+K84cEp+vlk7St78BP1yL1IRTwTVRsGr7Hj8LHyU6XlASjAv5P4+2
         vstLKkrSN01O2TRH37x9jatTA/zOfsoRDva31hE/nb86I8X3bLS49XOD0uTDYra62a4W
         EEHzm5Ukkj92bF/sOC2E4K6zTcmQ+p+6UQ0P6eN3ngd1W3qnTcaAjG3CZi9QSkajdvWx
         xzMJVYhWhhTiICuGFfS0x8NL6FIefr9QhWXSx1GPZvmjMbX72JRQyfj4GkeLEpM0VUBd
         zTOGC+KmH28bnpf7I6Tq9afg+ZBD4s4S2+f9lJv21d6bHfO33Bcl/4cvpQIWi5IwWvf3
         Jrww==
X-Gm-Message-State: AElRT7E97PiGT14gTgLr7RsQ0LjBLbRNK9pj2B4Xas+XjMspEYVTITvw
        a1wriAqlnfrxXqrDj4SJOlKMvZNg
X-Google-Smtp-Source: AIpwx49mkiUzZZ0f23EobuYInJ+OsDMpALWjOMTFRfxXRWlXge7k8xZHEEKMTPUhtFM3KAY5Z/9Zyw==
X-Received: by 10.98.238.3 with SMTP id e3mr197417pfi.88.1522171921783;
        Tue, 27 Mar 2018 10:32:01 -0700 (PDT)
Received: from localhost.localdomain ([27.34.16.79])
        by smtp.gmail.com with ESMTPSA id 6sm3606785pgf.9.2018.03.27.10.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Mar 2018 10:32:00 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5] test: avoid pipes in git related commands for test
Date:   Tue, 27 Mar 2018 23:16:37 +0545
Message-Id: <20180327173137.5970-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <CAPig+cS3GjYo+5C_W6WqzK3RP=W+918E6Cz=FSvHky6EWCEZPA@mail.gmail.com>
References: <CAPig+cS3GjYo+5C_W6WqzK3RP=W+918E6Cz=FSvHky6EWCEZPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Eric, I made changes according to your review.


Cheers,
Pratik

-- >8 --

Avoid using pipes downstream of Git commands since the exit codes
of commands upstream of pipes get swallowed, thus potentially
hiding failure of those commands. Instead, capture Git command
output to a file and apply the downstream command(s) to that file.


Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 t/t5300-pack-object.sh                     |  8 ++---
 t/t5510-fetch.sh                           |  8 ++---
 t/t7001-mv.sh                              | 22 ++++++-------
 t/t7003-filter-branch.sh                   |  9 ++++--
 t/t9104-git-svn-follow-parent.sh           | 16 +++++-----
 t/t9108-git-svn-glob.sh                    | 14 +++++----
 t/t9109-git-svn-multi-glob.sh              | 24 ++++++++------
 t/t9110-git-svn-use-svm-props.sh           | 40 ++++++++++++------------
 t/t9111-git-svn-use-svnsync-props.sh       | 36 ++++++++++-----------
 t/t9114-git-svn-dcommit-merge.sh           | 10 +++---
 t/t9130-git-svn-authors-file.sh            | 28 ++++++++++-------
 t/t9138-git-svn-authors-prog.sh            | 31 +++++++++---------
 t/t9153-git-svn-rewrite-uuid.sh            |  8 ++---
 t/t9168-git-svn-partially-globbed-names.sh | 34 +++++++++++---------
 t/t9350-fast-export.sh                     | 50 ++++++++++++++----------------
 15 files changed, 179 insertions(+), 159 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9c68b9925..156beb2d5 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -311,8 +311,8 @@ test_expect_success 'unpacking with --strict' '
 	rm -f .git/index &&
 	tail -n 10 LIST | git update-index --index-info &&
 	ST=$(git write-tree) &&
-	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
-		git pack-objects test-5 ) &&
+	git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
+	PACK5=$( git pack-objects test-5 <actual ) &&
 	PACK6=$( (
 			echo "$LIST"
 			echo "$LI"
@@ -358,8 +358,8 @@ test_expect_success 'index-pack with --strict' '
 	rm -f .git/index &&
 	tail -n 10 LIST | git update-index --index-info &&
 	ST=$(git write-tree) &&
-	PACK5=$( git rev-list --objects "$LIST" "$LI" "$ST" | \
-		git pack-objects test-5 ) &&
+	git rev-list --objects "$LIST" "$LI" "$ST" >actual &&
+	PACK5=$( git pack-objects test-5 <actual ) &&
 	PACK6=$( (
 			echo "$LIST"
 			echo "$LI"
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index da9ac0055..ae5a530a2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -840,8 +840,8 @@ test_expect_success C_LOCALE_OUTPUT 'fetch aligned output' '
 	test_commit looooooooooooong-tag &&
 	(
 		cd full-output &&
-		git -c fetch.output=full fetch origin 2>&1 | \
-			grep -e "->" | cut -c 22- >../actual
+		git -c fetch.output=full fetch origin >actual 2>&1 &&
+		grep -e "->" actual | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
 	master               -> origin/master
@@ -855,8 +855,8 @@ test_expect_success C_LOCALE_OUTPUT 'fetch compact output' '
 	test_commit extraaa &&
 	(
 		cd compact &&
-		git -c fetch.output=compact fetch origin 2>&1 | \
-			grep -e "->" | cut -c 22- >../actual
+		git -c fetch.output=compact fetch origin >actual 2>&1 &&
+		grep -e "->" actual | cut -c 22- >../actual
 	) &&
 	cat >expect <<-\EOF &&
 	master     -> origin/*
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index d4e6485a2..e96cbdb10 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -21,8 +21,8 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-    grep "^R100..*path0/COPYING..*path1/COPYING"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+    grep "^R100..*path0/COPYING..*path1/COPYING" actual'
 
 test_expect_success \
     'moving the file back into subdirectory' \
@@ -35,8 +35,8 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-    grep "^R100..*path1/COPYING..*path0/COPYING"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+    grep "^R100..*path1/COPYING..*path0/COPYING" actual'
 
 test_expect_success \
     'mv --dry-run does not move file' \
@@ -122,10 +122,9 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path0/COPYING..*path2/COPYING" &&
-     git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path0/README..*path2/README"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
+     grep "^R100..*path0/README..*path2/README" actual'
 
 test_expect_success \
     'succeed when source is a prefix of destination' \
@@ -141,10 +140,9 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path2/COPYING..*path1/path2/COPYING" &&
-     git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path2/README..*path1/path2/README"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
+     grep "^R100..*path2/README..*path1/path2/README" actual'
 
 test_expect_success \
     'do not move directory over existing directory' \
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 7cb60799b..6a28b6cce 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -187,7 +187,8 @@ test_expect_success 'author information is preserved' '
 			test \$GIT_COMMIT != $(git rev-parse master) || \
 			echo Hallo" \
 		preserved-author) &&
-	test 1 = $(git rev-list --author="B V Uips" preserved-author | wc -l)
+	git rev-list --author="B V Uips" preserved-author >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success "remove a certain author's commits" '
@@ -205,7 +206,8 @@ test_expect_success "remove a certain author's commits" '
 	cnt1=$(git rev-list master | wc -l) &&
 	cnt2=$(git rev-list removed-author | wc -l) &&
 	test $cnt1 -eq $(($cnt2 + 1)) &&
-	test 0 = $(git rev-list --author="B V Uips" removed-author | wc -l)
+	git rev-list --author="B V Uips" removed-author >actual &&
+	test_line_count = 0 actual
 '
 
 test_expect_success 'barf on invalid name' '
@@ -258,7 +260,8 @@ test_expect_success 'Subdirectory filter with disappearing trees' '
 	git commit -m "Re-adding foo" &&
 
 	git filter-branch -f --subdirectory-filter foo &&
-	test $(git rev-list master | wc -l) = 3
+	git rev-list master >actual &&
+	test_line_count = 3 actual
 '
 
 test_expect_success 'Tag name filtering retains tag message' '
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index cd480edf1..a735fa371 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -33,8 +33,8 @@ test_expect_success 'init and fetch a moved directory' '
 	git svn fetch -i thunk &&
 	test "$(git rev-parse --verify refs/remotes/thunk@2)" \
 	   = "$(git rev-parse --verify refs/remotes/thunk~1)" &&
-	test "$(git cat-file blob refs/remotes/thunk:readme |\
-		 sed -n -e "3p")" = goodbye &&
+	git cat-file blob refs/remotes/thunk:readme >actual &&
+	test "$(sed -n -e "3p" actual)" = goodbye &&
 	test -z "$(git config --get svn-remote.svn.fetch \
 		 "^trunk:refs/remotes/thunk@2$")"
 	'
@@ -48,8 +48,8 @@ test_expect_success 'init and fetch from one svn-remote' '
         git svn fetch -i svn/thunk &&
 	test "$(git rev-parse --verify refs/remotes/svn/trunk)" \
 	   = "$(git rev-parse --verify refs/remotes/svn/thunk~1)" &&
-	test "$(git cat-file blob refs/remotes/svn/thunk:readme |\
-		 sed -n -e "3p")" = goodbye
+	git cat-file blob refs/remotes/svn/thunk:readme >actual &&
+	test "$(sed -n -e "3p" actual)" = goodbye
         '
 
 test_expect_success 'follow deleted parent' '
@@ -107,7 +107,8 @@ test_expect_success 'follow deleted directory' '
 	git svn init --minimize-url -i glob "$svnrepo"/glob &&
 	git svn fetch -i glob &&
 	test "$(git cat-file blob refs/remotes/glob:blob/bye)" = hi &&
-	test "$(git ls-tree refs/remotes/glob | wc -l )" -eq 1
+	git ls-tree refs/remotes/glob >actual &&
+	test_line_count = 1 actual
 	'
 
 # ref: r9270 of the Subversion repository: (http://svn.collab.net/repos/svn)
@@ -204,8 +205,9 @@ test_expect_success "follow-parent is atomic" '
 test_expect_success "track multi-parent paths" '
 	svn_cmd cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git svn multi-fetch &&
-	test $(git cat-file commit refs/remotes/glob | \
-	       grep "^parent " | wc -l) -eq 2
+	git cat-file commit refs/remotes/glob >actual &&
+	grep "^parent " actual >actual2 &&
+	test_line_count = 2 actual2
 	'
 
 test_expect_success "multi-fetch continues to work" "
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index a94286c8e..6990f6436 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -47,8 +47,8 @@ test_expect_success 'test refspec globbing' '
 	git config --add svn-remote.svn.tags\
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
-	git log --pretty=oneline refs/remotes/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.end &&
+	git log --pretty=oneline refs/remotes/tags/end >actual &&
+	sed -e "s/^.\{41\}//" actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/end~1)" = \
 		"$(git rev-parse refs/remotes/branches/start)" &&
@@ -75,14 +75,16 @@ test_expect_success 'test left-hand-side only globbing' '
 		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
-	test $(git rev-list refs/remotes/two/tags/end | wc -l) -eq 6 &&
-	test $(git rev-list refs/remotes/two/branches/start | wc -l) -eq 3 &&
+	git rev-list refs/remotes/two/tags/end >actual &&
+	test_line_count = 6 actual &&
+	git rev-list refs/remotes/two/branches/start >actual &&
+	test_line_count = 3 actual &&
 	test $(git rev-parse refs/remotes/two/branches/start~2) = \
 	     $(git rev-parse refs/remotes/two/trunk) &&
 	test $(git rev-parse refs/remotes/two/tags/end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/start) &&
-	git log --pretty=oneline refs/remotes/two/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.two &&
+	git log --pretty=oneline refs/remotes/two/tags/end >actual &&
+	sed -e "s/^.\{41\}//" actual >output.two &&
 	test_cmp expect.two output.two
 	'
 
diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index 8d99e848d..c1e7542a3 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -47,8 +47,8 @@ test_expect_success 'test refspec globbing' '
 	git config --add svn-remote.svn.tags\
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
-	git log --pretty=oneline refs/remotes/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.end &&
+	git log --pretty=oneline refs/remotes/tags/end >actual &&
+	sed -e "s/^.\{41\}//" actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/end~1)" = \
 		"$(git rev-parse refs/remotes/branches/v1/start)" &&
@@ -75,14 +75,16 @@ test_expect_success 'test left-hand-side only globbing' '
 		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
-	test $(git rev-list refs/remotes/two/tags/end | wc -l) -eq 6 &&
-	test $(git rev-list refs/remotes/two/branches/v1/start | wc -l) -eq 3 &&
+	git rev-list refs/remotes/two/tags/end >actual &&
+	test_line_count = 6 actual &&
+	git rev-list refs/remotes/two/branches/v1/start >actual &&
+	test_line_count = 3 actual &&
 	test $(git rev-parse refs/remotes/two/branches/v1/start~2) = \
 	     $(git rev-parse refs/remotes/two/trunk) &&
 	test $(git rev-parse refs/remotes/two/tags/end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/v1/start) &&
-	git log --pretty=oneline refs/remotes/two/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.two &&
+	git log --pretty=oneline refs/remotes/two/tags/end >actual &&
+	sed -e "s/^.\{41\}//" actual >output.two &&
 	test_cmp expect.two output.two
 	'
 cat > expect.four <<EOF
@@ -124,14 +126,16 @@ test_expect_success 'test another branch' '
 	git config --add svn-remote.four.tags \
 	                 "tags/*:refs/remotes/four/tags/*" &&
 	git svn fetch four &&
-	test $(git rev-list refs/remotes/four/tags/next | wc -l) -eq 5 &&
-	test $(git rev-list refs/remotes/four/branches/v2/start | wc -l) -eq 3 &&
+	git rev-list refs/remotes/four/tags/next >actual &&
+	test_line_count = 5 actual &&
+	git rev-list refs/remotes/four/branches/v2/start >actual &&
+	test_line_count = 3 actual &&
 	test $(git rev-parse refs/remotes/four/branches/v2/start~2) = \
 	     $(git rev-parse refs/remotes/four/trunk) &&
 	test $(git rev-parse refs/remotes/four/tags/next~2) = \
 	     $(git rev-parse refs/remotes/four/branches/v2/start) &&
-	git log --pretty=oneline refs/remotes/four/tags/next | \
-	    sed -e "s/^.\{41\}//" > output.four &&
+	git log --pretty=oneline refs/remotes/four/tags/next >actual &&
+	sed -e "s/^.\{41\}//" actual >output.four &&
 	test_cmp expect.four output.four
 	'
 
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index dde0a3c22..ad37d980c 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -21,37 +21,37 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
-	git cat-file commit refs/remotes/bar | \
-	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
-	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
-	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
-	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
-	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
-	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^git-svn-id: $bar_url@1 $uuid$'
+	git cat-file commit refs/remotes/bar >actual &&
+	grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~1 >actual &&
+	grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~2 >actual &&
+	grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~3 >actual &&
+	grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~4 >actual &&
+	grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~5 >actual &&
+	grep '^git-svn-id: $bar_url@1 $uuid$' actual
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
-	git cat-file commit refs/remotes/e | \
-	   grep '^git-svn-id: $e_url@1 $uuid$'
+	git cat-file commit refs/remotes/e >actual &&
+	grep '^git-svn-id: $e_url@1 $uuid$' actual
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
-	git cat-file commit refs/remotes/dir | \
-	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
-	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^git-svn-id: $dir_url@1 $uuid$'
+	git cat-file commit refs/remotes/dir >actual &&
+	grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
+	git cat-file commit refs/remotes/dir~1 >actual &&
+	grep '^git-svn-id: $dir_url@1 $uuid$' actual
 	"
 
 test_expect_success 'find commit based on SVN revision number' "
-        git svn find-rev r12 |
-	    grep $(git rev-parse HEAD)
+	git svn find-rev r12 >actual &&
+	grep $(git rev-parse HEAD) actual
         "
 
 test_expect_success 'empty rebase' "
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index 22b6e5ee7..6c9307355 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -20,32 +20,32 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
-	git cat-file commit refs/remotes/bar | \
-	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
-	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
-	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
-	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
-	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
-	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^git-svn-id: $bar_url@1 $uuid$'
+	git cat-file commit refs/remotes/bar >actual &&
+	grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~1 >actual &&
+	grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~2 >actual &&
+	grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~3 >actual &&
+	grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~4 >actual &&
+	grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~5 >actual &&
+	grep '^git-svn-id: $bar_url@1 $uuid$' actual
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
-	git cat-file commit refs/remotes/e | \
-	   grep '^git-svn-id: $e_url@1 $uuid$'
+	git cat-file commit refs/remotes/e >actual &&
+	grep '^git-svn-id: $e_url@1 $uuid$' actual
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
-	git cat-file commit refs/remotes/dir | \
-	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
-	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^git-svn-id: $dir_url@1 $uuid$'
+	git cat-file commit refs/remotes/dir >actual &&
+	grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
+	git cat-file commit refs/remotes/dir~1 >actual &&
+	grep '^git-svn-id: $dir_url@1 $uuid$' actual
 	"
 
 test_done
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 50bca62de..32317d6bc 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -68,7 +68,8 @@ test_debug 'gitk --all & sleep 1'
 test_expect_success 'verify pre-merge ancestry' "
 	test x\$(git rev-parse --verify refs/heads/svn^2) = \
 	     x\$(git rev-parse --verify refs/heads/merge) &&
-	git cat-file commit refs/heads/svn^ | grep '^friend$'
+	git cat-file commit refs/heads/svn^ >actual &&
+	grep '^friend$' actual
 	"
 
 test_expect_success 'git svn dcommit merges' "
@@ -82,12 +83,13 @@ test_expect_success 'verify post-merge ancestry' "
 	     x\$(git rev-parse --verify refs/remotes/origin/trunk) &&
 	test x\$(git rev-parse --verify refs/heads/svn^2) = \
 	     x\$(git rev-parse --verify refs/heads/merge) &&
-	git cat-file commit refs/heads/svn^ | grep '^friend$'
+	git cat-file commit refs/heads/svn^ >actual &&
+	grep '^friend$' actual
 	"
 
 test_expect_success 'verify merge commit message' "
-	git rev-list --pretty=raw -1 refs/heads/svn | \
-	  grep \"    Merge branch 'merge' into svn\"
+	git rev-list --pretty=raw -1 refs/heads/svn >actual &&
+	grep \"    Merge branch 'merge' into svn\" actual
 	"
 
 test_done
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 41264818c..7752a1fae 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -26,11 +26,12 @@ test_expect_success 'start import with incomplete authors file' '
 test_expect_success 'imported 2 revisions successfully' '
 	(
 		cd x
-		test "$(git rev-list refs/remotes/git-svn | wc -l)" -eq 2 &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
-		  grep "^author BBBBBBB BBBBBBB <bb@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
-		  grep "^author AAAAAAA AAAAAAA <aa@example\.com> "
+		git rev-list refs/remotes/git-svn >actual &&
+		test_line_count = 2 actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		grep "^author BBBBBBB BBBBBBB <bb@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
+		grep "^author AAAAAAA AAAAAAA <aa@example\.com> " actual
 	)
 	'
 
@@ -43,11 +44,12 @@ test_expect_success 'continues to import once authors have been added' '
 	(
 		cd x
 		git svn fetch --authors-file=../svn-authors &&
-		test "$(git rev-list refs/remotes/git-svn | wc -l)" -eq 4 &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
-		  grep "^author DDDDDDD DDDDDDD <dd@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
-		  grep "^author CCCCCCC CCCCCCC <cc@example\.com> "
+		git rev-list refs/remotes/git-svn >actual &&
+		test_line_count = 4 actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		grep "^author DDDDDDD DDDDDDD <dd@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
+		grep "^author CCCCCCC CCCCCCC <cc@example\.com> " actual
 	)
 	'
 
@@ -102,8 +104,10 @@ test_expect_success !MINGW 'fresh clone with svn.authors-file in config' '
 		test x"$HOME"/svn-authors = x"$(git config svn.authorsfile)" &&
 		git svn clone "$svnrepo" gitconfig.clone &&
 		cd gitconfig.clone &&
-		nr_ex=$(git log | grep "^Author:.*example.com" | wc -l) &&
-		nr_rev=$(git rev-list HEAD | wc -l) &&
+		git log >actual &&
+		nr_ex=$(grep "^Author:.*example.com" actual | wc -l) &&
+		git rev-list HEAD >actual &&
+		nr_rev=$(wc -l <actual) &&
 		test $nr_rev -eq $nr_ex
 	)
 '
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 7d7e9d46b..48109f949 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -37,31 +37,32 @@ test_expect_success 'import authors with prog and file' '
 test_expect_success 'imported 6 revisions successfully' '
 	(
 		cd x
-		test "$(git rev-list refs/remotes/git-svn | wc -l)" -eq 6
+		git rev-list refs/remotes/git-svn >actual &&
+		test_line_count = 6 actual
 	)
 '
 
 test_expect_success 'authors-prog ran correctly' '
 	(
 		cd x
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
-		  grep "^author ee-foo <ee-foo@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 | \
-		  grep "^author dd <dd@sub\.example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 | \
-		  grep "^author cc <cc@sub\.example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 | \
-		  grep "^author bb <bb@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 | \
-		  grep "^author aa <aa@example\.com> "
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
+		grep "^author ee-foo <ee-foo@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 >actual &&
+		grep "^author dd <dd@sub\.example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 >actual &&
+		grep "^author cc <cc@sub\.example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 >actual &&
+		grep "^author bb <bb@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 >actual &&
+		grep "^author aa <aa@example\.com> " actual
 	)
 '
 
 test_expect_success 'authors-file overrode authors-prog' '
 	(
 		cd x
-		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
-		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> "
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> " actual
 	)
 '
 
@@ -73,8 +74,8 @@ test_expect_success 'authors-prog handled special characters in username' '
 	(
 		cd x &&
 		git svn --authors-prog=../svn-authors-prog fetch &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn |
-		grep "^author xyz; touch evil <xyz; touch evil@example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		grep "^author xyz; touch evil <xyz; touch evil@example\.com> " actual &&
 		! test -f evil
 	)
 '
diff --git a/t/t9153-git-svn-rewrite-uuid.sh b/t/t9153-git-svn-rewrite-uuid.sh
index 372ef1568..8cb2b5c69 100755
--- a/t/t9153-git-svn-rewrite-uuid.sh
+++ b/t/t9153-git-svn-rewrite-uuid.sh
@@ -16,10 +16,10 @@ test_expect_success 'load svn repo' "
 	"
 
 test_expect_success 'verify uuid' "
-	git cat-file commit refs/remotes/git-svn~0 | \
-	   grep '^git-svn-id: .*@2 $uuid$' &&
-	git cat-file commit refs/remotes/git-svn~1 | \
-	   grep '^git-svn-id: .*@1 $uuid$'
+	git cat-file commit refs/remotes/git-svn~0 >actual &&
+	grep '^git-svn-id: .*@2 $uuid$' actual &&
+	git cat-file commit refs/remotes/git-svn~1 >actual &&
+	grep '^git-svn-id: .*@1 $uuid$' actual
 	"
 
 test_done
diff --git a/t/t9168-git-svn-partially-globbed-names.sh b/t/t9168-git-svn-partially-globbed-names.sh
index 8b22f2272..bdf6e8499 100755
--- a/t/t9168-git-svn-partially-globbed-names.sh
+++ b/t/t9168-git-svn-partially-globbed-names.sh
@@ -48,8 +48,8 @@ test_expect_success 'test refspec prefixed globbing' '
 	git config --add svn-remote.svn.tags\
 			 "tags/t_*/src/a:refs/remotes/tags/t_*" &&
 	git svn multi-fetch &&
-	git log --pretty=oneline refs/remotes/tags/t_end | \
-	    sed -e "s/^.\{41\}//" >output.end &&
+	git log --pretty=oneline refs/remotes/tags/t_end >actual &&
+	sed -e "s/^.\{41\}//" actual >output.end &&
 	test_cmp expect.end output.end &&
 	test "$(git rev-parse refs/remotes/tags/t_end~1)" = \
 		"$(git rev-parse refs/remotes/branches/b_start)" &&
@@ -78,14 +78,16 @@ test_expect_success 'test left-hand-side only prefixed globbing' '
 		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
-	test $(git rev-list refs/remotes/two/tags/t_end | wc -l) -eq 6 &&
-	test $(git rev-list refs/remotes/two/branches/b_start | wc -l) -eq 3 &&
+	git rev-list refs/remotes/two/tags/t_end >actual &&
+	test_line_count = 6 actual &&
+	git rev-list refs/remotes/two/branches/b_start >actual &&
+	test_line_count = 3 actual &&
 	test $(git rev-parse refs/remotes/two/branches/b_start~2) = \
 	     $(git rev-parse refs/remotes/two/trunk) &&
 	test $(git rev-parse refs/remotes/two/tags/t_end~3) = \
 	     $(git rev-parse refs/remotes/two/branches/b_start) &&
-	git log --pretty=oneline refs/remotes/two/tags/t_end | \
-	    sed -e "s/^.\{41\}//" >output.two &&
+	git log --pretty=oneline refs/remotes/two/tags/t_end >actual &&
+	sed -e "s/^.\{41\}//" actual >output.two &&
 	test_cmp expect.two output.two
 	'
 
@@ -118,14 +120,16 @@ test_expect_success 'test prefixed globs match just prefix' '
 		svn_cmd up
 	) &&
 	git svn fetch three &&
-	test $(git rev-list refs/remotes/three/branches/b_ | wc -l) -eq 2 &&
-	test $(git rev-list refs/remotes/three/tags/t_ | wc -l) -eq 3 &&
+	git rev-list refs/remotes/three/branches/b_ >actual &&
+	test_line_count = 2 actual &&
+	git rev-list refs/remotes/three/tags/t_ >actual &&
+	test_line_count = 3 actual &&
 	test $(git rev-parse refs/remotes/three/branches/b_~1) = \
 	     $(git rev-parse refs/remotes/three/trunk) &&
 	test $(git rev-parse refs/remotes/three/tags/t_~1) = \
 	     $(git rev-parse refs/remotes/three/branches/b_) &&
-	git log --pretty=oneline refs/remotes/three/tags/t_ | \
-	    sed -e "s/^.\{41\}//" >output.three &&
+	git log --pretty=oneline refs/remotes/three/tags/t_ >actual &&
+	sed -e "s/^.\{41\}//" actual >output.three &&
 	test_cmp expect.three output.three
 	'
 
@@ -186,14 +190,16 @@ test_expect_success 'test globbing in the middle of the word' '
 		svn_cmd up
 	) &&
 	git svn fetch five &&
-	test $(git rev-list refs/remotes/five/branches/abcde | wc -l) -eq 2 &&
-	test $(git rev-list refs/remotes/five/tags/fghij | wc -l) -eq 3 &&
+	git rev-list refs/remotes/five/branches/abcde >actual &&
+	test_line_count = 2 actual &&
+	git rev-list refs/remotes/five/tags/fghij >actual &&
+	test_line_count = 3 actual &&
 	test $(git rev-parse refs/remotes/five/branches/abcde~1) = \
 	     $(git rev-parse refs/remotes/five/trunk) &&
 	test $(git rev-parse refs/remotes/five/tags/fghij~1) = \
 	     $(git rev-parse refs/remotes/five/branches/abcde) &&
-	git log --pretty=oneline refs/remotes/five/tags/fghij | \
-	    sed -e "s/^.\{41\}//" >output.five &&
+	git log --pretty=oneline refs/remotes/five/tags/fghij >actual &&
+	sed -e "s/^.\{41\}//" actual >output.five &&
 	test_cmp expect.five output.five
 	'
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 866ddf605..d5679ffb8 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -43,20 +43,20 @@ test_expect_success 'fast-export | fast-import' '
 	MUSS=$(git rev-parse --verify muss) &&
 	mkdir new &&
 	git --git-dir=new/.git init &&
-	git fast-export --all |
+	git fast-export --all >actual &&
 	(cd new &&
 	 git fast-import &&
 	 test $MASTER = $(git rev-parse --verify refs/heads/master) &&
 	 test $REIN = $(git rev-parse --verify refs/tags/rein) &&
 	 test $WER = $(git rev-parse --verify refs/heads/wer) &&
-	 test $MUSS = $(git rev-parse --verify refs/tags/muss))
+	 test $MUSS = $(git rev-parse --verify refs/tags/muss)) <actual
 
 '
 
 test_expect_success 'fast-export master~2..master' '
 
-	git fast-export master~2..master |
-		sed "s/master/partial/" |
+	git fast-export master~2..master >actual &&
+	sed "s/master/partial/" actual |
 		(cd new &&
 		 git fast-import &&
 		 test $MASTER != $(git rev-parse --verify refs/heads/partial) &&
@@ -74,11 +74,12 @@ test_expect_success 'iso-8859-1' '
 	test_tick &&
 	echo rosten >file &&
 	git commit -s -m den file &&
-	git fast-export wer^..wer |
-		sed "s/wer/i18n/" |
+	git fast-export wer^..wer >iso8859-1.fi &&
+	sed "s/wer/i18n/" iso8859-1.fi |
 		(cd new &&
 		 git fast-import &&
-		 git cat-file commit i18n | grep "Áéí óú")
+		 git cat-file commit i18n >actual &&
+		 grep "Áéí óú" actual)
 
 '
 test_expect_success 'import/export-marks' '
@@ -87,20 +88,14 @@ test_expect_success 'import/export-marks' '
 	git fast-export --export-marks=tmp-marks HEAD &&
 	test -s tmp-marks &&
 	test_line_count = 3 tmp-marks &&
-	test $(
-		git fast-export --import-marks=tmp-marks\
-		--export-marks=tmp-marks HEAD |
-		grep ^commit |
-		wc -l) \
-	-eq 0 &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks HEAD >actual &&
+	test $(grep ^commit actual | wc -l) -eq 0 &&
 	echo change > file &&
 	git commit -m "last commit" file &&
-	test $(
-		git fast-export --import-marks=tmp-marks \
-		--export-marks=tmp-marks HEAD |
-		grep ^commit\  |
-		wc -l) \
-	-eq 1 &&
+	git fast-export --import-marks=tmp-marks \
+		--export-marks=tmp-marks HEAD >actual &&
+	test $(grep ^commit\  actual | wc -l) -eq 1 &&
 	test_line_count = 4 tmp-marks
 
 '
@@ -184,7 +179,7 @@ test_expect_success 'submodule fast-export | fast-import' '
 	rm -rf new &&
 	mkdir new &&
 	git --git-dir=new/.git init &&
-	git fast-export --signed-tags=strip --all |
+	git fast-export --signed-tags=strip --all >actual &&
 	(cd new &&
 	 git fast-import &&
 	 test "$SUBENT1" = "$(git ls-tree refs/heads/master^ sub)" &&
@@ -192,7 +187,7 @@ test_expect_success 'submodule fast-export | fast-import' '
 	 git checkout master &&
 	 git submodule init &&
 	 git submodule update &&
-	 cmp sub/file ../sub/file)
+	 cmp sub/file ../sub/file) <actual
 
 '
 
@@ -367,12 +362,14 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
 	echo more content >> file &&
 	test_tick &&
 	git commit -mnext file &&
-	git fast-export --import-marks=marks simple -- file file0 | grep file0
+	git fast-export --import-marks=marks simple -- file file0 >actual &&
+	grep file0 actual
 '
 
 test_expect_success 'full-tree re-shows unmodified files'        '
 	git checkout -f simple &&
-	test $(git fast-export --full-tree simple | grep -c file0) -eq 3
+	git fast-export --full-tree simple >actual &&
+	test $(grep -c file0 actual) -eq 3
 '
 
 test_expect_success 'set-up a few more tags for tag export tests' '
@@ -505,8 +502,8 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
 '
 
 test_expect_success 'use refspec' '
-	git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
-		grep "^commit " | sort | uniq > actual &&
+	git fast-export --refspec refs/heads/master:refs/heads/foobar master >actual2 &&
+	grep "^commit " actual2 | sort | uniq >actual &&
 	echo "commit refs/heads/foobar" > expected &&
 	test_cmp expected actual
 '
@@ -534,7 +531,8 @@ test_expect_success 'when using -C, do not declare copy when source of copy is a
 	git -C src commit -m 2nd_commit &&
 
 	test_create_repo dst &&
-	git -C src fast-export --all -C | git -C dst fast-import &&
+	git -C src fast-export --all -C >actual &&
+	git -C dst fast-import <actual &&
 	git -C src show >expected &&
 	git -C dst show >actual &&
 	test_cmp expected actual
-- 
2.16.2

