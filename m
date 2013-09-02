From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] t: replace pulls with merges
Date: Mon,  2 Sep 2013 17:17:54 -0500
Message-ID: <1378160278-14872-3-git-send-email-felipe.contreras@gmail.com>
References: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 00:22:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcWM-0000xA-E0
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759098Ab3IBWWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:22:51 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:56545 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab3IBWWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:22:49 -0400
Received: by mail-ob0-f180.google.com with SMTP id v19so4925977obq.39
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eG6txFzFFtpoaTVqvLHdQwZUoqz2pcl8okp+wpJQxbI=;
        b=orE180cSaMpqOYhoGRgx9KibUiYW/dkZXI7S+MEn9QSIcxfWZvugwg5t1dENobQk3g
         iveuLAM0rCB5/7OAdca69a3kxgG8XbVmqPhQr4JtruF6BGJFscoR94jjoS4P7z4F1zcB
         lYsFuRDd2qmI2k3hcpC7WZj9Ngpdnk0JbUDguhFlDH7JIS6HuKwSM0V86mb+oHbHi5b3
         p9cJJMLjeJfVPechyTXRsaAdxnhWrjAf6Y2GyWwXlhw3ZSnxUfBVh598ke2VK8kbuOAs
         Bn96xu/swz0tUO/h3MiaBa9p9Opsy0wDBqjVw99Qe7oV3bXQLhAcD7U4YPkIAlrwQUXI
         KG3w==
X-Received: by 10.60.42.168 with SMTP id p8mr36330oel.73.1378160568463;
        Mon, 02 Sep 2013 15:22:48 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm15149723obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:22:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233667>

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
1.8.4-338-gefd7fa6
