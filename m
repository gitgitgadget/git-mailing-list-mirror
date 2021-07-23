Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD84C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BC660ED7
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 22:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhGWVXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhGWVXN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 17:23:13 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D60C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 15:03:46 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso3485654otq.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/O/Hm/sVso+x9Z18JZMv2FY79PO+5RJJr853BgmmqnM=;
        b=DAZ8WK6Ao0/k4is2qKgJXReTID5UCj0r/4SDkZd0KVEU4AGo2ApFmp7+nhSOVnEGVv
         EH3dHQWcnjSw37/+gmieecBIEH3UKd5ZWDN6egOGuv0t8ZIiFxmmRy0A4c4TwzklsTsF
         B48MRNrnUYftkJOoQi6z80LvHUk5amnqi9i6ymCwqHWjajJH14hlkvQ7Qa/3XtSomZSE
         z9TUlRDz3bME0AEj8ULPJNz9sHoYdgGVYFJPvdAEF8d4jqGIY9G1+BGnGMpbaVx5KAtl
         vWlVpQn78egURgpDltNQbA3tCBb5Pn3y4agDPtgBPvKxJ78hgJUZxY3SyIDpxjuzPlE0
         eH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O/Hm/sVso+x9Z18JZMv2FY79PO+5RJJr853BgmmqnM=;
        b=W4eHAXLdxnh1mUvQl+MbPpAGdZpcvKaY8ea38B9s5YZQ4UaBSsxnY6pf1pRpJsuF9k
         L4BiOYeqZrOwJ7c+FWb0nmyQxmsQJxzR+DmUIHrjk6CcaQpBHSzRycc2fw+6yUSPKInU
         eZTNghpUtnOPsPSGPTX1Ptod4bLX4OdIl6GCD3UF9I2yckl5VMnNXiQd8lPuMOoslTZq
         iuLckRcfw4wveCOcbJct3jUfZYn/+VEpCT2kGNGmfGsW5+IOV7JQN9All57LKrMDg5CA
         TjTYcWO/Os7/AKcvORAjNwi/RYIjcKbvSZpLUcuyIYllenNplsx5d3ReqafZ7KaHjU2C
         Abgg==
X-Gm-Message-State: AOAM533UWP4VwbTcP+eR6urh367QlwxdKxW+wzICUApFuA+BWVxWNQvY
        iWwR/WgtuO8+jF11ShESOm2XI09Xy2OWAzo9KUnmGbyG
X-Google-Smtp-Source: ABdhPJy1SsZKLPX1lMd9e389EjPV5RiWI4zwBaYCmtxuX2gXOT6DWpvJbUyD+8nj+0QUkNUqavDl129kqXgOhgAre38=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr4384498ots.162.1627077825841;
 Fri, 23 Jul 2021 15:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <9f8ab62b84256be6d7d984d576ff4fda09d88a1d.1627044897.git.gitgitgadget@gmail.com>
 <CAPig+cQK8F2p4JT6FCFxNALxhoj2_opZit-ao=pLNhOHxN+gDw@mail.gmail.com>
In-Reply-To: <CAPig+cQK8F2p4JT6FCFxNALxhoj2_opZit-ao=pLNhOHxN+gDw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 15:03:34 -0700
Message-ID: <CABPp-BHmY37fNw36E6d8thExA13zWY3sROewoHqT3CBA-Bj2Gg@mail.gmail.com>
Subject: Re: [PATCH 1/7] diffcore-rename: use a mem_pool for exact rename
 detection's hashmap
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 2:59 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Jul 23, 2021 at 8:55 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Exact rename detection, via insert_file_table(), uses a hashmap to store
> > files by oid.  Use a mem_pool for the hashmap entries so these can all be
> > allocated and deallocated together.
> > [...]
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/diffcore-rename.c b/diffcore-rename.c
> > @@ -355,7 +357,7 @@ static int find_exact_renames(struct diff_options *options)
> >         /* Free the hash data structure and entries */
> > -       hashmap_clear_and_free(&file_table, struct file_similarity, entry);
> > +       hashmap_clear(&file_table);
>
> Does the in-code comment become a bit out of date with this change?
> (It might make sense to drop the comment altogether -- or, if not,
> explain that the hashmap entries get thrown away later with the pool?)

Ah, good catch.  Yeah, I should update it or drop the comment.

> Not necessarily worth a re-roll.

I'm sure someone will comment on something else, so I'll just include
this among the fixes.
