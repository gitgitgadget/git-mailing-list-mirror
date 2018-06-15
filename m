Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 969E21F403
	for <e@80x24.org>; Fri, 15 Jun 2018 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965708AbeFOLXT (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 07:23:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33243 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965641AbeFOLXS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 07:23:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id l10-v6so8659134qtj.0
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iM03IxZ6BwBT6wHXd7dqlColGhZSss7YJqAQTFvAPsQ=;
        b=hN9Gv16LqnwbBPf3lWhTI400LQx3n6p0s3wZBxrqKj47sfLjr1+qPY/8jI4kHsfXGA
         h1gjEOeHGAN5+Tb/Qisqwi7+Pta0Ral7D97CSdvKoqLWrjpEKdMbtc1TvaWhUZy4xepi
         2esqfDMLxj5GVO5TuhOXKKn7HcMAZbHdDusKBcjm7v5CBmKEcWwver1crh1xUA8Ibaua
         bZvfCYaje3lGr1pZ9DotMa+Oxy6mF/oKRS+dmV0b4EZmNcUXNWnuAn6SPSVrQ5dlsDtq
         xrtWDmLDXpHuB+nB8wz+lGfVA2wn9vB8wOIze2+5hLlGMJXHLzOMJsZZGB6BJReZq/Rr
         rcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iM03IxZ6BwBT6wHXd7dqlColGhZSss7YJqAQTFvAPsQ=;
        b=mn8xsn1SwPl34QOw8gM9IDHGsCby1fSS+vHYga7u0Ml6rDL/P/jARg9KyrisXxbakU
         34n7kUCHRF5fQkpLtM4sv7PRtV7+KmG3i9eddDiCajUCfRm0JuJjovs6f6V52wndateZ
         6x3DVEQJ2lW4hA0aCicSe/BKUJPFNLWQz0Pbakh93Z3jqdhqIEgH3uXZE7lahjeEX+gQ
         or1LqDypAQf2GH68wn1wUtj8q5cVz8bcziCdTF+DKPCjlb/ITl0/aP6xiRE3QuS0T+yh
         o72pDdPuiMEQxh7a4Vl4mQhi6+XiRL4MW4L8/YPf3jBrLnqtalh3tteqvJXgWjOPITPp
         1tbg==
X-Gm-Message-State: APt69E333uCTNEfrm+YmXLRMoGqmJgHLZrQd6E3kHVHH8e6nptByiqkA
        5t5IZ8eRgpY/K1m3ItLz4xYsgx7L
X-Google-Smtp-Source: ADUXVKKirShk4MMrLgOAuv+uWq1ipRksnbzt6oj9LRjUMUT/Je5uro7bXynwF8MvOQvP2/zt7Zoc8g==
X-Received: by 2002:ac8:185c:: with SMTP id n28-v6mr1011867qtk.136.1529061797599;
        Fri, 15 Jun 2018 04:23:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:8010:0:f26b:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id q77-v6sm5705367qki.73.2018.06.15.04.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 04:23:16 -0700 (PDT)
Subject: Re: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
To:     Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
 <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615034442.GA14422@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f6931351-df79-cb76-ee29-c57472a6a201@gmail.com>
Date:   Fri, 15 Jun 2018 07:23:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615034442.GA14422@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2018 11:44 PM, Jeff King wrote:
> The return value of ewah_read_mmap() is now an ssize_t,
> since we could (in theory) process up to 32GB of data. This
> would never happen in practice, but a corrupt or malicious
> .bitmap or index file could convince us to do so.

Aside: Why a 32GB limit? Usually I see 32-bit issues limiting by 2 
(signed) or 4 GB (unsigned). Is there something specifically in the 
bitmap format that stops at this size?

Thanks,
-Stolee

