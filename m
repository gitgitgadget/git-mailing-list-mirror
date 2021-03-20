Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B150C433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 03:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3B761979
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 03:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCTDFR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 23:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhCTDFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 23:05:01 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C22C061761
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 20:05:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id x2so6880896oiv.2
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0j+JUaWqtgUqC//H8fcDlcco22dX4Q9tMs0cKnIm6tw=;
        b=e77z1NeJy/DE3XxAEViVzFxgoqpkzfOPqeL6yBFbrPIVB5dw0Tyxk1JaXlxOiCNmIa
         FeOv6yRnNt6eiOCxJQQ/7n+cpA+mme2iVNFpYXRL+gIrIynYO7pEWEmFrlydbcnYpkH3
         96IcRlRyOhiRRnnoOkGL2/T2qcytO1L+U4qdo75oIoHt3J8yQVl7+zYnYokt66dgv1yz
         uKXrtyq+PpZ5SMN6W3AKsPMrGiFjRSa+ohjDYW5GUM+39lOx/eklCQGj3kCgOoEznNTC
         WDIzLlcsU1YQ5I7Ngyy+fral+fbtxRUTRbbl+8Uni901TQLSly2+v3QMNa59XTiPofAW
         yPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0j+JUaWqtgUqC//H8fcDlcco22dX4Q9tMs0cKnIm6tw=;
        b=fXYQXPWGIPd0g8vvYnnCAzsm60/xHkGsdVmrE8OHI4NmmKeQHnGAGW2QwGYlw2xnmR
         dSDXM+8nJ60fHQ4CX8K9buxk4SSWlpUSEbrxk1OhEVhwoLkCYuZljoipdCDlHlo39jWH
         USOcizV5v7UxytUuzO8bHfWY+l4ne/7QYq9ZAamon9DPQHNNzd2IhkxTnSopoyLlf1Pb
         8kuBKfX22ma2xC2d60UIO7mgXyuf1B/AUhGUiNPB1b+TfQrSLfOQNUsvFQMs9CyEUne6
         +r2bbmWbc54GMRw6/DKQtymf20vxfNV58JQujOEeqaI8JgilKyuQ+m7916BzOy/iHiOc
         pxlA==
X-Gm-Message-State: AOAM532MNNOhPXubOufH3qac7jF4Y23ebv3xsWS/GFR9armfIJOJ7cJA
        If5jZx+0rpXBNBM+KR1ooK/MGl8NX9nLd/mRimE=
X-Google-Smtp-Source: ABdhPJyc+rpDsp0W9eX2jKLSUkQ0f9GZb5u3fucc3m7690u/lwT4chN4NOQWfMOvbT30ZHSyn7dzlpSog5pfQcS990I=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr3206314oig.179.1616209500236;
 Fri, 19 Mar 2021 20:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v6.git.1616047200968.gitgitgadget@gmail.com>
 <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com> <xmqq8s6jnjc8.fsf@gitster.g>
In-Reply-To: <xmqq8s6jnjc8.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Mar 2021 11:04:49 +0800
Message-ID: <CAOLTT8TZzf1vTvFULuPy4EeTQc6vBH=uRuC7WtUD97jA2Mk5hg@mail.gmail.com>
Subject: Re: [PATCH v7] format-patch: allow a non-integral version numbers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8820=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:29=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Usually we can only use `format-patch -v<n>` to generate integral
> > version numbers patches, but sometimes a same fixup should be
>
> I guess that you meant "a small fixup" here?
>

Yes.

> > labeled as a non-integral version like `v1.1`, so teach `format-patch`
> > to allow a non-integral version which may be helpful to send those
> > patches.
> >
> > `<n>` can be any string, such as `-v1.1`.
>
> I would probably use "such as '3.1' or '4rev2'" (without the leading
> "-v", as that is how you introduce <n> in the first sentence)
> instead in the proposed log message, and give a pair of examples to
> show both fractional numbers and non numbers are accepted in the
> documentation, if I were doing this patch.
>

Sure, either a "fractional" version or a "non-nummbers" version can be
accepted. I will complete the expansion of these documents.

> > In the case where it
> > is a non-integral value, the "Range-diff" and "Interdiff"
> > headers will not include the previous version.
>
> Which is rather unfortunate, but I do not care strongly enough (I
> would rather discurage use of partial rerolls with these fractinal
> bits anyway).
>

Well, now this patch (no previous-count) was born in the previous
suggestion of Denton Liu. I also hope it can be more practical.

> > Range-diff vs v6:
> >
> >  1:  d5f5e3f073de ! 1:  95cfe75ee7da format-patch: allow a non-integral=
 version numbers
> >      @@ builtin/log.c: static void print_bases(struct base_tree_info *b=
ases, FILE *file)
> >       +       int v;
> >       +
> >       +       /* RFC may be v0, so allow -v1 to diff against v0 */
> >      -+       if (reroll_count && !strtol_i(reroll_count, 10, &v))
> >      ++       if (reroll_count && !strtol_i(reroll_count, 10, &v) &&
> >      ++           v >=3D 1)
> >       +               strbuf_addf(sb, rerolled, v - 1);
> >       +       else
> >                       strbuf_addstr(sb, generic);
>
> In one of your review responses earlier, you hinted that limiting
> the range of v like this was needed for correctness.  There should
> be a new test to cover the case that this change makes a difference.

I will do it.

Thanks.
