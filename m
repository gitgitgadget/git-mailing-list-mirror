From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 16:53:42 +0200
Message-ID: <20070613145342.GG5311@artemis.intersec.eu>
References: <18031.64456.948230.375333@lisa.zopyra.com> <20070613143845.GD5311@artemis.intersec.eu> <18032.776.784080.321044@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="7cm2iqirTL37Ot+N";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 16:53:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUEM-0004Km-Al
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 16:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872AbXFMOxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 10:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758866AbXFMOxp
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 10:53:45 -0400
Received: from pan.madism.org ([88.191.52.104]:53942 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758854AbXFMOxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 10:53:44 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 05083CE05;
	Wed, 13 Jun 2007 16:53:43 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AD3B01AF1A; Wed, 13 Jun 2007 16:53:42 +0200 (CEST)
Mail-Followup-To: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <18032.776.784080.321044@lisa.zopyra.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50068>


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2007 at 09:45:28AM -0500, Bill Lear wrote:
> [Pierre writes:]
> >  I suppose the following way would work:
> >
> >  $ git commit -a -m "temporary commit"  # save current work
> >  $ git branch -f dirty                  # ..in a separate branch
> >  $ git reset --hard HEAD~1              # unwind this commit
> >  $ git pull                             # perform a clean pull
> >  $ git rebase master dirty              # rewrite the work
> >  <you may have to fix some conficts here>
> >  $ git reset master                     # "undo" the commit
> >
> >  So that's definitely doable.
> >
> >  Though, in git, if you really work in a "pure" git environment, you
> >never pull until your work in your topic branch is ready for a merge.
> >It's a very bad habit to do otherwise: you don't _need_ to pull until
> >you have a clean slate.
>=20
> I know, but I can't throw git purity at them as an explanation, they
> won't understand.  And they would disagree about the "need" to pull.
> That's for them to say: they WANT to pull without having to move aside
> the makefile that they modified to add the '-wingit' option to the
> compile line and just get on with their work without having to run 14
> different git commands.
>=20
> I'm not trying to justify their habits, but to try to see if there is
> any clinching reason why this habit is not only "bad", but positively
> harmful.

  If it's because they have local modifications that match their use and
are not meant to be commited then I'd say that leaving it as "unclean"
work is a bad idea, because one day or the other they will have to
modify this Makefile to add a thing to commit for real. and then, 99
times over 100 they will commit their local modification too. _that_ is
harmful. And usually there is very soon a new commit to remove the local
change.

  I have a project where we had .htaccess that people had to customize
to have their local checkout work in the devel web server setup. It was
always commited (wrongly). We weren't using git.

  To solve those issues, there is many ways, not all are very handy, but
it works. The simplest way is to use a repository with a tool like
guilt, and each time you commit, you:

  guilt pop -a (remove your changes)
  ... do the stuff ...
  guilt push -a (push your changes again).

  Maybe you can also have a local branch where you store those local
changes. But that's still a bit awkward to use. Maybe someone will come
with a better workflow for this.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGcAT2vGr7W6HudhwRAo71AKCnj8BfR3xJyYYG7pjjGLdT0Bcb7gCfd57O
N2b42zJkVhmZ9UBJL3uyQbY=
=Isnp
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
