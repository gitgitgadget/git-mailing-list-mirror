From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Submodule handling broken when changing branches?
Date: Tue, 15 Jun 2010 08:23:55 +0200
Message-ID: <20100615062355.GA3096@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Cc: Steven Armstrong <steven.armstrong@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 08:34:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOPif-00079R-PI
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 08:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab0FOGdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 02:33:52 -0400
Received: from mx3.schottelius.org ([77.109.138.221]:41139 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab0FOGdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 02:33:51 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jun 2010 02:33:51 EDT
Received: from kr.localdomain (mx3.schottelius.org [77.109.138.221])
	by mx3.schottelius.org (Postfix) with ESMTP id 3F490197A041;
	Tue, 15 Jun 2010 08:24:51 +0200 (CEST)
Received: by kr.localdomain (Postfix, from userid 1000)
	id 78DEC943CA; Tue, 15 Jun 2010 08:23:55 +0200 (CEST)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Netzseite: http://www.nico.schottelius.org/
X-System-Info: kr (Linux 2.6.34-NS-08528-gb3f2f6c x86_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149162>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good morning devs,

I'm wondering whether it is the intented behaviour that after
adding a submodule one is unable to change branchen?

Steps to reproduce

   ( mkdir sm && cd sm && touch a && git init && git add . && git commit -m=
 "init" )

   ( mkdir -p project/smdir && cd project && touch smdir/a  && git init && =
git add . && git commit -m "init" && git branch second )=20

  ( cd project && git rm smdir/a &&  git commit -m "remove file that will b=
e replaced by sm")
 =20
  ( cd project && git submodule add ~/temp/git/sm smdir && git submodule up=
date --init && git commit -m "add submodule" )

  ( cd project && git checkout second )
  error: Untracked working tree file 'smdir/a' would be overwritten by merg=
e.

It seems that the contents of a submodule are not cleanly moved away
when switching branches, I also see that in other places where the directory
is not known to the other branch, it will just stay.

If that is intented, what would be the clean way to switch the branch?
If so, shouldn't it be documented in the manpage?

Nico

--=20
New PGP key: 7ED9 F7D3 6B10 81D7 0EC5  5C09 D7DC C8E4 3187 7DF0
Please resign, if you signed 9885188C or 8D0E27A4.

Currently moving *.schottelius.org to http://www.nico.schottelius.org/ ...

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwXHHsACgkQ19zI5DGHffAmGQCeI1pO+saXjq+KI9tn4avHHABz
2SAAn04Jxzw5G/M4/Xqg/9A4/TVMkC7P
=LXTV
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
