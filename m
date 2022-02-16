Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C10C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiBPN7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:59:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiBPN7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 08:59:11 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F21B20207A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:58:59 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h16so2291923iol.11
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c2ZCVg3nuwgUr+HmZQ1BCx05tXRe3VuLnIRAp0IVCTs=;
        b=I9kDA4KKiEuyG5XkBGQtvv7hwotfVFwHGXfpiv6OEQJSysr8MQ8kFmKfpbvf1vx2Sq
         xq5I6hoqT9DOu4+pjpj/AK7CukMnyPlDi1xoa/dCaeOo4ccmOADdMM36WQUJn4pmmfRQ
         x3hO26R8HooIGvhiID2G68HJGNB87ewf2ds3s/3WZrZncFCr3x7jBhvH9rl7IloMdyH2
         Qn8klgE5I7vPBE1NYc8OMGbKcqQSV7LPgdPxLka1W1wMCycfFKatLCfQXl3htDlwRnKc
         sa6S/95HkHVPQHVWQlA86/qo/rTLS3ptJhEuLs7FR0pAwdsAdTdiC1o4pOxA+arZi1yS
         cA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c2ZCVg3nuwgUr+HmZQ1BCx05tXRe3VuLnIRAp0IVCTs=;
        b=BDT/G9uQp23tIUbvJrho/gXlQwpH2Cadt/KbEPLXNdBPOiqR+C/rGMDLFadxe7SZA/
         VfsvtTjupIORKqG3qfl/LoLlyvoa/CBM1HO36L77TQ/Jzn1ObEZ+azUEeKVO1b7ZSpGN
         W3HoNLXxGMLGpsniJ/tGpX8YDgtz0xXAcAOUd6zzh7xsFo9s+5oedaezZXKzGsEXFbJ9
         CrnSKqFCVQlCs5FtqbUnZQ/IHXBkNs2LRdr1mxj+w8ShzLa4sLUaO6fJ1zqZpxR1W5ka
         11RtMl9O0Dgeo52LNBGwjvLmvN3HcD0DhS4cQaTp/iqUa5rEhTgaPVDRJLN6+xM5cTn9
         8j9g==
X-Gm-Message-State: AOAM531SJELwBVJ/zxd/IlVmR/JJ3oGk9nw+3KEsXYvS/r0qvicqc7GM
        dx6hoiUTvQIpvXNwivZjK3YX
X-Google-Smtp-Source: ABdhPJwJQckU5eOy25URrM7Q7CIF8BZY4mptL3ZCT/NMi8xXftu91tdcb40gttT497ZR51jLVF/D2g==
X-Received: by 2002:a6b:c905:0:b0:63d:a716:2684 with SMTP id z5-20020a6bc905000000b0063da7162684mr1904066iof.114.1645019939027;
        Wed, 16 Feb 2022 05:58:59 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 5sm16873265ilq.59.2022.02.16.05.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:58:58 -0800 (PST)
Message-ID: <3769f426-6263-527b-be46-986ad0904cb4@github.com>
Date:   Wed, 16 Feb 2022 08:58:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config
 on add
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
 <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
 <CAPig+cQOieO3cmZv42G_8XRiMwkh4v3cO1AYg5VR9SiPNMwxhw@mail.gmail.com>
 <93747eca-08d6-0be9-08c7-42c81340b788@gmail.com>
 <CAPig+cS6Of=1OOw-6MOCBJVW6_FxtGw_ciUR=RTYakdy=1Z_hA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPig+cS6Of=1OOw-6MOCBJVW6_FxtGw_ciUR=RTYakdy=1Z_hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 5:01 PM, Eric Sunshine wrote:
> On Mon, Feb 7, 2022 at 9:30 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 2/6/2022 6:30 AM, Eric Sunshine wrote:
>>> On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>> +               git config --worktree bogus.key value &&
>>>> +               git config --unset core.bare &&
>>>
>>> Why is this being unset? (Genuine question. Am I missing something obvious?)
>>
>> I'm moving it out of the common config file. Earlier commands
>> enabled it in the config.worktree file for this working tree.
> 
> But won't the `git worktree add` commands which immediately follow
> this bit automatically drop `core.bare=true` from the common config
> file? Or am I misthinking on this? Or are you just trying to be
> explicit here with the manual removal?

Ah. Here we are testing that bogus.key gets copied from the
config.worktree file, but core.bare and core.worktree do _not_.

This is kind of like the case where we run two 'git worktree add'
commands in a row. The first one moves core.bare and core.worktree
into the config.worktree file. The second one attempts to copy the
config.worktree file into the new worktree (but must filter out
these config keys).

Thanks,
-Stolee
