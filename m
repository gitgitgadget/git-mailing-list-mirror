From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: several date related issues
Date: Thu, 25 Jun 2015 14:56:59 +0200
Message-ID: <20150625145659.09285538@pc09.procura.nl>
References: <20150625131901.5b962336@pc09.procura.nl>
	<20150625124445.GA18395@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/xoezNk2VhI/RRKXotMWcRps"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 25 14:57:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z86iO-0006F8-EU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 14:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbbFYM5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 08:57:09 -0400
Received: from lb2-smtp-cloud3.xs4all.net ([194.109.24.26]:59351 "EHLO
	lb2-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267AbbFYM5H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 08:57:07 -0400
Received: from pc09.procura.nl ([92.66.41.201])
	by smtp-cloud3.xs4all.net with ESMTP
	id kcx31q00C4LQezg01cx4Lq; Thu, 25 Jun 2015 14:57:05 +0200
In-Reply-To: <20150625124445.GA18395@peff.net>
X-Mailer: Claws Mail 3.11.1-171-g6f063a (GTK+ 2.24.23; x86_64-suse-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272671>

--Sig_/xoezNk2VhI/RRKXotMWcRps
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2015 08:44:45 -0400, Jeff King <peff@peff.net> wrote:

> On Thu, Jun 25, 2015 at 01:19:01PM +0200, H.Merijn Brand wrote:
>=20
> > *** Dates do not respect LC_TIME
>=20
> Right, we use our own routines for formatting the dates, and not
> strftime. And it probably should stay that way in general, as git's
> output is often meant to be parsed.
>=20
> That being said, I do not think it would be wrong to have a date-mode
> that just showed strftime("%c"), or some other arbitrary strftime
> string.  You could then set log.date as appropriate for human
> consumption.

Yes please :)

 --date=3Dlc
 --date=3Dlc_time
 --date=3Dlocale

all spring to mind as valid options

> > *** git log --date-order and --author-date-order do not order by date
>=20
> Correct. The documentation says:
>=20
>    --date-order
>      Show no parents before all of its children are shown, but otherwise
>      show commits in the commit timestamp order.
>=20
> In your example, one commit is the parent of the other, so it hits the
> first part of the sentence, and the dates are never even compared.

That is what I gathered, and concluded that the option name is
misleading

> There is not a simple way to show commits in arbitrary order without
> respect to parentage. I think you'd have to do something like:
>=20
>   git log --format=3D'%at %H' |
>   sort -rn |
>   cut -d' ' -f2 |
>   git log --stdin --no-walk

I'd like that as gitk option!

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/xoezNk2VhI/RRKXotMWcRps
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVi/qfAAoJEAOhR6E+XcCY43AIAK5ia98UK0teJtSD1rA1hDKI
AjitZZngbkMai6EYZr0skLT7/H6/XNB7/GLON/qPfGA0YuHqISGMgiT7vqBCctO+
JfFqfi9NlJCZvcVaC6/9cXulzCkyVqMaHxtMFBja1wgYyqcrqeU0oB0+1zTixhz/
t6nxKcy9dIYxqBHXBf7LfgI6lHGWqKeJZXhpiivGDhUiMeFGbBus85npPl09DBhh
uwb6y0SgRFqbUojy1yzXQ5z3ryr4zoY/vkcj5jUWVeWf8JRmef60lPAtsnfLfSKV
pYhhbaopIpGPTACRjYeus5eOfg8UEFpVIsy8tZrbI7KNbgqxxitvAsxHXF+/+2k=
=Qj2a
-----END PGP SIGNATURE-----

--Sig_/xoezNk2VhI/RRKXotMWcRps--
