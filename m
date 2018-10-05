Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0CD31F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 20:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeJFDAb (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 23:00:31 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40070 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeJFDAa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 23:00:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id b4-v6so7051061qtc.7
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pmA/EAJgBa7+Ap03pXdDhtl0gvmFK3cBPFPRdjnj39s=;
        b=hI1E2PPwXYA9m7tcYDaQkglqQS/eTB7XLzzQUVNNKxuwuE19sJgtrIpfWqo3OgnlFH
         7AlWm59LQiz6oev+NYH0J/kxEEMOGiVh1l5sTE1NMDE1T17/LlzJgK4xKUrCIVLM4qLd
         zKreJ05DtIZNVPElJdkUAbuzr9u4oHzVwQLtKfZNlrjbajaBX+73So0RX+J5UKJOunL3
         +25DXNq0xaw1S6fY6YN0A6tNXu0Nhu6MC2iqHVSDgEMruU7NdipjU+YaDbmiNeLLRG0J
         +tgbqYhr301rEgGGsI5gnkdtmOFydhsCAUqx+4KOiyylovBqgnYZn1Ar5sE+EFdXTAfI
         U6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pmA/EAJgBa7+Ap03pXdDhtl0gvmFK3cBPFPRdjnj39s=;
        b=UFpcamt9W31Rvzme+U0V3cT3Js+R4r9CpjibvKoKqCxmhO/W1KQj6+wrjWz0lJ5d6E
         ozKOSh0Qz8vLSzxG2hAzJdIJLguAxsDsebpv4DUxslnmc9Dy+resktwzyzHUjfbF2E0W
         ifzt7bzXzD9y/yndFp2IzbB4up3Cnzz6xjK4CuF1TGF5Yq2Eak0KksnLMPVwEUz9VIQE
         NxuhNsI/qAv+OYpvN9VR0a48XU4pNaIEF6rNayRQiqhKHLcTPtjviVS9zajMJYr6oDkg
         BpOqHpDUp/MWqB+1HX/7QiJ8WygH4ASRNZfcZG/pMCOBVLwlS5urWvIYJJK8XXvohOvv
         l0NQ==
X-Gm-Message-State: ABuFfojF2IpZXv9imXQ08BLNgBJGTvzf9G0kgmUB/hck5SUPkLCaYRt+
        YMjj3ODkH7oI4nd41/O8Olk=
X-Google-Smtp-Source: ACcGV62K1Kynqm+2kd8tn52tLQ0t4RRo6twzPVzIauNr/HHNVOVa4ri7fwIhJpfPkCT3MjylJvVmxg==
X-Received: by 2002:aed:39e8:: with SMTP id m95-v6mr10861232qte.30.1538769615160;
        Fri, 05 Oct 2018 13:00:15 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id a28-v6sm5271973qtb.4.2018.10.05.13.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 13:00:14 -0700 (PDT)
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due
 to commit graph
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?Q?y?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <87in2hgzin.fsf@evledraar.gmail.com>
 <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
 <87ftxkh7bf.fsf@evledraar.gmail.com>
 <05fefab0-4012-4ef0-5df1-2430eea2bf4d@gmail.com>
 <20181005192154.GD17482@sigill.intra.peff.net>
 <934fa00e-f6df-c333-4968-3e9acffab22d@gmail.com>
 <20181005194703.GA19735@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <14529aaa-fee0-e839-4629-bf87cdd13e31@gmail.com>
Date:   Fri, 5 Oct 2018 16:00:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005194703.GA19735@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2018 3:47 PM, Jeff King wrote:
> On Fri, Oct 05, 2018 at 03:41:40PM -0400, Derrick Stolee wrote:
>
>>> So can we really just take (total_objects - commit_graph_objects) and
>>> compare it to some threshold?
>> The commit-graph only stores the number of _commits_, not total objects.
> Oh, right, of course. That does throw a monkey wrench in that line of
> thought. ;)
>
> There's unfortunately not a fast way of doing that. One option would be
> to keep a counter of "ungraphed commit objects", and have callers update
> it. Anybody admitting a pack via index-pack or unpack-objects can easily
> get this information. Commands like fast-import can do likewise, and
> "git commit" obviously increments it by one.
>
> I'm not excited about adding a new global on-disk data structure (and
> the accompanying lock).

If we want, then we can add an optional chunk to the commit-graph file 
that stores the object count.

