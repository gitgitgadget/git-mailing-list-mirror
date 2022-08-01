Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9EC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 14:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiHAOAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiHAOAh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 10:00:37 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5F955AD
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 07:00:36 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id l3so8402300qkl.3
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 07:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=3Lu9U0oFbuLIS0gsBUisgrtTCpnooHJtYhniocyA+ZU=;
        b=g8fJF7LfZKG6eeMGm2+/kMRlWGOzNkE/Gb6oVdyu8L9bHOvGbWcF1vTn72SceLpCZv
         hfO7EFWSB0SfEoUIRjalLrFhfj+6ViG3Fjb0MzZNPHo7TQ0bdeWahbahVQhK6RjdTrdQ
         4Wtxmos7F0PXD2uQcpAgvxiLj7iD4v0FIp27TeuAxnqTJDdFnyJQoLEBbtoSOP/of62H
         kWs3JqDg3LIoqy8iOdkRvrAZqDkduaJv7kvA4wsYOAGgpALQmUyyuWdLJ1B6CCvcbrYw
         2MIOnoKxfabROWwsykYgQl/CVhZiPWiyK7fv1jnYnOwCheShLvNLrs7FAJys7O56wVmV
         Wzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3Lu9U0oFbuLIS0gsBUisgrtTCpnooHJtYhniocyA+ZU=;
        b=w9tiIx8IJ+2P7nd6mXzBvXQZs3YqiLn7R+UVpJxXbee3UIAGVzrr9IvQlbXHoSKIal
         qRNEAM+vj/FPdIMRLnxhQJDPmLgVUBgSCZtErq22IHHoDD1M5mm7+GfTYCZ/T7LrY3Ga
         2rP4kbhNt63tSPBYaU0BmTYw9hbwPdCEfQX2FLmQRM8qDGGpPO+lPyV078jiHlmy2Eme
         nU/C+JOrgHEfA0LoWjcVxASRAIJRmBMzs6RL/AH59bPI0ocDcP0iQpvfwyMhNLFKChYV
         ZOykx2g1d19L48uq8uAzvmObdDNmFL4RXcv+kjp4/RLQX+Pv7eMDIrYPJnXbZRg2cp9E
         iXTA==
X-Gm-Message-State: AJIora+fD5yuJ2EfMr1Z+1kgS1sHWIORVJPvf8QLdaLJiLOqJefPkR2U
        nwCVmE/iiL6A2/lP6AjbvCEr
X-Google-Smtp-Source: AGRyM1vfhMVQ4faZoFg3Bjv6fKmyqumHyf89T4lB3BliJC6loMWy+cOGXRF3tVk8XpHY2fmG2FiomQ==
X-Received: by 2002:a05:620a:404d:b0:6a7:d3d:df9b with SMTP id i13-20020a05620a404d00b006a70d3ddf9bmr11675267qko.530.1659362435710;
        Mon, 01 Aug 2022 07:00:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8ca1:1a2:b034:1f7e? ([2600:1700:e72:80a0:8ca1:1a2:b034:1f7e])
        by smtp.gmail.com with ESMTPSA id s8-20020ac85cc8000000b0031ebb1f8918sm7495063qta.76.2022.08.01.07.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 07:00:35 -0700 (PDT)
Message-ID: <6621a20d-9857-2150-258f-f229cea525dd@github.com>
Date:   Mon, 1 Aug 2022 10:00:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] bundle-uri: add support for http(s):// and file://
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <f6bc3177332e8608d0ba300669853bbad01c3266.1658781277.git.gitgitgadget@gmail.com>
 <YuG3miyCKtnv3Na/@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YuG3miyCKtnv3Na/@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/27/2022 6:09 PM, Josh Steadmon wrote:
> On 2022.07.25 20:34, Derrick Stolee via GitGitGadget wrote:

>> +static int copy_uri_to_file(const char *filename, const char *uri)
>> +{
>> +	const char *out;
>> +
>> +	if (skip_prefix(uri, "https:", &out) ||
>> +	    skip_prefix(uri, "http:", &out))
>> +		return download_https_uri_to_file(filename, uri);
> 
> Since we're not using "out" here, should we replace the skip_prefix()s
> with starts_with(), or perhaps even istarts_with()?

Sounds good to me. Can't abandon "out" because it is used
for the "file://" prefix, but istarts_with() is better here.

Thanks,
-Stolee
