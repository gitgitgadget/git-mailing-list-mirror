Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA9C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C89C61130
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 12:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhDHMTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhDHMTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 08:19:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F7AC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 05:19:11 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d2so1554116ilm.10
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 05:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PpOIdKTAlPZMHpNXbPLY7+85hJ7hBLQcQIStYI/ET0U=;
        b=cKaLUkSzjMGokgXw/yK4abRm5EO9KxH3LT4b6ziBLChkGNjNG2UuyxFkfU2+1w9KBk
         XSvFdFlDIfxmXvwt9HbXUhksK1ugG54awMOGs5da5rw5pPgiakVp22Baw3dhZLllJHSQ
         1l5lA4UMWwlTmGdiMdR5tb2EQ1SpJgMpPeoPsABkStjXye1vs18x+A02jK2AeyV/olra
         nczA/sQOY5X3TVfvV2LCyH5MUbiwE81f1sbKMe5tFvvuU3qJ/iIFetlQJwkqhvH6eBdu
         CjmcsGe9v1yQPhN9LRlzBIuL2U18hJPhY22jQ/OWSzjBwv227x6tWCTiQhJ64Uk55Reb
         nVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PpOIdKTAlPZMHpNXbPLY7+85hJ7hBLQcQIStYI/ET0U=;
        b=dJmV8WCYSrhAS7v9koNFZd8ptNIvy90awPrTtMQU8DAIWqMdOAPpnpnq17J8C5FUMk
         HyATSNqrWVKe0GR08W+Q0XNVx3haV3ixi0N4br0M0Erih27g0kPlb7D8NfSK/zZBxnDc
         YnNP15GSZOIVqE1D1bkoRuJZpaFV9/Bwg9Q+WV5EgL+Ws3iKYT88Bvo9AM+LJOzOUN9q
         aCHZkxPMrzRzAojO5JL1JVwLkUXKbV/Y27dP/B1v90XovBsim1PpQaoIqr8/PjiD3zPQ
         eRP47QucA0K8n42f6X5LI6KHhotqfr+mxy7+JvT6LYvK/hnXBnnWwncN7202tASPkHj0
         gNpw==
X-Gm-Message-State: AOAM532DyRpXkHKKFG7Co91Dm887wJRsrOTqfpqB5Epyg6hewa0pLvM+
        ks9urFC5xG7Q2LPdmX2X2jFbcFy56tiXRf09Qlg=
X-Google-Smtp-Source: ABdhPJwb8LiK1er1n/FqCPo1eSapv++2pzcBepd9pUYjgJk2rMTeFSKjh5UYDl6jZ3Rh53IDzoljXqHlizyk4IWjZk4=
X-Received: by 2002:a92:d308:: with SMTP id x8mr6640153ila.301.1617884351257;
 Thu, 08 Apr 2021 05:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com> <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
In-Reply-To: <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 8 Apr 2021 20:18:59 +0800
Message-ID: <CAOLTT8QvdLeWz=cDOoVFV8Lrk2QL2wf_jwDc6oK5j+6gup+Png@mail.gmail.com>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B44=E6=9C=888=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8A=E5=8D=885:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Apr 07, 2021 at 03:26:48PM +0000, ZheNing Hu via GitGitGadget wro=
te:
>
> > diff --git a/ref-filter.c b/ref-filter.c
> > index f0bd32f71416..27bbf9b6c8ac 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -2435,6 +2435,26 @@ int format_ref_array_item(struct ref_array_item =
*info,
> >       return 0;
> >  }
> >
> > +void show_ref_array_items(struct ref_array_item **info,
> > +                      const struct ref_format *format,
> > +                      size_t n)
> > +{
> > +     struct strbuf final_buf =3D STRBUF_INIT;
> > +     struct strbuf error_buf =3D STRBUF_INIT;
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < n; i++) {
> > +             if (format_ref_array_item(info[i], format, &final_buf, &e=
rror_buf))
> > +                     die("%s", error_buf.buf);
> > +             fwrite(final_buf.buf, 1, final_buf.len, stdout);
> > +             strbuf_reset(&error_buf);
> > +             strbuf_reset(&final_buf);
> > +             putchar('\n');
> > +     }
> > +     strbuf_release(&error_buf);
> > +     strbuf_release(&final_buf);
> > +}
>
> I think this is a reasonable direction to take the solution: wrapping
> the loop so that the reuse of the buffers can be included there.
>
> But I do wonder if we should go the opposite direction, and get rid of
> show_ref_array_item() entirely. It only has two callers, both of which
> could just write the loop themselves. That is more code, but perhaps it
> would make it more clear what is going on in those callers, and to give
> them more flexibility.
>

Indeed. I think `pretty_print_ref()` is proof that we may need to keep
`show_ref_array_item()` because If it modified to `show_ref_array_items(...=
,1);`
it will look very strange.

> I notice there's a third user of the ref-filter.c code in
> builtin/branch.c that does not use show_ref_array_item(). Instead, it
> loops itself and calls format_ref_array_item(). I think this is because
> it is sometimes columnizing the results. Perhaps git-tag and
> for-each-ref would want to learn the same trick, in which case they'd be
> happy to have the open-coded loop.
>

Yes, a special judgment about colopts is used in the `print_ref_list()` of
`branch.c`.

> Either way, it probably makes sense to introduce the same optimization
> to the case in builtin/branch.c.
>

I agree in `branch.c` here can learn this reusing bufs optimization.

> -Peff

Thanks.
--
ZheNing Hu
