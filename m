From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jc/maint-add-p-coalesce-fix] t3701: ensure correctly set up
 repository after skipped tests
Date: Mon, 25 May 2009 14:07:55 +0200
Message-ID: <4A1A8A1B.3040408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 14:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YyY-00067E-6L
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 14:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbZEYMII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 08:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbZEYMII
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 08:08:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56714 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbZEYMIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 08:08:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M8YyE-0001Ld-CK; Mon, 25 May 2009 14:08:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0215554D; Mon, 25 May 2009 14:07:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119930>

From: Johannes Sixt <j6t@kdbg.org>

There are two tests that are skipped if file modes are not obeyed by the
file system. In this case, the subsequent test failed because the
repository was in an unexpected state. This corrects it.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t3701-add-interactive.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5cdb83d..fd2a55a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -165,6 +165,12 @@ test_expect_success FILEMODE 'stage mode but

 # end of tests disabled when filemode is not usable

+test_expect_success 'setup again' '
+	git reset --hard &&
+	test_chmod +x file &&
+	echo content >>file
+'
+
 # Write the patch file with a new line at the top and bottom
 cat >patch <<EOF
 index 180b47c..b6f2c08 100644
-- 
1.6.3.1.1240.gc4fde
