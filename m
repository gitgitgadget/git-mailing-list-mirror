From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 20:04:25 -0700
Message-ID: <4F9F52B9.9060508@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>        <4F9F28F5.2020403@palm.com> <201205010137.q411bxaU002449@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue May 01 05:04:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP3OC-0003Te-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 05:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371Ab2EADE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 23:04:28 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:50522 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939Ab2EADE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 23:04:27 -0400
X-IronPort-AV: E=Sophos;i="4.75,508,1330934400"; 
   d="scan'208";a="13230562"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 30 Apr 2012 20:04:27 -0700
Received: from fuji.noir.com ([10.100.2.13])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q4134P8o020088;
	Mon, 30 Apr 2012 20:04:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <201205010137.q411bxaU002449@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196650>

On 4/30/12 18:37 , Seth Robertson wrote:
> For example, in the diagram http://mercurial.selenic.com/wiki/Head
> rev2 might be your version of master and rev3 might be my version.
> Both might exist in my repository and both might exist in your
> repository, and both might have the symbolic name "master" associated
> with it, and git would keep it entirely straight.

But not in the same repository. And therein lies the issue.

>      >     What git *does* forbid
>      >  (by default) is:
>      >
>      >  1: Letting you update someone else's checked out (non-bare) repository
>      >  underneath them
>      Yeah.  That "underneath them" thing is confusing.  I don't see any
>      reason why that should necessarily be so.
>
>      Git knows what commit is checked out.  That's HEAD, yes?  So what's
>      wrong with letting it collect other commits from other repositories
>      while your working directory sits?
>
> It does!  It can!

To the branch you have checked out?  That's what I want!  How do I do that?

> What is forbidden is for me update what you have
> checked out.

There's some ambiguity in your sentence here.  I don't know whether 
you're referring to my being forbidden from modifying your working 
directory or whether you're referring my being forbidden to modify the 
branch from which your working directory is checked out.  I understand 
and respect the former, but the latter seems arbitrary.

(I think clearcase already answered the dynamic update problem.  I liked 
it.  And I especially liked clearmake and build avoidance.  Shame that 
IBM killed it.  (Oh, and if you had inconsistent builds, then you 
weren't using clearmake.  Clearmake solved that problem.))

I'm less concerned about whether my push changes your working directory. 
  I'm fine with leaving your working directory as is and letting you 
decide when and how to move forward on your own time.

Perhaps part of the problem here is the unfortunate choice of the word 
"HEAD" to refer to the thing you have checked out when that commit might 
not be a childless commit at all.  When I say "create another head" I 
mean, "create a childless commit on the same branch".

>      You can always commit your change right on top of what's checked
>      out, creating a second head for that branch.
>
> With git, you must always commit your change right on top of what's
> checked out, though of course you may decide to change what's checked
> out and "float" the changes you made over to the new head (trivial, as
> long as there are not conflicts between the two heads and the changes
> you made).  However, only the user of the repository is allowed to do
> this.  A remote user is not allowed to change what's checked out.

Ok, how do I ask git to push a commit into the middle of a branch that 
you have checked out at a tip, (there's always exactly one tip for any 
branch in git, right?)?  I don't care to change your working directory 
nor your index.  I just want my commits to show up in the middle of that 
branch.

>      Yes, I've read that git-diff, etc, are all making assumptions that fail
>      in this case, but there's nothing significantly different about
>      collecting commits to other branches and collecting commits to the
>      branch you're currently checked out from.
>
> Yes there is.  Consider this use case.  You can I both spot DIFFERENT
> bugs.  You and I both start editing filea.  I fix my problem one way
> which involves lines 10, 100, and 500, you fix your problem which
> involves line 10, 100, and 200.  I'm typing faster than you so I
> commit/push first.  If I can update your HEAD, at that point I've
> changed the file you are editing. You save and my change is lost.

"HEAD", being defined as the thing I have checked out, should not be 
changed, I agree.

But the nomenclature here is a bit misleading.  Really, "HEAD" could be 
any commit.  It doesn't have to be a childless commit.  The fact that my 
HEAD was childless at the time I checked it out doesn't necessarily mean 
that it must remain childless forever.

Let's back it up a moment.  I change file1 and you change file2.  These 
are non-colliding changes.  They can be trivially merged and yet git 
refuses to push between our repositories.

The refusal seems arbitrary.  It could just as easily accept my change, 
leave your HEAD pointing where it was, but move the "master" pointer to 
point to the merged commit.  This is exactly what it does if I pull your 
changes into my repository.  I just can't ever push them again after 
this happens.  (I could push them previously.)

> Now this is where you say, if git only supported multiple HEADs the
> problem would go away.

Right.

> I could update my version of master and you
> could update your version of master and there would be no conflict.

There'd be a conflict.  But we'd be able to update anyway.  I'd be able 
to see your changes in my repository by default.  You'd be able to see 
mine.  And either one of us could merge, commit, and push the merge. 
Until then, the collision could be carried and propagated by multiple 
repositories around our repository network.  Maybe a third person would 
integrate them for us.

> And...of course you can with git.  I don't update your master, what
> you have checked out, I update what you know is my master.  Then when
> you are done, you get to say "merge my master with your master" or
> "instead of committing this change on my branch, let me try this last
> change I made on top of the changes you made" or whatever you want to
> say.

Yes.  And I have no choice.  I must say that at every repository I own, 
every time I push or pull changes, tracking whether those have been 
merged or not, even when 99% of my changes could have been trivially 
merged, owned by me, in repositories I own.  And I'm forced to do manual 
merges and extra pulls in the most common collision situation I run 
into, which can be handled automatically by other systems like 
mercurial, even subversion.

My problem is that I must necessarily manage 10's of repositories for my 
own work.  These extra steps mean a geometric increase in complexity and 
in error potential over something like mercurial, which maintains the 
"common branch" illusion automatically for me or something like 
subversion which genuinely has a common branch.

I don't need separate branches for each repository.  What I really want 
is a common branch whose changes I can push back and forth between the 
various repositories, or coordinate through a central cache, without 
worrying about the underlying details that git is forcing me to confront.

I think I'm beginning to understand what git does offer now.  Thank you 
for the help with clarifications.  I just don't like it.  It's a huge 
let down for me in my context from working with systems like mercurial 
which make my life easier.  Quite frankly, git is a huge amount of work 
for me by comparison to mercurial for no added benefit, or even by 
comparison to subversion, with only minor benefits in most situations 
over subversion.

> So...what's not possible?

In effect, any interesting activities involving push or any workflows 
that require pushing.  Most of them can probably be worked around by 
using a pull architecture instead, but that adds an unnecessary 
explosion of complexity in many cases such as the one I'm facing.

In particular, sharing a branch becomes problematic with git.

--rich
