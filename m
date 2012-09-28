From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 15/21] git p4 test: disable chmod test for cygwin
Date: Fri, 28 Sep 2012 08:04:19 -0400
Message-ID: <1348833865-6093-16-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZNz-0003dg-QI
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab2I1MJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:09:30 -0400
Received: from honk.padd.com ([74.3.171.149]:58374 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab2I1MJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:09:30 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id A29545AF2;
	Fri, 28 Sep 2012 05:09:29 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4C89B31413; Fri, 28 Sep 2012 08:09:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206573>

It does not notice chmod +x or -x; there is nothing
for this test to do.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9815-git-p4-submit-fail.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index d2b7b3d..2db1bf1 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -400,7 +400,9 @@ test_expect_success 'cleanup rename after submit cancel' '
 	)
 '
 
-test_expect_success 'cleanup chmod after submit cancel' '
+# chmods are not recognized in cygwin; git has nothing
+# to commit
+test_expect_success NOT_CYGWIN 'cleanup chmod after submit cancel' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
-- 
1.7.12.1.403.g28165e1
