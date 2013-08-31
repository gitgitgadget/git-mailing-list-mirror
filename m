From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] t: replace pulls with merges
Date: Sat, 31 Aug 2013 17:38:09 -0500
Message-ID: <1377988690-23460-3-git-send-email-felipe.contreras@gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 00:43:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtso-00079V-Tb
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab3HaWnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:43:01 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:37114 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab3HaWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 18:42:57 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so3243593obc.35
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNtRGSRtcE9KcsJdhgmy51BiHxKWVl3+DdBTr4vMC9M=;
        b=MDb6TGaZFZnZEkeuIB+VwMF9JTeZFq8MXaUwx69LdSVTI2QtbLBbi4vNl1pls3Vlkj
         5lvbD0jhcQw0QpowZHr13/Oqyzzy8cmaKJGA0F2ySt99xUB3067dsQPHrMOHVkzrL/WH
         mMXu0E8P9d6oZWxH5vTE3z0xxi6dVjDp53GhsvPm4MKpf7Wd14Wtq9wrNdZPcKpAKaQf
         66RGFJHJeGYsanqT6p6spV3b6iKCXU3uMM7s1tjdMQS2E9WPt4L/CrDrxiRZGB+GLb7s
         KpzUt79n//qXUwYGQ/tgxXPqa8D90WNI24oeTxpGtV2wu/GjjT73wOF4So7Db/0i1/Ly
         0Skg==
X-Received: by 10.60.117.225 with SMTP id kh1mr11858880oeb.15.1377988976801;
        Sat, 31 Aug 2013 15:42:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z2sm5367020obi.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 31 Aug 2013 15:42:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233556>

This is what the code intended.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/annotate-tests.sh                    | 2 +-
 t/t4200-rerere.sh                      | 2 +-
 t/t9114-git-svn-dcommit-merge.sh       | 2 +-
 t/t9500-gitweb-standalone-no-errors.sh | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index d4e7f47..01deece 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -92,7 +92,7 @@ test_expect_success 'blame 2 authors + 1 branch2 author' '
 '
 
 test_expect_success 'merge branch1 & branch2' '
-	git pull . branch1
+	git merge branch1
 '
 
 test_expect_success 'blame 2 authors + 2 merged-in authors' '
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7f6666f..cf19eb7 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -172,7 +172,7 @@ test_expect_success 'first postimage wins' '
 	git show second^:a1 | sed "s/To die: t/To die! T/" >a1 &&
 	git commit -q -a -m third &&
 
-	test_must_fail git pull . first &&
+	test_must_fail git merge first &&
 	# rerere kicked in
 	! grep "^=======\$" a1 &&
 	test_cmp expect a1
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index f524d2f..d33d714 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -62,7 +62,7 @@ test_expect_success 'setup git mirror and merge' '
 	echo friend > README &&
 	cat tmp >> README &&
 	git commit -a -m "friend" &&
-	git pull . merge
+	git merge merge
 	'
 
 test_debug 'gitk --all & sleep 1'
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6fca193..3864388 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -328,7 +328,7 @@ test_expect_success \
 	 git add b &&
 	 git commit -a -m "On branch" &&
 	 git checkout master &&
-	 git pull . b &&
+	 git merge b &&
 	 git tag merge_commit'
 
 test_expect_success \
-- 
1.8.4-337-g7358a66-dirty
