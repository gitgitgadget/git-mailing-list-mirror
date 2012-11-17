From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] Rename V15_MINGW_HEADERS into CYGWIN_OLD_WINSOCK_HEADERS
Date: Sat, 17 Nov 2012 08:09:49 +0100
Message-ID: <201211170809.50395.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mlevedahl@gmail.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 08:11:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZcYY-00076W-KU
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 08:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab2KQHJ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 02:09:58 -0500
Received: from mout.web.de ([212.227.17.11]:60182 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab2KQHJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 02:09:57 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MSs2H-1Th5JW1h37-00S2SS; Sat, 17 Nov 2012 08:09:55 +0100
X-Provags-ID: V02:K0:U/SA/tFZpUTIlH7BY+WZbC2YYostFX9MWHpgpmea0xZ
 8VtGlGe0LSaf66YaWyByUxUDa4ex4uC4i90Ld8O+P8nvqvNTnJ
 jYv6kp9RwlROOGIuoBne1ZJdN3xli2qnnzhqu63W0kU33NUhlu
 ImNY6yCkfoBK9uvTmnCc+KZrnedNC3aAkRXQaZLaFerydReYjC
 aGmSB1Fdt4jBJVtFCvc2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209931>

See commit 380a4d927bff693c42fc6b22c3547bdcaac4bdc3:
"Update cygwin.c for new mingw-64 win32 api headers"
Cygwin up to 1.7.16 uses some header file from the WINE project
Cygwin 1.7.17 uses some header file from the mingw-64 project
As the old cygwin (like 1.5) never used mingw,
the name V15_MINGW_HEADERS is confusing.
Rename it into CYGWIN_OLD_WINSOCK_HEADERS

Addtional note:
Cygwin versions 1.7.1 up to 1.7.16 are expected to upgrade to=20
Cygwin 1.7.17 or higher
As a temporary workaround make can be run as
CYGWIN_OLD_WINSOCK_HEADERS=3DYes make


Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Makefile        | 6 +++---
 compat/cygwin.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index c3edf8c..c2ea735 100644
--- a/Makefile
+++ b/Makefile
@@ -1089,7 +1089,7 @@ ifeq ($(uname_O),Cygwin)
 		NO_SYMLINK_HEAD =3D YesPlease
 		NO_IPV6 =3D YesPlease
 		OLD_ICONV =3D UnfortunatelyYes
-		V15_MINGW_HEADERS =3D YesPlease
+		CYGWIN_OLD_WINSOCK_HEADERS =3D YesPlease
 	endif
 	NO_THREAD_SAFE_PREAD =3D YesPlease
 	NEEDS_LIBICONV =3D YesPlease
@@ -1901,8 +1901,8 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS +=3D -Icompat/regex
 	COMPAT_OBJS +=3D compat/regex/regex.o
 endif
-ifdef V15_MINGW_HEADERS
-	COMPAT_CFLAGS +=3D -DV15_MINGW_HEADERS
+ifdef CYGWIN_OLD_WINSOCK_HEADERS
+	COMPAT_CFLAGS +=3D -DCYGWIN_OLD_WINSOCK_HEADERS
 endif
=20
 ifdef USE_NED_ALLOCATOR
diff --git a/compat/cygwin.c b/compat/cygwin.c
index 59d86e4..b9f2862 100644
--- a/compat/cygwin.c
+++ b/compat/cygwin.c
@@ -1,5 +1,5 @@
 #define WIN32_LEAN_AND_MEAN
-#ifdef V15_MINGW_HEADERS
+#ifdef CYGWIN_OLD_WINSOCK_HEADERS
 #include "../git-compat-util.h"
 #include "win32.h"
 #else
--=20
1.7.12
