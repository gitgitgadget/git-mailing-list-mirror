Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA571C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 15:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiLPPdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiLPPdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 10:33:18 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E07514D03
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:33:17 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id e12-20020a4ab98c000000b004a081e811beso419317oop.2
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gWqdL4UXbUn4eY5yarRTm39mheTyM2t15LEBscgTGOw=;
        b=jXXoucRwuAL+q88JkSaEh9aGR+BS5tsJxUH/xD8Xr+quTasCc7vrse/rs+iMcNkTYe
         ZAVFfg/NAIk2h5hHrOcAd2fnrTj81/IXMGgRsM/KJnC5p6JvwGpNKMyL6S9KxF9ceAe9
         uJSxqm+XO0eA4mNh9qtggG4GoWYd9ZBv3FvskquYKkGP1vyA84ZnaApQl6WeixnpbB47
         bjPX/ioNAXWFbxw47hqgWWVX0vH1vkxU1+08Jrs+VWMFgHp7yQvsybg7cBS9euTabMp+
         wG+xtrJCGiwj4AyxzXvyRxTMBhRrA9uNQGlkfFkUSCsoP3Qv+Ipcn+jnYbUkYr4uNWVO
         TWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWqdL4UXbUn4eY5yarRTm39mheTyM2t15LEBscgTGOw=;
        b=x6lIO0BtNWXcTuBkB35PFNz9ZX6yUMN/KmekzcXIdUP9yodITI/bF7i/hARno+9erI
         ZV01JLqLfF9qNkI4fPM8d2emEwgotGSAdXjDrAHSj/RKTtv3BLVO6sJdcLd0wv+Mid1T
         PTg9M+pNywvNEIXYeb4hQklbypoWZEtVIvUy6hCZkK7Boe+xZ7HTG3b3jtQ1BgGiOH6T
         XJEqNK6iTzwfTK/Be353UnyfPJYzxhCRTUQkXJnjhp78+Hx4J88qRHy6nv1LHgBak587
         Te9yfqcPBYF4+wJXQp0ikBKooILg16a7VJaihZOsv49oRhyvkvjB/QmXX7uH0W3U7u8r
         Lj/A==
X-Gm-Message-State: ANoB5pkM8aP++gkyw++wpCrzj6qXLPN4KXWPZd8hfprCdlZPsEM7uCKx
        2wd98VfX+10YUD8KKRYUd7lXUX4rSj98cU0=
X-Google-Smtp-Source: AA0mqf7JeKzYQR74+o0QYLKWRtydj7Wc2IGPBLxcgpT4i2boFLZIXYT+3nSTSaivoHoGqNhcE3wMRQ==
X-Received: by 2002:a4a:4511:0:b0:4a0:b23f:a870 with SMTP id y17-20020a4a4511000000b004a0b23fa870mr16432149ooa.8.1671204796442;
        Fri, 16 Dec 2022 07:33:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9410:24eb:9afe:f6a4? ([2600:1700:e72:80a0:9410:24eb:9afe:f6a4])
        by smtp.gmail.com with ESMTPSA id y15-20020a4ade0f000000b004abf3cec5f9sm721568oot.5.2022.12.16.07.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:33:16 -0800 (PST)
Message-ID: <4b4d5c18-dee3-76c6-8c72-db8ac05a046e@github.com>
Date:   Fri, 16 Dec 2022 10:33:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: ds/bundle-uri-4* (was Re: What's cooking in git.git (Dec 2022, #05;
 Wed, 14))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqiliewbje.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqiliewbje.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2022 4:59 AM, Junio C Hamano wrote:

> * ds/bundle-uri-4-fixup (2022-12-13) 3 commits
>  - bundle-uri: remove GIT_TEST_BUNDLE_URI env variable
>  - bundle-uri: advertise based on repo config
>  - bundle-uri: drop unused 'uri' parameter
>  (this branch uses ds/bundle-uri-4.)
> 
>  Incremental fixes on ds/bundle-uri-4 topic.
> 
>  Will merge to 'next'?
>  source: <pull.1443.git.1670866407.gitgitgadget@gmail.com>

> * ds/bundle-uri-4 (2022-12-06) 11 commits
>  - clone: unbundle the advertised bundles
>  - bundle-uri: download bundles from an advertised list
>  - bundle-uri: allow relative URLs in bundle lists
>  - strbuf: introduce strbuf_strip_file_from_path()
>  - bundle-uri: serve bundle.* keys from config
>  - bundle-uri client: add helper for testing server
>  - transport: rename got_remote_heads
>  - bundle-uri client: add boolean transfer.bundleURI setting
>  - clone: request the 'bundle-uri' command when available
>  - t: create test harness for 'bundle-uri' command
>  - protocol v2: add server-side "bundle-uri" skeleton
>  (this branch is used by ds/bundle-uri-4-fixup.)
> 
>  Bundle URIs part 4.
> 
>  Will merge back to 'next'?
>  source: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>

Please do merge these to 'next'. Things have been stable
since ds/bundle-uri-4-fixup was submitted and I'm currently
polishing part 5 on top of that branch.

Thanks,
-Stolee

