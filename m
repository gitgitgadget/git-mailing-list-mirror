Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E1C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706F620724
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 16:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqvlNv25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgJ3QDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3QDv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 12:03:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE68C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 09:03:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x1so7090247oic.13
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVVpAwn03cLIag9U80kL3Oqlc5cZint2arVeu9NUzAE=;
        b=UqvlNv25JXhi8RQuMOH1H8iR0bWkU0kAmVH/7jd32w916qmQPrE3Iqy1YKW7N7ZDCu
         LWD6FcWl7zC2E1dO5TIhwib9A14t0ArwMQ5Qy+ra9mAHg18wRDVvjB76BYzacGTKDGzR
         i9xv5MfAkMcMTMTX1IuoOVpRLY2dXjSqH1v/XYGKGDw1JBPkwOTErEt0mr/VWB6lqpAk
         MNl4B8VcGEIgF/BcaVTvQw6mYQd7S9EfUfUN5RHi4S+LDQVB6fbBZtM/yyAZu9JbYoCf
         2gTtkz6LGsAyEONAC0vMuVUOdKnIdBZb6/UgSKeBUtkFaAIaxeRQTYe/CmpC9XogAm0C
         kmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVVpAwn03cLIag9U80kL3Oqlc5cZint2arVeu9NUzAE=;
        b=ebWuDCVLt6L8LmmC871QfQuhMEf7Zb7g6wPoQepz3V1ggeZ+eQyfIu5rNjfdfIxglz
         uDZAxoTbT512BeWfOIKlChCulGG5YEIeXdmqI9De/wWh/adSOGr+OXO5B+57Em0Xi7D3
         LXaJlRFPKWgI9XtqLkNE1MVkupStK4Jw6zmma4jh4EIi8JDXwKu7jd0bQq8zZf974D+a
         2if2pQAe5N/wIW+S8o6G8oYHTofuCr+za6NkgNqSQWl6e6AnBed5yWkQSiGsTXrcx7+k
         SUyXwgYP5G71u16wIpcV3n5Cwiq8WdPXMQ27eTHch1f8VwdoETTfc7c/rt2WsBERNyxL
         F6rQ==
X-Gm-Message-State: AOAM531BulKSbNLMT33TELYOu+k9xM0re2ppw5DZJDg+8SjQVPG+2xaI
        RH0qyj8+yB8f9pC7IVSaKnylUOdr0EXaZeyanbM=
X-Google-Smtp-Source: ABdhPJxHicAU+gYu+o1/tLFMXeQQyv8IiY1C4VUx5xjO3wMMZurDGVsiMF1fAikvdDIzBOukqb273D/jJpJbQybEMno=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr2028784oic.31.1604073830300;
 Fri, 30 Oct 2020 09:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <061ab45a9bdae5352f62fa6e81bb21ae5c94b8df.1602549650.git.gitgitgadget@gmail.com>
 <20201030134131.GD3277724@coredump.intra.peff.net>
In-Reply-To: <20201030134131.GD3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 09:03:38 -0700
Message-ID: <CABPp-BEV6ZNsA_qqV67P=W4gASLGoggoR4wP2R6kf0eNfcsDCw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] hashmap: introduce a new hashmap_partial_clear()
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 6:41 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:44AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > merge-ort is a heavy user of strmaps, which are built on hashmap.[ch].
> > reset_maps() in merge-ort was taking about 12% of overall runtime in my
> > testcase involving rebasing 35 patches of linux.git across a big rename.
> > reset_maps() was calling hashmap_free() followed by hashmap_init(),
> > meaning that not only was it freeing all the memory associated with each
> > of the strmaps just to immediately allocate a new array again, it was
> > allocating a new array that wasy likely smaller than needed (thus
>
> s/wasy/was/

Thanks; will fix.

> > resulting in later need to rehash things).  The ending size of the map
> > table on the previous commit was likely almost perfectly sized for the
> > next commit we wanted to pick, and not dropping and reallocating the
> > table immediately is a win.
> >
> > Add some new API to hashmap to clear a hashmap of entries without
> > freeing map->table (and instead only zeroing it out like alloc_table()
> > would do, along with zeroing the count of items in the table and the
> > shrink_at field).
>
> This seems like a reasonable optimization to make, and doesn't make the
> API significantly more complicated. I'd expect the allocation of actual
> entry objects to dwarf the table allocation, but I guess:
>
>   - you'll deal with the individual entries later using a mempool
>
>   - it's not just the allocation, but the re-insertion of the entries as
>     we grow
>
> It would be nice if we had some actual perf numbers to report here, so
> we could know exactly how much it was buying us. But I guess things are
> a bit out-of-order there. You want to do this series first and then
> build merge-ort on top as a user. We could introduce the basic data
> structure first, then merge-ort, and then start applying optimizations
> with real-world measurements. But I'm not sure it's worth the amount of
> time you'd have to spend to reorganize in that way.

Yeah, the perf benefits didn't really come until I added a
strmap_clear() based on this, so as you discovered I put perf numbers
in patch 7 of this series.  Should I add a mention of the later commit
message at this point in the series?

> >  hashmap.c | 39 +++++++++++++++++++++++++++------------
> >  hashmap.h | 13 ++++++++++++-
>
> The implementation itself looks correct to me. I already mentioned my
> thoughts on naming in patch 1.

I'll circle back to that when I comment on patch 1...
