Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BC51F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 16:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJIAKO (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 20:10:14 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:42238 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJIAKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 20:10:14 -0400
Received: by mail-qk1-f179.google.com with SMTP id g20-v6so12470761qke.9
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rm5oggyJ8mz3sa6Oybejvk3Mq3Mxx9lnH55ISJcP+iQ=;
        b=a2vrzsxFTc7ZWQCi5nkR8Xnd0diNvntHIAqlhOLl4VF2tDDWArYJWzXr27nyMR3Wc5
         +r7RCOhgEbWoHtznIAOcHi8JVH7Sd9RBC2rqyiqtfJR1gzWu29hbw6Z1/elNTlx5BLj/
         1Z/HXxaB0c6Rx4UpMZAm819Y6B/hjPfZ0a8spTllqWWv2kKymZ5seUiWzklKen0izZoh
         qEPpjgCzbACYJ2kV1gKAoSZsxvC08HYbL4VSeKyP9xWsuKLHYQpQ7e7hPxImAPHpG3vO
         0a1jNvOZ6+STHfTbTdihfrykV0/Xe/4Gl/gceoa2nbRnr1D9sHLnYg87Sm8i/EZHwkxE
         2LRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rm5oggyJ8mz3sa6Oybejvk3Mq3Mxx9lnH55ISJcP+iQ=;
        b=b7Cj0RBVW96kQROFyPbV08lTxNywD/ZwLgDE1VoiwdkXho+sOdPyWbNgzKca0leMMA
         dRSztGTwqW8UzfSFFql94pdlI9Pslh5dLyQP6zYZHk1QqNZe4dLY7wBBoDth824UOWzi
         B9+JiWpY0YKlmYdnxQtmvqTxDVMXQvNFX6W6kiR7O1+SlI/Kt1cmKBUA+hNKyVE/perN
         6qJ01gNaX9PzwHgoxg8Fb+tcDBzjQAhRrRVbPwyxUTFJeTLLqqesqLFAOVX4Qc3osxQl
         HET0ESxEM6LAOrtxuXUxkBKe/nUiu4MnybzOwX7wQhq76rH9SCiTCnIF9tMxwLZ7JWFq
         xpgw==
X-Gm-Message-State: ABuFfogyPAohb51X7TIWED5CyKgzuuCIZSSY97d8m+q2DmusOafuovvN
        GmDr+GhxKAABGzqTXBmK5IE=
X-Google-Smtp-Source: ACcGV62BZL3dOv0Y0/xpwWj3TTx3Wngv0f3IwGmjuYfzpFU6W43Ki6jctGuAxeqxoyatFxGoxRq6Sw==
X-Received: by 2002:a37:ccd5:: with SMTP id n82-v6mr19037410qkl.16.1539017854579;
        Mon, 08 Oct 2018 09:57:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1c56:381e:537f:a878? ([2001:4898:8010:0:58c:381e:537f:a878])
        by smtp.gmail.com with ESMTPSA id p51-v6sm9979207qta.61.2018.10.08.09.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:57:33 -0700 (PDT)
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost> <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost> <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
Date:   Mon, 8 Oct 2018 12:57:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181008164141.GZ23446@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2018 12:41 PM, SZEDER Gábor wrote:
> On Wed, Oct 03, 2018 at 03:18:05PM -0400, Jeff King wrote:
>> I'm still excited about the prospect of a bloom filter for paths which
>> each commit touches. I think that's the next big frontier in getting
>> things like "git log -- path" to a reasonable run-time.
> There is certainly potential there.  With a (very) rough PoC
> experiment, a 8MB bloom filter, and a carefully choosen path I can
> achieve a nice, almost 25x speedup:
>
>    $ time git rev-list --count HEAD -- t/valgrind/valgrind.sh
>    6
>
>    real    0m1.563s
>    user    0m1.519s
>    sys     0m0.045s
>
>    $ time GIT_USE_POC_BLOOM_FILTER=y ~/src/git/git rev-list --count HEAD -- t/valgrind/valgrind.sh
>    6
>
>    real    0m0.063s
>    user    0m0.043s
>    sys     0m0.020s
>
>    bloom filter total queries: 16269 definitely not: 16195 maybe: 74 false positives: 64 fp ratio: 0.003934
Nice! These numbers make sense to me, in terms of how many TREESAME 
queries we actually need to perform for such a query.
> But I'm afraid it will take a while until I get around to turn it into
> something presentable...
Do you have the code pushed somewhere public where one could take a 
look? I could provide some early feedback.

Thanks,
-Stolee
