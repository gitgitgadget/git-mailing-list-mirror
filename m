From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't
 tried Negotiate
Date: Tue, 2 Feb 2016 23:29:52 +0000
Message-ID: <20160202232952.GA6503@vauxhall.crustytoothpaste.net>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
 <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Cc: git@vger.kernel.org, Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:30:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQkOZ-0005Vb-9R
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbcBBX37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:29:59 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49908 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754738AbcBBX35 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 18:29:57 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0F6AD282CA;
	Tue,  2 Feb 2016 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1454455795;
	bh=E8d8GU4xx2tsuAi7qJuMGzSCTEYfHq56sGtvcMieHnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4Ya4CODoJNXbDsmtZx6MEDhvIVYMlu+9Myd5arbyc/D3j5LL5Mp8UpthLa/TzLnB
	 WL21MoAG85GB3rmEvd5hBU139RdDukCi+Q/360fqZZINdsSryh9LBTd3Om3aUUzvsg
	 snGJXZiIpJxN2ile8FHpDUMQvCMNlAUUfNmxGR4VlohAR6fsTJ8A8Hi9aDNKNG05WB
	 dKLqPDIvHCrCuROmnJxCJKvdckbZbDtnRyCiPSy6o3QvLSLTLX1jaAZhYiqYTNQGMf
	 Op9isSAy8thYTf5Rok6nilKwtypmDrMX16GdFY7enkNu0wOcE4omIhm3oMMDaWSJ1C
	 myxbwgDHeikfjvgyanUj8uhh1HMFm1I5tGwFKshNgvlhGdqIMQn+FbO3edl3ZkO8tb
	 NWr5yWRzxSn4NyOPgtH/yKl6tml7FbUq5HB0kDi0KbUyGLhbdrtXr3PpBHjz/gYefZ
	 szu5tcmxr6Q4iM/i9Y/hvkZe+TouiL+9F9319W7PT+B/d8YvBRd
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285314>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 12:37:19PM -0800, Junio C Hamano wrote:
> Dmitry Vilkov <dmitry.a.vilkov@gmail.com> writes:
>=20
> > This is fix of bug introduced by 4dbe66464 commit.
>=20
> That would be 4dbe6646 (remote-curl: fall back to Basic auth if
> Negotiate fails, 2015-01-08) that appears in v2.3.1 and onward.
>=20
> > The problem is that when username/password combination was not set,
> > the first HTTP(S) request will fail and user will be asked for
> > credentials. As a side effect of first HTTP(S) request, libcurl auth
> > method GSS-Negotiate will be disabled unconditionally. Although, we
> > haven't tried yet provided credentials for this auth method.

I'm unclear in what case you'd need to have a username and password
combination with GSS-Negotiate.  Kerberos doesn't use your password,
although you need some indication of a username (valid or not) to get
libcurl to do authentication.

Are you basically using a bare URL (without a username component) and
waiting for git to prompt you for the username, so that it will then
enable authentication?  If so, this patch looks fine for that, although
I'd expand on the commit message.  If not, could you provide an example
of what you're trying to do?

> Brian, comments?  Here is what you wrote in that commit:
>=20
>     If Basic and something else are offered, libcurl will never
>     attempt to use Basic, even if the other option fails.  Teach the
>     HTTP client code to stop trying authentication mechanisms that
>     don't use a password (currently Negotiate) after the first
>     failure, since if they failed the first time, they will never
>     succeed.

I think what's happening here is no username is ever provided, so
libcurl never tries authentication in the first place.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.11 (GNU/Linux)

iQIcBAEBCgAGBQJWsTvwAAoJEL9TXYEfUvaLeeMP/3Y1dBeywuRMyXR1R/8OP5Ye
GQD24+/9kJlZwnf9VXfTkx7loig9aHyDQlb8oEm2Gzj5Nxs3Dq5dZjMkJm52yIuL
xgtfc6fWwowtRzkvejgTFcWomBhjcN1zM2dW/7ydT0j5JDy0yOhit6OC1J3aYquB
H+ZTXx+Nur1dITZGfgBdh5SgKlC1fzYCkFRVoQUfXFmnS7KSMDQggejE4VXEawis
CvVf34l/IW5k6XACg3G3o3prZeCyzuaGwHu8da8/wKQeP314TrxzpoywpIWT2Kmv
35qImGj13lPGiwg4SuCgKlz7hjUWx7u0Gy0ptnGD9JTBT7EGoH5j1NtauWHbgpWN
Kp13KzoytpGzKoTZ5Y8P27byKI0g4ZhDCVghsWlABgw2tDCN35Ix3z/wp+O8hsGj
TdkG6QR5gw2GnidLySjX7+MLR6iU+7lAgevUJm7ftQd+D8f7TuhflnD1nkVvmLPU
LFNo/DnRV4PobuwAdIWTUoyjNJP+/c2fBycmGozCVeuvkrNSwRv+GLY9B1CuQqXe
bzsMJxCqhmGWloseTEefkmvfMv+H6GJXI0Li3NFEoq6psNqvqPuCGaNCfJb/HbL4
4C3tSkNzo2KeFn12uCtw6uPikwDZL4y51ev/K3EQQShJAP+jIO/V+J3oejt4+AW/
TBKKPWrMNkVnVNUUh742
=L2FJ
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
