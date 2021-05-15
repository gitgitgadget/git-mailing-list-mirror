Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F220C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 03:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31317613D1
	for <git@archiver.kernel.org>; Sat, 15 May 2021 03:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhEODdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEODdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 23:33:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F406C06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 20:32:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h7so340864plt.1
        for <git@vger.kernel.org>; Fri, 14 May 2021 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EGc3jjWJsjZTIiHC4IwlBFPxeNzZCUa3p0/A11ilz30=;
        b=CVaaIK6ijGRuvH3QjE+6sqSOvYZYx6YwIsqEiAa31YgkTOZbaicyORDpZA6bN13d+w
         11NBSn7dTDc7UzNPaPZ+qOUjBd9imLDVOzU7XZQZgAKpUEIiI++hRgUzpZHOLzAD3cGn
         x40LL004IPdziAktVbGUwaccHcJPCTu4blyYiYao2G00OxDVTl0BRl/oJw3km2HOYvn3
         0KLCZteppUZdBpQqOXWMZsEwtyHLvtyx+P6lG4ughkIU2OFfESs1og7PMIFOFA1tZQ7N
         kTL/3YlGAlE5YxWqtlHmrjILGm21sAqfLwgqmUVpLfTw3zDm0pfvwSn43aVMPxzBv/ms
         oLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EGc3jjWJsjZTIiHC4IwlBFPxeNzZCUa3p0/A11ilz30=;
        b=aFA1a59uJLzYg8T11fxcgTRSeEFJk0D+hED4G584YecG/ALgjhEJjP4ETvRqw4fUh7
         S45AyRnhN+1zgX+SFHx1X0nqwwzGKJR41eW9rJQ4SgKi0UpDOXdtY39V9SxARtyHxn61
         UdD3leJCm57VjF03s4snKTZxTOXF39/7UO2KqixMgEGMUB6XnFzp8tnJz8iCeDbl7++q
         3sEAbVxycONZa4LA/xFH1WznIuH7MITNkCZkxaExI6yWEET0DcPtW3APZcgF+WZ4KriY
         fB9uIz3BJ3FWP0sAnLgn4KZVcIpOvYqK/2f77W6P4Tm/VDwRQk9At1pnwymdJlCryds8
         znpw==
X-Gm-Message-State: AOAM530BWLicXhy2AnW9jKaM53f7mlz3jlkun7jitKZ5csexXL5yG4a9
        ZA8VpGjLVdYo8mKfV+LH4oEqhzyuiZ6bUg==
X-Google-Smtp-Source: ABdhPJxDOO2cj2jKbQmYW7M8zPOZu6QX0IMmrJJyGSjLWbTRGHK9LVZCuI/jAgBVwU3tFrtHXv8YNw==
X-Received: by 2002:a17:902:104:b029:ec:9fa6:c08 with SMTP id 4-20020a1709020104b02900ec9fa60c08mr49422586plb.10.1621049551658;
        Fri, 14 May 2021 20:32:31 -0700 (PDT)
Received: from [192.168.43.80] (subs09b-223-255-225-233.three.co.id. [223.255.225.233])
        by smtp.gmail.com with ESMTPSA id t24sm10002926pji.56.2021.05.14.20.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 20:32:31 -0700 (PDT)
Subject: Re: [PATCH] Documentation/howto: tracking git.git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20210514124925.39229-1-bagasdotme@gmail.com>
 <xmqqwns177cv.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <cbbde4f4-3e10-2c08-6ca1-6f22f8497194@gmail.com>
Date:   Sat, 15 May 2021 10:32:27 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <xmqqwns177cv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/05/21 20.49, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> +Available Branches
>> +------------------
>> +
>> +There are several branches on git.git with different purposes:
>> +
>> +master::
>> +This is the most stable branch. Changes (topics) that are merged
>> +to master should have been stabilized in next and suitable for
>> +production use. Feature releases (vX.Y.0) are cut from this
>> +branch.
> 
> Isn't "maint" meant to be more stable?
> 

I think "maint" is maintenance branch for latest feature release.
For feature stabilization it happens on "main", so "master" is fully
polished.

>> +next::
>> +This is where topics that haven't been yet merged to master are
>> +stabilized and tested for breakage and regressions. It gives
>> +a summary forecast of what next batch of topics that will be
>> +merged to master looks like.
>> +
>> +seen::
>> +This is the most bleeding edge branch where all excited
>> +developments happened. All proposed topics are queued in seen
>> +by the maintainer. However, these may be buggy (have breakage or
>> +regressions). When topics queued are deemed good and ready for
>> +inclusion, they are graduated to next for stabilization.
> 
> This is inconsistent with what has been written elsewhere about this
> integration branch.  In short, you should not read anything more
> than "the maintainer happens to have seen these topics" out of the
> fact that a topic is in 'seen'.  Not all proposed topics will be in
> this branch, and a branch that was in 'seen' on one day may not be
> there the next day, but that does not mean anything (certainly it
> does not mean the topic has been "rejected").
> 
>> +Tracking
>> +--------
>> +
>> +If you don't have git.git clone handy, you can obtain one by:
>> +
>> +----
>> +$ git clone https://github.com/git/git.git git
>> +----
>> +
>> +Now you can start hacking your topics. Don't forget to read
>> +`Documentation/SubmittingPatches` for instructions on patch
>> +submission.
>> +
>> +After some time, there will be updates to git.git. First, fetch them:
>> +
>> +----
>> +$ git fetch origin
>> +----
>> +
>> +Then pull the updates.
>> +
>> + - For `master`, `next`, `maint`, and `todo`, you can do fast-forward
>> +   pull:
>> +
>> + $ git pull --ff-only
> 
> I do not see a point in doing this for all of these branches, and
> I'd rather not to see this recommended to people who "track to
> develop" at all.  It may make sense to do so if you do not do any
> development of your own and will always stay on 'master' to check
> out, build, test and install from the upstream, though.
> 

But when someone clones git.git, Git will automatically checkout default
branch (which is "master") after cloning. If he wants to checkout other
branches, he had to "git checkout next" for example. I wrote it above
under the assumption that someone had already checkout other branches
before.

> For those who track to develop", if you want a reference point to
> work from, you can do "git fetch origin" and then run
> 
>      $ git checkout -b mytopic origin/master
> 
> for a new feature, and
> 
>      $ git checkout -b myfix origin/maint
> 
> for a fix.  You can track your progress with
> 
>      $ git log origin/master..mytopic
>      $ git log origin/master..myfix
> 

I think git log above shows only commits that are on mytopic/myfix/
whatever that aren't on origin/master.

> If you are fixing a longstanding bug, you may even want to do
> 
>      $ git checkout -b myfix-for-2.29-and-above v2.29.3
>      $ git log origin/master..myfix-for-2.29-and-above
> 
> To test your various topics, you would then do
> 
>      $ git checkout -B trial origin/master
>      $ git merge mytopic
>      $ git merge myfix
>      ... build, test, install, employ it for daily use ...
> 
> And you can make sure you do not step on toes of others by doing
> trial merges
> 
>      $ git checkout -B trial origin/seen ;# or origin/next
>      $ git merge mytopic
>      $ git merge myfix
>      ... build and test
> 
> which is highly recommended.  This will give you a chance to notice
> who, if any, are working in areas of the codebase that potentially
> overlaps with what you are working on before you even send out your
> series for review.
> 
>> + - For `seen`, DO NOT pull with `git pull`. This is because seen is
>> +   in constant flux, and most often your local seen is divergent from
>> +   the origin, caused by force-push from the maintainer. Attempting
>> +   to pull either via merge or rebase will most likely end in
>> +   conflict. Instead, pull by resetting the local seen to the origin:
>> +
>> + $ git reset --hard origin/seen
> 
> Even better, do not even create your own 'seen' branch at all.  If
> you are interested in what is going on
> 
>      $ git log --first-parent --oneline origin/master..origin/seen
> 

OK.

> might be worth paying attention to, and checking out the tip of
> topics of other people you seen in the output and playing with it on
> a detached HEAD may also be useful, and if you find bugs in other's
> work, you can futz with the code from that commit and you may end up
> with a patch you can send as an improvement suggestion to the
> original author of the topic.  But 'seen' as a whole is rarely of
> interest, except for the purpose of learning what other topics may
> be in flight.  Nobody sane is supposed to be running the version
> from 'seen'; after all, the selection criteria of the topics in it
> is "some of the topics that the maintainer happened to have seen",
> and not even "these topics are interesting, promising and are wished
> to be in 'next' someday".
>
Thanks for your review.

-- 
An old man doll... just what I always wanted! - Clara
