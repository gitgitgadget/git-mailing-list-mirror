Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FBA31F428
	for <e@80x24.org>; Mon, 27 Aug 2018 12:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH0QTz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 12:19:55 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33892 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeH0QTy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 12:19:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so17763656qth.1
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 05:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pnEkEbvITP38vSDJGqDrqnLd5jX7pX2wW5Mfs0tBQmE=;
        b=VKkS4KahMR9ICcWf9mqIMM7uKqm6klJK7y3nveZUEpNFvXNtIo3qWiAKgooxl0WplZ
         TH+r6I7kemClhUTaxiN5kFV2hfhRjDJ78Bgw2DdofFOJ9X7nt3Q6oYkFs2tkalPy9QO0
         8UpzlEUmpvSWv0ocDAzx14NSRjNgq+Xtj6V84e1uC9heTbxvvmbCnZvBlDRmh9ijUn77
         K0/2ceQoy/rfaWV2IcICcT0E+DZLRwpbOzSUDxx01i6DUzTyQzqwuqAvzshGQjP4IMrG
         WEGKOUweYxr/9truTuBnflKcvti8FuosvoEDQXbWR44XgaZHPyXtck8Ft7Oh/XpLS71i
         HAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pnEkEbvITP38vSDJGqDrqnLd5jX7pX2wW5Mfs0tBQmE=;
        b=ItcNkYkWVgDAFw+NAtv7E2GQ4k0MoXPvSHNktK4MTd5mP2HyaoxiKWY3z8ZsJ4YFMK
         dy45IohcZYt4CjqY96qDx6EuyV9ko2C+wwOyInAVomRTOS9kfG2x7uTBHzaFgm5BYSmJ
         Et5Pyt1UPUjRdBIWUJA3XJr7QHQDnqXMnSN2uhpcyq4ocL6fjsDTpibYY14sLp8yUAEJ
         Ai925IzfdEu93O63T5Vcqm/x/2xGURAzCa9Dv5U80xc5ZOSIoCfGdz6QPUTBC1X7u5iw
         L/xIZnEi/1YD56IND01Vxqid2g0nuQ6DeHQCqRQfWkd+wW3CwLdTjC85TQ4PrXeaxy+4
         bhfg==
X-Gm-Message-State: APzg51BOttd27e/Et4L07/U4IsR5eOlnK8cWlFA6XR5D1QbR5WPUAjwn
        owDsG0QwoEqgbpC2ggVftCC+YfpC
X-Google-Smtp-Source: ANB0VdbPK7NILfKv4hFQsD43yowcF65+PBsY01pOsmnMEb7k41SlBCEC1KV5baarhaYf9hoVmQQHKA==
X-Received: by 2002:ac8:544c:: with SMTP id d12-v6mr14088909qtq.150.1535373205978;
        Mon, 27 Aug 2018 05:33:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:10b0:d7ed:482d:ab9b? ([2001:4898:8010:0:f9e5:d7ed:482d:ab9b])
        by smtp.gmail.com with ESMTPSA id p5-v6sm8018939qkd.81.2018.08.27.05.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 05:33:25 -0700 (PDT)
Subject: Re: [PATCH 3/9] convert "oidcmp() == 0" to oideq()
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180825080715.GC737@sigill.intra.peff.net>
 <20180825083602.GA2251@sigill.intra.peff.net>
 <62172db4-15b2-eac3-8591-246300db3948@gmail.com>
Message-ID: <909de6f4-0b30-b9d9-637c-a86497f86d8e@gmail.com>
Date:   Mon, 27 Aug 2018 08:33:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <62172db4-15b2-eac3-8591-246300db3948@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2018 8:31 AM, Derrick Stolee wrote:
> On 8/25/2018 4:36 AM, Jeff King wrote:
>> On Sat, Aug 25, 2018 at 04:07:15AM -0400, Jeff King wrote:
>>
>>> diff --git a/contrib/coccinelle/object_id.cocci 
>>> b/contrib/coccinelle/object_id.cocci
>>> index 5869979be7..548c02336d 100644
>>> --- a/contrib/coccinelle/object_id.cocci
>>> +++ b/contrib/coccinelle/object_id.cocci
>>> @@ -108,3 +108,9 @@ expression E1, E2;
>>>   @@
>>>   - hashcpy(E1.hash, E2->hash)
>>>   + oidcpy(&E1, E2)
>
> Is this change intended? It doesn't seem to match the intention of the 
> rest of the patch.

Ignore me. It's just confusing to read the +/- notation from a cocci 
script alongside the file diff.

