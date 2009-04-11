From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Sat, 11 Apr 2009 21:06:36 +0200
Message-ID: <20090411190636.GA31461@pengutronix.de>
References: <20090407133329.57b06727.weiny2@llnl.gov> <20090408080824.GF8940@machine.or.cz> <20090408083955.GA28482@pengutronix.de> <20090408091949.8a648d83.weiny2@llnl.gov> <20090409124337.GA6034@pengutronix.de> <20090409091021.5a7ded79.weiny2@llnl.gov> <36ca99e90904091101l6dd1685y5be70dd77bf52b57@mail.gmail.com> <20090409201515.GA4218@pengutronix.de> <36ca99e90904110840g35fa3b37m45f0286cb1f99db6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ira Weiny <weiny2@llnl.gov>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsiYv-0000or-Sx
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758897AbZDKTGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757875AbZDKTGm
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:06:42 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43661 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758579AbZDKTGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:06:41 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LsiXG-0000Oq-2G; Sat, 11 Apr 2009 21:06:38 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LsiXE-0008Bu-9R; Sat, 11 Apr 2009 21:06:36 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90904110840g35fa3b37m45f0286cb1f99db6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116309>

Hello Bert,

On Sat, Apr 11, 2009 at 05:40:04PM +0200, Bert Wesarg wrote:
> 2009/4/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Hello,
> >
> > On Thu, Apr 09, 2009 at 08:01:04PM +0200, Bert Wesarg wrote:
> >> 2009/4/9 Ira Weiny <weiny2@llnl.gov>:
> >> > On Thu, 9 Apr 2009 14:43:37 +0200
> >> > Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> >> >> You might want to check
> >> >>
> >> >> =A0 =A0 =A0 http:// thread.gmane.org/gmane.comp.version-control=
=2Egit/114581
> >> >
> >> > Ah this brings up more issues I had not thought about... =A0:-( =
=A0But perhaps
> >> > Bert's work could be used to help implement "rm". =A0Thoughts?
> >> No, it wont help. Because the base and tip of the topic should not
> >> changed in respect to the old state (expect for .topdeps of course=
).
> >>
> >> If you really want to remove a dependency, you need to revert a me=
rge
> >> of this dep from the topic base. which is not possible today, or m=
aybe
> >> I have just an idea for this:
> >>
> >> =A0 'topic': the topic
> >> =A0 'base': =A0the base of the topic, i.e. a merge from all depend=
ent
> >> topics dep0, ..., depN
> >>
> >> say you want to remove dep0
> >>
> >> =A0 1) merge all deps dep1, ..,depN into 'new-base'
> >>
> >> =A0 2) merge 'new-base' into base with the merge driver 'theirs', =
that
> >> would overwrite all changes from dep0 in the 'base'
> >>
> >> =A0 3) update 'topic' to the updated 'base'
> >>
> >> Any thoughts from someone who knows more than me?
> > Some time ago I thought about a similar issue:
> >
> > I based a branch on top of the Linux tree of the ARM maintainer (in=
 the
> > following called "rmk") and decided later to base it on top of Linu=
s'
> > tree. =A0So I did ~:
> >
> > =A0 =A0 =A0 =A0git checkout refs/top-bases/$branch
> > =A0 =A0 =A0 =A0git merge -s theirs linus/master
> > =A0 =A0 =A0 =A0git checkout $branch
> > =A0 =A0 =A0 =A0sed -i s,rmk,linus, .topdeps
> > =A0 =A0 =A0 =A0git add -f .topdeps
> > =A0 =A0 =A0 =A0git commit -m $commitmsg
> > =A0 =A0 =A0 =A0tg update
> >
> > When I thought about it with pencil and paper back then, I saw a pr=
oblem
> > with that approach. =A0Now I invested some time now to verify it re=
ally
> > exists: =A0In fact I reverted the changes in the rmk/master branch.
> > Consider Linus pulls from rmk and I update my topgit branch. =A0Gue=
ss what
> > happens? =A0Linus' pull + my revert yield Linus' tree without rmk's
> > changes.
> >
> > Here is my recipe:
> >
> > =A0 =A0 =A0 =A0# prepare linus/master
> > =A0 =A0 =A0 =A0git init
> > =A0 =A0 =A0 =A0echo 'VERSION=3D2.6.28' > Makefile
> > =A0 =A0 =A0 =A0git add Makefile; git commit -m 'v2.6.28'
> > =A0 =A0 =A0 =A0git branch -m master linus/master
> >
> > =A0 =A0 =A0 =A0# prepare rmk/master
> > =A0 =A0 =A0 =A0git checkout -b rmk/master
> > =A0 =A0 =A0 =A0echo 'support for some machine' > arm.c
> > =A0 =A0 =A0 =A0git add arm.c; git commit -m 'support for some machi=
ne'
> >
> > =A0 =A0 =A0 =A0# new topgit branch
> > =A0 =A0 =A0 =A0tg create t/test
> > =A0 =A0 =A0 =A0echo change > lib.c
> > =A0 =A0 =A0 =A0git add lib.c; git commit -m 'tralala'
> >
> > =A0 =A0 =A0 =A0# Linus goes on ...
> > =A0 =A0 =A0 =A0git checkout linus/master
> > =A0 =A0 =A0 =A0echo 'VERSION=3D2.6.29-rc1' > Makefile
> > =A0 =A0 =A0 =A0git add Makefile; git commit -m 'v2.6.29-rc1'
> >
> > =A0 =A0 =A0 =A0# "rebase" test branch on linus/master
> > =A0 =A0 =A0 =A0git checkout refs/top-bases/t/test
> > =A0 =A0 =A0 =A0git symbolic-ref HEAD refs/top-bases/t/test
> > =A0 =A0 =A0 =A0git merge --no-commit linus/master
> > =A0 =A0 =A0 =A0git read-tree linus/master
> > =A0 =A0 =A0 =A0git commit
> > =A0 =A0 =A0 =A0rm arm.c
> > =A0 =A0 =A0 =A0git checkout t/test
> > =A0 =A0 =A0 =A0sed -i s/rmk/linus/ .topdeps
> > =A0 =A0 =A0 =A0git add .topdeps; git commit -m 'change dep: rmk/mas=
ter -> linus/master'
> > =A0 =A0 =A0 =A0tg update
> >
> > =A0 =A0 =A0 =A0# Linus pulls from rmk
> > =A0 =A0 =A0 =A0git checkout linus/master
> > =A0 =A0 =A0 =A0git merge rmk/master
> >
> > =A0 =A0 =A0 =A0# update test to linus+rmk
> > =A0 =A0 =A0 =A0git checkout t/test
> > =A0 =A0 =A0 =A0tg update
> >
> > =A0 =A0 =A0 =A0# inspect:
> > =A0 =A0 =A0 =A0git diff linus/master refs/top-bases/t/test
> >
> > The last command shows that refs/top-bases/t/test doesn't have arm.=
c
> > :-/
> >
> > I'm sure the dependency deletion has exactly the same problem.
I think I've a solution.  Not an implementation yet, but the right
thoughs (I hope):

tg should not merge using the full history but fake the collapsed (as i=
n
tg export --collapse) history as HEAD.

> You're probably right. I just found the old discussion about
> dependencies removal [1]:
>=20
> On zo, 2008-09-21 at 16:24 +0200, Petr Baudis wrote:
> > The problem is that you can undo the merge content, but not the his=
tory
> > information. So this revert can e.g. propagate even into branches w=
hich
> > still *should* depend on the other branch, you get into trouble whe=
n you
> > want to make your branch depend on the other one anyway, etc.
>=20
> On di, 2008-09-23 at 15:27 +0200, Petr Baudis wrote:
> > what we can't make to work is just the
> > most generic case, but e.g. if master is a *leaf* branch nothing el=
se
> > depends on and it can't get the branch through multiple paths, you =
can
> > do the dependency removal rather easily (if it can get through mult=
iple
> > paths, you can still do it but you might have to deal with big
> > conflicts).
>=20
> Maybe the leaf solution could be done.  Only directly depending
> branches from the transitive reduction should be removable.  This
> would help for the 'tip'/'current' branch usecase, for collecting
> topics.
>=20
> Bert
>=20
> [1] http://thread.gmane.org/gmane.comp.version-control.git/95458/focu=
s=3D96093
This link isn't optimal.  The highlighted message doesn't contain the
citations above :-/.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
