Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF4C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E58611AE
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhEKSz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKSzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:55:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494BBC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:54:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v191so16720262pfc.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KNDbSQ+vNLwy9PrDLLNVluDP8+aWmxMKwwksPdO1HG0=;
        b=ojOjS3qM/r9lk759g2orgTnMAEgyNjeGJRtHBPZa0UT7IFHsWMvhE06f/cuIjITIpA
         j2qBSBkWfQeVXPlawWzxG7vCsgtd+xYG2V20bg5PcnCvtekopYUB+/YNZp3Dcz9k1Ukz
         p9iWu3pN8+6r1yL05pZoBcfy8fvueHmuH67ukMpY6Ty2FMPj8E/90kKF8ZH/5wQzHtm4
         LdIR0IYOeh/6JxM8TboLE2wQjzpelavxuoLIf9RJgltk9l5sz/Ye+dqSphIDTEmbh1jX
         M0KjO0/doZ+z4Dgt0ZM8kgwwpnMgcA5xSP6EF5wBahhxiNt6PuG6HDRo4ZUfv7I/Ygw8
         6OcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KNDbSQ+vNLwy9PrDLLNVluDP8+aWmxMKwwksPdO1HG0=;
        b=B2Y4TpA1WB5GBmPqxebX+HV/Vj4uXiMjLQuVBHqGw9pK5wDzis6oSJ9boxCks/egOV
         tKZ1XX0cjVW6tyEN5jtFp72P17qHJdrD3c89xnB6ow/vVujQ/fu05SGtF3Gjtpij9XQF
         zuw62v/45qky37jUT0Pmp7bCkqvunxHgxend3zyIrOZ5kbFBG1mauK8UQU8vMvjDRd0x
         F6kMKsOgMIJ7YHj0HER0lCFEuD6rBo5YT0Y2vBsePYuFb6z+Oc+ftNNGtQCgEeAXRWlk
         pu0dXK8mwHB0Cx24z4O7IlA+PS9UVfXO1r8O/KMv8nR+pCvtfdrDFq3/AO4LpnxECHuu
         3cHA==
X-Gm-Message-State: AOAM530NT7p7QQc+HPC7DIANFdjzm0oe2gL6T10gJmVlLZjQyKlZpUSc
        la7j2n74HoU4+TSE3y1+0RQJyrrDAlVyK7MeWmovhkfOme8=
X-Google-Smtp-Source: ABdhPJz13cE5bQeWYBJEy7wivLgqjPeFpkcmhxF/vlBpN3zkSmhtREtI/UeVfInoHI6O1al9l1+r0HurTtsdWPj2iIo=
X-Received: by 2002:a63:2c92:: with SMTP id s140mr32557270pgs.39.1620759285856;
 Tue, 11 May 2021 11:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com> <0fd3182c-3805-ee1b-5a35-e0c9a67892ab@gmail.com>
In-Reply-To: <0fd3182c-3805-ee1b-5a35-e0c9a67892ab@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 May 2021 20:54:33 +0200
Message-ID: <CAN0heSpNhfmsVO5rME1xZzPPbkCuDm0ng64xWNx4xy+8ZrVz+Q@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 at 11:04, Jean-No=C3=ABl Avila <avila.jn@gmail.com> wro=
te:
>
> On 09/05/2021 at 10:20, Martin =C3=85gren wrote :
> >
> > I tend to think asciidoctor even renders our manpages *better* than
> > asciidoc does. Not by a huge margin, but a few things here and there.
> > Some time around the Python 2 EOL, I was about to propose flipping the
> > default, but then I went to look up the asciidoc EOL schedule, and like
> > you, I noticed that it was a lot more alive and kicking than I thought
> > it was. So it's not so much "we should flip to avoid a bitrotting
> > dependency" as it is "asciidoctor is arguably nicer" or "it's the way
> > forward".
>
> If we start to change the documentation format to "the way  forward", we
> may soon end up with a format which is no longer handled by the legacy
> asciidoc.py

We used to be in a situation where Asciidoctor looked worse and the
rendered versions were quite different. We've fixed up quite a few
discrepancies by making some change that "happens" to be a noop with one
engine but an improvement with the other. (That it just "happens" has
sometimes been my feeling anyway.) Sometimes, we've been able to improve
both by spotting a difference, so that's good.

I would also expect that with more eyes on asciidoctor-built docs
(because default) and fewer on the other, the non-default will start to
degrade.

> As stated on https://github.com/asciidoc-py/asciidoc-py :
>
> "AsciiDoc.py is a legacy processor for this syntax, handling an older
> rendition of AsciiDoc. As such, this will not properly handle the
> current AsciiDoc specification. It is suggested that unless you
> specifically require the AsciiDoc.py toolchain, you should find a
> processor that handles the modern AsciiDoc syntax."

Thanks for that quote. It's very enlightening.

> FWIW, we are already using Asciidoctor for publishing the manpages to
> https://git-scm.com

Thank you for all your work on that site!

Martin
