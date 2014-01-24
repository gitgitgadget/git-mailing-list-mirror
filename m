From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/9] cherry-pick, revert: add the --gpg-sign option
Date: Fri, 24 Jan 2014 21:08:36 +0000
Message-ID: <20140124210836.GA58260@vauxhall.crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
 <1390524666-51274-2-git-send-email-sandals@crustytoothpaste.net>
 <xmqqiot9qend.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Cc: git@vger.kernel.org, Nicolas Vigier <boklm@mars-attacks.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 22:08:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6nzb-0007i4-29
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 22:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbaAXVIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 16:08:43 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51362 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752127AbaAXVIm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 16:08:42 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 56EA928074;
	Fri, 24 Jan 2014 21:08:41 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nicolas Vigier <boklm@mars-attacks.org>
Content-Disposition: inline
In-Reply-To: <xmqqiot9qend.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241041>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 01:00:06PM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +-S[<keyid>]::
> > +--gpg-sign[=3D<keyid>]::
> > +	GPG-sign commits.
> > +
>=20
> Does this accept --no-gpg-sign?  If not, shouldn't it?

It does not.  I took Nicolas's patches from the list and applied them to
master, so nothing from next is there, including the commit.gpgsign
stuff.

Would you prefer I rebased them on next instead?

> > diff --git a/sequencer.c b/sequencer.c
> > index 90cac7b..bde5f04 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -392,11 +392,18 @@ static int run_git_commit(const char *defmsg, str=
uct replay_opts *opts,
> >  {
> >  	struct argv_array array;
> >  	int rc;
> > +	char *gpg_sign;
> > =20
> >  	argv_array_init(&array);
> >  	argv_array_push(&array, "commit");
> >  	argv_array_push(&array, "-n");
> > =20
> > +	if (opts->gpg_sign) {
> > +		gpg_sign =3D xmalloc(3 + strlen(opts->gpg_sign));
> > +		sprintf(gpg_sign, "-S%s", opts->gpg_sign);
> > +		argv_array_push(&array, gpg_sign);
> > +		free(gpg_sign);
> > +	}
>=20
> Here you would need to invent a new way to propagate --no-gpg-sign
> to subsequent invocations, I think.

Probably.  It wouldn't be too terribly difficult.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS4tZUAAoJEL9TXYEfUvaLZqEP/2OWw12m5zt13dQ1kg6beQxf
5rQILOxbhn4OjpRY7hIYKyse4HV71PLxbyMsGQRZWgYyHE1fJmIzJMImyOq2eEcu
yTlsJEYkhGNiYG7VkPjqmnGrKJ8bavQMGKrImXE0zcC4SoZ//9sVEroxJfNd3SWJ
erTC19/hzWlRdTg52K3rUaFx+wzqrVffHxAePt+hYNkTeVJV+/t1qEjSBSsPLBdj
r1XhjmVGm+9LlLakTPSuXZROKxUaEzYtqpeI0ufFDNJG3ga0cL7fkpq3oy+te/9V
R1yjDzgEb984zMcgsylOzxyliCKKTOw12elEgj8+sgiOcV8hU5GNxVum4gTbSJzc
nIZwiwDyVUPlTrceRLu1mKxHAggnSelvqVYMqHogNppzFYfIBOkIBA85SiGmEPQI
+uUX2SqupUrm5kYBJrUG1LruQlLl41M/0T7FGV2ZJ3N7KTs7rGp/48IQOssMsMWT
NC9KFezM2HdONIjJEH0gCnxp5Qac3HSiZwtmnV4p6ZztEo8XLKvwvC7iCQVtftJr
uQS810OTs20FOhokIAr3gclvCvZlLnh4cmr2N1QnxCjbS9T/5wE82vH5E1m7lwLX
XQTiv34kKN09cY/rM1pROBunQhiWCsE3svHH4/wtBUe1nL3+jdqxGWdEQwodGKwH
4ntvHBUn0NHbDiuSOqlB
=ATpR
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
