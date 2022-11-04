Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EABC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 01:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKDBc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 21:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKDBc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 21:32:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759B10B43
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 18:32:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt23so9741983ejc.7
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 18:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYK3NHMaBnaKZVD2Nolab03hDOWyfnrgIdEwwXttQDA=;
        b=IvXjZMI8QHOpxduJ+FTmhMUgTjbY14bSjphEThqQiBdA0UemSorlxgj/GkS+ydx6FJ
         0iI7mOMBl7eIZG0OWW3g2aMpZGuUbGhgMjIPKcrnzugXZDXKr1d2bg5QAA1Em5NjyLMJ
         xk+BKdWwQNOKx1M4Al66sAc1JmhTlGLYsdhTQc54czt7w5rjdG65tiLYft1zf3L/hAfx
         oBp39od/zzVA8G0LneJtW11W96oIHcekHCs7eICzPQYjQFKtk0bqreIPvMbZDtYUBWJ4
         s5GAi/K1PRXrDNetlq+SllKN4G2/7k1414VmyNjD41UjnCRsjpPZ8Wcu2HaPlwBWHZpf
         tz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYK3NHMaBnaKZVD2Nolab03hDOWyfnrgIdEwwXttQDA=;
        b=ODv6jhmHZfXIemNEDGS9Kn64wXmmHDs/cRWf3IaKo3uMFeyDZ0h+Fdu+OmRkVaCT3y
         h6wZXUW9JJRQG7vNYYNsUSjRdm9gNBtz3iNkfYlwknYT6DdEUOFsCSO/O5Qf9aOH63Mo
         L1xQyj8rOYqucFPM0TiabW67VM5MbODtf5E/WbeLadw1D+j5Nq7LKhl/t3Z0jXDnUQK9
         i2rAW87V2P3l+IBeU9Dw4Y5TTUc6p3VQM6VQjiJRAjX2SjoFbW8f6797JDWYOPp0HSry
         k5X4ziBHTeFyaWm+jY2thtsLaDXmxU2pZeb7CJVcuiG8bZIFU6v2JBYaFx1sL733/hdk
         emaQ==
X-Gm-Message-State: ACrzQf3goCGCuZSgUkOnwhxjU+POHknqosftgkUI+O/3C+kF+nhbQp4K
        RX0VcK/twWQa90DDdT9iv+ePJnHZMlVW+Q==
X-Google-Smtp-Source: AMsMyM6RYFXn0aX9dmUARKAhI08Shpvz1Q461ZKzxLWOn/zj4JTmq1PofGCBfBxCoNAXac1rif/uCQ==
X-Received: by 2002:a17:907:6095:b0:78d:bb0b:c34d with SMTP id ht21-20020a170907609500b0078dbb0bc34dmr31987891ejc.662.1667525553059;
        Thu, 03 Nov 2022 18:32:33 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id fk27-20020a056402399b00b00459148fbb3csm1205183edb.86.2022.11.03.18.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 18:32:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqlZQ-00D1dP-0Z;
        Fri, 04 Nov 2022 02:32:32 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/worktree.c: Update checkout_worktree() to
 use git-worktree
Date:   Fri, 04 Nov 2022 02:32:11 +0100
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104010242.11555-3-jacobabel@nullpo.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221104010242.11555-3-jacobabel@nullpo.dev>
Message-ID: <221104.86sfizzeq7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Jacob Abel wrote:

> Updates the function to call `git checkout` instead of
> `git reset --hard` to simplify adding orphan support.
>
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index b3373fbbd6..d40f771848 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -357,7 +357,7 @@ static int checkout_worktree(const struct add_opts *opts,
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	cp.git_cmd = 1;
> -	strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
> +	strvec_pushl(&cp.args, "checkout", "--no-recurse-submodules", NULL);
>  	if (opts->quiet)
>  		strvec_push(&cp.args, "--quiet");
>  	strvec_pushv(&cp.env, child_env->v);

Won't we now start to run the post-checkout when doing this, and is that
intended?
