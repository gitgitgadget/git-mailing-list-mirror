Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B37C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiCBSzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiCBSzU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 13:55:20 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514AFCD5C1
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:54:36 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s5so2580607oic.10
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 10:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NgEg7+NRUu2KXXJ9gzyhd1iMRVcwWO9YZmsdIrECq5A=;
        b=iAv/rWTA3SMRnFHExlDTzNZsTKoljWRO3YHaREbt3J81UDvFEs2FElnr8D+kCBpLxI
         sTsGSWjurYprSD938D8mN/03Uwx/DdnJ5H5xmk+qTNWyFMVGSXoyEbAQpALvwwoJ7skr
         wdD32mbGsJJ0SA8l/v6Zq9NcdcbwuoNk9dVIeDwZ7JXdR0lCurVaUI4kvxpF8TnRkVbq
         4Gx2/pyOAUjUAHq8eCr/igTIvOnGk1VNpfX76U1kfZ9zKds3KxOlVPHMWGVuzHNxufPu
         mlr4G/jx9FsQNHFh499+I6Sih0NJZt/xtLRG4a2lr8dsH+Cs0p7H0ldpHh3Yc6w/IdP/
         BLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NgEg7+NRUu2KXXJ9gzyhd1iMRVcwWO9YZmsdIrECq5A=;
        b=5isZQPzEGOvgIpNRyzj/ggiIuuRgyY0eTiJaG1AXtAuq9T3q8osa3bPHPzCN+Bvwvs
         O6EhtxdHrP77ZVoOpyV1A4/ytvBsRpsZGKPk29UF0PD9nKrzG7aTRzk1xUV1f/Hv1LYo
         jL3+5M7MgQUI8c17fS0D0xqeN88aH0M3z0ij5dI/+C6doQb30HoeQNgNVAdLt4ZJUVRh
         TPO75Ib1J62Lk8/gGFIzMPZ4ADmFtPggGMnK7XUmI1SKrOEU9mtTP5U8GSwSZVFgNMzH
         q+wpRXuVOImNpYEc+0IZkCnr/jNaAwvuCay7LjxE+9RGVEn1aX1y/TEj60KJRwUMqWo7
         F/MA==
X-Gm-Message-State: AOAM532MHNvQuTrKp1JJcoWwAyhDcDXYRi4UY3oZIfYwp60W8Kf9+Mfs
        mfSH9qnNRQ5uzRP0qaQmXxiCWxCMH8gS
X-Google-Smtp-Source: ABdhPJxzxIfkK2TgWp01S6+oBrmTBgMkBzfwzfql6CEXd8UqotwHM8Ei9sW0//EvhOanmoVw30OA7w==
X-Received: by 2002:a05:6808:1801:b0:2d7:206e:36fd with SMTP id bh1-20020a056808180100b002d7206e36fdmr1183302oib.3.1646247275728;
        Wed, 02 Mar 2022 10:54:35 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w11-20020a4a274b000000b0031c10e27c1esm7809479oow.3.2022.03.02.10.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 10:54:35 -0800 (PST)
Message-ID: <49c21bac-0543-7c3e-33f2-d36cdac87362@github.com>
Date:   Wed, 2 Mar 2022 13:54:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/5] fetch: more optimizations for mirror fetches
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1645619224.git.ps@pks.im> <cover.1646127015.git.ps@pks.im>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1646127015.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 4:33 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this is another patch series with the aim to speed up mirror fetches. It
> applies on top of e6ebfd0e8c (The sixth batch, 2022-02-18) with
> 3824153b23 (Merge branch 'ps/fetch-atomic' into next, 2022-02-18) merged
> into it to fix a conflict.
> 
> The only change compared to v2 is an update to the benchmarks so that
> they're less verbose, as proposed by Derrick. I also had a look at
> introducing a new helper `parse_object_probably_commit()`, but I didn't
> find the end result to be much of an improvement compared to the ad-hoc
> `lookup_commit_in_graph() || parse_object()` dance we do right now.

I'm satisfied that you tried the helper idea. This version
looks good to me.

Thanks,
-Stolee
