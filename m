Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB71FC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 15:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbiAXPuy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 10:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiAXPuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 10:50:52 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB80C061401
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 07:50:52 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id n15so30244834uaq.5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58vAy2BMEVfxMekSbESJCQH1s6cQaqO7P0Ca1miSjWI=;
        b=mFBj4xttZaPQ2ZzzpLWrbHHF7jSX8XhO7oWEfKsSODj+w9rSUXtIwEGp1pL70nYI3x
         2N+K0vCtUApH/W6CoEVWhtH7yIgs0nB9AlfM0ytdM8ZxfcJmP8STQ3Pi61uWqBDrLS2X
         kvfDIePkK3UbRHS8BUY01S1sRzljbl6Rx5CQAzR2eCUL6ZuklutQfk8XGc1VaV29zmQS
         ZIe8/CRVR92RuOeqy7vQ9gTB9xCoWxJZvycqw/+YB6piDPmIEQfCSRPjnv+sLKFUNAVA
         G/4hF8Vy9e8+IXdVHmNEDaQifM1hyjeoDUiOZpfrnPjs4eLROskf+E1W3EoHA4C2EMtj
         S5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58vAy2BMEVfxMekSbESJCQH1s6cQaqO7P0Ca1miSjWI=;
        b=D1p78HBIHlx0kuLa+xHXIas6cUVLTTXQ2s/SGo1mvX7hu9FuyvmzgARcnhVO2/EmkI
         M2/lRlKrTKzXSQDSOVIy//OjBR7K0/7O0/GVtF8KmBEk9v7vgkB28/HnVrO/7WATV9cL
         /hYuhXAhatEDtutWQxLQRzRzaL7v+Wl/mWLS8SJeAAbP6wcosy2l2QnclkxmKJ0X1DZo
         8/sVNL93ikWk8pUVkMUnS0ojVjqOkRS6uOrq+RbMa7UQBNYTEqBh1BaFNjNpqtw2eexG
         oZRfhOK4hyF+1mjZr6kSIZmd/dKk720Q5jES1laQs2r9m3mAWjnv1Iql56nkcIlUIbeF
         x0+g==
X-Gm-Message-State: AOAM530akxu2wWENGtMg/akQsmeSjA/NzaoJDTOaucJLAk5bqOdyVIus
        NCOm2YZqMR6ZKGNbAT9oscSUcHMscuGz8JlyrLT6jg==
X-Google-Smtp-Source: ABdhPJx36egHLgDuG633I6L8oBqPNsppCGfJw1jk4lRxNNnF2sUdO9M5ffRkYwodv1DQLCLWq2NZC0LLAvnAwS2aekY=
X-Received: by 2002:ab0:4888:: with SMTP id x8mr5701485uac.55.1643039451381;
 Mon, 24 Jan 2022 07:50:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
 <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com> <82f140cab5c30b59de534d773a5d00343e0868f9.1642691534.git.gitgitgadget@gmail.com>
 <220121.86bl05jm8o.gmgdl@evledraar.gmail.com>
In-Reply-To: <220121.86bl05jm8o.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 24 Jan 2022 16:50:39 +0100
Message-ID: <CAFQ2z_OsEM3jOs7O5K-bGT3RqidppSzR1NuzeFEJ8_se+Cx6gg@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] reftable: add print functions to the record types
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 21, 2022 at 1:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > +static void reftable_index_record_print(const void *rec, int hash_size=
)
> > +{
> > +     const struct reftable_index_record *idx =3D rec;
> > +     /* TODO: escape null chars? */
>
> That's quite scary as a TODO comment, can we think about whether we're
> doing the wrong thing here? I.e. the printf() will stop on a \0, or
> maybe I'm misunderstanding this...

It's a print function, so we'd print a truncated last_key. This can
happen if we were printing an index record that points to a log
record. I'd address this if and when I have to debug into indexing
going wrong (which hasn't happened so far.)


> >       /* Are two records equal? This assumes they have the same type. R=
eturns 0 for non-equal. */
> >       int (*equal)(const void *a, const void *b, int hash_size);
> > +
> > +     /* Print on stdout, for debugging. */
>
> Inaccurate comment, this isn't for ad-hoc debugging, we're using this in
> the reftable tests....

The tests say

> > +     puts("testing print coverage:\n");
> > +     reftable_record_print(&copy, GIT_SHA1_RAWSZ);

ie. I'm calling the print functions to make sure they don't crash or
leak memory. They're not used as part of functionality of either the
reftable code or its tests.

> > +                                     .old_hash =3D reftable_malloc(GIT=
_SHA1_RAWSZ),
> > +                                     .new_hash =3D reftable_malloc(GIT=
_SHA1_RAWSZ),
> > +                                     /* rest of fields left empty. */
>
> But in test_reftable_log_record_roundtrip() we have another existing
> user who leaves out fields, but doesn't have such a comment.

rephrased comment.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
