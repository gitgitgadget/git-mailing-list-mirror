From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 01:12:20 +0200
Message-ID: <20080728231220.GA22625@artemis.madism.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <20080728220308.GF10409@artemis.madism.org> <32541b130807281532v3eed94ebv8037247618e9bd55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="u3/rZRmxL6MmkK24";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Nigel Magnay <nigel.magnay@gmail.com>, Git ML <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNjAN-0002v5-3o
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYG2G5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbYG2G5i
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:57:38 -0400
Received: from pan.madism.org ([88.191.52.104]:47290 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbYG2G5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:57:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 18D6A38BF5;
	Tue, 29 Jul 2008 08:57:33 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C17485AD30D; Tue, 29 Jul 2008 01:12:20 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32541b130807281532v3eed94ebv8037247618e9bd55@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90593>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2008 at 10:32:54PM +0000, Avery Pennarun wrote:
> On 7/28/08, Pierre Habouzit <madcoder@debian.org> wrote:
> >  > It's unfortunate that submodules involve a commit->tree->commit link
> >  > structure.
> >
> > Actually it's not a big problem, you just have to "dereference" twice
> >  instead of one, and be prepared to the fact that the second dereference
> >  may fail (because you miss some objects). I instead believe that
> >  gitlinks are a good idea.
>=20
> It's actually complicated to generate the log, however.  To be 100%
> accurate in creating a combined log of the supermodule and submodule,
> you'd have to check *for each supermodule commit* whether there were
> any changes in gitlinks.  And gitlinks might move around between
> revisions, so you can't just look up a particular path in each
> revision; you have to traverse the entire tree.  And you can't just
> look at the start and end supermodule commits to see if the gitlinks
> changed; they might have changed and then changed back, which is quite
> relevant to log messages.

I'm pretty clueless about how git-log works, but I fail to see how this
is harder than following file moves e.g. Of course it's more expensive
than git log, but it shouldn't really be more expensive than
`git log -M -C -C` already is.

> > Well, using the same [branch] as the supermodule is probably the less c=
onfusing
> >  way. Of course, not being in the "same" branch as the supermodule would
> >  clearly be a case of your tree being "dirty", and it would prevent a
> >  "git checkout" to work in the very same way that git checkout doesn't
> >  work if you have locally modified files.
> >
> >  If your submodule branching layout uses the same names as the
> >  supermodule branches then yes, it's going to hurt, but I believe it to
> >  be unlikely (else you would become insane just trying to remember what
> >  you are doing ;p).
>=20
> I think this is much more common than you think.  An easy example is
> that I'm developing a new version of my application in the
> supermodule's "master", but it relies on a released version of my
> submodule, definitely not the experimental "master" version.  Using
> your logic, the local branch of the submodule would be called master,
> but wouldn't correspond at all to the remote submodule's master.

Probably indeed, otoh the "remote" (assume it's origin) master state is
stored in "origin/master", not "master".

> I believe such a situation would be even worse than no branch at all.
> It could lead to people pushing/pulling all sorts of bad things from
> the wrong places.  At least right now, people become confused and ask
> for help instead of becoming confused and making a mess.

Indeed. But that's only a name issue, I'm sure we can come up with
something decent. What I (we ?) want is actually a way to make
git-checkout/git-reset work so that when you switch branches (reset
--hard to a previous state) you remain on branch, because human brains
usually don't remember those silly detached HEADs commits sha1 well ;)
The problem is, `the branch I'm on in my submodule when the supermodule
is on $foo` is a quite local information. But that's really what we
would like to remember so that when you git checkout somewhere and git
checkout master back, submodules switches branch accordingly.

Saying that, I realize that we probably _really_ want to name submodule
branches the same as the supermodule ones, but should manage to find UIs
that don't confuse users wrt the fact that it may be disconnected from
the remote branch nameing.

I reckon that for my use, I would not have those problems, because we
have this kind of layout:

lib-foo/ <-- submodule to share the foo library.
lib-bar/ <-- submodule to share the bar library.
app-frotz/ <-- the frotz product

In another repository we have app-quux and the same submodules, and so
on.

We always try that our `master`s (where devel happens unlike git.git ;p)
use the most recent `master` versions from the submodules. And the
stable branches (IOW the software that we sold and released and for
which we provide support), have branches named $product/$version. We
have $product/$version branches in those submodules as well. If we have
a bug that needs a patch in say, lib-foo, then we push the patch into a
topic branch, that we merge in all the $product/$version that need it,
and into master as well. For such a setup that I believe to be sane,
then well, corresponding names fit the job perfectly.

Of course if one of your submodule is git.git where the not too unstable
code lives in `next` and not `master` and another one is one of my
project at work, where not too unstable code lives in `master` then
indeed you're somehow screwed because indeed the whole `master` concept
would be quite confusing. But honestly, I don't think it's less
confusing with the current way submodules work either.


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiOUlMACgkQvGr7W6HudhzYlgCggGraWRaJaYgqXiqY6VS3x23C
nyQAoITxbz/ogxe8UAagQjVLZ39dFDTQ
=p2jQ
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
