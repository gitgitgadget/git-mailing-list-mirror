Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26B01F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeI0BaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:30:05 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:46010 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeI0BaE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:30:04 -0400
Received: by mail-qt1-f176.google.com with SMTP id l2-v6so58684qtr.12
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XXrZuM8rkV9ErlJ6wiCuF7pu8eYDRZrgOCKZQ1v2jCo=;
        b=nkHVdWBaFyS4/v71O4gQ3zL2rtj8D/xdsYJrEeH5vWzrJ9kb1LkrWq5zOBUtOiYZsj
         4T42KYrymy3C8IXWiLb7W8hnvhCWsiIoqWBrepjSLVsV1o8DovPvhGJzeEtEoXricYLc
         clH7V/VomslG3mkTkfjY2UNV7SKeWFo88IrOikYPBm88d0yPPsp+Ibr5Pt2EV8KQALSt
         gcVi04DAL6WZgP40/C3FVqql9dNGXhBBCtv7BqGUdgjSP1U1Ou/xeGo8keFEQ7mau31o
         pw5OKAlOAz6XjXwAyCCiY8H2dYd4jdUwpAyeBA9TQnQ1naPtLcf75naAuL1W9B/UOqVS
         ACWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XXrZuM8rkV9ErlJ6wiCuF7pu8eYDRZrgOCKZQ1v2jCo=;
        b=umOYFZor2zFoTFDgd+PzsMNOQhAvxDDQXJWe33s+gSY5Mc+KLhXpYidxPvQ2VsQUuv
         rVDGNuxGRBT5u3uQZ57Cq776arvwnwxfC1oolbESVmPvpT/maIU05JNFU6YhKFU1zz/6
         sVwJNknIVhveKGsFpnZPEY4IrUBlBWmeW6VOHfuinSXmiMwiDqGGit+gExvxUNovRqej
         aqEUqJtSmOaXehfsPo2nVoxYzCyD6uXRrZ6+buRL06FABjjxIPBAWV9D7Mjq1Xmb/hog
         RMCh88qZ+XEpQKqGCwmQh33j8vf6PIya9SrBSI7nRprEgDXtvamGeD9p7BdMCPml70vI
         iUHA==
X-Gm-Message-State: ABuFfohJ3QFeDZXX1m2/aw+T1BUs9F5+NXYeAfn6mUJNBHdNl5tEdmb5
        +s3HEM1VsPQSJ2jD1wYkBUU=
X-Google-Smtp-Source: ACcGV60pplH4dTIBN+PddIjM4bXU8+SHHrGu6Rm7ffL8TjINCQzrBrRO+zPlvKz2xbgcZzgO7EQ0OQ==
X-Received: by 2002:ac8:23d8:: with SMTP id r24-v6mr5641727qtr.300.1537989339136;
        Wed, 26 Sep 2018 12:15:39 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:51a9:99b0:a00a:e3c? ([2001:4898:8010:0:3adf:99b0:a00a:e3c])
        by smtp.gmail.com with ESMTPSA id 69-v6sm3233482qki.19.2018.09.26.12.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:15:37 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] prio-queue: add 'peek' operation
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
 <pull.25.v3.git.gitgitgadget@gmail.com>
 <cc1ec4c2702d8ba35873600d321015bb0430d92e.1537551564.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <04c9cd31-81cb-878c-85d4-dfa93220cf8b@gmail.com>
Date:   Wed, 26 Sep 2018 15:15:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cc1ec4c2702d8ba35873600d321015bb0430d92e.1537551564.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 1:39 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When consuming a priority queue, it can be convenient to inspect
> the next object that will be dequeued without actually dequeueing
> it. Our existing library did not have such a 'peek' operation, so
> add it as prio_queue_peek().
>
> Add a reference-level comparison in t/helper/test-prio-queue.c
> so this method is exercised by t0009-prio-queue.sh.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   prio-queue.c               |  9 +++++++++
>   prio-queue.h               |  6 ++++++
>   t/helper/test-prio-queue.c | 10 +++++++---
>   3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/prio-queue.c b/prio-queue.c
> index a078451872..d3f488cb05 100644
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -85,3 +85,12 @@ void *prio_queue_get(struct prio_queue *queue)
>   	}
>   	return result;
>   }
> +
> +void *prio_queue_peek(struct prio_queue *queue)
> +{
> +	if (!queue->nr)
> +		return NULL;
> +	if (!queue->compare)
> +		return queue->array[queue->nr - 1].data;
> +	return queue->array[0].data;
> +}

The second branch here is never run by the test suite, as the only 
consumers never have compare== NULL. I'll add an ability to test this 
"stack" behavior into t0009-prio-queue.sh.

-Stolee

