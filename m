From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] t: replace pulls with merges
Date: Sat, 14 Sep 2013 01:38:36 -0500
Message-ID: <1379140717-12940-5-git-send-email-felipe.contreras@gmail.com>
References: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjaV-0003fX-D5
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847Ab3INGoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:44:03 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:35756 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab3INGoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:44:01 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so2027126oag.10
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F+6jThMxroON527oGDpf7r+8bQmCQhUke6Zp1rNYy4w=;
        b=QDAfqjVBKshb29MtrEAx/zJSgFWf4gmT1JPjOLR5GJjI0krlK9jDj1oCpazPeuN/ei
         ZEb8bT1dGKLwtPA7qQh2QIwFx02CjKiOt5OnusCoUSrJM8U7hHPb0KfiJhafO+cpnRWE
         yiUJamZ7ivffYj93GdTcff09aeGe5etMK20+shK1a+v35rp8qOdF3p1eKwKUivfgZsDx
         DqJHG9jtk2EpNt1HqgahuF5mToF7c3ey3Rdg58jkOI5weaPmU3OH/erwezT9QJTjdyKo
         NJ3D0MvR3HiEtDszop0k0C4lJShmFqulf5XTQ7GDnFsvDygakVrpSxJbQyk1aaRP5FiJ
         xgzA==
X-Received: by 10.60.133.71 with SMTP id pa7mr15875484oeb.44.1379141040073;
        Fri, 13 Sep 2013 23:44:00 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm20426667obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:43:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234800>

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
1.8.4-fc
