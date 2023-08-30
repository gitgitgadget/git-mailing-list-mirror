Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358FFC6FA8F
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjH3SaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244627AbjH3NfO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 09:35:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5240311F
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 06:35:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso4978990f8f.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402509; x=1694007309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gO3s4wMDBiQKur+uX8iK+a1yGKnNfhN+D/SrqxeUeJA=;
        b=Hx47sBkUpP5o1Je/EobpHuGjJJd3kxVuM5T8ksNA3akG+NjUceSBVgww7wzRHD6yT2
         ozNkk/tFBdLkbLqzx/wMqJ4C2yiVxR0YVzgAwD/xSJhFN3iM7A90VR8CskLdZFgzRxeB
         hMIgQ9xb9HQjrIik+RHlZvgsU38mYwRhK06xjqvuy0y/ERVJOzncAjYRumz0CHb5JLa3
         piGQC1vQEQPtnpS+k6hBYv524UToelK1q1YLGNkkiIdlv9ttng0GFcZWQ43P9ayXSBw/
         uDixzQB3bOeZO+MrRoiyZCHeaLOU/aBRnZ7ElpH9ZipDmt0XPqm81arJ0qe/KISPbzPs
         E/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402509; x=1694007309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO3s4wMDBiQKur+uX8iK+a1yGKnNfhN+D/SrqxeUeJA=;
        b=grJRhaUXUy84LB41hLXY4ZV4hw7qBd9Vl/oMOd4DyATEs8yIW1LqxLQTmFVXwBeGvF
         WlwT+cOhn4XlKQvX0QNvbh02aji+D9ynutf/OPT31d5mchSKyzYlyUFMDXiSO3ouUYyT
         4P+uwO7B59APjoZ9ZLrDwauHZUl8Dv/Ux07JjbiAMrxZiR14ZKDqV8uXyH7P7AIrgrba
         4CBF32L46S2Vsz4pO7pEVcg8WBI1zL2lCldCxqvyHWB8KO+0tkNzFxS675/UvbIlKR/E
         L6Q4VFu4fHdcuitUxtvjsm3eAQJNSmEh1l3kkIo1MdE+0KdgA7GgXLYty6cYaq2kM+Bq
         fhbg==
X-Gm-Message-State: AOJu0Yy6qlw/1mvlBADZHRPuUlKOBV8ts/5U9FLI+9cvOhI7a7FyIJSR
        WM0c8diJGpHgaqmf+svv/po=
X-Google-Smtp-Source: AGHT+IHAb4hh+TszHRSZ64ArKfiddWMhhgvPsO8AiByvDnG97KLhVOKxYTLzpy5fKHRG3gyuTvRHQA==
X-Received: by 2002:a05:6000:114e:b0:31c:804b:5ec3 with SMTP id d14-20020a056000114e00b0031c804b5ec3mr1599413wrx.67.1693402508418;
        Wed, 30 Aug 2023 06:35:08 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id h4-20020adffa84000000b003197b85bad2sm16745757wrr.79.2023.08.30.06.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 06:35:08 -0700 (PDT)
Message-ID: <48d7763b-2661-48af-8e64-00178de612ed@gmail.com>
Date:   Wed, 30 Aug 2023 14:35:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 02/22] sequencer: mark repository argument as unused
Content-Language: en-US
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
References: <20230828214604.GA3830831@coredump.intra.peff.net>
 <20230828214717.GB3831137@coredump.intra.peff.net>
 <e65c93ec-0221-492b-b538-450b60cf1e59@gmail.com>
 <20230829233252.GA225495@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230829233252.GA225495@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/08/2023 00:32, Jeff King wrote:
> On Tue, Aug 29, 2023 at 04:55:30PM +0100, Phillip Wood wrote:
> 
>>> We could change the path helper to use REPO_GIT_PATH_FUNC(), but doing
>>> so piecemeal is not great. There are 41 uses of GIT_PATH_FUNC() in
>>> sequencer.c,
>>
>> Wow, I knew there were quite a few but I hadn't realized there were that
>> many. Changing them all to take a struct repository will be a big change and
>> will make struct repo_cache_path a lot larger.
> 
> Yeah. One of the things that gave me pause is that some of them may need
> to be renamed, as well. Most of the existing ones are static local
> within sequencer.c, so names like git_path_head_file() are OK. But
> REPO_GIT_PATH_FUNC() requires a pointer in the global repo_cache_path,
> so the names need to be appropriate for a global view.

It's definitely worth leaving that for a separate patch series. A lot of 
the paths start rebase_path_... (I think it is only the paths used by 
cherry-pick/revert that start git_path_...) so we'd need a separate 
macro unless we renamed them. Having a different prefix is probably a 
good thing for making them global functions but it still leaves the 
problem of renaming the ones like git_path_head_file().

Best Wishes

Phillip
