Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9131F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeFVBB2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:01:28 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39589 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933365AbeFVBB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:01:27 -0400
Received: by mail-qt0-f193.google.com with SMTP id p23-v6so4635022qtn.6
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OmgeNBIbHwhJtDgoituEmAI5eyC5nOQWM6VWzDHqvbU=;
        b=W3JCX0I+w/FMMMBqXc0LJLvO31n6d1Dkzb2VrJ0aum1JDmwbXgrlcmkOUkN1OqKLBz
         sF17IH+2IOIDCvPO6gmocCNBZeAx/zxS8ItyMqoBY1S/GiWLhPuiR5DwUQch3Op6K42y
         +MCkgYW3VKrKmnUy4m2wid35DLovLA6iYjXTe6+g3FqTdBygGsLE4evYbKwmY3DMnbvm
         fVzCnS/xUJOpQaH5nStbDJeJ4GFkPzcPDs/uTgzH4uczFrxP4eTXyXpkdeO8+cJJQcsi
         /IsZ6U8R/lJrjDjlTlfEENW7zj9vFF6BxFvPH0PFW6X9ev77kWwxIS9Gk9SJm8m0wfDd
         IJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OmgeNBIbHwhJtDgoituEmAI5eyC5nOQWM6VWzDHqvbU=;
        b=IRxKFrZUCknVQni+7q/hyur0d29Aewqy70hV8YG40XvQy+XU+gi3PQuzPrtb0FLsE5
         j6ba6L2AlKOHRloFVC4T0NP34Wllja5iKerTGM0ftfyep/PJE4b5Rp3afo6jdu4A2qit
         c1q181MmshcDFKDYQD8ZMbWS92sw5Pd8/hNQMTAY3rhpYy0gI4SeNmbDWyK1C6qXmMSF
         h51WAU5MHvP9HxOlP24Og5h9u5Kqr3UoP4PD4JnulXm8967BZVAiD8v8UuSIqwa0/gJI
         KlkVrNR+iHTcQoxAUoaIZCWNBuSZpI/TjLgRe89sr04+bmBAaM3CnMn6m/Te45d5HXVw
         3Bdw==
X-Gm-Message-State: APt69E06UXV2NQRBlEQ9WqvoLLhZQKyag95CSSawCtj6L3gyi8QYNmRf
        5jV/tk57nYjKOGSfeRbPBA5QWFDP
X-Google-Smtp-Source: ADUXVKIHES1t0RjlN9QY80bLaeeYLJQ+VwCDQ4zSzCVfBt/fE2j1+GAQgaIfF1jeVqQJzpI8MUq5RA==
X-Received: by 2002:a0c:d7c6:: with SMTP id g6-v6mr24793175qvj.85.1529629286411;
        Thu, 21 Jun 2018 18:01:26 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id y15-v6sm4370371qky.11.2018.06.21.18.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 18:01:25 -0700 (PDT)
Subject: Re: [PATCH 5/5] commit-graph: add repo arg to graph readers
From:   Derrick Stolee <stolee@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Cc:     git@vger.kernel.org
References: <CAGZ79kYYD48PQiSqjqHkrqX9stKbGmEAHc1ArsuUgSHhwv5=Vw@mail.gmail.com>
 <20180621230608.86117-1-jonathantanmy@google.com>
 <d7a42ecf-7261-ec14-5736-b1f9bc70ba64@gmail.com>
Message-ID: <e01ee415-2623-6aed-f003-dfe68b4e32eb@gmail.com>
Date:   Thu, 21 Jun 2018 21:01:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d7a42ecf-7261-ec14-5736-b1f9bc70ba64@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2018 8:33 PM, Derrick Stolee wrote:
> On 6/21/2018 7:06 PM, Jonathan Tan wrote:
>>>> diff --git a/commit.c b/commit.c
>>>> index 0030e79940..38c12b002f 100644
>>>> --- a/commit.c
>>>> +++ b/commit.c
>>>> @@ -317,7 +317,7 @@ struct tree *get_commit_tree(const struct 
>>>> commit *commit)
>>>>          if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
>>>>                  BUG("commit has NULL tree, but was not loaded from 
>>>> commit-graph");
>>>>
>>>> -       return get_commit_tree_in_graph(commit);
>>>> +       return get_commit_tree_in_graph(the_repository, commit);
>>> Here..
>>>
>>>>   }
>>>>
>>>>   struct object_id *get_commit_tree_oid(const struct commit *commit)
>>>> @@ -413,7 +413,7 @@ int parse_commit_gently(struct commit *item, 
>>>> int quiet_on_missing)
>>>>                  return -1;
>>>>          if (item->object.parsed)
>>>>                  return 0;
>>>> -       if (parse_commit_in_graph(item))
>>>> +       if (parse_commit_in_graph(the_repository, item))
>>> and here
>>>
>>>> +static void test_parse_commit_in_graph(const char *gitdir, const 
>>>> char *worktree,
>>>> +                                      const struct object_id 
>>>> *commit_oid)
>>>> +{
>>>> +       struct repository r;
>>>> +       struct commit *c;
>>>> +       struct commit_list *parent;
>>>> +
>>>> +       /*
>>>> +        * Create a commit independent of any repository.
>>>> +        */
>>>> +       c = lookup_commit(commit_oid);
>>> .. and this one are unfortunate as the rest of the object store series
>>> has not progressed as far as needed.
>> I think the first 2 are in reverse - get_commit_tree depends on
>> get_commit_tree_in_graph and parse_commit_gently depends on
>> parse_commit_in_graph, so we need the commit-graph functions to be
>> changed first. But I agree about lookup_commit.
>>
>>> The lookup_commit series is out there already, and that will
>>> teach lookup_commit a repository argument. When rerolling
>>> that series I need to switch the order of repo_init and lookup_commit
>>> such that we can pass the repo to the lookup.
>> For future reference, Stefan is talking about this series:
>> https://public-inbox.org/git/20180613230522.55335-1-sbeller@google.com/
>>
>> Let me know if you want to reroll yours on top of mine, or vice versa. I
>> think it's clearer if mine goes in first, though, since (as you said in
>> that e-mail) parse_commit depends on this change in the commit graph.
>
> I was about to comment that I thought 'parse_commit_in_graph' should 
> take a 'struct commit_graph' instead of 'struct repository', except 
> for these lookup_commit() calls will need the repository parameter.
>
> Please also keep in mind that ds/commit-graph-fsck has already updated 
> this method to parse from a specific graph [1]. I'm just waiting for 
> some things like ds/generation-numbers to get into 'master' and some 
> more object-store patches to be final before I re-roll that series. I 
> mentioned this in a message that I had sent, but apparently didn't 
> make it on the list (so I re-sent it recently).
>
> [1] 
> https://public-inbox.org/git/20180608135548.216405-4-dstolee@microsoft.com/

Here is the re-send: 
https://public-inbox.org/git/4e7600f1-6dd0-3b21-5f5d-26af2b3c0b1a@gmail.com/T/#t

