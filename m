Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0636EC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiHQOeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHQOeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:34:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F862A88
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:34:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p184so7366324iod.6
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=RxGS5rCLOkfYwUCT8LG/vRQFoXez+z/Xxrmn3R51CYA=;
        b=KzPzvTMjaSfBAR54XVycf/9qOjnCooN259kLgwGZ3FMRGVBoWob7t/7Edrk0iL2rHJ
         iJGXQtxIrviTZHZ7C+raDdT9MO0xyhqY9l33Fd8fwkboXF4QK95LKsVKh8eVZCQRisXi
         J84QJ8r27NHRDguE4ZNUjYdQjoA2/FgVcbg5prc0eWJZFd8Ov9CJWmaHHuAyyUxmTBym
         0B2B+lmAd8+HQeiy4ltzIHvLEU3kZ9LFtan0JTMqni9tLddQtpc3zUAF1mpFyEvOLiE8
         +DIBgGREKDdYflggdVKqIFuHYQk0dvalG7iXIZxaGYU8NbkpezkWxPRXWKPfkvVVwgd/
         Oa4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RxGS5rCLOkfYwUCT8LG/vRQFoXez+z/Xxrmn3R51CYA=;
        b=R9Fn2kTthQINO9WYD9QnUNdA43EKV147RRRt65AS9Te8v/3kx1L5RDfQUoPTz6uxQR
         fdo77jnx9QWakfVzM7k4GsNT8CRjy5zndpO8llluAQ2WVqS+LVvF/pU0ouUyV1zd/HAe
         c+nBCA4irWYXiPEUNRuyouS7q5zISLOY+Gwo5htQOAedFXmU9jImqIW3VZ2OwGjuupDR
         Y6v2rhgVNV24L1QqFihgEAJNNRCtfHySAHQCdyAT515QtFh354k09lR77PK8bMO4s4IG
         jerKE6jQJtMaXDNQtdeN4J5tQo+0Lnc0qdRTQnhukX+HAJTY9BED/6byWy7UJZi8lw+H
         KKFg==
X-Gm-Message-State: ACgBeo38vsdTns4Ckk+EzYrEMooYhr348NlXkbMKpfJdGvbf4CaCDIjS
        NnIUsN07EEagmNQLUN0bM/t3
X-Google-Smtp-Source: AA6agR7b5DlCu5P8ICMoYxHpCnfkIIYUJ03yv4C86oRTaxYQyLI23v/IEV50Msw7QkejJ8wrBQZM/A==
X-Received: by 2002:a05:6602:391:b0:688:8e46:f027 with SMTP id f17-20020a056602039100b006888e46f027mr5116897iov.4.1660746855966;
        Wed, 17 Aug 2022 07:34:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id c19-20020a928e13000000b002e7ff7e5aeasm852397ild.75.2022.08.17.07.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:34:15 -0700 (PDT)
Message-ID: <f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com>
Date:   Wed, 17 Aug 2022 10:34:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 3/5] scalar: enable built-in FSMonitor on `register`
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
 <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5fdf8337972d7092aba06a9c750f42cd5868e630.1660694290.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2022 7:58 PM, Matthew John Cheetham via GitGitGadget wrote:

> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> +		/*
> +		 * Enable the built-in FSMonitor on supported platforms.
> +		 */
> +		{ "core.fsmonitor", "true" },
> +#endif
> +	if (fsmonitor_ipc__is_supported() && start_fsmonitor_daemon())
> +		return error(_("could not start the FSMonitor daemon"));
> +

I initially worried if fsmonitor_ipc__is_supported() could use some
run-time information to detect if FS Monitor is supported (say, existence
of a network share or something). However, that implementation is
currently defined as a constant depending on
HAVE_FSMONITOR_DAEMON_BACKEND.

The reason I was worried is that we could enable core.fsmonitor=true based
on the compile-time macro, but then avoid starting the daemon based on the
run-time results. If we get into this state, would the user's 'git status'
calls start complaining about the core.fsmonitor=true config because it is
not supported?

The most future-proof thing to do might be to move the config write out of
the set_recommended_config() and into start_fsmonitor_daemon(). Perhaps
rename it to enable_fsmonitor() so it can fail due to writing the config
_or_ for starting the daemon. The error message would change, then, too.

Or maybe I'm making a mountain out of a mole hill and what exists here is
perfectly fine.

> +test_lazy_prereq BUILTIN_FSMONITOR '
> +	git version --build-options | grep -q "feature:.*fsmonitor--daemon"
> +'

It looks like we already have a FSMONITOR_DAEMON prereq in test-lib.sh.
Should we use that instead?

Thanks,
-Stolee
