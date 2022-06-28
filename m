Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33148CCA483
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 20:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiF1UNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiF1UL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 16:11:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBF13B2A0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 13:03:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i194so13926066ioa.12
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GcHx3ZQ6Kb8RtDGrPjkOM7CArRexvHzA8n4/5LQdWB0=;
        b=CvBQ7I0z7yi2P2Y7KbuWjSxz7JbvCnj4ObQzHE2NDA/LenxNA6+X1Bx5PFuPeX2BK6
         5IkupgCbZ3+gRzOXp52e+nJm0D5V54pttxe5otxOE4lM/uV2JCvzo0BeSLiULV1xaiER
         i6NYW+NsRXtb8WF6ewmErKJDydU86z96bO7IDAN6OVZAW90nspiHFGKvwDwv7vL3usXh
         lZN5jgru+d76UPNrLkl+whNV/CDcyOOz73BEAtN1uCnSpVFC32q3zUprUi/AB4+UzlOK
         g2LN+UhTdClx4BnajVFJ+jxd6Uffy+SeoB2EugSKAzTy1AfP12S57A1dApVyH2hqIi5E
         9lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GcHx3ZQ6Kb8RtDGrPjkOM7CArRexvHzA8n4/5LQdWB0=;
        b=fwitM55KHLkOyOYTwAEpnd97J3N4WKj+LQNHPv5Az7WtQciPGhWZFjp+neneSEZAD5
         uPKOvdkMR2vZzZEch3FtZishd1VwlSxjK2KVG1setOpXS6CXdowL6tCktZem26cbCSmy
         XEX4ByfqEtmZIWlfDPq84SUYKEKkGtvvYJw49bj3VaD8hyBHOVUCH7Sr5ytiolaxWBVv
         lT8QsmY3rSE/lfeoq+VA4AePgmzH+AJbTenFW0oh6ZhhvRkTgOtX8CxftageMobKBJHB
         Nd9utEIq9MhRPYVO1BlGLk6mD4/a/u0m24rtDo/G6PVwrVXFXx6Y90TOCoQlJyTh5amE
         touQ==
X-Gm-Message-State: AJIora/2+wpdH1hLT/jz7zKp7vLQj9zeQ4zgVYu66QpB6m/7foXYNYNX
        LQ6wQBXjybnIHJXvwwtkSVEskQpCJ2Wd
X-Google-Smtp-Source: AGRyM1u6VSeFq3hb44YVJqLB/CtO6Dbwcg7V+NgY9kVgglfimovj3+2+QuUZGVjuPLbGzeTm49A6xw==
X-Received: by 2002:a6b:14b:0:b0:675:1af2:ba27 with SMTP id 72-20020a6b014b000000b006751af2ba27mr9433129iob.78.1656446599524;
        Tue, 28 Jun 2022 13:03:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e803:5ac5:fad4:b3b2? ([2600:1700:e72:80a0:e803:5ac5:fad4:b3b2])
        by smtp.gmail.com with ESMTPSA id f7-20020a05660215c700b00674f80edd63sm7145289iow.23.2022.06.28.13.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 13:03:19 -0700 (PDT)
Message-ID: <69ee674a-6564-b0bc-fa53-2ec7dc02f80e@github.com>
Date:   Tue, 28 Jun 2022 16:03:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] pack-objects.h: remove outdated pahole results
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com
References: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2022 2:30 PM, Taylor Blau wrote:
> The size and padding of `struct object_entry` is an important factor in
> determining the memory usage of `pack-objects`. For this reason,
> 3b13a5f263 (pack-objects: reorder members to shrink struct object_entry,
> 2018-04-14) added a comment containing some information from pahole
> indicating the size and padding of that struct.
> 
> Unfortunately, this comment hasn't been updated since 9ac3f0e5b3
> (pack-objects: fix performance issues on packing large deltas,
> 2018-07-22), despite the size of this struct changing many times since
> that commit.
...
> For that reason, eliminate the confusion by removing the comment
> altogether.

> -
> -	/*
> -	 * pahole results on 64-bit linux (gcc and clang)
> -	 *
> -	 *   size: 80, bit_padding: 9 bits
> -	 *
> -	 * and on 32-bit (gcc)
> -	 *
> -	 *   size: 76, bit_padding: 9 bits
> -	 */
>  };

I will shed no tears over this being gone. Thanks!

-Stolee
