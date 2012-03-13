From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] test: use test_i18ncmp when checking --stat output
Date: Mon, 12 Mar 2012 23:54:05 -0500
Message-ID: <20120313045404.GA12550@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120313045100.GA12474@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 05:54:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Jki-0000zh-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 05:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab2CMEyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 00:54:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40565 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190Ab2CMEyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 00:54:21 -0400
Received: by gghe5 with SMTP id e5so145599ggh.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 21:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xp2rCwgwVz6r0nCgQSpegQd/3/pR4CVBrkV11/S/bN8=;
        b=EULt60egpBawkmy2UDKUPHOv/wJVtBLpn+yN+AK8HjPHkzdc2C6G7dkxFcnqCbM+Cw
         1MdpuHTRQ+vul3GCqJxadhCIFkQQ+yfqxx5Tt8q7hR4bDNCBetQLK3XkOzWu9bbTYbYr
         9aOr5Tw/V7ALdGLPdhmxfS8n/R7lwfhrOLhUMTWmUrsOBVFdV32iy2BOryfGr7OW7QkG
         5tBgZ2H9sW0sdI6EBbIduW+9Fx/kPzF11B6aoZWWzthCX2dkoZ7cPHEt/eKr01W9e981
         lLBSAgllWsbjwroUuw9IyCC7EcJLLrKjgMVNzXAZCVs3qEJV+tNhYGlB84cip9lmyBGR
         /BRQ==
Received: by 10.60.20.10 with SMTP id j10mr11186914oee.33.1331614461254;
        Mon, 12 Mar 2012 21:54:21 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 1sm24305417obo.2.2012.03.12.21.54.20
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 21:54:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120313045100.GA12474@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192972>

Ever since v1.7.9.2~13 (2012-02-01), git's diffstat-style summary line
produced by "git apply --stat", "git diff --stat", and "git commit"
varies by locale, producing test failures when GETTEXT_POISON is set.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As mentioned in the cover letter, this is incomplete.  More changes
of the same kind, especially in t4013-diff-various.sh, are needed for
the testsuite to pass with GETTEXT_POISON=t.  Patch 7 has them.

 t/t3300-funny-names.sh              |    6 +++---
 t/t3508-cherry-pick-many-commits.sh |    4 ++--
 t/t3903-stash.sh                    |    4 ++--
 t/t4012-diff-binary.sh              |    4 ++--
 t/t4049-diff-stat-count.sh          |    2 +-
 t/t4100-apply-stat.sh               |    4 ++--
 t/t5150-request-pull.sh             |    2 +-
 t/t7602-merge-octopus-many.sh       |    6 +++---
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index 9f00ada5..644aa219 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -174,7 +174,7 @@ EOF
 test_expect_success TABS_IN_FILENAMES 'git diff-tree rename with-funny applied' \
 	'git diff-index -M -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 test_cmp expected current'
+	 test_i18ncmp expected current'
 
 test_expect_success TABS_IN_FILENAMES 'setup expect' '
 cat > expected <<\EOF
@@ -187,12 +187,12 @@ EOF
 test_expect_success TABS_IN_FILENAMES 'git diff-tree delete with-funny applied' \
 	'git diff-index -p $t0 |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 test_cmp expected current'
+	 test_i18ncmp expected current'
 
 test_expect_success TABS_IN_FILENAMES 'git apply non-git diff' \
 	'git diff-index -p $t0 |
 	 sed -ne "/^[-+@]/p" |
 	 git apply --stat | sed -e "s/|.*//" -e "s/ *\$//" >current &&
-	 test_cmp expected current'
+	 test_i18ncmp expected current'
 
 test_done
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 1b3a3441..d909e6db 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -55,7 +55,7 @@ test_expect_success 'cherry-pick first..fourth works' '
 	git diff --quiet HEAD other &&
 
 	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
-	test_cmp expected actual.fuzzy &&
+	test_i18ncmp expected actual.fuzzy &&
 	check_head_differs_from fourth
 '
 
@@ -82,7 +82,7 @@ test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
 	git diff --quiet other &&
 	git diff --quiet HEAD other &&
 	sed -e "s/$_x05[0-9a-f][0-9a-f]/OBJID/" <actual >actual.fuzzy &&
-	test_cmp expected actual.fuzzy &&
+	test_i18ncmp expected actual.fuzzy &&
 	check_head_differs_from fourth
 '
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 663c60a1..c69e4da1 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -447,7 +447,7 @@ test_expect_success 'stash show - stashes on stack, stash-like argument' '
 	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'stash show -p - stashes on stack, stash-like argument' '
@@ -485,7 +485,7 @@ test_expect_success 'stash show - no stashes on stack, stash-like argument' '
 	 1 file changed, 1 insertion(+)
 	EOF
 	git stash show ${STASH_ID} >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 2d9f9a0c..008cf10a 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -25,11 +25,11 @@ cat > expected <<\EOF
 EOF
 test_expect_success 'diff without --binary' \
 	'git diff | git apply --stat --summary >current &&
-	 test_cmp expected current'
+	 test_i18ncmp expected current'
 
 test_expect_success 'diff with --binary' \
 	'git diff --binary | git apply --stat --summary >current &&
-	 test_cmp expected current'
+	 test_i18ncmp expected current'
 
 # apply needs to be able to skip the binary material correctly
 # in order to report the line number of a corrupt patch.
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index a6d18875..591ffbc0 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -19,7 +19,7 @@ test_expect_success setup '
 	 2 files changed, 2 insertions(+)
 	EOF
 	git diff --stat --stat-count=2 >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_done
diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
index 9b433de8..744b8e51 100755
--- a/t/t4100-apply-stat.sh
+++ b/t/t4100-apply-stat.sh
@@ -17,13 +17,13 @@ do
 	test_expect_success "$title" '
 		git apply --stat --summary \
 			<"$TEST_DIRECTORY/t4100/t-apply-$num.patch" >current &&
-		test_cmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
+		test_i18ncmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
 	'
 
 	test_expect_success "$title with recount" '
 		sed -e "$UNC" <"$TEST_DIRECTORY/t4100/t-apply-$num.patch" |
 		git apply --recount --stat --summary >current &&
-		test_cmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
+		test_i18ncmp "$TEST_DIRECTORY"/t4100/t-apply-$num.expect current
 	'
 done <<\EOF
 rename
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index ec5f7368..00109533 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -220,7 +220,7 @@ test_expect_success 'pull request format' '
 		git request-pull initial "$downstream_url" >../request
 	) &&
 	<request sed -nf fuzz.sed >request.fuzzy &&
-	test_cmp expect request.fuzzy
+	test_i18ncmp expect request.fuzzy
 
 '
 
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 5783ebf3..bce0bd37 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -66,7 +66,7 @@ EOF
 test_expect_success 'merge output uses pretty names' '
 	git reset --hard c1 &&
 	git merge c2 c3 c4 >actual &&
-	test_cmp actual expected
+	test_i18ncmp expected actual
 '
 
 cat >expected <<\EOF
@@ -80,7 +80,7 @@ EOF
 
 test_expect_success 'merge up-to-date output uses pretty names' '
 	git merge c4 c5 >actual &&
-	test_cmp actual expected
+	test_i18ncmp expected actual
 '
 
 cat >expected <<\EOF
@@ -97,7 +97,7 @@ EOF
 test_expect_success 'merge fast-forward output uses pretty names' '
 	git reset --hard c0 &&
 	git merge c1 c2 >actual &&
-	test_cmp actual expected
+	test_i18ncmp expected actual
 '
 
 test_done
-- 
1.7.9.2
