From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Fix git-show-branch --current when not on a branch
Date: Tue, 27 May 2008 02:20:51 +0200
Message-ID: <20080527002051.GA13683@leksak.fem-net>
References: <alpine.DEB.1.10.0805240049400.3980@euler.pkqs.net> <7vhcck4t6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 02:21:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0mwn-0007Bx-E4
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 02:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbYE0AU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 20:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753148AbYE0AU6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 20:20:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752996AbYE0AU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 20:20:57 -0400
Received: (qmail invoked by alias); 27 May 2008 00:20:55 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp037) with SMTP; 27 May 2008 02:20:55 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19fYtsHMh5fwuEmKxxRDpV/uW1Ymp/Ivo6RVtMMYu
	vjthbXkPhwS2um
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K0mvr-00049Y-SX; Tue, 27 May 2008 02:20:51 +0200
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhcck4t6z.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82981>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> >  builtin-show-branch.c |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin-show-branch.c b/builtin-show-branch.c
> > index 019abd3..412eba0 100644
> > --- a/builtin-show-branch.c
> > +++ b/builtin-show-branch.c
> > @@ -782,8 +782,7 @@ int cmd_show_branch(int ac, const char **av, const =
char *prefix)
> >  				has_head++;
> >  		}
> >  		if (!has_head) {
> > -			int pfxlen =3D strlen("refs/heads/");
> > -			append_one_rev(head + pfxlen);
> > +			append_one_rev(head);
>=20
> This changes the output for normal case.

It does?  How?

I cite my commit message:
> [...] So append_one_rev() operates
> on "refs/heads/foo" instead of "foo", which still works.
> But now it also operates correctly on "HEAD".

And I still think it's true.
I diff'ed the outputs of
	git-show-branch --current
AND (just to go sure)
	git-show-branch
on git.next
before and after the patch:
	No difference.

> +			int offset =3D !prefixcmp(head, "refs/heads/") ? 11 : 0;

Your version is the intuitive change and, of course, right,
but I don't see why we should do the prefixcmp() when it does
not change the resulting behavior in any way.

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIO1Pjbt3SB/zFBA8RApmtAJ0Zb9Y0spED4/DYzks+QWqey+BFrwCeOPDP
BjCAahEVQxliFO/ytNON1HQ=
=cofF
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
