From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 20:42:38 +0100
Message-ID: <20071211194238.GD20644@artemis.madism.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <vpq4pepcaz5.fsf@bauges.imag.fr> <alpine.LFD.0.9999.0712111119310.25032@woody.linux-foundation.org> <4aca3dc20712111124y1d9171eem4d2c4f0872703786@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="+KJYzRxRHjYqLGl5";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:43:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2B0U-0002wY-6u
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbXLKTml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbXLKTml
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:42:41 -0500
Received: from pan.madism.org ([88.191.52.104]:51284 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbXLKTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:42:40 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3EA1E2F6A4;
	Tue, 11 Dec 2007 20:42:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 28C1684E3; Tue, 11 Dec 2007 20:42:38 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4aca3dc20712111124y1d9171eem4d2c4f0872703786@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67922>


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2007 at 07:24:54PM +0000, Daniel Berlin wrote:
> On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Tue, 11 Dec 2007, Matthieu Moy wrote:
> > >
> > > I've seen you pointing this kind of examples many times, but is that
> > > really different from what even SVN does? "svn log drivers/char" will
> > > also list atomic commits, and give me a filtered view of the global
> > > log.
> >
> > Ok, BK and CVS both got this horribly wrong, which is why I care. Maybe
> > this is one of the things SVN gets right.
> >
> > I seriously doubt it, though. Do you get *history* right, or do you just
> > get a random list of commits?
>=20
> No, it will get actual history (IE not just things that happen to have
> that path in the repository)

OTOH svn has the result right, but the way it does that is horrible.
When you svn log some/path, I think it just (basically) ask svn log for
each file in that directory, and merge the logs together. This is "easy"
for svn since it remembers "where this specific file" came from.

So for svn it's just a matter of merging the individual files histories
together. It may have a more clever implementation, but basically I
believe it would be similar to that in the end.

Of course, if you do something as stupid as:
  svn cp Makefile some/path/foo.c
  # completely rewrite foo.c
  svn commit
then you'll have the history of `Makefile` melded into the
some/path/foo.c svn log, which is completely horribly wrong.

or if you do (which unlike the previous example isn't silly for so
many good reasons):
  cp bar.c foo.c
  svn add foo.c
  svn commit
then foo.c won't have bar.c history in its svn log.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHXuguvGr7W6HudhwRApGxAKCXI4I5oJpIMQsY6n6VGA+O3yFSkgCeLWdH
SIOYKr3nCuinqclgmod9cYY=
=AoLO
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
