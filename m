From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/20] t: replace pulls with merges
Date: Sat, 12 Oct 2013 02:07:12 -0500
Message-ID: <1381561636-20717-17-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOo-0005yB-HY
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab3JLHOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:01 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:64950 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3JLHN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:58 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so3126666oag.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DvwbMEtKDLS0izsPI8F4kK2mYjzXW3G3ORZzzyfP+Yg=;
        b=xARc/50sZovSlAZoZCKACGl3NMiwdYP2Fc+rIwaCVHksK+m9AXxgekv3KMySPuuQeu
         Zdfybsd2OD1L0jE+PIgRep9U9dqp7DhgzkCDn3Sl0iEmP3nVDA4UuQsxI1n8mV8JPnuK
         bZbl7/xwpDw8vDHsXYyAYdJlBrdOREYY/Ad5+htHqHYZbQ+VdFNtcZUwMrq9SwS995Sb
         TL3J1nAO6VqIKtK0CeKYq98Au21Mm0Fd2DkAJoM6cCfXw6wnm3AyAfB0Z8MR0qkyAjPO
         1u9nlhrToVGfqTaiNarYw9ECVfW8+Zl/XYTQeREwOEBa7OtfAPD0+Czsfyt+vM/VXJQM
         gi3w==
X-Received: by 10.60.145.207 with SMTP id sw15mr13715587oeb.38.1381562038542;
        Sat, 12 Oct 2013 00:13:58 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm28677843obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236024>

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
index 99caa42..c9d105d 100644
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
