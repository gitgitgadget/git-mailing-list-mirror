From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/5] test: trivial cleanups
Date: Tue, 28 May 2013 07:54:29 -0500
Message-ID: <1369745671-22418-4-git-send-email-felipe.contreras@gmail.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 14:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJS9-0001E5-Nn
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938Ab3E1M4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:56:35 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49549 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3E1M4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:56:34 -0400
Received: by mail-oa0-f54.google.com with SMTP id o17so9785205oag.41
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=b0++qS7opseABzSH6i2C56YbV3KparDlUdgUGSaSdy4=;
        b=NbaW1mlyOguMaGddIGhmNnocCdaFBhb0ZCsxWoNTtNhUvREfyEDsqW8YT2as6FGa18
         Gx5ZOLG+LXyMSUF9uEhazyp6Km/fOGClELe0iuVT6dQWGvvxm/TaM37Jgg1ot+lTpKJC
         glFk45FB54DMvEIyIEVrJ3WqCRHNW/AeLIrquAPFd31pBpjyeCPL/kgKgJyCcYRmabbs
         QrZj5ibulu5Cj5l/YLbWBWy6xyPuv9xt+vnnZBE6S+QaMfQ1y8j1REMKz+2f6T9xaw6R
         HOKPPm/UjxQno4OThEWE5DPJwV4DsF0NT41t9EbtdUY1Dtt03oA49bXjYuqhBS56dWRz
         FKQw==
X-Received: by 10.60.125.201 with SMTP id ms9mr20574234oeb.65.1369745793796;
        Tue, 28 May 2013 05:56:33 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jw8sm34431479obb.14.2013.05.28.05.56.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:56:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225636>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3403-rebase-skip.sh       |  7 ++++---
 t/t3505-cherry-pick-empty.sh | 18 +++++-------------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 826500b..3968020 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -64,10 +64,11 @@ test_expect_success 'rebase with --merge' '
 
 test_expect_success 'rebase --skip with --merge' '
 	git rebase --skip
-	'
+'
 
-test_expect_success 'merge and reference trees equal' \
-	'test -z "`git diff-tree skip-merge skip-reference`"'
+test_expect_success 'merge and reference trees equal' '
+	test -z "`git diff-tree skip-merge skip-reference`"
+'
 
 test_expect_success 'moved back to branch correctly' '
 	test refs/heads/skip-merge = $(git symbolic-ref HEAD)
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index a0c6e30..fbdc47c 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -28,29 +28,21 @@ test_expect_success setup '
 '
 
 test_expect_success 'cherry-pick an empty commit' '
-	git checkout master && {
-		git cherry-pick empty-branch^
-		test "$?" = 1
-	}
+	git checkout master &&
+	test_expect_code 1 git cherry-pick empty-branch^
 '
 
 test_expect_success 'index lockfile was removed' '
-
 	test ! -f .git/index.lock
-
 '
 
 test_expect_success 'cherry-pick a commit with an empty message' '
-	git checkout master && {
-		git cherry-pick empty-branch
-		test "$?" = 1
-	}
+	git checkout master &&
+	test_expect_code 1 git cherry-pick empty-branch
 '
 
 test_expect_success 'index lockfile was removed' '
-
 	test ! -f .git/index.lock
-
 '
 
 test_expect_success 'cherry-pick a commit with an empty message with --allow-empty-message' '
@@ -101,7 +93,7 @@ test_expect_success 'cherry-pick a no-op with --keep-redundant' '
 	git reset --hard &&
 	git checkout fork^0 &&
 	git cherry-pick --keep-redundant-commits master &&
-	git show -s --format='%s' >actual &&
+	git show -s --format=%s >actual &&
 	echo "add file2 on master" >expect &&
 	test_cmp expect actual
 '
-- 
1.8.3.rc3.312.g47657de
