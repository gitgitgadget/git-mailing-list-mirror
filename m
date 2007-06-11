From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/5] t7400: barf if git-submodule removes or replaces a file
Date: Mon, 11 Jun 2007 21:12:21 +0200
Message-ID: <11815891451258-git-send-email-hjemli@gmail.com>
References: <11815891453464-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:10:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpHp-0007lx-P9
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbXFKTK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbXFKTK1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:10:27 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:41069 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414AbXFKTKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:10:25 -0400
Received: from localhost.localdomain (ti231210a341-2365.bb.online.no [85.166.53.63])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l5BJ9pBQ025419;
	Mon, 11 Jun 2007 21:09:51 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <11815891453464-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49875>

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
