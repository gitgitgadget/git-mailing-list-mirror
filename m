From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Tue, 26 Jul 2005 01:42:57 +0200
Message-ID: <20050725234257.GC5680@kiste.smurf.noris.de>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de> <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Cc: Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 01:44:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxCcn-0003vO-Hg
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 01:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGYXoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 19:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGYXoe
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 19:44:34 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:6365 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261236AbVGYXod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 19:44:33 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DxCb5-0003iP-IE; Tue, 26 Jul 2005 01:43:28 +0200
Received: (nullmailer pid 18565 invoked by uid 501);
	Mon, 25 Jul 2005 23:42:57 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Linus Torvalds:
> In particular, they always end up being imported as zero-sized empty
> files, and will be filled in only later if that file is ever touched=20
> again. In other words, the resulting git tree ends up being bogus.
>=20
That's a problem with the bkcvs tree. Remember tht Bitkeeper does
exactly the same thing -- the 1.0 version of *any* file is empty, and
content appears only in version 1.1.

Well, the bkcvs export preserved that ... "feature".

(Side question - why aren't you doing a direct bk2git import?)

> 	Argument "28213 has collisions" isn't numeric in addition (+) at /home/t=
orvalds/bin/git-cvsimport-script line 600, <CVS> line 1.

That's an output from cvsps that is not handled yet.
If you really need it I'll have to investigate.

> Btw, looking at what the perl script _seems_ to do, it does seem to do
> insane things for the local CVS archive case. As far as I can tell from
> the spaghetti that is perl, it uses a CVS server to handle even the local=
=20
> file case, which just _can't_ be right.

Sure it is, because ...

>                                         I realize you'd want to do that t=
o=20
> avoid connecting millions of times, but maybe it's better to use somethin=
g=20
> like cvsnup to download the whole thing, and then always use a local CVS=
=20
> archive?

=2E.. I don't have a sensible RCS library for perl (the code that I could
find is just a command line front-end). Fork+exec of some cvs checkout
command per file is slower than just running a persistent CVS server.

I've tried other ideas, but they run into problems because some
idiots^Wpeople occasionally tag only parts of a CVS tree, or they do it
at different times, and cvsps has to rearrange stuff in a way the CVS
utilities don't understand, so any higher-level access than "grab a
bunch of files by their revision number and stick them into a commit"
don't work in real life.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Please try to limit the amount of "this room doesn't have any bazingas"
until you are told that those rooms are "punched out."  Once punched out,
we have a right to complain about atrocities, missing bazingas, and such.
		-- N. Meyrowitz

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC5XkA8+hUANcKr/kRAr2MAJsEBgqz3iGK40qyOiEDqaAVFYC2lACfWX7A
zDB9cjIX9Oisjl6ED+FhAdc=
=1A5i
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
