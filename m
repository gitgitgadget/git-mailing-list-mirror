Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B682C43217
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4F06101A
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhI1MVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbhI1MUx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 08:20:53 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1DC061740
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:19:14 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f18so21852873vsp.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OR8eFFFggAiG6XOTwPGJ7EZG4B5oy+KEBQ4sTtdVTIY=;
        b=pQzV+B09wenzFRWc7+32d2pF8ed7ETe52TJrzDpxwCmVsHuMlHZ+BO/xUAPa7NMYKR
         i7/gCDnWMq9bdofVVfoPodzQ2LB/ifJbNr3KGr3KzcQ53VUbbmZWE4ByLKZG78WE2btg
         mKZHwLnM7YWkcQJeyPBJ//1v251w1MNCH3VSNC6SydL5dJcP6A2JltJwzaWg3UCVB/Dm
         f09VgnH9XESK+b/HCuRUoeeK09fE1coHNJ2C8ggqXmsePOkBDw7X8jx3O39nDCJhTifV
         H2rRRb0whwXKTdSO96DnV5wMnJrei6S/DSIBhsMvzyMBXD+2J2hhAgfWS+MXYDvhMYYe
         xFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OR8eFFFggAiG6XOTwPGJ7EZG4B5oy+KEBQ4sTtdVTIY=;
        b=1dRxvH+brSdcCNn0JskR5PKzk6GS9GndUSVLOHikcLN8XmJvLJxiGM2qSmrYCAOZCj
         8QTXCjvBFF9ZZIm6ZpRWQRRwa3Js7xFtHb3O7XFi/PXURrhZvEXBO7Zn5yeHN0PdDGlj
         xg77ckt8tuXt5MMkmBYVzsUWbJdtTIZ4vrtFqHK5NsyIUfpnE2p8S2/NtvN54B/FEoR9
         tvXge56LVdyTbO8Asj9DKMu8MTiB4sQmlJ3f6CmUd1kaIZIbV4VW4apwRitJlvDSx2mH
         U0GXEaY/0vLH4joSY3AlzmAnPcfwdZ89MlojO/OqHVUUvhaGz+imjnUgLMXAS3SAPNGj
         Qfyw==
X-Gm-Message-State: AOAM532r6+/5SBjkDQP17h5URk0JgfcwZa6egGRoGUtIAJfe2dsJZVLv
        8NYLGxY2UHa6IRo16pZS/TTqH3C9tR4+rI9WV9yvlA==
X-Google-Smtp-Source: ABdhPJwqD6Q6CnbazkGpR8lvFRiAoh673Jlq6nSXEaEui3FAk4OilSSHKrU+z7B272OOkm8Sgxqx3mm/hcWK/L+Ikn4=
X-Received: by 2002:a05:6102:2252:: with SMTP id e18mr618463vsb.7.1632831552597;
 Tue, 28 Sep 2021 05:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <871r59xfgk.fsf@evledraar.gmail.com>
In-Reply-To: <871r59xfgk.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 Sep 2021 14:18:59 +0200
Message-ID: <CAFQ2z_NxqLVfSWNtcXdyWQsTXrTrWGq7Qof=wdx9mmeqOAJS_Q@mail.gmail.com>
Subject: Re: hn/reftable (Re: What's cooking in git.git (Sep 2021, #08; Mon, 27))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 10:38 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > * hn/reftable (2021-09-10) 20 commits
> >  - fixup! reftable: implement stack, a mutable database of reftable fil=
es.
> >  - Add "test-tool dump-reftable" command.
> >  - reftable: add dump utility
> >  - reftable: implement stack, a mutable database of reftable files.
> >  - reftable: implement refname validation
> >  - reftable: add merged table view
> >  - reftable: add a heap-based priority queue for reftable records
> >  - reftable: reftable file level tests
> >  - reftable: read reftable files
> >  - reftable: generic interface to tables
> >  - reftable: write reftable files
> >  - reftable: a generic binary tree implementation
> >  - reftable: reading/writing blocks
> >  - Provide zlib's uncompress2 from compat/zlib-compat.c
> >  - reftable: (de)serialization for the polymorphic record type.
> >  - reftable: add blocksource, an abstraction for random access reads
> >  - reftable: utility functions
> >  - reftable: add error related functionality
> >  - reftable: RFC: add LICENSE
> >  - hash.h: provide constants for the hash IDs
> >
> >  The "reftable" backend for the refs API, without integrating into
> >  the refs subsystem.
> >
> >  Will merge to 'next'?
>
> I think we've reached approximately "good enough" with this for the next
> steps, and can hopefully fix any remaining nits (such as my [1])
> post-merge.

There is still an RFC in 02/19. Maybe we can get agreement that this
is OK and drop the RFC ?

> Maybe hold off until Han-Wen gets a chance to ack it, and whether he's
> ok with the proposed fixup(s)?

regarding uncompress2: I thought it was functionality best left to
zlib to implement, but I imagine git.git offers something similar.
Sounds good to use that.

> Wasn't there an outstanding "some of this in reftable/* should be static
> functions" from someone, Carlo? (CC'd). In any case that sort of thing
> could also be a post-cleanup, I couldn't find a reference to that
> discussion in anything except my vague memory of it as I wrote this.

I think I have addressed all outstanding issues in my github PR, and
I'll send it out once I see CI pass.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
