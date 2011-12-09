From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/9] t3510 (cherry-pick-sequencer): remove malformed sheet 2
Date: Fri,  9 Dec 2011 21:12:03 +0530
Message-ID: <1323445326-24637-7-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2bq-00016w-KQ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab1LIPnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:31 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41561 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab1LIPnb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:31 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so2223292qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5/fYS/tPpC7/yg77xHixgs6plHdCEXxN5RytWCxJVS0=;
        b=oshgHdC7jqe9ocm92ZpWBYgJTenqvhbBGo3gqOg0mm0y0j9lLNwQwq9i201f5K8DVI
         F9mKdfPnW98/lLcoNUNOyRmfRfdd6Sl4wkqq3wh1FfeKS3juIW/UkFXsN96+v+89HWS3
         HoI1tCCU8r4aMGAZWQBw+zxbPO4rXN5Eltxso=
Received: by 10.50.220.231 with SMTP id pz7mr3676840igc.94.1323445410182;
        Fri, 09 Dec 2011 07:43:30 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:29 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186645>

The next patch allows mixing "pick" and "revert" instruction in the
same instruction sheet.  By removing the "malformed instruction sheet
2" test in advance, it'll be easier to see the changes made by the
next patch.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3510-cherry-pick-sequence.sh |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 9ffc085..70fd54b 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -309,7 +309,7 @@ test_expect_success '--signoff is not automatically propagated to resolved confl
 	grep "Signed-off-by:" anotherpick_msg
 '
 
-test_expect_success 'malformed instruction sheet 1' '
+test_expect_success 'malformed instruction sheet, action' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
@@ -320,18 +320,7 @@ test_expect_success 'malformed instruction sheet 1' '
 	test_expect_code 128 git cherry-pick --continue
 '
 
-test_expect_success 'malformed instruction sheet 2' '
-	pristine_detach initial &&
-	test_expect_code 1 git cherry-pick base..anotherpick &&
-	echo "resolved" >foo &&
-	git add foo &&
-	git commit &&
-	sed "s/pick/revert/" .git/sequencer/todo >new_sheet &&
-	cp new_sheet .git/sequencer/todo &&
-	test_expect_code 128 git cherry-pick --continue
-'
-
-test_expect_success 'malformed instruction sheet 3' '
+test_expect_success 'malformed instruction sheet, object name' '
 	pristine_detach initial &&
 	test_expect_code 1 git cherry-pick base..anotherpick &&
 	echo "resolved" >foo &&
-- 
1.7.7.3
