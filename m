Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DFDC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302EC2225E
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgLGTHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgLGTHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:07:16 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57AC061285
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 11:06:30 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so16246516ljk.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 11:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0cZe5gCiBmn19LAoGJWXaIsBYG0REWS7Xufu7I2DpQ=;
        b=QqRm95NTaFODLa8ic1fODWqRoaTdBR5uMkrt0lWCL/Eqpaj1eczmTF4tjb9AAHZj09
         VLrDcq3HuIwnKysagZdUQCt2XBA/XjGGhwAeLuN9LMgLo5WRI4k8MeMuktrpStQuWYdL
         leWeiC5vn+hjyyutfwokAhmBtXI5XBThOGQYcPR4/wM47xu4B2zIefru+1h50Hz8cKIk
         asstdydo3du6plZTf4Vz5XlzN7+bbls39Gw+i+duAdojMpdIZzDy0e9McE/q77I09Aoe
         Q4lstWS2x0NNUs5w7ev+HSQKIQBb2TGELqSoN27P++lXtVUp5o3crjgGY29r4KrKEGCt
         znVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0cZe5gCiBmn19LAoGJWXaIsBYG0REWS7Xufu7I2DpQ=;
        b=SDYvdJYAsFni14dGD/RqNlHp8u9JTKVhjHqlqidy76D2uPyk36P28nEliDR+xBXtL9
         IvElPtnCLR4SoNadzKPRhdkXeP0jyJ8KNRS+Y0L0P9VpdWjuTCyP+ETinInr+tpoKo60
         uYibTSD1Vq1r7rduA/TUZuXfhVgrDE5dJwlivazi1Yw2tnt/JPUuOUZrNRpgfsSCX2El
         Lg1QZ8/UOfo0FP69/oKvtp8t3LfazwljhlTpHtWrTIkBbmDUoXktrqq6oou6PvKbMdRd
         lSqnuxU3Hc3ECe9iv5Q9Y/238SiHYeWHXAXNGmixshxoz0IJ11JfMNmoV739UYGtSurK
         OL/Q==
X-Gm-Message-State: AOAM5328WUcY1N5sCJTgAIcnASSwqUlMnvzw7TvRb2nVqjZ41b6EDQAQ
        aaSgEpcgni+VEZeVMhEpJPJJi+fOv+mf6s3ba61PXw==
X-Google-Smtp-Source: ABdhPJzS1gxoYNcmv5Mbw5HJMGPHn4GDYo8E7iccN4VjK7icSHgFB6lA9rZdHxRf1q3cQCjB8/cJsHGXgqeceOBBIvY=
X-Received: by 2002:a2e:b4ed:: with SMTP id s13mr9386435ljm.22.1607367988675;
 Mon, 07 Dec 2020 11:06:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <bc8447cd9c106055a715305ab506adc6abae7713.1604521275.git.matheus.bernardino@usp.br>
 <CAP8UFD2+6DYpqM5d1-OCMr4hnGksng4R3e23hcQErT4-ff77=Q@mail.gmail.com>
In-Reply-To: <CAP8UFD2+6DYpqM5d1-OCMr4hnGksng4R3e23hcQErT4-ff77=Q@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 7 Dec 2020 16:06:16 -0300
Message-ID: <CAHd-oW7gn+ryOu+HhNUs6Do6dsamp86hEK3Lz5S7ajXYF1-YSw@mail.gmail.com>
Subject: Re: [PATCH v4 10/19] unpack-trees: add basic support for parallel checkout
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Christian

On Sun, Dec 6, 2020 at 8:36 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:34 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > This new interface allows us to enqueue some of the entries being
> > checked out to later call write_entry() for them in parallel. For now,
> > the parallel checkout machinery is enabled by default and there is no
> > user configuration, but run_parallel_checkout() just writes the queued
> > entries in sequence (without spawning additional workers). The next
> > patch will actually implement the parallelism and, later, we will make
> > it configurable.

I just noticed that this part of the commit message is a little
outdated. I'll fix it for v5. Currently, the parallelism and
configuration are added in the same patch (the next one). This way,
the patch that adds parallelism can already include runtime numbers
for different configuration values (which shows when the change is
beneficial).

> I would think that it might be more logical to first add a
> configuration that does nothing, then add writing the queued entries
> in sequence without parallelism, and then add actual parallelism.

I'm not sure I get the idea. Would the first patch add just the
documentation for `checkout.workers` and
`checkout.thresholdForParallelism` in
`Documentation/config/checkout.txt`, without the support for it in the
code? In that case, wouldn't the patch become somewhat incomplete on
its own?

> > When there are path collisions among the entries being written (which
> > can happen e.g. with case-sensitive files in case-insensitive file
> > systems), the parallel checkout code detects the problem and marks the
> > item with PC_ITEM_COLLIDED.
>
> Is this needed in this step that only writes the queued entries in
> sequence without parallelism, or could this be added later, before the
> step that adds actual parallelism?

This is already used in this patch. Even though the parallel checkout
machinery only learns to spawn additional workers in the next patch,
it can already encounter path collisions when writing the entries
sequentially. PC_ITEM_COLLIDED is then used to mark the colliding
entries, so that they can be properly handled later.

> > Later, these items are sequentially fed to
> > checkout_entry() again. This is similar to the way the sequential code
> > deals with collisions, overwriting the previously checked out entries
> > with the subsequent ones. The only difference is that, when we start
> > writing the entries in parallel, we won't be able to determine which of
> > the colliding entries will survive on disk (for the sequential
> > algorithm, it is always the last one).
>
> So I guess that PC_ITEM_COLLIDED will then be used to decide which
> entries will not be checked out in parallel?

Yes, in the next patch, the parallel workers will detect collisions
when `open(path, O_CREAT | O_EXCL)` fails with EEXIST or EISDIR. The
workers then mark such items with PC_ITEM_COLLIDED and let the main
process sequentially write them later.

> > I also experimented with the idea of not overwriting colliding entries,
> > and it seemed to work well in my simple tests.
>
> There are a number of co-author of this patch, so it's not very clear
> who "I" is. Maybe:
>
> "The idea of not overwriting colliding entries seemed to work well in
> simple tests, however ..."

Makes sense, thanks.

> > However, because just one
> > entry of each colliding group would be actually written, the others
> > would have null lstat() fields on the index. This might not be a problem
> > by itself, but it could cause performance penalties for subsequent
> > commands that need to refresh the index: when the st_size value cached
> > is 0, read-cache.c:ie_modified() will go to the filesystem to see if the
> > contents match. As mentioned in the function:
> >
> >     * Immediately after read-tree or update-index --cacheinfo,
> >     * the length field is zero, as we have never even read the
> >     * lstat(2) information once, and we cannot trust DATA_CHANGED
> >     * returned by ie_match_stat() which in turn was returned by
> >     * ce_match_stat_basic() to signal that the filesize of the
> >     * blob changed.  We have to actually go to the filesystem to
> >     * see if the contents match, and if so, should answer "unchanged".
> >
> > So, if we have N entries in a colliding group and we decide to write and
> > lstat() only one of them, every subsequent git-status will have to read,
> > convert, and hash the written file N - 1 times, to check that the N - 1
> > unwritten entries are dirty. By checking out all colliding entries (like
> > the sequential code does), we only pay the overhead once.
>
> Ok.
>
> >  5 files changed, 410 insertions(+), 3 deletions(-)
>
> It looks like a lot of new code in one patch/commit, which is why it
> might be interesting to split it.

Yeah, this and the following patch ended up quite big... But I wasn't
sure how to further split them while still keeping each part buildable
and self-contained :(

> > @@ -7,6 +7,7 @@
> >  #include "progress.h"
> >  #include "fsmonitor.h"
> >  #include "entry.h"
> > +#include "parallel-checkout.h"
> >
> >  static void create_directories(const char *path, int path_len,
> >                                const struct checkout *state)
> > @@ -426,8 +427,17 @@ static void mark_colliding_entries(const struct checkout *state,
> >         for (i = 0; i < state->istate->cache_nr; i++) {
> >                 struct cache_entry *dup = state->istate->cache[i];
> >
> > -               if (dup == ce)
> > -                       break;
> > +               if (dup == ce) {
> > +                       /*
> > +                        * Parallel checkout creates the files in no particular
> > +                        * order. So the other side of the collision may appear
> > +                        * after the given cache_entry in the array.
> > +                        */
>
> Is it really the case right now that the code creates files in no
> particular order or will that be the case later when actual
> parallelism is implemented?

In this patch, the code already creates files in no particular order.
Since not all entries are eligible for parallel checkout, and because
ineligible entries are written first, the files are not created in the
same order that they appear in istate->cache[]. (Even though
everything is still written sequentially in this patch).

> > +                       if (parallel_checkout_status() == PC_RUNNING)
> > +                               continue;
> > +                       else
> > +                               break;
> > +               }
>
> > +struct parallel_checkout_item {
> > +       /* pointer to a istate->cache[] entry. Not owned by us. */
> > +       struct cache_entry *ce;
> > +       struct conv_attrs ca;
> > +       struct stat st;
> > +       enum pc_item_status status;
> > +};
>
> "item" seems not very clear to me. If there is only one
> parallel_checkout_item for each cache_entry then it might be better to
> use "parallel_checkout_entry" instead of "parallel_checkout_item".

Hmm, I'm a little uncertain about this one. I usually use "item" and
"entry" interchangeably when talking about elements on a list, as in
this case. Could perhaps the 'struct parallel_checkout_item'
definition be unclear because it's far from the 'struct
parallel_checkout', where the list is actually defined?

> > +enum pc_status {
> > +       PC_UNINITIALIZED = 0,
> > +       PC_ACCEPTING_ENTRIES,
> > +       PC_RUNNING,
> > +};
> > +
> > +enum pc_status parallel_checkout_status(void);
> > +void init_parallel_checkout(void);
>
> Maybe a comment to tell what the above function does could be helpful.
> If I had to guess, I would write something like:
>
> /*
>  * Put parallel checkout into the PC_ACCEPTING_ENTRIES state.
>  * Should be used only when in the PC_UNINITIALIZED state.
>  */

OK, will do, thanks!

> > +/*
> > + * Return -1 if parallel checkout is currently not enabled
>
> Is it "enabled" or "initialized" or "configured" here? Does it refer
> to `enum pc_status` or a config option or something else? Looking at
> the code, it is testing if the status PC_ACCEPTING_ENTRIES, so
> perhaps: s/not enabled/not accepting entries/

Yes, that's better, thanks!
