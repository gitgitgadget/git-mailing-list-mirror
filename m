Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95640215F4
	for <e@80x24.org>; Tue,  1 May 2018 15:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeEAPhr (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 11:37:47 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45378 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752182AbeEAPhq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 11:37:46 -0400
Received: by mail-qt0-f195.google.com with SMTP id j42-v6so14951780qtj.12
        for <git@vger.kernel.org>; Tue, 01 May 2018 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EPMXGhnwhqsmdJJIj5yP8l3yjsx7B1zv1i8k2AhhXFc=;
        b=GKyLoq4xAVYJGJxllgujyBcVy/4r1JIeBi8+ZXi/psJcsW3JSRNAxD+EpYOjKT7nSi
         +6rDItNJeXTOKEbPrDkpkHzD2vjQ4413Wtir7KMNFFni7w2+fVWLWlTQakj5Vr/znHrv
         hY2OLVG0mdqZ2Ijhqm6x0MclMjFZO0uf0gcXcOoqZrowoIq6VGsHoez3CwVwMl6f4Z57
         7tEb8oA/boCQsCibDGLx+ALaxK7twvX6eyzlLrKe5FD0uBy13xPzV0cqRD268iurg3nD
         8Sz7nWbIkqZ6gOYKeA9zxjad/BsdCxrveYo9ReN4mdPgoPPEnuoZDIP2yh70ArdIAEG8
         620g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EPMXGhnwhqsmdJJIj5yP8l3yjsx7B1zv1i8k2AhhXFc=;
        b=BABClbAsGjXXOWrV4Cy173QoZnMXjiMoOTnjRnLgJdPAr2+8LmgLALq9YWxniV6NvV
         XikbALxcD61zvH/jq6MC8vlfkYjMUExtsk1HKOBcw4aksHr3wyWCNRmFJ1uVHFFB3MMD
         3aJbJFdYmAiCZr86dBkZzn5xZ+jgNNnJCyYQrgkjZUKGv19gpUSa2YnGxrjt6uLejBGm
         CPSoaMNSd8gmGM0LgE03l48I6o9rmnaWPEWF7vruVYKms2iMDKMVoko3hZBih4gNGPsg
         ut2Xr15sZRw3Xg0uts1L5kf7ZO9Dl1zfSk7wC4LiGZfOCArXF7B2+lBgETwHinHevM0v
         cNxg==
X-Gm-Message-State: ALQs6tCXPCwMR0eAYY5q/Dq4HqJ03uJ2uCr0Hg5FZiZ8q7lpIZnMJaLJ
        pjA0yQnYYh/kiK4FlhNPT84=
X-Google-Smtp-Source: AB8JxZqZedGVL6tVWkB2pikGpkWPd8TVMwmkZ+21v9MUMOTeQ1heTSus1B3IG3RyKgs67ts5Zqe5JQ==
X-Received: by 2002:ac8:18c8:: with SMTP id o8-v6mr6399478qtk.400.1525189065213;
        Tue, 01 May 2018 08:37:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id w70sm11492738qkg.13.2018.05.01.08.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 08:37:44 -0700 (PDT)
Subject: Re: [PATCH v5 09/11] commit: use generation number in
 remove_redundant()
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>
References: <20180425143735.240183-1-dstolee@microsoft.com>
 <20180501124652.155781-1-dstolee@microsoft.com>
 <20180501124652.155781-10-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1cfe38f6-925b-d36b-53ae-6b586eed199c@gmail.com>
Date:   Tue, 1 May 2018 11:37:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501124652.155781-10-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/1/2018 8:47 AM, Derrick Stolee wrote:
> The static remove_redundant() method is used to filter a list
> of commits by removing those that are reachable from another
> commit in the list. This is used to remove all possible merge-
> bases except a maximal, mutually independent set.
>
> To determine these commits are independent, we use a number of
> paint_down_to_common() walks and use the PARENT1, PARENT2 flags
> to determine reachability. Since we only care about reachability
> and not the full set of merge-bases between 'one' and 'twos', we
> can use the 'min_generation' parameter to short-circuit the walk.
>
> When no commit-graph exists, there is no change in behavior.
>
> For a copy of the Linux repository, we measured the following
> performance improvements:
>
> git merge-base v3.3 v4.5
>
> Before: 234 ms
>   After: 208 ms
>   Rel %: -11%
>
> git merge-base v4.3 v4.5
>
> Before: 102 ms
>   After:  83 ms
>   Rel %: -19%
>
> The experiments above were chosen to demonstrate that we are
> improving the filtering of the merge-base set. In the first
> example, more time is spent walking the history to find the
> set of merge bases before the remove_redundant() call. The
> starting commits are closer together in the second example,
> therefore more time is spent in remove_redundant(). The relative
> change in performance differs as expected.
>
> Reported-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>   commit.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/commit.c b/commit.c
> index 9875feec01..5064db4e61 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -949,6 +949,7 @@ static int remove_redundant(struct commit **array, int cnt)
>   		parse_commit(array[i]);
>   	for (i = 0; i < cnt; i++) {
>   		struct commit_list *common;
> +		uint32_t min_generation = GENERATION_NUMBER_INFINITY;

This initialization should be

     uint32_t min_generation = array[i]->generation;

since the assignment (using j) below skips the ith commit.

>   
>   		if (redundant[i])
>   			continue;
> @@ -957,8 +958,12 @@ static int remove_redundant(struct commit **array, int cnt)
>   				continue;
>   			filled_index[filled] = j;
>   			work[filled++] = array[j];
> +
> +			if (array[j]->generation < min_generation)
> +				min_generation = array[j]->generation;
>   		}
> -		common = paint_down_to_common(array[i], filled, work, 0);
> +		common = paint_down_to_common(array[i], filled, work,
> +					      min_generation);
>   		if (array[i]->object.flags & PARENT2)
>   			redundant[i] = 1;
>   		for (j = 0; j < filled; j++)

