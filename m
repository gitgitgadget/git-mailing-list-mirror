Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25573C636CC
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 17:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBKRjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 12:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjBKRjo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 12:39:44 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E22712
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 09:39:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id co8so4471502wrb.1
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNDTc/z81WDbzOAKWboDNietqvaL3zbvUmC5KF/br9Q=;
        b=nXcUDncWW2SXn0Z9PGeAlZRUxef/08lHc0gIp3NcOezBQ81UbmE50aERYJ7SF7Q3jZ
         jFBd42EGhwn8WALlQb0lRAc75gLrYBxVefxhDhYbmkTIULGCusbnQcSQ5Pz4wNxCAxAH
         3Rrif9gK0ZbHVr1hMKiCYbRrUh0XV6p9jGZWcX+vV/+XepiQVN4YLf3yIeg/qxOPhU+o
         hYc3hl+hJRmr/vCID/AnRmw8ulbFkarF0GuzayvETGLK3UCvIF4CzD/4WHFxSuPHArUU
         hdBYMw5b3dJp/RZB2/RDmNnk+t/Z1ShFucYisY+5wANZCnP6XJtK+5YQMorua2+rq0Gd
         IDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNDTc/z81WDbzOAKWboDNietqvaL3zbvUmC5KF/br9Q=;
        b=AXEnu0p2c12WFyPX54btwCZN3Rql292OzoMAcvgOTuvmEg3HMf08l0VuXWoYNhp/ee
         2mXHBvLOtQqgYXnPCov/Nn2fh0RuRBQEBdus37VAxGuKL/e+3vuc6qoAv9I9vQPkxauI
         XOiG/1U/u4UAAeWmnQdk40MYsd75WjQHugJeQ0gYTsUYZq1k/vs6sMuM8ApvSSaIGOI3
         fa92Rz99vOFUki3ONGuUt2K15vsCCkQDYsafa2sTisj9+WE8zGq/SvwsN11ZycGvPX2J
         IULfjgmKBfbvk+/vVs0+qXYdpvjnM1aYyuUUSkU0gefLIIY7aq+3GV5gKlwndJgnf4Jd
         wf9w==
X-Gm-Message-State: AO0yUKXAOMOd/DxbuDE/nOF5ieIfQPgOidWM/jRqusslFu2SlvEnyzy8
        3gDudRfELr7N2CbVQ9k4vhg=
X-Google-Smtp-Source: AK7set+hHnN6X81N6dKvCCjECHkepxEOCqRyDklypw2wTqsJXhLzlEHDaLXsWIjBaC3tg4G+NttV9A==
X-Received: by 2002:a05:6000:12cb:b0:2bf:c9e2:770a with SMTP id l11-20020a05600012cb00b002bfc9e2770amr18423960wrx.2.1676137180473;
        Sat, 11 Feb 2023 09:39:40 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d68d2000000b0029100e8dedasm6509938wrw.28.2023.02.11.09.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 09:39:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <37a89e67-23f0-83f7-aaa5-0199d5db3adb@dunelm.org.uk>
Date:   Sat, 11 Feb 2023 17:39:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai <johncai86@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
 <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
 <CABPp-BHQDS+AzWXtk9WV4HY2QZ8UdXrWJJDr-y6VPoLB6HuAfw@mail.gmail.com>
In-Reply-To: <CABPp-BHQDS+AzWXtk9WV4HY2QZ8UdXrWJJDr-y6VPoLB6HuAfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 10/02/2023 09:57, Elijah Newren wrote:
> Hi Phillip,
> 
> On Thu, Feb 9, 2023 at 6:44 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> On 09/02/2023 09:09, Elijah Newren wrote:
>> I'd support a change to either patience or histogram as the default
>> algorithm. My personal preference would be for the patience algorithm as
>> I think it generally gives nicer diffs in the cases that the two
>> disagree (see below, I've tried changing diff.algorithm to histogram a
>> few times and I always end up changing it back to patience pretty
>> quickly). However I can see there is an advantage in having "diff" and
>> "merge" use the same algorithm as users who diffing either side to the
>> merge base will see the same diff that the merge is using. The histogram
>> algorithm is known to produce sub-optimal diffs in certain cases[1] but
>> I'm not sure how much worse it is in that respect than any of the other
>> algorithms.
> [...]
>> [1]
>> https://lore.kernel.org/git/CAGZ79kZYO6hHiAM8Sfp3J=VX11c=0-7YDSx3_EAKt5-uvvt-Ew@mail.gmail.com/
> 
> Thanks, I might have a fix, though I'm a bit worried my tweaks might
> trigger issues elsewhere or cost a bit of performance; I'll need to
> test.  Are there any other good known testcases where histogram
> produces sub-optimal diffs?

Not that I'm aware of (I've a feeling there might have been something on 
the JGit mailing list but I only managed to find a copy of Stefan's 
message). Loosely related is [1] which talks about hash collisions and 
I've never found the time to look at properly. I suspect any hash 
collision problem is more likely to affect xdl_classify_record() which 
is used by all the algorithms.

>> To see the differences between the output of patience and histogram
>> algorithms I diffed the output of "git log -p --no-merges
>> --diff-algorithm=patience" and "git log -p --no-merges
>> --diff-algorithm=histogram". The first three differences are
>>
>> - 6c065f72b8 (http: support CURLOPT_PROTOCOLS_STR, 2023-01-16)
>>     In get_curl_allowed_protocols() the patience algorithm shows the
>>     change in the return statement more clearly
>>
>> - 47cfc9bd7d (attr: add flag `--source` to work with tree-ish, 2023-01-14)
>>      The histogram algorithm shows read_attr_from_index() being moved
>>      whereas the patience algorithm does not making the diff easier to
>>      follow.
>>
>> - b0226007f0 (fsmonitor: eliminate call to deprecated FSEventStream
>> function, 2022-12-14)
>>     In fsm_listen__stop_async() the histogram algorithm shows
>>     data->shutdown_style = SHUTDOWN_EVENT;
>>     being moved, which is not as clear as the patience output which
>>     shows it as a context line.
> 
> If my current changes are "good", then they also remove the
> differences between patience and histogram for the second and third
> commits above.  (And the differences between the two algorithms for
> the first commit look really minor.)

Interesting. I agree the differences for the first commit are small. 
Interestingly I think they come from patience algorithm falling back to 
the myers implementation because it cannot find any unique context lines 
(I have a patch that removes the fallback[2] and it gives the same 
result as the histogram implementation).

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/4e0eff48-4a3e-4f0e-9ed2-d01ec38442a5@www.fastmail.com/

[2] https://github.com/phillipwood/git/commits/pure-patience-diff
