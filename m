Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A97FC25B0E
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 18:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiHLSv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiHLSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 14:51:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10674E0DE
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 11:51:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z2so2401540edc.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1ABzOP9UWbYpEuZc2xnJ8ojXSOEdWyiKN/TDY4BHwTA=;
        b=K3Zjb79pT+93NZegx/rR3jr6Mamyx5DFhBkwRakazichGT7VMa09Wa46E8mjvRk8E7
         KOGNXJncoZX/CnZOq/Gu0pJ3UxtjDc2iZdx9Zdo31unLGVuryv9hZfDYmKgNjiXqkLBM
         XFjNKs66x7cgmaxEQ7TI0mV4wH2cs7AGXlyho+kxXUNjEZTUZEe93l4QAXDWQcimtmi0
         FCSiChWE9uwPiAGlhPNyuA59O5D/0Eu9AkGEug5vIF9BOe8fhUTX8PPJuzUcBw/u9sfr
         /ickXYh8Mzz0iRM8FXbg6Fyc0k0ZUwzPceyuEy26riEuuIMLp63jDEpWlhJtRchBafW4
         C94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1ABzOP9UWbYpEuZc2xnJ8ojXSOEdWyiKN/TDY4BHwTA=;
        b=rRwcqaOZfXlj8KWQ2EKdQkBm+gtrW/s8OunA2K8zSXE/o/qwlsgN4Z3rderf776xaZ
         ZWLxyLCe6ri8PmAtFnImk+Bkorq+HXYs17e7ks9R3hItUDNbX1HmJzYNERypIyqG4fQA
         oozlWt/kHy6Dg7ARYfraCh6LZQB35RQ6Y1JWYUhL6fJJGl/+pVcdQPDcSODAYddpGu2Y
         JySOUreBWncCB+PICyOY7L0zcX27jSIS+2WCXipmQJsPxUwTQQyuqzEIrEkb72BGQtmc
         m9dg0jj7DQXCr4M7Zxpo4qz4p7UyO5TDDfu5Z7pxC43Hr67Joffl3P72qPalxGlCCSg1
         XHyA==
X-Gm-Message-State: ACgBeo0heQbDd0cBDGCJdIC4uGKMCQd85/D6Bm0yMnUVF75mYNOgEDwd
        YCZo/Wa6hLA8Ny9jwfQm2XbeteNmuvaWqWhxfng=
X-Google-Smtp-Source: AA6agR6jP7tvAwJQ7sBZEnMclUsAlJH6hRjqPIkA4BJQobYCMOAq60EsPyso4flTg98ldPnOSmLfto0to19/PwWF2MM=
X-Received: by 2002:aa7:dc10:0:b0:440:b446:c0cc with SMTP id
 b16-20020aa7dc10000000b00440b446c0ccmr4704219edu.34.1660330313450; Fri, 12
 Aug 2022 11:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr> <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
 <p69r38sn-1ppn-q66q-9089-59394pq78772@tzk.qr> <CAPOJW5zYndyqwyN8xOcRQnwebqXciY-25hNL3fU=V5ac8fCpNA@mail.gmail.com>
 <s714sq49-o13q-5417-0o21-6397s3646q9o@tzk.qr> <CAPOJW5yNQvO3quG91jjC9pT-+NNhJta+H_E2R9-1wUzR+rPXnw@mail.gmail.com>
 <68r08n47-9o07-351s-710q-786q69429q86@tzk.qr> <4rs1s351-73np-4sq8-p6o8-r7178rp0p0n0@tzk.qr>
 <CAPOJW5w2NYbRkFOaqrNYVFkp5ud=aAxhGGV6gpdDPwnyx5TAVw@mail.gmail.com> <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
In-Reply-To: <805fb0df-45ab-7edd-8787-662b84201e2b@github.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 13 Aug 2022 00:21:42 +0530
Message-ID: <CAPOJW5x0coFREUPjFbF_zzQYbfEjOrL-j-G4N7MBUN4N6uS2jw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I think I have found the problem. Derrick was right that `mtime` part
is not the culprit. I tried to understand the whole midx workflow and
some questions were raised in my mind. I don't know whether those are
features or bugs (because I do not have much experience in
multi-pack-index code).

I am writing a brief description for the context of the issue and the
questions I have.

Let us start from the `write_midx_internal()` function. As
`packs_to_include` is null in our case, We can use the old midx to
write a new midx file. The line `ctx.m =
lookup_multi_pack_index(the_repository, object_dir)`[1]  does this. It
also loads packs that do not belong to any multi-pack-indexes. It also
sets `the_repository->objects->packed_git_intialized` to 1.  If we
look at our test case (`setup partial bitmap`) the last `.pack` file
(generated by `git repack &&` ) does not belong to any midx. So, that
pack will be loaded in this step.

[1] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L1169

Next let us move to the `if (ctx.m)`[2] block. As we will be writing a
bitmap, `if (flags & MIDX_WRITE_REV_INDEX)` is true. Thus all packs
related to the old midx are loaded and `ctx.info[ctx.nr].p` stores the
pointers of these packs.

[2] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L1182

After that we come to the `for_each_file_in_pack_dir(object_dir,
add_pack_to_midx, &ctx);` line[3] . The `add_pack_to_midx`[4] function
adds packs (that are not in the old midx) to `ctx.info`. Now I have a
question here - Why are we using  the `add_packed_git()`[5] function
provided we already loaded those packs in the
`lookup_multi_pack_index` step (i.e. 1st step)? These packs are not
added in `r->objects->packed_git`. This question is related to our
current issue.

I.e. instead of this -

   ctx->info[ctx->nr].p = add_packed_git(full_path,

full_path_len, 0);

Why not this (or similar) -

    for (cp = the_repository->objects->packed_git; cp; cp = cp->next)
        if (!cmp_idx_or_pack_name(cp->pack_name, full_path))
            ctx->info[ctx->nr].p = cp;

[3] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L1221
[4] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L462
[5] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/midx.c#L492

 `write_midx_bitmap()` function is where bitmap related code starts.
let us directly jump into the `prepare_packed_git()` function (called
by `get_all_packs()`[6]). As I said previously,
`r->objects->packed_git_initialized` is already enabled so this
function becomes a no-op function. Which means it does not load the
newly written midx (by calling `prepare_multi_pack_index_one`
function) and uses old midx to write the bitmap (though we still have
new packs and they can be used with the old midx to generate the
bitmap, maybe?) . Here comes my second question - Is this the desired
case? or should we use the new midx to write the bitmaps?

One important point to note is that `get_all_packs()` returns
`r->objects->packed_git` which now stores pointers of all the packs
and only these packfiles have their `->index` set.

[6] https://github.com/git/git/blob/5502f77b6944eda8e26813d8f542cffe7d110aea/packfile.c#L1043

Now let us move to the last function - `oe_set_in_pack()` (called by
`prepare_midx_packing_data()`). Note that, we are passing
`ctx->info[ctx->pack_perm[from->pack_int_id]].p` along with other
parameters. As I have said in an earlier para (containing my first
question), `ctx->info` has some packs (i.e. newer packs that are not
related to the old midx) that are not installed in
`r->objects->packed_git` . In other words, we have two instances of
the same pack file - one in `r->objects->packed_git` list and another
in `ctx->info[id].p`. As `prepare_in_pack_by_idx` function only sets
`->index` for `r->objects->packed_git` packs, these packs (i.e.
`ctx.info[id].p`) do not have their p->index set and thus end up
calling the `oe_map_new_pack` function.
