Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A4C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0960F9B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 10:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhIMKQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbhIMKQC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 06:16:02 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55CC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 03:14:47 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f18so2862246vsp.2
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 03:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kv9ZBB8nMMTXMMEm5iOyaUe2ZUg1iG4OgUUl2AiCgQ4=;
        b=Gx+0J7M2yTm1P6pZPBGAFWOXquZCLVp6GsiUQ2bhQ+R33/qteOM3b88M4T/ZRDrpeW
         CM+Odw/nLvXR5Tqa4kD+hK516Zs8vVwywkIXb5/CgkpIDJKURAOgxkVhO/S1j14cWCIT
         hXtVcg7w6TE0CNGyLbcRGsTzI0GEhlV+6LTOGIGv69tUNMDRq0w6N9rNBrEIAPfOcJGM
         yC0RgeRbBGB9yXzVlGh/xd+Dca0aE84uaE8cea2HA06tvuhlUlwK9nVRULia12cbp/v2
         1FIkvqFdRcY/SAmTfe4XDwCT9D+7Hk60uA0iLxMfOEEt3SWCeoC/+SReRFa9MOc9k6Ir
         EnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kv9ZBB8nMMTXMMEm5iOyaUe2ZUg1iG4OgUUl2AiCgQ4=;
        b=CLnIt6LKo3fuurD/pYzj0Z6o9jAcybB3XCnzYRFECEJFYjwDa2+j05AIeJUFA1Lxr+
         JbtfwSQQ4HvjAS22edUB+5tqgOSRwl+KM1GXEL/7I3ueVkLzULqc3zCVJwnBqR7MPCW3
         70DCFHRUlus0ns24H9JOyv7MQknmuIEM4iOHORMLzSUqcUQnSI++dvKJ1k6h+VAgFu6h
         o/kdVtR1PYopRYeJsJo40cs7n4REiCNof2zUdrj5jNi3X6nJrGBJJEv3MIY1uzwtl1Xp
         gcTd72L3AC9+1QHYD01vyuEDrQzK/JBuuE6U8Nf4lAXDGI0dNf3UCVe57yLFrS5C3KP2
         sbiQ==
X-Gm-Message-State: AOAM531CQCkuqeOfp63UEMk5kfo+x9R5rYmof9s41dEpt4Cy+2N2n0we
        AUrsp0aJAoYnlDm27r1Wpd1LGtf9IA9IzWAj7U80LA==
X-Google-Smtp-Source: ABdhPJxa55XeW6lh1nDS/HHVlO/ECyJyXkCKkJpz6nM6lewvj63ZzM3ke0MJElQ6r3aIxahkWhewWI4pRI01Ob7+H3s=
X-Received: by 2002:a05:6102:9d5:: with SMTP id g21mr4287573vsi.11.1631528086232;
 Mon, 13 Sep 2021 03:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
 <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com> <xmqq7dfpxzfw.fsf@gitster.g>
In-Reply-To: <xmqq7dfpxzfw.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 13 Sep 2021 12:14:34 +0200
Message-ID: <CAFQ2z_Pa+KmCYV224XwMXO1iFCNA=PXj5iKaQU3LYGYTK_+qsw@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 10:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > The reftable format is described in Documentation/technical/reftable.tx=
t.
> >
> > This is a fully reentrant implementation of reading and writing the ref=
table
> > file format, and should be suitable for embedding in libgit2 too. It do=
es
> > not hook the code up to git to function as a ref storage backend yet.
>
> Not a question for Han-Wen, but I am wondering how much style and
> other consistency guidelines we have in our C code to the files in
> this directory.

I am Han-Wen, but I'm not sure what you are saying here.

> I am guessing that rules like "no decl after statement" and "no decl
> in the set-up part of the for loop control" (i.e. "for (int i =3D 0;
> ..."  is a no-no) should apply equally to this code, but it might be
> OK to deviate from rules that are only meant to help human readers [*]
> without affecting compilation.
>
> Opinions?

The code has a different style because I wrote it separately from Git.
I'm not wedded to its current style, and most styling can easily be
changed. If you have specific things that should be addressed, let me
know.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
