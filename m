Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02FC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 15:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiLGPWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 10:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGPWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 10:22:23 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37545CD26
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 07:22:22 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r72so6895277iod.5
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9K9hcfYMR0ADCOtnSQzQMAeWO4QdSQTlhHRGtrjcPeA=;
        b=MRcFJ4fTRbmEzAH7iB7j499FS4HLo2LBSG/1z6A0/U6JBlkN+nPCAo8ksdoTx2151N
         J3oATqu7rasvvJP9K5dvOZBi9FzWM2xWlnT0wG1ErjSuJvPAqUX5CgF94BbA7rbWgqcl
         dfl6sL3VOj5bPnV8R8WZ1uiHA3LuK2/eLu4AHywyeRrK2YoNFgjc5vid2CV0dSe+jDee
         nXiZRBnQTThCmjz7NRptpJNACoD3loayWZ/hfOfUEBgPkkP3+ENODACPI1r/a9endy5b
         j0w3cW15tGebLNLjBOh59YKdFnLU53xSFCdZp6rI5TgPKW7aB99dPhVUEy4VohEzIlGT
         WypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9K9hcfYMR0ADCOtnSQzQMAeWO4QdSQTlhHRGtrjcPeA=;
        b=cdXc0La7sxmyItrX2ZEqwcDJskZSkEIcbV1rkblWA9aoX8Klo0iii0rsZKk/AEMTR3
         hjK0UkUilkzuhveG1j1r4/qfNOjB6N+TW7UkMxDfm0UCULg4saY++S7pPevyW1ckyP3+
         5BVLUwHUaM+ga3BFrqgE4GOWzZJWuI1kNmFA5KT9uebgopxFQNB+n4PSD2RsLZ0syxjV
         NchDiaf1hVZpycqiqbS7FF3JWVWnvRSUp4Q9hc9AkJjyAPsdDIcpwwpqyPx3n+s4uqeU
         Dm1Vk1xdTWwsYu/UNdkOWZSsrwlrwiNirBQIaESFdvbtNefp9McCBjKr0f1OUK9qOuUI
         6oMw==
X-Gm-Message-State: ANoB5pkjvLPBx5mzXh0Yqhwb0sgPPkp6phv4EyWMZdHJ8GkhHdJCLWmL
        RqlyobErrPPVciO/EwzT8v8r
X-Google-Smtp-Source: AA0mqf4njDwHokRfJ/KogWTCM9Yw2pvX6vqQlESLWfs5c268vcUE8FtyywOTQPwbtKsEZboEMLwmWw==
X-Received: by 2002:a02:2712:0:b0:375:b32f:7c75 with SMTP id g18-20020a022712000000b00375b32f7c75mr34348020jaa.162.1670426542225;
        Wed, 07 Dec 2022 07:22:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:30a0:a841:72ac:2559? ([2600:1700:e72:80a0:30a0:a841:72ac:2559])
        by smtp.gmail.com with ESMTPSA id ay32-20020a5d9da0000000b006e0577610e2sm899515iob.45.2022.12.07.07.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:22:21 -0800 (PST)
Message-ID: <76f9a25b-721b-29c9-9ad1-6174387aeeb8@github.com>
Date:   Wed, 7 Dec 2022 10:22:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 09/11] bundle-uri: allow relative URLs in bundle lists
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <48731438d6a289129a5768b80af856fb49692426.1670262639.git.gitgitgadget@gmail.com>
 <2b21f22b-b707-7705-a41c-9e4acbdb0405@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <2b21f22b-b707-7705-a41c-9e4acbdb0405@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/5/2022 6:33 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> Allow a bundle list to specify a relative URI for the bundles. This URI
>> is based on where the client received the bundle list. For a list
>> provided in the 'bundle-uri' protocol v2 command, the Git remote URI is
>> the base URI. Otherwise, the bundle list was provided from an HTTP URI
>> not using the Git protocol, and that URI is the base URI. This allows
>> easier distribution of bundle data.
> 
> Thanks, this clears up my confusion about the source of 'baseURI'.
> 
>> +	/**
>> +	 * The baseURI of a bundle_list is the URI that provided the list.
>> +	 *
>> +	 * In the case of the 'bundle-uri' protocol v2 command, the base
>> +	 * URI is the URI of the Git remote.
>> +	 *
>> +	 * Otherewise, the bundle list was downloaded over HTTP from some
>> +	 * known URI.
> 
> s/Otherewise/Otherwise
> 
> Also, this sentence is a bit more vague than what was noted in the commit
> message; it doesn't actually say what the base URI is set to in this
> scenario. Feel free to ignore if you think it's overkill, but that could
> probably be cleared up by adding another sentence after like "The base URI
> is set to that known URI."

Thanks for both of these suggestions.

-Stolee
