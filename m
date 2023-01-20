Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0640C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjATPxV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjATPxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:53:20 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A20C2940E
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:53:16 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id k4so6095838vsc.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElPx8yJ4tVufGN0BE+goiRMEDU2HSfG1Z8O8NWCZomo=;
        b=LBVNH8/FSnM5Y6zud7dTwj72e/C1CUhI2/tJ4ANUTpU0PuqDG5hN2EjUM/kzOY86qs
         s8aXWYvngGQWMEa+MrBuQw4t5zq6itidLcGBiiQsSD98+OELLDkLEq11tDa9eM1M+JXW
         LRnRu+bvPM97fzic1p1t4oWE+re+GBrEMwUWuDGouXLEEOUtopmJFZk96iQvYoryog81
         AZYyXA5/4pxby7Z254tmdtVV+gikAIqFtNKZDdM7GrSY+H0JofhkGo2BD5YKIkW9n+IS
         Vqt3oy3rBUkGxi0w9EtnH4e5R+bqQcu+SHUZzHLhGH4UmXq8bcTzQXYOJt9HD1C/UfCm
         VH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElPx8yJ4tVufGN0BE+goiRMEDU2HSfG1Z8O8NWCZomo=;
        b=RkmPYTf1y4YAQJWhzR3IGgv44+ozBtCrTzTRv3RZTie1GgiyE1eqnskjkz0Zd76M30
         /58bFL2rBKO55ARxJMHfVasJGW8PnMX9X+HnUQJM6pFMZy7zNs2eXlfnfAXc2XwcOraD
         bKloQbtkq5iD8JVGuLKb636+HIV345Gv0XoUenj0+Ygi6dvL9QFnCODubeYE8aRztSJU
         MHSRAlqdzztcooiDEvNKGydzpinzHmWHOIfC9buZ9sJ0UoiTkM6SGtBEugTQBP1aGYQd
         TMXJwu/lQnsrza7eazM1e+dS9nNPzV0qP7nEWIX5twG8/lqoZdgZ3s7eR3RSq7jX/HIm
         pZrA==
X-Gm-Message-State: AFqh2kozdsZZtY74Sq04onGK/Un96p2Tb13bf7vLsf2l/zstn/azQ0zW
        aZkcCINHKyypQWWiA9DL5dG8ZCdgtML38zI=
X-Google-Smtp-Source: AMrXdXupA6wZUgTxL9/fo8l/rCT44xWDlxqKkHenYlErVOZBwfp3wRQ4YTu3wcakmbNeL4NRHwV/UQ==
X-Received: by 2002:a67:ff10:0:b0:3d0:8a26:a666 with SMTP id v16-20020a67ff10000000b003d08a26a666mr9187360vsp.12.1674229995342;
        Fri, 20 Jan 2023 07:53:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ede7:6bce:9af7:733c? ([2600:1700:e72:80a0:ede7:6bce:9af7:733c])
        by smtp.gmail.com with ESMTPSA id 3-20020a05620a070300b00706b69d3414sm5013723qkc.94.2023.01.20.07.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:53:14 -0800 (PST)
Message-ID: <7853f7f3-d999-5b39-ab6f-c43055c65085@github.com>
Date:   Fri, 20 Jan 2023 10:53:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 8/8] bundle-uri: store fetch.bundleCreationToken
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <51f210ddeb46fb06e885dc384a486c4bb16ad8cd.1673037405.git.gitgitgadget@gmail.com>
 <f7a777f0-3f37-86a1-f520-1ab6853b9ed1@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f7a777f0-3f37-86a1-f520-1ab6853b9ed1@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/19/2023 5:24 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:

>> +	/*
>> +	 * If fetch.bundleCreationToken exists, parses to a uint64t, and
>> +	 * is not strictly smaller than the maximum creation token in the
>> +	 * bundle list, then do not download any bundles.
>> +	 */
>> +	if (!repo_config_get_value(r,
>> +				   "fetch.bundlecreationtoken",
>> +				   &creationTokenStr) &&
>> +	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
>> +	    sorted.items[0]->creationToken <= maxCreationToken) {
>> +		free(sorted.items);
>> +		return 0;
>> +	}
>
> And here, we exit if the cached creation token is greater than or equal to
> the highest advertised token. Overall, this seems pretty safe:
>
> - If the value is (somehow) manually updated to something larger than it
>   should be, objects will be fetched from the server that could have
>   otherwise come from a bundle. Not ideal, but no worse than a regular
>   fetch.
> - If the value is too small or invalid (i.e., not an unsigned integer),
>   we'll download the first bundle, unbundle it, then overwrite the invalid
>   'fetch.bundlecreationtoken' with a new valid one.
>
> The latter is self-correcting, but should the former be documented
> somewhere? For example, if someone changes which bundle server they're using
> with a repo, the creation token numbering scheme might be completely
> different. In that case, a user would probably want to "reset" the
> 'fetch.bundlecreationtoken' and start fresh with a new bundle list (even if
> the recommended method is "manually delete the config key from your repo").

I can update the config documentation to include this.


>> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
>> index 3f4d61a915c..0604d721f1b 100755
>> --- a/t/t5558-clone-bundle-uri.sh
>> +++ b/t/t5558-clone-bundle-uri.sh
>
> It isn't exactly related to this patch, but it looks like the second "clone
> bundle list (http, creationToken)" never received any updates to
> differentiate it from the first test with that name (I noted the duplicate
> name in patch 4 [2]). Is it just a leftover duplicate?
>
> [1] https://lore.kernel.org/git/ede340d1-bce4-0c1d-7afb-4874a67d1803@github.com/

I'll be sure to follow up and make these test changes be of higher value,
avoiding these confusions.

Thanks,
-Stolee
