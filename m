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
	by dcvr.yhbt.net (Postfix) with ESMTP id 820FF1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 12:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfIYMm6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:42:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43093 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfIYMm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:42:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so6314255qtv.10
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ysAi48GU6ZPpdVJ3oAMClqoVrRRZtBXQmCmCFFe2za0=;
        b=Am+lFcHcB1RH0lgjWjlCUrDSLlmZ1UzbjmZ7b46dO0vrx4jiiYYT909yTn61KyYYyB
         6j5OuBHpzDfS80IUsTbt3VkZcUJWPdtPrDGWg6y6Og/ZtFMV8o23/GyMarlvYBAR/s3X
         J7ubjMeF8wiDU+lL41fTW2GFspI98ZxCHfFO7hLfDKwZOH/nxxq+dGZlD8Nt62IlCGh+
         dr6NMZ8A2PLv6onIsFAuArVZO8mZQKVrZqzmG2jNd6fSBxmv6k/ips8CdMCL9YZRqnlG
         ipJtld+lqnKUdSZDexPwzlOcYh8TN3wNvwo3RC5mBN5QJE+yf/2VJsiUdKs42b6udyl8
         caPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ysAi48GU6ZPpdVJ3oAMClqoVrRRZtBXQmCmCFFe2za0=;
        b=opke3rH/KXwnrdE++dRsfbXJuxAIK5tUQl79Jf2iJsxqW9SNjj5tzXBQkJsDpSgP9j
         dhkqyEbiLUCJ1irn1HxnOlP91fZwuowcUj/O5qBwZ2Fkclc9sHa5eWzqaTrKP7+baMVj
         Vbr237rAuggb3y2WCxP8ibAzTCfTazRvPdU7fl4iPj61UiXvDzbD/CbgCPPe36TASdxE
         MVr8inmrLbcPR+9+iE74JPd8hgVH8ISG+i2FbJLEUhTZkBGC5WEVodK48YH6n7i3Lki5
         NKRponL8orQmkczdLkX7odGXNzGDq/3iPvONKSXFSBUBmRBQF87tbw0q2kZm3WrZkBRx
         HkFA==
X-Gm-Message-State: APjAAAWaJuAh+UjXDOuS39DeyT3erNlDctVSrYIeWvMwQxFjejCmZARz
        KEVozHl/7k74l/Xzyu03U+GK/Enr5xg=
X-Google-Smtp-Source: APXvYqx+yTI3LYElkXPOA3xgw0+NAsPwZsEZ4xwFoaBVjuvKO7SwbhrmBEChKFsHErKAytu8WXux+w==
X-Received: by 2002:ac8:111a:: with SMTP id c26mr8046135qtj.321.1569415376057;
        Wed, 25 Sep 2019 05:42:56 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1012:fdf4:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id z13sm2592466qkj.34.2019.09.25.05.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:42:55 -0700 (PDT)
Subject: Re: [PATCH v2 19/19] hashmap: remove type arg from
 hashmap_{get,put,remove}_entry
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-20-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <20c83a67-09c4-5c88-e937-7307541e4bf5@gmail.com>
Date:   Wed, 25 Sep 2019 08:42:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-20-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> Since these macros already take a `keyvar' pointer of a known type,
> we can rely on OFFSETOF_VAR to get the correct offset without
> relying on non-portable `__typeof__' and `offsetof'.
> 
> Argument order is also rearranged, so `keyvar' and `member' are
> sequential as they are used as: `keyvar->member'
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  attr.c                  |  2 +-
>  blame.c                 | 10 ++++-----
>  builtin/difftool.c      |  2 +-
>  builtin/fast-export.c   |  2 +-
>  config.c                |  3 +--
>  diff.c                  |  6 ++----
>  hashmap.c               |  2 +-
>  hashmap.h               | 45 ++++++++++++++++++++++++++++++-----------
>  merge-recursive.c       |  6 ++----
>  name-hash.c             |  3 +--
>  patch-ids.c             |  3 +--
>  range-diff.c            |  4 +---
>  remote.c                |  3 +--
>  revision.c              |  3 +--
>  sub-process.c           |  3 +--
>  submodule-config.c      | 10 +++------
>  t/helper/test-hashmap.c |  4 +---
>  17 files changed, 56 insertions(+), 55 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 9849106627..15f0efdf60 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -103,7 +103,7 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
>  	hashmap_entry_init(&k.ent, memhash(key, keylen));
>  	k.key = key;
>  	k.keylen = keylen;
> -	e = hashmap_get_entry(&map->map, &k, NULL, struct attr_hash_entry, ent);
> +	e = hashmap_get_entry(&map->map, &k, ent, NULL);
>  
>  	return e ? e->value : NULL;
>  }
> diff --git a/blame.c b/blame.c
> index 90b247abf9..6384f48133 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -419,8 +419,8 @@ static void get_fingerprint(struct fingerprint *result,
>  			continue;
>  		hashmap_entry_init(&entry->entry, hash);
>  
> -		found_entry = hashmap_get_entry(&result->map, entry, NULL,
> -					struct fingerprint_entry, entry);
> +		found_entry = hashmap_get_entry(&result->map, entry,
> +						/* member name */ entry, NULL);

In case I forget to point this out during the rest of my review: this
use of "/* member name */" to distinguish between the two "entry"
strings is very helpful for review. Likely, it will help future code
authors.

I looked at PATCHes 18 & 19 to see the end-result before going through
the rest. These are nice mechanical changes that present a cleaner API.
A worthy goal.

Thanks,
-Stolee
