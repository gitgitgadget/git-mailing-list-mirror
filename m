Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33130C4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58AF207C4
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 20:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/kXQe+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgIYUdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgIYUUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 16:20:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F56C0613B9
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:53:16 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id k2so2813402ybp.7
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A40Dp7ItMw6sO6daK51eOsrZZN6rgHRdhPaKPl0bxKg=;
        b=L/kXQe+eyadbywdPpD1c/UFkQs+R/jxTJcXldpgXZSoz9KfZ/HGMNoSMZZXeFT3OVZ
         StgDkryg883rbkuiFDPHPzFo7oCQ7OZpq8/Kk3FLXoehiMwd9ksZemZvF8TD8AfbLjB9
         gEJkvakq4wONXWEiYGHiJR9WjgEVTvljSFr4v1EKMh/E2y3sGg71Y+xs+Ua80WNVuMwD
         miINd3kajl0b0AHJRLLaZ5wNNLnHucwSeAOVPD/PxK2mHWElPfftJnYozhTiPeFstk22
         da0MOCxjRuzYIDdktCAk+TjzBKNZJ+kDP0FHxdptIlTKwVngxHgpuma9ieGYgAVAADVM
         Z1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A40Dp7ItMw6sO6daK51eOsrZZN6rgHRdhPaKPl0bxKg=;
        b=DJNkuQD20S42KmQuDISwmwLMMulxny76GNkhONefpzGlhJoQZLqSi0bDrfrTJN4d7a
         qvNfndcwVAxHuSD1TPHY/q4KfQ8DxG/Rn4X11ZiJIPmpQ98vlyn2hfYIxN4fypuUOmk/
         rVPkp2n5AoN/po9bFw3b2Ad3FiFHxj2L9vVXegJgYRMCrmaenF0CNTCyQPCqxwzYKwAv
         ZALo0l1bV5jLEjflKv1OOQpmNn8yX/0754nTOdPHKdUgKzy+8+jPDVJ1ZEvcDgS/HFmh
         jyYfSrVzl1eO+8yw9yGbsmKqcuxpKPVM7xEzT9RH5PTPA9sVSBPw3xELFOvSRqr4dvRf
         06qg==
X-Gm-Message-State: AOAM532/2p/xnaOzZ/8L8YIKTcGJOgVyklVQ+P9S2cfBZ+boqr+VXTsM
        AixRRG/u1grAcA4V/tn242YBNO2Kvkfwcxr5DfA=
X-Google-Smtp-Source: ABdhPJzLjubQP56/vF2sxRrxUMnfEAerY2hDKspHkPmODfRGI1w6cbOKJYGsQhrU6u8rTPfnv0dkKF232iJHj+uApts=
X-Received: by 2002:a25:6116:: with SMTP id v22mr1259836ybb.272.1601063595263;
 Fri, 25 Sep 2020 12:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABURp0r_VPNeU5ugbJDQo=hV_aOit7W-pf9nhDF9Og=vVJG8tw@mail.gmail.com>
 <20200925055258.79347-1-matheus.bernardino@usp.br>
In-Reply-To: <20200925055258.79347-1-matheus.bernardino@usp.br>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 25 Sep 2020 12:53:03 -0700
Message-ID: <CABURp0puC324750dZUpeXBricWizy9Ldaz_=JzdvdOkUp8V4pA@mail.gmail.com>
Subject: Re: RFC - concurrency causes segfault in git grep since 2.26.0
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Derrick Stolee <dstolee@microsoft.com>, Git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

Thanks for the quick response.

On Thu, Sep 24, 2020 at 10:53 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Hi, Phil
>
> Thanks for the bug report and for the crash logs.
>
> On Thu, Sep 24, 2020 at 11:36 PM Phil Hord <phil.hord@gmail.com> wrote:
> >
> > Hi list.  It's been a while.
> >
> > I can reliably reproduce a segfault in git grep when searching the
> > object DB. It is caused by a race when threads > 2.
> >
> > I have a patch that fixes the problem, but I don't know exactly why.
> > Can someone else explain it and/or offer a better solution?
> >
> > ====
> >
> > diff --git packfile.c packfile.c
> > index e69012e7f2..52b7b54aeb 100644
> > --- packfile.c
> > +++ packfile.c
> > @@ -1812,7 +1812,9 @@ void *unpack_entry(struct repository *r, struct
> > packed_git *p, off_t obj_offset,
> >                 if (!base)
> >                         continue;
> >
> > +               obj_read_lock();
> >                 delta_data = unpack_compressed_entry(p, &w_curs,
> > curpos, delta_size);
> > +               obj_read_unlock();
> >
> >                 if (!delta_data) {
> >                         error("failed to unpack compressed delta "
> >
> > ====
>
> Hmm, obj_read_mutex is a recursive lock, so by adding the
> obj_read_lock() call here, we are incrementing the lock value to [at
> least] 2 (because oid_object_info_extended() had already incremented
> once). Therefore, when unpack_compressed_entry() calls obj_read_unlock()
> before inflating the entry, the lock is not actually released, only
> decremented. So the effect of this change is that the phase III of
> unpack_entry() is performed entirely without releasing the lock.

Ah, there's the piece I was missing.  I didn't realize we temporarily
drop the lock inside unpack_compressed_entry.  And obviously I also
didn't notice that we were already holding a lock before entering
unpack_entry.  Thanks for the detailed explanation.

> Your crash log shows us that the segfault happened when trying to
> memcpy() the string `base` (in unpack_entry()). I.e., the same string
> that we had previously added to the delta base cache, right before
> calling unpack_compressed_entry() and releasing the lock. The
> problematic sequence is:
>         add `base` to the cache -> release lock -> inflate ->
>         acquire lock -> try to use `base`
>
> Maybe, when a thread X releases the lock to perform decompression,
> thread Y acquires the lock and tries to add another base to the cache.
> The cache is full, so Y has to remove entries, and it ends up free()'ing
> the base that was just inserted by X. Later, X tries to dereference
> `base` in patch_entry(), which would cause a segfault. It would also
> explain why your change solves the segfault.
>
> I'm not sure, though, why this entry would be removed, since it was just
> added... Maybe Y was adding a huge base to the cache, which required
> removing all entries?

I think your theory is correct here on both counts.  The repo I am
searching has some sinfully large objects, and when there is a cache
limit, they are likely to exceed it.

> Anyways, you mentioned you can reproduce the failure quite reliably in your
> repo with 20 threads, right? Could you please check with the following patch
> applied? It adds a `base` copy to the cache instead of the original string,
> allowing us to keep running decompression in parallel but without the risk of
> having another thread free()'ing `base` in the mean time.


Yes, your patch reliably solves the problem, too.  The performance is
only slightly improved over holding the lock during inflate in my
case, but it does save a bit of time.  Surprisingly, performance seems
to peak between 5 and 10 threads for me in both cases.  It reliably
gets slightly worse at 20 threads and 40 threads.

In all cases when threads > 2, this search appears to be 10%-20%
slower than running without this change.  Even when threads=1, though,
the result is about 10% slower.  Perhaps it is worth avoiding the
base_dup when !!obj_read_use_lock.

> diff --git a/packfile.c b/packfile.c
> index 9ef27508f2..79f83b6034 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -1772,14 +1772,15 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>         while (delta_stack_nr) {
>                 void *delta_data;
>                 void *base = data;
> -               void *external_base = NULL;
>                 unsigned long delta_size, base_size = size;
>                 int i;
>
>                 data = NULL;
>
> -               if (base)
> -                       add_delta_base_cache(p, obj_offset, base, base_size, type);
> +               if (base) {
> +                       char *base_dup = memcpy(xmalloc(base_size), base, base_size);
> +                       add_delta_base_cache(p, obj_offset, base_dup, base_size, type);
> +               }
>
>                 if (!base) {
>                         /*
> @@ -1799,7 +1800,6 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>                                       p->pack_name);
>                                 mark_bad_packed_object(p, base_oid.hash);
>                                 base = read_object(r, &base_oid, &type, &base_size);
> -                               external_base = base;
>                         }
>                 }
>
> @@ -1818,7 +1818,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>                               "at offset %"PRIuMAX" from %s",
>                               (uintmax_t)curpos, p->pack_name);
>                         data = NULL;
> -                       free(external_base);
> +                       free(base);
>                         continue;
>                 }
>
> @@ -1838,7 +1838,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
>                         error("failed to apply delta");
>
>                 free(delta_data);
> -               free(external_base);
> +               free(base);
>         }
>
>         if (final_type)
> --
