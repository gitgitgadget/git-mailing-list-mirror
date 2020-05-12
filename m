Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D135DCA90AF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A527206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kK0RhTh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgELQsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgELQso (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:48:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1BC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:48:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l17so2793008wrr.4
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F4BD8HCW4aBzsrBUKnLBcbXSsOnRUnKMv/C8H3S9s2A=;
        b=kK0RhTh9cgxo7zoT0ntwFmCDtKN6qwkwvCqao404jieTvT2DxZS9eMWPyQ7YDMcb1w
         UHOn1rFsO3waOo3D8YY7NU5FWyyLrmfE0MuKbXHnhwEw4MCb05FSDREA7vtLDX88pjzf
         ABjwTc1rEVHQsPsY9DvdWbUa7ALO3LGCEHQocoYolF5WQIiQ5NEEmYLCFR3FN+wpXVex
         CQtQgvEat7pMpnl0syn3xtQUbayin/wMXaRi9k17yhx6RsCHt4pQSjuAfFSQKBhJ9xt+
         7jxjqcPYcA6QG9wUP3EcqHv4zjvryfw+AKaEn/ehj4j6rLHhGpmGZxtmvBIYiwhvOfXK
         01aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F4BD8HCW4aBzsrBUKnLBcbXSsOnRUnKMv/C8H3S9s2A=;
        b=EZzjtvnXy5wEgR8Hs3RE68tiZDF1rfGI0jbzDQjj5H8kqvoB4J1bqTpHhyxTDHgPPB
         nLkBnpoBOHcjqLtsOcsGZYhGUpsv23tr/Bbrq6Lz+Kzbgq7vA8bxk1lE/Jkd+bmlOSqA
         gVet0xmvqvOe+mFQ4QJhbPq5hXBGppPZcLeq4J1ZuyQrC7I0EksiGTT4NB8Kq0vIKtdd
         XiXghABZzFUsdnEkqSr9dlkkz1/uj+2GUhts5sqiLNrEsyev/eD9S/4yosgxgA+FmL6y
         emdMvtxRVqma0SL+SpxSYaPl4MTEWnOxXRqHH4OVvQlWfQp2uzI8TkYXS4miak9trUEe
         37zQ==
X-Gm-Message-State: AOAM530pBCs1NW5MlKXtJjUYpCASJ1cwc3kZxqugUMrBMqveE55PTzZR
        sGdNiCFsIr2Ohi9+n3vv0LeuYFmnMHN9oCvBmWPE1cGXaUM=
X-Google-Smtp-Source: ABdhPJzOPzEnXbDEwXbFJx5s2cQw45uuWkXBfSBgoi+4ucEcmn1ZQjFdSK8Y66jOqZheuDtq8J3XB/hbE+c6VxmvCf8=
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr5808558wrh.219.1589302122985;
 Tue, 12 May 2020 09:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <2c2f94ddc0e77c8c70041a2a736e3a56698f058c.1589226388.git.gitgitgadget@gmail.com>
 <cd06245f-4717-3695-9550-0d8c4244725a@gmail.com>
In-Reply-To: <cd06245f-4717-3695-9550-0d8c4244725a@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 12 May 2020 18:48:30 +0200
Message-ID: <CAFQ2z_Ptuu14G-UOVfDnGsG6-EwUH-XdBp8HTw_zuHML5aMsQA@mail.gmail.com>
Subject: Re: [PATCH v13 07/13] Write pseudorefs through ref backends.
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 12:22 PM Phillip Wood <phillip.wood123@gmail.com> w=
rote:
> >       if (ref_type(refname) =3D=3D REF_TYPE_PSEUDOREF) {
> > -             assert(refs =3D=3D get_main_ref_store(the_repository));
>
> I don't think you meant to delete this line, the equivalent line is left
> untouched in the next hunk and there are comments in refs.h saying this
> should only me called on the main repository

yep. - Whoops. Fixed.

> > -struct ref_storage_be refs_be_files =3D {
> > -     NULL,
> > -     "files",
> > +struct ref_storage_be refs_be_files =3D { NULL,
> > +                                     "files",
> > +                                     files_ref_store_create,

> The formatting has gone haywire

This was clang-format's automatic reformatting. I've looked a bit
closer, and it was reformatting because the initializer list was
missing the ',' on the final entry. I've added that now.

> > +     NULL, NULL,
>
> Should the wrappers above that invoke these virtual functions check they
> are non-null before dereferencing them? It would be better to die with
> BUG() than segfault.

Done.

> I think this patch basically works but I'm concerned by the potential
> NULL pointer dereference. While it's unfair to judge a patch by it's
> formatting the changes to the formatting of existing code and the
> dropped assertion rightly or wrongly gave me the impression lack of
> attention which does make me concerned that there are other more serious
> unintentional changes in the rest of the series.

I prefer leaving formatting up to automated tooling. They're better at
following mechanical rules precisely.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
