From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 09/12] Add several uses of get_object_hash.
Date: Fri, 20 Nov 2015 13:00:20 +0000
Message-ID: <20151120130020.GA7459@vauxhall.crustytoothpaste.net>
References: <1447122150-672570-1-git-send-email-sandals@crustytoothpaste.net>
 <1447122150-672570-10-git-send-email-sandals@crustytoothpaste.net>
 <20151120113830.GF11198@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 14:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzlIj-0003l0-Ev
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 14:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760160AbbKTNAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 08:00:25 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:39960 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751479AbbKTNAY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 08:00:24 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6C0C9282C3
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1448024423;
	bh=qasLb7uqFBocNObLMBGUxrm3/ERa9GCDacl8GHTozlI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=1B9qJEtAHreiI2VnwJdPBbZMb42N2/HWgw/axL9odixATyuV3idMux62eGgxA01Vo
	 pRbiFSq0+lXBaMDy5k5tITQcmu6u01y8ptJgcLdvL2t8kbY3c9qCRiDphyNIIPLpeu
	 DlERzAoYyNi+jg6kX9VBch2PEqZxRjP2qjoV+WVKhYtHobYmYnsT4deiopwHBEiZBr
	 LDnICEMp3ZloANZPESMRYx3yUXk5WkEPInWt4ra/M1Q5kXSkeGEX/B5+cPxzcUwT+v
	 JEACQYd9MHVbRQZDbAb/f66mfz2LsGbzlhn8JDVw14muDj/nRrx6R6LYRDBDPZDzOS
	 cHm82gj6R5EzyuHPcM+zHrRAaB7xbtIQjd8YvKlI++eCCzfo2D6nw8giYIJC63Rin9
	 NRV5e3HC+7vFa8+xZ5VVF3+BgIVPTe6dThsEIm80/D8DUVa4+yQYhvtizr8G6yxoyI
	 /I1rHPXiA5FrSopYA6vN5AcMVLcpigvKU3G4mZ9IMZhBMETaeaB
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20151120113830.GF11198@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281518>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2015 at 06:38:30AM -0500, Jeff King wrote:
> On Tue, Nov 10, 2015 at 02:22:27AM +0000, brian m. carlson wrote:
>=20
> > diff --git a/patch-ids.c b/patch-ids.c
> > index bf81b923..83229a0d 100644
> > --- a/patch-ids.c
> > +++ b/patch-ids.c
> > @@ -8,10 +8,10 @@ static int commit_patch_id(struct commit *commit, str=
uct diff_options *options,
> >  		    unsigned char *sha1)
> >  {
> >  	if (commit->parents)
> > -		diff_tree_sha1(commit->parents->item->object.sha1,
> > -		               commit->object.sha1, "", options);
> > +		diff_tree_sha1(get_object_hash(commit->parents->item->object),
> > +		               get_object_hash(commit->object), "", options);
>=20
> I haven't looked carefully at this series yet, but while applying I
> noticed that git complained about whitespace here (long run of spaces
> which could be using tabs).

I believe that was in the original file, but I didn't fix it.  Git
doesn't show that by default, IIRC.  I probably should have put in a
preparatory patch.  My apologies.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWTxljAAoJEL9TXYEfUvaLQFQP/3zOHFmmQcMUiQsWDv5U36Pf
5Hq3hv9VrO9bJSXZd4BKIhEeG7AznxdH6JqCOrOArFU79IjmmtTCc9CoQxuK/r4Q
fleZN2VA8Lk8dbCE8AIIqXtPpnu2ulza8L1VmZXDEK74IQq1n6GCxoGcLfKuLg7o
VtL8JW0IfnmtDLdlYhgBvs0/gq3IKasgXFix6L1+NRDyLh9KbbawdhGY0Iyph7OU
w2IOkxQrz9v3Z40rH24qNyxpYVWTnYOsmDN2PluxtJ/HBWiB5UkC2f8NPkLg51c0
1O/NPpBYyTIEvldUfwQWSP7M3TJalVbqcrxFFA42ZFAAh8si4ezq+0qFRCvX7OYW
d+6Fc8BK4iXzS6nO6WR7UF8PuosGGUUOXpvgTbX0HVIiHevHexbzYkKtxq4f/S8/
AKYcRRqtfSIviNLHfZlzw/1+aQL6gL5AzbfIkKae7D9TAxfSYRCCnXUVoGQQFOxk
9Dw3h0RNyd4Osg8X+68R2l0Anc00c8QPxPBJ2QaRIxnb/WZOIKkKsYN/wsIJaXm6
XpAPDbQxfEXmkhc7v3eU/JyLvtGS4dHk8b/1lJGqctQGFJk5SZEiDINoq7yRH5GU
cx2LYG2IArFk0ZEPB3CwOFGbf9WupGQ+KiPAdWPu9lePXK2hu+OEbssOoRkYtwgc
VB+wh0LE59EOCk/uZx4e
=MGdQ
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
