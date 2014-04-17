From: Gerhard Gappmeier <gerhard.gappmeier@ascolab.com>
Subject: automatic submodule deinit (platform specific blacklist)
Date: Thu, 17 Apr 2014 10:02:50 +0200
Message-ID: <2348605.ZgCffZToXK@ws-gergap>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8963189.oqSjIHlCdh"; micalg="pgp-sha1"; protocol="application/pgp-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 10:03:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WahIG-0008I5-Mh
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 10:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbaDQIDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 04:03:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.130]:63090 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaDQIDO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 04:03:14 -0400
Received: from smtp.ascolab.com ([213.95.4.182])
	by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
	id 0MfV79-1WKY8i3suB-00P9x9; Thu, 17 Apr 2014 10:03:11 +0200
Received: from localhost (localhost [127.0.0.1])
	by smtp.ascolab.com (Postfix) with ESMTP id E6EA4E1A9A
	for <git@vger.kernel.org>; Thu, 17 Apr 2014 04:03:09 -0400 (EDT)
X-Virus-Scanned: amavisd-new at ascolab.com
Received: from smtp.ascolab.com ([127.0.0.1])
	by localhost (smtp.ascolab.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IEClznGOQev5 for <git@vger.kernel.org>;
	Thu, 17 Apr 2014 04:02:53 -0400 (EDT)
Received: from ws-gergap.localnet (unknown [213.95.4.186])
	by smtp.ascolab.com (Postfix) with ESMTPA id 25810E1A96
	for <git@vger.kernel.org>; Thu, 17 Apr 2014 04:02:53 -0400 (EDT)
User-Agent: KMail/4.11.5 (Linux/3.11.6-gentoo; KDE/4.11.5; x86_64; ; )
X-Provags-ID: V02:K0:L6AJp3Fhshsyrq/8Nxp/aGKriIIaHMt6t5+GlPB4Pdi
 sgayBCh0virso0+QPo2O9OQzIxlhzdn2RSBmOgJWvVlbbtBNWI
 IHwYJ+GiWoSgS/iHMl0NaInPMAKxjY292RQ3SkB7SyvzbUa7wK
 P+u6RUdc3Ag2bhB62HifgpV6io/2TDVbEZWP4GWAiRYxcNIuYc
 Z+YLq6P2eaHuBenNBqgkZM+38VvXtNf/rIKUCIb82q64Mkf3m/
 DxaSJt0DjPQb/mn1eFxc7tjygZp5o8yFAa8yM0riv+E6yZ8JY8
 sT5UTp8yT/IEfXSjIdzrOUC0ucXksWy85k2gzkd+8q+RVDaldA
 9udV4ImIDSPKSA7IPmG4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246413>


--nextPart8963189.oqSjIHlCdh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi all

in our cross-platform projects we always have a certain Windows-only=20=

submodule, which contains all the compatibility stuff and missing libra=
ries for=20
Windows.

When cloning such a repository on a Linux machine the typical procedure=
 is:
git clone git@server:project.git
cd project
git submodule init
git submodule deinit path/to/windows-stuff
git submodule update

This way you avoid wasting time and disk space to clone stuff that you =
don't=20
need on Linux (or on whatever non-windows machine your are actually wor=
king).

It would be really cool to add a kind of platform specific submodule bl=
acklist,
either in .gitconfig or maybe even better in .gitattributes so that we =
can add=20
this configuration to the repository.

Example .gitattributes how this could look like:
  # common stuff
  *.sh eol=3Dlf
  *.conf eol=3Dlf

  # submodule config
  [src/windows-compat]
  platforms =3D win32

By default the platforms could have the value "all". But one can change=
 it to=20
a list of platform names e.g. "platforms =3D linux, macosx" or "win32" =
like in=20
the example above.

Such a feature would also make it possible to simply use "git clone --
recursive git@server:project.git" avoiding the single stops as shown ab=
ove.

What do your think? Is something like this possible?
Or is it even possible already somehow?

Today I'm using a shell script to automate this steps, but this is just=
 a=20
workaround. It would be cool if git itself could do this for us.

=2D-=20
mit freundlichen Gr=C3=BC=C3=9Fen / best regards

Gerhard Gappmeier
ascolab GmbH - automation systems communication laboratory
Tel.: +49 9131 691 123
Fax: +49 9131 691 128
Web: http://www.ascolab.com
GPG-KeyId: 5AAC50C4
GPG-Fingerprint: 967A 15F1 2788 164D CCA3 6C46 07CD 6F82 5AAC 50C4

=2D-
ascolab GmbH
Gesch=C3=A4ftsf=C3=BChrer: Gerhard Gappmeier, Matthias Damm, Uwe Steink=
rau=C3=9F
Sitz der Gesellschaft: Am Weichselgarten 7 =E2=80=A2 91058 Erlangen =E2=
=80=A2 Germany
Registernummer: HRB 9360
Registergericht: Amtsgericht F=C3=BCrth
--nextPart8963189.oqSjIHlCdh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlNPiq0ACgkQB81vglqsUMTZcgCcDaRfJ6ex/IGuw6FRdMBNwhvs
mpMAn01lTs1CcbPjjchQVxB39RHc1itz
=+RDD
-----END PGP SIGNATURE-----

--nextPart8963189.oqSjIHlCdh--
