Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406B81F453
	for <e@80x24.org>; Mon, 22 Oct 2018 02:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJVKq3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 06:46:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33212 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeJVKq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 06:46:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id u1-v6so7325750wrn.0
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 19:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qo4NpBHtIFYE9uYYpAXOsQaglluG4d5oQ7vNPZfniKA=;
        b=CcXxsWiPfy6PifBHPmG7zJmXGHu0wmh66R6Y8rtwAIbHkka7TS5vZGIO4UnXymjnzu
         Z1bC6WLrgrwMgKc+A1PJ9t66H9pasBImPP0nBP8tdwLMDUs4/mxSAxH9MJmT8JyEa1/P
         TN2FeQvzEOUV/3BSC75pH2Qc9CiwJotXxaGUVvsFIloBeOdJizQFNbU2mEc/WFDCpzqI
         LkUPZdFFKeuDa6lXaCp83DLzAbCaZ3DRCxri7wGevueHWYoHdcT0Y1CY0E0gSBjqavm8
         jOqCytlMiD72wlmak/gCI0O84lDA/Y0HKRk4C2dqS1l8S0oL1YO697Xg4F533Xt11WUY
         xnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qo4NpBHtIFYE9uYYpAXOsQaglluG4d5oQ7vNPZfniKA=;
        b=k57W7e+3BurjN+fzezl+2MUMGg1WCVHP9TB08I7sffvriUtUgnxthPUoUBrReGgLYt
         b2k5hyFdx8b0DpSHXPXtRkklM5NuORvqBa1wC2VD2QcB2ePwCtezG3XhAOtqjg6WTuJe
         hBpGsfKWhBSFbCOAeaMjfu7OuZbpL3w2wRLPEADwm42M+OP3oK+qp0XvFh8yNj/WVtLs
         b9wdOUqkiZh/lk+XwxM2Db8DyhlCYR5ZZzFUt5J+hnNKjAO7vbRIg7B8VJvTyRarE88L
         W7YwY0hRi3TqwUTAWicH2yQ20fGbZLCpcYq1klvGupLf8F8T9Xz3y0ydlWsESEm0W9YS
         SlaQ==
X-Gm-Message-State: AGRZ1gKOy2z51Olab6E/i4LErsRHQ9yUFhqAndeD7cS1Ov6JtavLZnv1
        t5C6YTp+kjW4UijnJcif1bM=
X-Google-Smtp-Source: AJdET5eorib7HBGVIUIx9jx6ILtF3JQnqzVaDHdqe25UDQxTauF7EIXhP0WS7Bom2ru7rEjgv0CCyQ==
X-Received: by 2002:adf:83a4:: with SMTP id 33-v6mr683540wre.13.1540175396314;
        Sun, 21 Oct 2018 19:29:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s132-v6sm8963707wme.14.2018.10.21.19.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 19:29:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-reach: fix first-parent heuristic
References: <pull.51.git.gitgitgadget@gmail.com>
        <53ebceb7f11d1e1ea39ae4ca86850190ae839eff.1539883476.git.gitgitgadget@gmail.com>
        <xmqqd0s61pat.fsf@gitster-ct.c.googlers.com>
        <d8a21999-3080-0989-49ae-995074cf7672@gmail.com>
Date:   Mon, 22 Oct 2018 11:29:54 +0900
In-Reply-To: <d8a21999-3080-0989-49ae-995074cf7672@gmail.com> (Derrick
        Stolee's message of "Fri, 19 Oct 2018 08:32:19 -0400")
Message-ID: <xmqqk1mayaql.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 10/19/2018 1:24 AM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> We can also re-run the performance tests from commit 4fbcca4e
>>> "commit-reach: make can_all_from_reach... linear".
>>>
>>> Performance was measured on the Linux repository using
>>> 'test-tool reach can_all_from_reach'. The input included rows seeded by
>>> tag values. The "small" case included X-rows as v4.[0-9]* and Y-rows as
>>> v3.[0-9]*. This mimics a (very large) fetch that says "I have all major
>>> v3 releases and want all major v4 releases." The "large" case included
>>> X-rows as "v4.*" and Y-rows as "v3.*". This adds all release-candidate
>>> tags to the set, which does not greatly increase the number of objects
>>> that are considered, but does increase the number of 'from' commits,
>>> demonstrating the quadratic nature of the previous code.
>> These micro-benchmarks are interesting, but we should also remember
>> to describe the impact of the bug being fixed in the larger picture.
>> What end-user visible operations are affected?  Computing merge-base?
>> Finding if a push fast-forwards?  Something else?
>
> Sorry about that. Here is a description that could be inserted into
> the commit message:
>
> The can_all_from_reach() method synthesizes the logic for one
> iteration of can_all_from_reach_with_flags() which is used by the
> server during fetch negotiation to determine if more haves/wants are
> needed. The logic is also used by is_descendant_of() which is used to
> check if a force-push is required and in 'git branch --contains'.

I am afraid that it is still not end-user serving enough.  The level
of "larger picture" I had in mind was those that would appear as an
entry in the release notes, e.g. (this is for illustration purposes
only; I do not claim its actual contents is correct).

	We started using commit generation numbers in various
	reachability computations, but due to a bug, negitiation
	between the "git fetch" and the server started to require
	30% more roundtrips than necessary, and it has become less
	efficient to see if a commit is a descendant of another
	commit in certain cases, which has been corrected in this
	release.

Thanks.
