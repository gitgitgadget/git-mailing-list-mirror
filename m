From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Mon, 23 Apr 2007 19:11:06 -0700
Message-ID: <462D673A.1010805@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB55EF180B7902967EBBEC4E3"
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 04:11:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgAVQ-0004i1-0A
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 04:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031023AbXDXCLn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 22:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031029AbXDXCLn
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 22:11:43 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:44321 "EHLO
	mail2.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031023AbXDXCLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 22:11:42 -0400
Received: (qmail 22960 invoked from network); 24 Apr 2007 02:11:41 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail2.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 24 Apr 2007 02:11:41 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45405>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB55EF180B7902967EBBEC4E3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ETC_GITCONFIG defaults to $(prefix)/etc/gitconfig, so if you just set
prefix=3D/usr or prefix=3D/usr/local, you end up with a git that looks in=

/usr/etc/gitconfig or /usr/local/etc/gitconfig.  That seems rather subopt=
imal.

Use ifeq in the Makefile to set ETC_GITCONFIG=3D/etc/gitconfig unless the=
 prefix
points to $HOME .

The builder can always override ETC_GITCONFIG, so this just makes the def=
ault
saner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 65bd2db..6e1ae95 100644
--- a/Makefile
+++ b/Makefile
@@ -141,7 +141,11 @@ prefix =3D $(HOME)
 bindir =3D $(prefix)/bin
 gitexecdir =3D $(bindir)
 template_dir =3D $(prefix)/share/git-core/templates/
-ETC_GITCONFIG =3D $(prefix)/etc/gitconfig
+ifeq ($(prefix),$(HOME))
+ETC_GITCONFIG =3D $(HOME)/etc/gitconfig
+else
+ETC_GITCONFIG =3D /etc/gitconfig
+endif
 # DESTDIR=3D
=20
 # default configuration for gitweb
--=20
1.5.1.1



--------------enigB55EF180B7902967EBBEC4E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGLWc6GJuZRtD+evsRAgjWAKCtKXeqwjiZuTXOvYLYH5Ja5LDofgCfd+OR
fy48z5jSz3KTX+H16WSQHXs=
=FCSr
-----END PGP SIGNATURE-----

--------------enigB55EF180B7902967EBBEC4E3--
