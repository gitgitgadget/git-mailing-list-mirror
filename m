From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 3/4] Makefile: allow building without perl
Date: Sat, 4 Apr 2009 15:47:29 -0700
Message-ID: <20090404T224109Z@curie.orbis-terrarum.net>
References: <20090403192700.GA14965@coredump.intra.peff.net> <20090403193220.GC5547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 00:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqEfm-0001Yl-Cz
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 00:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbZDDWrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 18:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZDDWrg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 18:47:36 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:46233 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751465AbZDDWrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 18:47:35 -0400
Received: (qmail 647 invoked from network); 4 Apr 2009 22:47:32 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 04 Apr 2009 22:47:32 +0000
Received: (qmail 22469 invoked by uid 10000); 4 Apr 2009 15:47:29 -0700
Content-Disposition: inline
In-Reply-To: <20090403193220.GC5547@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115601>


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2009 at 03:32:20PM -0400, Jeff King wrote:
> For systems with a missing or broken perl, it is nicer to
> explicitly say "we don't want perl" because:
Part of the patch got missed. In the case of missing perl, we can detect it,
originally we had a compare of PERL_PATH for emptiness.

diff Makefile.orig Makefile
--- Makefile.orig
+++ Makefile
@@ -354,12 +354,6 @@ BUILT_INS +=3D git-whatchanged$X
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS =3D $(PROGRAMS) $(SCRIPTS)
=20
-# what 'all' will build but not install in gitexecdir
-OTHER_PROGRAMS =3D git$X
-ifndef NO_PERL
-OTHER_PROGRAMS +=3D gitweb/gitweb.cgi
-endif
-
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
        SHELL_PATH =3D /bin/sh
@@ -367,6 +361,18 @@ endif
 ifndef PERL_PATH
        PERL_PATH =3D /usr/bin/perl
 endif
+ifeq ($(wildcard $(PERL_PATH)),)
+PERL_PATH =3D
+NO_PERL =3D NoThanks
+NO_PERL_MAKEMAKER =3D NoThanks
+export NO_PERL NO_PERL_MAKEMAKER
+endif
+
+# what 'all' will build but not install in gitexecdir
+OTHER_PROGRAMS =3D git$X
+ifndef NO_PERL
+OTHER_PROGRAMS +=3D gitweb/gitweb.cgi
+endif

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknX44EACgkQPpIsIjIzwiycVQCgz15lfmMJFJ/z71E3m3EES2T5
tkUAoJO3xIwJv/hnvn2WnM0WSDasFMn8
=GzvI
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
