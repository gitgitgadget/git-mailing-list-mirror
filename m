From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: [PATCH Cogito] Fix 'cg-*-id' to make 'make-cg-asciidoc' happy
Date: Wed, 5 Oct 2005 18:03:58 +0200
Message-ID: <20051005160358.GA9870@ferdyx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
X-From: git-owner@vger.kernel.org Wed Oct 05 18:06:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBkb-0005Gl-0X
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVJEQEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVJEQEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:04:09 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:31716
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S1030198AbVJEQEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 12:04:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 58CBE8D318
	for <git@vger.kernel.org>; Wed,  5 Oct 2005 18:04:02 +0200 (CEST)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01351-08 for <git@vger.kernel.org>;
	Wed, 5 Oct 2005 18:03:58 +0200 (CEST)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id 665968D314
	for <git@vger.kernel.org>; Wed,  5 Oct 2005 18:03:57 +0200 (CEST)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Wed,  5 Oct 2005 18:04:00 +0200 (CEST)
To: GIT Mailing List <git@vger.kernel.org>
Mail-Followup-To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9715>


--xgyAXRrhYN0wYx8y
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi !

When bumping the Gentoo package to cogito-0.15 I came accross a
problem while making the documentation. cg-tree-id, cg-parent-id and
cg-commit-id didn't have an USAGE variable because they don't use it;
however this breaks the documentation generation.

This trivial patch fixes it.

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cogito-0.15-doc.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur cogito-0.15.old/cg-commit-id cogito-0.15/cg-commit-id
--- cogito-0.15.old/cg-commit-id	2005-09-19 02:46:25.000000000 +0200
+++ cogito-0.15/cg-commit-id	2005-10-05 17:22:26.000000000 +0200
@@ -5,6 +5,8 @@
 #
 # Takes the appropriate ID, defaults to HEAD.
=20
+USAGE=3D"cg-commit-id [id]"
+
 id=3D"$1"
 normid=3D$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=3D${normid#* }
diff -ur cogito-0.15.old/cg-parent-id cogito-0.15/cg-parent-id
--- cogito-0.15.old/cg-parent-id	2005-09-19 02:46:25.000000000 +0200
+++ cogito-0.15/cg-parent-id	2005-10-05 17:24:55.000000000 +0200
@@ -7,5 +7,7 @@
 #
 # NOTE: Will return multiple SHA1s if ID is a commit with multiple parents.
=20
+USAGE=3D"cg-parent-id [id]"
+
 normid=3D$(. ${COGITO_LIB}cg-Xnormid "$1"^)
 echo ${normid%% *}
diff -ur cogito-0.15.old/cg-tree-id cogito-0.15/cg-tree-id
--- cogito-0.15.old/cg-tree-id	2005-09-19 02:46:25.000000000 +0200
+++ cogito-0.15/cg-tree-id	2005-10-05 17:25:59.000000000 +0200
@@ -5,6 +5,8 @@
 #
 # Takes ID of the appropriate commit, defaults to HEAD.
=20
+USAGE=3D"cg-tree-id [id]"
+
 id=3D"$1"
 normid=3D$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 type=3D${normid#* }
Only in cogito-0.15.old/: cogito.spec

--7AUc2qLy4jB3hD7Z--

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDQ/luCkhbDGC9KNQRApmvAJ429ZaBIsyoMalaVGeyHPErGo0NYgCfYCGM
GiQV+xHQeBV+SkdA0yqkVIQ=
=6mmb
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
