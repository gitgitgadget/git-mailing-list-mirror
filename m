From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 06/19] mingw: try to delete target directory before
 renaming
Date: Sun, 24 Jan 2016 16:44:31 +0100 (CET)
Message-ID: <d75b0dc0b76beefee9e705555ca4f2fa4f4b96ce.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1286374471-1453650272=:2964"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:44:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqG-0000vV-4G
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbcAXPoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:44:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:60453 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbcAXPof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:44:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LvzF3-1a2Uw92Kuj-017p7n; Sun, 24 Jan 2016 16:44:32
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:oqi1tOg8SzxLz2/rheXTzWPyQ6982+buZHcUwxAyxufseEynuSL
 k3WX8PuGDw6FQ7aB2fMB+uKLmmX2KJV0UiPmiuc4nYr4wp3x8JpCmtmSicjvRE/O9ovPIlJ
 SZPfcC+ztQvf75Af3OeHM08sK5vQljFi50DixJr0y7I8cR95/kOetO1X78RVc7RoQfwBAaq
 2s7/zXq0ZZLcV1UzXC5wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gdgKLrqfSIQ=:gWfyii7d9U+ghNp+UojxaO
 ZzO4GWo9nWVSuvpdna8RzfNi4EJedmN7zp1q14ABb/9GqZxOV3BJlyQebqBZzDeMFfXilq43z
 i+2+Bp+5uiEHfbIDDW9r7jKEVOm5BaoMlm/sFJuq6lBeboh3N4jna+pXXRyUa6DenZ7X8l+/d
 RElLU7q6QieXrHmzXh8KyBAdwQrB7X+pSwwy5JiAC1/YS8OgRmKbOK7J6pTEBKO+mWciOquxo
 rZo5IQA624bo2B0EHjPGYFcr+Y7k+Cmv0UpkgDAXZvMLbNVeqpm8V53S8oRrAQUHPHVTx5kJJ
 Dx+ur9f4ICyYx7LnarDT8UUwUjplcwLpRbdLsU1Cnxbd2n4b3excBKPIBR3OhOuLDjhnsWVVn
 RlbxRYKuhrtRskpfOmoXy1aEiBWPBh7iIvxj8LArD41AV1ojUaqUlDn400l7PviTDsrZSrk2j
 7bsXMyGqrj9uSXeIdK7YQ1T2YKDxznCJg1hTyOeF8VdO3aqjh/GL4ostyLJkgPXDLdipPmn0D
 /Brkgbu/R56u8lB0B3SIRAUSy2/a+goTG00prZ/TRS3mPJvc0w5THMy32K2Z+wRKg7Fj/vhU/
 YBysgZXj4ampewnEal+c5vs3dkGIr7+3IpAW9Qdb5DBBPhfd5svik/EH/8dYBk9dd85h/KgMd
 uEeTd8IUkxYEMXZfVgV367YoQBkXixdccXmIKeA5TYF6b4kGMjzWWrCXXWlDPV3iX0Dls6D4G
 zvswXSwsaZBH1ds4m3P6aB+S+gjpMsqscMwQ1tPeB4e1JWgYdH9fs+3xkwYlQ8ZWP6NaMry6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284670>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1286374471-1453650272=:2964
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>

When the rename() function tries to move a directory it fails if the
target directory exists. It should check if it can delete the (possibly
empty) target directory and then try again to move the directory.

This partially fixes t9100-git-svn-basic.sh.

Signed-off-by: =B8=B6=B4=A9=BF=A4 <nalla@users.noreply.github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index db92f5d..e4839b9 100644
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


--8323329-1286374471-1453650272=:2964--
