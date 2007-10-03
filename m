From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn merge helper
Date: Wed, 3 Oct 2007 03:02:33 +0200
Message-ID: <20071003010233.GA8610@atjola.homenet>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet> <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr> <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com> <20071002211400.GA992@atjola.homenet> <20071002220458.GA21038@dervierte> <20071002223813.GA3152@atjola.homenet> <20071003004252.GA28495@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 03:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icsd2-0000KH-Hy
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 03:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbXJCBCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 21:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbXJCBCM
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 21:02:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:54587 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752929AbXJCBCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 21:02:11 -0400
Received: (qmail invoked by alias); 03 Oct 2007 01:02:10 -0000
Received: from i577B85BB.versanet.de (EHLO localhost) [87.123.133.187]
  by mail.gmx.net (mp031) with SMTP; 03 Oct 2007 03:02:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/CArE3md7CSuavZ16pl3wwsnZfA5oEKxxhciv8xM
	djuMtJDf3uhnbS
Content-Disposition: inline
In-Reply-To: <20071003004252.GA28495@dervierte>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59766>

On 2007.10.02 20:42:52 -0400, Steven Walter wrote:
> On Wed, Oct 03, 2007 at 12:38:13AM +0200, Bj=F6rn Steinbrink wrote:
> > > The other option is to have a "build" branch.  By example:
> > >=20
> > > git checkout build
> > > git reset --hard master
> > > git merge mybranch
> > > make
> > >=20
> > > In that way, I have branch with the latest changes from head and =
the
> > > changes from mybranch together.  The downside to this method is t=
hat you
> > > may have to repeated resolve merges.  Despite the downsides, I fi=
nd
> > > these two methods to work quite well.
> >=20
> > Thanks, but it makes no difference here, it stil results in a fast
> > forward. This is a small test case which exhibits the behaviour and
> > matches my current workflow with git-svn (except for the dcommits):
> >=20
> > git init
> > echo Hi > file1; git add file1; git commit -m file1
> > git checkout -b branch
> > echo Hi > file2; git add file2; git commit -m file2
> > git checkout master
> > echo Hi > file3; git add file3; git commit -m file3
> > git checkout branch
> > git merge master
> >=20
> > # Then I'd normally do the following which causes a fast forward
> > #git checkout master
> > #git merge branch
> >=20
> > # Now I tried this, which also results in a fast-forward:
> > git checkout -b merge
> > git reset --hard master
> > git merge branch
>=20
> I believe you misunderstood my suggestion.  In using a "build" branch=
,
> you would not merge master into branch, as you did above.  Instead, y=
ou
> would create a third, unpublished branch to hold the merge.

Almost though so.

> At the same time, I have a slightly better understanding of what it i=
s
> you're trying to do.  If you are trying to keep up an SVN-like workfl=
ow
> (namely pulling changes from trunk into a branch from time to time),
> then my solution probably isn't suitable for you.  However, you might
> consider why you actually /need/ to do that, outside of SVN conventio=
n.

Due to the same reason for which the branch needs to be public at all,
there are other people who want to follow it and test it, while there
are external dependencies that currently change quite often. So I need
to get the relevant changes from trunk into my branch anyway, even with
svn conventions put aside (well, unless I force everyone else to merge
over and over again). And as sometimes others commit to that branch, to=
o
(you just have to love that), keeping a separate branch for the final
merge isn't so nice either, as I'd need to constantly cherry-pick those
changes then and probably get even more conflicts along the way.

That said, Google finally liked some of the search terms that I threw a=
t
it and revealed a thread [1] from march, where Linus was torn on whethe=
r
or not a --no-fast-forward option should be introduced. That sounds lik=
e
it would help here, any chance of getting such a thing?

Thanks,
Bj=F6rn

[1]
http://lists-archives.org/git/419374-git-merge-and-merge-message.html
