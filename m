Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D1FC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 14:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiBXO73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 09:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiBXO7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 09:59:24 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF6F1B0C47
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:58:54 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id ba20so4008757qvb.1
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cM/1tZerJWsD5lKVxgFAacG3nP+SjRBQ+2MYjQ2jL1U=;
        b=CQ00o0IYP+DuVO8Ym6Z3svGqh8agH+NQRz6ozLFH5Khj1vlmlSZc3/Lpnwct4c03XQ
         AnofSfiLABAB3vysrtPbEtF+XurUpKjoVucTSrZMhkONAYZbA/yMX/GLhvDYRzE8ijEq
         wG0FKT6KxiF03amYRGVnV0KR5nTJq7Gr2f8eNrwaikM5Po+oLoCGWgRcUcFh7hz90LLe
         fBgjUCpq0I+SodZRHEg32YGZRuLejrgqdoMQhZMCioRrTvhHz3aanzsf4y6aXgSyikpa
         ftFFhErUZSleHDlWjWPoe/H8tyf+egz7yYFYOrb+QU9+UivJ//1S9wY8yy1gm/XeX5bF
         NtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cM/1tZerJWsD5lKVxgFAacG3nP+SjRBQ+2MYjQ2jL1U=;
        b=gtovHLIyFUDdGtrKSv1+bNVY3K91/AwPNZoxFT7sOU8mub02Jl+/H8akEtOvfgNqbH
         YHlWxTChOf+2aeWMlxecOWTvSa0wOMwPxzuYk0zrLBSvajPHHQxSYR05OutDPlFZ20pg
         ObWGfBrinVVduSeHJut7XSRlkhSZ734Sp+DDSOnHVwdNuTI6764oM/F7mTAwzwreGY7s
         2nKE4Wenul5rqBDww35qtgvvSt4VGLZaSZ4UAH+CKy/YuvMmOpjnPWWGFzLQqJXrUXPd
         5shUSQGTa/tC1EKkw+SfXWcn4etG6dwfpuN+1M2TNaXxyaHBNgrHQcy+U0svqsniIGIA
         32hw==
X-Gm-Message-State: AOAM532b3aV9348peuGF/QizfiBtAD1ccht+ePTSlTk/D84tLvZNKWcn
        aXIYHmDsn2hP+ZkoqkRDQ/vo2GjvLLZo
X-Google-Smtp-Source: ABdhPJyGGPJ9ehcuNGmee+D/4UN75fGcNE6AWG7Ranbhl5LXDlwWZNNCI1WGZ0S7+NHec7eYVY9PGg==
X-Received: by 2002:ac8:5808:0:b0:2de:1cef:65c8 with SMTP id g8-20020ac85808000000b002de1cef65c8mr2666779qtg.33.1645714733872;
        Thu, 24 Feb 2022 06:58:53 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o5sm1595401qtp.48.2022.02.24.06.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:58:53 -0800 (PST)
Message-ID: <ab3d1fc7-e63a-dff4-f373-a6ac32b8294a@github.com>
Date:   Thu, 24 Feb 2022 09:58:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 04/23] t/helper/fsmonitor-client: create stress test
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <9efdbe28223e371dc22b4ba32fc791729af5577a.1644940773.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9efdbe28223e371dc22b4ba32fc791729af5577a.1644940773.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Create a stress test to hammer on the fsmonitor daemon.
> Create a client-side thread pool of n threads and have
> each of them make m requests as fast as they can.
> 
> NEEDSWORK: This is just the client-side thread pool and
> is useful for interactive testing and experimentation.
> We need to add a script test to drive this.

I haven't gotten far enough in the series to know if you
_do_ use this in a test eventually. If so, this NEEDSWORK
could be replaced with a mention of a future change.

> +	/*
> +	 * TODO Decide if/when to return an error or call die().
> +	 */
> +	return 0;

This TODO could be cleaned up.

Thanks,
-Stolee
