From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/8] sha1_file: introduce has_object_file helper.
Date: Wed, 10 Jun 2015 13:55:55 +0000
Message-ID: <20150610135555.GD664685@vauxhall.crustytoothpaste.net>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net>
 <1433867316-663554-3-git-send-email-sandals@crustytoothpaste.net>
 <CACsJy8DHJ415euwo3gMTtuQx+5RopzBg+mssZ8TVstGJcdWSqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 15:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2gUE-0005Bo-5r
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 15:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbbFJN4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 09:56:05 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39289 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933687AbbFJN4B (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 09:56:01 -0400
Received: from vauxhall.crustytoothpaste.net (107-1-110-101-ip-static.hfc.comcastbusiness.net [107.1.110.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 596932808F;
	Wed, 10 Jun 2015 13:55:59 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Disposition: inline
In-Reply-To: <CACsJy8DHJ415euwo3gMTtuQx+5RopzBg+mssZ8TVstGJcdWSqg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -1.5 BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271287>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 04:59:58PM +0700, Duy Nguyen wrote:
> On Tue, Jun 9, 2015 at 11:28 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/sha1_file.c b/sha1_file.c
> > index 7e38148..09f7f03 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -3173,6 +3173,11 @@ int has_sha1_file(const unsigned char *sha1)
> >         return find_pack_entry(sha1, &e);
> >  }
> >
> > +int has_object_file(const struct object_id *oid)
> > +{
> > +       return has_sha1_file(oid->hash);
> > +}
> > +
>=20
> This version could be "static inline" and placed in cache.h. Though it
> may be premature optimization. On top of my head I can't recall any
> place where has_sha1_file() is used so many times for this extra call
> to become significant overhead.

I planned on merging the two into has_object_file when has_sha1_file has
no more callers, so it's more of an incidental artifact that one calls
the other rather than a long-term goal.  In the branch I'm working on
now, I'm down to 27 callers, so it may be rather soon that it goes away.

Of course, if the consensus is that the performance increase is worth it
in the mean time, I can certainly just move it back when they merge.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVeEHqAAoJEL9TXYEfUvaL7f4P/0/1lywwGv4lZgxk/L6GiQxt
ykNQLS1OGAas4x8Q/eXC5RswrwBzk6vQW5oi5qh+wukvdYCbVhv1MH/rjp4KY+zm
6+Vf986MU9DHIXwbMPo6rDzfaL7gNMYIYaJRhBkllzvdCSr0rtXv4gNzZGGXyKzU
qYU5kroLpK7JnB8cYyTWCfnWu4r7PAnRX8xMLuDs/6wFXzwcciY0X+p6vyuiAwsN
g3PF39MePrJZHtuRP3q/XQBM+a3jVx1Jd4Tdp9ohpzcocRLwy0dkdJjx5NDaPV04
7a1oMmen2JkFcEJbtEouf9FwXnF4SJGeJ+wtlTB8gBXhl6H9ufsBV+P50N2xKIia
oRGMEkYFJJe/FBFmlwQg6gMO3R8/NxoUvFUSsC5lu5LL1gi/yyT2Fjp2eDh7gYno
vwP3d84P2PCDH4V7tUbvwOj3+cvJu57pZwKKkGva7jrbTKOl8btk13Ps7rYWYn/v
CD+6wHbc/JfK4/HmKQnWU1x7RLXhnqBi3qqOZ9JnouPwxNMJzi/V7nhqxI7Y0CXA
GwioiFfUvxVjZSlkd9ErbLPh1dH+D6BgrH/ex5n3WkyjId/gfS2Rcot1nFOVpS9k
4nMUVQwOxcyrwl4XFteSthnibsm3A9fzN6d58LBJhJYQtCcal4nZ1NJJaYFKWdqz
Z5JELDADRov3ZM3Zr7Qh
=5Hox
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
