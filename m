Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6330CC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 15:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjEKPAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbjEKPAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 11:00:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EE7E66
        for <git@vger.kernel.org>; Thu, 11 May 2023 08:00:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba1815e12efso7476133276.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683817219; x=1686409219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQVDOr0pyWcOb9Mkn8hfPcjKUOGDBuENcgeUXfuqnUc=;
        b=DvhtAcoi5kVJsW4aU1IGhoBbd1agGKQ3HKxLjlaeZOXlyhMUyLCtctq4aQQgcZANF5
         lg5uryXQhCPLRsqIsg4NLBPFx/hTL5bqxp6aIakBZzuF5sco6r+jsvoyrhIGMQgICi4N
         97o/BRUUMwDD/dxLT0qmyGy5jXi6S2jbLK3RXaza3lQIj4gpDrMQ1PKdNBREsF0P4Uim
         7mF2g6lIJ6Oz6CUL0TuxSC45RWUQZETvM2wQpYLGN3YvzfiHhjP+s0PMUtHP87/T9tar
         8z3LT8z3StPtLN3P/SKjYpLLDD4sj36joDvh2WuYE+vbp94xPNL1uJL4T5ME5K4Iez1l
         oQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817219; x=1686409219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQVDOr0pyWcOb9Mkn8hfPcjKUOGDBuENcgeUXfuqnUc=;
        b=dGCchsyK257NaNZ8skXgO2pJMNzxNKBoO7BZWQDqA/rPwHs828FUJ04+uUcUcVt26u
         2cZqWXTJ/NOhQwDYN3HzsJHXRvf0i8hJwLGz3MDu1FcHyMg9zQtfcZJPkyH+eaDi8YZi
         aC2sc7H1ZrEf0ZMY0MZUCMYD99o3k2fdJlBX/0KtNAdsGaMlCgqUTEouGO8qJZaV6aRM
         gTtdKfgSJ5fPQusYKO7pCseMt6C25IVxaH5rLUbAK6+hvLFNGgtX0fM9gqUZ5JEJWFw2
         XKo2AXHn5iA7/cCF+oOfN4+AbefPTuhBvPAHCEG4S68qCZsJabTqmXO0gr09k6nEerBT
         avhQ==
X-Gm-Message-State: AC+VfDy/riak/9YhqkiaToq5gM+G0V2EGq4LYAHokKHFBYxkbMWsC79L
        Jse/O25alsLIAg2EBVhc7ZtC
X-Google-Smtp-Source: ACHHUZ6Zdc+M5fEeEh2NqC9a6Pr1O4IaJNvSovaN45z6gcy2k9QYprLS3ATJ2u1/XmjK8ABiIhJWLg==
X-Received: by 2002:a81:8347:0:b0:55c:253b:91dc with SMTP id t68-20020a818347000000b0055c253b91dcmr21971481ywf.34.1683817218748;
        Thu, 11 May 2023 08:00:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:c583:6563:bc4f:3e20? ([2600:1700:e72:80a0:c583:6563:bc4f:3e20])
        by smtp.gmail.com with ESMTPSA id f206-20020a816ad7000000b00559fb950d9fsm4974206ywc.45.2023.05.11.08.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 08:00:18 -0700 (PDT)
Message-ID: <2ce5dd62-3b76-c14f-35e2-5cb2ccda42a1@github.com>
Date:   Thu, 11 May 2023 11:00:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] merge-tree: load default git config
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        christian.couder@gmail.com
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
 <CABPp-BECZgACeEUqG3pajJpHAaY=-orNwwOUEX5qqzAKVRMFdQ@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BECZgACeEUqG3pajJpHAaY=-orNwwOUEX5qqzAKVRMFdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/11/2023 2:34 AM, Elijah Newren wrote:
> On Wed, May 10, 2023 at 12:33 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The 'git merge-tree' command handles creating root trees for merges
>> without using the worktree. This is a critical operation in many Git
>> hosts, as they typically store bare repositories.
>>
>> This builtin does not load the default Git config, which can have
>> several important ramifications.
>>
>> In particular, one config that is loaded by default is
>> core.useReplaceRefs. This is typically disabled in Git hosts due to
>> the ability to spoof commits in strange ways.

>> +       git_config(git_default_config, NULL);
>> +
> 
> Always nice when it's a simple fix.  :-)
> 
> I am curious though...
> 
> init_merge_options() in merge-recursive.c (which is also used by
> merge-ort) calls merge_recursive_config().  merge_recursive_config()
> does a bunch of config parsing, regardless of whatever config parsing
> is done beforehand by the caller of init_merge_options().  This makes
> me wonder if the config which handles replace refs should be included
> in merge_recursive_config() as well.  Doing so would have the added
> benefit of making sure all the builtins calling the merge logic behave
> similarly.  And if we copy/move the replace-refs-handling config
> logic, does that replace the fix in this patch, or just supplement it?
> 
> To be honest, I've mostly ignored the config side of things while
> working on the merge machinery, so I didn't even know (or at least
> remember) the above details until I went digging just now.  I don't
> know if the way init_merge_options()/merge_recursive_config() is how
> we should do things, or just vestiges of how it's evolved from 15
> years ago.
...
> Looks good.  I am curious for other's thoughts on whether it may make
> sense to add parsing of core.useReplaceRefs within
> merge_recursive_config().

In terms of a "real" fix to this kind of problem, I'm thinking that
we actually need to be sure we've parsed things like core.useReplaceRefs
when loading the object database for the first time.

Here, I'm suggesting the simplest fix before we can go about a more
rigorous change to prevent this from happening again.

The custom ahead-behind builtin that we have in our fork once also had
this same problem, and the fix was exactly like this. The impact was
less severe (mostly, things slowed down because the commit-graph was
disabled, but also the numbers could be different from expected).

Thanks,
-Stolee
