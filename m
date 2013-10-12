From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Sat, 12 Oct 2013 00:26:39 +0000
Message-ID: <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 02:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUn2s-0000p1-KP
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab3JLA0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:26:45 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32978 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129Ab3JLA0p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 20:26:45 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 930DA2807A;
	Sat, 12 Oct 2013 00:26:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131011235052.GV9464@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-trunk-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235931>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 04:50:52PM -0700, Jonathan Nieder wrote:
> brian m. carlson wrote:
> > +http.continue::
> > +	Ensure that authentication succeeds before sending the pack data when
> > +	POSTing data using the smart HTTP transport.  This is done by
> > +	requesting a 100 Continue response.  For requests larger than
> > +	'http.postBuffer', this is required when using GSS-Negotiate
> > +	(Kerberos) authentication over HTTP.  However, some proxies do not
> > +	handle the protocol exchange gracefully; for them, this option must be
> > +	disabled.  Defaults to disabled.
>=20
> It's not only your company's proxy that might mishandle 100-continue
> but the target server's reverse proxy (or from the point of view of
> the user, the target server), right?
>=20
> I think the wording could be clearer about the impact of the setting
> ("some proxies and reverse proxies" or something).

I'm unclear about what systems are actually broken, since I don't deal
with any such systems.  One of Shawn Pearce's commit messages definitely
covered broken proxies, but it could really be anything beyond the
client: proxies, reverse proxies, servers, or even rogue intermediaries
(for non-TLS connections).

> Perhaps this should be conditional on the authentication method used,
> so affected people could still contact broken servers without having
> different configuration per server and without having to wait a second
> for the timeout.

curl determines what method, but I guess it's safe to assume that the
authentication method used for the probe will be the same as the one
used for the final connection.  Unfortunately, all curl will tell us is
what was offered, not what it would have chosen, so if GSSAPI and
something non-Basic are both offered, we'd have to make a guess.  (curl
will always prefer non-Basic to Basic for the obvious reasons.)

If you can argue for some sane semantics in what we should do in that
case, I'll reroll with that fix and a clearer wording for the docs.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSWJc+AAoJEL9TXYEfUvaLNJ0P/1rRj3wOsTMFT6grJk8iFeJh
Sr//2dmnm+fgMG661xHUYH+XHIyJSgWj0oplrXXoP5PtKpFxpA5XCUKd9O/R8oAg
1DgMpxfHhDpO/rZrEy1Wo1wxsGkIaRi2bDZMj223J3QgquFmftXJZmvUpfjRSzSS
n+wbuM3/mai+s10ca9ulXwEES7fdLlYm2g1XevfKT9WkKQ7hZ9OYtN9EapSkqZ4K
7Dd8d0RKY52h3n6T+EizA9AF7TweAPkj4MbEqqjLxpIzs4OetAade28zjNNHqK+n
UrNmSNTC92Jxz6o7WIcS1N1n7b4oglGYQDsJz88mk6oKsNxfZ1u4xEC2AI/riQNU
yY0rAXfZa7/KpJfysS6eidtWrrabJ7fFPt4j3sf3NRGhdFnO5FUsQRgZkG+i3vzK
Y+TsyR3sbgC3Gla59UzTZ/wYnLA/9d2ZwyOYqZywZXO5fCzJ0sBhkcZB9iLaUy9w
IbIo/vE4LJpqfLgNxfrMJJKsoNI3+JqXiOoHpBo+jgT4Y83xg/0qi8BpK7NlrUyE
wENj9SR98ZXJdaD7xsAZRbYDgxtIkVeK8vxpcI+NixtNTpxcn1wr2Vicx61CLpHV
NJepGvmSnQp48EvgKJ+q68Ycv+q3ya7tuBUTKLNZv7oNt+cKYVOZqyeUZ6hb3snD
NXslId4dkeltv9/nlyu/
=PJ0p
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
