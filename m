Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9502201CF
	for <e@80x24.org>; Tue, 16 May 2017 01:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdEPBzS (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 21:55:18 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35203 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdEPBzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 21:55:17 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so18645218qtb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 18:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=8n0C3j+JRKiiFCz9kUBFvupGtjcMOfvogLifF4TXfpg=;
        b=PNXFxUD3Q9YzzCn7Vw2szsUrwJYHjK1o0yQzLUgAaapMnf/Ks4/d6BJJzp+SJzqBbT
         IhRxuB3E/Xr2J26rgn5GBZ3V/ZDkBzbUld9MjBzB1zFwUqaUTWGABG70CUs6nmwlfp9W
         Yz0Wg1JjG72ck+sQFhodZkXmGXzf6BFJPOyxuH+H211SfA9Zl5IjYoM8mBgLnleA3CVH
         alkUP7fdElHgl1iwaoumodeA0jodFxMGWmlRmfWX2iRy2Wv1mVbXrBnNQhHMoUQD9G2+
         0ke3fxUm99lvKg5f9a4j1OX5ffDE9cSpzu+ueXWbsvjA8Rv9sN5mRDPcdFz9gYHxt2W2
         pwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8n0C3j+JRKiiFCz9kUBFvupGtjcMOfvogLifF4TXfpg=;
        b=EwZ3vUz82YKjbryQbsqyVQeo8nRc73j2987vSg4gTnHw6/DDRCooVFNdDR+J92vuAS
         AZZww2IcrmmiGJjJhmI70UaygYSrsMOAYFMshEGiMj8pfvInpqIpHSLTRKZ1SGPDWEFa
         /bD44G2QcdWpuqgWx4tOtaHRGlKkHlNFY4cka7k3GjWiQN+vKTYMfmJQuftMpDqMIwFu
         +/+vrFbT1QEfUINAnyAQ9FjCg4FmUlqTUPgTL4LNsI3xsxWboNHiyM7JbonyqwUbGFZi
         RVqSwpbxxH7S3Rnj3JhNhIwjiFDZzjdLCbTIQPp3H2NFLB76XRfojjKi+pBLdcypuacr
         n7MQ==
X-Gm-Message-State: AODbwcDVDLbgWYKpCgEvebuvdsSGRZ9KvrqFZAQP2FVb5FnfqeTm8sZn
        rDFezJ7bIlcrqw==
X-Received: by 10.200.41.135 with SMTP id 7mr7788369qts.85.1494899716394;
        Mon, 15 May 2017 18:55:16 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w14sm8454546qkb.11.2017.05.15.18.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 18:55:15 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
Date:   Mon, 15 May 2017 21:55:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/15/2017 8:34 PM, Jeff King wrote:
> On Tue, May 16, 2017 at 12:22:14AM +0000, brian m. carlson wrote:
>
>> On Mon, May 15, 2017 at 03:13:44PM -0400, Ben Peart wrote:
>>> +	istate->last_update = (time_t)ntohll(*(uint64_t *)index);
>>> +	index += sizeof(uint64_t);
>>> +
>>> +	ewah_size = ntohl(*(uint32_t *)index);
>>> +	index += sizeof(uint32_t);
>>
>> To answer the question you asked in your cover letter, you cannot write
>> this unless you can guarantee (((uintptr_t)index & 7) == 0) is true.
>> Otherwise, this will produce a SIGBUS on SPARC, Alpha, MIPS, and some
>> ARM systems, and it will perform poorly on PowerPC and other ARM
>> systems[0].
>>
>> If you got that pointer from malloc and have only indexed multiples of 8
>> on it, you're good.  But if you're not sure, you probably want to use
>> memcpy.  If the compiler can determine that it's not necessary, it will
>> omit the copy and perform a direct load.
>
> I think get_be32() does exactly what we want for the ewah_size read. For
> the last_update one, we don't have a get_be64() yet, but it should be
> easy to make based on the 16/32 versions.

Thanks for the pointers.  I'll update this to use the existing get_be32 
and have created a get_be64 and will use that for the last_update.

>
> (I note also that time_t is not necessarily 64-bits in the first place,
> but David said something about this not really being a time_t).
>

The in memory representation is a time_t as that is the return value of 
time(NULL) but it is converted to/from a 64 bit value when written/read 
to the index extension so that the index format is the same no matter 
the native size of time_t.

> -Peff
>
