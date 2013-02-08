From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 23:33:20 +0530
Message-ID: <CALkWK0=RmKaM+5TRUxsPWomu+FgmAnBFBWe3YN+HFac4gnCqnA@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <20130208044836.GC4157@sigill.intra.peff.net> <7vliaz49sf.fsf@alter.siamese.dyndns.org>
 <7vd2wb483w.fsf@alter.siamese.dyndns.org> <20130208092204.GA15490@sigill.intra.peff.net>
 <7vwqui3fcc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:04:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3sIv-0004wg-Co
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946729Ab3BHSDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:03:42 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:44946 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946702Ab3BHSDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:03:41 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so4231969obb.36
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=N4BoQB19YVEqeBl2XQ/UmpThQS7qe6OPawgoOKxL2PY=;
        b=AArVKnNlbo5ozpW4wQ2AXhgcx1n0b7FHgMCgOY+eftE6wMWCzrgwnPD4d+UahEr0Sd
         BLMxr9qAvqNEqRpRE4PMMDyJtMX46U34MYPk76LvBCfO1IQO/RSa0jO/vLI1XF7BeVtC
         SkwFuzYcbNCkovkeCz141bi+a66PUdRY9ntLJdBlqieuCYuybPED8hbP54bJivDBjyeq
         dFfMORbhEe3fBOzqUQVhYZuGmjtyJpVqdxy9Ufmm8eoDnBafdOZDGFrNzUCX2UjkUhL9
         NiLSpvbTrtPR2vYAi2rHx3KMcNSnExtuqpmuJEaGbu4S9K1mUWz/J7LueHfrySJ3Y6M/
         4dYg==
X-Received: by 10.60.22.198 with SMTP id g6mr5003974oef.45.1360346620089; Fri,
 08 Feb 2013 10:03:40 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Fri, 8 Feb 2013 10:03:20 -0800 (PST)
In-Reply-To: <7vwqui3fcc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215792>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> We have the problem now that new users do not necessarily understand the
>> matching strategy, or why it is useful, and get confused. When we move
>> to "simple", we may be switching to a world where the early part of the
>> learning curve is more gentle for those users, but they eventually run
>> across the steeper part when they want to adjust their workflow (i.e.,
>> they will eventually learn about non-symmetric repo topologies because
>> those are part of many useful workflows).
>>
>> But I think it's a good thing to push that part of the learning curve
>> out, because:
>>
>>   1. Some people may stay in the centralized view their whole lives and
>>      never care.
>>
>>   2. It will make more sense to them, because they'll understand how it
>>      fits into what they're trying to do, rather than viewing it as an
>>      arcane and senseless default.
>>
>> There may be some confusion as people hit that learning point. I won't
>> be surprised if we end up adding more advice.* messages in certain cases
>> to guide people to adjusting their push.default. But I'm just as happy
>> to wait until people start hitting the confusion point in practice, and
>> we can see more clearly when that advice should trigger, and what it
>> should say.
>
> Oh, I agree with you that adding new support for triangular workflow
> will not hurt the centralized folks.  I was more interested about
> helping the "fetch from here, push to there" people.

In Git, there will always be a combination of switches which allows
you to go the centralized workflow mode.  We're focusing on expanding
this list of switches, to free up distributed workflows into more
possibilities.  We're currently targeting problems that affect us
everyday; the ones we've failed to notice.

> Centralized people do not have to configure anything for each branch
> for "git push" to push their current branch to where they fetch from
> and to the same name (you start building on their 'master', your
> result go to their 'master', because as a centralized person, you
> are part of 'them').  They have branch.$name.merge that names what
> their $name branch merges with, and that is sufficient to decide to
> which branch the result is to be pushed back.

What about the branch.$name.pushRef, which was proposed earlier?  They
should be able to say, at a per-branch level, which branches to send
for review (in Gerrit).

> With the "push.defaultTo = peff" to name what remote the "git push"
> will push to, or even with the "branch.master.remotepush = peff" to
> decide that per branch, would "fetch from here, push to there"
> people have a way similar to what branch.$name.merge gives to the
> centralized people to decide what branch is updated?

Ah.

> It almost seems to me that we may want to extend the semantics given
> to the remote.$name.push refspecs.  They are primarily for "perfect
> all branches you are going to push out, and push them in one go with
> 'git push'" workflow, but if it is clear that you are not following
> that (e.g. you are doing an equivalent of what the centralized folks
> would do with "push.default = simple/upstream/current") and pushing
> only the current branch, perhaps we should look at these refspecs to
> see where the current branch goes?

I'd actually just go with the current syntax + per-branch overrides.
Simple and serves the purpose: I don't think there'll be real usecases
outside this.

> In your case, 'refs/heads/master' would likely to go to
> 'refs/heads/master', and we could treat a missing remote.peff.push
> an equivalent to having remote.peff.push = refs/heads/*:refs/heads/*

I'll get to work on a patch that deems the configuration variable as
not "necessary".
