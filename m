From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] t: branch: fix broken && chains
Date: Fri, 30 Aug 2013 23:31:50 -0500
Message-ID: <1377923511-20787-4-git-send-email-felipe.contreras@gmail.com>
References: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 06:36:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFcvZ-00066U-9t
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 06:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969Ab3HaEgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 00:36:43 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50441 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381Ab3HaEgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 00:36:42 -0400
Received: by mail-ob0-f171.google.com with SMTP id tb18so2712871obb.30
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E/pOR7D26JHUAkhr5WQO5qknVa6Yvkwk7W4VI4GSVj0=;
        b=QC9NXTUFSp+AOmcfImlkY+ipQGjnEB2EJI72MDJQ28DfU13w1bGiMne1lgwxyvYqlz
         1fwmN7bmRTwKK/Ofazcs9ytV7Wh+Y6DVEjlCgjbmWvA8xwEnYmLUkj/oeB3nxGm6m1ze
         3VyLC0lRlwagCjpuJKUjiNqJ81lOgy3upYwM1fecBFMMWsCF0DxSGrlOl+WG2fMqO1DN
         0XfJJn9uNQ6PPuYgaU349YLzdEFblHDjUpGG13H4wbpRYJf6rMr2JqGlDdTQRDuklobF
         7ac9ocE/VYto1DdOpVewQ2M5Iky2pcpx2uUBVxy9Lzf7EVwvfJKBU4AQ2arrKRhv1Uf7
         FBAA==
X-Received: by 10.182.102.226 with SMTP id fr2mr9366592obb.57.1377923802001;
        Fri, 30 Aug 2013 21:36:42 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z2sm1744251obi.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 21:36:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377923511-20787-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233503>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3200-branch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3134652..d85306f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -425,14 +425,14 @@ test_expect_success '--set-upstream-to fails on a non-ref' '
 test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.master.remote foo &&
 	test_config branch.master.merge foo &&
-	git branch my12
+	git branch my12 &&
 	git branch --set-upstream-to my12 &&
 	test "$(git config branch.master.remote)" = "." &&
 	test "$(git config branch.master.merge)" = "refs/heads/my12"
 '
 
 test_expect_success 'use --set-upstream-to modify a particular branch' '
-	git branch my13
+	git branch my13 &&
 	git branch --set-upstream-to master my13 &&
 	test "$(git config branch.my13.remote)" = "." &&
 	test "$(git config branch.my13.merge)" = "refs/heads/master"
@@ -443,7 +443,7 @@ test_expect_success '--unset-upstream should fail if given a non-existent branch
 '
 
 test_expect_success 'test --unset-upstream on HEAD' '
-	git branch my14
+	git branch my14 &&
 	test_config branch.master.remote foo &&
 	test_config branch.master.merge foo &&
 	git branch --set-upstream-to my14 &&
@@ -465,7 +465,7 @@ test_expect_success '--unset-upstream should fail on detached HEAD' '
 '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
-	git branch my15
+	git branch my15 &&
 	git branch --set-upstream-to master my14 &&
 	git branch --unset-upstream my14 &&
 	test_must_fail git config branch.my14.remote &&
-- 
1.8.4-fc
