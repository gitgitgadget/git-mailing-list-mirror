Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD246C4742C
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 03:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91C322277
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 03:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="fZMSWwW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKCDsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 22:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKCDsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 22:48:16 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963AAC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 19:48:14 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t13so17405481ljk.12
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 19:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/S0PIZxjz2qkS6H00zOLlI5l9uPXalhZqZzKl7H1Ns=;
        b=fZMSWwW2ap2JGU2sgqV7IS0C8kQkeCoJe7snrwAQpq1gYWFl8v3UCFBK5vBmpw8EUP
         2JijeBFAMfCCL51Z6cWOkuLu60eQl36ZP44no+OlJOxDZVXB3Qdnvg9COT4Dfqjrg16R
         1sfwNHUkvmaDOK0KSnjnKu5+Tw0DpKHWhMbfndoyIeo7DKunF+Uv4WJl3ufL43/qJQ7C
         ZlDEAiNdfHSqxLY/Rd3df13RrcFeN5kr5RKnmX7w+wGy4dG/0q4FE7pBcySqhBop+p+D
         aofU0aWWpRL9rQ6r0Hx6xKhln/A6FsVRwf6bzundZjv9OIQRHETBIDA09FZupV6Ga7GZ
         MiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/S0PIZxjz2qkS6H00zOLlI5l9uPXalhZqZzKl7H1Ns=;
        b=Rad40OYir8RaVOO8nEG0HBhnQFgdCCTMODF5Ika4YLdR91p19tD0SL/ASyNKOlN5ye
         6JGKeccfJ8/MSbRy+rhz2jLtEIualQPq2D2BprAA65DR6WcRn+OGvSTx2JSAI506FdNG
         Ruse4BTj8cAOLYuqpxF4Plvr8efK+gZ/QL0Q20SsYBUce/6FeUjSROJXe6t+nOmsAgBi
         GVO+wjXj1Br2oK9UZ5NoW/e/1XhTwEgivf579sN3WK1u5dMo2KAcc8Pbcvs1xW8fdopp
         QlFKxPl0pU4B846XzpwIr7XpLDeFkKvAM/tsiqRSPmdWaDs/Ad/Kew8nhrC9Vh0DZRGT
         8Ilw==
X-Gm-Message-State: AOAM533kZswG2kkjjCk8sKLuaM26Ir9AXglFXofVLJKtlucRgKO7A9qi
        UEa6nyBhVX3ZbPEmyl9meuxTUoW8166D/lORcNSyjQ==
X-Google-Smtp-Source: ABdhPJyuLhlt4kQD8KrNJhPwSvkYM4X6CrwUK7GRVDefi2RBbBKnluUzBTDp2phDIcrMdvkYo2r6IVQ4PghLSdxTfp8=
X-Received: by 2002:a2e:83d0:: with SMTP id s16mr1771729ljh.22.1604375292807;
 Mon, 02 Nov 2020 19:48:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603937110.git.matheus.bernardino@usp.br>
 <2bdc13664e65a25607b8ecb4c0ea54fb2dad482c.1603937110.git.matheus.bernardino@usp.br>
 <xmqq361rv9fa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq361rv9fa.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 3 Nov 2020 00:48:01 -0300
Message-ID: <CAHd-oW5H_LLLkbhe+ffAMkpuuuGrNcOYF4sxUV55qyDomOHRug@mail.gmail.com>
Subject: Re: [PATCH v3 10/19] unpack-trees: add basic support for parallel checkout
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 4:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
[...]
> >
> > @@ -536,6 +546,9 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
> >               ca = &ca_buf;
> >       }
> >
> > +     if (!enqueue_checkout(ce, ca))
> > +             return 0;
> > +
> >       return write_entry(ce, path.buf, ca, state, 0);
>
> It it is not wrong but feels strange that paths that cannot be
> handled by parallel codepath for whatever reason are written using
> the fallback code, but the fallback actually touches the disk before
> the queued paths for parallel writeout ;-)

Yeah... I also considered having a second "sequential_checkout_item"
queue, and iterating it after the parallel-eligible entries. But I
thought that it might be better to write the ineligible entries right
away and save a little memory (especially for the regular files, for
which we would also have to hold the conversion attributes).

With that said, I ended up adding a second queue in part 2, just for
symlinks. By postponing the checkout of symlinks we can avoid the
check_leading_dirs() function and the additional lstat() calls in the
workers. This also makes it possible to create the leading directories
in parallel (in part 3) with raceproof_create_file(), which is quite
nice as it only calls stat() when open() fails. And since symlinks
probably appear in smaller numbers than regular files, this second
queue should never get too long.

> What's the reason why
> some paths cannot be handled by the new codepath again?

Submodules and symlinks are not eligible for parallel checkout mainly
because it would be hard to detect collisions when they are involved.
For symlinks, one worker could create the symlink a/b => d right
before another worker tries to open() and write() a/b/c, which would
then produce the wrong a/d/c file. And for submodules, we could have a
worker checking out a submodule S while another worker writes the
colliding regular file s/f.

As for regular files, we don't parallelize the checkout of entries
which require external filters, mainly because we cannot guarantee
that such filters are parallel-process safe. But also, the
delayed-checkout queue is incompatible with the parallel-checkout
queue (in the sense that each entry should only be present in one of
the two queues).

> Also, can a
> path that is handled by the fallback code collide with other paths
> that are handled by the parallel codepath, and what happens for
> these paths?

Yes, it can happen. But the parallel-checkout machinery should be
ready for it. There are two cases:

1. Both paths collide in the basename (e.g. a/b and a/B)
2. One path collide in the dirname (e.g. a/b and a/B/c)

For both cases, the collision will happen when trying to write the
parallel-eligible path. This happens because, for now, all paths that
are ineligible for parallel-checkout are checked out first. So, in the
first case, we will detect the collision when open() fails in
write_pc_item().

The second case is a little trickier, since [in part 1] we create the
leading directories right before enqueueing an entry for
parallel-checkout. An ineligible entry could then collide with the
dirname of an already enqueued parallel-eligible entry, removing (and
replacing) the created dirs. Also, the ineligible entry could be a
symlink, and we want to avoid the case of workers writing the entry
a/b/c at a/d/c due to a symlink in b. These collisions with the
dirname are detected when has_dirs_only_path() fails in
check_leading_dirs().

Furthermore, there is no risk that has_dirs_only_path() succeeds, but
then another entry collides with the leading directories before the
actual checkout. Because, when we start the workers, no file or
directory is ever removed.

> >  }
> >
> > diff --git a/parallel-checkout.c b/parallel-checkout.c
> > new file mode 100644
> > index 0000000000..981dbe6ff3
> > --- /dev/null
> > +++ b/parallel-checkout.c
> > @@ -0,0 +1,368 @@
> > +#include "cache.h"
> > +#include "entry.h"
> > +#include "parallel-checkout.h"
> > +#include "streaming.h"
> > +
> > +enum pc_item_status {
> > +     PC_ITEM_PENDING = 0,
> > +     PC_ITEM_WRITTEN,
> > +     /*
> > +      * The entry could not be written because there was another file
> > +      * already present in its path or leading directories. Since
> > +      * checkout_entry_ca() removes such files from the working tree before
> > +      * enqueueing the entry for parallel checkout, it means that there was
> > +      * a path collision among the entries being written.
> > +      */
> > +     PC_ITEM_COLLIDED,
> > +     PC_ITEM_FAILED,
> > +};
> > +
> > +struct parallel_checkout_item {
> > +     /* pointer to a istate->cache[] entry. Not owned by us. */
> > +     struct cache_entry *ce;
> > +     struct conv_attrs ca;
> > +     struct stat st;
> > +     enum pc_item_status status;
> > +};
> > +
> > +struct parallel_checkout {
> > +     enum pc_status status;
> > +     struct parallel_checkout_item *items;
> > +     size_t nr, alloc;
> > +};
> > +
> > +static struct parallel_checkout parallel_checkout = { 0 };
>
> Can't we let this handled by BSS by not explicitly giving an initial
> value?

Good catch, thanks.

> > +enum pc_status parallel_checkout_status(void)
> > +{
> > +     return parallel_checkout.status;
> > +}
> > +
> > +void init_parallel_checkout(void)
> > +{
> > +     if (parallel_checkout.status != PC_UNINITIALIZED)
> > +             BUG("parallel checkout already initialized");
> > +
> > +     parallel_checkout.status = PC_ACCEPTING_ENTRIES;
> > +}
> > +
> > +static void finish_parallel_checkout(void)
> > +{
> > +     if (parallel_checkout.status == PC_UNINITIALIZED)
> > +             BUG("cannot finish parallel checkout: not initialized yet");
> > +
> > +     free(parallel_checkout.items);
> > +     memset(&parallel_checkout, 0, sizeof(parallel_checkout));
> > +}
> > +
> > +static int is_eligible_for_parallel_checkout(const struct cache_entry *ce,
> > +                                          const struct conv_attrs *ca)
> > +{
> > +     enum conv_attrs_classification c;
> > +
> > +     if (!S_ISREG(ce->ce_mode))
> > +             return 0;
> > +
> > +     c = classify_conv_attrs(ca);
> > +     switch (c) {
> > +     case CA_CLASS_INCORE:
> > +             return 1;
> > +
> > +     case CA_CLASS_INCORE_FILTER:
> > +             /*
> > +              * It would be safe to allow concurrent instances of
> > +              * single-file smudge filters, like rot13, but we should not
> > +              * assume that all filters are parallel-process safe. So we
> > +              * don't allow this.
> > +              */
> > +             return 0;
> > +
> > +     case CA_CLASS_INCORE_PROCESS:
> > +             /*
> > +              * The parallel queue and the delayed queue are not compatible,
> > +              * so they must be kept completely separated. And we can't tell
> > +              * if a long-running process will delay its response without
> > +              * actually asking it to perform the filtering. Therefore, this
> > +              * type of filter is not allowed in parallel checkout.
> > +              *
> > +              * Furthermore, there should only be one instance of the
> > +              * long-running process filter as we don't know how it is
> > +              * managing its own concurrency. So, spreading the entries that
> > +              * requisite such a filter among the parallel workers would
> > +              * require a lot more inter-process communication. We would
> > +              * probably have to designate a single process to interact with
> > +              * the filter and send all the necessary data to it, for each
> > +              * entry.
> > +              */
> > +             return 0;
> > +
> > +     case CA_CLASS_STREAMABLE:
> > +             return 1;
> > +
> > +     default:
> > +             BUG("unsupported conv_attrs classification '%d'", c);
> > +     }
> > +}
>
> OK, the comments fairly clearly explain the reason for each case.
> Good.
>
> > +static int handle_results(struct checkout *state)
> > +{
> > +     int ret = 0;
> > +     size_t i;
> > +     int have_pending = 0;
> > +
> > +     /*
> > +      * We first update the successfully written entries with the collected
> > +      * stat() data, so that they can be found by mark_colliding_entries(),
> > +      * in the next loop, when necessary.
> > +      */
> > +     for (i = 0; i < parallel_checkout.nr; ++i) {
>
> We encourage post_increment++ when there is no particular reason to
> do otherwise in this codebase (I won't repeat in the remainder of
> this review).

OK, I will fix the pre-increments, thanks.

> > +static int reset_fd(int fd, const char *path)
> > +{
> > +     if (lseek(fd, 0, SEEK_SET) != 0)
> > +             return error_errno("failed to rewind descriptor of %s", path);
> > +     if (ftruncate(fd, 0))
> > +             return error_errno("failed to truncate file %s", path);
> > +     return 0;
> > +}
>
> This is in the error codepath when streaming fails, and we'll later
> attempt the normal "read object in-core, write it out" codepath, but
> is it enough to just ftruncate() it?  I am wondering why it is OK
> not to unlink() the failed one---is it the caller who is responsible
> for opening the file descriptor to write to, and at the layer of the
> caller of this helper there is no way to re-open it, or something
> like that?

Right. We also avoid unlinking the failed one to keep the invariant
that the first worker to successfully open(O_CREAT | O_EXCL) a file
has the "ownership" for that path. So other workers that try to open
the same path will know that there is a collision and can immediately
abort checking out their entry.

>         ... /me looks ahead and it seems the answer is "yes".
>
> > +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
> > +                            const char *path)
> > ...
> > +     if (filter) {
> > +             if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
> > +                     /* On error, reset fd to try writing without streaming */
> > +                     if (reset_fd(fd, path))
> > +                             return -1;
> > +             } else {
> > +                     return 0;
> > +             }
> > +     }
> > +
> > +     new_blob = read_blob_entry(pc_item->ce, &size);
> > ...
> > +     wrote = write_in_full(fd, new_blob, size);
>
> > +static int check_leading_dirs(const char *path, int len, int prefix_len)
> > +{
> > +     const char *slash = path + len;
> > +
> > +     while (slash > path && *slash != '/')
> > +             slash--;
>
> It is kind of surprising that we do not give us an easy-to-use
> helper to find the separtor between dirname and basename.  If there
> were, we do not even need this helper function with an unclear name
> (i.e. "check" does not mean much to those who are trying to
> understand the caller---"leading directories are checked for
> what???" will be their question).
>
> Perhaps create or find such a helper to remove this function and use
> has_dirs_only_path() directly in the caller?

OK, I'll look into it. It would be better if we can reuse an already
present helper, since this call to has_dirs_only_path() will be
removed in part 2.

> > +     return has_dirs_only_path(path, slash - path, prefix_len);
> > +}
>
> > +static void write_pc_item(struct parallel_checkout_item *pc_item,
> > +                       struct checkout *state)
> > +{
> > +     unsigned int mode = (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
> > +     int fd = -1, fstat_done = 0;
> > +     struct strbuf path = STRBUF_INIT;
> > +
> > +     strbuf_add(&path, state->base_dir, state->base_dir_len);
> > +     strbuf_add(&path, pc_item->ce->name, pc_item->ce->ce_namelen);
> > +
> > +     /*
> > +      * At this point, leading dirs should have already been created. But if
> > +      * a symlink being checked out has collided with one of the dirs, due to
> > +      * file system folding rules, it's possible that the dirs are no longer
>
> Is "file system folding rule" clear to readers of the code after
> this patch lands?  It isn't at least to me.

OK, I will rephrase this paragraph to make it clearer.
