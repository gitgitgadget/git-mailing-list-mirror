From: Felipe Balbi <balbi@ti.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Tue, 20 Nov 2012 09:54:16 +0200
Message-ID: <20121120075416.GA27690@arwen.pp.htv.fi>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Cc: Junio C Hamano <gitster@pobox.com>, Felipe Balbi <balbi@ti.com>,
	<git@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 09:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tailo-0007Yh-1H
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 09:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab2KTIBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 03:01:09 -0500
Received: from bear.ext.ti.com ([192.94.94.41]:51177 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513Ab2KTIBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 03:01:08 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id qAK80iVd024846;
	Tue, 20 Nov 2012 02:00:44 -0600
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAK80iIJ024943;
	Tue, 20 Nov 2012 02:00:44 -0600
Received: from dlelxv22.itg.ti.com (172.17.1.197) by DLEE74.ent.ti.com
 (157.170.170.8) with Microsoft SMTP Server id 14.1.323.3; Tue, 20 Nov 2012
 02:00:44 -0600
Received: from localhost (h68-4.vpn.ti.com [172.24.68.4])	by
 dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id qAK80gKn029841;	Tue, 20 Nov
 2012 02:00:42 -0600
Content-Disposition: inline
In-Reply-To: <20121119225838.GA23412@shrek.podlesie.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210086>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2012 at 11:58:38PM +0100, Krzysztof Mazur wrote:
> On Mon, Nov 19, 2012 at 11:27:45AM -0800, Junio C Hamano wrote:
> > Given that the problematic line
> >=20
> > 	Stable Kernel Maintainance Track <stable@vger.kernel.org> # vX.Y
> >=20
> > is not even a valid e-mail address, doesn't this new logic belong to
> > sanitize_address() conceptually?
>=20
> Yes, it's much better to do it in the sanitize_address().
>=20
> Felipe, may you check it?
>=20
> Krzysiek
> -- >8 --
> Subject: [PATCH] git-send-email: remove garbage after email address
>=20
> In some cases it's very useful to add some additional information
> after email in Cc-list, for instance:
>=20
> "Cc: Stable kernel <stable@vger.kernel.org> #v3.4 v3.5 v3.6"
>=20
> Currently the git refuses to add such invalid email to Cc-list,
> when the Email::Valid perl module is available or just uses whole line
> as the email address.
>=20
> Now in sanitize_address() everything after the email address is
> removed, so the resulting line is correct email address and Email::Valid
> validates it correctly.
>=20
> Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>

Tested-by: Felipe Balbi <balbi@ti.com>

> ---
>  git-send-email.perl | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 5a7c29d..9840d0a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -924,6 +924,10 @@ sub quote_subject {
>  # use the simplest quoting being able to handle the recipient
>  sub sanitize_address {
>  	my ($recipient) =3D @_;
> +
> +	# remove garbage after email address
> +	$recipient =3D~ s/(.*>).*$/$1/;
> +
>  	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)\s*(<=
=2E*)/);
> =20
>  	if (not $recipient_name) {
> --=20
> 1.8.0.283.gc57d856
>=20

--=20
balbi

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqzcnAAoJEIaOsuA1yqREuk8P/168LwKl6QPaH4mFccjC7T67
QSNUr8gEiPwklB0F3N9mvu/hfcuQcZ4+wEnO5+0CghXSPH3EFyL8nBYET/UjgyzJ
c1ODqvbPR71bnCiv7rcBbb6/t+9xUY8Fu13dAQjt5OGOhReAuNDTwZqEO3FtzINg
w6Gia7Ie7N+VfgiJvajkgNLFvGmK4K57/IGUR+Xwizsfi6zIIkPb3AS6W+ywvQyD
b+s5wzg5Qdesrr4KkGZY3mFvsVXofjEJRRrFMfThIyEwduriEpGTPwG+87Ymn6d2
ZDsukOXWjg264sN2EALejIEj3A5nH0T055mPMkFGkBhTq26jYp2M0qh+s3VZpWmt
9T5TeU6egFQwUgwhK0bvjn75BJ3RUKjz6Io0Rwfe+KwL4IgCiylrc9vBpH+KZT5y
w9tii69qx6JLIyKgUuCthmXhasrncgVkrjPC+xRVeI1sMW5Y3yIreba834utw3Qz
YCUNlWyu8qMGdN+J0aKNNB8rzvSoD9qtzOeUYzv5EcTBkHY/EgxgqVzDmhy5yq3Y
s65JCoowdN28j+C3g5lcmrF/6fc3wncChcapWAwEvaYM3OpMtNmr6jEUiqwkbJkl
2ATvEqP5+9oC5KVn7YrDLZJU8AMGQRpCiTwJ+Q6/YgiLR4TtmLmG/2tuL1lm1UGK
5mZBqpa0GfeavF8OHu2x
=tWbJ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
