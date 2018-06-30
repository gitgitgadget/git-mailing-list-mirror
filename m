Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D971F516
	for <e@80x24.org>; Sat, 30 Jun 2018 01:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935545AbeF3Bc0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 21:32:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33434 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932784AbeF3BcY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 21:32:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id l10-v6so9513834qtj.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 18:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7yvY4rA21qx+iK0iQT4uB6Z0LqOMvsWs/1lvKdphBcU=;
        b=tkMcSzxvIbDbsbR8E443Db89AIs0oLQZgj/I0Xx90u6seduQdx+/27GlQKYyKZcNKc
         FF7Q0U46LVuEj8NbcztKj+8m7Tc28cz23vPFpc4ZN10icTSkU7UIA91JoGfjuW6O+dTj
         JBwcKd1uI+b2N138jrntc9+uLW1IOjytTjdOYXI8Q2ln3nu8mK/14hbgWQvovcKazGHc
         is35t8b0uQlnOIpsjP0aiEaWfzv2bkK7meuX8Ju4LyF0TZrwptgPzz1zLQY4SLOwRNR7
         YkEu5BhSclNXEgKurPJPY0orXm7QnrkMWomBzZZbwtJEsA8qtiFAq8yPJM7szef8mvn7
         24sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7yvY4rA21qx+iK0iQT4uB6Z0LqOMvsWs/1lvKdphBcU=;
        b=OXOXuYiZFeJyjAsfY6IJ8WbFHI3OkavjPshDO5CPQB3kyQPumBL0XTDnsG+/w0qVhS
         ZGybnwikYAW0lDWDrB/wFCD9PZqItnt+mRoAhqJ8hhJTVbLKBQX8ygLJc0s7DGPRFiiS
         WQFnt3Z6otdkcTqmxh+dNx0JjODkiyUvjH11RCLIGV1NNEUiE6kCbYksMtR4nIg7dIZB
         9Xx4DoC/J1mCRoZdfxdPQF7/t9ut506XvtGRFKz3fpU7Am/H+tBWenDz7c/G8UwBPvSJ
         A88K3UHcxpkaSgTzbgJg7Osh/9RpUsV23/KvA2S1VlLUej0fw06CPCuG8smJvKOtZUrU
         TL1A==
X-Gm-Message-State: APt69E11Cqxot+32G2cTRIM0Yfjlb/3d4Vc1TjI3FoRmN5Yjldvf4lW7
        hWsMEHMaLujkY3b4qtPTJjs=
X-Google-Smtp-Source: AAOMgpcK5MGPOBJB0xG1t9xbfIvJGkUbSn8QY0L614knGbJcaA4QgSyJ1zjwxUWYlR86xOO3dnvs5w==
X-Received: by 2002:aed:238d:: with SMTP id j13-v6mr15462484qtc.384.1530322343830;
        Fri, 29 Jun 2018 18:32:23 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 32-v6sm2757215qtc.96.2018.06.29.18.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 18:32:23 -0700 (PDT)
Subject: Re: [RFC PATCH 03/13] commit-reach: move commit_contains from
 ref-filter
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
 <20180629161223.229661-4-dstolee@microsoft.com>
 <CAGZ79kbMks+U94-==SB48DoSpYQOpa-bn_yJBjW7zH3cCCotng@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <74071f5d-af5c-a125-3125-f52dd0977cb4@gmail.com>
Date:   Fri, 29 Jun 2018 21:32:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbMks+U94-==SB48DoSpYQOpa-bn_yJBjW7zH3cCCotng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2018 5:38 PM, Stefan Beller wrote:
> Hi Derrick,
>
>> +struct ref_filter_cbdata {
>> +       struct ref_array *array;
>> +       struct ref_filter *filter;
>> +       struct contains_cache contains_cache;
>> +       struct contains_cache no_contains_cache;
> These members also seem to be moved whitespace-inconsistently.
> Could you clarify in the commit message that you re-indent them or
> what happened?

Sorry, there appears to be something strange that happens when I paste 
into vim that causes my whitespace to mess up, especially leading 
whitespace. Usually `git rebase --whitespace=fix` fixes it.

I'll be more careful in my next replay of the series.
