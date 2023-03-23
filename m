Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23FFC76195
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 14:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjCWOT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCWOTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 10:19:25 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7A305F0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 07:19:23 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w25so4079328qtc.5
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 07:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679581162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVL+wF5e0VCR0X1vY0JQR4R8qKk4rHB0brMF8CqB8QM=;
        b=LpnNBWPSBvFi0OH9lzjBYikO2hewrMELBEoC+0aTtL7Jpu2cF0kwq0vml6zXSdXb+5
         vIT3WTbZWmBvjXvrrEb0ABFmb8rUs2UT3uNVOeLay3/jYokXTtrh5lM5S3V9B/B1Nn3e
         7IlCqDRCfLHqGYjrh2rjEv21LXOzl4kCgBA6PA9W+rMS1w2uAyBcU1s8879CF22lMH5Q
         i4ycTEiekM7zA4JxyawWx0HB24PlIpN/oz1VBna09jxTB3Zq33WFXKDlc0v2siJ2aSE1
         MHiMQuo4wAd1e1zvejdCnq1eYH6Ms66U3g6aO6gpc4jnA4YQhuEbchyPRa4TGA0N5lqr
         SGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XVL+wF5e0VCR0X1vY0JQR4R8qKk4rHB0brMF8CqB8QM=;
        b=oX3uS1bw2OVpomhZQOITGi/gnOev1M34lifZ+8JdtzCoAvBbZeFOBhcd4b6IOQrO/4
         264lcb+DU3kpvSBRoOWsCGprrw/LYqPLbr73re1wx4q8Rl1Ksr44umDhL96RvqzeU1jj
         jHuh8r5SeGJDNe511G0cl/fswJBRj8oFkjMQVIChLbfZYUTUoDhQ4yXK5t84cF2G0MpI
         t9NqOLNueMmKZxKHfHTau/OJu9SPxVu0kScAX5dxDL3e+R5+BHsKZd/w+vZivgNIKlyR
         +biFhQbGPEnuqaWHW8pWKu5LtwNGNyD9FJdgj5qcqWHVI7Q07ES+HwiOgztm1C2vWMKc
         7A/w==
X-Gm-Message-State: AO0yUKUNVx2s9uyEZmvfjYxSoFHkTya/UnpNGQ0eKEtq5lFLY34MmaZj
        fqhfM5zHAdOlWBFl7dbEyrvvgua+OvCHRdO4tw==
X-Google-Smtp-Source: AK7set+7siZf6wZruOsEOc06+ueuWjxpUoryeK2kVQvaWn6rOHrRsbzJqqvQmQ0mJc6Av//rEh1g0A==
X-Received: by 2002:a05:622a:130f:b0:3de:81b0:aab8 with SMTP id v15-20020a05622a130f00b003de81b0aab8mr12817677qtk.52.1679581162137;
        Thu, 23 Mar 2023 07:19:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:91a9:67a3:eca8:7366? ([2600:1700:e72:80a0:91a9:67a3:eca8:7366])
        by smtp.gmail.com with ESMTPSA id i14-20020ac84f4e000000b003e3895903bfsm3356918qtw.8.2023.03.23.07.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:19:21 -0700 (PDT)
Message-ID: <f6e3ae73-daae-3cc1-eb16-d4a24a2612db@github.com>
Date:   Thu, 23 Mar 2023 10:19:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/3] wildmatch: fix exponential behavior
Content-Language: en-US
To:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1679328580.git.phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/20/2023 12:09 PM, Phillip Wood wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> The wildmatch implementation in git suffers from exponential behavior as
> described in [1] where the time taken for a failing match is exponential
> in the number of wildcards it contains. The original implementation
> imported from rsync is immune but the optimizations introduced by [2.3]
> failed to prevent unnecessary backtracking when handling '*' and '/**/'.
> 
> This bug was were discussed on the security list and the conclusion was
> that it only affects operations that are already potential DoS vectors.
> 
> In the long term it would be nice to get rid of the recursion in the
> wildmatch() code but the patches here focus on a minimal fix.

Thanks for these changes. The patches look good to me.

I particularly appreciate that there is a regression test to avoid
this accidentally happening again in the future. The two second
timeout is a reasonable balance between "not taking too long" and
"will not be flaky, assuming the code is correct". I could imagine
that it might _pass_ unexpectedly if it runs on fast-enough hardware,
but that's not a huge concern right now. CI machines are not normally
powered significantly more than a typical developer machine.

Thanks,
-Stolee
