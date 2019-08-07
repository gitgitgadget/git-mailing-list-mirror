Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851A71F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbfHGNQ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:16:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37152 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfHGNQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:16:26 -0400
Received: by mail-yw1-f66.google.com with SMTP id u141so32320320ywe.4
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XOKdWiIxdI5BLG0K2p+GOukcnhEDQJ5HTGrhQyKum7A=;
        b=dsofu4y+yIPT/GvrMd6Sx3ctCC+gi5QqVfWN+NJTWbFQAu5DNzrP3kzdhfywlTq1+j
         FoVFzsMEwShM+1oD3Ceeu6U1nnSDUjtLM/MpfyjZELJWfrf67PN5UtcvcwBtF4ViBe2E
         l/AhcT67NvuBN8UFpkEAls/xZiGhqCBdws+r5vHSjAb2mhvPKDVzsqHqmzDExbXCC/Rs
         rSrLbdfOgXrWYacWtOHHibtSz1NKAZCUMpP4az1v1qeh6U9qiNgcMj+5doiOUWtXfCZe
         7FEJB4fCWIV9PqmB5HzqsFL4Vx+n7w25lBw3Qi1/omc/2sLPxfFcuPgXS4QBcxILPINy
         pdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOKdWiIxdI5BLG0K2p+GOukcnhEDQJ5HTGrhQyKum7A=;
        b=WQz5HEcF3IWumwrbkeQILY5w9zuuDHLwEVQdelCP/Of7HfIfRWjDSoh4A1RpjBQpzM
         c709zUuM+yLWNDi6WpIK2h3f3tLrKzx4HYFmM2H+46KilPwfgXt+bqUR09El88139+wJ
         7dcM6Zg0L8S3x8Lf2h99TF1rxP7hk4pvpj4EsQ+VeWKyG0fu1Fe+seHTVyaWnmCOZK8u
         oi1Dv4L69pMFbItg7LphLmLWXGlWtIOxpxkLVny30oSYHgjSWlNrdn70tvlQ9wP4nLHr
         HR/DrdZ8cBk/qgGoX97JjKjxkdu/nkbvzxNhYjS17Bwi8NF0nSo9Xn5QRpIrF9hIY5qg
         hgCg==
X-Gm-Message-State: APjAAAW4ySGxtp3tmRHWLDL4Hi7h8p438N00256tSzHA7nBOlOxZ41L5
        2v/sxoINUPR4oT6YyWicBpM=
X-Google-Smtp-Source: APXvYqwEQ1b9YMXKu3VLB2JT+o1/IKeRyVoJ8+PWI1SwIdyWukURtFf0sUo4tbGfhLfqxRyT942xow==
X-Received: by 2002:a0d:d690:: with SMTP id y138mr6245850ywd.433.1565183785721;
        Wed, 07 Aug 2019 06:16:25 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e12sm21250384ywe.85.2019.08.07.06.16.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 06:16:25 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: release strbufs after use
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <c3be25bf-6487-52ce-217d-d6ee93b3a16f@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a2f30b81-ba93-579c-98ec-07f5df1043d7@gmail.com>
Date:   Wed, 7 Aug 2019 09:16:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <c3be25bf-6487-52ce-217d-d6ee93b3a16f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/2019 7:15 AM, René Scharfe wrote:
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Patch generated with --function-context for easier review.  That makes
> it look a lot bigger than it actually is, though.

Thanks for the --function-context. It really does clarify what's going on,
especially in the case with the "out:" label.
 
> The plugged leaks were added after v2.22.0 (2019-06-07) by the following
> commits:
> 
> 5c84b3396c 2019-06-18 commit-graph: load commit-graph chains
> ef5b83f2cf 2019-06-12 commit-graph: extract fill_oids_from_packs()
> 8d84097f96 2019-06-18 commit-graph: expire commit-graph files

Your changes look good to me.

> -	strbuf_reset(&progress_title);
> +	strbuf_release(&progress_title);

This line confused me as I'm sure I adapted it from another place in code,
and sure enough in the old code, progress_title was re-used between multiple
stages. That's why it was a 'reset' when it should have been a 'release'.

Thanks!
-Stolee
