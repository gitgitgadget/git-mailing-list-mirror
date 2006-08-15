From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: provide function to format the URL for an action link.
Date: Wed, 16 Aug 2006 00:23:50 +0200
Message-ID: <20060815222350.GC14459@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
X-From: git-owner@vger.kernel.org Wed Aug 16 00:24:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD7KF-0004Jr-Vb
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 00:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWHOWXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 18:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWHOWXw
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 18:23:52 -0400
Received: from agent.admingilde.org ([213.95.21.5]:27827 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750752AbWHOWXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 18:23:51 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GD7KA-0000ZX-UI
	for git@vger.kernel.org; Wed, 16 Aug 2006 00:23:51 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25489>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Provide a new function which can be used to generate an URL for the CGI.
This makes it possible to consolidate the URL generation in order to make
it easier to change the encoding of actions into URLs.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5b89de..726dd66 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -181,6 +181,33 @@ if (!defined($actions{$action})) {
 exit;
=20
 ## =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+## action links
+
+sub href(%) {
+	my %mapping =3D (
+		action =3D> "a",
+		project =3D> "p",
+		file_name =3D> "f",
+		hash =3D> "h",
+		hash_parent =3D> "hp",
+		hash_base =3D> "hb",
+		page =3D> "pg",
+		searchtext =3D> "s",
+	);
+
+	my %params =3D @_;
+	$params{"project"} ||=3D $project;
+
+	my $href =3D "$my_uri?";
+	$href .=3D esc_param( join(";",
+		map { "$mapping{$_}=3D$params{$_}" } keys %params
+	) );
+
+	return $href;
+}
+
+
+## =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 ## validation, quoting/unquoting and escaping
=20
 sub validate_input {
--=20
1.4.2.rc2.gf055

--=20
Martin Waitz

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE4kl2j/Eaxd/oD7IRAtzyAJ9QHaKB8tx+QSo0AvfpIbM2sHSQ+gCdGFFt
bK2LBzzLMYmEWefN+N+hbU0=
=e3xL
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
