Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1E41F453
	for <e@80x24.org>; Fri,  2 Nov 2018 01:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeKBK4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 06:56:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKBK4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 06:56:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id y3-v6so74138wrh.10
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Af/AD+JVvO9RxEh3FVo3SJP55QKRBZwnrtjyRn7QVBE=;
        b=Q3gLvDsJsL+3Kl4+e28VI5ggvuASXC9JAGRvA3Vbl9TznZtYhsxj9NRzuGkGNfRHoQ
         N/GKykb8Wi3tf89zEcZa1GYPm85zshMHwMkpRvb1FT2Vd4NRLiBVOq26cBEiKRlDYUGH
         ZN/9rLM5W+NBMQD93CP2bP1Z+LDCZlHpMixT/iRg2ZKFxNCGA+QYDmn0+GqFKxrUmRMs
         tSgWOfRQeAoeJwKf7InC8h582UY3X3tbHPMS76eJf3TYyrD7p7GXVlfY0YSLW7vd0WRQ
         vG1LBTnk60GYkwMV9AaIV5IZQQrHIzRuCZ2XGRwucoxbHU6L1mTdTCsdTllLMBfZs6XP
         8fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Af/AD+JVvO9RxEh3FVo3SJP55QKRBZwnrtjyRn7QVBE=;
        b=bH27yYFsS4giphar9nByAkPWwigor09GG5a1ycCKCwBXMq1xtTLQ9t8GQSl1x4pHuT
         fkGpsxxc6zC69948KaLKcCv0srSYlxWcoyJCdr4UkhyRfsIOtRtCjkTz9dzrokji/BqD
         ke/ZNMY5mlwfS8hS6xkCEnZe2haXBzM1zb7agDy9FyjmuiB7a1wO0LIMEpb/Wd+RWs5N
         TYv9qgASAEYZLWmbfuzGxIgbuS5uPbbxWqc6z9OXKUgElISZwkFwNop8OnFkjXNyzWma
         Uz/Ja33X1W4JY5pU2sVXndLjqMRUkqC1RLAizbmLn7Xk5MYC6nq5v8DTNQQiT14p2Drw
         K7tA==
X-Gm-Message-State: AGRZ1gKo9JXNartvh6keO9valrE+vsiE+8YHLIMwzA10jmlnb95ivrfs
        vCJgeBwo/6jl+J+I/DWHZ34=
X-Google-Smtp-Source: AJdET5d2lzslD073Cz1YO048OKzzPTvAV9Tmi8QyNLRqk2IdJ9OEYiKVYHZDvFzLKwmy7x/Ve8EtLg==
X-Received: by 2002:adf:e651:: with SMTP id b17-v6mr8475915wrn.254.1541123476845;
        Thu, 01 Nov 2018 18:51:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c3-v6sm6307621wrq.13.2018.11.01.18.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 18:51:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] commit-reach: implement get_reachable_subset
References: <pull.60.git.gitgitgadget@gmail.com>
        <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
        <xmqqy3aeyehs.fsf@gitster-ct.c.googlers.com>
        <15ef2018-4bb1-430f-32fd-5676a1b5ac1a@gmail.com>
Date:   Fri, 02 Nov 2018 10:51:14 +0900
In-Reply-To: <15ef2018-4bb1-430f-32fd-5676a1b5ac1a@gmail.com> (Derrick
        Stolee's message of "Wed, 31 Oct 2018 08:01:48 -0400")
Message-ID: <xmqqk1lws0vh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> We could do this, but it does come with a performance hit when the following
> are all true:
>
> 1. 'to' is not reachable from any 'from' commits.
>
> 2. The 'to' and 'from' commits are close in commit-date.
>
> 3. Generation numbers are not available, or the topology is skewed to have
>    commits with high commit date and low generation number.
>
> Since in_merge_bases_many() calls paint_down_to_common(), it has the same
> issues with the current generation numbers. This can be fixed when we have
> the next version of generation numbers available.
>
> I'll make a note to have in_merge_bases_many() call get_reachable_subset()
> conditionally (like the generation_numbers_available() trick in the
> --topo-order
> series) after the generation numbers are settled and implemented.

Sounds good.

I wondered how this compares with in_merge_bases_many() primarily
because how performance characteristics between two approaches trade
off.  After all, what it needs to compute is a specialized case of
get_reachable_subset() where "to" happens to be a set with only
single element.  If the latter with a single element "to" has the
above performance "issues" compared to paint-down-to-common based
approach, it could be possible that, for small enough N>1, running N
in_merge_bases_many() traversals is more performant than a single
get_reachable_subset() call that works on N-element "to".

I am hoping that an update to better generation numbers to help
get_reachable_subset() would help paint-down-to-common the same way,
and would eventually allow us to use a single traversal that is best
for N==1 and N>1.

Thanks.

