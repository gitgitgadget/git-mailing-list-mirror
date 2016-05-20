From: Stefan Beller <sbeller@google.com>
Subject: Re: run-command: output owner picking strategy
Date: Fri, 20 May 2016 11:39:48 -0700
Message-ID: <CAGZ79kbTa-E3QTgGhzEPKnEHiOMq_On6h6RC8jrrQaot1YE94g@mail.gmail.com>
References: <906110267.5791524.1463748828183.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <401208017.5792558.1463749910970.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <CAGZ79kZ1LTF4h_WVV9mMCAQCVtH667GU011LiRNtkTmi9ygUYw@mail.gmail.com> <390486239.5813961.1463768960439.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 20 20:39:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3pL1-0007Mg-1G
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbcETSjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:39:51 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35646 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcETSju (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:39:50 -0400
Received: by mail-io0-f172.google.com with SMTP id p64so64386308ioi.2
        for <git@vger.kernel.org>; Fri, 20 May 2016 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7o0hLtcfhWAH6mp7xWhm9b/3N2WWY7zAVsgQLCa3zzk=;
        b=k/Zhk1+5Gf8mqY9DruWKUVY/2XjxRw8cP84tYWQZwuSdMPafd1g9x2XOcMM3oPqf1m
         d0xrHQGigB3Fyyuq0ikhORk4cVI0YRNMJNjXAu2uguA+fVqvkfxk8duNnibPT1X89RW5
         uEtCEsDjyEymi7JDoymEr6bi8f99YDMTIRltxYw4TLYQaYsCywhYQJ/OJmwHuy51c1Lb
         iE7pdxX55DDXpu1/evjwxbx6oBNBe3lrlVoMnEnXtok/iKxAlDv2TcMPKiDXUFsZCAV4
         5QFM9uFcsvejD49HP2NWIqery3S1McusM/nTb4TJyQNGJbagV38PAGzGcE04iTcYF6nE
         4C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7o0hLtcfhWAH6mp7xWhm9b/3N2WWY7zAVsgQLCa3zzk=;
        b=OAeppLbH7ZW42M2zR9u2S9Cc0/7EkF0CIMDjU6pFExJiYkMITccLYrkO6k71kVrPs0
         CR+4UYUHQ7d95uqsqG2Mu3uZjdx7a8Zt8DqGDy9+AUszyjX0INyx4fJtBD68/lmra4v2
         0Pvwl4iMb6AjHmXBBwE0orQH/B1aj5ZyDIaSnrqRMO8I/oRMwL5eGtf35bCAZiOpWxvY
         OhdQQwNBbK8+h4eGzxiV3+D7QTpF5eWnY2mjU/4YpZYdhSrQHD6qaCs2VHwfBNjZJ4u4
         I5DuKGtDfRTG/Ma64CErFtyH6FYXLf3lAQIWZxgcpr7eMPm9HC8g9xcn5APybulKKjxW
         9M4w==
X-Gm-Message-State: ALyK8tJhBbWxn1aNAph+UjC3VlE5pz+6KsI4QKxsbwJ6GVaDzQ+MW/PZ6UksiBRQqgH51uL5lqc1nQ9sTD09Jl1G
X-Received: by 10.36.107.148 with SMTP id v142mr737823itc.52.1463769589380;
 Fri, 20 May 2016 11:39:49 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 20 May 2016 11:39:48 -0700 (PDT)
In-Reply-To: <390486239.5813961.1463768960439.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295203>

On Fri, May 20, 2016 at 11:29 AM, William Duclot
<william.duclot@ensimag.grenoble-inp.fr> wrote:
>> When running in parallel we already may be out of order
>> (relative to serial processing). See the second example in the
>> commit message to produce a different order.
>
> Right, I could (should) have understood that by myself.
>
>> Consider we scheduled tasks to be run in 3 parallel processes:
>> (As we NEEDSWORK comment only addresses the ouput selection,
>> let's assume this is a fixes schedule, which we cannot alter.
>> Which is true if we only change the code you quoted. That picks
>> the process to output.)
>>
>> [...]
>
>> The output is produced by the current algorithm:
>> (1) Start with process 1 (A) whose output will be live
>> (2) Once A is done, flush all other done things, (B)
>> (3) live output will be round robin, so process 2 (D)
>> (4) Once D is done, flush all other done things (C, F, E)
>>     in order of who finshed first
>>
>>
>> (1) is uncontroversial. We have no information about tasks A,B,C,
>>     so pick a random candidate. We hardcoded process 1 for now.
>>
>> (2) also uncontroversial IMHO. There is not much we can do different.
>
> Agreed
>
>> (3) is what this NEEDSWORK comment is about. Instead of outputting D
>>     we might have choosen C. (for $REASONS, e.g.: C is running longer than
>>     D already, so we expect it to finish sooner, by assuming
>>     any task takes the same expected time to finish. And as C
>>     is expected to finish earlier than D, we may have smoother
>>     output. "Less buffered bursts")
>>
>> [...]
>>
>> This seems to be better than the current behavior as we have more
>> different tasks with "live" output, i.e. you see stuff moving.
>> I made up the data to make the point though. We would need to use
>> live data and experiment with different strategies to find a
>> good/better solution.
>
> We should probably settle on what is the behavior we want to obtain,
> before trying to find a strategy to implement (or approximate) it:
> - Do we want to be as close as possible to a serial processing output?
> - Do we want to see as much live output as possible?
>
> I do not think that being close to serial processing is a relevant
> behavior: we applied an arbitrary order to tasks when naming them for
> explanations (A, B, C...), but the tasks aren't really sorted in any
> way (and that's why the parallelization is relevant).Neither the user
> nor git have any interest in getting these ouputs in a specific order.

IIRC In serial processing the output was according to the sort order
within the tree. I agree that this sorting property is of no value to the user.

>
> Therefore, a "as much live output as possible" behavior would be more
> sensible.

I choose "as much live output" as an approximation of "least amount buffered
over time, i.e. if you were to integrate the buffer size over time
that should be
minimized. (c.f. users waiting for output: http://imgur.com/gallery/lhjhbB9)
I am not sure if that is ultimate thing to optimize for though.

> But I wonder: is there a worthy benefit in optimizing the
> output owner strategy?

Eventually there are more users than just submodules for this
parallel processing machinery, I would hope. They would also benefit
of a good fundament?

> I'm not used to working with submodules, but I
> don't think that having a great number of submodules is a common thing.

(Not yet, because of the chicken and egg problem: submodule UI is not
as polished because very few people use it. And few people use it because
of confusing UI. ;)

At his GitMerge2016 talk, Lars Schneider proposed a guideline to
not use more than 25 submodules as it "doesn't scale" IIRC.
And that resentment seems to be all over the place.

> Basically: we could solve a problem, but is there a problem?
> I'm not trying to bury this NEEDSWORK, I'd be happy to look into it if
> need be!

Well Git as a community doesn't ask you to solve any problems. ;)
So if you have fun thinking about scheduling problems (and as you do
it as part of a university project, if Matthieu is happy about this problem
also), go for it :)

If you find another more "interesting" problem (either as defined by
you personal interests or by the possible impact or by possible grading),
choose that?

Thanks,
Stefan
