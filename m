Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F42CC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiKHACI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiKHACE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:02:04 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447A6451
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:02:03 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z3so10275580iof.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ot1GWLIzWzEww3LumRZN15Sj45EGKxzpygl6r4ccteU=;
        b=DXMqyVosWdzeiG3aLG0Yz8RTPxPG8rDSOe08bCRhX7h1m/UtkPvRgFA0TkVYnzeMfa
         AyG1BlyXw1eC0tTPVNUYrZ0100N1vEUwG9RG4Wpc9mJaM7mS6jgej7/TEcA0NdJHl2CZ
         mJtuMa8KZxEw5JWRbPSUho2Nk6ji5W9GsymPsI8/1SBzwGgPvtaliaFNDmcVe3CGqnEh
         FwxgASPxM6zHYaVOEwJ7ZuUVIgElBq4uDWcFAwRFPozBUh+YMlry/6i2iVq5aWz0S7Vg
         fGe/mpv89ir8HO0ERhIS8Fkh5Yxt08MPKP9g6nNsyQa/uEDBD+Ji1Rb6Zl3f7P8Ky8wh
         ptrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ot1GWLIzWzEww3LumRZN15Sj45EGKxzpygl6r4ccteU=;
        b=tLaXsuE22QOrby/i9TjOzNMCWsQZyNk7VyJ8AtgPae/sE82Xr5IMBoYoRtj3vM99PK
         8tc3DwpRNrZNPs72JCtXCr6lKFXENu/riEOOSeJK8uWJnog0xUKtszQLb36HN1aH/BKr
         RedzwXhyNY/nK/fB/J+ghpbgrZW8LRQoxC5WUNwbTlWGAEiB1+ml+7UXZHO5MI5XgAtQ
         04umqhoEivdk6sSYIxkPRm/XEFcFtAVzPALm0mp5c4rOmETCt/MfYZ9m6xV6cctOxwEy
         nfnRj8maZ+ZxIq50WqhYVWEpNRkgZ4STejR+aokLI7kJUsYlNrQVRDVoocxfQNvqgt2H
         ELuA==
X-Gm-Message-State: ANoB5pkymDxkl1lMI3dEhmEdgo8PG4VsQ3TEN965yo2/b/6rVeLG6s3G
        DNhHKrNPLRmMRkTsAY25oKF9LHJz3/ykGtc=
X-Google-Smtp-Source: AA0mqf7nJ1GUKQPiOamlFqOnQXe7Fb4PBtYmzcb2z8FFBl31uGGlevMRF2wDPHrizOx73l2x5LOPqg==
X-Received: by 2002:a6b:b80a:0:b0:6dd:3f5a:32d6 with SMTP id i10-20020a6bb80a000000b006dd3f5a32d6mr237507iof.154.1667865723107;
        Mon, 07 Nov 2022 16:02:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:4981:637:22c8:3f52? ([2600:1700:e72:80a0:4981:637:22c8:3f52])
        by smtp.gmail.com with ESMTPSA id z64-20020a0293c6000000b003739e4d381esm3268008jah.141.2022.11.07.16.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 16:02:02 -0800 (PST)
Message-ID: <e185dc68-4a01-da57-8c68-a14448f9173f@github.com>
Date:   Mon, 7 Nov 2022 19:02:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ci: avoid unnecessary builds
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
 <Y2liOzOFLyz4uzd0@nand.local>
 <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
 <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
 <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
 <221108.8635autlha.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221108.8635autlha.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/2022 5:56 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 07 2022, Derrick Stolee wrote:
> 
>> On 11/7/22 4:03 PM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Mon, Nov 07 2022, Derrick Stolee wrote:

>>>> Either of these points may have an incorrect assumption, so
>>>> I'm prepared to be wrong.
>>>
>>> I *think* you're wrong about #2, but I'm not sure either.
>>
>> At the very least, the configurable option requires fetching the
>> repo and checking out at least one file. I don't know how much it
>> actually saves one way or another.
> 
> It's already fetching the ci-config repo, so we're talking about the
> marginal cost of running the bit of shellscript to check if
> config-repo/ci/config/skip-concurrent is executable, and if not keeping
> the default config.

>> I wonder how we could determine this. Should we run a few CI
>> jobs with some force-pushes in either approach (config turned
>> off) so we know that cost?
> 
> The incremental cost of that "test -x", or...? I'm not sure what you
> mean here.

The difference is that setting the concurrency globally allows
Actions to decide the concurrency from the workflow file alone,
before any jobs are run. This is done without a clone.

The method introduced in e76eec35540 (ci: allow per-branch config
for GitHub Actions, 2020-05-07) requires running the ci-config
job at minimum to set the concurrency value, which involves doing
a (very small, shallow) clone of the ci-config branch to determine
if that file exists.

Since this is the first job to run in the workflow, the global
concurrency will only reduces the amount of compute consumed
when pushes happen close together, but that is included for "oops
I forgot to --amend" and other common cases.

At the very least, the difference between the two mechanisms is
greater than a 'test -x'.

Thanks,
-Stolee
