Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A500C433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F734619D3
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 04:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhCaEWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 00:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCaEWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 00:22:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5554C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 21:22:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so27973170ejc.10
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 21:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFheAUf42oVbFsoJUNZNZRJsnDsIO91pNML+oyJ7Ki0=;
        b=fhZ0L+yaI5G/luMZV+pE/ViO7zwDvFu0dojkBQCROVkgvOa0EDT86EoWcgL768kj3y
         DIY5yoQPvkbD4ZULEvMjJdX6TQHK9e4qp7PP0HygYYntHTTYQ1XGiHQDnBjhlMSWXYmx
         vBJMuEucEjmeGQZbGROrkuNEAa9+lfBn3bouFWjMK/ajP1zpwavpKqAW3VAXlxZIr8pg
         BQ/n2D+EIFgZI9LDzbVRk4CWlf46+yCcCdR3qP/SuxVDCyc7rFk6xxxPAG/als8mn7wM
         NB80Is/e/2+u270L0OOAQxRWktumSpCq162snceoyN1n6S/7pbB9OHqNoyMtYUnNdz+7
         xuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFheAUf42oVbFsoJUNZNZRJsnDsIO91pNML+oyJ7Ki0=;
        b=tfRoDlfSa4MEW+/Umxbi7Z5iC3OeyknHDApM8029XUYCKzkbgQzOjGfZzSeYapczYM
         1ZsOmK/FurAaedCtHRdhkYVGJUOsa0rPLDc3LyoMkmdgfecmXv0Xbr0Z8t9rsca8tmvx
         K0H5Wv8TA627tb7iefZGuaURHTQAIwee/55nonJ/I/TJS39HK977XRDECi2WG0gh40ba
         e6emVZ57W75nWqH1DL0RMgpwatDpstZUpO9cWXYcFmhE1aoW5lsG1jMGjqKTlxLP4amG
         OMci6hdRyQqo9olayW7o8VkKyrpPr6EZ9LCRzKKJqxl0Ybu3ymI2fmBQ6dcFzlX/WXsO
         c1OQ==
X-Gm-Message-State: AOAM531IZn9KNerOnlsRxgKc4WwH9U4+IJoedYt0TFQaXs6eKQW11S5T
        ywSBcIHKWHsXOMOMEHPXO3+bvxKBpncVog+vGg0=
X-Google-Smtp-Source: ABdhPJwGON8M8AdJZcFZ89/SNIl8q333oCEbbgtvZ1hO8Sx734h4ObcedgjSedixqRp3eadmb19EsXnZZToAWIkIz1Y=
X-Received: by 2002:a17:906:aad5:: with SMTP id kt21mr1451086ejb.160.1617164564309;
 Tue, 30 Mar 2021 21:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616015337.git.matheus.bernardino@usp.br> <a3383042e2ee6c454e024db7a9154dc979a5af9e.1616015337.git.matheus.bernardino@usp.br>
In-Reply-To: <a3383042e2ee6c454e024db7a9154dc979a5af9e.1616015337.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Mar 2021 06:22:33 +0200
Message-ID: <CAP8UFD2eaaQEuytk6cPoYco2_dfdbsM3aAvJyYFqgYSfkZ487g@mail.gmail.com>
Subject: Re: [PATCH 1/5] unpack-trees: add basic support for parallel checkout
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 10:12 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:

> +struct parallel_checkout_item {
> +       /* pointer to a istate->cache[] entry. Not owned by us. */
> +       struct cache_entry *ce;
> +       struct conv_attrs ca;
> +       struct stat st;
> +       enum pc_item_status status;
> +};
> +
> +struct parallel_checkout {
> +       enum pc_status status;
> +       struct parallel_checkout_item *items;
> +       size_t nr, alloc;
> +};

It looks like this struct parallel_checkout contains what is called
the parallel checkout queue in many places. It would be a bit better
if a name or at least a comment could make that clear.

> +static struct parallel_checkout parallel_checkout;

[...]

> +static void finish_parallel_checkout(void)
> +{
> +       if (parallel_checkout.status == PC_UNINITIALIZED)
> +               BUG("cannot finish parallel checkout: not initialized yet");
> +
> +       free(parallel_checkout.items);

Ok, it looks like the queue can indeed be freed like this as the items
don't need their fields to be freed.

> +       memset(&parallel_checkout, 0, sizeof(parallel_checkout));

That should work to reset it.

> +}
> +
> +static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
> +                                            const struct conv_attrs *ca)
> +{
> +       enum conv_attrs_classification c;
> +
> +       /*
> +        * Symlinks cannot be checked out in parallel as, in case of path
> +        * collision, they could racily replace leading directories of other
> +        * entries being checked out. Submodules are checked out in child
> +        * processes, which have their own parallel checkout queues.
> +        */
> +       if (!S_ISREG(ce->ce_mode))
> +               return 0;
> +
> +       c = classify_conv_attrs(ca);
> +       switch (c) {
> +       case CA_CLASS_INCORE:
> +               return 1;
> +
> +       case CA_CLASS_INCORE_FILTER:
> +               /*
> +                * It would be safe to allow concurrent instances of
> +                * single-file smudge filters, like rot13, but we should not
> +                * assume that all filters are parallel-process safe. So we
> +                * don't allow this.
> +                */
> +               return 0;
> +
> +       case CA_CLASS_INCORE_PROCESS:
> +               /*
> +                * The parallel queue and the delayed queue are not compatible,
> +                * so they must be kept completely separated. And we can't tell
> +                * if a long-running process will delay its response without
> +                * actually asking it to perform the filtering. Therefore, this
> +                * type of filter is not allowed in parallel checkout.
> +                *
> +                * Furthermore, there should only be one instance of the
> +                * long-running process filter as we don't know how it is
> +                * managing its own concurrency. So, spreading the entries that
> +                * requisite such a filter among the parallel workers would
> +                * require a lot more inter-process communication. We would
> +                * probably have to designate a single process to interact with
> +                * the filter and send all the necessary data to it, for each
> +                * entry.
> +                */
> +               return 0;

So it looks like we don't process entries that need filtering. It's a
bit disappointing as the commit message says:

"This new interface allows us to enqueue some of the entries being
checked out to later uncompress, smudge, and write them in parallel."

So it seems to say that entries could be smudged in parallel. Or maybe
I am missing something?

> +       case CA_CLASS_STREAMABLE:
> +               return 1;
> +
> +       default:
> +               BUG("unsupported conv_attrs classification '%d'", c);
> +       }
> +}

[...]

> +static int handle_results(struct checkout *state)
> +{
> +       int ret = 0;
> +       size_t i;
> +       int have_pending = 0;
> +
> +       /*
> +        * We first update the successfully written entries with the collected
> +        * stat() data, so that they can be found by mark_colliding_entries(),
> +        * in the next loop, when necessary.
> +        */
> +       for (i = 0; i < parallel_checkout.nr; i++) {
> +               struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
> +               if (pc_item->status == PC_ITEM_WRITTEN)
> +                       update_ce_after_write(state, pc_item->ce, &pc_item->st);
> +       }
> +
> +       for (i = 0; i < parallel_checkout.nr; i++) {
> +               struct parallel_checkout_item *pc_item = &parallel_checkout.items[i];
> +
> +               switch(pc_item->status) {
> +               case PC_ITEM_WRITTEN:
> +                       /* Already handled */
> +                       break;
> +               case PC_ITEM_COLLIDED:
> +                       /*
> +                        * The entry could not be checked out due to a path
> +                        * collision with another entry. Since there can only
> +                        * be one entry of each colliding group on the disk, we
> +                        * could skip trying to check out this one and move on.
> +                        * However, this would leave the unwritten entries with
> +                        * null stat() fields on the index, which could
> +                        * potentially slow down subsequent operations that
> +                        * require refreshing it: git would not be able to
> +                        * trust st_size and would have to go to the filesystem
> +                        * to see if the contents match (see ie_modified()).
> +                        *
> +                        * Instead, let's pay the overhead only once, now, and
> +                        * call checkout_entry_ca() again for this file, to
> +                        * have it's stat() data stored in the index. This also

s/it's/its/

> +                        * has the benefit of adding this entry and its
> +                        * colliding pair to the collision report message.
> +                        * Additionally, this overwriting behavior is consistent
> +                        * with what the sequential checkout does, so it doesn't
> +                        * add any extra overhead.
> +                        */
> +                       ret |= checkout_entry_ca(pc_item->ce, &pc_item->ca,
> +                                                state, NULL, NULL);
> +                       break;
> +               case PC_ITEM_PENDING:
> +                       have_pending = 1;
> +                       /* fall through */
> +               case PC_ITEM_FAILED:
> +                       ret = -1;
> +                       break;
> +               default:
> +                       BUG("unknown checkout item status in parallel checkout");
> +               }
> +       }
> +
> +       if (have_pending)
> +               error(_("parallel checkout finished with pending entries"));

Is this an error that can actually happen? Or is it a bug? If this can
actually happen what is the state of the working directory and what
can the user do? Start another checkout with an option to do it
sequentially?

> +       return ret;
> +}

[...]

> +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
> +                              const char *path)
> +{
> +       int ret;
> +       struct stream_filter *filter;
> +       struct strbuf buf = STRBUF_INIT;
> +       char *new_blob;
> +       unsigned long size;

I thought that we shouldn't use unsigned long anymore for sizes, but
unfortunately it looks like that's what read_blob_entry() expects.

> +       size_t newsize = 0;

I don't think we need to initialize newsize. Also we could perhaps
declare it closer to where it is used below.

> +       ssize_t wrote;
> +
> +       /* Sanity check */
> +       assert(is_eligible_for_parallel_checkout(pc_item->ce, &pc_item->ca));
> +
> +       filter = get_stream_filter_ca(&pc_item->ca, &pc_item->ce->oid);
> +       if (filter) {
> +               if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
> +                       /* On error, reset fd to try writing without streaming */
> +                       if (reset_fd(fd, path))
> +                               return -1;
> +               } else {
> +                       return 0;
> +               }
> +       }
> +
> +       new_blob = read_blob_entry(pc_item->ce, &size);
> +       if (!new_blob)
> +               return error("unable to read sha1 file of %s (%s)", path,

With the support of sha256, I guess we should avoid talking about
sha1. Maybe: s/sha1/object/ Or maybe we could just say that we
couldn't read the object, as read_blob_entry() would perhaps read it
from a pack-file and not from a loose file?

> +                            oid_to_hex(&pc_item->ce->oid));
> +
> +       /*
> +        * checkout metadata is used to give context for external process
> +        * filters. Files requiring such filters are not eligible for parallel
> +        * checkout, so pass NULL.
> +        */
> +       ret = convert_to_working_tree_ca(&pc_item->ca, pc_item->ce->name,
> +                                        new_blob, size, &buf, NULL);
> +
> +       if (ret) {
> +               free(new_blob);
> +               new_blob = strbuf_detach(&buf, &newsize);
> +               size = newsize;

"newsize" seems to be used only here. It would be nice if we could get
rid of it and pass "&size" to strbuf_detach(), but maybe we cannot
because of the unsigned long/size_t type mismatch. At least we could
declare "newsize" in this scope though.

> +       }
> +
> +       wrote = write_in_full(fd, new_blob, size);
> +       free(new_blob);
> +       if (wrote < 0)
> +               return error("unable to write file %s", path);
> +
> +       return 0;
> +}
> +

[...]

> +static void write_pc_item(struct parallel_checkout_item *pc_item,
> +                         struct checkout *state)
> +{
> +       unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;

It looks like we are using similar code in different places, so it's
probably ok, but maybe it would be nice one day to use a macro or an
inline function for this.

> +       int fd = -1, fstat_done = 0;
> +       struct strbuf path = STRBUF_INIT;
> +       const char *dir_sep;
