Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC23C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDAD6144E
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 18:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbhDWSdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhDWSdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 14:33:16 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A473C061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 11:32:39 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d19so14857211qkk.12
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9hTHvSxfwrYwRlOb8hOqz7gxdwfgDKA/gGCDhr9TBTw=;
        b=TPtKAqQZZGVa9Vihrjiv3xOfmWfe84XGBwCjA/F+cXlhwXDxg57ZIc9joqhl1xfUUv
         H1OoQ/x8lcgdSqdxcms/pCzPkSdOL9VzxDDv7NTaaTQq35vhqJPwHDA6aKO9lgnHcmi5
         TUBqMayrNYEzg9yIkG5vzNN5UgobyNw2pgg18548XBF3tM4HzgHXWScSztvXtAGB1sj+
         3cdiK+8n7mOp/fgCkQvNGP5fX9enoDWBOxCK67dIqWL8ZSD6iBT5eexpfpccQ4686tRj
         xlmP5RgVXSfZi5hdRfc6+RIRbXkKuCWOrLXBsxmdQ7/tZEEsrGTh8jQgOasLyY2fLIPX
         cCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9hTHvSxfwrYwRlOb8hOqz7gxdwfgDKA/gGCDhr9TBTw=;
        b=WLDpoA6y11m6GqNhI/p+ngIbMbx4Vxt/t2X/NhZVm89q6ithCU9J9z0p+N4/yrDaEP
         B4j/NgxPYhrKLwW6h91YCMlJ0xHENIR+l4nMA3NBr6ygDQzIAkjTpPvavrCq1SYA76ZT
         oGcPEm6UVpmZPQQ2l2eorb7x1iepNnkgRyzUuNFGtaEdNnBdkCIrOm2okqMwOyp9kSrs
         /8wldLWgx+uQ8aq4YoJmmXS4jDJ/qqB+KJWlqFb4mUcgXr8vFD+OA1BlF76eZ3IQ1Dgr
         7bnYzw7neFKQyM5L922++XHLcfLWVmQ6crERw1zn7lTMgtJ5y15eoJO69PSwl+aQgf+J
         eL2g==
X-Gm-Message-State: AOAM530i1cAQ6o0FXvS+vsNG9AdXQGkJMcYLoEl2kVI94qZ1ZOaVaxd0
        spQU+XOeHsyusp0bWXFvwh47aEUIralw9Q==
X-Google-Smtp-Source: ABdhPJyJMgVW58BTVOTbji6DXnujEPFUDPnMENejCto9RWYQvhnmFYZGR5gA9bCdPEkI2IbN53ilGQ==
X-Received: by 2002:a05:620a:1092:: with SMTP id g18mr5623826qkk.57.1619202758638;
        Fri, 23 Apr 2021 11:32:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id n20sm4950566qkn.43.2021.04.23.11.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 11:32:38 -0700 (PDT)
Subject: Re: [PATCH 3/7] checkout-index: add parallel checkout support
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <6bf1db2fd8e807f9f259787ef75651d43b61e03a.1619104091.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36615f6a-ce58-3737-8c1d-fa1253a85439@gmail.com>
Date:   Fri, 23 Apr 2021 14:32:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6bf1db2fd8e807f9f259787ef75651d43b61e03a.1619104091.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> @@ -142,11 +143,7 @@ static void checkout_all(const char *prefix, int prefix_length)
>  	}
>  	if (last_ce && to_tempfile)
>  		write_tempfile_record(last_ce->name, prefix);
> -	if (errs)
> -		/* we have already done our error reporting.
> -		 * exit with the same code as die().
> -		 */
> -		exit(128);

Here, it makes note of returning 128 as if it were a die(), but

> +	if (all)
> +		err |= checkout_all(prefix, prefix_length);
> +
> +	if (pc_workers > 1)
> +		err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> +					     NULL, NULL);
> +
>  	if (err)
>  		return 1;

This returns 1 instead. Should we `return err` and use an error
code specific to the response? I imagine there are other reasons
that could cause a non-zero return for checkout_all() and
run_parallel_checkout().

I suppose: is there a value in persisting the 128 response code
here, or is an exit of 1 sufficient? There is no documentation
about the exit code, so any dependence on 128 is not based on a
"written promise" but I thought it was worth mentioning.

Thanks,
-Stolee
