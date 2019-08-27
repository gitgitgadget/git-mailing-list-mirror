Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5061F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 14:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfH0OtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 10:49:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39661 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0OtP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 10:49:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id l9so21526427qtu.6
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nzjd+dC0NZjjSUnxl6kMW4zx7deynHPuZzjasDuhrLg=;
        b=T5Zn1F0c8TUtRrAJH7vyqKvcDQFl2xLqxcwy8j7JKnxnc/6VwsCqKLTEnEZ8vHER9W
         BFwMS0uck2O9YiShPBhDRVNQ7JOlINsvMsbYe/WeQJL0CXyXkPQFhfxGVhvLTwBCnAfs
         9qbV67lz1t7v2XMlyM9CPZUzD9rTITZhf2Lj27LJkafn/GPPuzSNMMWmGEFFRvc7G6XV
         PyD+XNWQiRqII7p6vAXwH0MI1KtyRXDMH3C1mXEIMy8tSq3EAYD6qv/7sisXyWb1oXxn
         MGQKvLuzZeR3yzuV8wXzkcwDr6U1KHOSU9eOg+85CoGgbBrLnamc2gynI8UDwDJALnTR
         sA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nzjd+dC0NZjjSUnxl6kMW4zx7deynHPuZzjasDuhrLg=;
        b=fVGETWHr9fBGhtmJVs7A4xUlxr3qIC6+XPn2EC7l2LZ2jpv2tVccLFeIJYtxdg2bMD
         rpBkWb/zMUHNnS/vmutzzDNemXL8vnYUq7nuQgiPh7SyoqmNPpsyZCqYobyWItnfrKM4
         3NVgpxCZPyNJVvi/mVJL4h6Uv3bn1TYP2weRV2SQRWqL7ex18PHIgGMHgmE3WOpruS4t
         lqLUWv6At2OQm9c+jplfyXOb3nkA8mgdkitwlj7yA27vn/HGAth0xzOKO7dUGQafcHII
         S0RMqCS20jPjV00G2pYr6mZD6kKQ1gEQiN/zYbLFs7wdaSD4KBeiIURG8Kyq1vFCgaNz
         z9Ng==
X-Gm-Message-State: APjAAAWiERy0TAc/KbDO0U2/HaKc87zX2PjYiXc3+5R0c5Xu5l3Zvpf2
        4LK8dwdOI8eJaoVHeJ3H+a5crhg8H8Q=
X-Google-Smtp-Source: APXvYqz3Wa7B5XdHu7jQ1gsN/cqedXGCwbHsTanaTwm2PyJ5H3Tyo82a4ZuVKNuuKEOPXqu05Cdorw==
X-Received: by 2002:ac8:134c:: with SMTP id f12mr22587506qtj.75.1566917353240;
        Tue, 27 Aug 2019 07:49:13 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a903:7653:4c3b:5b49? ([2001:4898:a800:1010:5a39:7653:4c3b:5b49])
        by smtp.gmail.com with ESMTPSA id c15sm8284233qkm.32.2019.08.27.07.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 07:49:12 -0700 (PDT)
Subject: Re: [PATCH 10/11] introduce container_of macro
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190826024332.3403-1-e@80x24.org>
 <20190826024332.3403-11-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <381dd52f-f7d4-3e6c-24b8-22c8a0710f25@gmail.com>
Date:   Tue, 27 Aug 2019 10:49:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190826024332.3403-11-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2019 10:43 PM, Eric Wong wrote:
> This macro is popular within the Linux kernel for supporting
> intrusive data structures such as linked lists, red-black trees,
> and chained hash tables while allowing the compiler to do
> type checking.
> 
> I intend to use this to remove the limitation of "hashmap_entry"
> being location-dependent and to allow more compile-time type
> checking.
> 
> This macro already exists in our source as "list_entry" in
> list.h and making "list_entry" an alias to "container_of"
> as the Linux kernel has done is a possibility.
[snip]
> +/*
> + * container_of - Get the address of an object containing a field.
> + *
> + * @ptr: pointer to the field.
> + * @type: type of the object.
> + * @member: name of the field within the object.
> + */
> +#define container_of(ptr, type, member) \
> +	((type *) ((char *)(ptr) - offsetof(type, member)))
> +
>  #endif

I think it would be good to include at least one use of this
macro in this patch. As it stands, I need to look at the next
patch to make sense of what this is doing.

It took me a little while to parse what is happening here.
'ptr' is a pointer to the generic struct (in our case,
'struct hashmap_entry *'), while 'type' is the parent type,
and 'member' is the name of the member in 'type' that is
of type typeof(*ptr).

Perhaps this is easier to grok for others than it was for me.

-Stolee
