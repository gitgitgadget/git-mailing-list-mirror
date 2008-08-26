From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/6] git svn info: tests: fix ptouch argument order in setup
Date: Tue, 26 Aug 2008 21:32:35 +0200
Message-ID: <1219779157-31602-5-git-send-email-trast@student.ethz.ch>
References: <1219779157-31602-1-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-2-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-3-git-send-email-trast@student.ethz.ch>
 <1219779157-31602-4-git-send-email-trast@student.ethz.ch>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 21:34:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY4JU-0004pl-Pk
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759587AbYHZTcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 15:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759623AbYHZTcq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 15:32:46 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:37853 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759589AbYHZTcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 15:32:43 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 26 Aug 2008 21:32:37 +0200
X-Mailer: git-send-email 1.6.0.1.169.g494a
In-Reply-To: <1219779157-31602-4-git-send-email-trast@student.ethz.ch>
X-OriginalArrivalTime: 26 Aug 2008 19:32:37.0239 (UTC) FILETIME=[7EF5F070:01C907B2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93809>

The arguments must be <gitwc-path> <svnwc-path>, otherwise it fails to
update the timestamps (without setting a failure exit code) and
results in bad test output later on.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t9119-git-svn-info.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 7798dcc..821507d 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -51,10 +51,10 @@ test_expect_success 'setup repository and import' '
 		git-svn fetch &&
 	cd .. &&
 	svn co "$svnrepo" svnwc &&
-	ptouch svnwc/file gitwc/file &&
-	ptouch svnwc/directory gitwc/directory &&
-	ptouch svnwc/symlink-file gitwc/symlink-file &&
-	ptouch svnwc/symlink-directory gitwc/symlink-directory
+	ptouch gitwc/file svnwc/file &&
+	ptouch gitwc/directory svnwc/directory &&
+	ptouch gitwc/symlink-file svnwc/symlink-file &&
+	ptouch gitwc/symlink-directory svnwc/symlink-directory
 	'
 
 test_expect_success 'info' "
-- 
1.6.0.1.96.g9307e.dirty
