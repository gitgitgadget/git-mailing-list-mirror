From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 06/19] mingw: try to delete target directory before
 renaming
Date: Tue, 26 Jan 2016 15:34:47 +0100 (CET)
Message-ID: <136a54ce9ad696a287b47bd2c9711c252a61f38c.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2058225587-1453818887=:2964"
Cc: =?EUC-KR?B?uLa0qb+k?= <nalla@hamal.uberspace.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4hx-0004XC-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966282AbcAZOe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:34:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:54922 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966162AbcAZOew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MTkNU-1aWygh3ZnE-00QVWA; Tue, 26 Jan 2016 15:34:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:f+hgeTz+KY1Ylrs6OSN0rP+TA4eUE1s43RN/eo+2q+Hr4WCDrQU
 uKL4StP/sRkAMvaRLJB/9ASilgCXyIdpfaMSCi1S+UWtQ15KB6LdJQh6NqUP82TY4WWAail
 NIWlhgpIa/HCXAnG20utzK8KyDerDW2wZSUCu1H+BC+o7G8ltZ5WGuICnLKT2VQ2GnNOSDi
 GafHj8SPbWjo2u4KIqh/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8J6IzVogro8=:R4Wyv09mbS9T1rvT4MQ/Ks
 gbr76VC8c21V6IleA2mp0Wiy6+5jwb+zde/rYFDlqQD5MZaprpQ2ZP91X7AezOA2cmmMRtND9
 CuKBQts+isMkaokHiwxm/GcDUWC3BnRSBNlHlA4yiIaCV+ujdlZVBJIcKjHrv/hQhFwtecruK
 PCp7zm5z73vZeVt8lCbe7VJCu1mH/9ShQ0+hySFvBkBk394oW/2vtKYiLq+xyZ7vQsWXU+rux
 slX37W8oL2QB5Uan8pY+KpLUuyoY8CECPrQLcleFppuOovcze68z54hWQiryEjqoqlVtapwcX
 KD1DF1SFkVeYsQnMcTE5pJUGIKWJcOtQMWDODoeLOIS6Q8N91BlxYHNsPzGWE9bSeKc9MlYAt
 KWSSeGmIiF3TSkDLIdi9GSHc3crkyHMZGR4m084gVRn5tgAKRFz59GSg+Gzq+moo4aePQz2YZ
 9VmDYVCi2lVdEJlkfqIXHLFIF8unhlwvPusTD7ltAnQKjRKrhVVgnLG7VetNprzzKciGlI+e8
 OJgiomKJMsHaqvQ0gUw3M6Qj38ZH42BnHrBLlEm4QNgIemEoS/v4vQqgZPiqxqtPuJfpyxLY9
 xGBNyKYMaPN6jsmRkY9xItF7is1+FnAQ2eaCss0GNaA4V3ZSxQafcS2zWgTf6MGhvFbeMq+9z
 X4HAEj+9F/IYD1ZeR56SZFdaMFXHr9BO7pjCVYPGXGyXWUWqE0yhIMFLYajXXkTVxM6Di/6Up
 qTFznpQ6XvxtCp9j0JJ0bgcI/ZDwWJ8GFTtKjXR1FUAijCIxk4D5cm1/oWHXG09EP4GhVrgT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284817>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2058225587-1453818887=:2964
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =3D?UTF-8?q?=3DEB=3DA7=3D88=3DEB=3D88=3D84=3DEC=3D97=3D98?=3D <nalla@=
hamal.uberspace.de>

When the rename() function tries to move a directory it fails if the
target directory exists. It should check if it can delete the (possibly
empty) target directory and then try again to move the directory.

This partially fixes t9100-git-svn-basic.sh.

Signed-off-by: =B8=B6=B4=A9=BF=A4 <nalla@hamal.uberspace.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ba6bdb5..11b905d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1603,7 +1603,12 @@ repeat:
 =09if (gle =3D=3D ERROR_ACCESS_DENIED &&
 =09    (attrs =3D GetFileAttributesW(wpnew)) !=3D INVALID_FILE_ATTRIBUTES)=
 {
 =09=09if (attrs & FILE_ATTRIBUTE_DIRECTORY) {
-=09=09=09errno =3D EISDIR;
+=09=09=09DWORD attrsold =3D GetFileAttributesW(wpold);
+=09=09=09if (attrsold =3D=3D INVALID_FILE_ATTRIBUTES ||
+=09=09=09    !(attrsold & FILE_ATTRIBUTE_DIRECTORY))
+=09=09=09=09errno =3D EISDIR;
+=09=09=09else if (!_wrmdir(wpnew))
+=09=09=09=09goto repeat;
 =09=09=09return -1;
 =09=09}
 =09=09if ((attrs & FILE_ATTRIBUTE_READONLY) &&
--=20
2.7.0.windows.1.7.g55a05c8


--8323329-2058225587-1453818887=:2964--
