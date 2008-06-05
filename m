From: David =?utf-8?q?=E2=80=98Bombe=E2=80=99_Roden?= 
	<bombe@pterodactylus.net>
Subject: Re: [PATCH] handle http urls with query string ("?foo") correctly
Date: Thu, 5 Jun 2008 10:29:16 +0200
Message-ID: <200806051029.22580.bombe@pterodactylus.net>
References: <200806050128.33467.bombe@pterodactylus.net> <200806050848.43462.bombe@pterodactylus.net> <alpine.DEB.1.00.0806050758210.21190@racer>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5949508.jk72B8FB3P";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 10:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4AsI-0005Y0-9u
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 10:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbYFEI3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 04:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbYFEI3e
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 04:29:34 -0400
Received: from wing.pterodactylus.net ([89.207.253.13]:46350 "HELO
	pterodactylus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754760AbYFEI3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 04:29:32 -0400
Received: (qmail 21643 invoked from network); 5 Jun 2008 08:29:30 -0000
Received: from unknown (HELO ?192.168.178.19?) (10.98.86.10)
  by 10.98.86.1 with SMTP; 5 Jun 2008 08:29:30 -0000
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0806050758210.21190@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83881>

--nextPart5949508.jk72B8FB3P
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 05 June 2008 09:15:01 Johannes Schindelin wrote:

> And of course, you usually sign off your patches.

As soon as there are no more objections, I will. :)


> How about
>
> 	strbuf_addf(&suffix_buffer, "/objects/%c%c/%s",
> 		hex[0], hex[1], hex + 2);
>
> ?

Now that you mention it... ;) Changed.


> And this line wrapped, like so?
>
> 	url =3D transform_url(obj_req->repo->base,
> 		strbuf_detach(&suffix_buffer, NULL));

I usually don't do line-wrapping because all my terminals are wide enough b=
ut=20
I might just make an exception here. :)


> Oh, but maybe it makes more sense to let transform_url() work on the
> strbuf itself?

Then I would have to rewrite more unrelated stuff because everything else i=
n=20
those files still relies on char*. I'd rather not meddle with that for now;=
 I=20
agree that at some point it should all be rewritten to use strbuf (more or=
=20
less) exclusively. :)


> Junio usually prefers assignments outside of the if() statement.

Can do.


> But another thing is more pressing: obviously, there were reasons to quote
> the ref names with this funny URL encoding (%45%75%6E%6E%79), and you
> effectively undid that change.

Hmm, yes. Ref names should probably be url-escaped.


> > +#include <stddef.h>
> Why?

=46or ptrdiff_t. Yes, I know that the offset between the start of a URL and=
 the=20
question mark will never really exceed the 32-bit range and it's also highl=
y=20
unlikely that the two pointers in comparison differ in the upper 32 bits bu=
t=20
as I'm actually calculating the difference between two pointers ptrdiff_t w=
as=20
the logical choice over int.


> Dscho

	David

--nextPart5949508.jk72B8FB3P
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEUEABECAAYFAkhHo+IACgkQsh8Hgp5TwkORLACXQeocTyXANwdBtmKQNJmFM7Q3
zwCeO3lQw4rzVsHO5WOHCLYcPOYjujI=
=Kvwc
-----END PGP SIGNATURE-----

--nextPart5949508.jk72B8FB3P--
