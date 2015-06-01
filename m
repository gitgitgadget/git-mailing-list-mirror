From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] format-patch: dereference tags with
 --ignore-if-in-upstream
Date: Mon, 1 Jun 2015 11:22:12 +0000
Message-ID: <20150601112212.GA140991@vauxhall.crustytoothpaste.net>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
 <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
 <20150601102046.GA31792@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:22:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzNnT-00024a-Gm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 13:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbbFALWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 07:22:18 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:57872 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751234AbbFALWS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 07:22:18 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd0c:c3b:29e1:d998])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 225C02808F;
	Mon,  1 Jun 2015 11:22:16 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20150601102046.GA31792@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270400>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2015 at 06:20:46AM -0400, Jeff King wrote:
> So I think what you really want is lookup_commit_reference. And the
> error message is really not "invalid tag", but "not a commit". I think
> you can just use lookup_commit_or_die.

Thanks.  That does seem to be what I want.

> As an aside, now that we are dereferencing, these flags are from the
> wrong object. They _should_ be the same (we mark the tag as
> UNINTERESTING, too), but it's a little weird that at the end of the
> function we restore the saved flags from the tag object onto the commit.
> Just bumping the assignment of flags{1,2} would work (or just bump up
> the lookup_commit_or_die call to where we assign to o{1,2}).

I tried looking up the flags after dereferencing the tags, but that led
to the die("Not a range.") being triggered.  That's why the commit
message ended up mentioning loading the flags before dereferencing.

> I think this avoids the usual "wc" whitespace pitfall because you don't
> use double-quotes. But maybe:
>=20
>   grep "^From " patch1 >count &&
>   test_line_count =3D 2 patch1
>=20
> would be more idiomatic.

I can certainly make that change.  I made the test as similar as
possible to other tests in the area, but I wasn't aware of
test_line_count.

I'll reroll the patch later today.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVbEBcAAoJEL9TXYEfUvaLkf0QAM8CyilITWUhe9ieMMD1LSIO
DA8cWn5dU6qXoXnoIq0aDly3J3ypkTAawBU1kkS810lPO5yC+4fd04gHCf/NJR4U
ANz7faHpdt6PuMtz2QqZ4he224LLywSTLkOsp0LOD2fOJWdOiBbubC8Pbfbswk+c
qgsOmNTkLICX95ApTTG1SDCnv9Lp1azZ4AcZyA16Cr3rnu3yeF79f6bxPa+YZQ7c
9a2VA2jwrCScENyH5qDqI/yZBBaJwlT6ly9G1EXT3tPadJ8zQs7PBB0tEiTaP8vN
OoRLNt7wm0AIXWkmoSGPDvbH+X8669N+mRD4UXk/syFmBEtWHMh6kipfJMmQ21C1
vn8FmpxFh5k/uwQQclIe3C+R4lVO16zWk8mqa9cKebQMb8Bat+49JzZTY8iE/3RH
s8EQPMUX5+GXE896o/qmSSJpTo8Kb0NVfCJ8KKgme6TTiEkjljCZDuDoptuqFR7x
66BLPDkCxYs7HpIXlPmw+Gey7DpZhWxekHSQqzM5OWIKuOtPJ5LQ0G0Xq85Lart4
qvsDiqveRPb6GFmkF122g5qyA1d57JS3IRkkujbuCJwWeGOnYdRhdDutqjkCTqUS
dwIAyPwK/qO6gbgxe5zUNmrz+y525GwqCE6O3q7KvtpuhEQHPkTiV6z+UZ0K/b4e
8M9q3R6jV95/FkMNLlM5
=ud88
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
