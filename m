From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] zlib in custom location
Date: Fri, 27 Jul 2007 07:42:51 +0200
Message-ID: <20070727054251.GC30038@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 07:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEIba-0005NX-Qq
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 07:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbXG0Fm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 01:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757235AbXG0Fm6
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 01:42:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:39102 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232AbXG0Fm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 01:42:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so655415ugf
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 22:42:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=Eh+/lJjOf+bihpkH4TWlwNOoJ3LmlQOiIs3vrZN5y4Iy/m38Hnc5yUVyCiG6Dx8Dr6MUTAPhS0WHsTvo8Gmlezlnu8QFNhYeVpfjAv7mObKbEIOD/19lUQMKDvowtNmcalUQgM8zczBe/OrRFSESa0hUabJnCbcQMzyslDxdprw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=HvYHgH+cxAnZkYAPiFV/UtRLcm+/Gx0u3Ag8RIsb+XudA8UI0NJ04+b1+LSlBXaDmRjTp2PClS4imPN+zyzR9FQM3IiBX9F/ZNq5zFpRLXikb9JR/oNVMTsqfU5OM//IwW8eBHc0OQ6EIaMA/u1DxM3sB7Ez4OXM8ZkY56CVsDo=
Received: by 10.66.222.19 with SMTP id u19mr2675670ugg.1185514976246;
        Thu, 26 Jul 2007 22:42:56 -0700 (PDT)
Received: from sigkill.schiele.dyndns.org ( [87.178.92.138])
        by mx.google.com with ESMTPS id k27sm908024ugd.2007.07.26.22.42.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2007 22:42:54 -0700 (PDT)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id DBBEAB917DE; Fri, 27 Jul 2007 07:42:52 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53894>


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have some systems with zlib in a custom location and thus did the followi=
ng
change to support a variable ZLIBDIR like it does already exist for
OPENSSLDIR.  Would be great to see this in the main tree.

commit d61424558cda558b0c7893f545d548c6d6f211ff
Author: Robert Schiele <rschiele@gmail.com>
Date:   Thu Jul 26 22:34:16 2007 -0700

    - add option to find zlib in custom path

diff --git a/Makefile b/Makefile
index 73b487f..0179339 100644
--- a/Makefile
+++ b/Makefile
@@ -372,7 +372,7 @@ BUILTIN_OBJS =3D \
 	builtin-pack-refs.o
=20
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
-EXTLIBS =3D -lz
+EXTLIBS =3D
=20
 #
 # Platform specific tweaks
@@ -517,6 +517,12 @@ ifndef NO_CURL
 	endif
 endif
=20
+ifdef ZLIBDIR
+	BASIC_CFLAGS +=3D -I$(ZLIBDIR)/include
+	EXTLIBS +=3D -L$(ZLIBDIR)/lib $(CC_LD_DYNPATH)$(ZLIBDIR)/lib
+endif
+EXTLIBS +=3D -lz
+
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL =3D -lssl
 	ifdef OPENSSLDIR

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGqYXbxcDFxyGNGNcRApZSAJ4iEpAqJliAXLW+XPGd5JTdZ1ZV7ACfSVA8
jmv8JEehPSrVU4ik1wBgMxQ=
=LVto
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
