Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB3C7619A
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 20:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjCVUHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCVUGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 16:06:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2C6A1C3
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:01:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t15so18298186wrz.7
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679515255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpV/1Hb9VhXfATvAE6ajBMiRJJpMRdbiA6FtbP53kqg=;
        b=hX2/W2qLht5D+ptMfd327etFdmyA1MgB2xhTD0hh6dv8LhCtta1PKtJyrcVnqKbCwY
         SmGs4fYPtYPtYJ9vL4sq37uxKN/e48sj+LeVxKokWo5DbSR6W8QYuxx7aLMMWIx3Rhg9
         kP59QHYbmSaS0VHPZtbDw2McfFsvJxtSJaGYFaTkxmsPLP0Tb/nPPER9NrhacWT+4uKq
         /EjYLzpDsgz0+JoLS67pVhHZEqpWmuUJ5hulCO9lhnPYxrcbxrhWmEe9jcvxs/qX4uOf
         AlHvyTu5qP4EWb96kdoPBmNpKXHNLRADABd/gZqhQfFYHqAMn4tb4PU75Dw4pfxwXtka
         vlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpV/1Hb9VhXfATvAE6ajBMiRJJpMRdbiA6FtbP53kqg=;
        b=RcUfhT8KPdaD7PPYJ7qgcSqGdo4TwM3poMAJXvTYXUzUUBxwlwE2vDbc/kfeweR/pU
         5FX+ulKOcGDI0xYD2OsDoL6wIbyb2nbz5JIvQ0kffqu5QN31z9LUGZdshQy/ftLfaPxt
         1flaFfwA6GhwUt1NT9re36UztADCIlTI8WSuY+wenwFyUOQ5+mRP5jXX8sWXg4nBzxqV
         MsOvMKEYstTAyPhOYZz3mAiI52apLlFqx7GV0ZOf3zeeCTvp0i96Jw8H0xPwet3STeEx
         hDXJAGRtF8kuMWo0iQ/ZYSiGjB+AKut6OXVbFEPc1y6PsTKrFebyDXnu1uq4vCADTnH1
         GpKA==
X-Gm-Message-State: AAQBX9cnRjvu6wOLpDQGy4b6waPyagKT719HMC18evOLTCqDAwYBELMp
        mLz8QoTiKLDxQHmGP5+tNFsPYq/A+tSJdKBL
X-Google-Smtp-Source: AKy350Z0mgV3GbacHT77v2moOM4lGNqB0IzJ2mRmHKz/7EvjTRVXfJ+El3mUOXNtqldjdvdNrIJsDA==
X-Received: by 2002:a5d:48c1:0:b0:2cf:6089:2408 with SMTP id p1-20020a5d48c1000000b002cf60892408mr538198wrs.0.1679515255324;
        Wed, 22 Mar 2023 13:00:55 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8346:b700:58e5:1401:e322:878? ([2a01:cb19:8346:b700:58e5:1401:e322:878])
        by smtp.gmail.com with ESMTPSA id n17-20020adff091000000b002c5534db60bsm14604086wro.71.2023.03.22.13.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 13:00:54 -0700 (PDT)
Message-ID: <bd5207a0-9783-6a15-93da-0904ecd21341@gmail.com>
Date:   Wed, 22 Mar 2023 21:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] Fix mem leak in branch.c due to not-free newly added
 virtual_name variable
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        ctmbl via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
 <27f27f3afd76fc974350c0c94e20307879eead84.1679478126.git.gitgitgadget@gmail.com>
 <xmqqmt44enj3.fsf@gitster.g>
From:   Clement Mabileau <mabileau.clement@gmail.com>
In-Reply-To: <xmqqmt44enj3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22/03/2023 17:52, Junio C Hamano wrote:
> "ctmbl via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: ctmbl <mabileau.clement@gmail.com>
>>
>> Previous commit introduced virtual_name variable which is the name of
>> the branch in case it has been a remote ref (used to check whether the
>> user simply forgot `--remote` flag) but didn't free it.
>> Call FREE_AND_NULL(virtual_name) to solve it.
> 
> Do not introduce a bug in 1/2 and fix it in 2/2, unless it is
> absolutely necessary.

I didn't know this practice, thanks for letting me know :-)

> Squash this one into the previous commit, before sending your
> patches out to the list.  The public do not have to learn your
> earlier mistakes, and before sending your patches out is the perfect
> chance for you to pretend to be a person that is more perfect than
> you are ;-).

I just did it!

Thanks for the review.

