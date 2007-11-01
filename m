From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Thu, 1 Nov 2007 17:43:29 +0100
Message-ID: <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z
  ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!
 47299855.9010204@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 01 17:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IndIl-0003sT-Hk
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 17:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbXKAQxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 12:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbXKAQxh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 12:53:37 -0400
Received: from mailer.zib.de ([130.73.108.11]:48597 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414AbXKAQxg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 12:53:36 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA1Gg7RS024465;
	Thu, 1 Nov 2007 17:42:07 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA1Gg651025186
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 1 Nov 2007 17:42:07 +0100 (MET)
In-Reply-To: <47299855.9010204@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62980>


On Nov 1, 2007, at 10:11 AM, Andreas Ericsson wrote:

> Steffen Prohaska wrote:
>> On Oct 31, 2007, at 10:31 PM, Junio C Hamano wrote:
>>> Steffen Prohaska <prohaska@zib.de> writes:
>>>
>>>> Another difference is the way changes are integrated. In
>>>> a workflow without shared repositories, only pull is used
>>>> for integration, while push in only used for publishing the
>>>> changes.
>>>
>>> Wrong.  push is a mirror of fetch and does not do _any_
>>> integration.  It is just a safe (because it insists on
>>> fast-forward) propagation mechanism.  Your integration still
>>> happens with pull (actually, shared repository people seem to
>>> prefer "fetch + rebase" over "pull" which is "fetch + merge").
>> Right; but you can't push without doing the integration. If you
>> have new changes on the remote side you _must_ pull before
>> you can push.
>
> Yes, because otherwise you'd rewrite published history. That's not
> a good thing.
>
>> You're forced to do the integration immediately.
>
> Yes, but you get to choose how. Perhaps git-push should list more
> options than just git-pull, such as the three commands required to
> rebase the currently checked out branch onto its remote counterpart.
> That would support more workflows.

I agree. Providing better hints would be good.


>> Your main objective was to push, but the shared workflow forces
>> you to do the integration _now_ (by using pull). In a pull-only
>> workflow, you can just push and defer the integration for later.
>
> No, you can also fetch + rebase.

Right. My point was than one cannot defer the integration. It
must be addressed immediately.


>> Some people claim fetch + rebase is superior to fetch + merge.
>> The only point I can see is that fetch + rebase gives a linear
>> history without loops, which is nicer to visualize. I recently
>> asked on the list if there are any benefits of fetch + rebase
>> over fetch + merge, besides a nicer visualization.
>
>
> It's easier to bisect. If git bisect lands you on a merge-commit,
> you need to start a new bisect for each of the parents included
> in the merge. Hopefully the nature of the merge gives a clue so
> the user can make an educated guess as to which parent introduced
> the bogus commit, but for an "evil octopus" (unusual) or if the
> merge had conflicts which were resolved in a buggy way (not
> exactly uncommon), it can be quite a hassle to get things right.
> With a mostly linear history, this problem goes away.

This is really an interesting point. I did not start to use
git bisect regularly. But I certainly plan to do so in the future.

Couldn't bisect learn to better cope with non-linear history?

[...]


>> I am searching for a solution that just works for them. They
>> currently use CVS. I'll give them a detailed getting started
>> document for git. The workflow described should be as simple as
>> possible, but safe and reliable.
>
>
> If they're used to CVS and want to use more than one branch without
> having to learn additional syntax, nothing can help, methinks.

They will learn. But they must not get frustrated too early.
I also don't wont to see them lining up in front of my office.


BTW, what do you thing about the proposal to add branch.$name.push [1]?

[1] http://marc.info/?l=git&m=119384331712996&w=2


[...]

>> There were different suggestions what to do. A reasonable
>> suggestion was to delete the local branch after you're done.
>
> Except that it doesn't work unless you either detach the HEAD
> (which prints a big fat ugly message) or give it -D to force
> it, which I really, really don't recommend. We use git because
> I'm pretty confident in its capabilities of never ever losing
> anything. Using the seemingly harmless -D switch to git-branch
> puts us at risk of wiping history quite without noticing.

I don't like -D either. I liked the idea mentioned recently
to check -d against the remotes. If a remote tracking branch
has the history it should be considered fully merged.

Another idea may be to distinguish between detached head and
checkout of remote tracking branch. Maybe we could do some
useful things if get knew that the user is 'on a remote tracking
branch'. Committing could be forbidden. A suggestion would be
printed instead to use "git checkout -b something", which could act
as if the remote branch was mentioned on the command line.

Something like that would be needed before I'd seriously
suggest to delete local branches after you finished your work.


>> This clearly distinguishes between remote branches (which are
>> mirrored as a remote tracking branch) and local branches. Local
>> branches are _your_ branches while the remote branches contain
>> the shared work. If you're done with your local work, delete
>> your local branch. So maybe you should do
>>    git checkout origin/devel
>
> Except that this gives a warning-esque message:
> Note: moving to "origin/devel" which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>  git checkout -b <new_branch_name>
> HEAD is now at deadbeef... Ma! Pa butchered all the cows!
>
> To me, this indicates I've done something git thinks I shouldn't have.

I agree. This could probably be suppressed if git handled remote
tracking branches a bit differently from other detached heads.


>> Independently of what the best practice is, leaving the local
>> work branch there shouldn't do any harm because I'm sure that
>> some devs will forget to clean up, independently of what I tell
>> them.
>
> I wholeheartedly agree with this one.

So I think we need to resolve this first.

Do you already have post-checkout script that makes useful
suggestions.  I remember you mentioned something like that
during the 200-local-branches discussion.

	Steffen
