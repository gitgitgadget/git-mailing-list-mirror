From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] t7508: add a test for "git status" in a read-only repository
Date: Sat,  3 Apr 2010 12:11:57 +0200
Message-ID: <1270289517-32680-1-git-send-email-markus.heidelberg@web.de>
References: <7v1vex9mur.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 12:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny0JN-0000tb-O0
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 12:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0DCKKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 06:10:25 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:57186 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab0DCKKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 06:10:23 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3AB2515B6C489;
	Sat,  3 Apr 2010 12:10:11 +0200 (CEST)
Received: from [91.19.4.230] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1Ny0It-0001Kl-00; Sat, 03 Apr 2010 12:10:11 +0200
X-Mailer: git-send-email 1.7.0.4.304.gc2d16
In-Reply-To: <7v1vex9mur.fsf@alter.siamese.dyndns.org>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/ITuZGyotJmOQUjn1xRD8xfi2OGCRrLLM+foSv
	urEfnmO+rjg8VwDzxAQ2GNlR3N34j64//GBtphXxh9UtWT2o2e
	xPP08pbAe9K7Naj0CRiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143884>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/t7508-status.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c317bde..baa8d7b 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -703,4 +703,14 @@ test_expect_success 'commit --dry-run submodule summary (--amend)' '
 	test_cmp expect output
 '
 
+test_expect_success POSIXPERM 'status succeeds in a read-only repository' '
+	(
+		chmod a-w .git &&
+		git status
+	)
+	status=$?
+	chmod 775 .git
+	(exit $status)
+'
+
 test_done
-- 
1.7.0.4.304.gc2d16
