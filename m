From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] cygwin: Remove the CYGWIN_V15_WIN32API build variable
Date: Sat, 27 Apr 2013 20:41:44 +0100
Message-ID: <517C29F8.7090709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5u-0000w5-EY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab3D0Trc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:32 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33192 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756498Ab3D0Tra (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:30 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 920BA384081;
	Sat, 27 Apr 2013 20:47:29 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D6D8A38407C;
	Sat, 27 Apr 2013 20:47:28 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:28 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222679>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile         | 7 -------
 compat/cygwin.c  | 5 -----
 config.mak.uname | 1 -
 3 files changed, 13 deletions(-)

diff --git a/Makefile b/Makefile
index 0f931a2..32c49ba 100644
--- a/Makefile
+++ b/Makefile
@@ -290,10 +290,6 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
-# Define CYGWIN_V15_WIN32API if you are using Cygwin v1.7.x but are not
-# using the current w32api packages. The recommended approach, however,
-# is to update your installation if compilation errors occur.
-#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
@@ -1449,9 +1445,6 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
-ifdef CYGWIN_V15_WIN32API
-	COMPAT_CFLAGS += -DCYGWIN_V15_WIN32API
-endif
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -Icompat/nedmalloc
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 871b41d..91ce5d4 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,14 +1,9 @@
 #define CYGWIN_C
 #define WIN32_LEAN_AND_MEAN
-#ifdef CYGWIN_V15_WIN32API
-#include "../git-compat-util.h"
-#include "win32.h"
-#else
 #include <sys/stat.h>
 #include <sys/errno.h>
 #include "win32.h"
 #include "../git-compat-util.h"
-#endif
 #include "../cache.h" /* to read configuration */
 
 /*
diff --git a/config.mak.uname b/config.mak.uname
index d78fd3d..28aa239 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -158,7 +158,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD = YesPlease
 		NO_IPV6 = YesPlease
 		OLD_ICONV = UnfortunatelyYes
-		CYGWIN_V15_WIN32API = YesPlease
 	endif
 	NO_THREAD_SAFE_PREAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
-- 
1.8.2
