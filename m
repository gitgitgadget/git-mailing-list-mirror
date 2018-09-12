Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8F21F404
	for <e@80x24.org>; Wed, 12 Sep 2018 13:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeILSNC (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 14:13:02 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42552 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILSNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 14:13:01 -0400
Received: by mail-qt0-f194.google.com with SMTP id z8-v6so1714710qto.9
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z0CXIfzr+vRSWdUsCVGrWszugAGRxYinBnHQw3gXIDU=;
        b=l9egWxDkEBkwgFcNDu/3tyN9s1bcd0+Soz8wUPCEpQ51hiyelZwKLcVthk/GTqZhSE
         5zak6iFWlFVXVJl03/Sj8K8rYzGS7gRhfh14WFZ/5T9bWSWDdm6pEutNqLpP2gVxPeTw
         N4afqA8Ek/fy626OfwDbYN+l3qoZPCVKenJtHHRywSya4q+fUBLPLqu4RzZ4tl30wVIB
         Cee78OuKJooD18hZ3LusAxwkCTLNXoqTtX6PFRDi5jxYbb4CktwJKCF+XLkXnyNirlKC
         NN+jZ78qDszYjcEBdzzPgO/cWYBjZd0Rx/WAcImIN1I2KXgkP/ohE5MiRoYGDv1vs05o
         gz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z0CXIfzr+vRSWdUsCVGrWszugAGRxYinBnHQw3gXIDU=;
        b=QKbKGw6b9hdpoyvRdQ7jNAAPQsxiOgciJ/bLI9qdKaybd8cS6YfW1SUojVjBMWq2nN
         EHjMGxxH1lkfQgpeGfGA2xY/FV+jjx00hi9JklozvJs9IwF+n8bZj3GvjXv0Jj0AfLdP
         2Ejq7WBBbgCnB1EBlTS3hwmM+MJMryMq0ha/Vhi7IWau7gc/Hr7YsYRsw0ZqK25daRGh
         Jan8WRQuQ1NY/3IuDkNkblU0sV5Ej+0ji6H1eY8gRhOfuY5MsuHJkbpFPFIcXD9wgFDT
         t2KrsSK2OW9Mn5F1ZTLtgjPWqrhrNKEBS3n5WEx0sZcdU6s/Qx6ZXfg6sSUiUyoYJCSt
         xMCQ==
X-Gm-Message-State: APzg51BxWyJHu21lWJCjR5yzgANIdOGC7czUGxzYtNuURJ1eVRUdWP4m
        4Pnse1PPvauREUUR7KlVyNU=
X-Google-Smtp-Source: ANB0Vdb2NamiRvWBfWh4HSgSiu8z3ldcV76BDMrNLfN9OwhpPBf9F4xRDlJf2q74X3TAdSAu8CsGQg==
X-Received: by 2002:a0c:8c05:: with SMTP id n5-v6mr1345450qvb.185.1536757714477;
        Wed, 12 Sep 2018 06:08:34 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id m51-v6sm528488qtc.85.2018.09.12.06.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 06:08:32 -0700 (PDT)
Subject: Re: [PATCH v2 17/18] commit-reach: make can_all_from_reach... linear
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-18-dstolee@microsoft.com>
 <20180912041425.GA10472@sigill.intra.peff.net>
 <20180912042938.GA15876@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com>
Date:   Wed, 12 Sep 2018 09:08:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912042938.GA15876@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/12/2018 12:29 AM, Jeff King wrote:
> On Wed, Sep 12, 2018 at 12:14:25AM -0400, Jeff King wrote:
>
>>> +	ALLOC_ARRAY(list, from->nr);
>>>   	for (i = 0; i < from->nr; i++) {
>>> -		struct object *from_one = from->objects[i].item;
>>> +		list[i] = (struct commit *)from->objects[i].item;
>> Some of the objects in my array are not commits, but rather tags, so
>> this is a bogus cast.
>>
>> You can see that the original code peeled them and threw away
>> non-commits:
>>
>>>   
>>> -		if (from_one->flags & assign_flag)
>>> -			continue;
>>> -		from_one = deref_tag(the_repository, from_one, "a from object", 0);
>>> -		if (!from_one || from_one->type != OBJ_COMMIT) {
>>> -			/* no way to tell if this is reachable by
>>> -			 * looking at the ancestry chain alone, so
>>> -			 * leave a note to ourselves not to worry about
>>> -			 * this object anymore.
>>> -			 */
>>> -			from->objects[i].item->flags |= assign_flag;
>>> -			continue;
>>> -		}
>> So presumably we'd need to do something similar.
> This patch seems to fix it for me. It's more or less a reversion of the
> hunk above, though I didn't dig into whether I'm violating some other
> assumption in your new code.
>
> I think this function leaks "list" both from the location I noted here,
> as well as from normal exit
Thanks for the report and the fix. I'll try to create  test that 
demonstrates this and then push up a full patch.
> ---
>   commit-reach.c | 25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/commit-reach.c b/commit-reach.c
> index 622eeb313d..abe90a2f55 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -547,20 +547,31 @@ int can_all_from_reach_with_flag(struct object_array *from,
>   {
>   	struct commit **list = NULL;
>   	int i;
> +	int nr_commits;
>   	int result = 1;
>   
>   	ALLOC_ARRAY(list, from->nr);
> +	nr_commits = 0;
>   	for (i = 0; i < from->nr; i++) {
> -		list[i] = (struct commit *)from->objects[i].item;
> +		struct object *from_one = from->objects[i].item;
>   
> -		if (parse_commit(list[i]) ||
> -		    list[i]->generation < min_generation)
> -			return 0;
> +		from_one = deref_tag(the_repository, from_one,
> +				     "a from object", 0);
> +		if (!from_one || from_one->type != OBJ_COMMIT) {
> +			from->objects[i].item->flags |= assign_flag;
> +			continue;
> +		}
> +
> +		list[nr_commits] = (struct commit *)from_one;
> +		if (parse_commit(list[nr_commits]) ||
> +		    list[nr_commits]->generation < min_generation)
> +			return 0; /* is this a leak? */
> +		nr_commits++;
>   	}
>   
> -	QSORT(list, from->nr, compare_commits_by_gen);
> +	QSORT(list, nr_commits, compare_commits_by_gen);
>   
> -	for (i = 0; i < from->nr; i++) {
> +	for (i = 0; i < nr_commits; i++) {
>   		/* DFS from list[i] */
>   		struct commit_list *stack = NULL;
>   
> @@ -603,7 +614,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>   	}
>   
>   cleanup:
> -	for (i = 0; i < from->nr; i++) {
> +	for (i = 0; i < nr_commits; i++) {
>   		clear_commit_marks(list[i], RESULT);
>   		clear_commit_marks(list[i], assign_flag);
>   	}

