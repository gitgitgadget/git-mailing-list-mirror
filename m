Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053BC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbhLVIiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbhLVIiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 03:38:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4AC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 00:38:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g26so3683961lfv.11
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 00:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cWJ7FgNi2Nhxj9gsISRjm0IBjbPdLQ/XjFiZ5N7R5EY=;
        b=cl+Kebs1jTVAUEPFA0RmvCLY70k96Tj9q08hoifD+ug/y8InFe1z3uuLD1eRJpNQts
         wHpJ+/YcFyl+YsQJgfJHZboczOVmFbEZZuSWld4cjm3BipPvXkTY1ztraaPT/9Liajlj
         Doi40D44++7al54am0S9lwNCY3MQX6EkLrUa+7cFVB2xA2ngOP8xy77xRlb+1vlDDDCU
         n0tZ2gbEnT2SXZh/CGsvr+m3EKqhcfDFVClGHNAA7Hj3N5rvxj8OwpsAx1vWekA8+fkZ
         Nrr2clfqCdn9/rzS9FBiVPf+lAuDiWqHYqEMdSd1h0giWJ9p22UYQrlB6H/VuSFFLLOa
         hwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cWJ7FgNi2Nhxj9gsISRjm0IBjbPdLQ/XjFiZ5N7R5EY=;
        b=znkHhgDaoVfqtRBCSAss+2QOAeD08kzjlCqUXRrHCCykrNwWRGxcFe29jP/E8r90lS
         2dgCA2yGgK9cEeJbXu3gJjI9ggQoBcdYyEHjUo5fab5aKmd0vdc/rEz4n+aEBHGC92ih
         SwYcqop+1/pfPYgJRu9c+sBc+5V1K+9pGTx4RIDcbKjP3N+rMf0hJhWMMIvi9eT43rJw
         +lSXrP+tMN41Duvqaq1MSf8lATFy6qYbi//y30BHBgO1CtkN6jKfpcZD0jBjEjyBFAtS
         OZDno36yJTDI6vfG9dfcRvUqcZYWbWQie75UWa0uS45Cu5nDRZ13R5i3zeIAtW3CMkRI
         LTsg==
X-Gm-Message-State: AOAM532k+JNG/gkErKN2sRbPhqq9hyOuSn1aBnfPaYxTHKE0dkRZH0le
        8aUIB5Am9vnxTWEdctOhm1mGaQ==
X-Google-Smtp-Source: ABdhPJyVl2fenG92354mlQjjjXeYUf5vF9BuC41b/RhXWkBBBvdF54vRgE8Qhyr7NVTCAbMDY8UoxQ==
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr1732563lfo.8.1640162297173;
        Wed, 22 Dec 2021 00:38:17 -0800 (PST)
Received: from [192.168.0.30] (80-161-135-83-cable.dk.customer.tdc.net. [80.161.135.83])
        by smtp.gmail.com with ESMTPSA id i3sm147271lfu.156.2021.12.22.00.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 00:38:16 -0800 (PST)
Message-ID: <26316444-9fd2-8f69-10a4-2753c5455e53@unity3d.com>
Date:   Wed, 22 Dec 2021 09:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3] fast-export: fix surprising behavior with
 --first-parent
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1084.v2.git.1639037637231.gitgitgadget@gmail.com>
 <pull.1084.v3.git.1639671789279.gitgitgadget@gmail.com>
 <CABPp-BF7Rg3NH3UBnyzD6c1vuFh+FNrNc8eRvUffqmaLppUPkw@mail.gmail.com>
 <xmqq5yrhptqk.fsf@gitster.g>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <xmqq5yrhptqk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/2021 21.50, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
>>>       * Changed commit message to include the detailed description of the
>>>         problem area as suggested by Elijah. I went back and forth with my
>>>         self about whether the message needs some "lead in", but it ended up
>>>         getting long without adding much.
>>
>> If it feels weird quoting someone else so extensively and just using
>> their words for the commit message, we've used a "Commit-message-by:"
>> trailer in the past; that could be useful here.
> 
> I do not mind tweaking the copy I already have with "Helped-by"
> myself, while ...
> 
>> This version looks good to me:
>>
>> Reviewed-by: Elijah Newren <newren@gmail.com>
> 
> ... adding this one before merging the result to 'next'.
> 
> Thanks, both.

Either way works for me. I'm not too familiar with conventions around 
trailers. Both seem very reasonable to me.

Thanks a bunch for the help. :)
