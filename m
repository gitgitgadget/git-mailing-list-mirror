From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Make logerror() and loginfo() static
Date: Thu, 29 Sep 2005 16:53:14 -0400
Message-ID: <1128027194.24397.50.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 29 22:54:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL5Pa-0000nb-RE
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 22:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVI2Ux0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 16:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVI2Ux0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 16:53:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:30852 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751332AbVI2UxZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 16:53:25 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EL5P1-0001FO-89
	for git@vger.kernel.org; Thu, 29 Sep 2005 16:53:19 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EL5P0-0008Vg-5K
	for git@vger.kernel.org; Thu, 29 Sep 2005 16:53:14 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9506>

Make logerror() and loginfo() static

logerror() and loginfo() in daemon.c are never declared and never called
from other files, therefore they should be declared static.  Found by
sparse.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -57,7 +57,7 @@ static void logreport(int priority, cons
 	write(2, buf, buflen);
 }
 
-void logerror(const char *err, ...)
+static void logerror(const char *err, ...)
 {
 	va_list params;
 	va_start(params, err);
@@ -65,7 +65,7 @@ void logerror(const char *err, ...)
 	va_end(params);
 }
 
-void loginfo(const char *err, ...)
+static void loginfo(const char *err, ...)
 {
 	va_list params;
 	if (!verbose)


-- 
Regards,
Pavel Roskin
