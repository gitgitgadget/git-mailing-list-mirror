Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03EFB1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754821AbcH3Oy6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:54:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34235 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752703AbcH3Oy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 10:54:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so3538346wma.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KWA5qjps5B92PaFDW1qBNdSqV0zRPZ0Scbm6bZnd4s0=;
        b=bXZ3dPWNyDqLdcGfQk8wsl40cRj/e/xpqZTRGWlo43BUl2b6HI/u0EIztMoQOnZ+BB
         GpmusVJ+EYQSYgOKFUlGiRN4+AQ/iqJe9+1+q3GBK1jQFN8xbIbcY14S9LFxcoQQz86z
         jJc1qoRjNumYjhXh3AJEhGbC7LALQJLo4xz6VIhEwREj8HacElF4X9Bz9fiJ0syNjFBm
         fwyF0SKUUnoWO/01mO74CKi9e5KG5icWtQcpf1G7H+i2lE3XuDfsURYZe2qJberFoKo/
         6ud4hKqcqW686r1d4noMp/x2c+QGyRxT4TXb6djoMptRjBRLXS87tIHO9IMoWWwo2guc
         gxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KWA5qjps5B92PaFDW1qBNdSqV0zRPZ0Scbm6bZnd4s0=;
        b=C7FbJhzLzVt25E1SCQfocV7uWru2TdNPsoedn2L+0XMclqlG+YUr+FBoXi0yygz/N6
         ulHmXfWVheBURtYd94OQ6dU2vDnKkAk2yjeRW+5hY/Gl1/JL5rC8BJp3zgMkcVS4JVAi
         ieg13cjMV5B7oJGeYeN0yoJ5HWmqQ3boTSW6DjGUwsYpqt9r6OzlHa4Nd3EeTCTyfYcE
         kqcSfml80vJjWA+y3nTrYr2mWhWE0z2rPuBns7Z6mcpSRaPlSNcvC0SwN3y/CUTJpp6W
         Oo7Ht6Ea4HGGlBLWD8LZ6AHrsKIAImBotSfXhacRlGiipOjJIY9rlRDfFVhNmvkSidhs
         mQyA==
X-Gm-Message-State: AE9vXwO8dZ/Ta8aHcNA6GD8yiqPQRVMEh0adICH4pEhKr4K+2GNBdLwHtaM0a6eC4zvWag==
X-Received: by 10.194.75.225 with SMTP id f1mr3657694wjw.104.1472568895632;
        Tue, 30 Aug 2016 07:54:55 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id z17sm4304712wmz.23.2016.08.30.07.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 07:54:54 -0700 (PDT)
Subject: Re: [PATCH 06/22] sequencer: release memory that was allocated when
 reading options
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <9797cb9e-115c-bbea-51d2-a5d686aca514@gmail.com>
Date:   Tue, 30 Aug 2016 16:54:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <e4b48a9a73ff33179556c0137caae85bfb4a48d9.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:

> The sequencer reads options from disk and stores them in its struct
> for use during sequencer's operations.
> 
> With this patch, the memory is released afterwards, plugging a
> memory leak.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index b5be0f9..8d79091 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -131,6 +131,8 @@ static void remove_sequencer_state(const struct replay_opts *opts)
>  		free(opts->owned[i]);
>  	free(opts->owned);
>  
> +	free(opts->xopts);
> +

This looks like independent change, not related to using the
sequencer_entrust() to store options read from disk in replay_opts
struct to be able to free memory afterwards.

I guess you wanted to avoid one line changes...

>  	strbuf_addf(&dir, "%s", get_dir(opts));
>  	remove_dir_recursively(&dir, 0);
>  	strbuf_release(&dir);
> @@ -811,13 +813,18 @@ static int populate_opts_cb(const char *key, const char *value, void *data)

Sidenote: this patch would be easier to read if lines were reordered
as below, but I don't think any slider heuristics could help achieve
that automatically.  Also, the patch might be invalid...

>  		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.mainline"))
>  		opts->mainline = git_config_int(key, value);
> -	else if (!strcmp(key, "options.strategy"))
> +	else if (!strcmp(key, "options.strategy")) {
>  		git_config_string(&opts->strategy, key, value);
> +		sequencer_entrust(opts, (char *) opts->strategy);

I wonder if the ability to free strings dup-ed by git_config_string()
be something that is part of replay_opts, or rather remove_sequencer_state(),
that is a list of

	free(opts->strategy);
	free(opts->gpg_sign);

And of course

	for (i = 0; i < opts->xopts_nr; i++)
		free(opts->xopts[i]);
	free(opts->xopts);

Though... free(NULL) is nop as per standard, but can we rely on it?
If it is a problem, we can create xfree(ptr) being if(ptr)free(ptr);

The *_entrust() mechanism is more generic, but do we use this general-ness?
Well, it could be xstrdup or git_config_string doing entrust'ing...


> +	}
> -	else if (!strcmp(key, "options.gpg-sign"))
> +	else if (!strcmp(key, "options.gpg-sign")) {
>  		git_config_string(&opts->gpg_sign, key, value);
> +		sequencer_entrust(opts, (char *) opts->gpg_sign);
> +	}
>  	else if (!strcmp(key, "options.strategy-option")) {
>  		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
> -		opts->xopts[opts->xopts_nr++] = xstrdup(value);
> +		opts->xopts[opts->xopts_nr++] =
> +			sequencer_entrust(opts, xstrdup(value));

Nice.

>  	} else
>  		return error(_("Invalid key: %s"), key);
>  
> 

