Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA74CC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 14:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhLGOiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 09:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhLGOiR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 09:38:17 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E53C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 06:34:46 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p3so13213108qvj.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=n6BGPVuTvVCv0RTzl87OE90OWZuWslFcKaeQ9uL7w5Y=;
        b=VTeQsyEI+BMaCHZghOJGYRUpjg2cecjOHDvso98m2znrbXgyXKvrlRE0452Y5ctPpI
         WrhLaunje95MEOQKg+xhuPVDNkn8FRcOuQcYza1UtBsAb6G3wViO7AkOKDxwfanT5loZ
         2lNfiWzHlzIQUv0FRgS+q3JZ0QuP2E3Vl4PUDDCQkTcr150yYHmNPXIjSV1Px28Vpgpe
         MYdJbHLCy2r/7ayKrZPkm6bB5MIZpvDwJ/FmaKEllf3AYvs3Lm7Skihr56FVKJBBuRnE
         AYWJZSgcWoi5B6ZG90FFZqrhKrg0YCjmUl0PGtseFryWBmQ5kAHewh+SQmFknCkLezwt
         nUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n6BGPVuTvVCv0RTzl87OE90OWZuWslFcKaeQ9uL7w5Y=;
        b=Wsdh1w/+2DK6akoYI91AIaEvAlW7rngooiVQUTSlGsBw0IPthgTZc/a6M/AdejRR1z
         gvOkg6OrhIWomh/gSqDX90v1Nqnfyhg715tdmAgyIX5JX9J+Bw4L6qlLetVHlpDRtLdZ
         E01xTFiJgkiEBrBo09hmRlWrlnE54R4sveO7yLOnE0W2wmClaGunR9wKBuJRBOPeLyag
         YcINnSbzeJOQJnVNXtDJiuBj+hAQErJq9ZjaJD94XC8MmPm6M4xGXY1EiPXqO/aKg7zV
         Vz9UJKr0zbL1ZvYZveMasIA6iPzs14tl+priMWGxSQP7Cxqq09mdCOXjntfFc/h1OWkb
         FvPA==
X-Gm-Message-State: AOAM530ngv2OKX2MtGPZDcAAvuAsr+582qMMr0quirpimWJ1/C5DHD7v
        HTfl1T1A2gXLILdOApfSSj8R
X-Google-Smtp-Source: ABdhPJy4L5pZ1wPnItoaxQyH8/4fHsKdHtvdI+0g94nIKdvBRbRDM6/Hx3PbT0hvpICLFo+NPZY5ZQ==
X-Received: by 2002:a05:6214:e49:: with SMTP id o9mr46042848qvc.74.1638887685681;
        Tue, 07 Dec 2021 06:34:45 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id c7sm9861195qtc.32.2021.12.07.06.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:34:45 -0800 (PST)
Message-ID: <0e3e3a4f-f6af-d8df-8973-255ed7b1b7ef@github.com>
Date:   Tue, 7 Dec 2021 09:34:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: Build race observed with git 2.34.1 - hook-list.h wasn't
 generated yet
Content-Language: en-US
To:     Alexander Kanavin <alex.kanavin@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20211207113101.69686-1-alex.kanavin@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20211207113101.69686-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Kanavin wrote:
> Specifically:
> 
>  builtin/bugreport.c:7:10: fatal error: hook-list.h: No such file or directory
> |     7 | #include "hook-list.h"
> |       |          ^~~~~~~~~~~~~
> | compilation terminated.
> 
> Please see here for the full log:
> https://autobuilder.yoctoproject.org/typhoon/#/builders/59/builds/4427/steps/14/logs/stdio
> 
> Seems like COMPUTE_HEADER_DEPENDENCIES isn't working quite right? I meanwhile have set it to
> 'no'.
> 
> Thanks,
> Alexander
> 

I've encountered this as well, and it appears to be a dependency graph
issue. For me, compilation was fixed by a patch [1] that isn't in next or
master yet ("Needs review" - ab/make-dependency [2]). If this an important
fix to fast-track (I'll defer to more experienced contributors to determine
that), it might speed up review to separate that patch from the rest of the
series?

[1] https://lore.kernel.org/git/patch-v4-19.23-2710f8af6cd-20211117T101807Z-avarab@gmail.com/

[2] https://lore.kernel.org/git/xmqqbl1xqheu.fsf@gitster.g/
