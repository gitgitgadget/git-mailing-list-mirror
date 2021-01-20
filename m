Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E2EC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 845A5233EB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbhATTSI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392312AbhATTRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:17:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3462C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:16:53 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a109so24477463otc.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1UoMrKDBJZkolYtBaWSNd4OCvEp8T8FLU50QSUx+AT8=;
        b=rfABBac1dlW0hS7hu0ei11pMAqShj6eCIlixN67WNfMgUVCFNLeqiPPqbkvOuzwpx1
         nqV1eB04FdBaiu+lPvIMVhz0yOOM0Z3PI4UWO1XOKBVW/gpCmfh2/w9llDg7Pmt//ZiM
         r3Xazc/GVPfkI4k/xgMLnJKLaq6SXd8cKHRaXFgKds/hnlMPFqB8UA7/cxceThfuL3na
         sDZmlh3C/IJnZA2C0uTwHsuAXGMCphT596pPhE9CBGvxuIReCyNTEcpBGFfmW1WPhf4N
         GIG1K7zfnwNMigDttmk0W/ykjCMX03tjvstAvLZausgXOcrtIskPPYDwiNClYkBOrwQr
         L5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1UoMrKDBJZkolYtBaWSNd4OCvEp8T8FLU50QSUx+AT8=;
        b=so+MV2dIuTXR2304B0JUraGo0aYN2dCRPx2dgwuXJ1Pxzh3IMvoyJZN0HoOCsVItu6
         rehIv0wK0HhS2zQgLnecWi9GyMTVyNpS4zq+JOvZ+MpPr1Q2vZTKXapR09Ck7Kqy7eis
         CFwREdT65YjPEleuooxkxaxbhIRIeT4bhhwRN+QM/Wf5+mfYPKVmDXCR4qcEr8ty/O2g
         Jw1HDWd3DNHed1PnzcWV9ja/7kaqMCdNv8VG7pUcIfwKuI1vfEToTI+rTA2zpgV7C96+
         Sm9JRMOdXJPTaPNa6iu7AsjXtqR7Srt/4lsmaT+Dt212Ol0JYbm8W5PKTZShFywJYpjk
         dFcQ==
X-Gm-Message-State: AOAM5324Vz0YABMJeobrFx9w/2GLwP9t0nfl9uO9W95hXMuDrTU9b8NN
        sOc2qLy388pBoGCod6WeHsw=
X-Google-Smtp-Source: ABdhPJw2xWHrQtByjrzRqZGc/kMB1o0DjxKGWxzGY0w2U6lnYY8XCcZ/wzsbAozL8gbgtd4j5fGR+w==
X-Received: by 2002:a9d:7545:: with SMTP id b5mr7779364otl.239.1611170213211;
        Wed, 20 Jan 2021 11:16:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:710c:cecb:a7d:75ab? ([2600:1700:e72:80a0:710c:cecb:a7d:75ab])
        by smtp.gmail.com with UTF8SMTPSA id z3sm571850ota.80.2021.01.20.11.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:16:52 -0800 (PST)
Subject: Re: [PATCH 4/9] repository: add repo reference to index_state
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <d4ff0468fc0e22fe3ef82f74603ac781fd7711e1.1611161639.git.gitgitgadget@gmail.com>
 <CABPp-BGOVUDqDvTi0VOK7fD1EeFrhjCfZm241BqgA5_yMDH-VQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f790db9c-0c6d-3661-93d9-0339e22c12ff@gmail.com>
Date:   Wed, 20 Jan 2021 14:16:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGOVUDqDvTi0VOK7fD1EeFrhjCfZm241BqgA5_yMDH-VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/20/2021 12:46 PM, Elijah Newren wrote:
> On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> It will be helpful to add behavior to index opertations that might
> 
> s/opertations/operations/

Thanks.

>> trigger an object lookup. Since each index belongs to a specific
>> repository, add a 'repo' pointer to struct index_state that allows
>> access to this repository.
>>
>> This will prevent future changes from needing to pass an additional
>> 'struct repository *repo' parameter and instead rely only on the 'struct
>> index_state *istate' parameter.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  cache.h      | 1 +
>>  repository.c | 4 ++++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/cache.h b/cache.h
>> index 71097657489..f9c7a603841 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -328,6 +328,7 @@ struct index_state {
>>         struct ewah_bitmap *fsmonitor_dirty;
>>         struct mem_pool *ce_mem_pool;
>>         struct progress *progress;
>> +       struct repository *repo;
>>  };
>>
>>  /* Name hashing */
>> diff --git a/repository.c b/repository.c
>> index a4174ddb062..67a4c1da2d9 100644
>> --- a/repository.c
>> +++ b/repository.c
>> @@ -264,6 +264,10 @@ int repo_read_index(struct repository *repo)
>>         if (!repo->index)
>>                 repo->index = xcalloc(1, sizeof(*repo->index));
>>
>> +       /* Complete the double-reference */
>> +       if (!repo->index->repo)
>> +               repo->index->repo = repo;
>> +
>>         return read_index_from(repo->index, repo->index_file, repo->gitdir);
>>  }
>>
>> --
>> gitgitgadget
> 
> Since we have repo->index and we have index->repo, which are intended
> to be circular...what if they aren't?  Do we want or need to add
> assertions anywhere that repo == repo->index->repo or that index ==
> index->repo->index ?

Here, we are pairing them together and the loop is complete. I don't
view that as a permanent thing. This only initializes istate->repo
when we are parsing an index from a file, but not when we create one
in memory.

I imagine it will be likely in some cases to have multiple index_state
instances for a single repository. However, having the pointer "this
index belongs to this repository" seems helpful (to me).

> My initial implementations of --remerge-diff[1] played around with
> creating a second repo, with a different primary object store but
> everything else the same.  The index for the two repository objects
> was thus the same, and thus clearly would have violated this assumed
> invariant for one of the two repos.  I discarded that initial
> implementation (which I didn't quite have working) because I
> discovered tmp-objdir.h and was able to add some
> tmp_objdir_make_primary() and tmp_objdir_remove_as_primary() functions
> that merely altered the existing repo's primary object store, but I'm
> curious if there might be other cases of folks doing stuff that might
> have weird failures with this new invariant.

This is an interesting concept, and definitely violates my expectations
that an index belongs to only one repository. I'd need to know more
about why this was a good design decision before being convinced that
the relationship should not be many-to-one (index-to-repo).

> It's entirely possible that --remerge-diff was just so different, and
> I was so unfamiliar with repo objects (and still kind of am) that I
> was just doing weird stuff no one has done before, so perhaps no
> additional checks are needed -- I'm just throwing my gut question out
> there as food for thought.
> 
> [1] I have not yet submitted `--remerge-diff` to the list; you haven't
> missed anything.  I'm waiting for merge-ort to be submitted, reviewed,
> and merged first.  It's the remerge-diff branch in my fork on GitHub
> if anyone is curious, though.
 
I'm interested in what others might say about this idea. I'd be able
to do most of what I want to do without this patch, but it just gets
a lot messier. (istate->repo is used in the very next patch in a way
that would be less clean without it.)

Thanks,
-Stolee
