From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] bisect: add test to check that revs are properly parsed
Date: Thu, 25 Dec 2014 19:25:33 +0100
Message-ID: <20141225182534.32540.99486.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 19:41:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y4DLV-00081O-8a
	for gcvg-git-2@plane.gmane.org; Thu, 25 Dec 2014 19:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbaLYSkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2014 13:40:18 -0500
Received: from delay-1y.bbox.fr ([194.158.98.16]:61137 "EHLO delay-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbaLYSkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2014 13:40:17 -0500
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Dec 2014 13:40:17 EST
Received: from mail-2y.bbox.fr (bt8sssoo.cs.dolmen.bouyguestelecom.fr [172.24.208.129])
	by delay-1y.bbox.fr (Postfix) with ESMTP id 9A81C8FFB4
	for <git@vger.kernel.org>; Thu, 25 Dec 2014 19:29:36 +0100 (CET)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id DBB8342;
	Thu, 25 Dec 2014 19:29:34 +0100 (CET)
X-git-sha1: aabe5542ae8be690fe9933b9c2d61b4d0a64b4fc 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261822>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 064f5ce..e6abe65 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -779,4 +779,13 @@ test_expect_success 'bisect log: only skip commits left' '
 	git bisect reset
 '
 
+test_expect_success '"git bisect bad HEAD" behaves as "git bisect bad"' '
+	git checkout parallel &&
+	git bisect start HEAD $HASH1 &&
+	git bisect good HEAD &&
+	git bisect bad HEAD &&
+	test "$HASH6" = $(git rev-parse --verify HEAD) &&
+	git bisect reset
+'
+
 test_done
-- 
2.1.2.555.gfbecd99
