From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Fri, 26 Jun 2015 20:43:56 +0000
Message-ID: <20150626204356.GB263667@vauxhall.crustytoothpaste.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
 <20150626131524.GA2626@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 22:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8aTr-0000fk-58
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 22:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbbFZUoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 16:44:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:56105 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753083AbbFZUoE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2015 16:44:04 -0400
Received: from vauxhall.crustytoothpaste.net (c-73-155-40-49.hsd1.tx.comcast.net [73.155.40.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2B06A2808F;
	Fri, 26 Jun 2015 20:44:02 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Content-Disposition: inline
In-Reply-To: <20150626131524.GA2626@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: 0.163 () BAYES_00,RDNS_DYNAMIC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272824>


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2015 at 09:15:24AM -0400, Jeff King wrote:
> On Sun, Apr 26, 2015 at 08:30:12PM +0000, brian m. carlson wrote:
> > Improve the check by looking for "plink" or "tortoiseplink" (or those
> > names suffixed with ".exe") only in the final component of the path.
> > This has the downside that a program such as "plink-0.63" would no
> > longer be recognized, but the increased robustness is likely worth it.
> > Add tests to cover these cases to avoid regressions.
>=20
> FYI, this ended up biting me today. We have some integration tests that
> make sure we can clone over putty, and we wrap plink in a
> "plink-wrapper.sh" script that tweaks a few extra options. That used to
> match under the old scheme, but not the new. It would also match if we
> looked for "plink" anywhere in the basename (but not in leading
> directories).
>=20
> I was able to work around it pretty easily by changing our test setup,
> but I thought I would include it here as a data point. It's probably not
> that representative of real-world users.

Thanks for the data point.  While we don't use plink at $DAYJOB, this is
the kind of test we might well perform.  I expect it's most likely to
hit people in test setups like this, but if it turns out to be a
problem, we can certainly loosen it or if necessary, revert it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.4 (GNU/Linux)

iQIcBAEBCgAGBQJVjbmMAAoJEL9TXYEfUvaLLZsQAIPMU+ytoLz4Mqup5o0n4rFG
pYZEmN9JFKWdZu9FCdty4ef8OlsIK1hnqDohP3N0Ho+L9XVduE/YlVejw06+Zt+O
pMifo3+XQtMinZlu0oe5WiCmcb5CKY2kUr8pZ0B6l0z8gAtwaVanAEX7nCWVWeV2
VMkEF1sNWAUCqdsk6Vk2Kw5HCw5A9zmsfVydaGQc/h5muSJSaQ/dSKLUb+E2tLhD
eRuWtwyZSoVtqWANgfPHpTAcDejdKDz0x4VfiOSYE+M9NGHOxDawCVuUSNC70M2/
HbUnS6lqDbkpNyOYfqC7kPFtUh10McX0Ymy39HuXwi0Q512qx5i10QNT3lbGv/y6
53byb6sJXIXiXsfwdNsSVjBSWYaOi/q0xpkpJjyuatDaz4gE2X3pS8VqAxSiwsik
7k4f7jlvar5XVtYZXS0JkJmEsKKgf+y55LeIjgmcyJ4yVIYd1GvV7QUkUd9CRh7Q
ZITLMr3zenHKSxS21LUfYrY2abhr1xfuetoPX1Y8gJT6tCXQv14VvEkXRkNv7HQi
oD1a7hWBrGv+4FkkQmW6zzPkD30sWGcXXrBS8fcWmFeVf5a7POWnMDsYuiVBdxRq
KVA97fHvmnAoQTzICHsEiqXtx1t5sWmfUps0h7EKyOYpdCJnufNSSf8oWh+aZns8
Aea+IIK74znttiyhCxXK
=SCMC
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
