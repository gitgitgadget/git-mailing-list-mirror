From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v2] Fix false positives in t3404 due to SHELL=/bin/false
Date: Tue, 4 Jan 2011 20:35:38 +0000
Message-ID: <robbat2-20110104T203312-513011947Z@orbis-terrarum.net>
References: <robbat2-20101227T024837-537032076Z@orbis-terrarum.net>
 <7vsjxjyce6.fsf@alter.siamese.dyndns.org>
 <20101227080343.GA15026@orbis-terrarum.net>
 <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zvl510+jvRFHh8wJ"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Vallon, Justin" <Justin.Vallon@deshaw.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 21:35:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaDbj-0004rt-0Q
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 21:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab1ADUfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 15:35:46 -0500
Received: from mail.as30085.net ([208.95.172.20]:50565 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840Ab1ADUfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 15:35:45 -0500
Received: (qmail 31032 invoked from network); 4 Jan 2011 20:35:40 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Tue, 04 Jan 2011 20:35:40 +0000
Received: (qmail 5947 invoked by uid 10000); 4 Jan 2011 20:35:38 -0000
Content-Disposition: inline
In-Reply-To: <982E526FA742C94E9AC26DA766FD07090A3399@NYCMBX3.winmail.deshaw.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164517>


--Zvl510+jvRFHh8wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2011 at 09:43:12AM -0500, Vallon, Justin wrote:
>  # "exec" commands are ran with the user shell by default, but this may
>  # be non-POSIX. For example, if SHELL=3Dzsh then ">file" doesn't work
>  # to create a file. Unseting SHELL avoids such non-portable behavior
>=20
> Perl's exec and system do not use SHELL (as far as perlfunc states).  It =
uses
> /bin/sh -c "$cmd", or a platform-dependent equivalent.
>=20
> $SHELL is typically only used when a program wants to invoke a user-shell
> (ie: editor shell-escape, xterm, typescript, screen).
>=20
> How was SHELL=3D/bin/false causing problems?  Is git using $SHELL?
git-rebase--interactive.sh:
=3D=3D=3D=3D
${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
status=3D$?
if test "$status" -ne 0
then
	warn "Execution failed: $rest"
=3D=3D=3D=3D

This always triggers with SHELL=3D/bin/false if SHELL is unset or empty,
SHELL_PATH gets substituted, which tends to be the correct /bin/sh.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Zvl510+jvRFHh8wJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAk0jhJoACgkQPpIsIjIzwiyDHQCg7bmAzlt1JeaNeIrWthWjm04O
8NMAoKW47yqAxZq7Lo2xOhlErZKgML6p
=pOJb
-----END PGP SIGNATURE-----

--Zvl510+jvRFHh8wJ--
