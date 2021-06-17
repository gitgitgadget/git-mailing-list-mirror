Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFFCC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E786135C
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFQHZn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFQHZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:25:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92966C06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:23:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d9so2053527ioo.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CLhchXCyRxMSKw3Sw40u750DrXxD5MPNZWmixox9c1c=;
        b=ilFCv+nCayLFtENlG1wTHS0VMLnLwOJHm4y31J7bpbvndP7YhSsT2ZN+4AvQnMDiuC
         GyTZRlhcSwM5u2XIWO+W+gAvdq0WqzoZ8MyqxugLIvfUJcOtSdwgG3SYWQcwlT9deHYw
         pw93ZS06EoNcyg6Py1IQoeefUJj+1ooh7XdUpnHPPMsBr1UKkbdIrJnesWsjrY6dueaP
         QKOLJS6BTdG78j6gofGwsjXTNUw3hPZV9qSl0efu6B/aTER30SoXf0V3YpX+87srSD1Y
         ynVshApMXBDOcrxZNkb8f3DVIpoakpH3mjl0D5NIeCWEsN7JuTyqEO+otRkVow5YEHXv
         ZGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CLhchXCyRxMSKw3Sw40u750DrXxD5MPNZWmixox9c1c=;
        b=YJCI3LxpPJt5S1nJ6zj3eYsR2ikQZPUoIz1ru+nZH4/Yf9BLPU00lOuGrTADkSBvMq
         U78YSC77dI/kzPWPuilCiS6t0qPA69Vr1I9x55OXJn7kRE0TlzcvkBMv6wGYQoCCF1SY
         L4etUU1EUg3yUNrjLSjY/11+5JwqNB9NpT/LqcsRKFzSlotfWIFxuhSufU/H3xXs8VD8
         VoHMCzTRTStOYAQYIIrMe7inxLW32n+NBeicTiVWprlprzy+b7kFvXXx5GnZ9OPYplJw
         e8D5mcGPalXKOGjV4qNSZmBP6E4ocNsGZ7ZrN8emZV2db1W0V2p16i9nsywhifsTmXZA
         kRZg==
X-Gm-Message-State: AOAM5312kenrBjZ4OXMKd3ebiGpFi9cUrnWZHxzNkJbYGOtpGkzHIcJ5
        nwoGPNEJBYtMvSnevtVT/OKdtCJXX4bpaFXxHNc=
X-Google-Smtp-Source: ABdhPJyeM1aQc2U0vVVIz4kG+Mn7IJ15lUQvxKIKDodw8m3gXol9OoynTA7AOPbDlmOgvHmBBmS56OYYYVneMdV9D64=
X-Received: by 2002:a05:6638:1602:: with SMTP id x2mr3243645jas.130.1623914612026;
 Thu, 17 Jun 2021 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <pull.980.v2.git.1623763746.gitgitgadget@gmail.com> <49063372e0035c5384f834d78854da56f5726d13.1623763747.git.gitgitgadget@gmail.com>
 <xmqq1r92qn18.fsf@gitster.g>
In-Reply-To: <xmqq1r92qn18.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 15:23:20 +0800
Message-ID: <CAOLTT8Q3_X3kZ5ZdUYe8LKc2WuctWFPCg-akJEpQAKY9_rZv3g@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] [GSOC] ref-filter: teach get_object() return
 useful value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:36=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Let `populate_value()`, `get_ref_atom_value()` and
> > `format_ref_array_item()` get the return value of `get_object()`
> > correctly.
>
> The "get" the value correctly, I think.  What you are teaching them
> is to pass the return value from get_object() through the callchain
> to their callers.
>

Yes, this is exactly what I meant.

> The readers will be helped if you say what kind of errors
> get_object() wants to tell its callers, not just "-1" is for error,
> which is what populate_value() assumes to be sufficient.  In other
> words, which non-zero returns from get_object() are interesting and
> why?
>

As stated in 765337a, We can just print the error without exiting if the
return value of format_ref_array_item() is greater than 0. Therefore,
the current patch is to make get_object() return a value other than
-1 when an error occurs.

> > @@ -1997,9 +1997,11 @@ static int populate_value(struct ref_array_item =
*ref, struct strbuf *err)
> >  static int get_ref_atom_value(struct ref_array_item *ref, int atom,
> >                             struct atom_value **v, struct strbuf *err)
> >  {
> > +     int ret =3D 0;
> > +
> >       if (!ref->value) {
> > -             if (populate_value(ref, err))
> > -                     return -1;
> > +             if ((ret =3D populate_value(ref, err)))
> > +                     return ret;
>
> The new variable only needs to be in this scope, and does not have
> to be shown to the entire function.
>

Makes sense.

> > @@ -2573,6 +2575,7 @@ int format_ref_array_item(struct ref_array_item *=
info,
> >  {
> >       const char *cp, *sp, *ep;
> >       struct ref_formatting_state state =3D REF_FORMATTING_STATE_INIT;
> > +     int ret =3D 0;
>
> This is dubious...
>
> >       state.quote_style =3D format->quote_style;
> >       push_stack_element(&state.stack);
> > @@ -2585,10 +2588,10 @@ int format_ref_array_item(struct ref_array_item=
 *info,
> >               if (cp < sp)
> >                       append_literal(cp, sp, &state);
> >               pos =3D parse_ref_filter_atom(format, sp + 2, ep, error_b=
uf);
> > -             if (pos < 0 || get_ref_atom_value(info, pos, &atomv, erro=
r_buf) ||
> > +             if (pos < 0 || (ret =3D get_ref_atom_value(info, pos, &at=
omv, error_buf)) ||
>
> Here, if "ret" gets assigned any non-zero value, the condition is
> satisfied, and ...
>
> >                   atomv->handler(atomv, &state, error_buf)) {
> >                       pop_stack_element(&state.stack);
> > -                     return -1;
> > +                     return ret ? ret : -1;
>
> ... the control flow will leave this function.  Therefore, ...
>
> >               }
> >       }
> >       if (*cp) {
> > @@ -2610,7 +2613,7 @@ int format_ref_array_item(struct ref_array_item *=
info,
> >       }
> >       strbuf_addbuf(final_buf, &state.stack->output);
> >       pop_stack_element(&state.stack);
> > -     return 0;
> > +     return ret;
>
> ... at this point, "ret" can never be anything other than zero.  Am
> I misreading the patch?
>
> If I am not misreading the patch, then "ret" does not have to be
> globally visible in this function---it can have the same scope as
> "pos".
>

You are right, It is correct to only return 0 here at the moment.

Thanks.
--
ZheNing Hu
