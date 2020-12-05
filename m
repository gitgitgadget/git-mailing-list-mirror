Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CBAC4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5849A2310E
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 21:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgLEVyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 16:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLEVyS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 16:54:18 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E210C0613D1
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 13:53:32 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so12641392lfc.4
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 13:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQrvpD0bJitGY4Q4/vE0mmxYe3fuPmHZBWCIJeWwLk8=;
        b=Py+0keEcGgXke2JMMre/Zvuq7FRAbr7DEzDUoRxRvxqg5+yfilh9hw5E+1m/kPG1Eb
         3RXbMtUFL3ewdKwt4Kqtp+v4xK/E/g03/NFT6LQ/VaSsGu6Wn/Grmb6Of3zzhrzMJnkN
         wv2nhcbB4lFDa0nHdUBoH4Y1FN12rUDMooWlQZcQwJSszHAUBRrJ94XrLhG+hK4lNSST
         vXS0B8cxji8vQxknRmdtrgbvoozl/eyP372wZ0cF1UtpGzsHU9PeUWD8q56BX9Vd/O1U
         dpJ50MAVtnq1IN5c6ewL3Ua8HOna8HsdteRiEYUKz8ltiu8fyltccXURmHPUwy7Ks4hb
         CElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQrvpD0bJitGY4Q4/vE0mmxYe3fuPmHZBWCIJeWwLk8=;
        b=XlpHzadhhYsyQw35xyFAkCWsfZlJnwFq2z+6NuJZ0zE5UPPEKKjH6KEiC8hy2HzEli
         dxuaaskCkYl5IsiTXI0RW4e9TJVfGlbHEpvQX8gWPY5HK1erFG7FFRADHn34C38lI6To
         /Qxi6ZkuvmJI+XYUnW4wmYDiF3wXxVZILYWyYeAkqYsOZ1b7ru23jMgVwngfxEHuKLBK
         N/1sFJvR2WXt0xYoYxSMq7WtCIWb1apKWI6aGyISVmZ8PMDWx3CripXdAK/b4U7YLuk1
         jTF6DK8hUz5GXuS9zEEHR3dnRwdcyfBDG/Zz7jcyVnMkdxGhX66/F6eNx+rh1E3K7Yve
         5xuQ==
X-Gm-Message-State: AOAM531FPaQed83hfF2wRtkCmANWK8XrCtqCJRPPPJt5zQn6f8TY62Up
        XXliAdctu/0IaI8CyfRhdgEUn6U5NcAgl9cPiyh+0Q==
X-Google-Smtp-Source: ABdhPJzROzNqIqoXo+BGErF5likt7UpsokpwD+0wKi7DOMgSTKrd4+p95kiqrDzLt0tBNjTx7s4OF/1WgxCZtQJ18tU=
X-Received: by 2002:ac2:53bc:: with SMTP id j28mr5679026lfh.39.1607205210791;
 Sat, 05 Dec 2020 13:53:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <2726f6dc05c319e2baaf76a05d62426e0695fe65.1604521275.git.matheus.bernardino@usp.br>
 <CAP8UFD0Z-EU0=9qz8wYt4MSFqqmoDKnMxTbqgUJNVOR+qUZ3rA@mail.gmail.com>
In-Reply-To: <CAP8UFD0Z-EU0=9qz8wYt4MSFqqmoDKnMxTbqgUJNVOR+qUZ3rA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 5 Dec 2020 18:53:19 -0300
Message-ID: <CAHd-oW6RNVP68gXHGsMS9ky+DdcRBbTxJt--TRNszi9v+xOh-Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/19] convert: make convert_attrs() and convert
 structs public
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 7:40 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Move convert_attrs() declaration from convert.c to convert.h, together
> > with the conv_attrs struct and the crlf_action enum. This function and
> > the data structures will be used outside convert.c in the upcoming
> > parallel checkout implementation. Note that crlf_action is renamed to
> > convert_crlf_action, which is more appropriate for the global namespace.
>
> It annoys me a bit that some things are called "conv_*" and others
> "convert_*". Maybe we could standardize everything, but it could be a
> separate patch series.
>
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > [matheus.bernardino: squash and reword msg]
>
> Not sure we want the above line, which could actually not be
> completely true if you rework the patch before it gets merged.

Right, I'll remove this line from this and the next patches. Thanks.

> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>
> > --- a/convert.h
> > +++ b/convert.h
> > @@ -63,6 +63,30 @@ struct checkout_metadata {
> >         struct object_id blob;
> >  };
> >
> > +enum convert_crlf_action {
> > +       CRLF_UNDEFINED,
> > +       CRLF_BINARY,
> > +       CRLF_TEXT,
> > +       CRLF_TEXT_INPUT,
> > +       CRLF_TEXT_CRLF,
> > +       CRLF_AUTO,
> > +       CRLF_AUTO_INPUT,
> > +       CRLF_AUTO_CRLF
> > +};
>
> Maybe we should also prepend "CONVERT_" to the values?

Yeah, I also wondered about that. But I wasn't sure if it was worth
the change since there are about 52 occurrences of them. Junio later
mentioned [1] that it might be OK to leave them as-is since the use
sites will always pass these values to the API functions, which would
make it clear that they are from the "convert_" family.

[1]: https://lore.kernel.org/git/xmqqd00z397m.fsf@gitster.c.googlers.com/
