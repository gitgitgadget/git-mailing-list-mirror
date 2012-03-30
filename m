From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 14:28:31 -0700
Message-ID: <7vzkaxkccg.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <20120330210112.GA20734@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 23:28:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDjND-0007YL-6X
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 23:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935555Ab2C3V2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 17:28:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934743Ab2C3V2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:28:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E9EC4B30;
	Fri, 30 Mar 2012 17:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a+WFYx6oBxA9PQ7zVbfoG0Pt0SU=; b=V8IFIl
	iFPz3TVNgCcuTLI0INnAA+872GPbdc4uaAzzWYfMTpvFHyqbnR0b7gp3ddaWO+66
	lF9oYpWreiPrevGg/YOggtfLLReNTkkd1BAjJaIVYFYMh6O5AkKecFdt4pHgNNZI
	oLFXzusMliNfk4Uct4N8b71Dg/XWXFmjpEHBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uutd+D0is6IJmcc01J9xiFvUojrfmJUE
	c7nCiauRwhovMTKf6z3kI/BcZwLJCl21AhoEJGT82PdgqBG+kTe8Do2QkLYn3msZ
	fTZOrs/Z4BdDeEuor9uyjoS3ELPfIXPyzE2w5i4BIp1i1+kKAG7c7a1qt3ycRSV3
	7CDnsekmAjk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55A644B2F;
	Fri, 30 Mar 2012 17:28:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 894CC4B2E; Fri, 30 Mar 2012
 17:28:32 -0400 (EDT)
In-Reply-To: <20120330210112.GA20734@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 17:01:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CE477CC-7AAF-11E1-BE54-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194410>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 30, 2012 at 01:25:03PM -0700, Junio C Hamano wrote:
>
>> And the reason why it is surprising to the beginners is?  Because "topic"
>> and "master" (of "origin/master") are not the same name?
>
> Sort of. It is more because "upstream" is an overloaded concept. Perhaps
> you created the branch from origin/master because you wanted to say
> "this is where my topic is based, and when I 'rebase -i' later, I want
> it to be considered the baseline". Or perhaps you meant to say "I am
> going to work on origin's master branch, but I would prefer to call it
> 'topic' here".

In either case, you seem to be assuming (and it is a correct assumption,
even though we may not use such a workflow) that the resulting branch, if
long lived, will be rebasing on top of origin/master.  And the reason why
you do that is because...

Because you would eventually want to get it integrated into origin's
master.  Otherwise you can stay apart from origin/master and keep your
foundation solidly anchored to where you started.

So in that sense, in both cases, pushing back to origin/master is likely
to be what the user expected in the first place.

Like it or not, many parts of Git that is "upstream"-aware have been over
time taught to make it easier for the eventual result easier to be pushed
back to the "upstream" at the remote, I think.  "log --left-right @{u}..."
will show what you and others have done, "rebase" knows to use @{u} when
figuring out on which commit to rebuild your current branch, etc.

> So we have to decide when two things are forks of "the same branch", and
> when it is merely "X is based on Y", or "X happens to have the same name
> as Y". And I think the "name is the same" semantics are way more
> obvious.

I obviously agree with that.

>> I tend to think that this is on the "understandable" side of the line
>> (after all, I said "Let's start a topic to be merged to origin/master"
>> when I started the topic, and I've been rebasing the topic up to date from
>> time to time), but obviously you don't think so.
>
> Is that what you said? Or did you say "I am starting a new topic that
> will be based on origin/master?"

See above ;-)  Having said that...

> I feel like the concept of "upstream"
> is very loosely specified, and can mean many things.

...I tend to agree with it.  But I am not sure if that leads to "we should
default to 'current' because 'upstream' is too messy and blurry".  At
least, not yet.

> Ultimately, it is not about whether one workflow is better than the
> other. It is about having a default that stops the user and says "hey, I
> don't know what workflow you're using. So you need to tell me before I
> can continue."

OK.  Obviously we would not want to default to 'push.default = nothing',
and 'current' is far simpler to explain.

But then I am afraid that you may be inviting teachers to blindly teach
beginners to first set push.default to upstream, just like they do today
where the default is matching, as most of them do know that upstream works
fairly well with the way how _they_ work, without having an understanding
these gotchas in upstream you are (validly) raising as possible issues
here.  So in the end, we would have to clarify whatever 'upstream' does
anyway, no?
