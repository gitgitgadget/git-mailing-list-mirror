Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FCC433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7773961222
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhEEO62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhEEO61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:58:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0798C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 07:57:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1310973wmi.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Op2nByi/4/wknQyhpOrUy3B7Kc70K1RIGsndve1yK8=;
        b=iXUQOptQ5B5KxXB3xioZrf9toZDKZFeQxpyskPsBLo8uGIvB5bwJCrQL6fTP87x3Gr
         R1eCVmrmFvyUDoKrJZKJG0SeOphgAzLGOFggnMx9MdWoiV82EreIIBeifCzq8GSRaptn
         Sfu2LNU0eeSNDF0J6dp8NfZIjRh0NU98XdQRCm4ypIZqsEE4WEPuMIi5Ivdc6Mtpu66h
         6K4AsiSxzla5yvHcCvKJZmLY0J4zO0dXbZN7x3xyiy7z98PTwJfJBuIDX/ivddt0gPi2
         6Bro6w6mhnqerYIAqCw26jR6ghNtiAU47eHw5v5Yqe93lHSao31kBnBXF3l5GV2nYbBI
         puZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1Op2nByi/4/wknQyhpOrUy3B7Kc70K1RIGsndve1yK8=;
        b=JfJfQVkusbqyJ5vQZbt9s3ps1YnjchJbrd6LmR5kxNk6TpvTpGk7Jt7bxizYQHoDC0
         ykfTOtXWPXaKrBc8JhGHtJ1sMgfUpocj48muXTbGKGxjMt4K/2vuGGLc0AVEfGq+g7gd
         8oGYH0qCHFHpeRFx32fbfXEKAHX57f6knffsABenyv0DkpSLgBSX7Adt/UhE4kEGKhps
         pjwWmZGALzOfCJcE1ouf/Yx5fshQ97oy36LrW1cjftGlJO5p6Uv/iL/0HsX8+tO0g4HQ
         tdm/iHNyUN2kHAkR6hJr9Ndx2+evxP2fcgHVndrvAM5vEJ+t7JsXiZFiKpjqFKwv1EvB
         Mg2w==
X-Gm-Message-State: AOAM532gItxTABr1cSbqZOYt52rE7FSqQ9Ph5whfOmiTG9ANEZnzhV3B
        cwydMtqjh0TUk6I9fqtxGR0=
X-Google-Smtp-Source: ABdhPJyrps38nCz1yUIrVR9SBDrA5l44ZDKP7vbRl+Vdy36Fa/pcGiIBf2WQA6hqY7YPE1Cy8x9l8g==
X-Received: by 2002:a7b:c101:: with SMTP id w1mr10452605wmi.164.1620226649441;
        Wed, 05 May 2021 07:57:29 -0700 (PDT)
Received: from [192.168.1.240] (61.22.198.146.dyn.plus.net. [146.198.22.61])
        by smtp.gmail.com with ESMTPSA id n5sm15599069wrx.31.2021.05.05.07.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 07:57:29 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
 <b1153c47-05cf-877c-587b-8205d8d32816@gmail.com> <YJKNVX5Nq64wAfvA@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <24e37e66-1418-4f64-5405-46aaf6449e4a@gmail.com>
Date:   Wed, 5 May 2021 15:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJKNVX5Nq64wAfvA@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn

On 05/05/2021 13:19, Đoàn Trần Công Danh wrote:
> On 2021-05-02 15:10:05+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 02/05/2021 07:45, Eric Sunshine wrote:
>>> On Sat, May 1, 2021 at 10:59 AM Lénaïc Huard <lenaic@lhuard.fr> wrote:
>>>> The existing mechanism for scheduling background maintenance is done
>>>> through cron. On Linux systems managed by systemd, systemd provides an
>>>> alternative to schedule recurring tasks: systemd timers.
>>>
>>> Thanks for working on this. While `cron` has been the go-to standard
>>> for decades, `systemd` is certainly widespread enough that it makes
>>> sense to support it, as well.
>>
>> Yes, thank you for working on this, it will be very useful to users like me
>> who use a linux distribution that does not install a cron daemon by default
>> but relies on systemd instead.
>>
>>>> The main motivations to implement systemd timers in addition to cron
>>>> are:
>>>> * cron is optional and Linux systems running systemd might not have it
>>>>     installed.
>>>> * The execution of `crontab -l` can tell us if cron is installed but not
>>>>     if the daemon is actually running.
>>
>> Can we use systemctl to see if it is running (and enabled so we know it will
>> be restarted after a reboot)?
> 
> Not sure if I understand this suggestion.
> However, non-systemd systems doesn't have systemctl command to begin
> with.

I was wondering if on systems with both cron and systemd installed we 
could use systemctl to determine if crond is actually running as Lénaïc 
pointed out that being able to run `crontab -l` does not tell us if 
crond is running.

Best Wishes

Phillip

>>>> * With systemd, each service is run in its own cgroup and its logs are
>>>>     tagged by the service inside journald. With cron, all scheduled tasks
>>>>     are running in the cron daemon cgroup and all the logs of the
>>>>     user-scheduled tasks are pretended to belong to the system cron
>>>>     service.
>>>>     Concretely, a user that doesn’t have access to the system logs won’t
>>>>     have access to the log of its own tasks scheduled by cron whereas he
>>>>     will have access to the log of its own tasks scheduled by systemd
>>>>     timer.
>>>
>>> The last point is somewhat compelling. A potential counterargument is
>>> that `cron` does send email to the user by default if any output is
>>> generated by the cron job. However, it seems quite likely these days
>>> that many systems either won't have local mail service enabled or the
>>> user won't bother checking the local mailbox. It's a minor point, but
>>> if you re-roll it might make sense for the commit message to expand
>>> the last point by saying that although `cron` attempts to send email,
>>> that email may go unseen by the user.
>>>
>>>> In order to schedule git maintenance, we need two unit template files:
>>>> * ~/.config/systemd/user/git-maintenance@.service
>>>>     to define the command to be started by systemd and
>>>> * ~/.config/systemd/user/git-maintenance@.timer
>>>>     to define the schedule at which the command should be run.
> 
> I think it would be better to change ~/.config here to
> $XDG_CONFIG_HOME, as others also points out in another comments.
> 
> [..snip..]
> 
>>>> +`git maintenance start` will overwrite these files and start the timer
>>>> +again with `systemctl --user`, so any customization should be done by
>>>> +creating a drop-in file
>>>> +`~/.config/systemd/user/git-maintenance@.service.d/*.conf`.
> 
> Ditto.
> 
>>> Will `systemd` users generally understand what filename to create in
>>> the "...@.service.d/" directory, and will they know what to populate
>>> the file with? (Genuine question; I've never dealt with that.)
>>
>> I think it would be helpful to explicitly mention the file names (I don't
>> think I could tell you what they are without reading the relevant systemd
>> man page)
> 
> [..snip..]
> 
>>>> +static char *systemd_timer_timer_filename()
>>>> +{
>>>> +       const char *filename = "~/.config/systemd/user/git-maintenance@.timer";
>>>> +       char *expanded = expand_user_path(filename, 0);
>>>> +       if (!expanded)
>>>> +               die(_("failed to expand path '%s'"), filename);
>>>> +
>>>> +       return expanded;
>>>> +}
>>>
>>> I was curious whether this would fail if `.config/systemd/user/`
>>> didn't already exist, but looking at the implementation of
>>> expand_user_path() , I see that it doesn't require the path to already
>>> exist if you pass 0 for the second argument as you do here. Okay.
>>
>> Do we need to worry about $XDG_CONFIG_HOME rather than hard coding
>> "~/.config/". There is a function xdg_config_home() that takes care of this.
> 
