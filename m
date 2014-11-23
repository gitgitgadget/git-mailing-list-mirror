From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Sun, 23 Nov 2014 15:16:06 +0100
Message-ID: <5471EC26.3040705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ramsay@ramsay1.demon.co.uk, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 23 15:16:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsXxX-0005y5-1H
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 15:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbaKWOQL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 09:16:11 -0500
Received: from mout.web.de ([212.227.15.14]:58315 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbaKWOQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 09:16:10 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MQf2z-1XV3gQ2vZV-00U0U1; Sun, 23 Nov 2014 15:16:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Provags-ID: V03:K0:ykmkRif9aRy9jwnRMwAx7rRCNo7fEOdgoD/iHAME9KRWmPGNXNh
 ARuNCNqTGgDbBO9W6qk8Mm0RrRB6O0XJEr8hamJwW9QMFlebajyxtlCzRY+sXUotvcu9Fsr
 uTM3wbulFlZjhA5J4fj63aHUiFMdJSV4pAu3WnPFfOuMeQzCPKJaHma5XQeVCz1rjw1OHsF
 R3sBlehah2Ds6CQ4Osz3A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260087>

gcc under cygwin reports several warnings like this:
 warning: implicit declaration of function 'memmem'
  [-Wimplicit-function-declaration]
This has been observed under CYGWIN-32 with GCC 4.7.3 as well
as CYGWIN-64 with gcc v4.8.3-5 x86-64

Do not #define _XOPEN_SOURCE 600 for CYGWIN.

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
This may be a start for a patch, tested under CYGWIN-32,
both Windows7 and XP
 git-compat-util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 400e921..cef2691 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -75,7 +75,8 @@
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC_=
_) && \
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) =
&& \
-      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__)
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) =
&& \
+      !defined(__CYGWIN__)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD nee=
ds 600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
--=20
1.9.1.dirty
