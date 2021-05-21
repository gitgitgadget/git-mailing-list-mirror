Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3134C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B85476135A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 10:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhEUKFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhEUKEp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 06:04:45 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D6C0612F2
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:59:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f22so6174915pfn.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bS+oaoc1Hxw/4djmPgx0BV5MEmKCjmhLTde9JpyBbjo=;
        b=AzT0b38iJ2gy9gvwMs1NvYQVyi0fR45+EN/OAGRTzvHHO3GY02s5dnqPndoglBje6K
         OM0B//qIWnIWYKbHCw/zdFHrs/APVYe2qhZ/ZF35VGvvsU6gtuLkyYtQU49Vowmam6We
         PDy6deOczmQs7jBfzfsz2iEcFUL4rZOW83Qh17pGTGHYgxJFzri6l2qiiYgH40vd6AgA
         yrUzD0s/gunnELISuw72pgTi9VMpS7gY+D83neg/ER/qGn5aiDegJ+ral+LCzJMXsP9L
         rFfWViBZtrzHkZBpvKucD4vR6miCVP4Y1yfkYl6C+c8lgPSabHfCyojiKW2EHSLOhHM0
         dCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bS+oaoc1Hxw/4djmPgx0BV5MEmKCjmhLTde9JpyBbjo=;
        b=qwn80MUFJRnrUkgQH6tOvVt8DyxTM8/sYeHdEtDsVb3npaOgsRhsk9UQbopH94FHD6
         lg5hjt6A5E20BcHPt3EV/r2YEKwlBZOTLT6LmGpgM6eX0r6nXp+hH1ja4hh5q8/WmL8u
         4VZmLX6CBgutH4pvIHaRBrDIqEIxYaULnhvfYcK/ehxQ7aHEskQNu3oagYbXe8ZILQl9
         x068YNf39V+jqPKGlwRzOuYb0CfoP4cWH71hj1a2eWoWnvV0nMSCwOxL/w6lw6HmEP/u
         G70fpSdNTHC8A9G8+jgm5mI0W1iSBcMEms1eJ3AZt7orf9sffMRMwjKBKiQ6VcbDbynY
         vkPA==
X-Gm-Message-State: AOAM530bQo0zwBqvoAwERSazAqBRnkbMtwaHo/+mHbtna5NkPooH8CUK
        6Iml6fOA8W02/8p0Y7qzXeC/mqkrHf48cnwC
X-Google-Smtp-Source: ABdhPJy3p7PtS/Qk5fh9XqtX/kkD3gVbcYueXCzUO9pUyGiP9zK5FMESa/0zHW3Qhcwt8MEZjiVpEg==
X-Received: by 2002:a63:2686:: with SMTP id m128mr8898467pgm.406.1621591170867;
        Fri, 21 May 2021 02:59:30 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-41.three.co.id. [116.206.28.41])
        by smtp.gmail.com with ESMTPSA id jz7sm8568430pjb.32.2021.05.21.02.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 02:59:30 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] maintenance: optionally use systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210520221359.75615-5-lenaic@lhuard.fr>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <715d8115-641b-5c06-d514-36911eb169ef@gmail.com>
Date:   Fri, 21 May 2021 16:59:26 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520221359.75615-5-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/05/21 05.13, Lénaïc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
> 
> The main motivations to implement systemd timers in addition to cron
> are:
> * cron is optional and Linux systems running systemd might not have it
>    installed.
> * The execution of `crontab -l` can tell us if cron is installed but not
>    if the daemon is actually running.
> * With systemd, each service is run in its own cgroup and its logs are
>    tagged by the service inside journald. With cron, all scheduled tasks
>    are running in the cron daemon cgroup and all the logs of the
>    user-scheduled tasks are pretended to belong to the system cron
>    service.
>    Concretely, a user that doesn’t have access to the system logs won’t
>    have access to the log of its own tasks scheduled by cron whereas he
>    will have access to the log of its own tasks scheduled by systemd
>    timer.

For gender neutrality, we can use he/she instead.

>    Although `cron` attempts to send email, that email may go unseen by
>    the user because these days, local mailboxes are not heavily used
>    anymore.
> 
> In order to schedule git maintenance, we need two unit template files:
> * ~/.config/systemd/user/git-maintenance@.service
>    to define the command to be started by systemd and
> * ~/.config/systemd/user/git-maintenance@.timer
>    to define the schedule at which the command should be run.
> 
> Those units are templates that are parameterized by the frequency.
> 
> Based on those templates, 3 timers are started:
> * git-maintenance@hourly.timer
> * git-maintenance@daily.timer
> * git-maintenance@weekly.timer
> 
> The command launched by those three timers are the same as with the
> other scheduling methods:
> 
> git for-each-repo --config=maintenance.repo maintenance run
> --schedule=%i
> 
> with the full path for git to ensure that the version of git launched
> for the scheduled maintenance is the same as the one used to run
> `maintenance start`.
> 

Wouldn't it be `/path/to/git for-each-repo <options>...`?

> The timer unit contains `Persistent=true` so that, if the computer is
> powered down when a maintenance task should run, the task will be run
> when the computer is back powered on.
> 

The title for this patch implied that users running Linux can choose
between classic crontab or systemd timers. However, the intent of this
patch is we add support for systemd timers. So let's say the title
should be "maintenance: add support for systemd timers on Linux".

-- 
An old man doll... just what I always wanted! - Clara
