Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0A7C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1862074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 11:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWiCFDcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKKLIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgKKLIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 06:08:16 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC1C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:08:15 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id s8so1524811yba.13
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=apnmHM0AyrFE3unQHY+BFaeA7xJ+cnqfZw23tG9N5P0=;
        b=PWiCFDcFqaldRN9RXuy5je1Hw9ojWZor6Tb6cBjdHAsI3/5BAZTTD7EUIp8+pC++M8
         LG8riARI5uHm6Cu6TiCRI2yQNlxfW3UV2htJ86v0+4PgiHK4CTw/tVE1QyF7166zsMOI
         ShW1Dft2GZ4VBHxrwJizSO548H/YrbDkkp3qcKVQjj+AVkYM+DD3fUUlDMSVypzjeLnA
         MzWHDDi0SQ0fQIB1pH4Z+s4/fZJsDwUoExREn0GYQuevRUGD9DLYBm+bU+1bw8BEhxPY
         wZWmF0qykU7GzZEqZqt4ZYokQEZ7P/OnerxsYVhWCNGbtzKHnejItj1bd7SEWLRb+ByO
         fjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=apnmHM0AyrFE3unQHY+BFaeA7xJ+cnqfZw23tG9N5P0=;
        b=GdwjLv343V/cDrrsQNdd7x5S+hgq0+/G7nEFbz7jluJ7OH/vhnfdr1fBdYbrH2uxiT
         4BooOuoFF+gq+zoqb3bgQl3vpsMmGCDKzeHI0br3258+lAjsUVlJvPYrVD00xJwuz2la
         MDp4kv9B1mhMT5T3Pxhyo+8EBfT+TVqt9HDa1fatPYoJWWY5XqgQvaaMdWaV4HyfMeD6
         VWiNqLK6fZ9ztMGFejwEvhWvFvxD+lKZg4ncYgp6MSaeOvSvNdmUoZYXHOVeV/9403WO
         38ZHGBaVrgCuIKcUTuPXIT90EDi0IwDaTVPhkCDRKZYd8IElFZ+KkHskPafh+3bglyWo
         0BSQ==
X-Gm-Message-State: AOAM531xBtYOvtXPpBzhriT0EkCM5B2vqw1KgtX9rkQTJLsJOygwmx2e
        T7JBfWtfO03DLcSSi2AmSgf//agT93IPEd+A+jlJ5JzRNOF4wg==
X-Google-Smtp-Source: ABdhPJzjdUkyFqsGLoJeRC3TGHQz+76QSZAjErvXfb927GzHd109e7yEA54Fio/W022TgKRu1vQhswBn+k+mF8HcEMY=
X-Received: by 2002:a25:bc02:: with SMTP id i2mr8194212ybh.478.1605092894499;
 Wed, 11 Nov 2020 03:08:14 -0800 (PST)
MIME-Version: 1.0
References: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
 <20201110120135.42025-1-zhiyou.jx@alibaba-inc.com> <xmqq7dqt6ilx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dqt6ilx.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Wed, 11 Nov 2020 19:08:03 +0800
Message-ID: <CANYiYbEFrqCDOcmFek336UG7PK0TLUaa26jVYjRgRcCvtfkHsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t5411: refactor make_user_friendly_and_stable_output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > diff --git a/t/t5411/common-functions.sh b/t/t5411/common-functions.sh
> > index 521a347710..b7cca2d8fb 100644
> > --- a/t/t5411/common-functions.sh
> > +++ b/t/t5411/common-functions.sh
> > @@ -42,7 +42,7 @@ create_commits_in () {
> >  make_user_friendly_and_stable_output () {
> >       sed \
> >               -e "s/  *\$//" \
> > -             -e "s/   */ /g" \
> > +             -e "s/  */ /g" \
> >               -e "s/'/\"/g" \
> >               -e "s/  /    /g" \
> >               -e "s/$A/<COMMIT-A>/g" \
> > @@ -52,5 +52,11 @@ make_user_friendly_and_stable_output () {
> >               -e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
> >               -e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
> >               -e "s#To $URL_PREFIX/upstream.git#To <URL/of/upstream.git=
>#" \
> > -             -e "/^error: / d"
> > +             -e "/^error: / d" | \
> > +     if test $# -eq 0
> > +     then
> > +             cat
> > +     else
> > +             sed ${1+"$@"}
> > +     fi
> >  }
>
> I may have suggested it, but looking at this implementation I'd have
> to say it is not worth the extra process here.  The only reason why
> I made the suggestion was that way we can make the single "sed"
> invocation to do what we want.
>
> If you need custom output for just two tests in 5411-0000, define
> the custom one that wraps make_user_friendly_and_stable_output in
> that single script like so:
>
>     filter_out_remote_messages () {
>         make_user_friendly_and_stable_output |
>         sed -n -e ...
>     }
>
> and then use that ...

Will add new helper function
`filter_out_user_friendly_and_stable_output` like this, and use it for
5411-0000, 5411-0001, 5411-0013 and 5411-0014.
