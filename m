From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 16:44:37 -0400
Message-ID: <20121023204437.GE28592@odin.tremily.us>
References: <CABURp0q7TJM_0E7g8EAB9jQ2q6rNcvncOqYnk4byehQxbZfo1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=jKBxcB1XkHIR0Eqt
Cc: git@vger.kernel.org
To: Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 23:45:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQmHz-0008BW-0f
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 23:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565Ab2JWVpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 17:45:17 -0400
Received: from vms173007pub.verizon.net ([206.46.173.7]:18501 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2JWVpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 17:45:16 -0400
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2012 17:45:16 EDT
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCD0026V5MEPI20@vms173007.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 15:44:39 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id E8CAC67EA55; Tue,
 23 Oct 2012 16:44:37 -0400 (EDT)
Content-disposition: inline
In-reply-to: <CABURp0q7TJM_0E7g8EAB9jQ2q6rNcvncOqYnk4byehQxbZfo1w@mail.gmail.com>
 <20121023194436.GD28592@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208254>


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 03:44:36PM -0400, W. Trevor King wrote:
> On Tue, Oct 23, 2012 at 12:16:22PM -0700, Nahor wrote:
> > On 2012-10-22 09:34, W. Trevor King wrote:
> > For instance, the module may later be updated to a commit in branch B=
=20
> > instead of branch A. Unless you remember to also update .gitmodule, you=
=20
> > have then inconsistent information.
>=20
> But you're explicitly *using* the configured setting in
>=20
>   git config --file $toplevel/.gitmodules submodule.$name.branch
>=20
> That should be a reminder that the configuration is important, and
> you'll remember to change it.

To make my case more cleanly, people already handle all the
troublesome cases for branch.$name.remote, so handling similar
upstream volatility for submodule.$name.branch should not be too
difficult or surprising.

On Tue, Oct 23, 2012 at 03:58:48PM -0400, Phil Hord wrote:
> On Mon, Oct 22, 2012 at 6:55 PM, W. Trevor King <wking@tremily.us> wrote:
> > How about -r/--record, with the recorded name being optional?
> >
> >   --record-branch[=3D<recorded_name>]
>=20
> I like that just fine.
>=20
> > This would satisfy Gerrit users that wanted to use '.', but also
> > satisfy me with:
> >
> >   git submodule add -rb=3Dmaster foo bar
> >
> > However, there is a change that people would see that, and then use
> >
> >   git submodule add -r -b=3Dmaster foo bar
> >
> > which would checkout the HEAD from foo and store `-b=3Dmaster` in
> > submodule.$name.branch.
>=20
> I don't think it would.

Ah, right, forcing the =3D<name> attached case would mean they'd have to
use

  git submodule add -r=3D-b=3Dmaster

which doesn't sound like the sort of thing you'd do accidentally.

> Though I see in rev-parse--parseopts that the use of
> optional-argument options "is discouraged".

I'll work up a v2 patch and we'll see if anyone complains ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhwGzAAoJEEUbTsx0l5OMqHgP/3gvmFjI2nMZ9Z3TGQDPfrXo
gAWvaHvxSMhtsczdAzAC/plJILT2jLdHSryxKjIfME7l3R5xhCwSGd67Q7joxh19
WhwmU99kRPQEyScgxgDrpg25xtDonz45GLA5rMZaWyZGgr2pjzZOHuZLk8zgkhLL
cr5uTfMhxxbRvcWtMXR0lPWTBxtaSMaGfhGcdM8/H3mVnmu3DbczjLoWEoBoTEOc
JVxTSWHLgZOm7Zfq88BF99HOEWgkkhRlg722oTjAuJ8J5npHoQiy4s+DPfEL3XVh
IgVonnpvm+MW44KnXcwAsUsCMqtNBUmlKkOJs2cutVZQWxk9DInrDF4TBiv2tN9t
NPrlANXS3eDWuTrFjMp4ElM56EKdppGbCezFZoe+gFWWSH4htkCk3kPRtK0+KUlB
RouwJNIFRVtVFqvwAyaax22FaM5Op+C6oYmIphDHghYf40mMnbHDzV2qBOercgHg
FgdXQznWx3ziR6+MXmr4CiN/0cDPmPuQfNYU18sYLgzO2kVVfAKyIoaRZBfByrtq
qLV4SBxAP6qj3YJyHL6QlBIMFyTfUFJLjnc9w1bzodTKDjZyoh7ggJxzQ09P8pPe
zz8BYSSiV5Z6YdDfgSZJgI9ThvSUSPZ7Ds4qCzK758zVTrdTNsHXrU0Hi5GzHDQf
iQysAOBy0QX7b8TlwUvz
=V6xP
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
