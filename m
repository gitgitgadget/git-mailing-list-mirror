From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 09:06:27 -0800
Message-ID: <7vwqui3fcc.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <20130208044836.GC4157@sigill.intra.peff.net>
 <7vliaz49sf.fsf@alter.siamese.dyndns.org>
 <7vd2wb483w.fsf@alter.siamese.dyndns.org>
 <20130208092204.GA15490@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:07:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rPl-0006ZF-II
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760206Ab3BHRGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:06:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758581Ab3BHRGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:06:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FB90CF42;
	Fri,  8 Feb 2013 12:06:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yNM18cK/uCNpaxkLqFzUUTykC3Q=; b=HyUsaS
	b0rQNvcHV3NoisCUHHeH13sKUPPRQP6CriSckecdkbv8r1UOjC6ZmcOaVXBcdpyr
	e4vPktdUtwLFdpigryxJIskRm3n4ow8fVLbVtW9Dgf+XOxkvA0iDWYgMpfNK7Uxi
	GzdDKIO7T4FmRm32Xld5jvgzWviSotCg38Zv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lSHuFmK4Fj2Y+6lg0nrHIy5qql4Dgz+k
	N8yVQmCwwsV5Mv3zdED3NzWY3WYdUHgBdlXG1gx4QKpIOwDiHvj1Grh3FIeb3qEh
	/j+X1YqhoszQCDYcbHLWWsYCD2sCUG8dwr4nZH2v06msR6uUI338krgO9Kbfg5sZ
	IWNmZmV9lJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9445CCF41;
	Fri,  8 Feb 2013 12:06:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB5EFCF40; Fri,  8 Feb 2013
 12:06:28 -0500 (EST)
In-Reply-To: <20130208092204.GA15490@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Feb 2013 04:22:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0F07DD0-7211-11E2-8C67-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215782>

Jeff King <peff@peff.net> writes:

> We have the problem now that new users do not necessarily understand the
> matching strategy, or why it is useful, and get confused. When we move
> to "simple", we may be switching to a world where the early part of the
> learning curve is more gentle for those users, but they eventually run
> across the steeper part when they want to adjust their workflow (i.e.,
> they will eventually learn about non-symmetric repo topologies because
> those are part of many useful workflows).
>
> But I think it's a good thing to push that part of the learning curve
> out, because:
>
>   1. Some people may stay in the centralized view their whole lives and
>      never care.
>
>   2. It will make more sense to them, because they'll understand how it
>      fits into what they're trying to do, rather than viewing it as an
>      arcane and senseless default.
>
> There may be some confusion as people hit that learning point. I won't
> be surprised if we end up adding more advice.* messages in certain cases
> to guide people to adjusting their push.default. But I'm just as happy
> to wait until people start hitting the confusion point in practice, and
> we can see more clearly when that advice should trigger, and what it
> should say.

Oh, I agree with you that adding new support for triangular workflow
will not hurt the centralized folks.  I was more interested about
helping the "fetch from here, push to there" people.

Centralized people do not have to configure anything for each branch
for "git push" to push their current branch to where they fetch from
and to the same name (you start building on their 'master', your
result go to their 'master', because as a centralized person, you
are part of 'them').  They have branch.$name.merge that names what
their $name branch merges with, and that is sufficient to decide to
which branch the result is to be pushed back.  

With the "push.defaultTo = peff" to name what remote the "git push"
will push to, or even with the "branch.master.remotepush = peff" to
decide that per branch, would "fetch from here, push to there"
people have a way similar to what branch.$name.merge gives to the
centralized people to decide what branch is updated?

It almost seems to me that we may want to extend the semantics given
to the remote.$name.push refspecs.  They are primarily for "perfect
all branches you are going to push out, and push them in one go with
'git push'" workflow, but if it is clear that you are not following
that (e.g. you are doing an equivalent of what the centralized folks
would do with "push.default = simple/upstream/current") and pushing
only the current branch, perhaps we should look at these refspecs to
see where the current branch goes?

In your case, 'refs/heads/master' would likely to go to
'refs/heads/master', and we could treat a missing remote.peff.push  
an equivalent to having remote.peff.push = refs/heads/*:refs/heads/*

In a Gerrit user's case brought up by Michael Schubert in a message
earlier in the near-by subthread, 'refs/heads/frotz' would likely to
go to 'refs/for/frotz' and they can express it with something like

	[remote "origin"]
		url = ... ;# pushurl is the same or just s/git/ssh/;
                fetch = refs/heads/*:refs/heads/*
                push = refs/heads/*:refs/for/*
	[push]
		default = "???"

where "???" says "I push out only the currently checked-out branch;
figure out where it goes using remote.origin.push refspec".

Having to set both branch.$name.remotepush to name what remote this
branch should be pushed, and branch.$name.branchpush to name what
branch at the remote this branch should update with a push, and
doing so for each and every branch, sounds like an unnecessary
complexity.
