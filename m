Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD761F517
	for <e@80x24.org>; Thu, 14 Jun 2018 19:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755070AbeFNTdg (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:33:36 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:43021 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754780AbeFNTdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:33:35 -0400
Received: by mail-pf0-f179.google.com with SMTP id y8-v6so3712415pfm.10
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2aFBYNE8myS5B/Orvz0khQOl9PSH/q4f/cYmgEnPuVU=;
        b=tlQsiYALV4EJsl7poGvvDN6ES9pHANROWcjVDTFAA9EzrF2qPUnN8yCOPt9gtWzs95
         sZHnlhN29a5mcf33OJXR9p2IQoMvjytDIz829tnIhRh7fzR7D+RRdg21lvFBaKHwn4tm
         Sy981FETVdXYrXFfEqQK7NYdozQ8iZNAAv61ka37uKdVtodpAzu2cM1793QY3jUl9DMy
         5AZIx0USkuWdzuspe2sWejFXb9ppOXYKIcUNWGkBxNAo8jnKslDunCWh87kTU2C0iX5E
         ZTSozM1TUGIujfckT2jY8sQfyVLjHtUS5KYcA0hAKidcpDN+s/9TZzy1Rgv0BK3pCrzf
         wz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2aFBYNE8myS5B/Orvz0khQOl9PSH/q4f/cYmgEnPuVU=;
        b=cOr/bN08i8enAKZF9WL+RT6TBcwJ5rn4X1Oh7mtkiFMXlqc+i8yOzfegdNECeAnoFB
         aq+eVG1ny/lVlQETdYMdg+H9lKI/ho5sD4Uao4ewXLTFULD/p3X9RkypPVlNA/zl66SY
         Y9+qdeDqnLOs0srbbLefqNXnFAOa59OeBUvxYP2VpUtbAJS7UZ5+bwDMMvHZZmnTo2fZ
         9VjogBhCAeT3ttglf/TVsHVoGnieg5lAWLcx/Qujs1zmZdv2fu1LPrp+/M+M9QKB44Ed
         YJo96TXJ9Hy4EddqrZAPsKeGMfNsb70VYdFV38TyLEmQK2DC1KriF3ggyf9ZV+iG5FoV
         PfNg==
X-Gm-Message-State: APt69E1AUpFF7yhi15LrFdrL9kLgZ9ublRzK2nGXSVxm+f967SUZT+tc
        cT4HV3zHN8MmDo322M/muDE=
X-Google-Smtp-Source: ADUXVKIrY5wxusPnXIhZKQLI+00jpO27A/z3E/8wjctjClCwUQK2IsN3T9JWlSjVZYQy+1I7+yIt5A==
X-Received: by 2002:a62:3dca:: with SMTP id x71-v6mr10816753pfj.134.1529004814427;
        Thu, 14 Jun 2018 12:33:34 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:936:68f2:e294:88e9? ([2001:4898:e008:1:9272:68f2:e294:88e9])
        by smtp.gmail.com with ESMTPSA id 63-v6sm831052pfo.1.2018.06.14.12.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:33:33 -0700 (PDT)
Subject: Re: [PATCH v2 05/31] tree: add repository argument to lookup_tree
From:   Derrick Stolee <stolee@gmail.com>
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180613230522.55335-1-sbeller@google.com>
 <20180613230522.55335-6-sbeller@google.com>
 <fcb052e0-2308-31bd-aa90-d6d3327642c0@gmail.com>
Message-ID: <709bd61c-70fc-a925-efba-58ab9be265c9@gmail.com>
Date:   Thu, 14 Jun 2018 15:33:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fcb052e0-2308-31bd-aa90-d6d3327642c0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2018 1:55 PM, Derrick Stolee wrote:
> On 6/13/2018 7:04 PM, Stefan Beller wrote:
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 71125d7cbb6..88a4b0d2a47 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -261,7 +261,7 @@ static int fill_commit_in_graph(struct commit 
>> *item, struct commit_graph *g, uin
>>       item->graph_pos = pos;
>>         hashcpy(oid.hash, commit_data);
>> -    item->tree = lookup_tree(&oid);
>> +    item->tree = lookup_tree(the_repository, &oid);
>>         date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
>>       date_low = get_be32(commit_data + g->hash_len + 12);
>> diff --git a/commit.c b/commit.c
>> index d76d64d4dfc..755b8b9d94f 100644
>> --- a/commit.c
>> +++ b/commit.c
>> @@ -354,7 +354,7 @@ int parse_commit_buffer(struct commit *item, 
>> const void *buffer, unsigned long s
>>       if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
>>           return error("bad tree pointer in commit %s",
>>                    oid_to_hex(&item->object.oid));
>> -    item->tree = lookup_tree(&parent);
>> +    item->tree = lookup_tree(the_repository, &parent);
>>       bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
>>       pptr = &item->parents;
>>   diff --git a/fsck.c b/fsck.c
>> index 2d372f2a3f3..b07abb9796c 100644
>
> I'm a bit late here, but you don't have ds/lazy-load-trees merged in 
> your history, so this will conflict with 'master'. I caught this as I 
> was trying to merge ds/generation-numbers with your branch.
>
> The 'tree' member of 'struct commit' was renamed to 'maybe_tree'.

Resolving the merge was not very simple. I have a working merge 
available on GitHub [1] as commit 99a899f7c12ef73840dbe79c71acb11034d707dd.

Thanks,
-Stolee

[1] 
https://github.com/derrickstolee/git/commits/generation-numbers-object-store
