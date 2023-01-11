Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C7C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 20:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAKUST (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbjAKUSK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 15:18:10 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BD913D0B
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 12:18:00 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id n8so13712591oih.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 12:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vd/gYSRKkPriFIW+cE2mdwVrOimb6bFunX08vYioPQg=;
        b=GOvDVp1kV9AyCBw4pnCwMcBR2rbvt5TFrMOB+KJZl52CaBNL+XE5SgByCjqpACm6aD
         xcMcuCUAzQiDyqR62qjRivh0AMp168iw8pUFX5RgE2i6gBAk2UqYQfK6kOZyugpr/AI7
         UJwnoFodsYmskFCBwjii6L/dsy8paYHsTTJXKZUPUIoG3kpP43oDjgMm4djkDHfvKqSV
         a1+i0NsN+svl48WFqvDdOyyytb+6m4Sk4KtP3lErCiX6lQ8gVnAZPX+DQEsfThispIjo
         G5OZqO+R8EWx1WafTdRIkvPmLrSQaS/PhMgxibe4+nfn0fORNuQIPfpYjWTiHbWe3J4L
         YX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd/gYSRKkPriFIW+cE2mdwVrOimb6bFunX08vYioPQg=;
        b=myvYyD4EtiFdUuSy989uOELgLpxQ7P55lZ8iWhYDW/bNvgrHdC3IAbjb0fd1e/Fr4Y
         NVGDFxqR9g7pUpP5Y47Ichd92Rd64JrOCxC7VP+SMIflTQEWilxtkQeI/m07TXVYphfm
         U/611F2y3w0AxnllGIV085GJwEDJL2pDgayBrSq8kZY3dqP1kVYRnIcAi6xx3w1fgLE6
         t8Dhhne4O1fo8LgZ2ky8KCUda0MLu6EM/o4EKP2Pyt45YkpYLubsCnbSonwJfz4rOdds
         ii4dp/0bvdsEHa1cQlmCE7/ggCMWeUGqfftBDs57BbTAu7FCx6tmAmG8UTKO9Io9uU+5
         Q+Lg==
X-Gm-Message-State: AFqh2kqSp4tFlvhqKNjTzTArhvqJnMRJ2O22MTyQYW27gA8vQvf8w8+o
        nCtfTR6LoM0pGTmeAt6dv1N6
X-Google-Smtp-Source: AMrXdXuxFTJAl3uZqqeN8uV0tRtaL+R24JwzZ+jNCE/QeJKpgZHlH+gDISPhgHoexfmdYIyfituy7g==
X-Received: by 2002:a05:6808:2796:b0:360:ba2b:d7e9 with SMTP id es22-20020a056808279600b00360ba2bd7e9mr1483810oib.31.1673468280232;
        Wed, 11 Jan 2023 12:18:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:88e6:17dd:15a5:edd9? ([2600:1700:e72:80a0:88e6:17dd:15a5:edd9])
        by smtp.gmail.com with ESMTPSA id bk33-20020a0568081a2100b0035a2f3e423esm6976336oib.32.2023.01.11.12.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 12:17:59 -0800 (PST)
Message-ID: <6c896cc8-2da9-a448-4ab6-2dc535fb0e2b@github.com>
Date:   Wed, 11 Jan 2023 15:17:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/5] cleaning up read_object() family of functions
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
References: <Y7l4LsEQcDT9HZ21@coredump.intra.peff.net>
 <f1028cba-5fc6-3584-3f21-545550012e9d@github.com>
 <Y77/T8dktee3wOA5@coredump.intra.peff.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y77/T8dktee3wOA5@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2023 1:26 PM, Jeff King wrote:
> On Mon, Jan 09, 2023 at 10:09:32AM -0500, Derrick Stolee wrote:
> 
>> I did think that requiring callers to create their own object_info
>> structs (which takes at least four lines) would be too much, but
>> the number of new callers is so low that I think this is a fine place
>> to stop.
> 
> Yeah, that was my feeling. I do wonder if there's a way to make it
> easier for callers of oid_object_info_extended(), but I couldn't come up
> with anything that's nice enough to merit the complexity.
> 
> For example, here's an attempt to let the caller use designated
> initializers to set up the query struct:

> +	struct object_info oi = OBJECT_INFO(.typep = type,
> +					    .sizep = size,
> +					    .contentp = &data);

Your macro expansion creates this format:

	struct object_info oi = {
		.type = type,
		.sizep = size,
		.contentp = &data,
	};

And even this expansion looks a bit better than the inline
updates:

> -	oi.typep = type;
> -	oi.sizep = size;
> -	oi.contentp = &data;

So maybe that's a preferred pattern that we could establish
by replacing the existing callers. It's also such a minor
point that I wouldn't say it's a high priority to do.

Thanks,
-Stolee
