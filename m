From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Thu, 15 Oct 2009 14:54:18 -0700
Message-ID: <7v1vl42uid.fsf@alter.siamese.dyndns.org>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 23:58:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyYKW-0007Cp-52
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 23:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935348AbZJOVzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758315AbZJOVzp
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 17:55:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbZJOVzo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 17:55:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 40FE1792CB;
	Thu, 15 Oct 2009 17:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2t7xk43+OSQngEV0dcwheND9CEY=; b=LhdH+P
	r4Ru4QlmjMs3aTrou/IAIuiNApJJrQ9Uev9DPUrk7ZIwNm+OPJxDm+KXpPnk2/ZW
	trofWkYY+afxzL/4+vwyfBiSX2G7pEJ5DBVvcF7Lt4Kx1ybHVworXCnzeeEOWL5c
	QiZrkhz24Wa+Kj/tjP+tc3G9PJbzcmI0Xp0g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZD0DeCR4Wq9LkQ4KRAIIQ/0xq4KllVO
	F6TvzGXyvKTGpKR+FlzCfc9dFDfWFJeh/mSoRNA/RMd88Z3d2QI4lc9IyPacjmNK
	dylvadxRsrzP3vFV1Ga7bLCZOXP6DaqEzv4zDzujLlsZ7cRXfZG8ed4G2QjNTFEJ
	MQwJZSbcDLo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8035792C7;
	Thu, 15 Oct 2009 17:54:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4401F792C2; Thu, 15 Oct 2009
 17:54:19 -0400 (EDT)
In-Reply-To: <20091015212632.GA13180@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 15 Oct 2009 17\:26\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5097C308-B9D5-11DE-B535-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130427>

Jeff King <peff@peff.net> writes:

> On Thu, Oct 15, 2009 at 12:52:55PM -0700, Junio C Hamano wrote:
>
>> I like James's suggestion to allow us to store refs other than refs/heads/
>> in HEAD to denote this state, and keep commit and reset from updating such
>> a ref through updating HEAD.
>
> Didn't we already consider and reject this the first time around? For
> example, this thread has a ton of stuff about how we shouldn't prevent
> people from making commits on the wandering state:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/35777/focus=35835
>
> And here's me even advocating this exact strategy (and I'm sure I didn't
> think of it; it's probably discussed elsewhere, too):
>
>   http://thread.gmane.org/gmane.comp.version-control.git/35777/focus=35858
>
> Not that I am not necessarily complaining, but I just hope this decision
> is "with new-found knowledge we are revisiting this decision" and not
> "we totally forgot about what came before".

Maybe we are reading different messages in the same message.

My understanding of James's suggestion is:

 (1) "git checkout $token" makes HEAD point at the refname dwim_ref()
     expands $token to, iff dwim_ref() is happy, and otherwise detaches
     HEAD;

 (2) "git commit" (and other things like "git reset HEAD^" that updates
     underlying ref thru updates to HEAD when HEAD is a symref) rejects
     when HEAD points at a ref outside refs/heads/, but works when HEAD
     points at a local branch, or when HEAD is detached.

As a consequence:

    $ git checkout v1.6.5      ;# does not detach, cannot update
    $ git symbolic-ref HEAD
    refs/tags/v1.6.5
    $ git checkout origin/next ;# ditto
    $ git symbolic-ref HEAD
    refs/remotes/origin/next

These are often done by sightseers, and we can add instructions to fork
and record upon an attempt to "git commit".

As a bonus, we get Daniel's extra information for detached HEAD for free,
as we can just read HEAD and learn what it points at.  We need to design
what "git branch" should say in this case.

This is backward incompatible, and makes what experts are used to do
slightly cumbersome to spell, i.e.

    $ git checkout v1.6.5^0      ;# detaches and can commit
    $ git checkout origin/next^0 ;# ditto
    $ git checkout $(git merge-base master sp/smart-http) ;# ditto

These detach, and I can apply the updates series to the same base as the
previous round on an unnamed branch.

So in other words, the semantics for detached HEAD case does not change at
all.  We never forbid committing or resetting while on detached HEAD, as
it is meant to be an easy way to get an unnamed throw-away state that is
not even worth coming up with a unique temporary branch name, and I do not
think the above contradicts with what was said in 35835.

We used to have only two states on HEAD: either on a local branch or
detached.  James is introducing another state: on a ref that is not a
local branch.

As that is useful for common sightseer tasks, we can afford to forbid
committing or updating for safety and we do not have to worry about
hurting the established usefulness of how detached HEAD works.

One drawback is that you cannot be in this sightseeing state without
having a ref.  You can have "look-but-not-touch" checkout on origin/next
or origin/master, but you cannot sightsee the parent of origin/next the
same way (it would detach).  I do not know if it is a big deal, though.

If it is very important to support:

    $ git checkout --look-but-not-touch origin/next^

then James's approach would not be very useful, as we do have to detach
HEAD and implement the "do not touch" logic for detached HEAD state
anyway, so we might just use the same logic we would use for origin/next^
when checking out origin/next itself.
