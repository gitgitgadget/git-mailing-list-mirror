From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Wed, 17 Dec 2008 15:27:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812171500070.19665@iabervon.org>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>  <20081214145518.GA26380@mail.local.tull.net>  <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>  <20081214160645.GA21358@myhost>  <c55009e70812140848j79202b0aqc6ffbfecfff50757@mail.gmail.com>
  <alpine.LNX.1.00.0812151501570.19665@iabervon.org> <c55009e70812171157s7932c0b3u7a8ee6557c140d56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-2112111901-1229545624=:19665"
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Nick Andrew <nick@nick-andrew.net>, git@vger.kernel.org
To: =?ISO-8859-2?Q?=A3ukasz_Lew?= <lukasz.lew@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD30V-0005dp-AJ
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbYLQU1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbYLQU1I
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:27:08 -0500
Received: from iabervon.org ([66.92.72.58]:58978 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbYLQU1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:27:06 -0500
Received: (qmail 8637 invoked by uid 1000); 17 Dec 2008 20:27:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Dec 2008 20:27:04 -0000
In-Reply-To: <c55009e70812171157s7932c0b3u7a8ee6557c140d56@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103382>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-2112111901-1229545624=:19665
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

On Wed, 17 Dec 2008, £ukasz Lew wrote:

> Well, I am still a beginner in git. I just switched from mercurial.
> Some inline follows:
> 
> 2008/12/15 Daniel Barkalow <barkalow@iabervon.org>:
> > On Sun, 14 Dec 2008, £ukasz Lew wrote:
> >
> >> Hi Alexander,
> >>
> >> On Sun, Dec 14, 2008 at 17:06, Alexander Potashev <aspotashev@gmail.com> wrote:
> >> > Hello, £ukasz!
> >> >
> >> > On 16:38 Sun 14 Dec     , £ukasz Lew wrote:
> >> >> Thanks Nick, thats really helpful (and surprisingly simple).
> >> >> I have a couple more questions:
> >> >>
> >> >> On Sun, Dec 14, 2008 at 15:55, Nick Andrew <nick@nick-andrew.net> wrote:
> >> >> > On Sun, Dec 14, 2008 at 02:49:50PM +0100, £ukasz Lew wrote:
> >> >> >> I don't know how to make such a scenario work:
> >> >> >> - two repositories: pub, priv
> >> >> >> - priv is clone/branch of pub
> >> >> >> - there is some constant developement both in pub and priv
> >> >> >> - there are regular syncs with pub in priv
> >> >> >>
> >> >> >> Problem:
> >> >> >> Occasionally I want to push some changes from priv to pub.
> >> >> >> Then after syncing with pub I want to get as few conflicts as possible.
> >> >> >>
> >> >> >> Is it possible to do with git?
> >> >> >
> >> >> > Git can do almost anything. One should instead ask "How to do this
> >> >> > with git?" :-)
> >> >>
> >> >> So I've heard, but not yet experienced it myself. I'm thrilled to try.
> >> >>
> >> >> >
> >> >> > If I understand your problem, you could solve it with git cherry-pick
> >> >> > and rebase. On priv, make a for-public branch from a pub branch. Then
> >> >> > cherry-pick the commits you want from your private branch into the
> >> >> > for-public branch.
> >> >>
> >> >> That almost works. Can I somehow split existing commits just like in git-add -p?
> >> > It's, however, better to make more commits to not experience the need of
> >> > commit splitting.
> >>
> >> Indeed good advice and best practice, but another best practice is to
> >> not commit not compiling state.
> >
> > In your private branches, it's actually good practice to commit all sorts
> > of junk. That way, when you mess up badly while trying to get it to
> > compile, you won't have lost your work. Of course, that means your commits
> > are going to need more cleanup before going public.
> 
> I started to follow your advise.
> Then I rebase -i.
> I found out I need more precise commit messages. :)

One useful strategy is to have a second shell and do "git show <hash>" to 
figure out what you did in that misc commit.

> >> My common scenario is that I code a big change in priv repository, and
> >> after that I find that some of its parts can and should be moved to
> >> pub.
> >
> > I usually end up with my private branch containing the public branch, plus
> > a bunch of commits that introduce: bugs, later fixed; mixed improvements;
> > and debugging cruft. I want to generate nice commits that are individual
> > improvements. I generally do:
> > $ git checkout -b submit origin/master (the first time, to set it up)
> >
> > $ git checkout submit
> > $ git diff submit mixed-work
> > look at it for good changes, find some in file1 and file2
> > $ git diff submit mixed-work -- file1 file2 | git apply
> 
> But with this command we do not preserve objects identity.
> I.e: when you merge with mixed-work you have duplicate changes.
> Is it ok?

Git is very good about recognizing duplicate changes in 3-way situations. 
That is, merging two branches, each of which makes the same change (on a 
hunk level) to a common ancestor. It'll identify this as "the branches 
agree on a change" rather than "the branches conflict". Also, "rebase" 
will try the 3-way merge mechanism, so it will be able to sort this out.

The interesting case is when both branches have the same logical change, 
but one of them is done better than the other. When you merge these, 
you'll have to select the better one by hand in a conflict resolution.

> > Sometimes, clean up bits that aren't ideal
> > $ git add -i
> > Add the good parts
> > $ git checkout . (revert the working tree to the index)
> > $ make test (did I extract the change correctly?)
> > $ git commit
> > Write a good message, sign off, etc
> > $ git checkout mixed-work
> > $ git rebase -i submit
> 
> ... Ah I see, we throw away old commits anyway with rebasing.

Yup. The old commits are there to save us when we make good changes and 
undo them before getting to a finished state. Once we reach a finished 
state, we intend to throw them away.

> > Often, resolve easy conflicts where my mixed-work branch introduced bugs
> > that I fixed later and have now adopted the fixed code
> >
> > Then I repeat until I don't have any more good changes in mixed-work
> > (either I have nothing, only debugging cruft, or only stuff I haven't
> > gotten to work yet). If there's nothing but cruft, I've fully merged the
> > topic, and I delete the branch.
> >
> > Eventually, I'm satisfied with what I've cleaned up, and I do:
> > $ git push origin submit:master
> >
> > Also, I generally have a bunch of "mixed-work" branches, each containing
> > different stuff that isn't ready. I'll periodicly go through all of them
> > and rebase onto "submit" or "origin/master" (or, sometimes, give up on
> > them and delete them).
> >
> > (One thing that would be nice to have is a "git apply --interactive" which
> > applies the user's choice of hunks, like "git add -i" adds them)
> 
> I totally agree.
> 
> I would appriciate rebase --copy option, which doesn't move, but copy
> the changelists like cherry-pick.

There's work in progress on a generalization of "rebase -i" that could be 
seeded with the "cherry-pick" operations instead of the "rebase" 
operations. I think that's what you'd like. On the other hand, remember 
that you can just make a new branch based on your endpoint and rebase it 
on your upstream; there's no reason that you can't "unzip" the history 
past the point where the branch you're modifying was created.

> Then we could use rebase -i (with edit) instead of apply.
> 
> PS
> Why after edit in rebase -i the change is already commited? I always
> have to reset;add -i

There's (currently) no equivalent of the index (storing the contents of 
the commit in progress) for the message (and author info, etc). On the 
other hand, you can use "git commit --amend" to alter the commit on top 
(including the files), and you can do "git diff HEAD HEAD^ | git apply" to 
get reverts into your worktree that you can add (or not add).

The common case for edit, I think, is that things are mostly correct, but 
there's a wrong change; with the change already committed, it's easy to 
change it to what it should be and "git commit -a --amend".

	-Daniel
*This .sig left intentionally blank*
--1547844168-2112111901-1229545624=:19665--
