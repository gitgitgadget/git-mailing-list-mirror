From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t/t9001: use egrep when regular expressions are involved
Date: Mon, 28 Jun 2010 17:46:22 -0500
Message-ID: <_N29gMstbxoMxTYcMQECjVdQPNE8os2yuDS4zgtxw7xeZoP8pckXHsBNVLrsPCEEMmoFN-o4mDU@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, trast@student.ethz.ch,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 29 00:47:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTN6g-0002vm-V1
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0F1WrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 18:47:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46548 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0F1WrI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 18:47:08 -0400
Received: by mail.nrlssc.navy.mil id o5SMkcoF027132; Mon, 28 Jun 2010 17:46:38 -0500
X-OriginalArrivalTime: 28 Jun 2010 22:46:38.0395 (UTC) FILETIME=[C4CFA0B0:01CB1713]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149869>

From: Brandon Casey <drafnel@gmail.com>

Supplying backslashed, extended regular expressions to grep is not
portable.  Use egrep instead.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9001-send-email.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 37610db..23597cc 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -943,7 +943,7 @@ test_expect_success 'asks about and fixes 8bit encodings' '
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
 	grep email-using-8bit stdout &&
 	grep "Which 8bit encoding" stdout &&
-	grep "Content\\|MIME" msgtxt1 >actual &&
+	egrep "Content|MIME" msgtxt1 >actual &&
 	test_cmp actual content-type-decl
 '
 
@@ -954,7 +954,7 @@ test_expect_success 'sendemail.8bitEncoding works' '
 	git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
-	grep "Content\\|MIME" msgtxt1 >actual &&
+	egrep "Content|MIME" msgtxt1 >actual &&
 	test_cmp actual content-type-decl
 '
 
@@ -966,7 +966,7 @@ test_expect_success '--8bit-encoding overrides sendemail.8bitEncoding' '
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
-	grep "Content\\|MIME" msgtxt1 >actual &&
+	egrep "Content|MIME" msgtxt1 >actual &&
 	test_cmp actual content-type-decl
 '
 
-- 
1.6.6.2
