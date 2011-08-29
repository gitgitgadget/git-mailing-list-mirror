From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/4] t4014: invoke format-patch with --stdout where intended
Date: Mon, 29 Aug 2011 22:10:47 +0200
Message-ID: <797b96d784211a9d26eac1a5f5f7f0388a2c6a3b.1314648438.git.trast@student.ethz.ch>
References: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:10:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8Ac-0005R6-7d
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab1H2UK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:10:56 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:55607 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754938Ab1H2UKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:10:51 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:49 +0200
Received: from localhost.localdomain (129.132.153.219) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:10:49 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
In-Reply-To: <bbfb7190ca0125798417f57f4d33b5443257e478.1314648438.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180339>

The test wrote something along the lines of 0001-foo.patch to output,
which of course never contained a signature.  Luckily the tested
behaviour is actually present.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4014-format-patch.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b4d4207..a45d4fb 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -698,8 +698,8 @@ test_expect_success 'format-patch --no-signature supresses signatures' '
 	! grep "^-- \$" output
 '
 
-test_expect_failure 'format-patch --signature="" supresses signatures' '
-	git format-patch --signature="" -1 >output &&
+test_expect_success 'format-patch --signature="" supresses signatures' '
+	git format-patch --stdout --signature="" -1 >output &&
 	check_patch output &&
 	! grep "^-- \$" output
 '
-- 
1.7.7.rc0.370.gdcae57
