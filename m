Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CDE1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 16:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJGAAj (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 20:00:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37614 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJGAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 20:00:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so4567196wmt.2
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tpJFQFsKD4oiHEIydDkCfa9Ouhkgy4vVpQ1Yc/l+RzM=;
        b=QI5sxvQP2IB0tedI1WPfhwzvsOLmu1R7R4Dbv4XJq2MTJo8OLnVe+is7J0BNtVMlau
         spqBgzeaqh49N8uH4rlbEPIuVAcPHqCMyFn59o3v81ZpVcsTzSO/K861u1GeQvydgYy8
         Qfn6xXN/ovJrGXmFdww2zBNCxZUWYuiQe4W/rmCOh6qzWvWi3KgyreWz9Ni9HA7/a3XB
         OBJH/J5NaTuSuhOmsc0KiD69Qhh+Eiv3M8f7CjpVgs5MrW1PILheFPqE34r+6hyhv6Lq
         u30c0Cpdu35OOEl33AfX7bYMm8Dw5d27gVZcbe8YlZE+n6aEO6KmjoOkyDzNYFsT2quI
         wnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=tpJFQFsKD4oiHEIydDkCfa9Ouhkgy4vVpQ1Yc/l+RzM=;
        b=sUbc0d42Fk7fPv3TeRz8OtlDbjbi5RNj1mHJVmlsDrTQYoKikJSC2U3SMwMZ8XXIUe
         sDO/pYmawv1uKCeijIv5W8e1/Fr2z8XwEJIMitlJoFtVpLZu/NskohVLYLHjI9jsgvm8
         ysws9RJQ76IWSKdiCkpfRoik3ybQVcf8yyI6xHACCjqFN/inc/oaht4o33+gL1Zh+Vt6
         9a7e7yXpywf8wyy02FDJwyQJbHBVfP1RQ82A7X8wT3u9fcKnCsGZZ8bd7Bi03mBrvpDK
         GZnK2/CRkryS6F1PEq7687wYIOt11lU9D6X5Q+1v7Mxa+OrZZqko/T+PS5zuxdpFx+B8
         I+Sg==
X-Gm-Message-State: ABuFfogzkm/y8r0+2CQrHIQJNr4INT1rAKeyMQnFP8SMdwLcJh9swKPF
        1//Q5Syv8xqdU7NWbmXJShY=
X-Google-Smtp-Source: ACcGV60K5ATL+Zt3wdkM5+OQZnfQukIfOe8iMVEZaD43pllbSNpK71hKWRLoR87WLk6K6F69u1hk7w==
X-Received: by 2002:a1c:b743:: with SMTP id h64-v6mr10673792wmf.26.1538844992072;
        Sat, 06 Oct 2018 09:56:32 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (eka203.neoplus.adsl.tpnet.pl. [83.21.168.203])
        by smtp.gmail.com with ESMTPSA id j6-v6sm1337074wru.20.2018.10.06.09.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 09:56:30 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 7/7] revision.c: refactor basic topo-order logic
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
        <020b2f50c5703e8291577b008fdfa567093c6eab.1537551564.git.gitgitgadget@gmail.com>
        <7b1640a0-4002-9e5f-ea06-4504a5cc9f43@gmail.com>
Date:   Sat, 06 Oct 2018 18:56:30 +0200
In-Reply-To: <7b1640a0-4002-9e5f-ea06-4504a5cc9f43@gmail.com> (Derrick
        Stolee's message of "Thu, 27 Sep 2018 13:57:21 -0400")
Message-ID: <86r2h3xbcx.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/21/2018 1:39 PM, Derrick Stolee via GitGitGadget wrote:

> Hello, Git contributors.
>
> I understand that this commit message and patch are pretty
> daunting. There is a lot to read and digest. I would like to see if
> anyone is willing to put the work in to review this patch, as I quite
> like what it does, and the performance numbers below.

I'll try to find time to review v3 of this patch series this week.

>> In my local testing, I used the following Git commands on the
>> Linux repository in three modes: HEAD~1 with no commit-graph,
>> HEAD~1 with a commit-graph, and HEAD with a commit-graph. This
>> allows comparing the benefits we get from parsing commits from
>> the commit-graph and then again the benefits we get by
>> restricting the set of commits we walk.
>>
>> Test: git rev-list --topo-order -100 HEAD
>> HEAD~1, no commit-graph: 6.80 s
>> HEAD~1, w/ commit-graph: 0.77 s
>>    HEAD, w/ commit-graph: 0.02 s
>>
>> Test: git rev-list --topo-order -100 HEAD -- tools
>> HEAD~1, no commit-graph: 9.63 s
>> HEAD~1, w/ commit-graph: 6.06 s
>>    HEAD, w/ commit-graph: 0.06 s
>
> If there is something I can do to make this easier to review, then
> please let me know.
>
> Thanks,
> -Stolee
