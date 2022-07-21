Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC293C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 21:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiGUVOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 17:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUVOP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 17:14:15 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4973509F4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:14:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x11so2251247qts.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 14:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HOtX0U5LcsQK2KA70uJ7ra0ooEr66kaj7Gc4GE8wFvs=;
        b=KytFSx1FAu82hhoY8ophkn/PCebP9rRSg/k0uiMAPU43rKu7qycuAPw8oSPSs9X8xz
         iE1Z0gk+iW7lW8d0MfiG6wCbK5vd9WVVEHxntoW3mNehYa94jr6yfHFcExP6AubFUwHQ
         ukkAREWJEsLb3uKHEZQb5JZ4e6dhuyHhn34o36dhy5344gRiS3XDAM4KKC9VAMPPfx8g
         i/MtjrjIZuLiTUgJmV869FznI52+i+9RoP/MwBPbl/XPI04yv7PmJwTyJpMdJC2HkaGO
         APMNmxdA5ehg1d/QTsLeZLlUEInj4NT6166dYo+Ir5zsp1VGXfEqja+Tm2NXybCdX3vG
         LrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HOtX0U5LcsQK2KA70uJ7ra0ooEr66kaj7Gc4GE8wFvs=;
        b=72q35dXnG3s8opEF9rwI1z2vES4PI7cJCeTrpGZUXm5vB2x4sDQHdjPZ+Jor/vT3oz
         sio13UXPgAKfy6PRrU4mtMrFAleIbRG91Sku+jQjw5IIRTm7FJ6uobm4+vEyeX8pBMxB
         3owWDBB2OS0F4YfNpHzpgTgwygtWpPiefse4eT7w52/S5eYhsTg4Xwx7QPHxQnyqZceM
         YMV+p3yWE9vxIp6ZQ4b6wyCxMiAo6RIbI6hyoxyhDwnJFHbW+IkjQyOYUd/vzurQu2h8
         8QZYR07uQAXKRVCacy2MeHPeW8Xv8uyreHeUKqVXS9V/1T1FgfKI1dzKHAxu3ksYLzx8
         8x4g==
X-Gm-Message-State: AJIora+WNoOmv4X9aOlX1MAogO25iPdH5t3MMG9VPJ9TkvYSJNCsg3CE
        d4/Y+FMOXr0NgBlS8F+bcD4lgs1Sw2Y6TLt1EPM=
X-Google-Smtp-Source: AGRyM1vsSwSpq1YiFcfON9VKDhRNMqGsHFcbvPBquFysUCcYhbDt+v+PHpYCML44GNFAdBoivLXMXAMKAoFEmsd2Au0=
X-Received: by 2002:ac8:6bc3:0:b0:31e:dc36:6cf8 with SMTP id
 b3-20020ac86bc3000000b0031edc366cf8mr492694qtt.470.1658438053755; Thu, 21 Jul
 2022 14:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com> <e39b2e15ece14ba2b1118ae95e0d90ed60589b41.1658391391.git.gitgitgadget@gmail.com>
 <xmqqsfmulb6w.fsf@gitster.g> <CABPp-BEddgN5QmFkfejC6jZXMAGTivQBtV8YQ8Jq0EZzPhAM8Q@mail.gmail.com>
 <xmqq1quegrj5.fsf@gitster.g>
In-Reply-To: <xmqq1quegrj5.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Jul 2022 14:14:03 -0700
Message-ID: <CABPp-BGttaVetjRnxYM8ti0fHNcvsNYc9NcWXKQwH4Qqbii9wg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] merge-ort-wrappers: make printed message match the
 one from recursive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 1:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Thu, Jul 21, 2022 at 8:47 AM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> >       if (head && repo_index_has_changes(opt->repo, head, &sb)) {
> >> > -             fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> >> > +             struct strbuf err = STRBUF_INIT;
> >> > +             strbuf_addstr(&err, "error: ");
> >> > +             strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
> >> >                   sb.buf);
> >> > +             strbuf_addch(&err, '\n');
> >> > +             fputs(err.buf, stderr);
> >> > +             strbuf_release(&err);
> >>
> >> Makes me wonder why this is not a mere
> >>
> >>         error(_("Your local chagnes ... by merge:\n  %s"), sb.buf);
> >>
> >> that reuses the exact string.  The err() function in merge-recursive.c
> >> is strangely complex (and probably buggy---if it is not buffering
> >> output, it adds "error: " prefix to opt->obuf before calling vaddf
> >> to add the message, and then sends that to error() to give it
> >> another "error: " prefix), but all the above does is to send a
> >> message to standard error stream.
> >
> > Ah, that would be nicer; thanks for the pointer.  I would still need
> > to prefix it with an
> >     strbuf_addch(&sb, '\n');
> > but two lines certainly beats six.
>
> Your "strbuf" version uses the same format string as my error()
> thing and then manually add one LF at the end, before sending it to
> fputs(), which, unlike puts() does not add any extra LF at the end.
>
> error() gives a terminating newline at the end.
>
> Do you still need to add one more?

Ah, sorry, my mistake.  I somehow thought error() just added the
"error: " prefix.  So, indeed, this is just a change from
fprintf(stderr, ...) to error(...).  No second newline needed.

Thanks!
