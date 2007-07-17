From: martin f krafft <madduck@madduck.net>
Subject: gitignore and shared worktrees (was: finding the right remote
	branch for a commit)
Date: Tue, 17 Jul 2007 15:09:36 +0200
Message-ID: <20070717130936.GA19724@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 15:09:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAmoD-0007fs-1H
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 15:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbXGQNJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 09:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXGQNJk
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 09:09:40 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:51820 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbXGQNJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 09:09:39 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id E4F0D895D8F;
	Tue, 17 Jul 2007 15:09:37 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20066-10; Tue, 17 Jul 2007 15:09:37 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 87E32895D8E;
	Tue, 17 Jul 2007 15:09:37 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 18DA29F166;
	Tue, 17 Jul 2007 15:09:37 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id D3D5643EA; Tue, 17 Jul 2007 15:09:36 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52758>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for the somewhat late reply, I just found time on the weekend
to check out this suggestion by Johannes

  (http://marc.info/?l=3Dgit&m=3D118418927823760&w=3D2)

also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.07.11.21=
26 +0200]:
> Come to think of it, this is maybe what I would have done, but it
> appears to me that this is the _ideal_ use case for worktree:
>=20
> In $HOME/gits:
>=20
> $ mkdir vim.git && cd vim.git
> $ git --work-tree=3D$HOME init
> $ cat >> info/exclude < EOF
> *
> !/.vimrc
> EOF
>=20
> Then you could do all Git operations like push, fetch, pull, log in=20
> $HOME/gits/vim.git, and all editing in $HOME.

This actually seems to work really nicely, but I am somewhat
displeased by the gitignore/exclude handling, since it's local. What
I want to do is synchronise the vim configuration across many
workstations with git, and I don't want to have to modify
$GIT_DIR/info/exclude on each machine.

So I am tempted to use .gitignore, but that lives in the worktree,
and since the suggestion is to share worktrees between different git
repos, I can only ever have one .gitignore file, which would have to
list ignores for *all* repos in $HOME/gits, which breaks my head.

Do you have any other idea on how to handle ignores? I guess one
alternative is just to ignore git status output altogether, but
that's not really nice.

Would people consider honoring .gitignore-* in addition to just
=2Egitignore? Or maybe even honouring .gitignore/*, if .gitignore is
a directory, not a file?

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"i like .net for the same reason i like gentoo. it keeps all the
 people with no clue from writing c code, which is much harder for me
 to identify and eliminate from my systems. in the same way that
 gentoo gives those people a place to be that isn't in debian"
                                                    -- andrew suffield

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGnL+QIgvIgzMMSnURAliWAJwMl8fDbCndyMuoO6SBIHFJa/yHXgCfQmfE
DSwbSozAgYwm2Aa1GapKRhY=
=X7pN
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
