From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/3] t7400: barf if git-submodule removes or replaces a file
Date: Sat,  9 Jun 2007 23:38:52 +0200
Message-ID: <11814251333211-git-send-email-hjemli@gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8c0-00008j-9G
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297AbXFIVgc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756996AbXFIVgb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:36:31 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:53455 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756794AbXFIVga (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:36:30 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id l59LaKTh006815;
	Sat, 9 Jun 2007 23:36:21 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <1181425132239-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49622>

The test for an unmolested file wouldn't fail properly if the file had been
removed or replaced by something other than a regular file. This fixes it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 t/t7400-submodule-basic.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3940433..74fafce 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -72,7 +72,7 @@ test_expect_success 'update should fail when path is used by a file' '
 	then
 		echo "[OOPS] update should have failed"
 		false
-	elif test -f lib && test "$(cat lib)" != "hello"
+	elif test "$(cat lib)" != "hello"
 	then
 		echo "[OOPS] update failed but lib file was molested"
 		false
-- 
1.5.2.1.914.gbd3a7
