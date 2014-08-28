From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 5/9] autoconf: Check for struct itimerval
Date: Thu, 28 Aug 2014 03:04:18 +0200
Message-ID: <1409187862-21257-6-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoKE-0005nC-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbaH1BQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:16:27 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59722 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373AbaH1BQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:16:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 488AC40001D69;
	Thu, 28 Aug 2014 01:06:14 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256064>

The makefile has provisions for this case, so let's detect it in
the configure script as well.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 31b3218..00842ae 100644
--- a/configure.ac
+++ b/configure.ac
@@ -761,6 +761,13 @@ AC_CHECK_TYPES([struct timespec],
 [#include <sys/time.h>])
 GIT_CONF_SUBST([NO_STRUCT_TIMESPEC])
 #
+# Define NO_STRUCT_ITIMERVAL if you don't have struct itimerval.
+AC_CHECK_TYPES([struct itimerval],
+[NO_STRUCT_ITIMERVAL=],
+[NO_STRUCT_ITIMERVAL=UnfortunatelyYes],
+[#include <sys/time.h>])
+GIT_CONF_SUBST([NO_STRUCT_ITIMERVAL])
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
-- 
2.1.0
