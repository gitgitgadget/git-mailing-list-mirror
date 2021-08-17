Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C7C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B6960FA0
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhHQNpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhHQNpC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:45:02 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6401C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:44:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j12-20020a05600c1c0c00b002e6d80c902dso2179207wms.4
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aVzSXDkKJrg56FJuW3OWgfjeNQuPokNpRVKVaz2IdHc=;
        b=mQIypIxFFfJbI3SF8Eh68ximg7+aWcR81IL29PKLNME63EycqmYicVzoVVsyVwquFG
         rtIfydvxkGRVoIuFhmLypexmabN303Hp0SqURqjAx1EudnghnEUFbS5tB2qbgoVJ+k9r
         WCWfSXjc16W6DW+Vngm9gFQyFF7snBOEP0xgJxHStHRiBGhu6KHf+vVUHPhSbbqG73Or
         +FFYHzw/z9fFpxGmuGRhnezuRFA6pxw0UvIFhR5RKdhjd+EGChsDseATJzFMtLFe/8M+
         HzcFQLZGi6uYaDnsCER5XJ02QndJ7aBStljnwwsqZ1EH1wDNjIZRO4FYJUW3RVJ8bCGN
         lNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aVzSXDkKJrg56FJuW3OWgfjeNQuPokNpRVKVaz2IdHc=;
        b=D3r4YtJFzPlIVu5YaofFaTjUos6Ltiz075DEl33yXUFJwOnCLt8v9epvcL9smaI2n+
         FnwzCQWMOyX7Pbxm39KdIMCl5i+a02TkN/8GBNmKUJGgVm/eoMmQvDLxdphcA21tObwO
         DNoHZrf5smrAqEnXPt5S2KPX/RDbMaEe6+7kBtQmr21bUIzpEuD6kEFmxAK9Q6/iXa38
         PHHQ9kNBeniZgE6Uj7Vyz7AdtT4FwPAg4In4GrN/AKef4eOcTfPlEz2pt8qYfD/GVhHA
         UoMGbWMWLLyTG+sS9af4/ilRXRPHZWvgixUfchwbxy3lzi9ZL+cXo9B1xsg8Q94nb2Xc
         qmSQ==
X-Gm-Message-State: AOAM531eEhUcVskLHgwaWcW8+8f+cCZXSjgJ3awK79JMSAy5cKDyBdMx
        KWp0nVlEq1so0N81umvzRKoWclq/ATNAss8MXHoPQA==
X-Google-Smtp-Source: ABdhPJw4xe/KH9LBgQWNaxfwihIfweJkfDAinU7w++4ZzpYo6HnML1tebK633h8/R2YzHIKf0QcpbgjRnLlThw9Y8Q4=
X-Received: by 2002:a05:600c:1ca7:: with SMTP id k39mr3587479wms.115.1629207868147;
 Tue, 17 Aug 2021 06:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
 <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com> <282d8e4d817f969a3c4d882cc833dd76f4451764.1629145036.git.gitgitgadget@gmail.com>
 <YRresPEnuv9EwBgS@carlos-mbp.lan>
In-Reply-To: <YRresPEnuv9EwBgS@carlos-mbp.lan>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 17 Aug 2021 15:44:16 +0200
Message-ID: <CAFQ2z_O1mJEqnxow-SLytiPwh_Pgnsupdi5ORgE4Q6KULmuLoA@mail.gmail.com>
Subject: Re: [PATCH v2 07/25] reftable: (de)serialization for the polymorphic
 record type.
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 11:54 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> On Mon, Aug 16, 2021 at 08:16:58PM +0000, Han-Wen Nienhuys via GitGitGadg=
et wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> ...
> > +     union {
> > +             struct {
> > +                     uint8_t *new_hash;
> > +                     uint8_t *old_hash;
> > +                     char *name;
> > +                     char *email;
> > +                     uint64_t time;
> > +                     int16_t tz_offset;
> > +                     char *message;
> > +             } update;
> > +     };
>
> the use of an anonymous union here (which requires C11) could be made
> C89 compatible without any impact AFAIK by doing instead:

Thanks for the pointer. I opted to do it the C89 way instead, for
consistency with reftable_ref_record.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
