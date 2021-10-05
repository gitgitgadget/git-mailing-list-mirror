Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F6BC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AA461501
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 17:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJERpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJERpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 13:45:16 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F651C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 10:43:25 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id n63so296738oif.7
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+o3nLzfBJmqDL391s1VICKUT4YFjrVS6BP1S/pb5lmk=;
        b=cmgT+oScrJS2Drp0UR0nvRhEmUcrlAn0rqB6/Cgo4SHdQ0LInTNFbM3Ea4qkUoJqSF
         CCJQIrJUYLla1kJeBNeXoN/kNY37qqtFm/djJmAZ3zH4BtPJL1v1j8bNX+YSXLiKl7Jw
         x28eCgULUwYhDaKmZV1WfbWCX+nekP2RDHwEta3Y6GZZvWXQ7PCIrGPFrID+AGJOKJ/R
         P9LkGEkOX+r+x3IdYQ+7Nsh1n6a2wd2KXZCHgIRC7JsHpa/ZA39W3O/6RjdiR+W65hNY
         QS0jg/omG+kGedr//MdycczAYbFRYy8xJ40h7mFjmbt2vfZHyZZZpGA5pwgiR6JSp/1y
         8lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+o3nLzfBJmqDL391s1VICKUT4YFjrVS6BP1S/pb5lmk=;
        b=h9+XWeK160ZuY/FsgvEVb7bYPu27BHTEYoJbRASllNYPwMGj9rSbgcv/t0Yf9SHHb2
         dNd6y2zyNBwSzrrTVUiivGCH8BG+h/sBjBDv8l3MfYezhn7KPDRAnXreI84yiqym+XdJ
         37V3eUpOwJBR+aRsr5nwxEXP82Ob9tfd//tCa1/DyVOAA9kHzuydx+9AtEIBMKiGU5bX
         AenuYwM+plf2JrlfyNny/wbZF+iQNik28dX0rvXb+C1Q6hjVJqmmuXaiHeSUHfxCLpG/
         mwA7wl9f7U98nH1KeNkVLViphxI/QofIz0y4C6cv6wwQhRT9MWOBhC1xyUDryz6pCGv+
         nxaQ==
X-Gm-Message-State: AOAM532QsJqbLjC6b+sdqoXDS/x5mZvnr67CFcY1tjzs2jPWfTnK7wHP
        YK25T+Yv/k4223ulZdJkqyQ=
X-Google-Smtp-Source: ABdhPJzRvYqM8S7GgDJFabrvFLXcLSgtnyV7XncR854y3YaBXtam2z7OzRh9r/NPdM35EtCAA3ySlA==
X-Received: by 2002:aca:2116:: with SMTP id 22mr3756492oiz.146.1633455804502;
        Tue, 05 Oct 2021 10:43:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5589:eba2:f5ec:ffb9? ([2600:1700:e72:80a0:5589:eba2:f5ec:ffb9])
        by smtp.gmail.com with ESMTPSA id e16sm3403444oie.17.2021.10.05.10.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 10:43:23 -0700 (PDT)
Message-ID: <70aca052-716f-40ed-47c4-1882fdbd221e@gmail.com>
Date:   Tue, 5 Oct 2021 13:43:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v3 0/3] Use default values from settings instead of config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20210917225459.68086-1-chooglen@google.com>
 <20211005001931.13932-1-chooglen@google.com>
 <87lf37ll4k.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <87lf37ll4k.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2021 7:57 AM, Ævar Arnfjörð Bjarmason wrote:

> Subject: [PATCH] WIP gc/maintenance: just call prepare_repo_settings() earlier
> 
> Consolidate the various calls to prepare_repo_settings() to happen at
> the start of cmd_maintenance() (TODO: and cmd_gc()). This WIP commit
> intentionally breaks things, we seem to be lacking test coverage for
> cmd_gc(), perhaps since 31b1de6a09b (commit-graph: turn on
> commit-graph by default, 2019-08-13)?
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/gc.c            | 5 +----
>  t/t5318-commit-graph.sh | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 26709311601..f59dbedc1fe 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -695,7 +695,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		clean_pack_garbage();
>  	}
>  
> -	prepare_repo_settings(the_repository);
>  	if (the_repository->settings.gc_write_commit_graph == 1)

I think that removing these calls is dangerous. prepare_repo_settings()
already returns immediately if the repository already has its settings
populated. The pattern of "call prepare before using a setting" is a
safe way to future-proof the check from a movement of the call.

Putting that potential-future-problem aside, I don't see how this
change is a _benefit_ other than fewer lines of code, which is not a
quality measure in itself.

Thanks,
-Stolee
