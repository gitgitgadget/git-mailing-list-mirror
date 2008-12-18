From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Thu, 18 Dec 2008 03:03:48 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812180236190.19665@iabervon.org>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>  <20081214145518.GA26380@mail.local.tull.net>  <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>  <20081214160645.GA21358@myhost>  <c55009e70812140848j79202b0aqc6ffbfecfff50757@mail.gmail.com>
  <alpine.LNX.1.00.0812151501570.19665@iabervon.org>  <c55009e70812171157s7932c0b3u7a8ee6557c140d56@mail.gmail.com>  <alpine.LNX.1.00.0812171500070.19665@iabervon.org> <c55009e70812171431l7eab33b2x28c5b4360118880b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-465907084-1229587428=:19665"
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Nick Andrew <nick@nick-andrew.net>, git@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Lew?= <lukasz.lew@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 09:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDDsc-0002M4-Un
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 09:05:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbYLRIDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 03:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbYLRIDu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 03:03:50 -0500
Received: from iabervon.org ([66.92.72.58]:46371 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817AbYLRIDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 03:03:49 -0500
Received: (qmail 17009 invoked by uid 1000); 18 Dec 2008 08:03:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Dec 2008 08:03:48 -0000
In-Reply-To: <c55009e70812171431l7eab33b2x28c5b4360118880b@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103443>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-465907084-1229587428=:19665
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

On Wed, 17 Dec 2008, £ukasz Lew wrote:

> >> > Often, resolve easy conflicts where my mixed-work branch introduced bugs
> >> > that I fixed later and have now adopted the fixed code
> >> >
> >> > Then I repeat until I don't have any more good changes in mixed-work
> >> > (either I have nothing, only debugging cruft, or only stuff I haven't
> >> > gotten to work yet). If there's nothing but cruft, I've fully merged the
> >> > topic, and I delete the branch.
> >> >
> >> > Eventually, I'm satisfied with what I've cleaned up, and I do:
> >> > $ git push origin submit:master
> >> >
> >> > Also, I generally have a bunch of "mixed-work" branches, each containing
> >> > different stuff that isn't ready. I'll periodicly go through all of them
> >> > and rebase onto "submit" or "origin/master" (or, sometimes, give up on
> >> > them and delete them).
> >> >
> >> > (One thing that would be nice to have is a "git apply --interactive" which
> >> > applies the user's choice of hunks, like "git add -i" adds them)
> >>
> >> I totally agree.
> >>
> >> I would appriciate rebase --copy option, which doesn't move, but copy
> >> the changelists like cherry-pick.
> >
> > There's work in progress on a generalization of "rebase -i" that could be
> > seeded with the "cherry-pick" operations instead of the "rebase"
> > operations. I think that's what you'd like.
> 
> I always wanted to have system that would allow me manipulation of
> patches as features.
> I.e: I have one patch for feature X, one for Y, one for debugging X,
> one for debugging Y, etc.
> Then I would just pick some of them, work with them to create new ones.
> 
> The basic operations would be use/unuse patch, combine sequence of
> patches into one (with commit messages of subpatches saved somewhere),
> uncombine patch into sequence of patches.
> Easy way of spliting atomic patch (diff) into several more so I can
> add more commit messages.
> 
> Now this would resemble directory structure, I could copy/move/remove
> patches from/to various bigger packs of patches. Merging would detect
> duplicates of course.
> 
> Git took me for the first time close to this ideal.

Git works from the point of view of a developer producing the ideal 
development history that doesn;t (necessarily) include false starts, bugs 
fixed in private, and changes mixed together. Or rather, git allows a 
developer to make commits again knowing the full outcome of the series.

It also works from the point of view of a maintainer who merges or does 
not merge the output of developers working in this mode.

It doesn't really quite handle the work of an integrator whose work is to 
manage a patch queue. I think it needs some additional tools which allow 
the user do work which consists of operations like "replace this 
patch/branch with a new version", "suppress this patch/branch", "reorder 
these patches/branches", and the main thing: "produce a version of my 
current series with conflict resolutions"

This would actually be really helpful to have explicitly represented, so 
that people could actually bisect the -mm series to find the operation 
that Andrew did that caused a problem to enter the series, which would be 
something like adding a patch that doesn't work with other patches in the 
series. Note that this is different from bisecting within the failing 
state of the -mm tree, which finds where the series seen as a difference 
from mainline, fails; if you know that -mm yesterday works and -mm today 
fails, the difference might be that a branch merged early in the series 
was updated to a version incompatible with a branch later in the series 
that hasn't changed, and you'd want to finger the update rather than the 
point in the series where kernels start failing.

> > On the other hand, remember
> > that you can just make a new branch based on your endpoint and rebase it
> > on your upstream; there's no reason that you can't "unzip" the history
> > past the point where the branch you're modifying was created.
> 
> I never thought about that. It works indeed.

There's a lot you can do when branches are as cheap and flexible as git's 
branches are.

> >> Then we could use rebase -i (with edit) instead of apply.
> >>
> >> PS
> >> Why after edit in rebase -i the change is already commited? I always
> >> have to reset;add -i
> >
> > There's (currently) no equivalent of the index (storing the contents of
> > the commit in progress) for the message (and author info, etc). On the
> > other hand, you can use "git commit --amend" to alter the commit on top
> > (including the files), and you can do "git diff HEAD HEAD^ | git apply" to
> > get reverts into your worktree that you can add (or not add).
> 
> Good idea, thanks.
> BTW is it diff | apply the same as revert --no-commit?

Largely, although you can give the diff/apply pair paths you want to 
revert, and not revert the whole thing. And the second commit can be 
anything with the diff/apply pair, not just HEAD^, which is what revert 
does, so it's a worthwhile generalization to understand.

	-Daniel
*This .sig left intentionally blank*
--1547844168-465907084-1229587428=:19665--
