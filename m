Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02EBC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 14:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjDXOou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXOom (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 10:44:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0259F5
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:44:41 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b95fb433f59so8083604276.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682347481; x=1684939481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gamvEDFKIBs9u8gZ3tdfcRuxfN3o5CwF5adg3qGZxfk=;
        b=GfegTgyLsDy7RVQV4lFDvVFZxXJEyiWE/PYjMX/IK3QZZWeMz0ColOMDrwqQ9KAow5
         +lkbkfkNns8LC2KlS896nRk7V3C8yAl1b6/vg/c4cSuPiqw3Hv03aWrUGXcdbLMLbtGd
         oWl6dnerU1R4d7BiffrXYmkBf3V3DDxqS73jm8hRaIsyiTl1V4zopX/sUoAbragkhb5N
         IyPklTslWlkeP3azKTrYmhjgDYSAysWFrgXWL2MkK8jDHkCq1R2FXyWvskuo0S5yN92h
         gyWiXbrKf2AfrYSZzJh/EkSBoFji4eFF1/IVe5CJNxOQUkIJgKJqhZCV8n0CK5L4VY3u
         gdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347481; x=1684939481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gamvEDFKIBs9u8gZ3tdfcRuxfN3o5CwF5adg3qGZxfk=;
        b=DwHQb1iVof2yRv9TDV8zSy7kQMKk8E9qvB/uTG4uYCetmclRDe+Y14/L18zVAYbIc0
         0aJylSfCvs8xkb5DPK6rDLxZangXI49w2bMsi+I3IW1IG2Ok/R7aO2ueDFd3V5nrdkfj
         fR78lwY/clMpQGDZg2DOeGO0QZwUd+IR3SEfjjTsOBgfZbed9tY5s+skqhmlQf1xOE38
         YwJisbTAFtrb+8EaLqtahZwG/avPkCXZaAAWTnR0tDUlAfuVEyi5ajyOa4ws1uCqRtv9
         2taCqldqOI2FdiK3TjpfR/N2BuuYdBnyH4AKyVivjvnt8G8/Dcq4MxKoaE8JUUGdqJQQ
         DsUA==
X-Gm-Message-State: AAQBX9dPUKdnyK0RvL1K/GAmR7uIh8JHb9FWFyxH/vAxc03svjqGG+gX
        kB5AbdqUf1Jli1HcHJUTWeNO
X-Google-Smtp-Source: AKy350Zii7s7bclLExXiConESF+LsNCs+ebxQJZIi+Add9H7NIa8ijfKmeR1Kn0dTdcBWYODX3vGBA==
X-Received: by 2002:a25:246:0:b0:a09:3c5a:c0d7 with SMTP id 67-20020a250246000000b00a093c5ac0d7mr9952376ybc.61.1682347480820;
        Mon, 24 Apr 2023 07:44:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4c:5bca:4632:1d72? ([2600:1700:e72:80a0:4c:5bca:4632:1d72])
        by smtp.gmail.com with ESMTPSA id 190-20020a250ac7000000b00b7767ca749esm2921970ybk.59.2023.04.24.07.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:44:40 -0700 (PDT)
Message-ID: <2bcaeba9-20bc-1ca8-849b-ac54342c71e3@github.com>
Date:   Mon, 24 Apr 2023 10:44:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] negotiator/default.c: avoid stack overflow
To:     Han Xin <hanxin.hx@bytedance.com>, git@vger.kernel.org
Cc:     xingxin.xx@bytedance.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230424022318.80469-1-hanxin.hx@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/23/2023 10:23 PM, Han Xin wrote:
> mark_common() in negotiator/default.c may overflow the stack due to
> recursive function calls. Avoid this by instead recursing using a
> heap-allocated data structure.

I'm really happy to see that since you could replace the if statement
with a while statement, most of the existing logic could stay without
a bunch of whitespace changes.
 
> This is the same case as [1].
> 
> 1. https://lore.kernel.org/git/20221025232934.1504445-1-jonathantanmy@google.com/

Thanks for the link, though this could be replaced with

  4654134976f (negotiator/skipping: avoid stack overflow, 2022-10-25)

now that the change exists in the commit history.

One thing that is missing from that change is a test, and such a test
could be generalized to apply to all negotiators. This could maybe
help any potential future negotiator avoid this bug. Did you think
about what such a test could look like? Perhaps test_commit_bulk
could help, but we'd probably need to create so many commits that the
test would need to be marked as expensive. That's probably a major
reason to not include a test and rely on avoiding recursion when
possible.

> -	if (commit != NULL && !(commit->object.flags & COMMON)) {
> +	struct prio_queue queue = { NULL };
> +
> +	prio_queue_put(&queue, commit);

Should we check the conditions what were removed? The COMMON flag
is likely only useful for the recursion, but prio_queue_put() is
not careful about NULL values. However, no callers should be
providing NULL commits here.

Couldn't hurt to add
	
	if (!commit)
		return;

before the prio_queue_put().

> +	while ((commit = prio_queue_get(&queue))) {
>  		struct object *o = (struct object *)commit;
>  
> +		if (commit == NULL || (commit->object.flags & COMMON))
> +			continue;

The NULL condition is definitely unnecessary here as it is checked
by the while condition. The "& COMMON" is helpful if the commit
gained the COMMON flag after being inserted into the queue.

>  		if (!ancestors_only)
>  			o->flags |= COMMON;
>  


> @@ -70,15 +76,17 @@ static void mark_common(struct negotiation_state *ns, struct commit *commit,
>  				ns->non_common_revs--;
>  			if (!o->parsed && !dont_parse)
>  				if (repo_parse_commit(the_repository, commit))
> -					return;
> +					continue;
>  
> +			ancestors_only = 0;

This caught me off guard, but this flag essentially says "should
I mark the first commit as common or not?". It would probably be
clearer if this was done before the loop, and then was ignored
within the loop, setting the flag on each parent in this loop:

>  			for (parents = commit->parents;
>  					parents;
>  					parents = parents->next)
> -				mark_common(ns, parents->item, 0,
> -					    dont_parse);
> +				prio_queue_put(&queue, parents->item);

It would have an extra benefit: your walk may duplicate objects in the
priority queue (there is no duplicate protection in prio_queue_put).
But, we could use

	if (!(parents->item->object.flags & COMMON)) {
		parents->item->object.flags |= COMMON;
		prio_queue_put(&queue, parents->item);
	}

as duplicate protection _and_ a clearer way to demonstrate what
ancestors_only is doing. Without this protection, it is possible
to have exponential growth in the priority queue using simple
merge commits.

You'd need this at the beginning:

	if (!commit)
		return;

	prio_queue_put(&queue, commit);
	if (!ancestors_only)
		commit->object.flags |= COMMON;
> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> index c7d6ab39bc..3d262b3533 100644
> --- a/negotiator/skipping.c
> +++ b/negotiator/skipping.c
> @@ -108,6 +108,8 @@ static void mark_common(struct data *data, struct commit *seen_commit)
>  				prio_queue_put(&queue, p->item);
>  		}
>  	}
> +
> +	clear_prio_queue(&queue);

This memory leak cleanup in the skipping negotiator is good to
do, but should be split into its own change.

In addition, the mark_common() method there seems to have a few
problems:

 1. It does not do duplicate protection before prio_queue_put().
    (The COMMON bit would work here, too.)
 2. When it translated from recursive to iterative it kept "return"
    statements that should probably be "continue" statements.
 3. It does not attempt to parse commits, and instead returns
    immediately when finding an unparsed commit. This is something
    that it did in its original version, so maybe it is by design,
    but it doesn't match the doc comment for the method.

Consider fixing these issues while you are here.

Thanks,
-Stolee
