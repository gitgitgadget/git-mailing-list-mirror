From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 2/9] autoconf: Check for struct itimerval
Date: Fri, 29 Aug 2014 09:42:34 -0700
Message-ID: <1409330561-11806-2-git-send-email-jacob.e.keller@intel.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPH7-0007qr-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbaH2Qnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:43:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:57264 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbaH2QnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:43:22 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378757883"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:38:37 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256161>

From: Jonas 'Sortie' Termansen <sortie@maxsi.org>

The makefile has provisions for this case, so let's detect it in
the configure script as well.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 configure.ac | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure.ac b/configure.ac
index 4b1ae7c3c9f5..652bfdddb2a9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -746,6 +746,14 @@ case $ac_cv_type_socklen_t in
 esac
 GIT_CONF_SUBST([SOCKLEN_T])
 
+#
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
2.0.1.475.g9b8d714
