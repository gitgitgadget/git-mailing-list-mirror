Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD616C64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B38320725
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 14:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXENwOv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgK3O4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgK3O4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 09:56:49 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B96C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:56:09 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id m62so6448431vsd.3
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HXVfP4Y76rU0Aug30Y/qKy5GYl2DQt7dptkdehAzvQo=;
        b=gXENwOv6lUpcbpwOAHUOjhiwXU2mFlK+DNwWtIa8ADJpTwZ+Y6D6Q40ueMa6WYAp8r
         I1fxf86D5F+K0WSVwH1ugjHc2ywYpY7aE1huZaOyUgWYfvSPlHUL/8fUuoHkpCbVwL3w
         5a5tE2Gb03bkc6iTZYh1+jEmRHlKWuhD256VQLDlHLplHBZECFmnbcH++WJF7Lx9Pqv5
         QsiWcC/kgsKeENrMihoRxYT39nq7ESwmOwKtNSZaxJQkg3EP/3UPuXFm0FqsPyvJ7V3T
         OKq9kOk3V3hLNt3/vQ0uI2nUQ9vvGKYKQNNI5FlSq3Dtixs7DN0ylRCxXsgMiThhaMxl
         tKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HXVfP4Y76rU0Aug30Y/qKy5GYl2DQt7dptkdehAzvQo=;
        b=ehMesgHpSRkZegjqBhbFVpwrQYDB7PVuMlLc2kwkeDfXD/HimD8Pfgl2ywIy/pe5W2
         u7j32mBkFIBWBo15/HIB0HA9CD/HnpLajialt0szfG0QeBd8JcvJ3LgEwrDlRgdmofrL
         VOgN8q5rZ/Xa5ywfmFL7AYWDZL6aCtlGgMWSU1foIX4MRytldiH1Ln13zLWQg8jXnr9D
         MpRV4zpMXkaYRF0WFzNNxwLmPaDzwbK1m6N/7myRT4tT6yVKeZQ4aQ2+LNuwCospPFtA
         uYNzds7AmbRDRK6F1d8s1OejtL2gIi611onTiPSuzP+EWyCoYFqOX1nHzAqNkfwZT6uw
         vT4w==
X-Gm-Message-State: AOAM533q0olW+S8kvmQuNf0U2u9BZ+cRQYxg+n5k3uxAfo5Dy8S6PeDo
        dmkeWh9R7+jrOhCTaMgwV83u1Ezcd0U9hJVPmb+lalJX9Ak=
X-Google-Smtp-Source: ABdhPJzHN5moboIauytrtaUrQtGhAOX7gFFzZG56lrSuXLgBg0t3NsV0tRhib3voYqE7KpHJ4WKd11X65ujoZAXTUA4=
X-Received: by 2002:a05:6102:154:: with SMTP id a20mr15518114vsr.50.1606748168436;
 Mon, 30 Nov 2020 06:56:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <5d1b946ab5473504e9599d90c0feda407a179a05.1601568663.git.gitgitgadget@gmail.com>
 <20201002035851.GB3252492@google.com> <CAFQ2z_NU_hBF2Gz4yFK+Q-KreBQONeMF+pJYESp7hVnKCWvmDg@mail.gmail.com>
 <20201012165730.GC3740546@google.com>
In-Reply-To: <20201012165730.GC3740546@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Nov 2020 15:55:57 +0100
Message-ID: <CAFQ2z_PNn499nxv5h-_Q6bzR15S6e8CaFxoR+yL6DJkTj6=bgA@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] reftable: define the public API
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 12, 2020 at 6:57 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > We could, but it would considerably complicate work on this patch
> > series, as the commit boundary then doesn't fall on file boundaries
> > anymore. Would you be open to having multiple headers for the public
> > interface? eg. reftable-record.h, reftable-reader.h etc. ?
>
> I'd be more than open to it: I think that would make for a clearer API.

Done.

> >> Should these call BUG()?  Or is it useful for some callers to be able
> >> to recover from these errors?
> >
> > Since this was written as a standalone library, it's up to the caller
> > to decide what should be done.
>
> I'm not strongly opinionated about this, but just a quick note: this
> implies that the library would need to make sure it is producing a
> valid state in error cases.

This is what it already does. I tried to clarify this in some places.

> Does the API documentation describe what state a handle is in after
> an error --- e.g., what operations are permitted after that?

API_ERROR should not result in state changes.

> >>> +int reftable_error_to_errno(int err);
> >>
> >> What is the intended use of this function?
> >
> > The read_raw_ref method in the ref backend API uses errno values as
> > out-of-band communication mechanism.
>
> Could we change that?  It sounds error-prone.

I moved it into refs/reftable-backend.c; I'd rather not also have to
clean up the files backend as part of this work, though.

> >> Do I pass in the 'struct block_source *' as the source arg?  If so, wh=
y
> >> are these declared as void *?
> >
> > you pass in block_source->arg. Should struct implementations of
> > polymorphic types carry a pointer to their own vtable instead?
>
> I think a pointer to block_source would make it more self-explanatory,
> yes.

This has a number of downsides, though. It means I have to introduce
separate structs strbuf_blocksource and file_blocksource, along with
functions to create and deallocate them, so it makes the whole thing
more unwieldy to use.

> >> Is the reason this manages the buffer instead of requiring a
> >> caller-supplied buffer to support zero-copy?
> >
> > Log blocks are compressed, so the caller doesn't know the correct size
> > to supply. By letting the block source handle the management, we can
> > swap out the block read from the file for a block managed by malloc on
> > decompressing a log block.
>
> Hm, my naive assumption would have been that we'd use different
> buffers for the compressed and uncompressed data.

Maybe you can comment on how to solve this differently when we get to
the implementation of block reading/writing in the commit series.

> >>> + Generic tables
> >>> +
> >>> + A unified API for reading tables, either merged tables, or single r=
eaders.
> >>
> >> Are there callers/helpers that don't know whether they want one or the
> >> other?
> >
> > The setup with per-worktree refs means that there are two reftable
> > stacks in a .git repo. In order to iterate over the entire ref space,
> > you have to merge two merged tables, but the stack itslef merges a set
> > of simple reftables.
>
> I see.  That's subtle, so it seems worth documenting for the next
> person reading this documentation and wondering why.

Done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
