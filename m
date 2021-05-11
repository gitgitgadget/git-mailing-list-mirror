Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D3C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E306190A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhEKSqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhEKSqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 14:46:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FEEC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:45:24 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z18so7675016plg.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4e/0TeYpOvmUBdbMLNTy8FUhCZ8epdDqHG3SUytV8Vg=;
        b=JeKphhKpxcke/v+Zl1crwz3bg4ifWhyQrrao9xl+dIod0NPucuYEKsqvRgF8HWC/0Y
         6E5LMbNhGFzlKkYd9Ls7pvherM5gCIcysgfYNRlEs8eKKU4Tu5Us2ULiTxdVLZS3vFry
         dXa1ZhzHQrI0rExRb0GACxCvgCmbfcWCrCKX7DkQMNs3VOpFPfaaqrsNluOtkHCh0rCq
         r16we2kG0NZ5PSppvbv9uFMhLn+tgsj3IQSSL0kmjbTX0BT99mzLp5PMjeBezmkLVuC1
         raxoQuqH6pku6+J17JmFQBSZPrFZh96Q0F5eHMxi5mfB6ICTdUvnAmrr5j5DBTdcAvJZ
         w65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4e/0TeYpOvmUBdbMLNTy8FUhCZ8epdDqHG3SUytV8Vg=;
        b=AAGM95fWRIu6RXjcQoWVZ4Yvl5OCdFKUqsgAHVnY52L2G0H2zh4XUfoIBavS/FQBoW
         cHObXQwLKc4NNIsOojnlA7396uPwPF034VMtUWU7eQ9gl3uRD7ajoa8o1lX9d7OcAqKA
         /7fQv6MM7sVbApxAela0y5sdwCWm3ybUnbzrJ1v7O51YWwbUySficZQ/g1Dx1CeVDFKP
         HutUn10BawngKNUelBbbiKshvRAQqpNOB8sjTM2A+Cb2ejhsiibvY5aMrcVwrkHJVJRg
         zs7rzbiKZo/MgjiXtVKp6yTZ3pDEIF4lnYyLapHV4e6lrooPaGEkHqgNkoanDRxRGPoA
         ZUtQ==
X-Gm-Message-State: AOAM5328WKvUmT0hcAiQPoJjayzixR+rb9pdsH2+hESPsIcdyKjc4LCu
        +PhS7ZX3NZliJRw9wMMTz0lYtV8Cibc9uKgT7LQ=
X-Google-Smtp-Source: ABdhPJztiLWmno+Y7wpaWSiUpx1h4DtuZc564gCD543NZMSDqPwhYAYjcmKMkrUOxalUbk4a24bupZpNxYp/9/H7b6M=
X-Received: by 2002:a17:90a:9312:: with SMTP id p18mr6545413pjo.171.1620758723750;
 Tue, 11 May 2021 11:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com> <YJmykGWaWi03+WoW@coredump.intra.peff.net>
In-Reply-To: <YJmykGWaWi03+WoW@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 May 2021 20:45:10 +0200
Message-ID: <CAN0heSp6uw7yqNZLD5w13xJUgnUtgHM0OYw9KQ6Z-FKk+x4OPA@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 at 00:24, Jeff King <peff@peff.net> wrote:
>
> On Sun, May 09, 2021 at 10:20:37AM +0200, Martin =C3=85gren wrote:
>
> > it was. So it's not so much "we should flip to avoid a bitrotting
> > dependency" as it is "asciidoctor is arguably nicer" or "it's the way
> > forward".
>
> I'm OK with those arguments, too. :)

Excellent. :)

> > When we looked at xmlto-less rendering around two years ago [1], we
> > found various asciidoctor bugs up to and around version 2.0. We would
> > likely need to require some >=3D2.0.x. The exact requirements will
> > probably only become clear when someone really does the work.
>
> That does make things a little less convenient; Debian stable, for
> instance, still has 1.5.8. It's not too hard to install an updated gem,
> but not quite as nice as using the system package (it also makes things
> weird for building the stable Debian package itself, which would want to
> rely only on other packages; but of course any proposed change to the
> doc toolchain would be for new versions, and would not get backported
> there anyway).

Right. And 1.5.8 is perfectly fine for ascidoctor *with* xmlto, i.e., as
long as we're discussing moving away from asciidoc, not moving away from
xmlto entirely. And soon enough, Debian stable should be at 2.12. ;-)
(I realize Debian stable was just an example.)

> > I think what I'm arguing for is
> >
> >   1) switch the default to asciidoctor,
> >   2) enable optionally using it without xmlto,
> >   3) figure out what broke and fix it, and document which is the minimu=
m
> >      asciidoctor version we're going to bother with for (2),
> >   4) lather, rinse, repeat (3),
> >   5) switch the default to not using xmlto,
> >   6) drop the xmlto way of generating the manpages(?).
>
> I'm unclear when support for python asciidoc goes away here. Is it part
> of step 6 (because it does not have another way of generating them)? Or
> does it live on forever as a non-default legacy system? I'd prefer not,
> but as long as we are clear about the primary target and leave it up to
> people interested in the legacy to do the compat fixes, that might be
> OK.

I think I meant it to happen somewhere in step 3 or 4, I just didn't
call it out. If it happens super-early in step 3, that would perhaps be
a bit unfortunate. But if fixing up the last few bits of
xmlto-vs-no-xmlto with asciidoctor involves giving up on asciidoc, then
so be it... If nothing else, we might all of a sudden find that our
asciidoc-processed docs look awful and that nobody seems to have
noticed.

Martin
