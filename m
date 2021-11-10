Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24837C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1C061241
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhKJVI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhKJVIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 16:08:53 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15613C061766
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 13:06:05 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s139so7579011oie.13
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 13:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rbERqa1R7FHCEGjJXyM2TGYwZotwNNLvsYm+CdhNPWo=;
        b=KLX2Gj7BPaY5jge2GgK2OwyPY92Wc8RKl6lLSxlXy45DZycLFOm0Yog7R3u2cPXgMe
         vGoNIQgQDIshXXh+CHHV+RjEyuS18/oX0M9ICGpJ0uOcalfxgWuAhO6pUOsH8AiIocoi
         yyQByrj+l69wbmWuqmv5zmDDEJnk/w5vO3FOLYRZ6uSWKSsJ7Oq4y/BvXbc7k6R4BaU6
         4qlwGQhBpmXHcRXACXc3V51bQ7dhR0pawIkHJVLUBFxViE4uoM8sYEgwMjPZ2aX0r+fX
         BYHJVfp3CC6ODRtTVPdvYEalyeWKTL/dGwz4VfcpKRG7tiHqMi6NBYPpCnoFxlAoV8w4
         h00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rbERqa1R7FHCEGjJXyM2TGYwZotwNNLvsYm+CdhNPWo=;
        b=LK1CH/c7lZvjxJViTloS7pqZmC1Fvgf6c8+SWthMAKYDFVNiNsp7i7hdA1q/2tKKli
         NRjy2IO+95OVWSRc1Gyr0Ll6UaT1kH/kv7NJWJ6t0uXWdaUaZHAx8sSN+4NFkLi0gQBy
         F8/c4StjmLnFq7WqZ2pqAl7XR50DaPsNB5qVcxb1x85L+q3ZzHWFrIr7rIYTwzN6XfdX
         xe+fYdTnf7AUWiy3A7TiQeuegme8yvpEpk76VbohMdpDKl1o8K5emvHpba3UDT7WhjBw
         f6pj8vJVNMdzgXLLc8+feLG4UofeyRbGWpRLa4ikbmBmM9U7B/ekaLhOU+CozKRRkdBz
         UZFg==
X-Gm-Message-State: AOAM531jJqrfpg7jTIRTidf8JlXCFx8Smov95GTTn9l1lKzMtBSq0xQG
        wWLVvT8U7kWrY3UBO/PoxU4=
X-Google-Smtp-Source: ABdhPJzrnosFgZGreWeWmIbumT2Rt+bqDmbW9NIKXSmBhUHasnBFy7K8LBvwcP6GOsdGnk3b60yJ7Q==
X-Received: by 2002:a05:6808:1a2a:: with SMTP id bk42mr15690111oib.118.1636578364274;
        Wed, 10 Nov 2021 13:06:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:64b8:5437:e398:f201? ([2600:1700:e72:80a0:64b8:5437:e398:f201])
        by smtp.gmail.com with ESMTPSA id u6sm164918ooh.15.2021.11.10.13.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 13:06:03 -0800 (PST)
Message-ID: <4996fb32-8262-b2af-b78a-c337041d897a@gmail.com>
Date:   Wed, 10 Nov 2021 16:06:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] maintenance: disable cron on macOS
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
 <211110.86y25vpw1y.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211110.86y25vpw1y.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2021 3:56 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Nov 10 2021, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> In eba1ba9 (maintenance: `git maintenance run` learned
>> `--scheduler=<scheduler>`, 2021-09-04), we introduced the ability to
>> specify a scheduler explicitly. This led to some extra checks around
>> whether an alternative scheduler was available. This added the
>> functionality of removing background maintenance from schedulers other
>> than the one selected.

Note this last sentence.

> I haven't tested, but isn't a smaller fix for this to just re-arrange
> the array where we declare the methods to check to have "cron" come
> after all the OS-specific ones, or at least after launchctl?
> 
> I.e. we already have an ifdef to pick launchctl and never cron for OSX
> on "start", so this is only for the case where we loop through the array
> looking for something to select.
> 
> That wouldn't work if that user can run cron, but can't use launchctl at
> all, but in that case won't they be happy to get the prompt?
 
Your suggestion doesn't work because this isn't about picking cron
over launchctl, it's about disabling cron (and systemd or whatever is
available) when launchctl was selected.

Thanks,
-Stolee
