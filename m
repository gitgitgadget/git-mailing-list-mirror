From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] zlib in custom location
Date: Fri, 27 Jul 2007 08:14:56 +0200
Message-ID: <20070727061456.GD30038@schiele.dyndns.org>
References: <20070727054251.GC30038@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 08:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEJ6m-0004u3-5g
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 08:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbXG0GPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 02:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXG0GPE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 02:15:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4049 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbXG0GPB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 02:15:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so658372ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 23:15:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=RrTaEMvC3wqSgAdQPGF+QLsj8mJeZbyXcriDtGjQQINjggqR9K2E56ytDrAMVqK/l39iIqoEHS1ZTQN06+tjeY4NkFi3NasHpaoOn+527cB3mZi0kycdnkZF0RCCDdVARfsYoVfc219VhicpBe2a7690mMdKmpfoW0fUMZjGaQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=YcSIjkUoVDocBx1Zs5fZZtn5SgXIK1vgjBpBHXCBAco+s5vdMs0K8GYQ5jTcdfqUNF5q8Lf741fMShx3QwuRTpaV4rF3eJjdgbSZlIoU35+NqJLEX9wkyrwWuVUD2eVSNDOw/r3BnehRCXY3Z1iRg1XYYTYG0T6Ljn9oEGr8+qE=
Received: by 10.86.60.7 with SMTP id i7mr1700383fga.1185516900044;
        Thu, 26 Jul 2007 23:15:00 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.92.138])
        by mx.google.com with ESMTPS id 34sm10336024nfu.2007.07.26.23.14.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2007 23:14:59 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 98182B973C9; Fri, 27 Jul 2007 08:14:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070727054251.GC30038@schiele.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53900>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2007 at 07:42:51AM +0200, Robert Schiele wrote:
> Hi,
>=20
> I have some systems with zlib in a custom location and thus did the follo=
wing
> change to support a variable ZLIBDIR like it does already exist for
> OPENSSLDIR.  Would be great to see this in the main tree.

Just to follow up this change I have another one:

Since some Linux archs use different names for the library directory than
"lib" (like "lib64") I made this a config variable as well.  Currently this=
 is
only an issue if you use custom directories for libraries used by git.

commit a1cffe56cc9092443cd8bd03b18eb7e222528e35
Author: Robert Schiele <rschiele@gmail.com>
Date:   Thu Jul 26 23:08:47 2007 -0700

    - make the name of the library directory a config option

diff --git a/Makefile b/Makefile
index 0179339..64c0a59 100644
--- a/Makefile
+++ b/Makefile
@@ -151,6 +151,7 @@ sysconfdir =3D /etc
 else
 sysconfdir =3D $(prefix)/etc
 endif
+lib =3D lib
 ETC_GITCONFIG =3D $(sysconfdir)/gitconfig
 # DESTDIR=3D
=20
@@ -170,7 +171,7 @@ GITWEB_FAVICON =3D git-favicon.png
 GITWEB_SITE_HEADER =3D
 GITWEB_SITE_FOOTER =3D
=20
-export prefix bindir gitexecdir sharedir template_dir sysconfdir
+export prefix bindir gitexecdir sharedir template_dir sysconfdir lib
=20
 CC =3D gcc
 AR =3D ar
@@ -499,9 +500,9 @@ endif
=20
 ifndef NO_CURL
 	ifdef CURLDIR
-		# Try "-Wl,-rpath=3D$(CURLDIR)/lib" in such a case.
+		# Try "-Wl,-rpath=3D$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS +=3D -I$(CURLDIR)/include
-		CURL_LIBCURL =3D -L$(CURLDIR)/lib $(CC_LD_DYNPATH)$(CURLDIR)/lib -lcurl
+		CURL_LIBCURL =3D -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -=
lcurl
 	else
 		CURL_LIBCURL =3D -lcurl
 	endif
@@ -519,7 +520,7 @@ endif
=20
 ifdef ZLIBDIR
 	BASIC_CFLAGS +=3D -I$(ZLIBDIR)/include
-	EXTLIBS +=3D -L$(ZLIBDIR)/lib $(CC_LD_DYNPATH)$(ZLIBDIR)/lib
+	EXTLIBS +=3D -L$(ZLIBDIR)/$(lib) $(CC_LD_DYNPATH)$(ZLIBDIR)/$(lib)
 endif
 EXTLIBS +=3D -lz
=20
@@ -527,7 +528,7 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR
 		BASIC_CFLAGS +=3D -I$(OPENSSLDIR)/include
-		OPENSSL_LINK =3D -L$(OPENSSLDIR)/lib $(CC_LD_DYNPATH)$(OPENSSLDIR)/lib
+		OPENSSL_LINK =3D -L$(OPENSSLDIR)/$(lib) $(CC_LD_DYNPATH)$(OPENSSLDIR)/$(=
lib)
 	else
 		OPENSSL_LINK =3D
 	endif
@@ -544,7 +545,7 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		BASIC_CFLAGS +=3D -I$(ICONVDIR)/include
-		ICONV_LINK =3D -L$(ICONVDIR)/lib $(CC_LD_DYNPATH)$(ICONVDIR)/lib
+		ICONV_LINK =3D -L$(ICONVDIR)/$(lib) $(CC_LD_DYNPATH)$(ICONVDIR)/$(lib)
 	else
 		ICONV_LINK =3D
 	endif

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGqY1gxcDFxyGNGNcRAgydAKCMTUaXslHwGeY1ofh8YJjN6iX9BgCdHEHo
Xfke2Iaxbm8oGd7VosiZ7Ts=
=j0+D
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
