Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1371FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdFGRvZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 13:51:25 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35951 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFGRvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 13:51:25 -0400
Received: by mail-pg0-f53.google.com with SMTP id a70so7653105pge.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/bREPe35eR9m+5hF3eMNLaRZXjHA1I9B7wncKl9kZgg=;
        b=u9FWs/PwUoP+5wmLELt3yYJEw6WR5hVoTblk9I8Lq9MNkA172/EA3PDtY0TFfcFDTT
         MZJnnb0lDzKJQIQECpLMswkrkXPYL0j26NUeB3EktN8whM9GCvOkLeKict9z60TAGI1R
         1DzOLEQLQvalgsBfPRX6HJ/dm7a5GpgouL51tqf7vNqcVt7gvIyVjTNozKZkIWCW0PJc
         Nd71xn+cOTwsEjiCqc14tSEhspTeGiHsncNAfqoSaEaSxldklAhm8ALt7wqyNqlDCS5U
         EQCCnsOFRZ9OsGpB1CHi+hVggEagUv6gC9WL/AhT6R2lc1XvrMTE/jPI1OisF7wZl2Px
         puXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/bREPe35eR9m+5hF3eMNLaRZXjHA1I9B7wncKl9kZgg=;
        b=pIhVzJW2n1+xYZqZU74SjiaTh2fH3RmpjeMNYNM3VL4Xu1MHet3PfonyFr48bz9nl7
         ltxV+kM+VHK73CZrcVvYqPoiYyhP1udsp3HqUIRQOkPrAK42juAUpUVZZQifVJ/rYp1o
         3YRT+BE2YKqaL+9bPd807nsbvetV7YaRRmiam/qsm03zZk4uwLlYI19cbbgT87txV6Ly
         DA9mH/c3Ib+lTc/gDNSKSoDXuLUtnoCVLcYxjbT67mPFJo9LqYieXZw/qxE+G9kNDINQ
         yR4OfEgf8j974ovCajsYVS7mmPWoczxHhY/o1PAj6oWM0RpNZLxqmaB1syg19L/hvF57
         EcGQ==
X-Gm-Message-State: AODbwcByLN1Sm/GlP0zedlz4Rw+GQt71P4F9XCZ1P3fK3Hw78O6kMM4W
        n5dRq3AMc1wHh74y
X-Received: by 10.84.192.3 with SMTP id b3mr16669950pld.76.1496857884274;
        Wed, 07 Jun 2017 10:51:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id a187sm4918189pge.45.2017.06.07.10.51.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 10:51:23 -0700 (PDT)
Date:   Wed, 7 Jun 2017 10:51:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] help: use early config when autocorrecting aliases
Message-ID: <20170607175122.GC110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <d7b77cbd688b7536aebee49df652af594d2a1293.1496851544.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7b77cbd688b7536aebee49df652af594d2a1293.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Johannes Schindelin wrote:
> Git has this feature where suggests similar commands (including aliases)

nit: s/where/which/

> in case that the user specified an unknown command.

s/that//

> 
> This feature currently relies on a side effect of the way we expand
> aliases right now: when a command is not a builtin, we use the regular
> config machinery (meaning: discovering the .git/ directory and
> initializing global state such as the config cache) to see whether the
> command refers to an alias.
> 
> However, we will change the way aliases are expanded in the next
> commits, to use the early config instead. That means that the
> autocorrect feature can no longer discover the available aliases by
> looking at the config cache (because it has not yet been initialized).
> 
> So let's just use the early config machinery instead.
> 
> This is slightly less performant than the previous way, as the early
> config is used *twice*: once to see whether the command refers to an
> alias, and then to see what aliases are most similar. However, this is
> hardly a performance-critical code path, so performance is less important
> here.

Agreed, and it is more important to be correct than performant.

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/help.c b/help.c
> index db7f3d79a01..b44c55ec2da 100644
> --- a/help.c
> +++ b/help.c
> @@ -289,7 +289,7 @@ const char *help_unknown_cmd(const char *cmd)
>  	memset(&other_cmds, 0, sizeof(other_cmds));
>  	memset(&aliases, 0, sizeof(aliases));
>  
> -	git_config(git_unknown_cmd_config, NULL);
> +	read_early_config(git_unknown_cmd_config, NULL);
>  
>  	load_command_list("git-", &main_cmds, &other_cmds);
>  
> -- 
> 2.13.0.windows.1.460.g13f583bedb5
> 
> 

-- 
Brandon Williams
