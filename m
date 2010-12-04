From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 04/14] msvc: Fix macro redefinition warnings
Date: Sat, 04 Dec 2010 19:00:51 +0000
Message-ID: <4CFA8FE3.1050009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>, sschuberth@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 22:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POzDo-0000KS-KG
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 22:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab0LDVAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 16:00:40 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:42427 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755945Ab0LDVAj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Dec 2010 16:00:39 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1POysj-0001mO-pS; Sat, 04 Dec 2010 20:38:58 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162912>


Commit 4091bfc (MinGW: Add missing file mode bit defines,
28-12-2009) causes the msvc build to issue many additional
(currently 1008) macro redefinition warnings. The warnings
relate to the S_IRUSR, S_IWUSR, S_IXUSR and S_IRWXU macros.

In order to fix the warnings, we simply remove the offending
macro definitions which, for both msvc and MinGW, are not
required.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/mingw.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 99a7467..da316dc 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -14,12 +14,6 @@ typedef int socklen_t;
 #define S_ISLNK(x) (((x) & S_IFMT) == S_IFLNK)
 #define S_ISSOCK(x) 0
 
-#ifndef _STAT_H_
-#define S_IRUSR 0
-#define S_IWUSR 0
-#define S_IXUSR 0
-#define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
-#endif
 #define S_IRGRP 0
 #define S_IWGRP 0
 #define S_IXGRP 0
-- 
1.7.3
