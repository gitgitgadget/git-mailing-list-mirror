Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212AEC61D97
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 17:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbjA3RnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjA3Rm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 12:42:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D7C146
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 09:42:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so11798316pjb.5
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 09:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qLrDVPIKXVUJ4c3a749f/prnF50Iix2lQbcdsg216o=;
        b=FqR8+pTSz9/Gl18i0T/9jzWrRJtx5dewG4maG6sSag//WBOrjYtYVtdG47TtVr/T7x
         gwjxXVnOyIj/aIp768LuYipbM8trI3vYLqhVMYlnhJl9OJqEXFxXkwx5TpEc4UyoqfYN
         vgf+bw2yhSz0MptQ5IGGX+uEEufUpiSikrjCn9m3DI7n7TQa0VSl1FS4aJ6c1Bb0k3sS
         b08NaHzLv5vOM56tB8U49xHZmU+jsHPec/UdpLiRx0BDnBxkPbyYNbte8t0FXKra0EpF
         hgob4T77rjCYl/fllDfS6xQDOwYM/4kaVm6dBSd/iNq0GSDkR/17QRbBDY6aQ9b1EbYT
         yXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qLrDVPIKXVUJ4c3a749f/prnF50Iix2lQbcdsg216o=;
        b=QRoArEm0Bcdw69X+6wdaiBbG1ths9TS8pYxgR4+tAa3m0CRC58+/hqYna2ScHzrR5z
         ECFetiQs8AGdpZkhYe29ZkOAsGi4d9xHOjz9mVUv62cSdxS9XVERsGqBE7GAhQhI48Tv
         lD3gMTk5vIUtoZY9oPTGeWN2ak0xQJ+ngm1PPyYFNLUHqU5nlgGjRdOpbX6HcMg58m3G
         NPCpJOX3Rqg8AdXs6EaCsxEj/qfY/LPYvWxJnG4EQtXDobS2tVdhrYpEJeHt5aANA6ny
         5CfSTcdlpXJWH3Yn4GIK94MpldBmInmGQUE7IUK7FUm7OQ0xuvg3Wv5/LbvW4r7jQ4+3
         f+yw==
X-Gm-Message-State: AO0yUKWmXSVJBSh20boMN4XL/ihqp6MKq1rl4sRPRCmIim8Ta4YD1Xmb
        /owFj79DpIjde+7zhgkMlh6o
X-Google-Smtp-Source: AK7set83EmC++qm0JWL2f8cHn/pn8ij/U295VjoPBqXFazrOpwoAtfzDrXT3oFGj6oZYhRwccnDL7g==
X-Received: by 2002:a05:6a20:6721:b0:bc:8254:ddff with SMTP id q33-20020a056a20672100b000bc8254ddffmr8945526pzh.1.1675100577447;
        Mon, 30 Jan 2023 09:42:57 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id s8-20020a63af48000000b0046b1dabf9a8sm6885580pgo.70.2023.01.30.09.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 09:42:57 -0800 (PST)
Message-ID: <db04e31d-681f-5809-f51a-37b9c734b45a@github.com>
Date:   Mon, 30 Jan 2023 09:42:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <xmqqleln90ka.fsf@gitster.g>
 <4913381a-769f-aba0-c04d-559d103e8396@github.com>
 <xmqq357v8poc.fsf@gitster.g>
 <b63611dc-a889-8900-403a-ec7c42a89705@github.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <b63611dc-a889-8900-403a-ec7c42a89705@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 1/27/2023 7:32 PM, Junio C Hamano wrote:
>> Derrick Stolee <derrickstolee@github.com> writes:
>>
>>>>  The "maintain
>>>> their clone" certainly should include running periodic maintenance
>>>> tasks without them having to worry about it.  It feels like this is
>>>> calling for an explicit "disable periodic maintenance tasks in this
>>>> repository" option to help these esoteric environments that disable
>>>> cron-like system services, while keeping the default safer,
>>>> i.e. fail loudly when the periodic maintenance tasks that the users
>>>> expect to happen cannot be enabled, or something.
>>>>
>>>> Perhaps I am not the primary audience, but hmph, I have a feeling
>>>> that this is not exactly going into a healthy direction.
>>>
>>> Here, we are in an environment where background maintenance is
>>> unavailable in an unexpected way. If that feature is not available
>>> to the user, should they not get the benefits of the others?
>>
>> That is not what I was saying.  I just have expected to see a way
>> for the user to give scalar an explicit "I understand that periodic
>> maintenance does not happen in this repository" consent, instead of
>> demoting an error detection for everybody to a warning that users
>> will just ignore.
> 
> Ah, so you'd prefer a --no-maintenance option for users who have
> this problem instead of just a warning. I'll do that in v2.

I mentioned this earlier [1], but I want to reiterate that I really don't
think a dedicated '--no-maintenance' option is a good approach to this
problem. I understand wanting more active user acknowledgement that "I
understand that periodic maintenance does not happen in this repository";
without that, users may (rightfully) be confused when they find their
scalar-cloned repository full of loose objects. But, in the use case you've
presented (where no scheduler is available), the user would need to -
somewhat redundantly, I feel - acknowledge that for *every* repository they
clone. 

I'm also still worried about cluttering scalar's UX with options that toggle
use of its internally-configured options and features. One of the big
selling points for including scalar in the upstream project ([2], [3]) was
its ability to "intelligently" configure all of the settings a user would
need to optimize a large repository *without* a user needing to know what
any of those options are/what they mean. These settings are inherently
subject to change (due to use of experimental features); exposing a feature
toggle entrenches that setting permanently within scalar and makes a user
aware of implementation details that were intended to be hidden. At a high
level, it pushes scalar towards simply being an "opinionated" 'git
config'-configurator, which was a model I explicitly tried to move away from
while upstreaming last year.  

I still believe treating maintenance like FSMonitor - pre-determining
whether the feature is available and only enabling it if possible - is the
most consistent and user-friendly solution to the given problem within the
context of scalar. But, if you feel that user acknowledgement is absolutely
critical, I'd strongly prefer a config setting like 'maintenance.enabled';
it could be set globally (the appropriate scope in the case of a system that
has no scheduler), or with '-c' with Scalar clone if it really needs to be
per-repo.

[1] https://lore.kernel.org/git/3ade6d9f-8477-40c2-d683-d629e863c6ab@github.com/
[2] https://lore.kernel.org/git/pull.1005.git.1630359290.gitgitgadget@gmail.com/
[3] https://lore.kernel.org/git/pull.1275.git.1656521925.gitgitgadget@gmail.com/

> 
> This could be a good time for me to upstream the --no-src option
> while I'm messing with arguments in 'scalar clone'.

For what it's worth, my concerns about option clutter don't really apply to
'--no-src' (cloning directly into a given directory, rather than
'<directory>/src'). Unlike features like FSMonitor and maintenance, the
'src/' directory is a user-facing Scalar design decision. It's also
something that seems to exist primarily for backward-compatibility reasons
(if I'm interpreting your earlier comments [4] correctly). This could be a
step on a deprecation path to make '--no-src' the default and remove the
legacy enlistment structure? At the very least, it's sufficiently outside
scalar's "configure for a large repo" scope for me to not worry about it
setting a bad precedent.

[4] https://lore.kernel.org/git/82716e5b-3522-68f5-7479-1b39811e0cb2@github.com/

> 
> Thanks,
> -Stolee

