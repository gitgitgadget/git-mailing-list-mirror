Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76064C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4092078D
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfdph6fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgHZPae (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgHZPac (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 11:30:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E69BC061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 08:30:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t7so1838679otp.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xaIyQ3bc/uzlKo0QVUWn5qTIpNGHUKOfJHw1IgctrUQ=;
        b=cfdph6fjs/Eam6KrmhgE+OGed4gJ+0v1gvRUrNTU3SwE+S4UZWma/bl0naAo+gZU+v
         XikNsxPcWkjEE2uXz1g6q7B4TQTV8Xm0qU4VCoBscE/g3hs+naLtXl7opuqNmROV3f54
         cKtmGkjyoD0SvWrMb++g6O85Ks6OTJwpZVwUhwgq4d59sHWc9EoaF87/H/T+lMYagHFE
         OVedKh3iZcau9AtsHXXN8dOXCSihVP1fI2GMSPiwAfnW9Mzwldh1IICC67SJM3aBxOT2
         7MH7emfzlbffm3frclos9LSSSnjmbP7gYBedp4CGGrdFPdpsNpP2l3ia6tnza0By2url
         2Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xaIyQ3bc/uzlKo0QVUWn5qTIpNGHUKOfJHw1IgctrUQ=;
        b=argXzn/D7ysrrU+SJoqYqYHRSapVbPx58B1DA/Ti25j8r6izGgEi9zZDLWpKjcN9iS
         x/mOGbXAVA0pdwMZVRq3BC+65/ZZRt+DTQblOwqrPusG6daWdSeU8OJZgEEpN+yfM7oU
         dipH/b3P7Y04sO1TDzGC4J3zF7gmd3+cAC1GYu4svutam5AYx6KV1Tiza894LvlaPEWc
         6oD33u3MCmgJAIZk67YTGnUoDfGmRAemTaUV1jmsr91Xy8xcfKkUya+MxgOJ+sIxAh80
         NfMNHAhcspmHU3L4TUD1NrAu4IBy3Y+ZJQ5fN+hLYWBffSbq6fdEI9fZcidumGcIO2lH
         aMYg==
X-Gm-Message-State: AOAM533sEFbi9X/oCgzjWoDqMhzZ80BvtjWEyv9uwop4wR/bnnAmYD1M
        CYtgmiVmGVd4xeFyTxaQ14U=
X-Google-Smtp-Source: ABdhPJzjZ8HAHaCM6o71dSPrYXocabC84h7zeVDoojSmyjxaX6+gOYIo432NWvR964HLNxn9L0GKGw==
X-Received: by 2002:a05:6830:1283:: with SMTP id z3mr10052981otp.51.1598455831207;
        Wed, 26 Aug 2020 08:30:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id x21sm676269ooq.30.2020.08.26.08.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:30:30 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] maintenance: add --scheduled option and config
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
 <c728c57d85b17035d42313260620a7de5756b0c3.1598380805.git.gitgitgadget@gmail.com>
 <xmqqd03ez8pp.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd4e18b7-6265-73e7-bc1a-a7d647eafd0a@gmail.com>
Date:   Wed, 26 Aug 2020 11:30:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqd03ez8pp.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 6:01 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> A user may want to run certain maintenance tasks based on frequency, not
>> conditions given in the repository. For example, the user may want to
>> perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
>> update the 'git maintenance run --scheduled' command to check the config
>> for the last run of that task and add a number of seconds. The task
>> would then run only if the current time is beyond that minimum
>> timestamp.
>>
>> Add a '--scheduled' option to 'git maintenance run' to only run tasks
>> that have had enough time pass since their last run. This is done for
>> each enabled task by checking if the current timestamp is at least as
>> large as the sum of 'maintenance.<task>.lastRun' and
>> 'maintenance.<task>.schedule' in the Git config. This second value is
>> new to this commit, storing a number of seconds intended between runs.
>>
>> A user could then set up an hourly maintenance run with the following
>> cron table:
>>
>>   0 * * * * git -C <repo> maintenance run --scheduled
> 
> The scheme has one obvious drawback.  An hourly crontab entry means
> your maintenance.*.schedule that is finer grained than an hour
> increment will not run as expected.  You'd need to take all the
> schedule intervals and take their GCD to come up with the frequency
> of the single crontab entry.  

My intention for the *.schedule is that it is not an _exact_ frequency,
but instead a lower bound on the frequency. That can be shelved for now
as we discuss this setup:

> Wouldn't it make more sense to have N crontab entries for N tasks
> you want to run periodically, each with their own frequency
> controlled by crontab?  That way, you do not need to maintain
> maintenance.*.schedule configuration variables and the --scheduled
> option.  It might make maintenance.*.lastrun timestamps unneeded,
> which would be an added plus to simplify the system quite
> drastically.  Most importantly, that would be the way crontab users
> are most used to in order to schedule their periodical jobs, so it
> is one less thing to learn.

I had briefly considered setting up crontab entries for each task
(and possibly each repo) but ended up with these complications:

 1. Maintenance frequency differs by task, so we need to split the
    crontab by task. But we can't just split everything because we
    do not want multiple tasks running at the same time on one
    repository. We would need to group the tasks and have one entry
    saying "git maintenance run --task=<task1> --task=<task2> ..."
    for all tasks in the group.

 2. Different repositories might want different tasks at different
    frequencies, so we might need to split the crontab by repository.
    Again, we likely want to group repositories by these frequencies
    because a user could have 100 registered repositories and we don't
    really want to launch 100 parallel processes.

 3. If we want to stop maintenance, then restart it, we need to
    clear the crontab and repopulate it, which would require iterating
    through all "registered" repositories to read their config for
    frequencies.

 4. On macOS, editing the crontab doesn't require "sudo" but it _does_
    create a pop-up(!) to get permission from the user. It would be
    good to minimize how often we edit the crontab and instead use
    config edits to change frequencies.

With these things in mind, here is a suggested alternative design:

Let users specify a schedule frequency among this list: hourly, daily,
weekly, monthly. We then set the following* crontab:

	0 * * * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=hourly
	0 0 * * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=daily
	0 0 * * 0 git for-each-repo --config=maintenance.repos maintenance run --scheduled=weekly
	0 0 0 * * git for-each-repo --config=maintenance.repos maintenance run --scheduled=monthly

*Of course, there is some care around "$path/git --exec-path=$path"
that I drop for ease here.

Then, "git maintenance (start|stop)" can be just as simple as we have
now: write a fixed schedule every time.

The problem here is that cron will launch these processes in parallel,
and then our object-database lock will cause some to fail! If anyone
knows a simple way to tell cron "run hourly _except_ not at midnight"
then we could let the "daily" schedule also run the "hourly" jobs, for
instance. Hopefully that pattern could be extended to the weekly and
monthly collisions.

Alternatively, we could run every hour and then interpret from config
if the current "hour" matches one of the schedules ourselves. So, the
crontab would be this simple:

	0 * * * * git for-each-repo --config=maintenance.repos maintenance run --scheduled

and then we would internally decide "is this the midnight hour?" and
"is this the first day of the week?" and "is this the first day of the
month?" to detect if we should run the daily/weekly/monthly tasks. While
it adds more time-awareness into Git, it does avoid the parallel task
collisions. There are some concerns here related to long-running tasks
delaying sequential runs of "git -C <repo> maintenance run --scheduled"
causing the "is this the midnight hour?" queries to fail and having
nightly/weekly/monthly maintenance be skipped accidentally. This
motivates the *.lastRun config giving us some guarantee of _eventually_
running the tasks, just _not too frequently_.

I hope this launches a good discussion to help us find a good cron
schedule strategy. After we land on a suitable strategy, I'll summarize
all of these subtleties in the commit message for posterity.

Hopefully, the current way that I integrate with crontab and test that
integration (in PATCH 6/7) could also be reviewed in parallel with this
discussion. I'm very curious to see how that could be improved.

Thanks,
-Stolee
