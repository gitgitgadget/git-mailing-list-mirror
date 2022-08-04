Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690FC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 14:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiHDOel (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 10:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiHDOej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 10:34:39 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F72613B
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 07:34:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p82so1119766iod.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=OACPYGheDKWZ2+FNrHIgR0fSVqJ1nmeHL59BWeTgzVI=;
        b=Vpgmxnt6OKqge2m4SKucLCIRbSrd5hSZqW+fhhSp5UnbfwXGuEpsnR2CVUAlC/dyzD
         pnpMjjWLq47X4YLEfZiLW6gByr4euaTidhKwh380/IwmavN6cTiwuwQYcJpy0JWvhMLI
         IwdLui08elaZvgzpdm4qKEIHrkCEEDOaMMnFgC22XrKUJZjpdY1w302XDPMTje9AzhZf
         rdTnLn5PrKR3mboCDfsjeeFTdA6GWoJiaaKkk0r09WxryznG2gflzfZnD+KYJqwWy4jR
         C8gLCJUYnImMXFhFdmNzXGsJEMdjW7elljXKgm4dlfSWqvQ+D/lId3y1CwC/sBq+WkbC
         9hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=OACPYGheDKWZ2+FNrHIgR0fSVqJ1nmeHL59BWeTgzVI=;
        b=ivUWwyz/L/ilmMEJYQzJtmIilYl+aASXRQhfoVZ6FHK4dSZeHEkwnCujsmS6grm1zn
         Lho57hA5BVqHC0xpeJf1Zei0RhWxPqsc32GiLJzq4lmqJid9bSM94IXGQv8EEWS6PKW4
         N0sORXPj0Kb8oWB8yg+jnV8tlbpyBJwHC2T71zJQ6UCfODC5CbRTcjStOfWNUdyhyRte
         P0R0VbkQmiAMifU8nGVhxwZnbCLDBOLiKvQs259K7DhPqCwOlGVeST2OWtsjR/OQJEeG
         wTiWBl/sbsDPaQpol0Mb2CKjQ2VBOHxL6frqJG6EwYfgxUW+ZqrS8jj5ROoRbUVD8IxY
         n8JA==
X-Gm-Message-State: ACgBeo0OhWP04lnsvt16oeYsVa5wKS/PEQzksKuTQVoCn4BbNV7s+mni
        4tJxQSmhKg3y2qxxMB/ff92D
X-Google-Smtp-Source: AA6agR7mZUSs9mBr2GyXPHLFlGH8jIfI7h3ROpnVZ0xAl4pNDf/FOp6D8Frb834wR6YSjtIVb69rig==
X-Received: by 2002:a6b:3f83:0:b0:680:5bfb:8936 with SMTP id m125-20020a6b3f83000000b006805bfb8936mr895800ioa.46.1659623677701;
        Thu, 04 Aug 2022 07:34:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8b6:bc6e:e88:13d9? ([2600:1700:e72:80a0:8b6:bc6e:e88:13d9])
        by smtp.gmail.com with ESMTPSA id g95-20020a028568000000b0033f4bd1342esm516721jai.104.2022.08.04.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 07:34:37 -0700 (PDT)
Message-ID: <2d24b539-a5b8-ed7d-2320-97588854eb5b@github.com>
Date:   Thu, 4 Aug 2022 10:34:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/10] log-tree: use ref_namespaces instead of
 if/else-if
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <53b15a0b7932f892505d07a509909b62c473037e.1659122979.git.gitgitgadget@gmail.com>
 <xmqqv8r9dei7.fsf@gitster.g>
 <b4f07dd1-b59d-864b-f881-110c9bf87202@github.com>
In-Reply-To: <b4f07dd1-b59d-864b-f881-110c9bf87202@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 9:31 AM, Derrick Stolee wrote:
> On 8/3/2022 2:31 AM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> +	for (i = 0; i < NAMESPACE__COUNT; i++) {
>>> +		struct ref_namespace_info *info = &ref_namespaces[i];
>>> +
>>> +		if (!info->decoration)
>>> +			continue;
>>> +		if (info->exact) {
>>> +			if (!strcmp(refname, info->ref)) {
>>> +				deco_type = info->decoration;
>>> +				break;
>>> +			}
>>> +		} else if (starts_with(refname, info->ref)) {
>>> +			deco_type = info->decoration;
>>> +			break;
>>> +		}
>>> +	}
>>
>> Very nice.  The double-dash in the NAMESPACE__COUNT constant somehow
>> looks strange.  As we scan through ref_namespace[] array densely,
>>
>> 	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++)
>> 		...
>>
>> without having to use the constant would probably be more in line
>> with the way how the rest of the codebase works.
> 
> Ah, I did not know about that trick. Thanks!

...except that it doesn't work because the array is declared as
'extern' so we don't know its size outside of refs.c.

This motivates the use of NAMESPACE__COUNT (and the double
underscores differentiates the "COUNT" from other namespaces, so
there is no confusion about "COUNT" being a namespace). If there
is another way around this, then I would love to hear it!

Thanks,
-Stolee
