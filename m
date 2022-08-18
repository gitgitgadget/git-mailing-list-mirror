Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBDC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbiHRPAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbiHRPAV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 11:00:21 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8132BA4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:00:20 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11c896b879bso2074582fac.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=e7hYV0q9iipvui8WNoP5Uds/JpBvpFThW0Ax24faISg=;
        b=ElC69DQO0ZRgCDBlXI6hgCfLjviAN0j6z6LXZcep7U3M9YnnTDXiYPcJrLNwSfMw6d
         AIVC76wwi7KC7RP7057guB/t81L5oqAO62Fg8PexzpE5jbGRq5uT1N2hlUJ3+tqfAJmK
         6xJcl/CWxdJBIn5sdVMDb1qIwOZM+AK2V6oUtgm3TxzxV7PvbxBlJWjIud0HGATijfr7
         Hm3FuWM1FL202yA3YwJzXfB69g4QrAuwL77feP4njNVOkTiz2mg+932fyEQYdLc0A6gX
         3AnFwDmKbJfchkaiviZwNC766XI12fuy6rt6RQioJkJJD8Mnx1A91dVKgyRKPQaF7b3d
         EEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=e7hYV0q9iipvui8WNoP5Uds/JpBvpFThW0Ax24faISg=;
        b=250kQS+a1sHqz2aTb1E1cMxQ+zMcIvj4NnUcuNLCpeSgU8/Gqc89d02Zyqs4pqxPOe
         T7HxPJGQaJDVgyeHx9MPHenKc7sGKWkUsCe0srk2MgqAxAQETYPJp+CC0YJk0zbFVWV6
         SCz4yCtOT/Ni/ZGBCZM1ODPBOng+pl0lMj+/UB+QM1lYFcVNHF+uYL2n9/VZNORHV8/A
         UsQPS5wqdLtIuNm1X0Cy89WzKnnmz46Jw4W/8qYJOl0RgP6A/5SM4p++af6f2MbJSsKB
         3nFzsF2+iKE/4gTmQrXnCOf7IHusLDA6Rtm9Ppr9NNcE0X1O4hdtz+Vq9L4T/RiwisWF
         8Vxw==
X-Gm-Message-State: ACgBeo2vs1sZAFgBvuXfDjmceZ/5yb0VxsM/NZVxrCXT1NSsuGgasyuK
        IjwmDBCcYkjeY1d7cpe1V70A
X-Google-Smtp-Source: AA6agR44YhpskuY0TJ7JqCIgvsZWzmSK6H9zPIEWIXKDwFLL9b5LLL6Nb1iIpoaRIDrgOhoHfSR9xQ==
X-Received: by 2002:a05:6870:a18c:b0:118:5b96:1cc4 with SMTP id a12-20020a056870a18c00b001185b961cc4mr1553151oaf.290.1660834819630;
        Thu, 18 Aug 2022 08:00:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6? ([2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6])
        by smtp.gmail.com with ESMTPSA id m9-20020a056870058900b0011bb6582378sm477515oap.51.2022.08.18.08.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 08:00:19 -0700 (PDT)
Message-ID: <fbcb87f4-00fa-3371-e108-a104be7ae501@github.com>
Date:   Thu, 18 Aug 2022 11:00:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: ds/* (was Re: What's cooking in git.git (Aug 2022, #06; Wed, 17))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq7d36s31e.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d36s31e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 10:23 PM, Junio C Hamano wrote:

> * ds/bundle-uri-clone (2022-08-10) 5 commits
>  - clone: --bundle-uri cannot be combined with --depth
>  - bundle-uri: add support for http(s):// and file://
>  - clone: add --bundle-uri option
>  - bundle-uri: create basic file-copy logic
>  - remote-curl: add 'get' capability
> 
>  Implement "git clone --bundle-uri".
>  source: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>

This series has been stable for a while. Please consider merging it
to 'next' when you are ready.

I have part 3 ready to go when this is merged. It will cover the
parsing of bundle lists through the existing 'git clone --bundle-uri'
option.

> * ds/decorate-filter-tweak (2022-08-05) 11 commits
>  - fetch: use ref_namespaces during prefetch
>  - maintenance: stop writing log.excludeDecoration
>  - log: create log.initialDecorationSet=all
>  - log: add --clear-decorations option
>  - log: add default decoration filter
>  - log-tree: use ref_namespaces instead of if/else-if
>  - refs: use ref_namespaces for replace refs base
>  - refs: add array of ref namespaces
>  - t4207: test coloring of grafted decorations
>  - t4207: modernize test
>  - refs: allow "HEAD" as decoration filter
> 
>  The namespaces used by "log --decorate" from "refs/" hierarchy by
>  default has been tightened.
> 
>  Will merge to 'next'?
>  source: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>

This has been stable for a few What's Cooking mails. Should be
ready to go.

Thanks,
-Stolee
