From: Joachim Breitner <mail@joachim-breitner.de>
Subject: Storing commits in trees
Date: Thu, 15 Apr 2010 22:32:12 +0200
Message-ID: <1271363532.18164.47.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qM4+TLQEJ/Jo/IgSJCuI"
Cc: "Bernhard R . Link" <brlink@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 22:55:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2W62-0005qS-Ci
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 22:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab0DOUz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 16:55:28 -0400
Received: from nomeata.de ([80.86.81.20]:37701 "EHLO quimby.ehbuehl.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756793Ab0DOUz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 16:55:28 -0400
X-Greylist: delayed 1389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2010 16:55:27 EDT
Received: from kirk.vpn.ehbuehl.net ([10.254.1.12] helo=localhost)
	by quimby.ehbuehl.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <msg@joachim-breitner.de>)
	id 1O2VjS-0000gq-Ua; Thu, 15 Apr 2010 22:32:15 +0200
Received: from jojo by localhost with local (Exim 4.71)
	(envelope-from <msg@joachim-breitner.de>)
	id 1O2VjR-0005f1-3C; Thu, 15 Apr 2010 22:32:13 +0200
X-Mailer: Evolution 2.29.92.1 
X-Spam-Score: -6.6 (------)
X-Spam-Report: Status No, score=-6.6 required=5.0 bayes=0.0000 tests=BAYES_00=-6.599 autolearn=ham version=3.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145025>


--=-qM4+TLQEJ/Jo/IgSJCuI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Please CC me on reply, as I=E2=80=99m not subscribed. Thanks!]

Hi,

for a variation of the workflow implemented by git-dpm[1], a tool to
manage the development of Debian packages in git, I wanted to refer to a
specific commit P from a regular commit D on my master branch, without P
being a parent of D, as I don=E2=80=99t want it to show up in the history.

I found out that I can store commit objects in a tree object, using git=20
$ git update-index --add --cacheinfo 160000 0ac1855f1681c05d195f219c3003a05=
dc8d3ac20 stored-commits/some-commit
and refer to it via HEAD:stored-commits/some-commit. I was happy, until
I noticed that git prune will happily delete the stored commit as soon
as it is not referred somewhere else, and git push/pull won=E2=80=99t trans=
fer
the stored commit along the tree it is contained in.

I then found out that storing commit objects in the tree is implemented
for git-submodules, where you in fact do not want to store the commit in
the main repo.

Now I=E2=80=99m wondering if it would be feasible to offer this feature: A
proper =E2=80=9Ccommit=E2=80=9D object within a tree that is walked by fsck=
_walk_tree
and the other tree walkers?

Or is there yet another way of telling git that commit D =E2=80=9Cdepends o=
n=E2=80=9D
commit P?

Thanks,
Joachim

[1] http://git-dpm.alioth.debian.org/



--=20
Joachim "nomeata" Breitner
  mail: mail@joachim-breitner.de | ICQ# 74513189 | GPG-Key: 4743206C
  JID: nomeata@joachim-breitner.de | http://www.joachim-breitner.de/
  Debian Developer: nomeata@debian.org

--=-qM4+TLQEJ/Jo/IgSJCuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvHd8wACgkQ9ijrk0dDIGy+CQCdHsvigfSD9dITC4oKn44NvYWb
ipwAn3od9jHNnXJuHiClPN/U+JaBfpuL
=LDrW
-----END PGP SIGNATURE-----

--=-qM4+TLQEJ/Jo/IgSJCuI--
