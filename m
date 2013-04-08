From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Poor performance of auto gc
Date: Mon, 8 Apr 2013 13:54:58 +0100
Message-ID: <20130408125458.GM9243@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sy9WyBOsCRoUO165"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 18:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPExS-0003oz-2E
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935734Ab3DHMzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 08:55:02 -0400
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:60829 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935703Ab3DHMzB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Apr 2013 08:55:01 -0400
Received: from finisterre.wolfsonmicro.main (unknown [87.246.78.26])
	by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 95A2511068A
	for <git@vger.kernel.org>; Mon,  8 Apr 2013 13:54:59 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.80)
	(envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1UPBb9-0003ql-0S
	for git@vger.kernel.org; Mon, 08 Apr 2013 13:54:59 +0100
Content-Disposition: inline
X-Cookie: Your love life will be... interesting.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220423>


--sy9WyBOsCRoUO165
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I routinely experience very poor behaviour of the auto garbage
collection both on the command line and especially with git gui (which
appears to have a much lower threashold).  I have a kernel git
repository I do most of my work in which includes a bunch of trees
including -next and which has some frequently rebased branches.  This
does garbage collection (or for git gui prompts me to do garbage
collection) far too frequently.  Previous analysis has shown that the
issue is that garbage collection leaves a bunch of unreferenced items
lying around as loose objects rather than in a pack waiting to age out
of the tree.  This is especially bad towards the end of the release
cycle when the trees in -next get bigger, right now the gc *always*
triggers.

It seems to me that it should be possible to trigger garbage collection
based on proportions of the number of objects in the repository rather
than on absolute numbers; some sort of time/object count increase based
holdoff might be useful to prevent things retriggering too soon.

--sy9WyBOsCRoUO165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRYr4bAAoJELSic+t+oim9WRsP/ihIsl0fWuQBcWke7UYEoSih
FhyGA1Oxqr1PL4qSVgZfKy18X1EFo6hyYtIGgOoC/MpBX8FvuX1nQ4ol1LPtahbZ
tXjFtogPcM2yJt+ZPD2Nb2VrTfhMtaLIH8qs4URElsgSS2m3Pu7sahjAzINGQrez
OFiNrgjaA1AWav6i/5KuEdizS7GDgmIEofs1Z5tJrfNQ9WJfBWA2Ff/ovN90U6fD
xnUlrD1h+0leQcFwh17XoEOE8Gfbujpn1PNU4+qdClUWTJut8VmE+fncbOzT4rKj
ALBHRKUejoG7Ix1kLoF5lQ+U0Qy/RNJfnPHiJLRbVvvDocylV4L+rL0ATnFFx1cn
ooP+kwx374x9GcIVAiLpChzp9yyzLvBJgr0ZatC6XOzjQLZUmtufSCVfnmAHNXKG
+U8nWhWjgJ/y6ozyLU1U6wk46+N1Ge5awGGk7z5Gmhp3xZ7MAscr8iPtwcoZcpTX
Yxgiu5TXScxNVDETIUQ08OrF+F8FtUaV7qAMbEV2VefWC/86e2nLkjXhWxORB8AC
J5ulgFvZ+mx7kMj6xGEUcafYUvxk4v8zUiK6LSxJY3i/LITLZGafQZpwfqnViQx7
HmVZDV1LRVqfxwsByomhETdgLrolLXscH1cqTpU9gQqbxJwtwJWkW48srs1NUIpk
Iv/ZHCZRHXG6M+taPO3k
=xD9f
-----END PGP SIGNATURE-----

--sy9WyBOsCRoUO165--
