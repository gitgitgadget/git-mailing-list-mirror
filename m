From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: git-applymbox broken?
Date: Mon, 12 Jun 2006 14:10:01 -0600
Message-ID: <m17j3m5e5i.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
	<m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
	<m13bea6w13.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606121204220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 22:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpsjz-000273-NM
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 22:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWFLUKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 16:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWFLUKS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 16:10:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19430 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932223AbWFLUKO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 16:10:14 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5CKA1Wr007220;
	Mon, 12 Jun 2006 14:10:01 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5CKA19v007217;
	Mon, 12 Jun 2006 14:10:01 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606121204220.5498@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Jun 2006 12:10:27 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21738>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 12 Jun 2006, Eric W. Biederman wrote:
>> 
>> Below is an example of the kind of patch that inspired me to relax the
>> rules on parsing in body headers (this comes from Andi Kleen quilt tree).
>
> And this is wrong.
>
> We should _not_ accept crappy patches, and then start guessing at what the 
> person meant.
>
>>From the very beginning of git, I tried to make it extremely clear that 
> there is never any guessing going on. We don't use "heuristics" except as 
> a pure optimization: ie a heuristic can have a _performance_ impact, but 
> it must never EVER have semantic impact.
>
> SCM's are not about guessing. They are about saving the _exact_ state that 
> the user asked for. No "let's try to be nice", no gray areas.
>
> If the new git-applymbox just takes random lines from the body of the 
> email, and decides that they may be authorship information, then that is a 
> BUG. The "From: " line in the middle of an email may well be about 
> somebody having _discovered_ the bug, and we're quoting him as part of the 
> explanation. It does NOT mean that it's about authorship.
>
> So we should ONLY check for "From:" (and perhaps "Subject:" and "Date:") 
> at the very top of the email body. NOWHERE ELSE.
>
> The fact that somebody has a crappy quilt tree, and the fact that quilt is 
> very much a "anything goes" kind of laissez faire system does not mean, 
> and should NEVER mean that git becomes the same kind of mess of "let's do 
> a best effort and try to guess what somebody means" kind of thing.

Ok. A reasonable position.  It would have been nice if you had squawked 
when I made that change: 2dec02b1ecafc47d4031d0a68a94c775a6a9ff9e

I thought I was explicit when I did it, oh well.

As for quilt being imperfect that among other things is why I
am slowly trying to make the tools play together better.  So people
can use the best tool for the job, which if the integration is tight
enough becomes a single tool.

> I check and edit my emails before I apply them, and I try to teach the 
> people who send them manners and what the rules are. THAT is the way to 
> handle this, not by having the tool itself become unreliable and random

What are the rules?

This looks like something that needs to be Documented by
more than just the source of git-mailinfo.

The need to skip extra blank lines was a surprise to me.
In looking for documentation the best I could quickly
find was SubmittingPatches and it only Documents the From: and ---
lines.

Eric
