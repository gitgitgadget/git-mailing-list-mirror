From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 15:27:52 +0200
Message-ID: <20080511132752.GA22778@atjola.homenet>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826E791.7030407@gmail.com> <20080511125722.GA22075@atjola.homenet> <4826EEDF.4010404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 15:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvBbk-000315-Ak
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 15:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbYEKN14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbYEKN14
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 09:27:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:37036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752952AbYEKN1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 09:27:55 -0400
Received: (qmail invoked by alias); 11 May 2008 13:27:54 -0000
Received: from i577B82CA.versanet.de (EHLO atjola.local) [87.123.130.202]
  by mail.gmx.net (mp008) with SMTP; 11 May 2008 15:27:54 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/zIV9qgQPzlQFEKg3v6c8ZF7NUuTo7qjlUdaY+J6
	luoX5EKRq2OPbl
Content-Disposition: inline
In-Reply-To: <4826EEDF.4010404@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81772>

On 2008.05.11 16:04:31 +0300, Dima Kagan wrote:
> Bj=F6rn Steinbrink wrote:
> > On 2008.05.11 15:33:21 +0300, Dima Kagan wrote:
> >>>> Basically I see that the same file I edited on the 'test_branch'
> >>>> branch appears to be modified on the 'master' branch as well. Th=
is
> >>>> behavior is unwanted, of course.
> >>>>
> >>>> Can someone please tell me, what am doing wrong? Or is this git'=
s
> >>>> normal behavior?
> >> I just realized that this behavior is even more confusing.  If I
> >> commit the file on 'test_branch' and only then 'git checkout maste=
r'
> >> the changes are not visible on 'master' until I merge. So why shou=
ld
> >> 'master' be affected by uncommitted changes on some branch???
> >=20
> > Uncommitted changes are not on any branch, they are in your working=
 tree
> >
[example removed]
> >=20
> >=20
> > The uncommitted changes survived the branch change and are still in=
 the
> > working tree, in svn just like in git.
>=20
> Yes, I am aware of that, except one rarely works in one directory on
> multiple svn branches, because the branches are not private.

I always did that, the working copy _is_ private even in svn, so messin=
g
with that was not a problem there either.

> Git's branches can be private, so perhaps this behavior should be
> different from SVN?

No. Uncommitted changes are, well, uncommitted. They don't belong to an=
y
branch yet. A branch is not some structure that contains history in
itself. A branch just points to a commit, and the commits, with their
parent-child relations, form the actual history. The index and working
tree are not part of a branch.

Changing that would even break a workflow that is rather common for me.
I start working on something that is either just experimental or assume=
d
to be a very small change. Then I realize that the change is worth
keeping and/or too big and deserves its own branch. At that point, I ca=
n
just do "git checkout -b new_branch", and pretend that I started workin=
g
on that branch right from the start. With your proposed change, I would
need some extra command to transfer the work in progress from the old
branch to the new branch.

If I ever want to switch to another branch and not keep the changes in
my working tree and index, I stash them away or create a temporary
commit, which I later amend. That's a use-case that comes up rather
seldom though (for me at least).

> BTW, Is there a way to do 'svn checkout -b new_branch' into a new dir=
ectory?

There's a script (new-working-tree or so) in contrib/ that can create a
second working tree for a given repo, but I usually prefer to just clon=
e
my repo locally. In the second repo, I can then switch branches as much
as I like ;-)

Bj=F6rn
