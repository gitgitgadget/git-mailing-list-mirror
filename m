From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 3 Jun 2007 15:23:55 +0200
Message-ID: <20070603132355.GC14336@artemis>
References: <20070603114843.GA14336@artemis> <20070603123510.GC6992@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="hYooF8G/hrfVAmum";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:24:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huq3x-0002qY-KP
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbXFCNX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756340AbXFCNX6
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:23:58 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:44365 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192AbXFCNX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:23:58 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 23F2D18760;
	Sun,  3 Jun 2007 15:23:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CC923E5; Sun,  3 Jun 2007 15:23:55 +0200 (CEST)
Mail-Followup-To: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070603123510.GC6992@nan92-1-81-57-214-146.fbx.proxad.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48992>


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 03, 2007 at 02:35:10PM +0200, Yann Dirson wrote:
> On Sun, Jun 03, 2007 at 01:48:44PM +0200, Pierre Habouzit wrote:
> >   Hi, I'm currently trying to think about a bug tracking system that
> > would be tightly integrated with git, meaning that it would have to be
> > somehow decentralized.
>=20
> You may want to look at existing solutions, such as Bugs
> Everywhere[1], which has is modular wrt the backend SCM (supports Arch
> and Bazaar for now).
>=20
> I'm not sure its storage format is extensible enough, but it at least
> shows some interesting ideas.

  I looked at it, the idea is good, implementation quite wrong (too many
files, with too much crancky formats). But it's quite small, so if it's
the good way, it should be easy to adapt.

> >   I mean, the immediate idea is to have some .bugs/ directories (or
> > alike). This has many good properties, e.g. for projects like the linux
> > kernel with its many subsystems or driver, it would make sense to have
> > per driver/subsystems/... bug packs, and move bugs from one pack to
> > another would be the way of assigning bugs to different modules.
>=20
> What about a requirement that .bugs/ is at the project toplevel ?

  I don't see why it's necessary, it's just random thoughts and quite
outside the scope of my concerns right now.


> >   The other problem I see is that at the time a bug gets reported, the
> > user knows it's found at a commit say 'X'. But it could in fact have
> > been generated at a commit Y, with this pattern:
> >=20
> >   --o---o---Y---o---o---o---o---X---o---o--> master
> >                      \
> >                       o---o---o---o---o---o--> branch B
> >=20
> >=20
> >   Sadly, the bug report has been commited at 'X', hence it does taints
> > branch B. As "inserting" or "moving" 'X' commit before the branch is not
> > an option as it would rewrite history, that becomes also a major no-go
> > for in-tree collecting of bugs.
>=20
> Maybe "commit annotations" would help here ?  I have noticed a thread
> about a git-note tool, though did not open it yet - so I may be
> off-track here.

  Hmm, I'll try to search for it then.
> > PS: What I left over, is why I wanted such a tool. Programmers tends (or
> >     say I tend to, maybe I'm over-generalizing, but I seem to remember a
> >     thread on the lkml where Linus was basically saying the same) to
> >     hate bugzillas and such out-of-tree tool because they suck, and do
> >     not really fit in the programming cycle. I'd rather see a
> >     bugtracking system where the backend is in-tree, basically mboxes so
> >     that you can read them easily with your favourite MUA, as well as
> >     adding new comments in it the same way. It also accommodates with
> >     linux-like workflows where bugs usually are sent on the lkml, a bit
> >     like patches and pull requests are handled. That's the reasons why I
> >     came with this idea.
>=20
> I still have mixed feelings towards the idea of implementing a brand
> new defect-tracking system, when there are already so many of them,
> with many features already.  Eg., my initial opinion about Bugs
> Everywhere was that it was not complete enough to be used in many
> projects.
>=20
> I tend to think it would be more productive to do any necessary
> changes in widely-used bug trackers (bugzilla, mantis, rt...), and
> work on glue tools, like scmbug[2].

  Well, why writing yet-another-scm like err git ? Because other were
doing things wrong. Bugzilla, or especially rt are not distributed,
hence completely inadequate for use with git, whatever clumsy plumbing
you do to make them work. And I know what I'm talking about, I wrote the
plumbing for the debian bug tracking system, I've looked at a lot of
them. And only bugs everywhere was near what looks the good way, because
when you're able to deal with your code like git allows you to, it makes
absolutely no sense not being able to deal with your bug database the
same way.

  And FWIW I'm just asking questions, nothing more, just because I don't
want to rush in yet-another-tool if it appears it will be broken.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGYsDrvGr7W6HudhwRAllQAJ95e8yUQHrWy2wtcF86JYMJWfYRwACgg2Ds
TkHpgAuaCyUsBtr+wJhXO7c=
=6B3+
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
