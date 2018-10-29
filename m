Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA4A1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeJ3B5A (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:57:00 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41128 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ3B47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:56:59 -0400
Received: by mail-qk1-f195.google.com with SMTP id 189so3977135qkj.8
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JX4L4rRZwGJ4JxLtEMkl6gHgmJTkKVfSlpU9JAgPcJw=;
        b=RrwtE702lt0coZ0NrFP/0+Uy//MBZYusHCr4VjQb53W+lI8GcM34Hg7mKmPlB1MiYD
         e9zf0JRotYazsPXLEZKyjk5JfDxK15reqidVQKJHzXP/Z6JIiZ6+y0msilhyT7AZr18x
         QqJv8y/QfKnV/wJJxwB6K8IS+GD+ecJ/GW8vCVGwHyC1/k7hBg9DftYmVdKM9T50TttN
         CZYtZ+A5VKCVKMIz5+4ILxV2cew/9bLObwJq1u9zcKFpe2up8QObQueQ28sM4wwGb/B6
         F1OU+iO/qNWtNGvK4V16RMAi36Y7gjgKzqeduvlFCNR5YS11C9XY3GwGD1Y6WAUPWGWZ
         aorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JX4L4rRZwGJ4JxLtEMkl6gHgmJTkKVfSlpU9JAgPcJw=;
        b=gCCevBDDzS9sb+Np097wTJVb1vRwdAgQ5pacBqHHZxMh1nvbHNX0OeuPUodAataTFx
         YltF0LiUCLwIkFcTxXMn9B2lm4SpQu7P4CaAhYVei6N6T5p5Keai7/wOPT8eU5F6gx/H
         LQ92p8l5A2RJK8RDxCvi92ZLP5XL0kXK2LB8IWPaBvK/SZ3PrF69dYx/5vyoDaBxXaVA
         p6p4ydIbd5vu0xiNaUHSG/LrFHB4rwiBiQe1J/gG/gXvYiT367ogEzrJ9kPfNgqAezrC
         uzkUMqqhCqAcp5YiNZ7ybqpfzQ/Ub4fAya+BwTwK6BaPKNfmu5N5eYXBZe+p+u06AU+6
         7EUA==
X-Gm-Message-State: AGRZ1gIrWKE9pE8eukf0A7R9+/9E409sMwyL/xWiONbihS+ALb1WZ9sI
        YRlf8Sl1LoK6nWjnZEpHmk8ZLUKt
X-Google-Smtp-Source: AJdET5e3O0BRXNf+Gd+KYRgyaRd4E6a7cVS9sVZHtFJb/NJGrpGBoD+szt//qKnrA7Ty63dFnX7wTQ==
X-Received: by 2002:a37:8006:: with SMTP id b6-v6mr12831075qkd.178.1540832850201;
        Mon, 29 Oct 2018 10:07:30 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d193-v6sm15831036qka.78.2018.10.29.10.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 10:07:29 -0700 (PDT)
Subject: Re: [PATCH v2 08/10] read-cache.c: remove #ifdef NO_PTHREADS
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20181027071003.1347-1-pclouds@gmail.com>
 <20181027173008.18852-1-pclouds@gmail.com>
 <20181027173008.18852-9-pclouds@gmail.com>
 <20181029143033.GF17668@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <4e3c20f1-580f-0a34-eb86-028bf8dd1b4b@gmail.com>
Date:   Mon, 29 Oct 2018 13:07:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181029143033.GF17668@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/29/2018 10:30 AM, Jeff King wrote:
> On Sat, Oct 27, 2018 at 07:30:06PM +0200, Nguyễn Thái Ngọc Duy wrote:
> 
>> -#ifndef NO_PTHREADS
>> -	nr_threads = git_config_get_index_threads();
>> +	if (HAVE_THREADS) {
>> +		nr_threads = git_config_get_index_threads();
>>   
>> -	/* TODO: does creating more threads than cores help? */
>> -	if (!nr_threads) {
>> -		nr_threads = istate->cache_nr / THREAD_COST;
>> -		cpus = online_cpus();
>> -		if (nr_threads > cpus)
>> -			nr_threads = cpus;
>> +		/* TODO: does creating more threads than cores help? */
>> +		if (!nr_threads) {
>> +			nr_threads = istate->cache_nr / THREAD_COST;
>> +			cpus = online_cpus();
>> +			if (nr_threads > cpus)
>> +				nr_threads = cpus;
>> +		}
>> +	} else {
>> +		nr_threads = 1;
>>   	}
> 
> I'd have thought we could just rely on online_cpus() returning 1 here to
> avoid having to ask "do we even have thread support?". But I guess that
> TODO comment implies that we might one day two 2 threads on a single
> CPU.
> 
> -Peff
> 

See my earlier response - the HAVE_THREADS tests are not needed.

We can remove the "TODO" comment - I tested it and it wasn't faster to 
have more threads than CPUs.
