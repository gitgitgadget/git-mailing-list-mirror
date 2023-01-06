Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA3C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 15:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjAFPdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 10:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjAFPdN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 10:33:13 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273673E0B
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 07:33:12 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 16so2287436ybc.0
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyYfbe+ODOrvbJAE5TOlnhFJNNfc+2SqJSqLvivQw+Y=;
        b=J9ZOUQkZNGCtcpiwBdXzz69WIxl+SzYuiR+pFnVw4BF6y3ZsR0l51PasRWNRMNzuFH
         RcZlCJbe4L/2795l7NSDO4qfRDtIvmIhQ+KvTV3vGDcClIVk6CvIPR67PpZ+bEPX1/hU
         fLvH9qCJo4eUMuGmMDLJ20Oc+LVPzr470bkumjCPvX5O1QHjpLCj8jrXIQI48Wwz7jfP
         gPhUzu3NKTjqXjbSIipEylid/N2PMyfSerjCa39uOoBxK56aRoEKG0Ma22EuGDpMH+s9
         PhL7WVdIxi0ZlxJUZwQnpHhIsKHM9SuWOW/WFyIty7Z1MhE7LVVizSyEaFYBRqDKnQlE
         U8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyYfbe+ODOrvbJAE5TOlnhFJNNfc+2SqJSqLvivQw+Y=;
        b=kTdZonsj3irQXrngPeuLHVvytof96mRAr9IxH4reQTJPiZh9gpbgyJyxSva5MANkcd
         eoH+DLIoXesXNUO7hYwon9FF2mSIO1LRglzeLVxnLarvIKwBx/LIrimTYr/0PCGSOSml
         BTLxVjEKT+Jm7yhf1zw7ierwh9sI6EOpMup0V/nwlesuzA1lSLQl14fXvVpPiosyDj4A
         te48FG2JiQby33tY2Tvaus6eLcd3JiT8fWkf8iJ+cEckH2a9t/QDJmfOCxkgEh/00YBy
         Sa0Wu1RgWIBMSKNNcYwFo+w4FvOCrBRL3OtLtuSWOMbKglJvDbpF/IFo/qVVFG4EzgZH
         oaeQ==
X-Gm-Message-State: AFqh2kpto2IjWKgQ1ZPBLDGPIv5vzTPyJbPXVDqRfQYNz7kNqi3En1vb
        7ZK0ZGsIRVzRST+TtsQTO4vN
X-Google-Smtp-Source: AMrXdXtjMgf+w5mCV1Ic1SYsM2ZSTbtIbq9bBXt4sQBthyqMkEX682n5690x+qZHtRZlH1i4DA2Yxg==
X-Received: by 2002:a25:d00d:0:b0:7b0:beea:1a7f with SMTP id h13-20020a25d00d000000b007b0beea1a7fmr10379720ybg.17.1673019191434;
        Fri, 06 Jan 2023 07:33:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:715c:222d:8069:3fe7? ([2600:1700:e72:80a0:715c:222d:8069:3fe7])
        by smtp.gmail.com with ESMTPSA id q14-20020a37f70e000000b006ec62032d3dsm672497qkj.30.2023.01.06.07.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 07:33:10 -0800 (PST)
Message-ID: <b2164be2-72e9-cee5-26db-3e4fbfec3051@github.com>
Date:   Fri, 6 Jan 2023 10:33:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/4] Optionally skip hashing index on write
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
 <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
 <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/16/2022 10:43 AM, Ævar Arnfjörð Bjarmason wrote:

> But as it is split up the individual steps should make sense. The 2/4
> here should really just use "bool", not "maybe_bool" to begin with, no?
 
> And part of this in 4/4 is inheriting a non-stricture in
> repo-settings.c, but for this new config variable that we're introducing
> as only a boolean from day one can't we just die() on anything that's
> not a boolean?
> 
> On other implied feedback, in
> https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.com/
> I noted the switching between istate->repo & the_repository, and that
> you could hit a BUG() (when uncommenting a line in my testing patch on
> top) if we didn't have istate->repo:
> 
> There was a commit message update for that:
> 
>>  2:  00738c81a12 ! 2:  aae047cbc9f read-cache: add index.skipHash config option
>>      @@ Commit message
>>       
>>           [1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201
>>       
>>      +    We load this config from the repository config given by istate->repo,
>>      +    with a fallback to the_repository if it is not set.
> 
> But I think that really sweeps a potential issue under the rug. What are
> these cases where we don't get istate->repo, are those expected? Is
> preferring istate->repo always known to be redundant now, and just done
> for good measure, or are there subtle cases (e.g. when reading
> submodules) where we pick the wrong repo's config?

After investigating some of the failures from creating a BUG() statement
when istate->repo is NULL I see several problems, and they are not related
to submodules for the most part.

The first issues I've found are due to code paths that operate on the_index
without actually initializing it with a do_read_index(), or otherwise
initialize an index using a memset() instead of a common initializer. This
looks to be a frequent enough problem that solving it would require a
significant effort. It's not a quick fix.

> In that context I'd really like to see some testing of submodules in the
> added tests, i.e. does this act as we'd like it to when you set the
> config as "true" in the parent, but "false" in the submodule, & the
> other way around? That's a case that should stress this "the_repository"
> v.s. "istate->repo".

I can add a test for this, though we do not do that for every new config
option. Further, we can only rely on commands like 'git add' that correctly
initialize the index from a do_read_index(). It should be sufficient to
use the index-local repository (when available) and trust that the
repo_config_...() method is doing the right thing.

> I really don't care per-se where we read the config, as long as it's
> doing what we expect from the UX point of view.
> 
> But in your
> https://lore.kernel.org/git/9e754af8-ecd3-6aed-60e8-2fc09a6a8759@github.com/
> you noted "There's no reason to load the config inside repo-settings.c
> unless it's part of something like feature.manyFiles.".
> 
> I think that's true, but on the flip side of that: Is there a reason to
> move the reading of such localized config (only needed in read-cache.c,
> as 2/4 shows) to repo-settings.c, just because it's now relying on the
> "manyfiles"?

Yes, because it makes it clear what options are part of these meta-config
keys. It is better to centralize the parsing instead of having several
different ad-hoc parsing strategies.

Thanks,
-Stolee
