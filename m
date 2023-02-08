Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF32C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjBHV3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjBHV3T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:29:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2A18145
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:29:18 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b5so450366plz.5
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5dEt+9JBTibcAWvW6aZoFMcuYlCEfMNhwV4YfnAHIMM=;
        b=VwFsehYxN046C4EmmtfI8n3XURZSYJVCcYBhO5ejm2RudqqVAV2oqffwrqe6els3d+
         +BOcziop9yO1x1DwM/O1RRCJ57EhscABXJyiXKZVGSh0wuWCiLpFWYA4cha+yZSduuQq
         54AqtGWxMUjn71jUlo6hEs3aQ+onkaTXs+PjVt+owpTTFcoBbjdUH0NHTh340SoDXvVH
         JXu1+GoRjmBQXicrpXgkcaJ3u+0lUk9UL5ZPz1iuFcI+XIaY48SD8DlHz8XMCuCPJnUW
         JHwBwN1rYcjc8kzmvS4Le6m+kh2Zc7IycKyg+lYYhrhRKVnwULz0dth2qyZz96ENINaU
         8PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dEt+9JBTibcAWvW6aZoFMcuYlCEfMNhwV4YfnAHIMM=;
        b=BbyXl9Q9gYRXNbPX9+u0EdpNEO6PF1t6GuF05zgSkrtUNGNs0FQitcvjErFOvWB6ag
         6WhUQGWtNGVjxGXnd5btXms4DolcR/FO8IrbnEDVKFaOcFgWaa/TbLphk0GlmPsb+M5Y
         3kkeru85hy5sH70hkMlfDKYw1EV0NBLfjjMG+BWA+Hhv5hcSrJSmA9O1XevwQVUsxfRe
         nPYnQO7NFWU4Ma9+9NwMLCs6VKKZPY65nKlxvjlJDLMf0E7mDy8be5g81lJeJbPp9jtv
         A3qP5Bn0Hdj7RzrcICHTTQ+vNrbOYOX3x3FVwtEbtqbqXR456Ngk9YtIzZICe0QqmKOo
         khcA==
X-Gm-Message-State: AO0yUKUH3zy0xdqghaFMwAP/hzGmNioOmlaqJ2RCX+qctKBm8bxnybKD
        u0PO+zs6YdAZH/BQuK8PKiaD
X-Google-Smtp-Source: AK7set/iMqS+BlCZ5wHthCdJJp1t9aGlWvohX8x+xTAT9h7+w+9OPY3K6MYZt6OEwh6pFFMRDUzmyg==
X-Received: by 2002:a17:902:f28c:b0:199:109e:81f with SMTP id k12-20020a170902f28c00b00199109e081fmr6950822plc.57.1675891757976;
        Wed, 08 Feb 2023 13:29:17 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902a41200b00198d5c7cafasm11529254plq.156.2023.02.08.13.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 13:29:17 -0800 (PST)
Message-ID: <9012b8a3-4abe-d3c6-41ee-f28931869ad7@github.com>
Date:   Wed, 8 Feb 2023 13:29:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v8 0/3] Enhance credential helper protocol to include auth
 headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> Updates in v8
> =============
> 
>  * Drop custom HTTP test helper tool in favour of using a CGI shell script
>    and Apache; avoiding the need to implement an HTTP server.
> 
>  * Avoid allocations in header reading callback unless we have a header we
>    care about; act on the char* from libcurl directly rather than create a
>    strbuf for each header.
> 
>  * Drop st_mult overflow guarding function in curl callback functions; we're
>    not allocating memory based on the resulting value and just adds to
>    potential confusion in the future.
> 
The core functionality change in this series (passing through
'WWW-Authenticate' headers to credential requests) didn't change much
between v7 and v8, and what was updated was a net improvement [1].
Otherwise, the new test infrastructure is concise and made for an easy
re-review; I had one small suggestion for patch 1 [2], but it's not critical
enough on its own to hold this series up. I think this could probably be
merged to 'next' as-is, but a final re-roll with some of the minor fixups
suggested in other reviews wouldn't hurt either. 

Thanks again for the time & effort you've put into perfecting these patches!

[1] https://lore.kernel.org/git/983fc35b-55e8-50df-5035-191a10b4ddac@github.com/
[2] https://lore.kernel.org/git/87f79e79-1591-ca28-4975-3bca5b8f7266@github.com/

