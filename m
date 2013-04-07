From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 07 Apr 2013 02:00:09 -0700
Message-ID: <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
 <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 11:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlSZ-0007Et-Tu
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 11:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933074Ab3DGJAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 05:00:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933070Ab3DGJAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 05:00:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9C94F8C1;
	Sun,  7 Apr 2013 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jKTpw2urif9TZNf3tJj2J7Oh5gE=; b=RYK2pU
	pi0ElLfzUpKp06/NK2AOB52Ue8pFmquHqMccui/fWrT5atUo1x/1qc0g+z7mUY67
	XeLyc9AZJzIy8R+LjaQ0IcSDJxUeQYkuTlaaHUo2XF01Ni3MUWncUIDpcizby6q3
	PGXjZ86hTBMIOHrx1IJQmXZzXThSBU8eVDhAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDdt4jiTI9qnAWSp88KgbP4KEaQJ4uqP
	agoYM45cVJ1/sNtC22yKnyLCEb6kfNwLkX+p2fo2oJO3AoxcO7H8yzjDr1UPk+le
	FJmr2YS07ZDSb9MV93IlIDB6UGALhRrBh8kK1R2cixNI866Zr7b/W1f8Bey62q2g
	M5HAZkJUi9s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E081BF8BF;
	Sun,  7 Apr 2013 09:00:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29BD9F8B8; Sun,  7 Apr 2013
 09:00:11 +0000 (UTC)
In-Reply-To: <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sun, 7 Apr 2013 12:57:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DA8A558-9F61-11E2-B9AA-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220299>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> I think it is too premature to discuss _your_ code.  The patches do
>> not even tell us anything about how much more work is needed to
>> merely make Git with your patches work properly again.  For one
>> thing, I suspect that you won't even be able to repack a repository
>> that has OBJ_LINK only with the patches you posted.
>
> ...
> You're asking me to submit a perfect 40 or 50 part series...

Not at all.  And please do not start _coding_.

When the design is not clear enough that a 7-patch series is not
ready to be reviewed, certainly 50-patch series will not be.  Not
until you can explain what you are trying to solve and convince
others why other less disruptive approaches are fundamentally
unworkable, and why we need to change the object layer.

> To reiterate: link does not make possible something that is not
> fundamentally _possible_ with a .githack and a 100k-line Perl script.
>
> At its core, every variant of submodules does this.  What I'm
> essentially proposing: break up the information in .githack into
> smaller bits and create a new object type so it can be parsed by
> git-core easily.

The .gitmodules file is designed to be easily parsable by the config
infrastructure and implemented as such already, thank-you-very-much.

Why do you keep calling an already working solution with derogatory
misspelling?  That only gives others an impression that you do not
understand how the current system works, and pursuade them not to
waste time responding to you.  Stop it.

> When the series matures, we can investigate the other implementations
> in greater detail so we can pick out more optional fields to add to
> the link object before getting it merged.

Sorry, but that is not how open source works in general, and
certainly not how this project works.

We do not add disruptive change just for the sake of changing it to
break a working system, make an extra work to clean up the fallout
for ourselves (i.e. your "40 to 50 patch series", but honestly
speaking I expect it would be more like a 4 months work for a full
time engineer or two), for unproven design (that has not yet to be
illustrated) to solve problems (that has not yet to be explained),
without knowing that

 (1) the problems are worth solving;

 (2) the design will solve the problems; and

 (3) solving the same problems without such a disruptive change is
     impossible, or so cumbersome that it will be far larger than
     the work needed to clean-up the fallout of the disruptive
     change.

So what are your X, Y, Z?  You still haven't answered that question.

For that matter, you didn't answer the same question that was more
tersely phrased by Linus in the very first response in the thread:

> Linus Torvalds wrote:
>> I don't dispute that a new link object might be a good idea, but
>> there's no explanation of the actual format of this thing anywhere,
>> and what the real advantages would be. A clearer "this is the design,
>> this is the format of the link object, and this is what it buys us"
>> would be a good idea.
>
> Yeah, I need help with that.  I've just stuffed in whatever fields
> popped into my mind first.  The current ones are:


And what you listed were your back-then-current thinking on "actual
format".

What are the real advantages?  How are they used?  What do they
allow us to do what we cannot do with .gitmodules (or repo or
gitslave for that matter)?  What do they buy us?

What problem are you trying to solve?

I have this suspicion that you do not have to change anything in the
object layer to make Git behave very differently from the current
submodule implementation.  For example, if your gripe were (I am
just speculating without any input from you in this thread) that
each submodule working tree has ".git" at their top and there is no
unified view from the top-level [*1*], we certainly can solve it
without any change to the object layer.

We currently add a cache entry that has the commit object name to
the index from the tree object when we check out the superproject,
and create a separate repository with a working tree when we
instantiate a submodule.

This arrangement does not have to be fundamental. It is a design
choice of one particular working tree layout, which is totally local
to individual superproject working tree.

You could arrange a single index (the one in the superproject) to
hold the tree contents from the commit in the submodule, while
noting the original commit object name in a new mandatory extension
section in the index. The index will have a unified view of the
whole tree, and we do not have to have a .git at the root of each
submodule working tree (be it a directory or a gitfile).

I think the message where I talked about the "bind" idea in the list
archive URLs I gave you earlier would give you such a layout, and
you should go read it again to understand how the flow from object
database to index to working tree back to index back to object
database was envisioned to work.  I think the only thing we need to
do differently from that "bind" proposal in the current world order
is not to record the new submodule state in the commit object of the
superproject, but actually create a new commit for the submodule
part and store it in the tree object for the commit in the
superproject (the "bind lines in the superproject commit" was a
hack, only because we didn't have a way to write the submodule
commit object name in the index and in the trees).


[Footnote]

*1* I am not saying that keeping everything down to the leaves of
submodules is necessarily a good idea.  This is only meant as an
illustration of what kind of a system that looks drastically
different from the end-user's point of view you could build, without
breaking the object layer and having to redo everything.
