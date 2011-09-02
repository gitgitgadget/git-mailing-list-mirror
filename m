From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Fri, 2 Sep 2011 19:39:26 +0200
Organization: Gentoo
Message-ID: <20110902193931.42593338@pomiocik.lan>
References: <20110901184815.2cd8b472@pomiocik.lan>
	<1314895801-21147-1-git-send-email-mgorny@gentoo.org>
	<20110902163903.GA21768@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/NwKde5a+dfJk.H1inoLmlRi"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 19:37:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzXgj-0004tB-Ot
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 19:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab1IBRhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 13:37:51 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:51340 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab1IBRhv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 13:37:51 -0400
Received: from pomiocik.lan (unknown [81.219.205.214])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 597B01B401C;
	Fri,  2 Sep 2011 17:37:49 +0000 (UTC)
In-Reply-To: <20110902163903.GA21768@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.5; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180624>

--Sig_/NwKde5a+dfJk.H1inoLmlRi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 2 Sep 2011 12:39:03 -0400
Jeff King <peff@peff.net> wrote:

> On Thu, Sep 01, 2011 at 06:50:01PM +0200, Micha=C5=82 G=C3=B3rny wrote:
>=20
> > -	buf =3D strchr(buf, '\n');
> > -	if (!buf) {
> > -		*body =3D "";
> > -		return; /* no body */
> > -	}
> > -	while (*buf =3D=3D '\n')
> > -		buf++; /* skip blank between subject and body */
> > -	*body =3D buf;
> > +	buf =3D format_subject(NULL, buf, NULL);
> > +
> > +	/* When having a signed tag without body, format_subject()
> > +	 * will start to eat the signature. */
> > +	if (buf > *signature)
> > +		*body =3D *signature;
> > +	else /* - 1 to get a trailing newline to strip */
> > +		*body =3D buf - 1;
>=20
> This last line is wrong if there is no trailing newline, no? Running
> even the existing tests in t6300 against your new patch, I get:
>=20
> expecting success:
>   git for-each-ref --format=3D'%(subject)' refs/heads/master >actual &&
>   test_cmp expected actual
>=20
> --- expected    2011-09-02 16:36:38.306058729 +0000
> +++ actual      2011-09-02 16:36:38.318058729 +0000
> @@ -1 +1 @@
> -Initial
> +Initia
> not ok - 28 basic atom: head subject

Any suggestion how to strip trailing newlines?

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/NwKde5a+dfJk.H1inoLmlRi
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQEIAAYFAk5hFNcACgkQfXuS5UK5QB0DNwP/dbrkgs1/j93UfZNE+v1shKUU
u3T4IEOe9AWYxiCIq+i+3Cr+bZFrWfAaDA8qjiOGqMCdQfC3fsWC6oy/T6RWiIF/
H1qu/oifz72M55x+JXnIYBM/hiQeSEbmsfjX+uVs6AKW1bU0syMjeLmzBuDzEaPH
MjWGi6nvkZRL1fsnWcI=
=cTF/
-----END PGP SIGNATURE-----

--Sig_/NwKde5a+dfJk.H1inoLmlRi--
