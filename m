Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D85DC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8523C60EFF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhJYQWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhJYQWI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:22:08 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2482C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:19:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j10so10253402ilu.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zQ4BEt2/bM8NRfuEoVEDwzsFlMP+rhxMLPZ7T9XW6+Q=;
        b=MomCH4YT7GwnIVJ5W/eQTOgxkVnboYAvuGub33UAWKDWoeD9nv8VimPY2ZD2U1s9pL
         dJI5mcTJXArGtqnRaPrBLgyJ8CevSSCpeXQnCb+OBmUxYM9OZQpj2dvKuvBeNuJS8zDo
         pLmO5fyiKSeJGtDWx+P1yj+Xhg057WTM1VA0P68QRX3XJALKRi7CFqUMoxsNoqm0ate0
         2axHg9Y5ACIpZdXG9gw6pFz5t8dud7pe6jAi9ojoaIr9W3ajcdXtXlCVCAek+DjvpZQz
         0OpxoisLLMNbX59BUldnwS3/Pf8ZqZaC2GReHNihLTRbi01fO9B7x4Xos5tVJeLpw6Cu
         ofsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zQ4BEt2/bM8NRfuEoVEDwzsFlMP+rhxMLPZ7T9XW6+Q=;
        b=oCeu5yNAzLXFC2r29cUA5VsSJskV0PKqntgfIrZlJ7HAvnwyQkmWHT7Y10ko9n2IXj
         UyGGLxQhIp/knxbtUsKFRNveLBX1xX3umvxCZL2Z16Z4bMgR7Hw5oO7ZjNio4bAcS27M
         Zk1vmQl5mUHeK4q4nigsgn4VqvYeRVWCAfi13t3XY6P+fhWksJcy+XhIlIluKCp7MOdT
         KXxIZwh4AHeA9HJeJwoD8iW0d78ZJTsJQL/voimN/cBXSYncjcgvdrTtikTaDhee1BoK
         SytT1WP5hH0Iqlu1mggwWm6cxeOvAJrk+UwelsWbd6HhxOhbOUUGSfD+Iwk+mFFRU+3i
         6fvQ==
X-Gm-Message-State: AOAM5305+G5MLobHJzBwipRUAvGgK33f24zWbh+aRjV7nl9IM6ELe983
        PjS7+71kMjtRoeF41eiKy3yp57KW2P4=
X-Google-Smtp-Source: ABdhPJySXbCWQ3qDq5LDBSrDqvQX1v7GMz05xgi04vawq+8ynZyY670P2EN2p8iTixBjve8axP4A0w==
X-Received: by 2002:a05:6e02:1562:: with SMTP id k2mr331711ilu.167.1635178785359;
        Mon, 25 Oct 2021 09:19:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b594:8626:d264:bb0? ([2600:1700:e72:80a0:b594:8626:d264:bb0])
        by smtp.gmail.com with ESMTPSA id r17sm8344804ioj.43.2021.10.25.09.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 09:19:44 -0700 (PDT)
Message-ID: <911ab2c1-8a11-d9d0-4b28-fc801112f6da@gmail.com>
Date:   Mon, 25 Oct 2021 12:19:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 0/4] cache parent project's gitdir in submodules
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20211014203416.2802639-1-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211014203416.2802639-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2021 4:34 PM, Emily Shaffer wrote:
> Since v3, a pretty major change: the semantics of
> submodule.superprojectGitDir has changed, to point from the submodule's
> gitdir to the superproject's gitdir (in v3 and earlier, we kept a path
> from the submodule's *worktree* to the superproject's gitdir instead).
> This cleans up some of the confusions about the behavior when a
> submodule worktree moves around in the superproject's tree, or in a
> future when we support submodules having multiple worktrees.

I like the new design!
 
> I also tried to simplify the tests to use 'test-tool path-utils
> relative_path' everywhere - I think that makes them much more clear for
> a test reader, but if you're reviewing and it isn't obvious what we're
> testing for, please speak up.

I found these changes to be well motivated.

> I think this is pretty mature and there was a lot of general agreement
> that the gitdir->gitdir association was the way to go, so please be
> brutal and look for nits, leaks, etc. this round ;)

My main concern was also brought up by Jonathan: the concerns around
worktrees are not fully fleshed out. We should avoid a NEEDSWORK, and
there is a way forward using a subprocess even if we find it is
difficult to find the correct config file in-core. In-core is preferred,
but it's good to have options.

Thanks,
-Stolee
