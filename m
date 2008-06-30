From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: [PATCH] Skip unwritable tests for root
Date: Mon, 30 Jun 2008 07:05:51 +0000
Message-ID: <1214809551-14603-1-git-send-email-ferdy@ferdyx.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 09:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDDeR-0003hY-1l
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbYF3HRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 03:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYF3HRO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:17:14 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:48129
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYF3HRN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 03:17:13 -0400
X-Greylist: delayed 679 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2008 03:17:12 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 1713E8D314;
	Mon, 30 Jun 2008 09:09:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ferdyx.org
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGo2Yvd4Wome; Mon, 30 Jun 2008 09:09:19 +0200 (CEST)
Received: from localhost.localdomain (ares.ferdyx.org [192.168.0.4])
	by smtp.ferdyx.org (Postfix) with ESMTP id BCDD78D307;
	Mon, 30 Jun 2008 09:09:19 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86885>

Signed-off-by: Fernando J. Pereda <ferdy@ferdyx.org>
---
 t/t0004-unwritable.sh |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 9255c63..728ec22 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -4,6 +4,13 @@ test_description='detect unwritable repository and fail correctly'
 
 . ./test-lib.sh
 
+if test "$(id -u)" -eq 0
+then
+	test_expect_success 'root writes to unwritable places, skipping test' :
+	test_done
+	exit
+fi
+
 test_expect_success setup '
 
 	>file &&
-- 
1.5.6.1
