From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Thu, 01 Nov 2007 13:18:52 -0700
Message-ID: <7vfxzpbtxv.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<1193593581486-git-send-email-prohaska@zib.de>
	<11935935812185-git-send-email-prohaska@zib.de>
	<11935935822846-git-send-email-prohaska@zib.de>
	<11935935821136-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
	<B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de>
	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>
	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
	<7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
	<6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!
	47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 21:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IngVV-0005SB-3M
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbXKAUTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbXKAUS7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:18:59 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:50113 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbXKAUS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:18:58 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5ADFD2F0;
	Thu,  1 Nov 2007 16:19:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 97389911F3;
	Thu,  1 Nov 2007 16:19:15 -0400 (EDT)
In-Reply-To: <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> (Steffen Prohaska's
	message of "Thu, 1 Nov 2007 17:43:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62988>

Steffen Prohaska <prohaska@zib.de> writes:

> On Nov 1, 2007, at 10:11 AM, Andreas Ericsson wrote:
>
>> Steffen Prohaska wrote:
>>
>>> You're forced to do the integration immediately.

The context of this "forced" is that you say (in the following
paragraph) the user's main objective was to "push", but I do not
think "to push" is ever the main objective.

 - If it is to give integrated result for others to work further
   on, then you need to resolve before being able to achieve
   that goal.  There is no escaping from it.

 - On the other hand, if it is to show what you did as early as
   possible in a working shape, and if the updated shared
   repository has changes from somebody else that conflicts you,
   in a CVS/SVN style shared workflow, there is no way for you
   to show what you did in isolation.  If you try to follow that
   model in git and insist pushing to the same branch, then you
   are forced to resolve first.

   But you do not have to.  You could push out to another new
   branch, and say "Here is how you could do it, although this
   is based on an older codebase and conflicts with what
   recently happened to the tip".  You could even ask other
   party whose changes conflict with yours to help with the
   merge by saying "I pushed it out, you are more familiar with
   that area of the code and with your changes near the tip of
   the trunk, so could you merge it and push out the result?"

>> Yes, but you get to choose how. Perhaps git-push should list more
>> options than just git-pull, such as the three commands required to
>> rebase the currently checked out branch onto its remote counterpart.
>> That would support more workflows.
>
> I agree. Providing better hints would be good.

I am not so sure about that.  If there are three different
workflows, should git-push give hints suitable for all of them?

The current hint was added in response to users' requests, and I
think it could be generalized.  What we would want the end user
to realize is:

    What I tried to push out is stale, I do not want to push out
    something that does not contain what the other side has
    done, so I need to integrate my work with what the other
    side have before pushing to that branch at the remote.

    In my workflow, that means doing rebase of the branch I
    tried to push out on top of the remote branch I was trying
    to push to.

The second paragraph depends on the workflow.  Do we want to
(can we afford the space to) give a laundry list here?  Probably
not.

>>> Your main objective was to push, but the shared workflow forces
>>> you to do the integration _now_ (by using pull). In a pull-only
>>> workflow, you can just push and defer the integration for later.
>>
>> No, you can also fetch + rebase.
>
> Right. My point was than one cannot defer the integration. It
> must be addressed immediately.

See above.

>>> Some people claim fetch + rebase is superior to fetch + merge.
>>> The only point I can see is that fetch + rebase gives a linear
>>> history without loops, which is nicer to visualize. I recently
>>> asked on the list if there are any benefits of fetch + rebase
>>> over fetch + merge, besides a nicer visualization.
>>
>>
>> It's easier to bisect...
>> With a mostly linear history, this problem goes away.
>
> This is really an interesting point. I did not start to use
> git bisect regularly. But I certainly plan to do so in the future.
>
> Couldn't bisect learn to better cope with non-linear history?

It copes with it as best as it can.

Another thing to think about is how "everybody fetches, merges
and pushes out" would interact with the concept of "mainline".
Strictly speaking, the point of distributed development is that
there is no mainline, but workflows based on "fetch + rebase"
allows --first-parent to give a reasonable approximation of what
people would naively expect how the mainline would look like.
If everybody fetches, merges and pushes out, there is no
"mainline" and --first-parent would give totally useless
history.
