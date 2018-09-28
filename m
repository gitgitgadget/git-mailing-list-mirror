Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03991F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbeI1Hlo (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:41:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40155 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1Hln (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:41:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so2873942qkd.7
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 18:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fDxuOuVIa1aY6v04pcIBnqgccR/uiI4nIJpw6aFA2Q0=;
        b=RhBjijWvwy4G5aNH0sWRBig5BiFFq9gO/EaZpdGFyqQR/MwWUusCvzFYtLTGuhYtpW
         0y0FjDDyuqz9yp52rghV2md2/5kxGu6uOuHna1eFXL8yyBEQjp/mIJ94WpoDMGkpNfxP
         CxP2pHT/L+SJpWb5rQ4wqPWz5S2+z3TCzPOQybxKQ0FU+bDEF0nQvLWaYKKnSNab1csf
         A10+Mrw20kY/zE38HRi5GFTZD32k0GpSAggnHdaNakc2tnqrPiZqwH8cg3ZDYkQFnUtT
         RwfNsXPhzgQ1eap+1yocluDYmL5+FDaY7DJkjcXOmjg1zmKnec0BSbiygpmo2fgf+xjE
         p7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fDxuOuVIa1aY6v04pcIBnqgccR/uiI4nIJpw6aFA2Q0=;
        b=DpjvSBp7ZZhqsY3CPJcWiSiFPUXwv4py2noMAPp0sCOpaewBSzXYs/BhCF+DepqhnA
         0YmnhLfXvwg63S2bK8TA80l7szrtULT3LtKSDQzyUBU3JEZ+8RjK1Ek9UyVCE0euFE+9
         eO5N0Kf54PsM4x4nRTBnsHXHHzFiOCRGMSUYj5zgFDDWz+FRZwUWOHzV55K0xEYUZ6fB
         cQpoRB592Dp4VEaofdMYZMhMiCYEa3+je/NWfmgc4/Z94vptlRVflGHDY31N0D+dBhHf
         OjTYTtVGt1vTRlDcyUdkILJmIOlfh7uWSw5qGsA89ggeEvhe/itnXVrLcv5a4rjKANR9
         IhgA==
X-Gm-Message-State: ABuFfoihp5X3N2Vs63kTAXuqQJOVZTC+o5ToqnQLy8IDJ5jckS2tvXhu
        rSBFBE5LhiVCtU30vejI8Jrg7Lf0y5E=
X-Google-Smtp-Source: ACcGV61iFgTJzYN32BeFmQdRkWISPYMwmA/utQZjoRFvIum/XU5eYA9Z3+bCSHkTBflTeVqFZ8sa9Q==
X-Received: by 2002:a37:9904:: with SMTP id b4-v6mr10200198qke.102.1538097635346;
        Thu, 27 Sep 2018 18:20:35 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n186-v6sm1917859qkb.32.2018.09.27.18.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 18:20:34 -0700 (PDT)
Subject: Re: [PATCH] read-cache: fix division by zero core-dump
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <476b5678-41b2-d2f8-1890-ba315354ebc0@ramsayjones.plus.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <8a76234e-fcf8-f435-33e9-1846c3b6ad14@gmail.com>
Date:   Thu, 27 Sep 2018 21:20:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <476b5678-41b2-d2f8-1890-ba315354ebc0@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/27/2018 6:24 PM, Ramsay Jones wrote:
> 
> commit 225df8a468 ("ieot: add Index Entry Offset Table (IEOT)
> extension", 2018-09-26) added a 'DIV_ROUND_UP(entries, ieot_blocks)
> expression, where ieot_blocks was set to zero for a single cpu
> platform. This caused an SIGFPE and a core dump in practically
> every test in the test-suite, until test t4056-diff-order.sh, which
> then went into an infinite loop!
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Ben,
> 
> Could you please squash this into the relevant commits on your
> 'bp/read-cache-parallel' branch. (The first hunk fixes a sparse
> warning about using an integer as a NULL pointer).
> 

Absolutely - thanks for the patch.

I don't know how long it's been since I've been on a single core CPU - 
I'm sad for you. ;-)

> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>   read-cache.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 6755d58877..40f096f70a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2141,7 +2141,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   	size_t extension_offset = 0;
>   #ifndef NO_PTHREADS
>   	int nr_threads, cpus;
> -	struct index_entry_offset_table *ieot = 0;
> +	struct index_entry_offset_table *ieot = NULL;
>   #endif
>   
>   	if (istate->initialized)
> @@ -2771,7 +2771,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   			if (ieot_blocks < 1)
>   				ieot_blocks = 1;
>   			cpus = online_cpus();
> -			if (ieot_blocks > cpus - 1)
> +			if (cpus > 1 && ieot_blocks > cpus - 1)
>   				ieot_blocks = cpus - 1;
>   		} else {
>   			ieot_blocks = nr;
> 
