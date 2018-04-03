Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A771F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDCS3F (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:29:05 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:32866 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeDCS3E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:29:04 -0400
Received: by mail-qk0-f177.google.com with SMTP id d206so19702517qkb.0
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xmfm2qM8F1J9MXrLauqq4AAQtsDNDH9RD6gntSS4oeM=;
        b=CMn3jjFtmOOqQjwezZUHnbvK9ohiHGxWpZVeTg6E0V2OhG1p0hkwYpPFUEsESDbN+r
         dZUBrd0dznK4q5uPMbEsYZPKdvgBifckhptQtKiaWY0n7WdCLT93wwLvxrFLM+BZ9ko7
         IU+pxRC8cobh4kTVzpsDjiNXHwc6jJmwmOPHHWxuPxwmeKFGXiOZ3ZkH8FjylOGA5/78
         IBCkPRTKegOc271vr59u8WFlVPiAjyEpMEHkXk63Y7Pilzfeo+cziAHYcwfe3Hd2lKH2
         0PXUl/6346lpoDvO4fnUWnuJdMlJLBicY3aL8uFjIvtVjUMFN9fuBV+NphEBtv3bW2+G
         /DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xmfm2qM8F1J9MXrLauqq4AAQtsDNDH9RD6gntSS4oeM=;
        b=dYi2yXrTSztuftlnXrt0eMJjCVTD1nEgU4ytU2dSSbuz7kEv1EVhp/GGi+GPAO1HU8
         7xjRExYYwqnQbDXhTZee7lGjokvz+7gpnzi/x9GOr0uSUi6Re4b+PYQtiq7yYjqY18n3
         gJeNskYmPXCNZEOZcn+sVGi5dCtx6sr+uJ3GGbPY/MqYpJ0Vzfez4N0a5cSH6ikpz4WG
         SPOWeGD+ZvDHBA49x5/P7qT4K7alreRkb0u4coAeUeYlwC6HorcW9+z4rTRRXOX1Xy1F
         QtwqLuUmL19lbvZHqeqYeCdxxj8FV9spl/QqzxpKIw8tLXwXVwE+uEnHHMAivqpvM0C/
         jlgA==
X-Gm-Message-State: ALQs6tBwt36qQ/y6ZvxyyI9XOoUcbMrtQy47CFUx6AOtG4Hw5DpUZtRd
        iwznwU9LqES7lcWP7H4syP0=
X-Google-Smtp-Source: AIpwx49tjFVXr8CCTH1Anh/1lkgnvouArrYSICS1MvqOVbUEAd5GZFoymGIElcixYIc39nit9rTYgw==
X-Received: by 10.55.209.79 with SMTP id s76mr20457127qki.89.1522780143446;
        Tue, 03 Apr 2018 11:29:03 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v186sm2508137qkd.49.2018.04.03.11.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 11:29:02 -0700 (PDT)
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
To:     Brandon Williams <bmwill@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180403180336.GA100220@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f8e171f9-0936-1412-81f9-1149fd2c5a23@gmail.com>
Date:   Tue, 3 Apr 2018 14:29:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403180336.GA100220@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 2:03 PM, Brandon Williams wrote:
> On 04/03, Derrick Stolee wrote:
>> This is the first of several "small" patches that follow the serialized
>> Git commit graph patch (ds/commit-graph).
>>
>> As described in Documentation/technical/commit-graph.txt, the generation
>> number of a commit is one more than the maximum generation number among
>> its parents (trivially, a commit with no parents has generation number
>> one).
> Thanks for ensuring that this is defined and documented somewhere :)
>
>> This series makes the computation of generation numbers part of the
>> commit-graph write process.
>>
>> Finally, generation numbers are used to order commits in the priority
>> queue in paint_down_to_common(). This allows a constant-time check in
>> queue_has_nonstale() instead of the previous linear-time check.
>>
>> This does not have a significant performance benefit in repositories
>> of normal size, but in the Windows repository, some merge-base
>> calculations improve from 3.1s to 2.9s. A modest speedup, but provides
>> an actual consumer of generation numbers as a starting point.
>>
>> A more substantial refactoring of revision.c is required before making
>> 'git log --graph' use generation numbers effectively.
> log --graph should benefit a lot more from this correct?  I know we've
> talked a bit about negotiation and I wonder if these generation numbers
> should be able to help out a little bit with that some day.

'log --graph' should be a HUGE speedup, when it is refactored. Since the 
topo-order can "stream" commits to the pager, it can be very responsive 
to return the graph in almost all conditions. (The case where generation 
numbers are not enough is when filters reduce the set of displayed 
commits to be very sparse, so many commits are walked anyway.)

If we have generic "can X reach Y?" queries, then we can also use 
generation numbers there to great effect (by not walking commits Z with 
gen(Z) <= gen(Y)). Perhaps I should look at that "git branch --contains" 
thread for ideas.

For negotiation, there are some things we can do here. VSTS uses 
generation numbers as a heuristic for determining "all wants connected 
to haves" which is a condition for halting negotiation. The idea is very 
simple, and I'd be happy to discuss it on a separate thread.

Thanks,
-Stolee
