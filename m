Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83711C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 19:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiHLTWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 15:22:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAEE9925A
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 12:22:42 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r6so940988ilc.12
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3dj7eZ0ii2YhqPz6BkNhgRWwrR/EXsjoEvUeNjuNjPU=;
        b=RUZmmNyvodZWlVC3DJHsiFcUqK4dzu18qh/mKQpWzytAmWcgtWPOLqjKbRZacIV1Ud
         wM8dQGHPmiW5NfP8+tyUzlBLtnYr0vchYmuKDh1JwqAI7op+tSIxT9gd1tfk42NCb8R9
         MSIL35h9UfMN2JcOrBy3xwsC6lBE0ouNp4IGSlxytnfq690Qe8j5ZbSHQlj1rnemUuc/
         Jpv61zLmtV60OSmi77knrBvatXMMeaXrM4J04wveacP62V00QhOBER6wNtBR4MvMw96K
         jexeNHyrZ7voiozAq3yc6FdlWEySBJ6Tm6BwP/lybnBc/2DDrCYQDH6+TdKKSyh5GHFZ
         Qpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3dj7eZ0ii2YhqPz6BkNhgRWwrR/EXsjoEvUeNjuNjPU=;
        b=dBC40KNs7GfmUVDevZS7OQiDV8ghB37H1mWrT+Q3xkV3qbIAWizcaYkmie+2ECkE3Q
         1SSSzdgDi5pOnRlF5y5/k/HJmU/Tg6p7fbpiU7FVWfYe7E4CAVLEEbu/z5ZOAzwrBq4Q
         19BK5G1Q3h3NsF9NgIgqp9S/tM4PYZFG96hGMYolqt90WHPdtHJM3zOTEG97NNFnUZrc
         kYutX3iLr9h+fORRzOsUvQydH63cBiJvjzclX7qVEYzbSN7mmC6/htILStCq5vsMP8S3
         kvWbGknWWPhUoHfietFb7SC1f8PvN02Pg4LiA5gIWzYO0s05yw9KQhyah9AY4G7a6fXL
         dAxw==
X-Gm-Message-State: ACgBeo06LDYnigSym21B/J+S9X34z9whLgnG1WiSan6Br7aIStdgwB54
        IOpqRTTsOOd3XaZEEDaC7U/d
X-Google-Smtp-Source: AA6agR5+GFplvGGnu0lvThrWHTqfxpbL73PFVVjmM1qO7wFF4W41OGPyeKY3DWJqpD6Assts6YovLQ==
X-Received: by 2002:a92:ca47:0:b0:2de:a702:7a20 with SMTP id q7-20020a92ca47000000b002dea7027a20mr2603110ilo.307.1660332162108;
        Fri, 12 Aug 2022 12:22:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f58c:d8c5:7c0e:77b6? ([2600:1700:e72:80a0:f58c:d8c5:7c0e:77b6])
        by smtp.gmail.com with ESMTPSA id k20-20020a023354000000b003435cef00eesm207284jak.124.2022.08.12.12.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 12:22:41 -0700 (PDT)
Message-ID: <179c0d30-ccb1-36cf-f783-814c9c8d84c2@github.com>
Date:   Fri, 12 Aug 2022 15:22:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn
 pack.writeBitmapLookupTable and add tests
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr>
 <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr>
 <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr>
 <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr>
 <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr>
 <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com>
 <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
 <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2022 2:51 PM, Abhradeep Chakraborty wrote:

> I think I have found the problem. Derrick was right that `mtime` part
> is not the culprit. I tried to understand the whole midx workflow and
> some questions were raised in my mind. I don't know whether those are
> features or bugs (because I do not have much experience in
> multi-pack-index code).
> 
> I am writing a brief description for the context of the issue and the
> questions I have.

Thanks for the detailed writeup.

> Let us start from the `write_midx_internal()` function. As
> `packs_to_include` is null in our case, We can use the old midx to
> write a new midx file. The line `ctx.m =
> lookup_multi_pack_index(the_repository, object_dir)`[1]  does this. It
> also loads packs that do not belong to any multi-pack-indexes. It also
> sets `the_repository->objects->packed_git_intialized` to 1.  If we
> look at our test case (`setup partial bitmap`) the last `.pack` file
> (generated by `git repack &&` ) does not belong to any midx. So, that
> pack will be loaded in this step.
> 
> [1] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L1169
> 
> Next let us move to the `if (ctx.m)`[2] block. As we will be writing a
> bitmap, `if (flags & MIDX_WRITE_REV_INDEX)` is true. Thus all packs
> related to the old midx are loaded and `ctx.info[ctx.nr].p` stores the
> pointers of these packs.
> 
> [2] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L1182
> 
> After that we come to the `for_each_file_in_pack_dir(object_dir,
> add_pack_to_midx, &ctx);` line[3] . The `add_pack_to_midx`[4] function
> adds packs (that are not in the old midx) to `ctx.info`. Now I have a
> question here - Why are we using  the `add_packed_git()`[5] function
> provided we already loaded those packs in the
> `lookup_multi_pack_index` step (i.e. 1st step)? These packs are not
> added in `r->objects->packed_git`. This question is related to our
> current issue.
> 
> I.e. instead of this -
> 
>    ctx->info[ctx->nr].p = add_packed_git(full_path,
> 
> full_path_len, 0);
> 
> Why not this (or similar) -
> 
>     for (cp = the_repository->objects->packed_git; cp; cp = cp->next)
>         if (!cmp_idx_or_pack_name(cp->pack_name, full_path))
>             ctx->info[ctx->nr].p = cp;
> 
> [3] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L1221
> [4] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L462
> [5] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L492
> 
>  `write_midx_bitmap()` function is where bitmap related code starts.
> let us directly jump into the `prepare_packed_git()` function (called
> by `get_all_packs()`[6]). As I said previously,
> `r->objects->packed_git_initialized` is already enabled so this
> function becomes a no-op function. Which means it does not load the
> newly written midx (by calling `prepare_multi_pack_index_one`
> function) and uses old midx to write the bitmap (though we still have
> new packs and they can be used with the old midx to generate the
> bitmap, maybe?) . Here comes my second question - Is this the desired
> case? or should we use the new midx to write the bitmaps?

The confusing part of all this is that the bitmaps are being written
while the "new" midx is written only to "multi-pack-index.lock" and
has not been renamed to "multi-pack-index". If we renamed first, then
the old .bitmap file would not match the new midx and all Git commands
would act as if there was no .bitmap file.
 
> One important point to note is that `get_all_packs()` returns
> `r->objects->packed_git` which now stores pointers of all the packs
> and only these packfiles have their `->index` set.
> 
> [6] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/packfile.c#L1043
> 
> Now let us move to the last function - `oe_set_in_pack()` (called by
> `prepare_midx_packing_data()`). Note that, we are passing
> `ctx->info[ctx->pack_perm[from->pack_int_id]].p` along with other
> parameters. As I have said in an earlier para (containing my first
> question), `ctx->info` has some packs (i.e. newer packs that are not
> related to the old midx) that are not installed in
> `r->objects->packed_git` . In other words, we have two instances of
> the same pack file - one in `r->objects->packed_git` list and another
> in `ctx->info[id].p`. As `prepare_in_pack_by_idx` function only sets
> `->index` for `r->objects->packed_git` packs, these packs (i.e.
> `ctx.info[id].p`) do not have their p->index set and thus end up
> calling the `oe_map_new_pack` function.

So really, the problem is that we are handling the r->objects->packed_git
list instead of an array of packs that are under the control of the new
midx. This assumption is baked deep in the pack-objects flow, so it
would be hard to separate this idea.

Perhaps doing the reprepare_packed_git() to regenerate the list would be
sufficient as a band-aid for now, but we would want to later do the big
dig of focusing the pack_data struct to a specific list of pack-files
(by default the set from get_all_packs(), but for midx bitmaps we can
supply a specific set of packs).

Thanks,
-Stolee
