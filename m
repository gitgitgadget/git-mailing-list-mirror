Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BF81F404
	for <e@80x24.org>; Mon, 12 Feb 2018 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeBLR6C (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 12:58:02 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:32871 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeBLR6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 12:58:00 -0500
Received: by mail-qk0-f180.google.com with SMTP id c82so19393495qka.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QWsa+pP6GJ18EuVHb1hZaMG8za/Mdik9rgErxfTcBjs=;
        b=kjUId/u/cQPb+r+b2kyXK2Q0lCLYBGyAI+2+AO4XiWCPqNt9QQQANs3gvMvJEB1t9Q
         xWe7/EgM2NE7r3vElqEwL6y+A144RhqnGJ9lzC6cF17hRKF3i20r7Ho6Kj3+2fxX0Q/N
         m34ndo8uWZHPH1DvnjXNSjaOW14UqfM/1MraqVy2QltyEzLItzbM44+lEUhXlKSXb1+u
         WYY8MFagRK6MSqt+C0HEmABbXRRqnjk/e1FsIyqQPPwmFUh9I5EVBb6D5d+ybXdaMPB6
         n6IBZEGZ7js5/MTz80wMsgcoepfFXf5357PgxS+H7YODfx8OHTO2FcB8mX3OUjlRfQEN
         gP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QWsa+pP6GJ18EuVHb1hZaMG8za/Mdik9rgErxfTcBjs=;
        b=m5z/PCzBrqla7H12wUuRfVm7VWU6rh21kM9p8cWsz28oe4wLCh60U8O4avbtJEbsiV
         7gcLBzUCfWkhF8pV4Z6FB1624EWWYVjQDj0ugcgSnITPfmTnhzkvTymECPwA2taiGeBD
         vjoJBd9xTSsntfhaEGURINMMJFYdzzqFMeRQvloBbE1k1KS0bmrG4JXFLY2oA7shNn3w
         1rdo3Joo7Z4kg0TsY/ao6wJngAn14T9E7lAAMwedjjqq3NFhiurKuA+PHNC5AVrHsj+9
         kRNoRQXJB28V+/kDihhcNaPMBFze5K9lBu0ruucHP9Ybt+OWL3v8x8BrlKmj2PqmQhjX
         FN6Q==
X-Gm-Message-State: APf1xPBbxM8BY+Cg4IQ11kAhQ1BtxJTyhe6U89c7LL6Zs9i5hnn8tabA
        1Ss+LYlt3MY7QPrWKna15sE=
X-Google-Smtp-Source: AH8x225mR4Sci7ozz+PG5OKF2gOCY5ljpwAixpet6xFKzBMvkHZAWxpK6S/qGjAF6C9z528ZoTVfuQ==
X-Received: by 10.55.40.140 with SMTP id o12mr20126295qko.216.1518458279517;
        Mon, 12 Feb 2018 09:57:59 -0800 (PST)
Received: from ?IPv6:2001:4898:4070:37:dc8:5c07:f7fd:ede4? ([2001:4898:8010:1:ce5d:5c07:f7fd:ede4])
        by smtp.gmail.com with ESMTPSA id d20sm7017775qte.88.2018.02.12.09.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2018 09:57:53 -0800 (PST)
Subject: Re: [PATCH v1] dir.c: don't flag the index as dirty for changes to
 the untracked cache
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20180205195619.31064-1-benpeart@microsoft.com>
 <20180205215805.GA90084@google.com>
 <6fb43664-7546-7865-0488-8ed6292d77a6@gmail.com>
 <CACsJy8DLP=j-h3knwX9zOpejAfUbv1YJwfB-iw4476oy0hTfxg@mail.gmail.com>
 <0039c71c-cefd-4950-aa7c-ffbb7cf66e49@gmail.com>
 <CACsJy8A2=tWpiBOBxmTLHXm6bvjGCdoDEuJEy7PewvnzEQi2Qg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d1371a6c-2b30-515a-372e-4fea9bc09c43@gmail.com>
Date:   Mon, 12 Feb 2018 12:57:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8A2=tWpiBOBxmTLHXm6bvjGCdoDEuJEy7PewvnzEQi2Qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/12/2018 5:20 AM, Duy Nguyen wrote:
> On Wed, Feb 7, 2018 at 9:13 PM, Ben Peart <peartben@gmail.com> wrote:
>>
>> On 2/6/2018 7:27 AM, Duy Nguyen wrote:
>>>
>>> This is another thing that bugs me. I know you're talking about huge
>>> index files, but at what size should we start this sort of
>>> optimization? Writing down a few MBs on linux is cheap enough that I
>>> won't bother optimizing (and I get my UNTR extension repaired all the
>>> time, so reduced lstat calls and stuff). This "typically" only comes
>>> at certain size, what size?
>>>
>> It's important to identify what we're trading off here.  With the proposed
>> optimization, we'll end up doing less writes of the index but potentially
>> more lstat calls.  Even with a small index, writing the index is much more
>> expensive than calling lstat on a file.  Exactly how much more expensive
>> depends on a lot of variables but even with a SSD its still orders of
>> magnitude difference.
> Keep in mind it's not just about lstat() calls. Processing ignore
> patterns also takes a big chunk of CPU, especially when you have more
> than a couple ignore rules.

Yes, I'm very familiar with the cost of the exclude list pattern 
matching code.  I've rewritten it to use a hashmap (for those patterns 
where it is possible) that dramatically speeds that aspect up as we tend 
to abuse it pretty heavily (~60K entries on average).

>
> I'm not convinced that writing index files is that expensive for small
> files. I don't know about Windows, with Linux it seems fast to me.
> Actually, for small scale repos, performance probably does not differ
> much either.

I agree.  For small scale repos, none of this is significant enough to 
matter.  Untracked caching should help most as your working directory 
starts to get large.

>> That means we could potentially lstat hundreds or thousands of files and
>> still come out ahead.  Given the untracked cache works at the directory
>> level, the lstat cost actually scales with the number of directories that
>> have had changes (ie changing a 2nd file in the same directory doesn't add
>> any additional cost).  In "typical" workflows, developers don't often change
>> hundreds of files across different directories so we'd "typically" still
>> come out ahead.
> I agree. But we must deal with the bad case when someone
> "accidentally" does that. We should not wait until them yell up "it's
> too slow now" and tell them to disable/enable untracked cache again.
>
> Another case that could touches a lot of directories over time is
> switch trees (e.g. "git checkout master" then "checkout next" or worse
> "checkout v1.0").

You're example above makes me wonder if you understand what my patch is 
doing.  If the index is flagged as dirty for _any_ reason, the entire 
index is written to disk with the latest information - including the 
updated untracked cache and all other extensions.  So in your checkout 
examples above, the index will still get written to disk with the 
updated untracked cache extension.  There would be zero change in 
behavior or performance.  The _only_ time the index is not written to 
disk after my patch is if there were no other changes to the index.  In 
my experience, that is only status calls.

To suffer any degradation in the untracked cache would be if a user 
edited a bunch of files across multiple directories and called status 
repeatedly.  As soon as they did add, checkout, rm, rebase, etc (ie most 
git commands other than status) the index would get flagged as dirty and 
the latest untracked cache extension would get written to disk.

>> We have internal performance tests based on common developer sequences of
>> commands (status, edit a file, status, add, status, commit, log, push, etc)
>> that show that having the untracked cache turned on actually makes these
>> sequences slower.  At the time, we didn't have time to investigate why so we
>> just turned off the untracked cache.
>>
>> When writing the fsmonitor patch series which can utilize the untracked
>> cache, I did some investigation into why the untracked cache was slowing
>> things down in these tests and discovered the cause was the additional index
>> writes.  That is what led to this patch.
>>
>> I've been sitting on it for months now because I didn't have the time to
>> write some performance tests for the git perf framework to demonstrate the
>> problem and how this helps solve it.  With the discussion about the
>> fsmonitor extension, I thought this might be a good time to send it out
>> there.
> Hopefully you have time to get some of those numbers :) A patch is
> more convincing when it's backed by numbers. And I'm still not
> convinced that never ever letting untracked cache be written to the
> index again is a right thing to do [1].

I agree that any performance patch should be accompanied by a 
performance test to demonstrate it actually performs as promised.  I 
looked for but didn't find a performance test for the untracked cache so 
will have to create one from scratch.  In order to make that as 
realistic as possible, it needs to simulate (as much as possible) 
typical developer workflows, ie  create/edit files across multiple 
directories and then execute various common commands (status, add, 
status, add, status, rm, status, commit, log, rebase, etc) and time the 
performance of that sequence of commands.  All doable, that just isn't 
supported well in the performance framework yet so will take some time 
(much more than the actual patch :)).

>> If you have the cycles, time a typical series of commands with and without
>> the untracked cache (ie don't just call status over and over in a loop) and
>> you should see the same results.  Given my limited time right now, I'm OK
>> putting this on the back burner again until a git perf test can be written
>> to ensure it actually speeds things up as advertised.
> [1] Another case that we must _sometimes_ let untracked cache be
> written down is to correct its data. My last invalidation bug, for
> example, could leave the untracked cache in a bad state, when you run
> with new git then it should be able to correct the data and write
> down. But if you don't allow writing down, the new 'git' will keep
> seeing the old errors and keep complaining.

