From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Conventions on struct copying?
Date: Fri, 20 Jun 2014 01:26:08 +0000
Message-ID: <20140620012608.GA856079@vauxhall.crustytoothpaste.net>
References: <20140618233129.GK368384@vauxhall.crustytoothpaste.net>
 <xmqqvbrwhlki.fsf@gitster.dls.corp.google.com>
 <5A7F0CEE2DEC4F1B825568DB8358D397@black>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Fri Jun 20 03:26:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxnaw-0005Pv-3b
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 03:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbaFTB0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 21:26:14 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48455 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754250AbaFTB0N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2014 21:26:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:4482:19b0:51d5:328f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E135C2808E;
	Fri, 20 Jun 2014 01:26:11 +0000 (UTC)
Mail-Followup-To: Jason Pyeron <jpyeron@pdinc.us>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5A7F0CEE2DEC4F1B825568DB8358D397@black>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.15-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252202>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2014 at 01:22:44PM -0400, Jason Pyeron wrote:
> > -----Original Message-----
> > From: Junio C Hamano
> > Sent: Thursday, June 19, 2014 13:11
> >=20
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >=20
> > > I don't know of any place we explicitly copy structs like
> > > this,...
> >=20
> > which should be a reason enough.  The first concrete guideline is
> > "just imitate the existing code".

Right.  The reason I asked is that most of our structures end up
containing pointers, so it wouldn't make sense to do the equivalent of a
memcpy on them anyways.  This is just data, so I thought it might be
different.  I'll implement an oidcpy function to do the work.

> > > but I don't know of any prohibition against it, either.
> >=20
> > So now you know ;-).
>=20
> To expand, on that do not trust the compiler to do deep copies.

I'm not.  The definition looks like;

  struct object_id {
    unsigned char sha1[20];
  };

I only want it to memcpy those 20 bytes; there's no pointers or anything
to complicate it.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTo42vAAoJEL9TXYEfUvaLAcMQAKjzI5ykHQFg785TVae+ZCWM
Uz+Zgw5aBxrpHY+dd+3bKcFyKYed+Y0HgX+tdC5Ibq/9B/Hs4O7JL2LXaJu12mmK
uqfe9pg12KdaFIsHqtk1U6fyJ1/pzbjr+c1CbPyHIE/S4mhSAjMDmTxIN2gXTNYz
FqJ02PRGaYQANzU1FGObxih2jagBpbvChnu5EkO59tITm/ju9Ds9XQAlJEFrsMCw
L82OJ4fEPl0XAYnM3Du//tngX/fVlq/241Tgq7Cj8dpuMEepOUUK8Ucnkex1/iL9
vAuC3hH69J4giadjkM2Gib8FuonG/7ij32zOTV41k968sFgoqZoWnqiK9m6nu0JJ
hwn+BJEwX+Pz1zpwdQr8v6NTiYBSGixKHT6upn5SH80Ajq4HfyykXD/EqFqeoIaW
1FfRE7nlZ4YrW7C1/gLW6wIE9+nXvV+zyPycjxYmOA7hSv6/g1QGEzZ57ewrMWxI
8RpqET/lVoysNWAHXP4ponee4RvXgSJ0o1Tcep7NytYgJgQJpnpDAQgFBe09ilEP
3aG74uC/IDZnhf6i3MyL2V7n6+obALpt1J6hCVWI0aa+D4DlLWWN76lnyBwVGxig
ev/z7M/bktnmEyLKfCXZBG7PxboMV8HSI9ykbOGBQxSMa9jzeXwH7GK0oRr0zUjx
YkXpy7DZXYNqyA6DAV3l
=9XRr
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
