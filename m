From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 16:43:11 +0200
Message-ID: <20070613144311.GE5311@artemis.intersec.eu>
References: <18031.64456.948230.375333@lisa.zopyra.com> <20070613143845.GD5311@artemis.intersec.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="J5MfuwkIyy7RmF4Q";
	protocol="application/pgp-signature"; micalg=SHA1
To: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 16:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyU42-0001P6-TR
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbXFMOnN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbXFMOnN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:43:13 -0400
Received: from pan.madism.org ([88.191.52.104]:47980 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbXFMOnM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:43:12 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DBA62839C;
	Wed, 13 Jun 2007 16:43:11 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 81CE21AF1B; Wed, 13 Jun 2007 16:43:11 +0200 (CEST)
Mail-Followup-To: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070613143845.GD5311@artemis.intersec.eu>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50063>


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 04:38:45PM +0200, Pierre Habouzit wrote:
> On Wed, Jun 13, 2007 at 09:14:32AM -0500, Bill Lear wrote:
> > We have some CVS users who complain that they cannot do a pull
> > into a dirty working tree, as they could under CVS.  Here is
> > their scenario: they make a few changes to their code and want
> > to test it out; someone else pushes changes to the central repo
> > that they then want to add to their working tree to test also;
> > they then want to pull in these changes and test everything, as
> > if they had done 'mv stuff stuff-; git pull; mv stuff- stuff'.
> >=20
> > They would like an option (perhaps a config option) to do a "dirty
> > pull".
> >=20
> > The git-merge documentation states:
> >=20
> >   You may have local modifications in the working tree files. In other
> >   words, git-diff is allowed to report changes. However, the merge uses
> >   your working tree as the working area, and in order to prevent the
> >   merge operation from losing such changes, it makes sure that they do
> >   not interfere with the merge. Those complex tables in read-tree
> >   documentation define what it means for a path to "interfere with the
> >   merge". And if your local modifications interfere with the merge,
> >   again, it stops before touching anything.
> >=20
> > But my colleagues are still wondering: why can't git just do it as
> > CVS does?
> >=20
> > I know there are workarounds: I myself documented a set of commands
> > to "put things on a shelf", but they still are whining.
> >=20
> > I need a convincing argument: not a technical one, but one that is
> > practical (e.g. where CVS would do harm that git is preventing).
> >=20
> > So, any explanation that I can give them why we can't have a 'git pull
> > --dirty' that moves things out of the way, then does the merge, then
> > moves thing back, aside from that it is stupid?
>=20
>   I suppose the following way would work:
>=20
>   $ git commit -a -m "temporary commit"  # save current work
>   $ git branch -f dirty                  # ..in a separate branch
>   $ git reset --hard HEAD~1              # unwind this commit
>   $ git pull                             # perform a clean pull
>   $ git rebase master dirty              # rewrite the work
>   <you may have to fix some conficts here>

>   $ git reset master                     # "undo" the commit

  okay this is wrong because you would then "live" in the `dirty`
branch. So you'd have to do sth like:

   git checkout master
   git diff master..dirty | git apply
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcAJ/vGr7W6HudhwRAp71AKCGAgop1lteinRQcDBmO3KzC2wuBgCgoJav
okb0VqoVjCob//y2UXrGSuA=
=bYDr
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
