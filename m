Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1526CDB465
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 00:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjJLAHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 20:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLAHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 20:07:00 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EA94
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 17:06:58 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697069216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOfw2cXYffgIKZQ9c4OJfA9MSIKJGhXBiGqrzna9Cng=;
        b=tVa4AUmqiQSjD5Ztnsjgddr0HpqzaJ5/eRikhx45pXaPoRqEzSvkIy2C6SKjJrEbPJjLRo
        hv/yEfPRuHiSjbBZM80IG21zV4GgoRkbzxbmq4PiVQ9TZvYHwm3r7eVd+73ge6YqhARAJb
        Mo2++Z7hsACaLT19HJjuA1lVRY7F5cqMUs3+pb9dlhJmpGsOQbQ8deF0pwB+NUleNvc4nz
        +lX2tv+62VZRG83QMQatTs4FoXeQCJ0sxa6sO6GLNDJ0l3yfn0dM1TNQBHxeH1Q+iM2h4M
        HMRAXsWJe/Vqi10Sj3EhW+AeyYYVSlVGHKIxY5qe9yUSb8L4qa9lLqGwXjug6Q==
Date:   Thu, 12 Oct 2023 02:06:56 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
 <xmqqa5sokdd3.fsf@gitster.g>
 <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
 <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
 <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
 <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
 <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
Message-ID: <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-12 01:43, Christoph Anton Mitterer wrote:
> On Thu, 2023-10-12 at 01:29 +0200, Dragan Simic wrote:
>> I'm not sure what do you mean by the non-cleared remains being
>> chopped
>> off...  Could you clarify that a bit, please?
> 
> Well if I do say:
> $ reset
> $ git diff HEAD~10
> 
> and from there scroll down a bit and then q to exit less (and the
> screen is not cleared), I see the output only so far as I've had
> previously scrolled down in less.

There's also scrollback in the terminal, which can be used to show more 
of the contents that was displayed before exiting the pager.

> Everything that would have come after that is of course not visible.
> The place where I exited may be some "well defined" border, like the
> end of a commit... or anywhere it the middle of a patch (making the
> left over remains on the terminal perhaps even ambiguous).

If you didn't select some line or page to be displayed, by scrolling 
within the pager, it obviously isn't going to be displayed, which is the 
whole point of using a pager instead of "spitting" the whole contents 
out at once.

Where and when you exit the pager is up to you only, and you can decide 
what will be left on the screen at that point.

> What's worse, when (in less) I scroll down and up again, perhaps
> repeating several times, and then quit... I see (at least in my
> less/terminal combination) things twice and mangled up (i.e. when I
> scroll up the terminal (outside of less)).

That sounds like some issue with your terminal or terminal emulator, 
which should be debugged and fixed separately.  Such misbehavior isn't 
supposed to happen at all.

> So AFAICS, not clearing the screen only works properly when never
> scrolling up again (in less).

It works just fine for me, for example.  You're obviously having some 
unrelated issues with your terminal emulator.

>> As I already mentioned above, everyone is free to configure the pager
>> behavior in any way they like.
> 
> Sure :-)
> 
>> 
>> > > Exiting if less contents than one full screen was displayed (i.e.
>> > > "-
>> > > F")
>> > > is there to save people from the frustration of quitting a pager
>> > > that
>> > > actually wasn't needed to be executed.
>> >
>> > Same actually here, at least strictly speaking, ... though I (and
>> > probably everybody else?) would really hate it, if that was
>> > removed. ^^
>> 
>> I'm afraid that I don't understand very well are you complaining
>> about
>> the presence of "-F" or not?
> 
> No :-) As I've said, I like it that way and I and probably everyone
> else would be annoyed, if -F was not present.
> 
> I just meant that strictly speaking the same reason why "S" was
> removed, could be applied to "F" as well.

I see.  Actually, removing "-S" was a good decision, IMHO, because 
chopping long lines isn't something that a sane set of defaults should 
do.  Many users would probably be confused with the need to use the 
right arrow to see long lines in their entirety.

> It is - like -R - not necessary for less to work with git.
> 
> But it is, of course, what virtually everyone will want in practise.

Well, "-R" is pretty much mandatory, because coloring the outputs has 
become some kind of defacto standard, and it's very useful when viewing 
diffs, for example.

>> Quite frankly, I can't stand scrolling in less(1) using the mouse
>> wheel,
>> but I do understand why some people like it.
> 
> The main reason I want it is, that things don't get messy, when I
> forget being in less and mouse scroll. ;-)
> 
> 
> Thanks,
> Chris.
