Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D8C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 13:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKPNoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 08:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKPNoI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 08:44:08 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776912B18C
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 05:44:02 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w9so819941qtv.13
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzM1DoxeOVHxlCLj4ZiKF0K1Uoejgjf8SflVruJpo+w=;
        b=KWqioo3yEZQdw2GSbe9JPvIt2E0a7FxzZY3ctTa6eOlNjSvOZOGmoiuVGiQN3nFQ7T
         QVbJHBJCL4N8O+dNouw723/GpFNz6qaQqtgAp0itzmCuVrIxInHPlEbA4GBXtdIBKV47
         IBzT6n9UKlrL8V98SBzCHW2COb3F5KyIS5vzHyyIVWbaInuL2ShTIzTx15WykcrQiL6/
         LGn02nlp+NfuWnPpk1rr7cfiPfjCaGeSYjHnkoyLTZkMj+gsjqY+yBWBVEva3WXw5d3W
         3/xhyjizQMDDFU99THmSuDp5EjD3wDr5PA2UbVu1hFYvj9vhIqokoMELf8RHzg6y19HM
         sEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzM1DoxeOVHxlCLj4ZiKF0K1Uoejgjf8SflVruJpo+w=;
        b=bCz0uv6uVm8Tfi7xCjg/jEAt0ma1d34FhDCRqyQTHXvhfzhE/QFwOvE9BDSwLdU/3q
         /sFeFfRhnCEkUGESLyUC2Ww2rAalyFLqAhhPaxixgan+4aYUmMr+3VSuAPTHcAo3vzPj
         ygH4fgTjT6E1GdZKUxyIvX+VV9pM/BCwkLA6NrVjoVyEWpHc8BZ9H+nV0ZKC4xW1Yar4
         dWXvfubxJgWE87q21YhZRcjipag3C0FE/r/GWlTdqNL2a3ONXTPwjO9p8oWGO9CEGgcz
         YDMmBgOSFHnZAFiej7Fp4+DulSPZKzwTCcDDM+ENOHa4b8Q0hl83V/tNuGf5THoRJ7IT
         IQHw==
X-Gm-Message-State: ANoB5pnup6TtkPuPZfnwvYeVTCrAhTAQ6PDu7A3pL9OI3tybyV4VHXUb
        qjH9bZ6oXcaN2Vx3XfptCviP
X-Google-Smtp-Source: AA0mqf6dJgg5j+97Y2fP0aUXyKCp+TbPGh7rgNOW20gao7d0E44ao2NVOQxMUyyKZSBTgfoNkmZ1iA==
X-Received: by 2002:ac8:681:0:b0:3a5:faa7:35e7 with SMTP id f1-20020ac80681000000b003a5faa735e7mr6871570qth.66.1668606241490;
        Wed, 16 Nov 2022 05:44:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f553:9f0c:85c5:38e1? ([2600:1700:e72:80a0:f553:9f0c:85c5:38e1])
        by smtp.gmail.com with ESMTPSA id cb5-20020a05622a1f8500b0039cc0fbdb61sm8719460qtb.53.2022.11.16.05.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:44:01 -0800 (PST)
Message-ID: <2ce55cf7-5eef-8e6d-7b91-9a4bc16ed1c4@github.com>
Date:   Wed, 16 Nov 2022 08:44:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
 <221115.86r0y4j8tr.gmgdl@evledraar.gmail.com> <Y3Puhtj8Q8kf2wt0@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y3Puhtj8Q8kf2wt0@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/22 2:54 PM, Taylor Blau wrote:
> On Tue, Nov 15, 2022 at 08:41:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
>>> @@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>>>  	int found = 0;
>>>  	struct string_list_item *item;
>>>  	const struct string_list *list;
>>> +	struct config_set cs = { { 0 } };
>>
>> Just "{ 0 }" here instead? I see it may have been copied from some older
>> pre-image though, and they'll do the same in either case, so it's not
>> important...
> 
> Copying from other zero-initializations of `struct config_set`:
> 
>     $ git grep -oh 'struct config_set.*= {.*' | sort | uniq -c
>           3 struct config_set cs = { { 0 } };

Yes, without the double braces the compiler will complain on
macOS, I believe.

Thanks,
-Stolee
