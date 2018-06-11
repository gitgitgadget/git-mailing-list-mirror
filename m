Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4BAC1F403
	for <e@80x24.org>; Mon, 11 Jun 2018 23:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeFKX46 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 19:56:58 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34165 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeFKX45 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 19:56:57 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so6054185ybg.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=349GJTJWHfVzGB36hlE0F4qoqpu2cXDr1Z4kyWQqDnc=;
        b=vrpTZqQKZm46civHe6hduakIvjVGINxWO4SX0St0s+Ne9M3hhcmxs7Oq+di0u+D1yx
         npejSU51rzXhGITL+oGDVFpjvHyHB0u1V/FlUPKhcAU2SH21XgUdETVt3i7wX7plUHvs
         NCeFP3XgAm8A8kYMNZxH87ExM1x8PH0thoVCDwvmVjtoaUwy2vX3brHXLlGolgxAekmi
         9FqAur5oIXAo4/4fzOnTnE2Gdyu6D8D9iHdySO/Yb17IrYgbYpIz/E/h19btonrtbki/
         +qTFJreHBOYVFFN1/cXMeNErEK3KO4hEB7n5dWnFPzAYR9QE21/OExGB13I7B6X9W2IY
         q1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=349GJTJWHfVzGB36hlE0F4qoqpu2cXDr1Z4kyWQqDnc=;
        b=AgzqMhnsPjDLL1vf7F26sxP0SYEEnP2BhXvTtuUpomyawfZThs+JLi2LojbVDJnCC4
         ucJUmqNC2UmZJb6zG7sMZ4fKRdwZ94kPjWMDQrkFPUlEXZccqQ8hrBI2RZIzAoaefPHN
         Ev68AYXozI/NNb9HWynj2LyWY9BYZpkE6/VilTwiwXJmyOqFqP3Inw/vKvPNj0TKp2FW
         AiRmKp8RBXR4ntZ6GQWSxpjnJPXHd3FoYFalEQIlf8g4D827GTyEMj/ir/iJGpdYUVWX
         0jVcWdFiOk9bBo04iUHoDwDsv+LuLVI6mUBrRVIrH9Kc6xbrXHKgaYBJjKEc9w4ACGoO
         W7Tg==
X-Gm-Message-State: APt69E1RQVtrUSjzHtFfuvk1L1sVPdxfF1dpJL/F9gyShBoVe4efvCBl
        3kX2v5EGXFp3P8V1IrGZtUM5gOVPyZOWaSfLfn8eww==
X-Google-Smtp-Source: ADUXVKJhi+NZzwTUFtyoK4IVxmSL3TqTy+nM4OXWeaqKOszvUrfl3iIGL9DmcF9mYgjajLujbikfSSiqaYpMqZ81J+A=
X-Received: by 2002:a25:cc54:: with SMTP id l81-v6mr570511ybf.334.1528761416870;
 Mon, 11 Jun 2018 16:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
 <20180417213049.118995-1-sbeller@google.com> <20180417213049.118995-2-sbeller@google.com>
 <737e4f2e-9896-0119-2c43-655ac29fe018@web.de>
In-Reply-To: <737e4f2e-9896-0119-2c43-655ac29fe018@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 16:56:46 -0700
Message-ID: <CAGZ79kYLgKEJtMG+S_A3TnLN6u-r04BHGBF7yENVLNsvgJr8Ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 4:26 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 17.04.2018 um 23:30 schrieb Stefan Beller:
> > +static void parse_color_fields(const char *s)
> > +{
> > +     struct string_list l =3D STRING_LIST_INIT_DUP;
> > +     struct string_list_item *item;
> > +     enum { EXPECT_DATE, EXPECT_COLOR } next =3D EXPECT_COLOR;
> > +
> > +     colorfield_nr =3D 0;
> > +
> > +     /* Ideally this would be stripped and split at the same time? */
>
> Why?  Both approxidate() and color_parse() handle spaces.

I think that comment is stale; I remember experimenting with
different internal structs to write a parser until I came up with this
implementation. It is a left over.

> This adds a minor memory leak; fix below.

Thanks!

> -- >8 --
> Subject: [PATCH] blame: release string_list after use in parse_color_fiel=
ds()
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/blame.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 4202584f97..3295718841 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -411,6 +411,7 @@ static void parse_color_fields(const char *s)
>                 die (_("must end with a color"));
>
>         colorfield[colorfield_nr].hop =3D TIME_MAX;
> +       string_list_clear(&l, 0);
>  }
>
>  static void setup_default_color_by_age(void)
> --
> 2.17.1
