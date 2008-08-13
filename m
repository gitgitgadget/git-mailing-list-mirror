From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [BUG?] rebase -i -p leaves index changed
Date: Wed, 13 Aug 2008 22:51:03 +0200
Message-ID: <20080813205103.GB10758@leksak.fem-net>
References: <200808121116.41535.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:52:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNKI-0007cX-AC
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYHMUvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbYHMUvK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:51:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:57695 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751896AbYHMUvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:51:08 -0400
Received: (qmail invoked by alias); 13 Aug 2008 20:51:05 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp013) with SMTP; 13 Aug 2008 22:51:05 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18RzbMOLMkRLRpt28tFuWk+iq1vi6yZXhZaP+aS6N
	c0I031T+DE89g1
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KTNJ9-0005NS-NX; Wed, 13 Aug 2008 22:51:03 +0200
Content-Disposition: inline
In-Reply-To: <200808121116.41535.trast@student.ethz.ch>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92271>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thomas Rast wrote:
> 'rebase -i -p' appears to be a bit confused about what it is doing.
> Try a history like this:
>=20
>   O -- A -- M -- B
>    \       /
>     \- C -/
>=20
> built by:
>=20
>   git init
>   touch foo
>   git add foo
>   git ci -m initial
>   git tag root
>   git co -b side

Puh, it is nice that you provide a sequence how you generated your test
case, but "ci" and "co" are no git commands.  Ok, because of the
sequence it was clear to me that you mean "commit" and "checkout",
but I couldn't just c&p it into my xterm :(
;-)

> Second, 'edit' is also a bit suspicious:
>=20
>   git reset --hard
>   GIT_EDITOR=3D'perl -i -pe "s/pick 096/edit 096/"' git rebase -i -p root

This perl expression does nothing if your commit is not prefixed with 096 ;)
But I tested by changing the line of commit "a" to "edit".

> Despite claiming "Stopped at 096[...] a", a quick 'git show' tells us
> that it is actually stuck at 'initial'.  (At least 'git rebase
> --continue' then ends up with the same result as the first test.)

Regarding your [BUG?]: this is a bug, definitely.

> Granted, I'm not entirely sure what it _should_ do.  In my use case
> (relating to the filter-branch topic), C was a commit from elsewhere
> that B depended on.  So I kind of hoped 'rebase -i -p' would let me
> edit A, then rebuild M and B on top, while leaving C alone.

I think your hope is right.  So this is also a bug.

I tested this with my sequencer-based rebase -i -p first and it worked
as you hope. I tested it with your v2 patches and it works, too. ;)
So I'm having a deeper look at your patches in some minutes...

Regards,
  Stephan

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIo0k3bt3SB/zFBA8RAq/lAKC+13Ru9A81v2G7oCxcdmKE8o9lZACePwjx
mR3rJHGMpSzqdJQ41BpDmv4=
=hfNQ
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
