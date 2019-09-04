Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32D01F461
	for <e@80x24.org>; Wed,  4 Sep 2019 01:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIDBhK (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 21:37:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35913 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDBhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 21:37:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id x64so3553336ywg.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 18:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=33syZzecJsFphTIx5raeKp0HnXM6iLhw8vO2DEZEcbk=;
        b=ncDH1MpWMapXBK91+FqUM7e1RoHHvfC/6GhVgwQfg6i1ZQUXJGrg+Dm0oE/tFXRR69
         ppYtlG+HvxodmODqwK81oZY7+/ZN/TRKr9UgPW0sccNg1jHy6FAruJfqwiuqTAfUCurV
         /rf2eNwRJg/cmCsz1ZsDRA0u7jnV6Vuk5nMsv+EAGDKTGa5MlDeXo3Q0cTnW8cfBQDcQ
         5oe1JYFCZTDgaShUTa907Q7/S8YeDkB0l0jI3XPVVV/6X+Hkt0pFssMHtX8qy1LmkMC1
         NCQ+MHJZwfGto6EawkhaRewKWdkMnU46tUw05LsVlJllppY8OYmRkFelkwsGhqkD2k/j
         dBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=33syZzecJsFphTIx5raeKp0HnXM6iLhw8vO2DEZEcbk=;
        b=Y4o/l2xhzYrp4q0TwLDknq0QvvRjH9y8hKip3v0n+lasdrIJyNLntTxAFhBAOsjae2
         fwU0q70VSBLj2ER/CYNXnlAu+Ua/5+Vy1elDOD7GJdWtifGCRaMfALysTOUfY1ehW5aN
         n2ppiwuEbjgG6hdTO9mN097canK1qlrlERgzx8TJ2rO05OYre42Aljbjqyjyztx5V9k8
         TBXOIrdTwgxTJV22LjqzZ3HD8PIelQkwOt7UhL1Abhr7KyV+lOC4kv8fpYFNmSTPlfn2
         NDHz6VH4kBlnT9qkUh3hBtwmlGzb5qja3cXUvky+DiPg7UcFwjnEgqkSKnKySdRjRZd/
         kcRQ==
X-Gm-Message-State: APjAAAWn/fg71qJ+nEGImLXsdlfUSidgWptDB5EUYUlBE0Weo7T14IsA
        8S5fHMBqRrF2iNdVgumctiecLy/a/yM=
X-Google-Smtp-Source: APXvYqwxmF07EzeaYB8h3txgVqPNti3wire2wldpkJJHqQOrghgIjdl8ReFo3F8KXFzBjEXDW7BHyg==
X-Received: by 2002:a81:5883:: with SMTP id m125mr2649102ywb.64.1567561028842;
        Tue, 03 Sep 2019 18:37:08 -0700 (PDT)
Received: from [192.168.1.25] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l77sm3874341ywb.32.2019.09.03.18.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 18:37:08 -0700 (PDT)
Subject: Re: [PATCH] cache-tree: do not lazy-fetch merge tree
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190903194247.217964-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <69f2b069-3e11-4a2e-9b81-bde18c463d8c@gmail.com>
Date:   Tue, 3 Sep 2019 21:37:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190903194247.217964-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2019 3:42 PM, Jonathan Tan wrote:
> When cherry-picking (for example), new trees may be constructed. During
> this process, Git checks whether these trees exist. However, in a
> partial clone, this causes a lazy fetch to occur, which is both
> unnecessary (because Git has already constructed this tree as part of
> the cherry-picking process) and likely to fail (because the remote
> probably doesn't have this tree).

If we have constructed the object already, then why do we not see it
and avoid fetching it? This must be a slightly strange timing issue
with objects being flushed to disk or added to the object cache.

One approach is to find all of these has_object_file() calls that should
really be one with OBJECT_INFO_SKIP_FETCH_OBJECT. Another would be to
find out why has_object_file() isn't seeing the object we constructed.

> Do not lazy fetch in this situation.
I agree that the patch has this effect.
 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Another partial clone bug.
> 
> This raises the issue that failed fetches are currently fatal - if they
> weren't fatal, this cherry-pick would have worked (except with some
> delay as the fetch is attempted, and with a warning message about the
> fetch failing). My personal inclination right now is to leave things as
> it is (fatal failed fetches), but I'm open to other opinions.
> ---
>  cache-tree.c             |  2 +-
>  t/t0410-partial-clone.sh | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index c22161f987..9e596893bc 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -407,7 +407,7 @@ static int update_one(struct cache_tree *it,
>  	if (repair) {
>  		struct object_id oid;
>  		hash_object_file(buffer.buf, buffer.len, tree_type, &oid);
> -		if (has_object_file(&oid))
> +		if (has_object_file_with_flags(&oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
>  			oidcpy(&it->oid, &oid);
>  		else
>  			to_invalidate = 1;
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 6415063980..3e434b6a81 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -492,6 +492,20 @@ test_expect_success 'gc stops traversal when a missing but promised object is re
>  	! grep "$TREE_HASH" out
>  '
>  
> +test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
> +	rm -rf repo &&
> +	test_create_repo repo &&
> +	test_commit -C repo base &&
> +	test_commit -C repo side1 &&
> +	git -C repo checkout base &&
> +	test_commit -C repo side2 &&
> +
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.partialclone "arbitrary string" &&
> +
> +	git -C repo cherry-pick side1
> +'
> +

I appreciate this test!

Thanks,
-Stolee
