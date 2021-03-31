Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF7AC433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B850619CD
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhCaEcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 00:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhCaEcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 00:32:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E87C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 21:32:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so20646898edt.13
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D3tTDcRSBLaztbxvGF3E/WRTC1Ew/uoMztxezQ1sRyk=;
        b=EObOqBz9SY3f9K3XDDwj7TI1ihD4GXkQnKt2ynewZYlg1lhf3ZqNQi3EguuA1V0Wby
         O9ciGDL6pGefpKG63qZT4AwuA4II0UazlnrhWSWR9ApY8qG92r93zMaL9HsoITH6PuHh
         RyYWbxoV8nvluDyyNG/rft+CRSPFmxDvyBDQcyjppMdGAx9JGeISTZqWn1V9RluMjLdF
         5Hly6p4GJxBKUWNIJULodg58oUrlpZTzh/Um0oCJ4xuKKwA5hbhu2yAN2vz9y5coGt8h
         pMW19UQMM05uoHq4+wAzaLrW3HUBzKIiiFVE/wj4jM8KKQHlhCxRHAl333hyi+AGfPY/
         gK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D3tTDcRSBLaztbxvGF3E/WRTC1Ew/uoMztxezQ1sRyk=;
        b=cYS+K00SLKmQjH9alqI5LR+7QilquYFVuQfr7FJH2VO0UnLQfZ4AFZNdQq6DOeUniJ
         gx5jaBWX+QZvv/Za3kMh5Ch8YdQwvbmtXKMeC//KY1Vu2JLMbnsJiPZto/a/VRB5PsHr
         Mn2Wd9Zi2pn/KLk+oH/ObPZRMg2WLztrA5SeGI8VY2MGlTZ8Am/08kMYdRpctb1RuNkz
         Mms7AMEvjZQcsPfL53DiztNc+kXvyKrOWw4BR86ppD8ia+vfKCdPmir0Wu76JJ2WQXFm
         iQJcCaL30E4VEsFq35fXcS+fN1N7BnlCOkllJTohYxWB7y8UtBNflEmXVaQL1uIpjd3C
         pJOg==
X-Gm-Message-State: AOAM5303L6nqTTBmetFKkPLT57GH3OLEIZEHowBzgdxTKhO8qHXa9Z/G
        kmMY/wlq4Fys769rtu0MuxFpKv+8UVRIoDqtnzE=
X-Google-Smtp-Source: ABdhPJzjQVAeZQdHCsYfLZkU8hBp09BzskR2APzsF+TCEGmRsiIlLCHPF8BBvWbX88IP7u1apvm0EP1Dk721mkOrmME=
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr1294776edx.273.1617165169984;
 Tue, 30 Mar 2021 21:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br> <fca797698c78e2248bd2645bd0dce23ec4df35ae.1616015337.git.matheus.bernardino@usp.br>
In-Reply-To: <fca797698c78e2248bd2645bd0dce23ec4df35ae.1616015337.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Mar 2021 06:32:38 +0200
Message-ID: <CAP8UFD0CmPmvK7a-+5fKk0e0=te_e7cCFf6_-vSFrX9COTBg-w@mail.gmail.com>
Subject: Re: [PATCH 2/5] parallel-checkout: make it truly parallel
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> diff --git a/.gitignore b/.gitignore
> index 3dcdb6bb5a..26f8ddfc55 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -33,6 +33,7 @@
>  /git-check-mailmap
>  /git-check-ref-format
>  /git-checkout
> +/git-checkout--helper

I wonder if "checkout--worker" would be better than "checkout--helper".

>  /git-checkout-index
>  /git-cherry
>  /git-cherry-pick

[...]

> +#define ASSERT_PC_ITEM_RESULT_SIZE(got, exp) \
> +{ \
> +       if (got != exp) \
> +               BUG("corrupted result from checkout worker (got %dB, exp %dB)", \

Maybe precompilers are smart enough to not replace the "got" and "exp"
in the above string, but it might be a bit confusing for readers.
Anway I wonder if this macro could just be a regular (possibly inline)
function.

> +                   got, exp); \
> +} while(0)

> +static void parse_and_save_result(const char *line, int len,
> +                                 struct pc_worker *worker)
> +{
> +       struct pc_item_result *res;
> +       struct parallel_checkout_item *pc_item;
> +       struct stat *st = NULL;
> +
> +       if (len < PC_ITEM_RESULT_BASE_SIZE)
> +               BUG("too short result from checkout worker (got %dB, exp %dB)",
> +                   len, (int)PC_ITEM_RESULT_BASE_SIZE);
> +
> +       res = (struct pc_item_result *)line;
> +
> +       /*
> +        * Worker should send either the full result struct on success, or
> +        * just the base (i.e. no stat data), otherwise.
> +        */
> +       if (res->status == PC_ITEM_WRITTEN) {
> +               ASSERT_PC_ITEM_RESULT_SIZE(len, (int)sizeof(struct pc_item_result));
> +               st = &res->st;
> +       } else {
> +               ASSERT_PC_ITEM_RESULT_SIZE(len, (int)PC_ITEM_RESULT_BASE_SIZE);
> +       }
> +
> +       if (!worker->nr_items_to_complete || res->id != worker->next_item_to_complete)

Nit: maybe it could be useful to distinguish between these 2 potential
bugs and have a specific BUG() for each one.

> +               BUG("checkout worker sent unexpected item id");

> +       worker->next_item_to_complete++;
> +       worker->nr_items_to_complete--;
> +
> +       pc_item = &parallel_checkout.items[res->id];
> +       pc_item->status = res->status;
> +       if (st)
> +               pc_item->st = *st;
> +}
> +
> +

One blank line is enough.

> +static void gather_results_from_workers(struct pc_worker *workers,
> +                                       int num_workers)
> +{
> +       int i, active_workers = num_workers;
> +       struct pollfd *pfds;
> +
> +       CALLOC_ARRAY(pfds, num_workers);
> +       for (i = 0; i < num_workers; i++) {
> +               pfds[i].fd = workers[i].cp.out;
> +               pfds[i].events = POLLIN;
> +       }
> +
> +       while (active_workers) {
> +               int nr = poll(pfds, num_workers, -1);
> +
> +               if (nr < 0) {
> +                       if (errno == EINTR)
> +                               continue;
> +                       die_errno("failed to poll checkout workers");
> +               }
> +
> +               for (i = 0; i < num_workers && nr > 0; i++) {

Is it possible that nr is 0? If that happens, it looks like we would
be in an infinite `while (active_workers) { ... }` loop.

Actually in poll(2) there is: "A value of 0 indicates that the call
timed out and no file descriptors were ready." So it seems that it
could, at least theorically, happen.

> +                       struct pc_worker *worker = &workers[i];
> +                       struct pollfd *pfd = &pfds[i];
> +
> +                       if (!pfd->revents)
> +                               continue;
> +
> +                       if (pfd->revents & POLLIN) {
> +                               int len;
> +                               const char *line = packet_read_line(pfd->fd, &len);
> +
> +                               if (!line) {
> +                                       pfd->fd = -1;
> +                                       active_workers--;
> +                               } else {
> +                                       parse_and_save_result(line, len, worker);
> +                               }
> +                       } else if (pfd->revents & POLLHUP) {
> +                               pfd->fd = -1;
> +                               active_workers--;
> +                       } else if (pfd->revents & (POLLNVAL | POLLERR)) {
> +                               die(_("error polling from checkout worker"));
> +                       }
> +
> +                       nr--;
> +               }
> +       }
> +
> +       free(pfds);
> +}

[...]

> +enum pc_item_status {
> +       PC_ITEM_PENDING = 0,
> +       PC_ITEM_WRITTEN,
> +       /*
> +        * The entry could not be written because there was another file
> +        * already present in its path or leading directories. Since
> +        * checkout_entry_ca() removes such files from the working tree before
> +        * enqueueing the entry for parallel checkout, it means that there was
> +        * a path collision among the entries being written.
> +        */
> +       PC_ITEM_COLLIDED,
> +       PC_ITEM_FAILED,
> +};
> +
> +struct parallel_checkout_item {
> +       /*
> +        * In main process ce points to a istate->cache[] entry. Thus, it's not
> +        * owned by us. In workers they own the memory, which *must be* released.
> +        */
> +       struct cache_entry *ce;
> +       struct conv_attrs ca;
> +       size_t id; /* position in parallel_checkout.items[] of main process */
> +
> +       /* Output fields, sent from workers. */
> +       enum pc_item_status status;
> +       struct stat st;
> +};

Maybe the previous patch could have declared both 'enum
pc_item_status' and 'struct parallel_checkout_item' here, in
parallel-checkout.h, so that this patch wouldn't need to move them
here.
