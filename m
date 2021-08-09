Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329A8C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0623560FC2
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 22:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhHIWE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhHIWE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 18:04:27 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692FC0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 15:04:06 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k24so11028426vsg.9
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 15:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tc/R/8OeJmcuUPoeWbT4OOdWFn9LzTqDR1tPhaBpj6s=;
        b=gIkWFpL3TWe1f5rBnKR8LqNB+Yi4zCnII+XtmDOZfmMldaGjGxxsSIAPZfbPSnAdtE
         hA6i5rhyd/byIYezA5lEhsb1kUWU7ZKmbs8+eiUgeuA9yrhftN5iMsQlZZN3lRiwokaq
         sRck1BCzqtCCfdeid2EaQISr4HOyFfZKDSmy5xX5kA/8MXRaVeYbdLegAkHPLW8dlJWN
         dtNHo3dU1wpmPB0wLo8jzZVXTVxPECy6CTtZM+vdTAh+bNEWeOdwx8PNSMs7wk/t9yjF
         D6JOMN7k941fQXkVDjPTvriEHgCtf7POLBWxVbP7dQLahok2vxPNXK45MYTlTpCyVyxX
         BjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tc/R/8OeJmcuUPoeWbT4OOdWFn9LzTqDR1tPhaBpj6s=;
        b=rcXJXIRT5O7rvWbbbd5oShPslYwUeEq1DTqQ9I7+uvw1x7nnaNrAYSPI35XMt53J16
         wsSUg84mo3efFIin6TsyLYdpEGXnkufDPCRqTUFFTqISYJpRgWwDcgZAzWlFe9y/4f9Q
         O1ktIbt0TW94sUFyXYgx6nIQ8F262+QAXkbE0+/hBXNOpTKonuB0fRveiZ9rSmptnLXf
         h1UJOb9wHcYzQwF2f4c/0seo0ZrFyulprf4yqdX+BKg63oaWPDwaySgaDoxGO15si8V+
         lREQYmA7auLeJWiMZVbZJMbi1vmC/vaurr5zXXMNImPEFVG8aEKwtFRLpsKNIynyWnB7
         Jt9Q==
X-Gm-Message-State: AOAM53315RwSRkXeoIwrhwsXBmLhPG/YK3YfId7rPGf/0uUGF5FWEqBn
        hlocaOTwb4ObPSOjBCJu69B8M5htpYpi9ehuhek=
X-Google-Smtp-Source: ABdhPJzd/fQHd+k/sVqSXzoaaciu2+lw9/mcQti2ANZB9fMqtFkMvpel+CrIP8lerECdCGC32miPkHM0XcPxk9CYKm4=
X-Received: by 2002:a05:6102:2421:: with SMTP id l1mr16342015vsi.53.1628546645562;
 Mon, 09 Aug 2021 15:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com> <20210809013833.58110-4-carenas@gmail.com>
 <c903b477-8438-7c9a-bbbc-ec87d1b05451@gmail.com>
In-Reply-To: <c903b477-8438-7c9a-bbbc-ec87d1b05451@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 Aug 2021 15:03:54 -0700
Message-ID: <CAPUEspjtOzc-kis1P-3nhGXQR20vVP+ny2-o_BojG8mx2fo+Jg@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub workflow
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 3:50 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 09/08/21 08.38, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > add a dockerized build using fedora (that usually has the latest gcc)
> > to be ahead of the curve and avoid older ISO C issues at the same time.
>
> But from GCC manual [1], the default C dialect used is `-std=3Dgnu17`,
> while `-pedantic` is only relevant for ISO C (such as `-std=3Dc17`).

sorry about that, my comment was confusing

I only meant to imply that newer compilers were not throwing any more
warnings than the ones that were fixed unlike what you would get if
using older compilers or targeting an older standard.  This implies that
it will likely not have many false positives and the few breaks that would
come with newer compiled might be worth investigating or adding to the
ignore list.

a strict C89 compiler won't even build (ex: inline is a gnu extension
and the codebase has
been adding those officially since fe9dc6b08c (Merge branch
'jc/post-c89-rules-doc', 2019-07-25))

and so the pedantic check implied you would target at least gnu89 and
generate lots of warnings (so don't expect to build with DEVELOPER=3D1
that adds -Werror)

are you suggesting we need a more aggresive target like strict C99? at
least gcc 11.2.0
seems to be able to still build next without warnings.

> And why not using `-pedantic-errors`, so that non-ISO features are
> treated as errors?

warnings are already treated as errors, if you want to see all
warnings need DEVOPTS=3D"no-error pedantic"

> Newcomers contributing to Git may think that based on what our CI do,
> they can submit patches with C17 features (perhaps with GNU extensions).
> Then at some time there is casual users that complain that Git doesn't
> compile with their default older compiler (maybe they run LTS
> distributions or pre-C17 compiler). Thus we want Git to be compiled
> successfully using wide variety of compilers (maybe as old as GCC 4.8).

the codebase was meant to be C89 compatible (as described in
Documentation/CodingGuidelines).

gcc-4 is a good target because AFAIK was the last one that defaulted
to gnu89 mode
and was also used as the system compiler for several really old
systems that still have support.

I tested with 4.9.4, which was the oldest I could get a hold off from
gcc's docker hub, but I suspect
will work the same in that old gcc from centos or debian as well.

Carlo
