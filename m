Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD5C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 13:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJMNK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJMNK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 09:10:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FE35C951
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 06:10:20 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h24so593594qta.7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ND5PNMWXt/E3bVqq8vAnhbc0M53WrHB9u3urKYH3zIg=;
        b=bPue9/VV1x9HQiLCLuXptKxLaz+Eiy09Gh3yymiIe0uOfcEzZ9i+vDpsoey8V7BjUl
         NxXinHNwLZYLhgB9ys27HRm3N+WuJ3w3laeQKfgfGhdtUpm9r1hfPLEYMAxoYBVlCENv
         2nObOFvIPoRQ4HtFz16EmT76kkvaBdaFLRBsLi4Ck0u9pK6bM092uDhSi7GNov52L1Yo
         mrEmoxH3/dGzQIINn6Y6mvE2g0UKmA8aYB3StL/CZeeCxW86HALpIwzsXCDdNnQBSMYJ
         OK45gj2eYilutMrNwvTLw1DGz97ek/ZCbxgzUcowF6pp+Q9m8K2xgpl0hv8s7CZv59MP
         kVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ND5PNMWXt/E3bVqq8vAnhbc0M53WrHB9u3urKYH3zIg=;
        b=1s+LPN44ViQcdj33TyCIcAiUz5uR7I86caZfUBqPGrQYhbFwzcBPQAmbzZhwY2FymY
         TnTJSssnFmn4p1IpxK+MAXcESseTSoxAC8zVFf0CJ7Jd/rOU/joaWw5eBXBV+5Wrya7Q
         m5JPVje+pWT4BiFPdsD1ZPND4LYPcGgbnoempIBwUgM5NpL/jP2A9X4lN0MnU94Yp2Em
         f/LJP14ziFwbQ1LmGtgZuF9VGpRVI7hXsb1/AUiQxuhxxfZN316mXnxgvc+1HRal7flY
         uFrKGtUHeNPhNwlIA4I5askmtjsKDJhYVH3HbHadQGp/+QjAKsuJ9w67XjWK5ukgrh4R
         5swg==
X-Gm-Message-State: ACrzQf2D2s/QBC8YJnrLKrK5FauhX0fi+BjXHj7R0a429RKgI0KgEs6x
        2nHvkG67rFpkpdZ8zEdQbJuBwHb9IfEf
X-Google-Smtp-Source: AMsMyM4qMfnLhlcZOApWJJ70sETv6ULBYXQghjdEpsDW6CyVbXpZps81+wI34pVFdrkV1N9tZWXH8g==
X-Received: by 2002:a05:620a:1982:b0:6ee:c63f:f983 with SMTP id bm2-20020a05620a198200b006eec63ff983mr391710qkb.382.1665666619425;
        Thu, 13 Oct 2022 06:10:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8d47:fb11:1aff:a5c7? ([2600:1700:e72:80a0:8d47:fb11:1aff:a5c7])
        by smtp.gmail.com with ESMTPSA id bn42-20020a05620a2aea00b006ee8874f5d8sm5836724qkb.28.2022.10.13.06.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:10:18 -0700 (PDT)
Message-ID: <fa47a48b-6da7-a456-05d6-cd5c17b159c3@github.com>
Date:   Thu, 13 Oct 2022 09:10:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/4] midx: trace2 regions and grab-bag patches
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, vdye@github.com, gitster@pobox.com
References: <cover.1665612094.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1665612094.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2022 6:01 PM, Taylor Blau wrote:
> Here is a small handful of MIDX and MIDX bitmap-related patches that
> I've been carrying in GitHub's fork for a while now and forgot to send
> upstream.
> 
> The first is a small typofix, and the second is a legitimate bug fix
> which allows us to consider annotated tags as bitmap candidates during
> commit selection. The final two are trace2 regions and instrumentation
> that I've found helpful when rolling out MIDX bitmaps in a production
> setting.
> 
> Sorry that these are so disjointed in nature ;-). I figured that it was
> better to send a grab-bag series like this than to hold onto these
> patches forever!

As advertised, this set of patches are all nice and small. I've found
the additional tracing useful during performance investigations and
unobtrusive otherwise.

Though they looked familiar, I gave them a careful read and have no
comments. LGTM.

Thanks,
-Stolee
