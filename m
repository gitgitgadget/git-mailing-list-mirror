From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH] submodule : Add --no-separate-git-dir option to add and
 update command.
Date: Tue, 11 Mar 2014 10:55:03 +0100
Message-ID: <1394531703.7891.54.camel@Naugrim>
References: <5314BFA5.2030807@web.de> <1393878866.7891.22.camel@Naugrim>
	 <53176951.7000201@web.de> <1394069128.7891.29.camel@Naugrim>
	 <5318D101.9050305@web.de> <1394136925.7891.31.camel@Naugrim>
	 <5318DFDD.4060006@web.de> <1394144428.7891.33.camel@Naugrim>
	 <531A4FA3.3040007@web.de> <1394442486.7891.45.camel@Naugrim>
	 <20140310203245.GB5345@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0qAhxv6SssTJUFFfBW8W"
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:55:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNJP7-0007Mo-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 10:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbaCKJzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 05:55:15 -0400
Received: from smtpout4.laposte.net ([193.253.67.229]:16951 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbaCKJzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 05:55:13 -0400
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8508-out with ME
	id c9v31n0072iaXuy039v4ge; Tue, 11 Mar 2014 10:55:08 +0100
In-Reply-To: <20140310203245.GB5345@sandbox-ub>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243850>


--=-0qAhxv6SssTJUFFfBW8W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 10 mars 2014 =C3=A0 21:32 +0100, Heiko Voigt a =C3=A9crit :
> On Mon, Mar 10, 2014 at 10:08:06AM +0100, Henri GEIST wrote:
> > Le samedi 08 mars 2014 =C3=A0 00:00 +0100, Jens Lehmann a =C3=A9crit :
> > > Am 06.03.2014 23:20, schrieb Henri GEIST:
> > > >> What is the use case you are trying to solve and why can that
> > > >> not be handled by adding "subsubmodule" inside "submodule"?
> > > >=20
> > > > The problem is access rights.
> > > >=20
> > > > Imagine you have 2 people Pierre and Paul.
> > > > Each with different access write on the server.
> > > > Pierre has full access on every things.
> > > > Paul has full access on superproject and subsubmodule but no read/w=
rite
> > > > access to submodule only execution on the directory.
> > >=20
> > > Ok, I think I'm slowly beginning to understand your setup.
> > >=20
> > > > I want all user to get every things they are allowed to have with t=
he
> > > > command 'git submodule update --init --recursive'.
> > > > Then as Paul can not clone submodule he can not get subsubmodule
> > > > recursively through it.
> > >=20
> > > Sure, that's how it should work. Paul could only work on a branch
> > > where "submodule" is an empty directory containing "subsubmodule",
> > > as he doesn't have the rights to clone "submodule".
> >=20
> > I will not redundantly create a branch for each user on the server.
> > When users clone the server it already create a special branch for them
> > 'master' which track 'origin/master'. And if each user have its own bra=
nch
> > on the server it will completely defeat the goal of the server "collabo=
ration".
> > And transform the git server in simple rsync server.
>=20
> I do not think that is what Jens was suggesting. It does not matter in
> which branch they work, they can directly use master if you like. What
> he was suggesting is that they create their repository structure like
> this:
>=20
> git clone git@somewhere.net:superproject.git
> cd superproject/submodule
> git clone git@somehwere.net:subsubmodule.git
> cd subsubmodule
> ... work, commit, work, commit ...
>=20
> The same applies for the superproject. Now only someone with access to
> the submodule has to update the registered sha1 once the work is pushed
> to submodule.

I am not sure to understand everything.
But if you suggest to clone manually subsubmodule because it could
not be clone recursively by submodule due to the lake of access write
to get submodule.

It is not practical in my use cases.
Two of the superprojects I have in charge contains hundreds of submodules
or subsubmodules and I have too much users with disparate computer skills.

Getting all what a user has access on should be just a recursive clone.

>=20
> > > > And I need superproject to add also submodule/subsubmodule.
> > >=20
> > > No. Never let the same file/directory be tracked by two git
> > > repositories at the same time. Give Paul a branch to work on
> > > where "submodule" is just an empty directory, and everything
> > > will be fine. Or move "subsubmodule" outside of "submodule"
> > > (and let a symbolic link point to the new location if the
> > > path cannot be easily changed). Would that work for you?
> >=20
> > If I use symbolic links it will just as gitlink enable to use the
> > same subsubmodule clone by more than one superproject but with two
> > major problems :
> >   - symbolic links do not work under Windows and some of my users do
> >     not even know something else could exist.
> >   - symbolic links will not store the SHA-1 of the subsubmodule.
> >     And a 'git status' in the repository containing the symbolic link
> >     will say nothing about subsubmodule state.
>=20
> Here you are also missing something. What Jens was suggesting was that
> you move your subsubmodule directly underneath the superproject and from
> the old location you create a link to the new location for a quick
> transition. But you can also change all paths in your project to point
> to the new location. But in the new location you will have subsubmodule
> registered as a submodule only that it is now directly linked (as
> submodule) from the superproject instead of the submodule.
>=20

Ok but in this case what happen to someone cloning only submodule but
not superproject ? He will not get subsubmodule which is part of it.
Just a dead symbolic link with no hint on what is missing behind.

Each of my submodules (at any level) should be usable superprojects by
them self having a gitlink to each subsubmodules they needs.

> > I think where we diverge is in the way we are looking gitlinks.
> > Where you see a hierarchic tree, I see a web.
> > And I use gitlinks just like multiplatform symbolic links storing
> > the SHA-1 of there destination and pointing exclusively on git reposito=
ries.
>=20
> Well but the problem with a web is that it will introduce a lot of
> problems that need to be solved. Some repository has to have the
> authority about a file (or link). If you have a file in multiple
> repositories overlayed how do you know who is in charge and when?
>=20

It will not introduce a lot of problems.
Me and my teams are using gitlinks this way every days for 2 years know.
With a web far more complex than the example I give above.
And the problem you are speaking about and which we solve with the
--no-separate-git-dir option is the only one we encounter until now.

This solve the question of who is in charge ? and when ?
subsubmodule is in charge of itself. Always.

I know there is some good reasons for the separate gitdir.
But none of them bother me in my day to day use.
That is why I came with this simple solution

Another solution to combine all advantages.
Is deciding to always make superproject in charge and place a link
$SUBMODULE_GIT_DIR/modules/link_to_subsubmodule_gitdir
pointing to $SUPERPROJECT_GIT_DIR/modules/submodule/subsubmodule.

I think I can write a 3 step patch doing just that :

  1) A little change in the $GIT_DIR/modules layout making the
$SUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule/.git instead o=
f
$SUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule

Then it will be possible to have
$SUBSUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule/subsubmodul=
e/.git
and so on without risk of name collision in case subsubmodule have a name l=
ike
'branches', 'hooks', 'refs' or anything like that.

  2) Making submodules aware that they have been cloned has submodule and
where is at least one of their superproject that is the non trivial part.
Maybe choosing the one which actually clone it.
Another solution is to simply found it by the fact the $SUBMODULE_GIT_DIR
is supposed to be in the $SUPERPROJECT_GIT_DIR.

  3) Making 'git submodule <add|update>' search recursively through its
superprojects or directly for the top one and place adequately its own
$SUBSUBMODULE_GIT_DIR.


> There is a reason why it is designed like this: simplicity. I currently
> do not see how your web idea can be simple without introducing a lot of
> user interface questions.
>=20

Working with the web idea for several time now I can ensure you that
Git is so well designed that it is ready to use with this concept.
I have no user interface problem except the one we are speaking about.

> Cheers Heiko



--=-0qAhxv6SssTJUFFfBW8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMe3XcACgkQkKuHPdwEGdT9MgD/URauiHAqAuZN0546KrA/nMOj
TdOj0AR01OPcGlrwoI0A/28SkSH2SzwmeLgwZuX5vDY821Z4WU5/zq3TcmGp6P/C
=N+ik
-----END PGP SIGNATURE-----

--=-0qAhxv6SssTJUFFfBW8W--
