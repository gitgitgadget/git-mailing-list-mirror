From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] submodule : Add --no-separate-git-dir option to add
 and update command.
Date: Tue, 11 Mar 2014 21:11:10 +0100
Message-ID: <20140311201110.GB4833@sandbox-ub>
References: <53176951.7000201@web.de>
 <1394069128.7891.29.camel@Naugrim>
 <5318D101.9050305@web.de>
 <1394136925.7891.31.camel@Naugrim>
 <5318DFDD.4060006@web.de>
 <1394144428.7891.33.camel@Naugrim>
 <531A4FA3.3040007@web.de>
 <1394442486.7891.45.camel@Naugrim>
 <20140310203245.GB5345@sandbox-ub>
 <1394531703.7891.54.camel@Naugrim>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Henri GEIST <geist.henri@laposte.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:11:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNT1K-0007Rs-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362AbaCKULX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 16:11:23 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.93]:49392 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbaCKULV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:11:21 -0400
Received: from [77.20.146.74] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WNT15-0000PZ-Oj; Tue, 11 Mar 2014 21:11:12 +0100
Content-Disposition: inline
In-Reply-To: <1394531703.7891.54.camel@Naugrim>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243890>

On Tue, Mar 11, 2014 at 10:55:03AM +0100, Henri GEIST wrote:
> Le lundi 10 mars 2014 =E0 21:32 +0100, Heiko Voigt a =E9crit :
> > On Mon, Mar 10, 2014 at 10:08:06AM +0100, Henri GEIST wrote:
> > > Le samedi 08 mars 2014 =E0 00:00 +0100, Jens Lehmann a =E9crit :
> > > > Am 06.03.2014 23:20, schrieb Henri GEIST:
> > > > >> What is the use case you are trying to solve and why can tha=
t
> > > > >> not be handled by adding "subsubmodule" inside "submodule"?
> > > > >=20
> > > > > The problem is access rights.
> > > > >=20
> > > > > Imagine you have 2 people Pierre and Paul.
> > > > > Each with different access write on the server.
> > > > > Pierre has full access on every things.
> > > > > Paul has full access on superproject and subsubmodule but no =
read/write
> > > > > access to submodule only execution on the directory.
> > > >=20
> > > > Ok, I think I'm slowly beginning to understand your setup.
> > > >=20
> > > > > I want all user to get every things they are allowed to have =
with the
> > > > > command 'git submodule update --init --recursive'.
> > > > > Then as Paul can not clone submodule he can not get subsubmod=
ule
> > > > > recursively through it.
> > > >=20
> > > > Sure, that's how it should work. Paul could only work on a bran=
ch
> > > > where "submodule" is an empty directory containing "subsubmodul=
e",
> > > > as he doesn't have the rights to clone "submodule".
> > >=20
> > > I will not redundantly create a branch for each user on the serve=
r.
> > > When users clone the server it already create a special branch fo=
r them
> > > 'master' which track 'origin/master'. And if each user have its o=
wn branch
> > > on the server it will completely defeat the goal of the server "c=
ollaboration".
> > > And transform the git server in simple rsync server.
> >=20
> > I do not think that is what Jens was suggesting. It does not matter=
 in
> > which branch they work, they can directly use master if you like. W=
hat
> > he was suggesting is that they create their repository structure li=
ke
> > this:
> >=20
> > git clone git@somewhere.net:superproject.git
> > cd superproject/submodule
> > git clone git@somehwere.net:subsubmodule.git
> > cd subsubmodule
> > ... work, commit, work, commit ...
> >=20
> > The same applies for the superproject. Now only someone with access=
 to
> > the submodule has to update the registered sha1 once the work is pu=
shed
> > to submodule.
>=20
> I am not sure to understand everything.
> But if you suggest to clone manually subsubmodule because it could
> not be clone recursively by submodule due to the lake of access write
> to get submodule.
>=20
> It is not practical in my use cases.
> Two of the superprojects I have in charge contains hundreds of submod=
ules
> or subsubmodules and I have too much users with disparate computer sk=
ills.
>=20
> Getting all what a user has access on should be just a recursive clon=
e.

Then I would think about getting rid of the recursion part as it seems
you have interdependencies which can only be solved by a package
management system. I would see the superproject as this package
management system, but it requires you to have all the submodules next
to each other instead of contained in each other.

I think in terms of combining libraries that is actually the correct
solution because there can be modules that need each other. Some
submodule A might evolve and add a dependency to a subsubmodule B that
is itself contained in another submodule C. Then it just does not feel
correct anymore that B is contained in C. You want to have one instance
that is in charge of all the dependencies, that is IMO directly the
superproject and not something that reaches through another submodule
to record a dependency to a subsubmodule.

> > > > > And I need superproject to add also submodule/subsubmodule.
> > > >=20
> > > > No. Never let the same file/directory be tracked by two git
> > > > repositories at the same time. Give Paul a branch to work on
> > > > where "submodule" is just an empty directory, and everything
> > > > will be fine. Or move "subsubmodule" outside of "submodule"
> > > > (and let a symbolic link point to the new location if the
> > > > path cannot be easily changed). Would that work for you?
> > >=20
> > > If I use symbolic links it will just as gitlink enable to use the
> > > same subsubmodule clone by more than one superproject but with tw=
o
> > > major problems :
> > >   - symbolic links do not work under Windows and some of my users=
 do
> > >     not even know something else could exist.
> > >   - symbolic links will not store the SHA-1 of the subsubmodule.
> > >     And a 'git status' in the repository containing the symbolic =
link
> > >     will say nothing about subsubmodule state.
> >=20
> > Here you are also missing something. What Jens was suggesting was t=
hat
> > you move your subsubmodule directly underneath the superproject and=
 from
> > the old location you create a link to the new location for a quick
> > transition. But you can also change all paths in your project to po=
int
> > to the new location. But in the new location you will have subsubmo=
dule
> > registered as a submodule only that it is now directly linked (as
> > submodule) from the superproject instead of the submodule.
> >=20
>=20
> Ok but in this case what happen to someone cloning only submodule but
> not superproject ? He will not get subsubmodule which is part of it.
> Just a dead symbolic link with no hint on what is missing behind.
>=20
> Each of my submodules (at any level) should be usable superprojects b=
y
> them self having a gitlink to each subsubmodules they needs.

Then you will end up duplicating many submodules if everything should
contain everything it needs. Think about the example I described above.
In case of libraries, that will become a management nightmare.

> > > I think where we diverge is in the way we are looking gitlinks.
> > > Where you see a hierarchic tree, I see a web.
> > > And I use gitlinks just like multiplatform symbolic links storing
> > > the SHA-1 of there destination and pointing exclusively on git re=
positories.
> >=20
> > Well but the problem with a web is that it will introduce a lot of
> > problems that need to be solved. Some repository has to have the
> > authority about a file (or link). If you have a file in multiple
> > repositories overlayed how do you know who is in charge and when?
> >=20
>=20
> It will not introduce a lot of problems.
> Me and my teams are using gitlinks this way every days for 2 years kn=
ow.
> With a web far more complex than the example I give above.
> And the problem you are speaking about and which we solve with the
> --no-separate-git-dir option is the only one we encounter until now.
>=20
> This solve the question of who is in charge ? and when ?
> subsubmodule is in charge of itself. Always.
>=20
> I know there is some good reasons for the separate gitdir.
> But none of them bother me in my day to day use.
> That is why I came with this simple solution
>=20
> Another solution to combine all advantages.
> Is deciding to always make superproject in charge and place a link
> $SUBMODULE_GIT_DIR/modules/link_to_subsubmodule_gitdir
> pointing to $SUPERPROJECT_GIT_DIR/modules/submodule/subsubmodule.
>=20
> I think I can write a 3 step patch doing just that :
>=20
>   1) A little change in the $GIT_DIR/modules layout making the
> $SUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule/.git ins=
tead of
> $SUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule
>=20
> Then it will be possible to have
> $SUBSUBMODULE_GIT_DIR=3D$SUPERPROJECT_GIT_DIR/modules/submodule/subsu=
bmodule/.git
> and so on without risk of name collision in case subsubmodule have a =
name like
> 'branches', 'hooks', 'refs' or anything like that.
>=20
>   2) Making submodules aware that they have been cloned has submodule=
 and
> where is at least one of their superproject that is the non trivial p=
art.
> Maybe choosing the one which actually clone it.
> Another solution is to simply found it by the fact the $SUBMODULE_GIT=
_DIR
> is supposed to be in the $SUPERPROJECT_GIT_DIR.
>=20
>   3) Making 'git submodule <add|update>' search recursively through i=
ts
> superprojects or directly for the top one and place adequately its ow=
n
> $SUBSUBMODULE_GIT_DIR.
>=20
>=20
> > There is a reason why it is designed like this: simplicity. I curre=
ntly
> > do not see how your web idea can be simple without introducing a lo=
t of
> > user interface questions.
> >=20
>=20
> Working with the web idea for several time now I can ensure you that
> Git is so well designed that it is ready to use with this concept.
> I have no user interface problem except the one we are speaking about=
=2E

If you have multiple superprojects for a submodule in which superprojec=
t
do you commit a change on a gitlink?

Don't you end up having a lot of commits if you have to commit in
multiple superprojects?

Suppose you have a directory layout like this:

super\
   submoduleA\
   	submoduleB

What happens if submoduleA has no knowledge about submoduleB but super
decides to track it? Then on one point submoduleA decides to put files
into the directory named 'submoduleB'. What happens?

Just a few questions that immediately pop into my mind.

Cheers Heiko
