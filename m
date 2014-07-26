From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git + mod_auth_kerb
Date: Sat, 26 Jul 2014 20:57:16 +0000
Message-ID: <20140726205716.GB155979@vauxhall.crustytoothpaste.net>
References: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
 <20140721231721.GB5616@vauxhall.crustytoothpaste.net>
 <xmqqfvhtgwgp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Cc: Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 22:57:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XB923-0002rM-C7
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 22:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbaGZU50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2014 16:57:26 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49129 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751616AbaGZU5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jul 2014 16:57:25 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9409:d75d:4b48:c101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E95182808F;
	Sat, 26 Jul 2014 20:57:22 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jean-Francois Bouchard <jfbouchard@accedian.com>,
	git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <xmqqfvhtgwgp.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254281>


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 10:00:22AM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > So git uses libcurl with CURLAUTH_ANY.  In order for authentication to
> > work with libcurl, you have to supply a username.  If you specify it in
> > the URL, the libcurl realizes that it can use Kerberos, and goes on its
> > merry way.
> >
> > If you don't specify the username in the URL, git notices that
> > authentication has failed, and asks the credential store for a username
> > and password.  git does not know that a password is not needed, so the
> > credential subsystem prompts for one anyway.
>=20
> Hmmm, does this hint that we might want to be able to tell the
> credential subsystem that it is sufficient to have name without
> password, or allow the credential subsystem to say "I am giving you
> sufficient information" when it returns only username without
> password?

I just did some testing here, and on my configuration (mod_auth_kerb
without Basic authentication fallback), hitting enter at both the
username and password prompts results in a successful connection with
stock git.  This makes sense, because with GSSAPI authentication, your
ticket is tied to your username, so no explicit username is needed.

If I turn on KrbMethodK5Passwd and try to push without credentials, I
can confirm that git refuses, even if the correct password is set.  It
looks like libcurl really doesn't want to use Basic authentication if
there's a "better" choice.

Jean-Francois, do you have KrbMethodK5Passwd set to on (the default)?
If so, you might try turning it off and forcing Kerberos authentication
all the time.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT1BYsAAoJEL9TXYEfUvaLdSwP/2zmDXxtbJLkOBsc25zaX5y7
ys5IzDZCWJL6UyTI1Th4YMt+Dwx/2cLk1oimi60bjqVRR1vKBNZFvUtL0ZapF7+Z
Yu8fwZqN4n8omDSlO8kjLnR38Ve+aWIdupkpJNTZLSpNKRhvZxpjSd++DWQ5MJPk
5IVA31VK77r4aoR5bxttobVOf5wm6eKYFm8Hulb0Hj0VBSQiUJ9H2rN6Jf3KQC72
0rpTT3SpvtVbogCcvGmJ1Q//jD6q6bf3A6Y7y7KQPxodg54NREEQ+m3XYTrqdK4O
MNvi3S7mn51RrB9TqbYS2P7feEeCIRdJO3/VAHi012AzRIAUdxY8ki6NNH1sdcUg
U7OBi7GOkgFdTsVAQXbH+pvYw6mYgs5EuDPkzreZSKlFkFGGC0fwiERq5KGK3TyN
AEN4NA/C6VHzCEyyHt8aI16EgjbLQFQW+Q6HvdS7/4V6OCuCqpVeGG9Asfar0rLb
Mc9tID1N0UZ42mTPoZgvwDurQ1pIKTG2+ZrSWnl8/1pnCOGGl8BBck5wsbHgiJF8
GQjScseBJiVGwO38483JQM5fDD1NWSw17g5OfgTN0+GQyoneIUqhqKoaZIsK480A
jx75gYiKXkVL57ojeJGCTYX6xVWs7ZhkD1cFc3EDLVaCHGVcC0LIFb98q+9UBDqR
suYhsAAwjbnHi+CI0rMB
=iHey
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
