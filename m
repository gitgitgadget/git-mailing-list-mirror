From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Documentation: add a planning document for the next  CLI revamp
Date: Fri, 31 Oct 2008 09:20:15 +0100
Message-ID: <20081031082015.GA21015@artemis.corp>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz> <20081031003154.GA5745@sigill.intra.peff.net> <1225435238.20883.18.camel@maia.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="X1bOJ3K7DJ5YkBrT";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, Sam Vilain <samv@vilain.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:21:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvpGI-0007aJ-Ds
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbYJaIU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 04:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbYJaIU0
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:20:26 -0400
Received: from pan.madism.org ([88.191.52.104]:39331 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbYJaIUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:20:23 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id B53613B420;
	Fri, 31 Oct 2008 09:20:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6C1EC5EE23C; Fri, 31 Oct 2008 09:20:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225435238.20883.18.camel@maia.lan>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99561>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 06:40:38AM +0000, Sam Vilain wrote:
> On Thu, 2008-10-30 at 20:31 -0400, Jeff King wrote:
> > >  Some suggestions, which have been briefly scanned over by some of the
> > >  (remaining) GitTogether attendees.  Please keep it constructive!  :)
> > Thanks for putting this together.
>=20
> No problem!  Thanks for responding.  I've been amazed that it seems to
> have been largely taken well :)  But there are still very important
> changes required.

Well, most of it we discussed IRL, that helps tremendously ;)

> I still think it's OK to use 'git revert-files' for this; it just seems
> so long.  Switches could specify where to and from.

Well the point is we will probably just deprecate git-revert and remove
it alltogether in git 2.6. At that time you will be able to define
git-revert as an alias to git cherry-pick -R if you're an old fart, or
git revert-files if you're an svn user ;)

But I see no convincing name that hasn't "revert" in them, hence will be
long :/

> Of course 'git branch -q' would then be the quick version, or 'git
> br' (after git config --global alias.br 'branch -q')

oh no, not -q please, -q is quiet, -h is help, -v is verbose. I mean
POSIX should define these. Do not give those switch any other kind of
sementics anymore, we've done that, and it hurts. -Q is fine with me
though.

> Another command people often want is 'git info' to tell them stuff like
> they might get from 'git status' or 'git remote' but without all the
> file details...

And to say to them if they're in the midle of a merge, of a rebase, an
am, on a detached, head, .... what is in the __git_ps1 of bash actually.

> > > +  * 'git init --server' (or similar) should do everything required f=
or
> > > +    exporting::
> > > +----
> > > +chmod -R a+rX
> > > +touch git-daemon-export-ok
> > > +git gc
> > > +git update-server-info
> > > +chmod u+x .git/hooks/post-update
> > > +git config core.sharedrepository=3D1
> > > +----
> >=20
> > But not all of those things are necessarily related, and some of them
> > have security implications. I would hate to get a bug report like "I
> > used --server because I wanted to share my content via dumb http, but my
> > repo was p0wned because of too-loose group permissions."
>=20
> ok.  That should come down to the detail of how '--server' is specified,
> I think.  I'll expand on that during round 2.

What about git init --svn-like ? /me *ducks*

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkKv70ACgkQvGr7W6HudhxovwCgn+ymBBTHHt2CoAoDtRGlEjeD
RxkAnRWohEvKpD4g7IVO77zIm+pbMgYG
=MJH5
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
