From: Keith Packard <keithp@keithp.com>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 22:05:03 -0700
Message-ID: <1151989503.4723.126.camel@neko.keithp.com>
References: <1151949764.4723.51.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
	 <1151973438.4723.70.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
	 <1151985747.4723.102.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4KVucz2Kx1XsRbEnRHY6"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 07:05:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxd63-0002VM-Jy
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 07:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWGDFFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 01:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWGDFFJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 01:05:09 -0400
Received: from home.keithp.com ([63.227.221.253]:11272 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751425AbWGDFFI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 01:05:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EA54B130020;
	Mon,  3 Jul 2006 22:05:06 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id r+qezCWrmSgZ; Mon,  3 Jul 2006 22:05:06 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 646EC13001E; Mon,  3 Jul 2006 22:05:06 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 529CA14001;
	Mon,  3 Jul 2006 22:05:06 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 4BED46AC24A; Mon,  3 Jul 2006 22:05:04 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23249>


--=-4KVucz2Kx1XsRbEnRHY6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-03 at 21:19 -0700, Linus Torvalds wrote:

> Can you instrument your "git-fetch.sh" script (just add random
>=20
> 	(echo $LINENO ; date) >&2
>=20
> lines all over) to see what is so expensive?=20

5 Start:                             21:59:01.584648000
66 After args:                       21:59:01.605987000
248 fetch_main() start:              21:59:02.408559000
339 fetch_main() before fetch-pack:  21:59:03.293228000
387 fetch_main() done:               21:59:04.784388000
422 After tag following:             21:59:05.311439000
438 All done:                        21:59:05.315338000

fetch-pack itself took 0.421 seconds (measured with time(1)).

Looks like the bulk of the time here is caused by simple shell
processing overhead, some of which scales with the number of heads and
tags to track.

--=20
keith.packard@intel.com

--=-4KVucz2Kx1XsRbEnRHY6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqfb/Qp8BWwlsTdMRArohAKCAZwC+TEV3NRaCVCYveV1ZfSvZewCeKTpr
6j/u5oTrLQ1q6Udm7NiVFKU=
=+d9w
-----END PGP SIGNATURE-----

--=-4KVucz2Kx1XsRbEnRHY6--
