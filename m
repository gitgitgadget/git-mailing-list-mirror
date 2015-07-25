From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Sat, 25 Jul 2015 15:41:13 -0700
Message-ID: <CA+P7+xq7cL2M+EUQ6gafbn_qTLzz1jgcAHmfWccsrKUvpXK52g@mail.gmail.com>
References: <20150723012343.GA21000@peff.net> <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
 <20150724072325.GC2111@peff.net> <xmqq8ua5oapm.fsf@gitster.dls.corp.google.com>
 <20150725020526.GA8948@peff.net> <xmqqh9osjfsu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 00:41:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ88Q-0005y2-1g
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 00:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbbGYWle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 18:41:34 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33234 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbbGYWld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 18:41:33 -0400
Received: by ietj16 with SMTP id j16so41390111iet.0
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LgIFucC9mTiqfb9UJvJ1rD0UMOvihyueEVEJ+bcmN8k=;
        b=omHVdJHPmYC1AclwZhhQJdfyIL9oRyA8MtzCvGKeG78nD4UTdk3wKTBgFRCC3n8T8G
         CGwC6688eQv4RxG/czz/RFNt5XKgtilO0ypOJa1xl9y8kk6qLmGUqf7qdQouQ6ohiNtN
         1itXsA+SDCpBhSVu0cgKi61rQsNJpleksiBScRC/ztmFGqFTBELDua8n/PkLFyq1eD2j
         CU/6wOjfgDJKIVUEHBk9e7H+qxksiL+PjB4vVrk5UEijMCh93OzwEd1pF1U/HWVe2QrX
         iVytU1tvrZk4nFTOTGWrObqOmC5ql0/5O20DfQJIg1EidhWhRKpEHXrK4AevOQfMSo7p
         9LFg==
X-Received: by 10.50.88.6 with SMTP id bc6mr7014445igb.24.1437864093164; Sat,
 25 Jul 2015 15:41:33 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 25 Jul 2015 15:41:13 -0700 (PDT)
In-Reply-To: <xmqqh9osjfsu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274622>

On Sat, Jul 25, 2015 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Jul 24, 2015 at 08:07:49AM -0700, Junio C Hamano wrote:
>>
>>> Yeah, you actually convinced me reasonably well that it would
>>> happen.  I'd never use it myself.  If people want to shoot
>>> themselves in the foot, be my guest ;-)
>>>
>>> Perhaps we should drop this, and give a shorter synonym to the
>>> option?
>>
>> I'm still on the fence to have the config kick in only for HEAD.
>
> Hmm, I cannot tell offhand if the confusion factor is worth it (I
> didn't say "I don't think it is worth it").  I'd imagine that one
> common thing to want is to get an overview of what has happened
> upstream since the topic one is currently working on forked from it,
> i.e. "log --first-parent ..master", for an individual contributor,
> and nother is to see what has happened since the last stable point,
> i.e. "log --first-parent origin.." or "log --first-parent v1.0..",
> for an integrator.  Neither is covered by the "fp when implied HEAD".
>
> When I am playing an individual contributor, I often want to see my
> progress with "log -9" or something, only because "log origin.." is
> longer to type and I know my topic is not that long as nine commits.
> I guess implied first-parent would not hurt that much in that case,
> simply because I do not expect too many merges on a topic, but it
> feels wrong to default to first-parent traversal there.
>
> So...
>
>> It feels somewhat magical, but at least the config option name makes it
>> painfully clear exactly when it would kick in. I dunno. I am happy
>> enough for myself to just run "--first-parent" when that is what I want
>> to see. Giving it a shorter name would not help much, I think.
>
> I admit I may be minority, but two common things I do everyday are
> "log --first-parent v2.5.0-rc0.." and "log --first-parent master..pu";
> I could certainly use a short-hand there.
>
> I already have alias for it, so this is not to help me personally,
> but "log -FO" to trigger first-parent one-line would make the alias
> unnecessary.
>
>> It is not
>> the number of characters, but the fact that most people do not _know_
>> that --first-parent exists in the first place, or that it would be
>> useful in this case.
>
> That is a separate "education" problem.  My suggestion was more
> about "I know there is a way already, but it is cumbersome to type".
>
>> I hoped with a config option it might become
>> something projects could recommend to their users[1] if the project has a
>> matching workflow. But maybe we could also rely on those same projects
>> to educate their users.
>
> They could educate their users to use "log -F" just like they could
> tell them to say "config log.firstparent true", I would think.  The
> risk of the latter is that those who blindly follow the config path
> without understanding what is going on will not even realize that
> the problem is that they told Git to only follow the first-parent
> path, when they do want to see commits on the side branch, let alone
> discovering how to countermand it from the command line one shot.
>
> An instruction to use an extra option, on the other hand, makes it
> clear that there is a non-default thing going on, which is more
> discoverable: "perhaps I can run it without -F?"

I like the idea of a shorthand more than the configuration simply
because it doesn't make sense (to me) to always be enabled, and it is
much easier to do so without realizing that you've done it.

Regards,
Jake
