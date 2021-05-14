Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89FDC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BD461260
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhENIlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 04:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhENIll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 04:41:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C6C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:40:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e19so5929891pfv.3
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zCV2R4ZLSjWbif5a6NcVEg2cqfrXudE18E5bOY1xt3s=;
        b=skC8EjWf+n4C7OPmo2PwuZxpPHGApxHcAOtsn1UtznsbwkpAgyo0XgP6/Jccz5jQ2l
         VWSoWHgBh+tODZ4k3xH69GQyLfplMnBklAOkUm1BTaqjrXzwmqeDUs1rYbjoEMs+udKt
         uPQRDoJ8natUymrDRXflMsiGofDcWxZHPDLwR6wS8t8SB4OfZSLRSEkMIBZAU3pc9OVK
         IvdzY+Z1kGIkpXX6DLKwATaTz3/KLBRF6ctkgYB2zFt5ce4Q7wG7xqEzYirqmha/8QOR
         DejVeThr2YACOTcMuusMBsVrXUKChzi6Nj0AKxFfFW0dKtDbuo5yYGYXeyFdy80ClVI6
         vSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zCV2R4ZLSjWbif5a6NcVEg2cqfrXudE18E5bOY1xt3s=;
        b=d/ILWpfvC1kh0HrUwTeEZueIOIJS70kILQ6h/KHfZrZXWnbBP4I4UdwvirB7/UIM/E
         uMh6jV+oZwN70eAKJzT1t0V4TRTFrLaC46LZMAGhvdlFJmGBWTyzkgTL1cB/mX/qIxlg
         QSPwmPHjDoq/DRctBik2Unox8VK5XV9Lbhbm4XhOfFxtnPdVpxfVn3EJSqC5n0l1tTRo
         8bSiEgRGTogif/YWfyxXbwWwV5H07DhlUjedMbnnEKu0AgsQmo4j+d55R34OFZi2gTHD
         r9OTmngqg438Cws0JULYHj69ekmvVc7xaX6SGmkxWBzXYnprYa95gwlQgwQTVlp2OuEQ
         a4QA==
X-Gm-Message-State: AOAM533I3aX+fhkkfA4AIkU8sRxe9AAWCw2p+/6RDkLBPRN6v1fLoPZm
        Q9/3AHyK4sLh7DLXhYYgLPNN4U0LSG0GC/ZdkWxfuXND24Y=
X-Google-Smtp-Source: ABdhPJwxiwCh2uwGdUiJUW7gvmEyFvufsWnLatUOLret9zV2DhWSQ4894NzJYt5jWjSfCL1NVhr6mZBhJ2mNHjwI5n0=
X-Received: by 2002:aa7:8ac3:0:b029:28e:df57:991b with SMTP id
 b3-20020aa78ac30000b029028edf57991bmr44505295pfd.38.1620981629442; Fri, 14
 May 2021 01:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <xmqqsg2q9xts.fsf@gitster.g>
In-Reply-To: <xmqqsg2q9xts.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 10:40:17 +0200
Message-ID: <CAN0heSrzkexY9K=VD=y0h9D0pVh59BjaLLg0pEo-WxsP+s0juA@mail.gmail.com>
Subject: Re: [PATCH 0/6] AsciiDoc vs Asciidoctor, once again
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 22:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Some of these rephrase wording such as "other peoples' commits" to avoi=
d
> > that apostrophe at the end of a word. I'm hoping those rephrasings don'=
t
> > regress the quality of the text -- if they do, I'll be happy to try
> > something else.
>
> It is sad, but we really should try "something else", unfortunately.
>
> I do agree with the "motive" very much---even though condensing it
> down to plain text before running comparison already loses too much
> information, doc-diff is the only tool we currently have to
> effectively review regressions in rendered document, and the
> proposed transition cannot be done safely with confidence without
> being able to vet the differences.  I am happy to hear about 17%
> reduction already, but the requirement to rewrite things like "other
> peoples' commits" is a dealbreaker.

OK, calling it a dealbreaker is fair. Thanks.

> A typesettig rule like "instead of double-dashes --, use {litdd}" is
> an acceptable way out.  At least that wouldn't constrain what the
> final product that gets delivered to the end-users can say.

I've done some experimenting now with a new attribute "apos" which
expands to a lone SQ. It seems to work fine across the different tools.
The rule could be that all ' should be {apos}. That's a quite
aggressive rule in a sense. It could be narrowed down to something like
"... if the paragraph contains other quotation, such as backticks or
single quotes", but that's probably just overly complicating things.

I don't see an immediate need to go s/'/{apos}/ just because we can.
We've identified five problematic spots, four of which are with the tool
we're moving away from.

Martin
