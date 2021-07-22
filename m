Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ECCC6377D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE5761248
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhGVHuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:50:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A0C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:30:54 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z17so5350031iog.12
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JNlQYlluu0ZtRHDUU71SVbr11uVw1RQUu39CBsBXqD0=;
        b=ceX8bHR7aGZLFWSnhXETYOdzH8XQ5zGIb7cXmZUrJAn6cp3PlGyjYPEB2jweShBGPL
         4m0cxwbTkTdybhrLna3Kdvj5VV/ZXaBJRLTwzumJX+JEA5/3hR1w5DITXU9YqlteoxkI
         6JlAWegQ1EUl6w4BUukFaBrohmlaA1y6xJH8d/K/4EwH4S3XFwaYTuRC7ullaBxV1aRC
         4hS/1nCQS4pvShI4XZJaWEikzprjDKfkiQMSy+9nIHSbUUHfF+OkEuN3+oNDqA7/RRyg
         O+3V2aASe7CqTtlmDDILjbm784KxXuM8D/Z6PiZyFiFaSUQBmz+w+3UZlFwOskMIKQg8
         nPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JNlQYlluu0ZtRHDUU71SVbr11uVw1RQUu39CBsBXqD0=;
        b=iuTBq6B3lGLNt577ClRzKZtV1HEAL1WGZz6ZQq7opbFdE23NkSi1DLYMjv88MS0Xgn
         b2uREr/+7nxx8WoVrWnk9ZADxu85oelz4fObc2e1W4yC67GmBJSi7YZLwkJFT5gftcXj
         hq66e5+3Z7lfXu9onLVwdeYOAKuXVZ8KCOqfJMWIw+qqWmq0WanoYLCxMpt9bgziLuh+
         eNmIldjwvyZp2syKf8tTq2px87wkYI5AZfJSvOObd1pv5NKsHtiabxKscE+IAxCEUtr7
         Ys621a20cSj4pe+jU1PbL83oRIx2oX8rgf4D3YJT/CFTQfHTzTJK5Zcdr96TvXyb8pHi
         DEfg==
X-Gm-Message-State: AOAM5309SP0MkTOcfjFUqsvb7AiiJ/QJH8aAA6w7fHO259PUqVbkez3d
        sYJFftBh2+naHlKNpJSJ8SZWsmp+Fh/77+QhXHg=
X-Google-Smtp-Source: ABdhPJzyBzUsRnfKSnr1qeqVyD+zJK5Bgze2Wsk7SxknGmnXIrCCajBr/OimlkHxghCyyEz9sH+0hOkutpkgJ/8jQ/w=
X-Received: by 2002:a05:6602:1203:: with SMTP id y3mr22997182iot.192.1626942654119;
 Thu, 22 Jul 2021 01:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <ecd41b370e62cc88f1606569ec700eaca837fa1f.1626939557.git.gitgitgadget@gmail.com>
 <877dhivkei.fsf@evledraar.gmail.com>
In-Reply-To: <877dhivkei.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 22 Jul 2021 16:31:18 +0800
Message-ID: <CAOLTT8TP4z1vR8i9DX09+oBiPVgaF1isTgD2ZQ4nfoBJwTd9_w@mail.gmail.com>
Subject: Re: [PATCH 2/5] [GSOC] ref-filter: add %(raw) atom
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B47=E6=9C=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:10=E5=86=
=99=E9=81=93=EF=BC=9A

>
>
> On Thu, Jul 22 2021, ZheNing Hu via GitGitGadget wrote:
>
> > [..] add a new member in
> > `struct atom_value`: `s_size`, which can record raw object size, it
> > can help us add raw object data to the buffer or compare two buffers
> > which contain raw object data.
>
> I didn't look in detail, just one nit/comment, no need to re-roll for thi=
s:
>
>
> >  struct atom_value {
> >       const char *s;
> > +     size_t s_size;
> >       int (*handler)(struct atom_value *atomv, struct ref_formatting_st=
ate *state,
> >                      struct strbuf *err);
> >       uintmax_t value; /* used for sorting when not FIELD_STR */
> >       struct used_atom *atom;
> >  };
> >
> > +#define ATOM_VALUE_S_SIZE_INIT (-1)
> > +
>
> This and then later doing (this appears to be the only initialization?):

Yes, "s_size =3D -1=E2=80=9D is the only initialization.

>
> >       if (format->need_color_reset_at_eol) {
> >               struct atom_value resetv;
> > +             resetv.s_size =3D ATOM_VALUE_S_SIZE_INIT;
> >               resetv.s =3D GIT_COLOR_RESET;
> >               if (append_atom(&resetv, &state, error_buf)) {
> >                       pop_stack_element(&state.stack);
>
> Is a rather unusual pattern, more typical would be:
>
>         struct atom_value { .... }
>         #define ATOM_VALUE_INIT { \
>                 .s_size =3D -1, \
>         }
>
> Then:
>
>         struct atom_value resetv =3D ATOM_VALUE_INIT;
>
> You could keep that "#define ATOM_VALUE_S_SIZE_INIT (-1)" to check the
> init value, personally I think it's just fine to hardcode the -1 literal
> and do "size < 0" checks, which we us as convention in a lot of other
> places for "not initialized".

Maybe you are right, hard-coding "-1" is ok.

Thanks.
--
ZheNing Hu
