Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1E5C43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D786128A
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 09:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbhDWJrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241846AbhDWJrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 05:47:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2BC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:46:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id x12so52255849ejc.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ekrb7ikh5V4OaUTaOj6NIDtnnBgsdDTo0Ezeh+TSBtY=;
        b=jAshgNt0LovAXBZO/oBvFiL5pZn/BVCXeVrypGyDU8b3MP3tExy7bpxP3XHTUJCClr
         JyYeHeFj98bLLxU12hQh1Maovpl+HHhiA9NWNUzRYcNGeiiTsu2oQTjpnZqa36iK1xTr
         jyh+UxXPNwNeQkPnM4dvZbs2UA9UbeMfG8pfteVFOUO9UcwfWO1k351twMzro+fSkLh1
         ij+lyJYsEvCEHBJZdVINi/c/1GgQerOw5DPuPjfPFoeRK4uunZGs5+lnJsITAi4T1MiX
         XkATr5V8yZzl7R3PJyPe/BFrhIy0OqoVC491zz9plfkBmIZvQbd97XE1lyrf75z1VXiT
         5IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ekrb7ikh5V4OaUTaOj6NIDtnnBgsdDTo0Ezeh+TSBtY=;
        b=lNbvLjxlosUdfx+kNnEcTo7Ow2zwY0ktQgrJBpZn2QJQTs70u5b71TY5lelxgabedJ
         1zJCqykk0wcZL1klAujeFNrupf5C7hFORA0RaaYzdVEaiqdMCwgnmOGvJYFKEkH2t8SY
         T9O0qGF76ARfC6KF6O1+l/H3gn4lp5t5N4pj6W4B4YubfkT+W7wRq+PaOsUzG9Ljecbj
         kWnWpuGkciIXgCoffQ0MFlwCQymYGnkRXdjnLrc3DYeqre+jLuor7jY7HCK9KRuaucjB
         OrZcMV8I/tTM+jESy3Q8r9nUNFYO2t++MJQrTeHALzxfykQJrEmjm1QuyixKqhb2aSn+
         00Ow==
X-Gm-Message-State: AOAM530I9Tp9la30MrYbR6I35mlKiOi8CKccGcXyZHQNPfMeT1yQIQ4g
        D6gp7IXcbtQ+B2tAbLR7hEOp0Sfj4Sg=
X-Google-Smtp-Source: ABdhPJzXHt3kSX07a3H16jnyhm+PSRkmehUsrM2bpUdy3SD+LHGgy0Hnvm8B1Ub+EtbBodukMYTecQ==
X-Received: by 2002:a17:906:6ce:: with SMTP id v14mr3188944ejb.296.1619171185576;
        Fri, 23 Apr 2021 02:46:25 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id i19sm4320643eds.39.2021.04.23.02.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:46:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/4] config: rename "submodule" scope to
 "gitmodules"
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210423001539.4059524-1-emilyshaffer@google.com>
 <20210423001539.4059524-2-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8d27af1f-7fa3-e3a7-f042-2559fc24bc18@gmail.com>
Date:   Fri, 23 Apr 2021 10:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210423001539.4059524-2-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 23/04/2021 01:15, Emily Shaffer wrote:
> To prepare for the addition of a new config scope which only applies to
> submodule projects, disambiguate "CONFIG_SCOPE_SUBMODULES". This scope
> refers to configs gathered from the .gitmodules file in the
> superproject, so just call it "gitmodules."

Am I right in thinking that this changes the output of `git config 
--show-scope`? If so I'm not sure it's a good idea as it would break any 
scripts that are parsing that output

Best Wishes

Phillip

> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   config.c           | 4 ++--
>   config.h           | 2 +-
>   submodule-config.c | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 870d9534de..c8426ef3f3 100644
> --- a/config.c
> +++ b/config.c
> @@ -3499,8 +3499,8 @@ const char *config_scope_name(enum config_scope scope)
>   		return "worktree";
>   	case CONFIG_SCOPE_COMMAND:
>   		return "command";
> -	case CONFIG_SCOPE_SUBMODULE:
> -		return "submodule";
> +	case CONFIG_SCOPE_GITMODULES:
> +		return "gitmodules";
>   	default:
>   		return "unknown";
>   	}
> diff --git a/config.h b/config.h
> index 19a9adbaa9..535f5517b8 100644
> --- a/config.h
> +++ b/config.h
> @@ -42,7 +42,7 @@ enum config_scope {
>   	CONFIG_SCOPE_LOCAL,
>   	CONFIG_SCOPE_WORKTREE,
>   	CONFIG_SCOPE_COMMAND,
> -	CONFIG_SCOPE_SUBMODULE,
> +	CONFIG_SCOPE_GITMODULES,
>   };
>   const char *config_scope_name(enum config_scope scope);
>   
> diff --git a/submodule-config.c b/submodule-config.c
> index f502505566..0e435e6fdd 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -637,7 +637,7 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
>   {
>   	if (repo->worktree) {
>   		struct git_config_source config_source = {
> -			0, .scope = CONFIG_SCOPE_SUBMODULE
> +			0, .scope = CONFIG_SCOPE_GITMODULES
>   		};
>   		const struct config_options opts = { 0 };
>   		struct object_id oid;
> 

