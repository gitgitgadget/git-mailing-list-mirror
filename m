From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Need some help with git rebase
Date: Thu, 31 Dec 2009 10:32:00 +0100
Message-ID: <20091231093200.GB24460@m62s10.vlinux.de>
References: <4B38B3A7.6010900@steek.com> <1262211866.7068.1.camel@kheops> <CB5B49CA-0C66-4384-9B47-3675E517E203@wincent.com> <7fce93be0912310102x53755120o31e42c4a7a92a709@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Thu Dec 31 10:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQHOY-0004Al-Go
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 10:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZLaJcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2009 04:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZLaJcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 04:32:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:39557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751443AbZLaJcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 04:32:08 -0500
Received: (qmail invoked by alias); 31 Dec 2009 09:32:03 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp059) with SMTP; 31 Dec 2009 10:32:03 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX191Kc8Wzv51NQq7L8VUscieUV+MJeLM/DAPkGUYzw
	avsYmAFFfElETc
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 0457EEC001; Thu, 31 Dec 2009 10:32:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7fce93be0912310102x53755120o31e42c4a7a92a709@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135939>

On Thu, Dec 31, 2009 at 10:02:12AM +0100, Sylvain Rabot wrote:
> On Wed, Dec 30, 2009 at 23:46, Wincent Colaiuta=A0<win@wincent.com>=A0=
wrote:
> >
> > Look at the "git-rebase" man page, particularly the order of the ar=
guments, what they mean, and the usage examples of "--onto":
> >
> > =A0$ git rebase --onto 12.72.1 master feature
> >
> > Means, "replay these changes on top of 12.72.1", where "these chang=
es" refers to commits on branch "feature" with upstream "master", which=
 is what "git rebase" did for you.
> >
> > If you actually want the "feature" branch to continue pointing at t=
he old feature branch rather than your newly rebased one, you could jus=
t look up the old SHA1 for it and update it with:
> >
> > =A0$ git branch -f feature abcd1234
> >
> > Where "abcd1234" is the hash of the old "feature" HEAD.
> >
> > But I don't really know why you'd want to do that. The purpose of "=
git rebase" isn't to copy or cherry-pick commits from one branch onto a=
nother, but to actually _move_ (or transplant, or replay, if you prefer=
) those commits.
> >
> > Maybe I misunderstood your intentions though.
> >
> > Cheers,
> > Wincent
> >
>=20
> In fact I want to backport the commits of the feature branch into=A01=
2.72.1.
> I used git rebase because the drawings of the man page looked like
> that I wanted to do and it does except for the part it resets the hea=
d
> of my feature branch.
>=20
> But the good behavior would be to cherry pick each commit of the
> feature branch and apply them into 12.72.1, right ?
>=20

$ git checkout -b rebased_feature feature
$ git rebase --onto 12.72.1 master rebased_feature

will create a temporary branch named "rebased_feature" pointing to the =
same
commit as the branch "feature". In fact, this will rebase the commits o=
n the
feature branch not reachable from master onto your 12.72.1 branch *and*=
 won't
reset the feature branch. Instead the temporary branch named "rebased_f=
eature"
will be rebased ontop of 12.72.1.

I would still prefere the rebase over doing multiple cherry picks.

-Peter
