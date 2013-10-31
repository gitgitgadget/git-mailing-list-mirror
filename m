From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/16] t: replace pulls with merges
Date: Thu, 31 Oct 2013 03:25:33 -0600
Message-ID: <1383211547-9145-3-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocP-00087Y-7M
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab3JaJcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:36 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49274 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3JaJce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:34 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp18so2776443obc.15
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yIWCYXrJxWuPKfB1toZyI9JTjbN8rEZ7LKwNuJ2ok/w=;
        b=SNmO2njKlRdXh5ZL4NzgvynfOUeTpu1vgx9qTg0sKwUbzjO393+ouFz+m01JdjfPko
         rFHeeUr9Svbsckaa60bDFGXy25tFOgR7SRu1jmkiXm8lP4UB6L1x2JuowwrGT5H7kl9z
         TK9KSBkma5lON2XI/sPB+kF4GB8hpjIT84N49LIM4IG8FjSNMbVMPKigoLprXLVbo+td
         ossGvY6YFucFvsm7j4RAXDPlGcaOGQYfAXKyGkqNFG5mlKGoO0hIw9TWCuz2mSMMDMA3
         qbWQnAYPKOaTnCI/PdGqfR3r9U7bHpDn3Bsy8sLo32zGborQ9Da1ralsHBdDZkqoGtKb
         BfgQ==
X-Received: by 10.60.44.239 with SMTP id h15mr1887468oem.22.1383211954182;
        Thu, 31 Oct 2013 02:32:34 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm4477411obj.8.2013.10.31.02.32.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237085>

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
index 718014d..e74b9ab 100755
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
1.8.4.2+fc1
