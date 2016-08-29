Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885F01FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755784AbcH2V7w (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:59:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35123 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755123AbcH2V7u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:59:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so549036wmg.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DiNRjLX4blitVPN6RbV+SN+fcPrOddRdQJupFkO1RgI=;
        b=I9hZRbAvqsdcX/hkdW7Dp24wl7kbTa9dXliFCYeZeKpoCqvu6WYgWFjrGOPypcGUK2
         Yity2dFr1d1gAuRBlJjg3gDhvvxDctYB5+oaP/BwISz6PCZPXgn6kFPeQb3hvrFF3Lx4
         owqkJ9tSZimeYubieoEi614CIj+bvKG6YFidvCFCWPUIMEHq/RRkwYhm02bJFRSKkXDN
         IB+/7sylnjz3gFLsZTCijYYpasAlmxYaBDzvjU5wl1eS6wSCZ8W4Hl1Urh+RpASShR58
         9Qo2hoHuh4jFeFdB/5WE7gZ0h6lQHdx0+1jhaqyM1SLBU9F6G9qYsvuNC6nH9+Z+0tfs
         7+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DiNRjLX4blitVPN6RbV+SN+fcPrOddRdQJupFkO1RgI=;
        b=a17TeIkVx03NRsd4dU2gG29pZa5hhhKqcdf0Gf/zimgqv4Cg5u3DRwnnqlgVPNcWzc
         VIs2BRD/dmnuCrPsKV8YgpgxAjmbQwkbeof70wIYTx5bsK8Zopt68wO28JaBeCHF77XL
         tsz7nfyID5guyWaIbwqYrkiUmXsT11c1Mv+eooiqnI1LLWIvIJ664CTrBdqbC4zPor00
         yWrEVuzCAzmVR8sNES6iMBgw7+GmI0myrhEEWdY75m7meN1cqqRNp8Gg1Ez/hSYiji59
         +lsAnyaZlFPoNwPhIcfi8z6cPYbBZ4oleGUqndouRRiA17AOdfPPGHu1AjrmSgEvd6Y9
         V9XA==
X-Gm-Message-State: AE9vXwNWn/HqQKtIKRxfxg0RZ7PCn/1S0uKuKh2a1PwHvqyf3Y1omEUSRzh7+YK8QXzlag==
X-Received: by 10.28.148.148 with SMTP id w142mr13033200wmd.48.1472507987268;
        Mon, 29 Aug 2016 14:59:47 -0700 (PDT)
Received: from [192.168.1.26] (afz108.neoplus.adsl.tpnet.pl. [83.25.155.108])
        by smtp.googlemail.com with ESMTPSA id x203sm15428945wmg.0.2016.08.29.14.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 14:59:46 -0700 (PDT)
Subject: Re: [PATCH 05/22] sequencer: allow the sequencer to take custody of
 malloc()ed data
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <733a899a-470b-79b3-b059-b38313a7057d@gmail.com>
Date:   Mon, 29 Aug 2016 23:59:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <e4e7eab3d0610faa9d3173a585902e50128d8e15.1472457609.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 10:04, Johannes Schindelin pisze:

> The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
> like a one-shot command when it reads its configuration: memory is
> allocated and released only when the command exits.
> 
> This is kind of okay for git-cherry-pick, which *is* a one-shot
> command. All the work to make the sequencer its work horse was
> done to allow using the functionality as a library function, though,
> including proper clean-up after use.
> 
> This patch introduces an API to pass the responsibility of releasing
> certain memory to the sequencer.

So how this API would be / is meant to be used?  From the following
patches (which I shouldn't have to read to understand this one)
it looks like it is about strdup'ed strings from option parsing.
Or would there be something more in the future?

Would sequencer as a library function be called multiple times,
or only once?


I'm trying to find out how this is solved in other places of Git
code, and I have stumbled upon free_util in string_list...

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 13 +++++++++++++
>  sequencer.h |  8 +++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index c4b223b..b5be0f9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -114,9 +114,22 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	return 1;
>  }
>  
> +void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use)
> +{
> +	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
> +	opts->owned[opts->owned_nr++] = set_me_free_after_use;
> +
> +	return set_me_free_after_use;

I was wondering what this 'set_me_free_after_use' parameter is about;
wouldn't it be more readable if this parameter was called 'owned_data'
or 'owned_ptr'?

> +}
> +
>  static void remove_sequencer_state(const struct replay_opts *opts)
>  {
>  	struct strbuf dir = STRBUF_INIT;
> +	int i;
> +
> +	for (i = 0; i < opts->owned_nr; i++)
> +		free(opts->owned[i]);

I guess you can remove owned data in any order, regardless if you
store struct or its members first...

> +	free(opts->owned);
>  
>  	strbuf_addf(&dir, "%s", get_dir(opts));
>  	remove_dir_recursively(&dir, 0);
> diff --git a/sequencer.h b/sequencer.h
> index c955594..20b708a 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -43,8 +43,14 @@ struct replay_opts {
>  
>  	/* Only used by REPLAY_NONE */
>  	struct rev_info *revs;
> +
> +	/* malloc()ed data entrusted to the sequencer */
> +	void **owned;
> +	int owned_nr, owned_alloc;

I'm not sure about naming conventions for those types of data, but
wouldn't 'owned_data' be a better name?  I could be wrong here...

>  };
> -#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL }
> +#define REPLAY_OPTS_INIT { -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 0, 0, NULL, NULL, 0, 0 }

Nb. it is a pity that we cannot use named initializers for structs,
so called designated inits.  It would make this macro more readable.

> +
> +void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use);
>  
>  int sequencer_pick_revisions(struct replay_opts *opts);
>  
> 

