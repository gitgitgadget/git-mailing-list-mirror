Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D461F424
	for <e@80x24.org>; Mon, 23 Apr 2018 16:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755724AbeDWQpC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 12:45:02 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43166 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755605AbeDWQo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 12:44:59 -0400
Received: by mail-qk0-f195.google.com with SMTP id v2so16788558qkh.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 09:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0SDHdpsHU5B+qANohfsSQgSOqe0tx1ZN4EbjlVXs8A=;
        b=Ic6uOcX2b1fCO7Xhupop0/8wAIeowNgLKQ+kK0YGFmpvuyI5vQ1dgh6bLseyV3Y/WQ
         nkhF8UFVWENfpWBz958kQmSvo92b+KnILdMma26ibZ8pZ2g9s0BfoJIgXwRoZXDLM4LD
         iHsUFWNqoeeZEQMdSIsd+1M8LvIX4BMQFJNyZ/sJWnOXjRdNLRYmorllWEcQFqUVoTAd
         jyURD/cRKxd2IP0k5N59OwVPhN0xOUihdXiDZTYPA+1dCKsbxXZ6EZ4M97JuFIp7jr82
         F+40pGb4Je4NrCp3I9C+aj+dinVFkFvqMquT9L73h82pdTS8j2zI/vL3JmqMR5t7rirW
         Rijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0SDHdpsHU5B+qANohfsSQgSOqe0tx1ZN4EbjlVXs8A=;
        b=tBvOjKb2Z9cmKXLRdBuKY3c1QkBtJGbOw9afeiOc2JpK+eywXIFtUXcvN792gkZqd2
         zDHV6wA/jf/8dnpAMZAmiOj7+kF4tkgESO+D7QAR1Xa4gChwLZrAwSzILBSaqJwIZrfz
         OInGr/SB/Mde3KDCu5OBJdi5SAr27SQ8y1WVZy9slSVrZD/eOhrbXsGmkg8UYKQzvf7T
         gKIARl2J1Cb4Id8hN7nT4VARlZ1mpPZ9i6WUpMDQrcEJzUAlQ7EoUhNxm3PCP7PeEdCe
         P4p9BQQk094Ha9zoq2bmlWDP9WP8SNnV/ZkIzDSpFNuJZYGkx6smG6B029BDRdM9ewMw
         nTDA==
X-Gm-Message-State: ALQs6tAirsBNw1RWu1gKPr/TuuvVoVOeBdDBM8LYJO6DrLnYkAJICjft
        2jAuZp6MMVNBWJOb1pMmbzY=
X-Google-Smtp-Source: AB8JxZoXjGtOni4i4P2WFQgcv53Od/CayP9yi2G8tUlayJ4fQsvsWJcjLRApUNFshFGbuHkXlt/BqA==
X-Received: by 10.233.222.68 with SMTP id s65mr23906706qkf.177.1524501898759;
        Mon, 23 Apr 2018 09:44:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id x3-v6sm8967971qtf.48.2018.04.23.09.44.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 09:44:58 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <xmqqwox5i0f7.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbOQLkNZxHbR0bDwVHbT0x47v8qp81E2WFm72HdZJ4ZRA@mail.gmail.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <3ec5999c-f81d-eafb-1597-4fa93f943a6d@gmail.com>
Date:   Mon, 23 Apr 2018 12:44:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbOQLkNZxHbR0bDwVHbT0x47v8qp81E2WFm72HdZJ4ZRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/20/2018 01:49 PM, Stefan Beller wrote:
>>> base-commit: cafaccae98f749ebf33495aec42ea25060de8682
>>
>> I couldn't quite figure out what these five patches were based on,
>> even with this line.  Basing on and referring to a commit that is
>> not part of our published history with "base-commit" is not all that
>> useful to others.
> 
> I'd like to second this. In the object store refactoring, I am at a point where
> I'd want to migrate the memory management of {object, tree, commit, tag}.c
> which currently is done in alloc.c to a memory pool, that has a dedicated
> pointer to it.
> 
> So I'd either have to refactor alloc.c to take the_repository[1] or
> I'd play around with the mem_pool to manage memory in the
> object layer. I guess this playing around can happen with
> what is at origin/jm/mem-pool, however the life cycle management
> part of the third patch[2] would allow for stopping memleaks there.
> So I am interested in this series as well.
>

Sorry about the confusion here. This patch series can be applied to the 
next branch. They apply cleanly on [3]. The lifecycle functions are 
re-introduced in [4], which we could incorporate sooner if useful. I 
didn't have a consumer for the calls in the original patch series, and 
so deferred them until there was a caller. I would be interested to 
understand how the mem_pool would fit your needs, and if it is 
sufficient or needs modification for your use cases.

> [1] proof of concept in patches nearby
> https://public-inbox.org/git/20180206001749.218943-31-sbeller@google.com/
> 
> [2] https://public-inbox.org/git/20180417163400.3875-5-jamill@microsoft.com/
> 
> Thanks,
> Stefan
> 

[3] b46fe60e1d ("merge-fix/ps/test-chmtime-get", 2018-04-20)

[4]
https://public-inbox.org/git/20180417163400.3875-5-jamill@microsoft.com/
