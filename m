From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 17:19:21 +0200
Message-ID: <20070603151921.GB30347@artemis>
References: <20070603114843.GA14336@artemis> <878xb19ot5.fsf@graviton.dyn.troilus.org> <20070603133109.GD14336@artemis> <200706031548.30111.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="wq9mPyueHGvFACwf";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Michael Poole <mdpoole@troilus.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 17:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hurre-00057C-BP
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 17:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbXFCPTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 11:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbXFCPTX
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 11:19:23 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:33405 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbXFCPTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 11:19:23 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id E136A18EF2;
	Sun,  3 Jun 2007 17:19:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AB9DE17D73; Sun,  3 Jun 2007 17:19:21 +0200 (CEST)
Mail-Followup-To: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Poole <mdpoole@troilus.org>
Content-Disposition: inline
In-Reply-To: <200706031548.30111.johan@herland.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49007>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 03:48:29PM +0200, Johan Herland wrote:
> On Sunday 03 June 2007, Pierre Habouzit wrote:
> > On Sun, Jun 03, 2007 at 08:59:18AM -0400, Michael Poole wrote:
> > > Pierre Habouzit writes:
> > >
> > > >   The other problem I see is that at the time a bug gets reported, =
the
> > > > user knows it's found at a commit say 'X'. But it could in fact have
> > > > been generated at a commit Y, with this pattern:
> > > >
> > > >   --o---o---Y---o---o---o---o---X---o---o--> master
> > > >                      \
> > > >                       o---o---o---o---o---o--> branch B
> > >=20
> > > Mainly for that reason, I would suggest having it outside the code
> > > base's namespace: probably a different root in the same $GIT_DIR, but
> > > I can see people wanting to have a separate $GIT_DIR.  If the database
> > > tracks bugs by what commit(s) introduce or expose the bug -- at least
> > > once that is known -- then you get nearly free tracking of which
> > > branches have the bug without having to check out largely redundant
> > > trees.
> >=20
> >   Sure, but if it's completely out-of-tree, then cloning a repository
> > don't allow you to get the bug databases with it for free. I mean it'd
> > be great to have it somehow linked to the repository, but also I agree
> > that not everybody wants to clone the whole bugs databases. So maybe it
> > should just be in another shadow branch that annotates the devel ones.
> > Hmmm I definitely need to read the git-note thread...
>=20
> I guess I'm the one responsible for starting that git-note thread...
>=20
> For the moment, I'm busy implementing some concepts that came out of that=
=20
> discussion (refactoring tag objects and building some infrastructure need=
ed=20
> to support notes without the drawbacks present in my first version).
>=20
> Hopefully I'll have a proof-of-concept ready before too long. In the=20
> meantime I'll be happy to answer questions you might have.
>=20
> Regarding the notes themselves, I thought about possibly using them as a=
=20
> link between the repo and the bug tracker, with some glue code in between=
=20
> for making the connections. I haven't thought about integrating them more=
=20
> deeply into a bug tracker, but it might be worth thinking along those=20
> lines, especially for the kind of system you're proposing.

  Yeah, now that I read that thread, well yeah, I think notes are a hell
of a good concept for my ideas. I mean, a bug report would be basically
a collection of notes:
  * the bug has been found at this commit ;
  * the bug has been not-found at this commit ;
  * this commit is a fix for that bug ;
  * this commit enhance features for that wish and so on.
Some other bits are more followup comments and are disconnected to
commits, but could be attached to the "bug object" whatever would be
used for bugs, the whole concept is blurry anyways, we're just
discussing ideas :)

  Though, for a good bug tracking system, you need to be able to answer
some kind of questions fast enough:
  * list bugs that affect a given stage of the repository
    (tag/branch/commit/...) ;
  * be able to trace history of a given bug (yes, it's fairly obvious,
    but unlike many other bug tracking systems, for us it would not be
    contiguous, so it's not necessarily a O(1) operation) ;

  Other things nice to have is textual search, git-grep can help of
course, but that's an operation you do often with a bug tracking system,
and you expect it to be faster than git-grep is (though maybe an
optionnal index can be built around the notes for that purpose and not
be versionned ?).

  Another think that notes do not address are another operation we
usually do on bugs: merge (or duplicates). There is a think I hate in
bugzilla and love in debbugs, it's that duplicate bugs are closed in the
former, and merged in the latter. When two bugs are the same, their
history are often *both* valuable, and you really don't want to lose one
half, you want to merge them. And you also want the option to "unmerge"
them, but for that the better option is to have the ability to duplicate
a bug (aka debbugs cloning).

  Anyways it's just gossip, but maybe someone will have a brilliant
ideas, so I'm just throwing my thoughts into this mail :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYtv5vGr7W6HudhwRAql4AJ47HZtHbSTEA3J6m/HgCAuME6fipQCgiEGA
agpUm2DHlcpkNV8WoqRSVno=
=Dfy0
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
