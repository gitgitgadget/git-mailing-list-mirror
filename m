From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Git submodule for a local branch?
Date: Tue, 23 Oct 2012 18:09:55 -0400
Message-ID: <20121023220955.GA30442@odin.tremily.us>
References: <20121022123714.GL25563@odin.tremily.us> <508704D5.9020902@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=BOKacYhQ+x31HxR3
Cc: Git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 01:10:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQnc2-0006e3-2v
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 01:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933658Ab2JWXKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 19:10:04 -0400
Received: from vms173019pub.verizon.net ([206.46.173.19]:57459 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464Ab2JWXKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 19:10:03 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2012 19:10:03 EDT
Received: from odin.tremily.us ([unknown] [72.76.145.253])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MCD005QG9KJAR10@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 23 Oct 2012 17:09:56 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 9E7A467EBC0; Tue,
 23 Oct 2012 18:09:55 -0400 (EDT)
Content-disposition: inline
In-reply-to: <508704D5.9020902@web.de>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208272>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2012 at 10:57:57PM +0200, Jens Lehmann wrote:
> Am 22.10.2012 14:37, schrieb W. Trevor King:
> > but cloning a remote repository (vs. checking out a local branch)
> > seems to be baked into the submodule implementation.  Should I be
> > thinking about generalizing git-submodule.sh, or am I looking under
> > the wrong rock?  My ideal syntax would be something like
> >=20
> >   $ git submodule add -b c --local dir-for-c/
>=20
> But then we'd have to be able to have two (or more) work trees using
> the same git directory, which current submodule code can't.

And that's the problem I'm trying to solve ;).

> > The motivation is that I have website that contains a bunch of
> > sub-sites, and the sub-sites share content.  I have per-sub-site
> > branches (a, b, c) and want a master branch (index) that aggregates
> > them.  Perhaps this is too much to wedge into a single repository?
>=20
> To me this sounds upside-down. I'd put the three sub-sites into
> different repositories and the shared content into a submodule that
> all three sub-sites use. At least that is how I do all my content
> sharing on the websites I have done ... does that make sense?

That makes sense, however the problem is not in the common content, it
is in the final index:

  index
  |-- sub-site a (branch of sub-site-x)
  |-- sub-site b (branch of sub-site-x)
  `-- sub-site c (branch of sub-site-x)

All of the sub-sites are branches of a single sub-site-x master:

  o--o--o--o   sub-site-x
   \--o--o--o  sub-site-1
       \--o    sub-site-2
        \--o   sub-site-3

So they all live in the same repository.  My index repository will
have submodules for each of the sub-sites, and I'd like the index
branch to *also* live in same repository as the subsites.  This last
bit is the sticky part.

For a proof-of-concept example (where I currently use public
repositories for the sub-site submodules), see

  http://wking.github.com/swc-workshop/

which uses gh-pages as the index branch, and master, 2012-10-caltech,
and 2012-10-lbl for the sub-site branches.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQhxWwAAoJEEUbTsx0l5OM6okP+wXqzfplYbs7duodS4NRN/NN
t7K/FgQIuFDYs6Va2RkdXyzQ+6Q3//RPiOMgp5YlJIWO/+0BKkslxyUztlIz8FPZ
X+sanf5bmzmh1bCP7Adxnx44htq+4nDzpa+G9z++rHHwbFqpEfgy8hOlntD8Aj9p
Mm6f1qhSkCg5cp198MrBCfG1Hfp9hK+zQVvNIBFwe06LDkRtzj5CSa2aOM306KaB
kcaa6AvYnoiCcaqMf3IYHvsVZqjAsBm4GEjCFvy+LB8LcI8PWKYm60vB6mAhxk1s
dVPicJUQjUeAOcPCxp6wfS/Qq9qIzNPFwXSVN+d12IcKAaysr5SacDTpXRuB52Rt
crEDjIRzYQHjYa+vrrl5wl50BVN6/6w1ZSme1a8qWjQVCfpd9m6CvbY8IfYLHTxB
Ypd6tZz/V7fJHZMAKM9HFysYPYk/1joS7qT+3oUj4ox3M6e5cRmdkPxK10zTLu1g
pm4Yp98baVufKBVVCdrSMedCvuOUxLjkcKbMO23dF0Vnj9zArDk1KM/LZ5DVDeUD
cn9IiKq20QyXddM9mzhujOfKkk2v75w+PMDCZHE35fn26DTOZcLHbL8jfMAlEHcB
cInfm0kd3jGRpylSpOUO58rfVA0LfG+uJ8NPUXMNND9FWxdcTWWyXj1a58WcT8nQ
BecrYRBqyHOBQacXBo6U
=+vI8
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
