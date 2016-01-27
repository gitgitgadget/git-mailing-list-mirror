From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 06/20] mingw: try to delete target directory before
 renaming
Date: Wed, 27 Jan 2016 17:19:29 +0100 (CET)
Message-ID: <2185537d1ded7926241414b32e553d7ce4cd2935.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-425594966-1453911570=:2964"
Cc: =?UTF-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSop-00029G-9w
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933550AbcA0QTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:58187 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932476AbcA0QTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:35 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lk7T8-1ZnT6e3M1C-00c7JN; Wed, 27 Jan 2016 17:19:30
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:O660UOSG1GocQb81JZh5TIz7d2ovKCMbgM9S0OtY+y9TAKDL9iI
 RDl0QTWHCM8Ws/W2cfibPua1yGMSx0IBMubb4SdsrtyiMt1xzEKi/+JJxjNdxXJ7YCk2DOK
 jen5AaeZA5zoWzp3kbouZrZ5aVO7lI54m0BoSYHHg0lJkwj1Xf/qANKCBKSiPLp8aXZvOSt
 wPPvrSuOucTFq2/Zvke+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zun9MH7k1Sw=:AZAU1YQRTEeokwh/3icslO
 hjxxXhOF63o4qpZ/xRWJo0HTznZXdgzGWWkiWbjnSywtTILlfkOvYbeXpH3kOq/octaJI7ZzM
 dmcuwqVHkB/qbtHeEpIl5gqQFQFtVs5C51bSfDY07VFsBkfQmsYm5Gr2rCKuDFYNW5ko6W/HM
 hKUxmYtAy8q2k60zfTxHzifufxtaOihhsi6oHIc1J5zCInzcLBaxnJew0NgpAkMcTxXMT9K0Y
 2DeVeIkKJZZ18gP87vhbsaZRajFPJiPeiDkP81aqDc9FD0UF4fwBpl3Td2HKaRdZVkmRgv/In
 z+BdH969D3RbE+SFEZTp3AhcGuPVdghKyMzWTw7LQFZQz2AKEUNbJU+slv8OgbUy6ZzQt4zKs
 MeZGsD1CTnJy5kCuiZOzH0SJ3jwxWfWw34e7+gmE3MdBUqZtnrvw2YW8bfQV1h/hT65+nKtRk
 UJVCbeo8tJKpJU+1D5uY96pYIw1Trcc1HTcIrrgRT6gopgS4lfofCYQY2xtmq3wMGYshQ0ZtF
 tQJjF0bXJJr0e64qIxkSsXUjRJX8Pwl33qF3kxzLIDBu3QXeGZB+Gw5pcdES5hoFbwF9lAfuZ
 UB3rTjSpFPmndk3QYnaStVRDmqW69BpnHcEzUf4rUpUOMG6ReUpGivkmRVdLncMkHXYYEwfA/
 5uJzNah6Pt8MkSplGAA4TMemqykhGLS7QLQbD1Ia9c1blXLE6wLHU4OQiXq+IFpad6/057p6S
 KI1O4s6ekphDby8nZ40DIs7jW8WlkmlBBXVovCmqc2CQz5XmgV6liJs6P98z8a7bo9PyIl/m 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284925>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-425594966-1453911570=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

From: =3D?UTF-8?q?=3DEB=3DA7=3D88=3DEB=3D88=3D84=3DEC=3D97=3D98?=3D <nalla@=
hamal.uberspace.de>

When the rename() function tries to move a directory it fails if the
target directory exists. It should check if it can delete the (possibly
empty) target directory and then try again to move the directory.

This partially fixes t9100-git-svn-basic.sh.

Signed-off-by: =EB=A7=88=EB=88=84=EC=97=98 <nalla@hamal.uberspace.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ba5cb1c..f37f8d5 100644
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


--8323329-425594966-1453911570=:2964--
