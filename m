From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] configure.ac: Add missing comma to CC_LD_DYNPATH
Date: Tue,  9 Oct 2012 18:36:12 +0200
Message-ID: <1349800572-2963-1-git-send-email-sunny@sunbase.org>
References: <1349800026-10717-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stefano.lattarini@gmail.com, gitster@pobox.com,
	=?UTF-8?q? "=C3=98yvind=20A.=20Holm" ?= <sunny@sunbase.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 18:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLcnP-00020Z-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 18:36:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496Ab2JIQg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 12:36:29 -0400
Received: from smtp.domeneshop.no ([194.63.252.54]:57003 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2JIQg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 12:36:28 -0400
Received: from sunbase.org ([178.79.142.16] helo=linode.members.linode.com)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <sunny@sunbase.org>)
	id 1TLcn9-0006o1-Bw; Tue, 09 Oct 2012 18:36:23 +0200
X-Mailer: git-send-email 1.8.0.rc1
In-Reply-To: <1349800026-10717-1-git-send-email-sunny@sunbase.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207324>

=46rom: "=C3=98yvind A. Holm" <sunny@sunbase.org>

40bfbde ("build: don't duplicate substitution of make variables",
2012-09-11) breaks make by removing a necessary comma at the end of
"CC_LD_DYNPATH=3D-rpath" in line 414 and 423.

When executing "./configure --with-zlib=3DPATH", this resulted in

      [...]
      CC xdiff/xhistogram.o
      AR xdiff/lib.a
      LINK git-credential-store
  /usr/bin/ld: bad -rpath option
  collect2: ld returned 1 exit status
  make: *** [git-credential-store] Error 1
  $

during make.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index da1f41f..ea79ea2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -411,7 +411,7 @@ else
       LDFLAGS=3D"${SAVE_LDFLAGS}"
    ])
    if test "$git_cv_ld_wl_rpath" =3D "yes"; then
-      CC_LD_DYNPATH=3D-Wl,-rpath
+      CC_LD_DYNPATH=3D-Wl,-rpath,
    else
       AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
          SAVE_LDFLAGS=3D"${LDFLAGS}"
@@ -420,7 +420,7 @@ else
          LDFLAGS=3D"${SAVE_LDFLAGS}"
       ])
       if test "$git_cv_ld_rpath" =3D "yes"; then
-         CC_LD_DYNPATH=3D-rpath
+         CC_LD_DYNPATH=3D-rpath,
       else
          CC_LD_DYNPATH=3D
          AC_MSG_WARN([linker does not support runtime path to dynamic =
libraries])
--=20
1.8.0.rc1
