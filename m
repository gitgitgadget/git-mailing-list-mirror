From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 7/9] autoconf: Check for setitimer
Date: Thu, 28 Aug 2014 03:04:20 +0200
Message-ID: <1409187862-21257-8-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoKF-0005nC-4W
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbaH1BQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:16:28 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59724 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056AbaH1BQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:16:25 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id C97BE40001D6B;
	Thu, 28 Aug 2014 01:06:14 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256065>

The makefile has provisions for this case, so let's detect it in the
configure script as well.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3c64251..89eb48f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -939,6 +939,12 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 #
+# Define NO_SETITIMER if you don't have setitimer.
+GIT_CHECK_FUNC(setitimer,
+[NO_SETITIMER=],
+[NO_SETITIMER=YesPlease])
+GIT_CONF_SUBST([NO_SETITIMER])
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
-- 
2.1.0
