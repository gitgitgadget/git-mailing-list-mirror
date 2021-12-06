Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680E4C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 18:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbhLFTCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhLFTCk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:02:40 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCD4C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 10:59:11 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so370708wmi.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l2eIZHaafW3aRkGGraYDirdtSfQXuRmZMv9MhrXOzXA=;
        b=Fy8Iv6iGl85EAC0nT7TF6hGgY/adTdD3kXAgq5wALVfCaO1OtbFdjiyx2VI09Txtah
         6VA0NpPdsYiE7hwyVZTccjaDZoJIX2QmDIoH4lguE3bRBgAtnAwn4xDSVKq1PyxEoHGL
         j7H9yRob0oliK9DfnIwENkoEQ0t7QOhqNE3oi85pNyxquNIx6beNhQZLjkXKV1V+kPAL
         Zi2soRicB/1Y3mc1lCjD3y2TbDw9aYEte1ujDqIaB5uNZGu2O/3Koo1LXicJaLNZAZQv
         c0WmutUUMsWM4oBC5FpybW+wyjB1FsKWhAfc9wFsjSQ8lHfXKAUjp0hU0v4Ltkfvf8Pw
         4axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l2eIZHaafW3aRkGGraYDirdtSfQXuRmZMv9MhrXOzXA=;
        b=acyYhORTNLTsa6V1xtY5HvxlXlhHeXUjWd7uJVnTD3JyD0y3bNfesk9ATXKlhOkoPK
         PHGE4uTfoJVwUUD3rh1kn/IXxgv6i7MSkSy4QrLgZzVvUszvYVfzpebjb2gqh9UA+F18
         XJEBRt2Dao3V2Q4G4bV+5nql82libfEYwObFAaPz3AevWZJuBmvv4XFqlu3OZRGzDasK
         WVO3ursnvXTU6MT/XlSYtFx+jbILoUt+InODXitf3www4ueVc40+qcaoTrkGQ4vwK1Pi
         hLl1slCbPSNIZ/jIPSTaK95WWvOenaD8hkbwNbd9CLOg+/YNUaXV0v0tAjWMfN3409oI
         dOqQ==
X-Gm-Message-State: AOAM532olNgVu/EBqmC/yBg/DU/4sGET0awwVo7F06/TUSW24u31kn06
        eR3ClUAl3PKlUAbtzN+GQDI=
X-Google-Smtp-Source: ABdhPJwsnfjPLLZNWN9vzh0jT0g8EvJzWk4FI9cT4uaNGbJGt0K4XhfKZrMPAETzI+azfaVwWZOSIA==
X-Received: by 2002:a05:600c:3c9b:: with SMTP id bg27mr414821wmb.163.1638817149789;
        Mon, 06 Dec 2021 10:59:09 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id o25sm229452wms.17.2021.12.06.10.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 10:59:09 -0800 (PST)
Message-ID: <f91879b0-7767-5406-cd36-885b4b53deab@gmail.com>
Date:   Mon, 6 Dec 2021 18:59:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] unused-parameter cleanups on top of
 pw/xdiff-classify-record-in-histogram
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Yammtm+pIkMu43zZ@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 03/12/2021 05:10, Jeff King wrote:
> On Mon, Nov 29, 2021 at 06:16:54PM -0800, Junio C Hamano wrote:
> 
>> * pw/xdiff-classify-record-in-histogram (2021-11-18) 3 commits
>>   - xdiff: simplify comparison
>>   - xdiff: avoid unnecessary memory allocations
>>   - diff histogram: intern strings
>>
>>   "diff --histogram" optimization.
>>
>>   Will merge to 'next'.
> 
> This being merged to 'next' tickled my -Wunused-parameter topic, so
> there were a few more opportunities for cleanup.
> 
> Definitely not urgent, but I think worth doing. Prepared on top of the
> topic branch.
> 
>    [1/3]: xdiff: drop CMP_ENV macro from xhistogram
>    [2/3]: xdiff: drop xpparam_t parameter from histogram cmp_recs()
>    [3/3]: xdiff: drop unused flags parameter from recs_match

Thanks, all three patches look good to me

Best Wishes

Phillip

>   xdiff/xdiffi.c     | 18 +++++++++---------
>   xdiff/xhistogram.c |  8 ++------
>   2 files changed, 11 insertions(+), 15 deletions(-)
> 
> -Peff
> 

