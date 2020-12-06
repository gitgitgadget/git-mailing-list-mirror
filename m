Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2560C433FE
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 11:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EF0229C5
	for <git@archiver.kernel.org>; Sun,  6 Dec 2020 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLFLgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 06:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFLgy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 06:36:54 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D448EC0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 03:36:13 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f23so15357215ejk.2
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOEdL2yKUUx0nc0vpG2hwQROfUHJ6TVQCLci5Mx092s=;
        b=hLBVNLJ2tn8pc+flNdSV2dYQ6LfywRI5/Neum9/v3cS0D1uDih/GjViyb68iteyLCA
         CMFggecC2YyXWkcCgTvCHpHg8mV8VXqInPYMX/lL9wCBzuyOEGZG+CUqLXeFjjjV9weT
         rq6rSFywpbTc8ddh5YiUfBqo+41GnBeAeQC81RZYCgChW32MTeCppAnfiBG259NlJ6Od
         /EhPkN1O+VdJaiPT/xHVZhYRsRn7hQZqwnnLvH+ecDp3Jr2LJy004V+aja+oxq7yNNLc
         VUltdUDiqXm3GLwb1EMC4SH6WeyTbo1CQ28UnBy/Q9fZ0od+6n0X2MXeKm9oDreqAg1/
         eqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOEdL2yKUUx0nc0vpG2hwQROfUHJ6TVQCLci5Mx092s=;
        b=TxOCHrALqYDbph/q+E9z8AzZ8bCs+DY/vQF6DJ48Kvx9VXpsy748DUZptbxd+VOQQS
         weBwxKa7Pa9mHRuBDNioAveSf7lxGx0ZEmmLXSa1vPdooICD0KXIRss7A4cto7re3188
         z71R5JY7rwbvTIOyNLt98X71sKTmyCWAME9fdHXl0lJr4MYzNlrXN4MUeUCkuRhO3fEm
         Dz7/fiBMPwDfYFb7mNPYoMTZ3ZGh4OWoQyiTBcSaracWhgXFwhgydQD3WlrSLo1hQy0W
         2/erbb2JfcnWwTMRLbypwTty6KwZmSvuc5VwcVObi7YoBcVsx+lBPOD91ZvbZmOYDYrg
         t9nw==
X-Gm-Message-State: AOAM533POLjLmA1icRMcKlwFTgCvj/JGajmcHQScRdwYNV/kO3Hp0WTk
        5QJbdLdgGhtMe9vzFJUk5ixxKmNkC/ChMYE1lrE=
X-Google-Smtp-Source: ABdhPJzAVfOjSsmM4V0AQmz78/5F4z++qSekx5gFQrISQybUdWAFKz5hmy9qEnT3xQq5565FEnLUJpzKkFm7cWcEqsA=
X-Received: by 2002:a17:906:9a07:: with SMTP id ai7mr14938514ejc.216.1607254572569;
 Sun, 06 Dec 2020 03:36:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br> <bc8447cd9c106055a715305ab506adc6abae7713.1604521275.git.matheus.bernardino@usp.br>
In-Reply-To: <bc8447cd9c106055a715305ab506adc6abae7713.1604521275.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 6 Dec 2020 12:36:00 +0100
Message-ID: <CAP8UFD2+6DYpqM5d1-OCMr4hnGksng4R3e23hcQErT4-ff77=Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/19] unpack-trees: add basic support for parallel checkout
To:     Matheus Tavares <matheus.bernardino@usp.br>
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

On Wed, Nov 4, 2020 at 9:34 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This new interface allows us to enqueue some of the entries being
> checked out to later call write_entry() for them in parallel. For now,
> the parallel checkout machinery is enabled by default and there is no
> user configuration, but run_parallel_checkout() just writes the queued
> entries in sequence (without spawning additional workers). The next
> patch will actually implement the parallelism and, later, we will make
> it configurable.

I would think that it might be more logical to first add a
configuration that does nothing, then add writing the queued entries
in sequence without parallelism, and then add actual parallelism.

> When there are path collisions among the entries being written (which
> can happen e.g. with case-sensitive files in case-insensitive file
> systems), the parallel checkout code detects the problem and marks the
> item with PC_ITEM_COLLIDED.

Is this needed in this step that only writes the queued entries in
sequence without parallelism, or could this be added later, before the
step that adds actual parallelism?

> Later, these items are sequentially fed to
> checkout_entry() again. This is similar to the way the sequential code
> deals with collisions, overwriting the previously checked out entries
> with the subsequent ones. The only difference is that, when we start
> writing the entries in parallel, we won't be able to determine which of
> the colliding entries will survive on disk (for the sequential
> algorithm, it is always the last one).

So I guess that PC_ITEM_COLLIDED will then be used to decide which
entries will not be checked out in parallel?

> I also experimented with the idea of not overwriting colliding entries,
> and it seemed to work well in my simple tests.

There are a number of co-author of this patch, so it's not very clear
who "I" is. Maybe:

"The idea of not overwriting colliding entries seemed to work well in
simple tests, however ..."

> However, because just one
> entry of each colliding group would be actually written, the others
> would have null lstat() fields on the index. This might not be a problem
> by itself, but it could cause performance penalties for subsequent
> commands that need to refresh the index: when the st_size value cached
> is 0, read-cache.c:ie_modified() will go to the filesystem to see if the
> contents match. As mentioned in the function:
>
>     * Immediately after read-tree or update-index --cacheinfo,
>     * the length field is zero, as we have never even read the
>     * lstat(2) information once, and we cannot trust DATA_CHANGED
>     * returned by ie_match_stat() which in turn was returned by
>     * ce_match_stat_basic() to signal that the filesize of the
>     * blob changed.  We have to actually go to the filesystem to
>     * see if the contents match, and if so, should answer "unchanged".
>
> So, if we have N entries in a colliding group and we decide to write and
> lstat() only one of them, every subsequent git-status will have to read,
> convert, and hash the written file N - 1 times, to check that the N - 1
> unwritten entries are dirty. By checking out all colliding entries (like
> the sequential code does), we only pay the overhead once.

Ok.

>  5 files changed, 410 insertions(+), 3 deletions(-)

It looks like a lot of new code in one patch/commit, which is why it
might be interesting to split it.

> @@ -7,6 +7,7 @@
>  #include "progress.h"
>  #include "fsmonitor.h"
>  #include "entry.h"
> +#include "parallel-checkout.h"
>
>  static void create_directories(const char *path, int path_len,
>                                const struct checkout *state)
> @@ -426,8 +427,17 @@ static void mark_colliding_entries(const struct checkout *state,
>         for (i = 0; i < state->istate->cache_nr; i++) {
>                 struct cache_entry *dup = state->istate->cache[i];
>
> -               if (dup == ce)
> -                       break;
> +               if (dup == ce) {
> +                       /*
> +                        * Parallel checkout creates the files in no particular
> +                        * order. So the other side of the collision may appear
> +                        * after the given cache_entry in the array.
> +                        */

Is it really the case right now that the code creates files in no
particular order or will that be the case later when actual
parallelism is implemented?

> +                       if (parallel_checkout_status() == PC_RUNNING)
> +                               continue;
> +                       else
> +                               break;
> +               }

> +struct parallel_checkout_item {
> +       /* pointer to a istate->cache[] entry. Not owned by us. */
> +       struct cache_entry *ce;
> +       struct conv_attrs ca;
> +       struct stat st;
> +       enum pc_item_status status;
> +};

"item" seems not very clear to me. If there is only one
parallel_checkout_item for each cache_entry then it might be better to
use "parallel_checkout_entry" instead of "parallel_checkout_item".

> +enum pc_status {
> +       PC_UNINITIALIZED = 0,
> +       PC_ACCEPTING_ENTRIES,
> +       PC_RUNNING,
> +};
> +
> +enum pc_status parallel_checkout_status(void);
> +void init_parallel_checkout(void);

Maybe a comment to tell what the above function does could be helpful.
If I had to guess, I would write something like:

/*
 * Put parallel checkout into the PC_ACCEPTING_ENTRIES state.
 * Should be used only when in the PC_UNINITIALIZED state.
 */

> +/*
> + * Return -1 if parallel checkout is currently not enabled

Is it "enabled" or "initialized" or "configured" here? Does it refer
to `enum pc_status` or a config option or something else? Looking at
the code, it is testing if the status PC_ACCEPTING_ENTRIES, so
perhaps: s/not enabled/not accepting entries/

> or if the entry is
> + * not eligible for parallel checkout. Otherwise, enqueue the entry for later
> + * write and return 0.
> + */
> +int enqueue_checkout(struct cache_entry *ce, struct conv_attrs *ca);
