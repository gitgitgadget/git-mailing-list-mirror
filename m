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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A8B11F461
	for <e@80x24.org>; Thu, 22 Aug 2019 14:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfHVOET (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 10:04:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45280 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732497AbfHVOES (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 10:04:18 -0400
Received: by mail-qt1-f194.google.com with SMTP id k13so7742810qtm.12
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mu9iipZB8cLreeAJ80e5snah50zsKJYX13xZNByJsV8=;
        b=utciKPcSao/0vTEC69E/Aq+FByzjMHan2XuznxWhZx9P+TlsGFuv4bJyFXmIv1eWc1
         a8zIrMWD5KDS51xFXXj2LkYBASVo9FX168HdVdXtBcv8TjciBiqimECsVBJk9X205j5q
         hn7kaG7sXwTBZXTA6HdVft+KwT/XwSrDDUDqUZaXqU/EoebKsFqjmw8iLXZhLt7BCn6V
         oX/VKuU0iUYB8gtwG+aQY7k+KEr7PC/aQP6fdj9SNCkwn8RhkUJMUrmopR/2QKwbW00K
         laT/EU0EFwypE2GpXaWdMOMVwGIIgL6mRfCdk3bDh9LQsz4CXSv8TDse3Vx64hPhkcra
         yIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mu9iipZB8cLreeAJ80e5snah50zsKJYX13xZNByJsV8=;
        b=dMgBIg850b2jOpjRtWmdRDRxFDAyP/2reXoEhDoU/b07Vju8S1jHL5GoG5lBKUaa3A
         qIeW7E9L43hZSAfVZKyqYX92VTZHu3aFhuDWEDJU8tf6OdB9V+eagm0UuOUNUgnPxaYU
         5dC0Pk08c09sM4B67rRHnSCh39HNSypvARSAayGlUMGvW3p8MTWfpdF6EZ6OC18VRub4
         XFDvEXCbIpI66NiUK/tyd21AFlysLwqk4K0zQtV3fabrPl46L39qBcZBKVPtBS4IT7We
         iKyTv6CWM5MVJo7qBl4WFV7EX0R/I1l/IYWCN/KERy1nxmOc4fN8w7X75zQmcTM4+vZA
         AFYQ==
X-Gm-Message-State: APjAAAXc32ysoSle1u57rrs9GNI+7JnCyImxqjwgnm6hJ9MtirUu6ISN
        Y3xv/RbSH/MhBpR4j8kRPTE=
X-Google-Smtp-Source: APXvYqw46am4bNDpMrq4iN/MhzoNbWWNDyZcBLf6jYgsurHl2qw72vNZwURYcFQ6OJjwgBEV+QiTiA==
X-Received: by 2002:ac8:358e:: with SMTP id k14mr33331464qtb.83.1566482657855;
        Thu, 22 Aug 2019 07:04:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7dcd:416c:c779:cf77? ([2001:4898:a800:1012:2f01:416c:c779:cf77])
        by smtp.gmail.com with ESMTPSA id h1sm15254554qtc.92.2019.08.22.07.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 07:04:17 -0700 (PDT)
Subject: Re: [PATCH 26/26] midx: switch to using the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
 <20190818200427.870753-27-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4f6b781b-68b8-5bc4-92a2-67caff32024f@gmail.com>
Date:   Thu, 22 Aug 2019 10:04:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190818200427.870753-27-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2019 4:04 PM, brian m. carlson wrote:
> Instead of hard-coding the hash size, use the_hash_algo to look up the
> hash size at runtime.  Remove the #define constant which was used to
> hold the hash length, since writing the expression with the_hash_algo
> provide enough documentary value on its own.

Thanks for this change! It seems to be very similar to the one
included in the commit-graph, barring one small issue below
(that we can follow-up on later).

> diff --git a/midx.c b/midx.c
> index d649644420..f29afc0d2d 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -19,8 +19,7 @@
>  #define MIDX_BYTE_NUM_PACKS 8
>  #define MIDX_HASH_VERSION 1

This hash version "1" is the same as we used in the commit-graph. It's
a byte value from the file format, and we've already discussed how it
would have been better to use the 4-byte identifier, but that ship has
sailed. I'm just pointing this out to say that we are not done in this
file yet, but we can get to that when we want to test the midx with
multiple hash lengths.

>  #define MIDX_HEADER_SIZE 12
> -#define MIDX_HASH_LEN 20

The replacements of MIDX_HASH_LEN make sense. Thanks!

-Stolee
