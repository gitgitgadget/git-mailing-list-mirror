From: Joey Hess <id@joeyh.name>
Subject: GIT_INDEX_FILE relative path breaks in subdir
Date: Tue, 17 May 2016 13:18:36 -0400
Message-ID: <20160517171836.GA12183@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 19:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2idq-0007x8-74
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbcEQRSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:18:41 -0400
Received: from kitenet.net ([66.228.36.95]:48390 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbcEQRSk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:18:40 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=d5X98ctA;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1463505516; bh=PypnXtxuUGS4dCVRigdFF2U1WxKWLF1seengWMBIuvg=;
	h=Date:From:To:Subject:From;
	b=d5X98ctAROpzTwAW+CCJkprjLeWkeC/aY/7eWh6ZE+xLq/U8LmdMzULeGW3ld+2PY
	 2oCwotf208Zafb0at60fS+1inOJd4/Z2Kgc85QLueKnJ+LKhYiDmGnEMZTmaSwPB7B
	 zB62gqRmur0MeYDBEsk4gZ/CuNiNkb0Q9IEiyRjs=
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-98.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RDNS_DYNAMIC,SPF_SOFTFAIL,
	USER_IN_WHITELIST autolearn=no autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294880>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

joey@darkstar:/tmp>git init test
Initialized empty Git repository in /tmp/test/.git/
joey@darkstar:/tmp>cd test
joey@darkstar:/tmp/test>mkdir sub
joey@darkstar:/tmp/test>cd sub
joey@darkstar:/tmp/test/sub>GIT_INDEX_FILE=3D../.git/otherindex git write-t=
ree
fatal: Unable to create '/tmp/test/../.git/otherindex.lock': No such file o=
r directory

Appears to be a bug in git. Seems that it's assuming GIT_INDEX_FILE is
relative to the top of the worktree and not to the CWD.

Workaround: Use absolute path to the index file.

joey@darkstar:/tmp/test/sub>GIT_INDEX_FILE=3D`pwd`/../.git/otherindex git w=
rite-tree
4b825dc642cb6eb9a060e54bf8d69288fbee4904
joey@darkstar:/tmp/test/sub>ls ../.git/otherindex=20
=2E./.git/otherindex

git version 2.8.1

--=20
see shy jo

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVztSbMkQ2SIlEuPHAQKdhBAAt07qI4Jtt1pQhUb2MW/kMXBLrgbLCGcF
Z3SPtaudy7161rN26t7y7QMhzh/l9qq7Yi9e4gIlaKyha9xrboiW/isJ4OkMeN77
EUx7njFEzv5FMPj4DZBSXvjgi9Nscvi0+8XWoQ1X4glhHfVRjZIvJq8WDPqEFCjp
wyRsMojm/+Zr7BUU7svox8atzd4VG2Oyst4PzZEfuMWSeaL3ABoVr6JddQ+YXD1Q
U0N2gzhxgbcHOsY5pCaEYmxgb0t5u7vPfriNJA/GTm3qgNNujU7qKliD8bDR7s8l
2EECvug6ZecxBS9HaLcL3wREOOVvLWLTzGLErmbsy7mzDomJd7x1ZzZKQjn7onu2
dhS1EW+bFOe3golPxb9ChMVJlpyJ7n1w2oXAY7ca6mtI+ajWeJhYS1ePRzT1O/ky
kStgoUDWAqJCQhREhxDFGKyqXszTcW8dK/EYHxSL89Ual0M1LIDpbZK9/POgEd+Z
3Oy2oYmAMe7VMdg8VOW/QHmmjXU5eN/6AgE2h0bRpWvkx8GpE0YHSak540qtWGsG
fyAWAeP79v1xfNpVau40AWJFJ+3UkeQu6MmikrEnavH77hzLZVTfCVfJ5BUXAiKU
Jv+mZv3nOF5Sk4W/T02RPdRLVPaLDnJua3/PqrZZtJz+HUBvPQwyBozuCJ15IaAe
2x4BzrLbWEA=
=+fBq
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
