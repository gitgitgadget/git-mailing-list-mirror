From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request - discard hunk in add --patch mode
Date: Wed, 15 Aug 2012 14:51:57 -0700
Message-ID: <7vfw7n4yde.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl>
 <87txw41okl.fsf@thomas.inf.ethz.ch> <7vvcgk58le.fsf@alter.siamese.dyndns.org>
 <7vmx1w56z1.fsf@alter.siamese.dyndns.org>
 <BLU0-SMTP112EF6B9308C55734C4F10293B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Mina Almasry <almasry.mina@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:52:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1lVc-0005b2-Uq
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 23:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2HOVwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 17:52:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab2HOVwD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 17:52:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8811698B1;
	Wed, 15 Aug 2012 17:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GjSvoOio3FGYuPhjKYl+UHQQl8c=; b=m6FpXo
	i+p94oZDcY19OLht/SzDmQvEC6pjyFjAN4zN6WIMabZ7LNkdSUTynsAAgUYv1N4i
	H+xg0M8ZAG+9OB6HVZpPhbzQT1DcAfcOzzLoomom/Ix1UyMMGFer/NnraUMnB6wV
	gVoFtQ/wp8Py/GbJ+4FaGCEMgH6sG0uroUpIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Id1lLcBc+1dNGvr5Tm3ekmTgIedShyHZ
	23d1uHizL8B0Buz/smwTn4tvL3lUaFOfkiFSmSgoGo+zoQrfPU7PjDYN39vh5Sdv
	FwWmpgDEWMRxHghQaJo4iKSNxfVfjJVbv+VMZW8htH3QQbgVTbh1vdhz/lGRO9e9
	3+YN2QXckXg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7501E98AF;
	Wed, 15 Aug 2012 17:51:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97EC798AD; Wed, 15 Aug 2012
 17:51:58 -0400 (EDT)
In-Reply-To: <BLU0-SMTP112EF6B9308C55734C4F10293B60@phx.gbl> (Mina Almasry's
 message of "Wed, 15 Aug 2012 16:58:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FF9337A-E723-11E1-AA5A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mina Almasry <almasry.mina@hotmail.com> writes:

> On 12-08-15 02:46 PM, Junio C Hamano wrote:
> ...
>> Please forget this question.  A better way in the form of "stash -p"
>> was suggested in the old thread to get rid of debug cruft in the
>> tree before an "add -p" session (or during a series of "add -p"
>> sessions).
>>
>> So is this still an issue?
>>
> I read most of the thread, and I do think it still is. Here are my 2 cents:
>
> 1. The alternative commands aren't nearly as time efficient:
>     - git checkout . is fast and awesome, but you can't use it if, for
> example, you have to maintain a dirty         working tree
>     - git (stash|reset|checkout) -p make you go through (all|most) of
> the hunks you have to hunt down             those 2 lines that say
> "echo 'This line is runningantoeuhaoeuaoae'"

You have to do that _at least once_ anyway, as there is no other way
for Git to tell which one is debugging cruft and which one is the
real change you value without you telling it.  Will return to the
topic later.

> 2. All of the safety concerns can be alleviated with the right
> interface.

There are three safety concerns I raised in the original thread.
Among them, I do not think

 (1) new user may mistake "undo" to be something safe; and
 (2) experts will continue making typo between "y" and "u"

are the primary risks of the original patch Thomas pointed out.  

A much bigger problem with the approach is (3) letting "add" touch
the working tree breaks the world model.  Both experts and newbies
alike, people have learned that "git add" will never clobber what
they have in the working tree and rely on that promise.

And your key assignment, command renaming or extra prompting do not
change this fundamental issue at all.

Let's step back a bit, and define the problem we are solving.

Suppose you have changes in your working tree that are worth
multiple commits, debugging aid, and uncommittable WIP.  You want to
create multiple commits, possibly giving each of them the final
testing before committing, and want to end up with the WIP (plus
possibly the debugging aid, as that may still help your WIP) in your
working tree.

Do we agree that the goal of the discussion of this thread is to
make that process simple, safe, efficient and easy?

Now, back when the original patch by Pierre was proposed, it indeed
was cumbersome.  You could sift things through by "add -p" to build
the first commit in the index, commit, and iterate.  In each round,
"add -p" step had to skip the same debugging aid and WIP over and
over again.  If you wanted to give the result of "git add -p" a
final test before committing, "stash save -k" would give you the
state you would be committing, but it isn't easy to reintroduce only
the debugging aid to the working tree.

Since then "stash -p" was added to our toolchest.  So theoretically,
we should be able to do something like this:

    # start from N-commit worth of change, debug and WIP
    git stash save -p debug ;# stash away only the debugging aid
    # now we have only N-commit worth of change and WIP
    git stash save -p wip ;# stash away WIP

Then after that, you need N round of "git add -p && git commit".

Now, with what we have already, can we also give final testing
before committing?  Each round may now start with:

    git add -p ;# prepare the index for the next commit
    git stash save -k ;# save away the changes for later commits

and at this point, your working tree and the index has what you are
about to commit.  If we can apply the "debugging aid" stash we
created earlier to the working tree, that would allow you to test
the state you are about to commit with your debugging aid.  The
command to do so may be

    git stash apply stash@{2}

Once you are satisfied, you can reset this change out of your
working tree with "checkout .", and then "git commit" to record what
is in the index.

And then you can "git stash pop" to bring back the remainder of
N-commit series worth of changes.  You are ready to continue to the
next round.

Once you created N-commit series, you will still have two stash
entries, one "debug" and one "wip".  You should be able to resurrect
"wip" with

    git stash pop

just fine, but there is a little problem after this step.  Because
"git stash [apply|pop]" does not want to work on a dirty working
tree, starting from this state just after popping "wip" stash, you
cannot "git stash pop" to have both WIP changes and debugging aid to
the working tree.

A topic to improve "stash [apply/pop]" to allow it may be a valid
and useful thing to do.

As an approximation, without changing any of the current tools,
however, you should be able to do this after creating N-commit
series following the above procedure.

	git stash pop ;# resurrect "wip" to the working tree.
        git add -u ;# and add that to the index temporarily
        git stash pop ;# resurrect "debug" to the working tree as well.
	git reset ;# then match the index to HEAD

That will mix the WIP and debug again in your working tree.

Why you would want to mix them together, after sifting debug and wip
using "add -p" already, is a different issue, though (there are
valid scenarios why you would want to do so, and there are valid
cases why you do not have to bother).

So is this still an issue?
