From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 2 Nov 2007 08:21:26 +0100
Message-ID: <63FCD695-B952-4624-854C-0F1C662D94D1@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.d
 e> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <! 47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <7vfxzpbtxv.fsf@gitste!
 r.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 08:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inqpv-0004Mj-1q
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 08:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbXKBHUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 03:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbXKBHUn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 03:20:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:44187 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbXKBHUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 03:20:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA27K5qA003246;
	Fri, 2 Nov 2007 08:20:06 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a828.pool.einsundeins.de [77.177.168.40])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA27K4fm005665
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 Nov 2007 08:20:04 +0100 (MET)
In-Reply-To: <7vfxzpbtxv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63066>


On Nov 1, 2007, at 9:18 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> On Nov 1, 2007, at 10:11 AM, Andreas Ericsson wrote:
>>
>>> Steffen Prohaska wrote:
>>>
>>>> You're forced to do the integration immediately.
>
> The context of this "forced" is that you say (in the following
> paragraph) the user's main objective was to "push", but I do not
> think "to push" is ever the main objective.

Right. I should probably describe a bit more of the context.

We have a shared branch for a group of developer who are located
in the same building. We are allowed to commit reasonably stable
code to this branch. Changes should compile and the commiter
should be convinced that it does something useful without
breaking other code. But failing to meet these requirements
is acceptable. For example it is sufficient to compile on
only one architecture and have good reason to believe that
the other architectures will work, too.

A nightly job builds the shared branch on all of our
architectures and creates a report that is available the next
day. If problems happen you should fix them asap. If someone
spots problems causes by others that need to be addressed
right away, he can walk over to the office of the one who
caused the problem.

In this setting a user really want to push. Because only then
the code will be tested and available for all others. ...



>  - If it is to give integrated result for others to work further
>    on, then you need to resolve before being able to achieve
>    that goal.  There is no escaping from it.
>
>  - On the other hand, if it is to show what you did as early as
>    possible in a working shape, and if the updated shared
>    repository has changes from somebody else that conflicts you,
>    in a CVS/SVN style shared workflow, there is no way for you
>    to show what you did in isolation.  If you try to follow that
>    model in git and insist pushing to the same branch, then you
>    are forced to resolve first.
>
>    But you do not have to.  You could push out to another new
>    branch, and say "Here is how you could do it, although this
>    is based on an older codebase and conflicts with what
>    recently happened to the tip".  You could even ask other
>    party whose changes conflict with yours to help with the
>    merge by saying "I pushed it out, you are more familiar with
>    that area of the code and with your changes near the tip of
>    the trunk, so could you merge it and push out the result?"


... I know we could use git to establish a more complex workflow
that would give better guarantees on the published branches.

But it's a judgement how much complexity you want to
add. Pushing to a different branch instead of solving
conflicts right away may be a good model to postpone conflict
resolution. But it requires more knowledge of git and more
commands. Right now, the users are trained on a CVS workflow
and they expect that conflicts may occur and if so need to
be addressed right away. The next step is probably to learn
how git could help them to do this.  (index vs. work tree,
mergetool, ...)

Btw, I have another 'stable' branch, which I have full control
over. This branch is built and tested prior to pushing to the
public repository. So, if the shared branch completely breaks
down, we can fall-back to the stable branch.

We haven't figured out much more of our workflow. The first
milestone is to migrate from CVS to git continuing to use a
CVS-style workflow.



>>> Yes, but you get to choose how. Perhaps git-push should list more
>>> options than just git-pull, such as the three commands required to
>>> rebase the currently checked out branch onto its remote counterpart.
>>> That would support more workflows.
>>
>> I agree. Providing better hints would be good.
>
> I am not so sure about that.  If there are three different
> workflows, should git-push give hints suitable for all of them?
>
> The current hint was added in response to users' requests, and I
> think it could be generalized.  What we would want the end user
> to realize is:
>
>     What I tried to push out is stale, I do not want to push out
>     something that does not contain what the other side has
>     done, so I need to integrate my work with what the other
>     side have before pushing to that branch at the remote.
>
>     In my workflow, that means doing rebase of the branch I
>     tried to push out on top of the remote branch I was trying
>     to push to.
>
> The second paragraph depends on the workflow.  Do we want to
> (can we afford the space to) give a laundry list here?  Probably
> not.

I agree.

But how many different ways of integrating do we have? I only know
of merge or rebase. So, we may just mention both.

Or we only print an extended message if '--verbose' is given. The
short message could be even shorter and refer to '--verbose':

error: remote 'refs/heads/master' is ahead of local 'refs/heads/ 
master'. Use --verbose for more details.

If the user passes --verbose he gets the full story:

- A more detailed description of 'ahead'. For example,
   local could be a strict subset of remote, or local could have
   new commits that are not already at remote.

- We could give all sorts of hints, for example how to list the
   commits that are new on the local side. Recommendations how to
   solve the issue (merge, rebase). The message shouldn't get
   too verbose, though.



>>>> Your main objective was to push, but the shared workflow forces
>>>> you to do the integration _now_ (by using pull). In a pull-only
>>>> workflow, you can just push and defer the integration for later.
>>>
>>> No, you can also fetch + rebase.
>>
>> Right. My point was than one cannot defer the integration. It
>> must be addressed immediately.
>
> See above.

See above.


>>>> Some people claim fetch + rebase is superior to fetch + merge.
>>>> The only point I can see is that fetch + rebase gives a linear
>>>> history without loops, which is nicer to visualize. I recently
>>>> asked on the list if there are any benefits of fetch + rebase
>>>> over fetch + merge, besides a nicer visualization.
>>>
>>>
>>> It's easier to bisect...
>>> With a mostly linear history, this problem goes away.
>>
>> This is really an interesting point. I did not start to use
>> git bisect regularly. But I certainly plan to do so in the future.
>>
>> Couldn't bisect learn to better cope with non-linear history?
>
> It copes with it as best as it can.

I should try out git bisect to understand the details.


> Another thing to think about is how "everybody fetches, merges
> and pushes out" would interact with the concept of "mainline".
> Strictly speaking, the point of distributed development is that
> there is no mainline, but workflows based on "fetch + rebase"
> allows --first-parent to give a reasonable approximation of what
> people would naively expect how the mainline would look like.
> If everybody fetches, merges and pushes out, there is no
> "mainline" and --first-parent would give totally useless
> history.

Building a main line needs more control and more knowledge
about git.

Here is what I think can be done. It's only a sketch so
far. It's not yet reality. Therefore it might turn out to be
infeasible. I'd adjust my plans then.

We actually have at least three groups of developers that work
at three different locations. They'll work on different shared
branches. We also will create shared topic branches if a smaller
group of developers needs to work together on a prototype.

At some point shared branches need to become stable. They
need to be tested and maybe some of the changes need to be
reverted if they turn out to be useless. Finally we'll have a
tip of a shared branch that is stable. Stable depends on the
quality criteria, which may vary depending on where we are
in the release cycle. But at least some minimal requirements,
like "compiles on all platforms" or "passes all tests" will be
verified. Such a stable tip will now be merged with '--no-ff'
to the mainline. The merge will be thoroughly tested.

The chain of commits along first parent establishes a mainline
that matches certain quality criteria. The criteria are not
necessarily met by commits on the side branches. Therefore
fast-forward must not be used for the merge.

If we feel comfortable with git, we may consider creating
better topic branches in the first place. But for now I want
to start with shared branches containing a mixed bag of
commits.

Do all this make sense?

	Steffen
