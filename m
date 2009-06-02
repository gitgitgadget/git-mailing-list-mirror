From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/4] t6030: add test case for "git bisect skip --ratio=x/y"
Date: Tue, 02 Jun 2009 22:16:33 +0200
Message-ID: <20090602201634.3630.34948.chriscool@tuxfamily.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 22:18:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBaRg-0008Np-3U
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705AbZFBURq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbZFBURo
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 16:17:44 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:44323 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198AbZFBURl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 16:17:41 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 7853E940183;
	Tue,  2 Jun 2009 22:17:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 6856A9401B7;
	Tue,  2 Jun 2009 22:17:32 +0200 (CEST)
X-git-sha1: 9fcf22ef8ac841877f4dbd060a22c4d68892e3bc 
X-Mailer: git-mail-commits v0.4.5
In-Reply-To: <20090602200731.3630.33652.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120541>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6030-bisect-porcelain.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 5254b23..79956e5 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -555,6 +555,18 @@ test_expect_success 'restricting bisection on one dir and a file' '
 	grep "$PARA_HASH4 is first bad commit" my_bisect_log.txt
 '
 
+test_expect_success 'skipping with skip ratio' '
+	git bisect start $PARA_HASH7 $HASH1 &&
+	para4=$(git rev-parse --verify HEAD) &&
+	test "$para4" = "$PARA_HASH4" &&
+        git bisect skip --ratio=1/2 &&
+	hash7=$(git rev-parse --verify HEAD) &&
+	test "$hash7" = "$HASH7" &&
+        git bisect skip --ratio=3 &&
+	para6=$(git rev-parse --verify HEAD) &&
+	test "$para6" = "$PARA_HASH6"
+'
+
 #
 #
 test_done
-- 
1.6.3.GIT
