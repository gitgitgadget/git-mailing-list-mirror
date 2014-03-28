From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH] MSVC: link in invalidcontinue.obj for better POSIX compatibility
Date: Fri, 28 Mar 2014 15:19:30 +0400
Message-ID: <1396005570-948-1-git-send-email-marat@slonopotamus.org>
References: <53354EE3.2050908@viscovery.net>
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 12:19:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTUpJ-0008Ts-13
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 12:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbaC1LTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 07:19:52 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:49312 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaC1LTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 07:19:51 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WTUpA-0002WZ-7r; Fri, 28 Mar 2014 15:19:48 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <53354EE3.2050908@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245380>

This patch fixes crashes caused by quitting from PAGER.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---

> Please do not cull the Cc list.

That was gmane web interface.

> The correct solution is to link against invalidcontinue.obj in the MSVC
> build. This is a compiler-provided object file that changes the default
> behavior to the "expected" kind, i.e., C runtime functions return EINVAL
> when appropriate instead of crashing the application.

Thanks for a hint.

 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 38c60af..8e7ec6e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -366,7 +366,7 @@ ifeq ($(uname_S),Windows)
 		compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
-	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
 	PTHREAD_LIBS =
 	lib =
 ifndef DEBUG
-- 
1.9.1
