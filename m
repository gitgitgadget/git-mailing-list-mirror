Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64EFC47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 08:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D0D610CC
	for <git@archiver.kernel.org>; Sun, 30 May 2021 08:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE3INp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 04:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3INo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 04:13:44 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA2C061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 01:12:06 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x18so1753898ila.10
        for <git@vger.kernel.org>; Sun, 30 May 2021 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f1X6IZi/eC5utinSx9tyGE0md6X9y8LMkR3ItnOB30E=;
        b=CAtI7GYVdwJRPuaVNluGLmy/PFYouE1PKWIsbu9f9IYItMfiNsyBg788alMuIZaRHC
         Rv5XPFjx8q2G2wmcwmFdycG3X8SJB9zyjDxkUSqcQ1sJLe9xWZ7U3Nd2t40pxOibT6JN
         s9rX5ZHjlRx3gKQSdyCuwPcrGv0cJqoV2WhZMfDoyohJPKQISIwY+87VXuprAAn1x+0/
         sfGYv3SxRZEbr/HRFykN1c7repbaebHbdawqOIVwML4NGuEVSXrFta+uX/jYLiJEN2ML
         j12qb4BKesZXpCS3CvZ/8rL8RMPQ0OfKdeobdGokXMyH5ERp2BimxsJWalRNKMp9aEWU
         rV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f1X6IZi/eC5utinSx9tyGE0md6X9y8LMkR3ItnOB30E=;
        b=rA89U0y2YK2sbAq2/Va/Cg+6NIt+8u8eQ7dgjyjjbaGh4KQvwvYuBEgOklU+7RlgLS
         5v6yFfMBVWMzMFqUxivJnMna9Rw9ZswJ7T6+nbCUq0PSwF7Z85snyTc9rO45/PsvEh+9
         PGMO9WYdewtOAPVLwiSaDsh4FqgUYH+BwxLY2ioxfSSQz9xEVbKmpjaXyAtFFQ8Xy3AW
         bN0hBbbO8o4m0czSscnk1zrrnUdF8/Af71yuvftTgfqPz52oaIZErxIuF1EXT/lPKIFs
         93vdX4+xtqNzkh8dVhHg5g0ui+BDSaHS2wIKKX51JbcDhb2F22vwLCRDoZ74jGC4xTJU
         698w==
X-Gm-Message-State: AOAM533oDZXcu7Da21EfTrmprpfYPVYq+G7XKicdoVVBThM6N4XLv+3/
        xbGfR3nwpIUMW9UFCGw603IUAPe5k5gjc3uwOcM=
X-Google-Smtp-Source: ABdhPJzKKgy+wwrNQdpENucwqlsSvIhsS5LV71f7qIPtsdb8o6PekxdNfIZQw7GSgyT2efpP433TfaQnoy3agt5KSjA=
X-Received: by 2002:a05:6e02:12c9:: with SMTP id i9mr513399ilm.17.1622362324873;
 Sun, 30 May 2021 01:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com>
 <xmqq1r9r8spu.fsf@gitster.g> <CAOLTT8SLLgZnF0SV2FPPBJkB=ybeh8mamTPqc-M6CXQeepooOQ@mail.gmail.com>
In-Reply-To: <CAOLTT8SLLgZnF0SV2FPPBJkB=ybeh8mamTPqc-M6CXQeepooOQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 30 May 2021 16:11:52 +0800
Message-ID: <CAOLTT8QAS5AyUE-9hR7v1bfYdAEf=VJiPZukGMJED+F_4Jt_zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8811:04=E5=86=99=E9=81=93=EF=BC=9A
>
> > Can the change in this commit violate the invariant that
> > if_then_else->str cannot be NULL, which seems to have been the case
> > forever as we see an unchecked strcmp() done in the original?
> >
> > If so, perhaps you can check the condition upfront, where you
> > compute str_len above, e.g.
> >
> >         if (!if_then_else->str) {
> >                 if (if_then_else->cmp_status =3D=3D COMPARE_EQUAL ||
> >                     if_then_else->cmp_status =3D=3D COMPARE_UNEQUAL)
> >                         BUG(...);
> >         } else
> >                 str_len =3D strlen(...);
> >
> > If not, then I do not see the point of adding this (and later) check
> > with BUG to this code.
> >
> > Or is the invariant that .str must not be NULL could have been
> > violated without this patch (i.e. the original was buggy in running
> > strcmp() on .str without checking)?  If so, please make it a separate
> > preliminary change to add such an assert.
> >
>
> The BUG() here actually acts as an "assert()". ".str must not be NULL" is
> right, it point to "xxx" in "%(if:equals=3Dxxx)", so it seems that these =
BUG()
> are somewhat redundant, I will remove them.
>

Correct the error: If the atom is "%(if)" instread of
"%(if:equals=3Dxxx)", .str will be NULL.
Without assert() or BUG() is ok, but clang-tidy will give a warning:
"Null pointer
passed to 1st parameter expecting 'nonnull'"

--
ZheNing Hu
