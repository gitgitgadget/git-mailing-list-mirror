From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: [PATCH v2] Correct references to /usr/bin/python which does not
 exist on FreeBSD
Date: Sun, 21 Mar 2010 12:01:50 -0700
Message-ID: <20100321190145.GA32578@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 20:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtQPW-0000WA-QP
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 20:02:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab0CUTCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 15:02:00 -0400
Received: from mail.geekisp.com ([216.168.135.169]:6540 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295Ab0CUTB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 15:01:59 -0400
Received: (qmail 10222 invoked by uid 1003); 21 Mar 2010 19:01:56 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 21 Mar 2010 19:01:56 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142850>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On FreeBSD, Python does not ship as part of the base system but is available
via the ports system, which install the binary in /usr/local/bin.
---
 Makefile                           |    6 +++++-
 contrib/fast-import/import-zips.py |    2 +-
 contrib/hg-to-git/hg-to-git.py     |    2 +-
 contrib/p4import/git-p4import.py   |    2 +-
 git_remote_helpers/Makefile        |    6 +++++-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 3a6c6ea..4f8fbf0 100644
--- a/Makefile
+++ b/Makefile
@@ -444,7 +444,11 @@ ifndef PERL_PATH
 	PERL_PATH =3D /usr/bin/perl
 endif
 ifndef PYTHON_PATH
-	PYTHON_PATH =3D /usr/bin/python
+	ifeq ($(uname_S),FreeBSD)
+		PYTHON_PATH =3D /usr/local/bin/python
+	else
+		PYTHON_PATH =3D /usr/bin/python
+	endif
 endif
=20
 export PERL_PATH
diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/impor=
t-zips.py
index 7051a83..82f5ed3 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
=20
 ## zip archive frontend for git-fast-import
 ##
diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 854cd94..046cb2b 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -1,4 +1,4 @@
-#! /usr/bin/python
+#!/usr/bin/env python
=20
 """ hg-to-git.py - A Mercurial to GIT converter
=20
diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-p4impo=
rt.py
index 0f3d97b..b6e534b 100644
--- a/contrib/p4import/git-p4import.py
+++ b/contrib/p4import/git-p4import.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 #
 # This tool is copyright (c) 2006, Sean Estabrooks.
 # It is released under the Gnu Public License, version 2.
diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index c62dfd0..74b05dc 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -7,7 +7,11 @@ pysetupfile:=3Dsetup.py
 DESTDIR_SQ =3D $(subst ','\'',$(DESTDIR))
=20
 ifndef PYTHON_PATH
-	PYTHON_PATH =3D /usr/bin/python
+	ifeq ($(uname_S),FreeBSD)
+		PYTHON_PATH =3D /usr/local/bin/python
+	else
+		PYTHON_PATH =3D /usr/bin/python
+	endif
 endif
 ifndef prefix
 	prefix =3D $(HOME)
--=20
1.6.4.3

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkumbRkACgkQFCbH3D9R4W/c2ACeJ3OmB3PJ+s7WYbgsbnn/i1Xu
7DIAoJfCu4Brg0C1Gjm1D8Mv0qVwwg93
=/mHv
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
