Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561FCC4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349E6601FC
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 07:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhGXHQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jul 2021 03:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbhGXHQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jul 2021 03:16:17 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F98C061575
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 00:56:49 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id r18so5315234iot.4
        for <git@vger.kernel.org>; Sat, 24 Jul 2021 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xrLC6yearNb432PcZKab7ouIHX3OpwfGiOPQWkQqUR4=;
        b=D7UMEQv8zL9QwcyA/Rlv+VmIuBG9bEAUPiTHhmp74D4o65zORKop9FMkoFRtsXUGaL
         mHZlBfenJqSlPx6QEmO4rBL2EcTNnj/vVBQjREECVHcNNUpvFbP9qtGJsvJXAR3AYv4+
         krS4L/Pky13CrlhyWb1VySRpUU4cgLLCnnkj1DZ84dgCYEJ6gG6TaEduA3mHXWjETBBZ
         CW3+eC016V8aj4RXmQEgII0NKR5jBlbZXUPP9FozQb/xCGxNBgALeGRFFupCqPvNg9bz
         JtKIFhyjaJv0N5UQBRExEPTykujLBiS9ad46Hl0omPivQWfnFgtoX0+UAcvlROihOLlZ
         jTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xrLC6yearNb432PcZKab7ouIHX3OpwfGiOPQWkQqUR4=;
        b=HuifnNGB2fzDqaFnh5qY/846Ifs2pgoAwLjaOKyYenF0WVBR0yy32ui+N8F56lkux+
         UeQtLauyHS2NXUFYdD7sqbdWSv7aracm2Jxxtd+Av36KN9TrDBoUzavS09rDDZ2Q9Y4x
         TvhM6ZTaBKWLV/as65h/zaBXR05ANT7P81yWIIGmvb4WjMnWlmeiCr2cnr2XopL3ZmRZ
         oGXFmptBVrlfUmcVzhf94yvULF505cgj3FHE9S6T9Id6q5pp62iyl/jgWEC7b7EcRB0A
         ZaxGgtf1zDDyd8SMIyRm76xQxC+c6fU5jYopAq1KOrESjo0wKT/etmRFdE5t2d/S+iF5
         F2Yg==
X-Gm-Message-State: AOAM530/e4V+VWdYmqKuf8HkeD7VyFaJYfx8S6SLblLx1KPgNolL38Fz
        M8gHs0XyTLCgaZq6quaPa5b2nU7u9gtILudBSsI=
X-Google-Smtp-Source: ABdhPJxYAUhzA78GwtwItK0j+OhnIaSbFCZz6BD2SIr7qoaooqMDiMAtkUGmJ9Wq4DU48vwUQ6EekdmRwkQ2Hmdjslc=
X-Received: by 2002:a5e:db02:: with SMTP id q2mr6937427iop.172.1627113409102;
 Sat, 24 Jul 2021 00:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
 <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com> <eafb79bad62f13fc8fd70ba1dce3e8fbab870e52.1627031043.git.gitgitgadget@gmail.com>
 <xmqqh7glouiw.fsf@gitster.g>
In-Reply-To: <xmqqh7glouiw.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 24 Jul 2021 15:57:16 +0800
Message-ID: <CAOLTT8SggCXkajPG3om+6zhM_K8fyAb2qTBDj40JJa1pszshzg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:38=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
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
> > +#define ATOM_VALUE_INIT { \
> > +     .s_size =3D -1 \
> > +}
>
> This will get turned into size_t that is unsigned, and comparisons
> like this one and ...
>
> >       case QUOTE_NONE:
> > -             strbuf_addstr(s, str);
> > +             if (len !=3D -1)
> > +                     strbuf_add(s, str, len);
> > +             else
> > +                     strbuf_addstr(s, str);
>
> this one ...
>
> > +             if (v->s_size !=3D -1)
> > +                     strbuf_add(&state->stack->output, v->s, v->s_size=
);
> > +             else
> > +                     strbuf_addstr(&state->stack->output, v->s);
> >       return 0;
> >  }
>
> may work as expected, but it makes readers wonder if there is
> significance to negative values other than -1 (in other words, what
> does it mean if v->s_size =3D=3D -2, for example?).
>

Yes, any value less than -1 is meaningless here.

> It may make sense to
>
>  * Turn atom_value.s_size field into ssize_t instead of size_t
>

Will the conversion of size_t and ssize_t break -Wsign-conversion?
Although there is a lot of code in Git that has broken it, but I am not
sure if it is wise to use ssize_t here.

>  * Rewrite (v->s_size !=3D -1) comparison to (v->s_size < 0)
>

For size_t, this scheme is wrong.

>
> Optionally we could introduce #define ATOM_SIZE_UNSPECIFIED (-1) and
> use it to initialize .s_size in ATOM_VALUE_INIT, but if we are just
> going to test "is it negative, then it is not given", then it probably
> is not needed.
>

It seems that this is the only method left. Although I think
ATOM_SIZE_UNSPECIFIED
is not very useful becasue we already have ATOM_VALUE_INIT.

> Other changes in the whole series relative to what has been queued
> looked all sensible to me.
>
> THanks.
>

Thanks.
--
ZheNing Hu
