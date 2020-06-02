Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED64C433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29306206E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7VpPK0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgFBTLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgFBTLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:11:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B9FC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:11:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so13888600ejd.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=06Go+qkYFYP4YFXm231GpMn7fJo4+RuYYTziC5rcMd8=;
        b=F7VpPK0nxowBMwuVFCDGBBi7gW4Pe/68069yO10B5Upeo/B7kJvwUiPCIq7z4+2VRC
         8UTtHFlpfEGKXH3jgptX/hZ3jy3eWkogVgTBIVbj/be+IjGcFoa/DZlf5zZI6TK29C6O
         VhyELCsG/asWuLFe0O/xhdCCcsaJfTSRfBD3FCuJax97DxbHMTUeSj6oWnDDX+qqjDbK
         lmHvK/GdNwx66yec/n/tBdP2bcXC2D4arNRQw0vC2x4KuZ2ky2v1gcovSkILZK7scKz8
         +2+Su9TWBOECOAgwgOfy6XNgocoyRhfxoW7230eXGNE3xEV6emEqZCRIQNGEKoIsztFq
         Tu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06Go+qkYFYP4YFXm231GpMn7fJo4+RuYYTziC5rcMd8=;
        b=i7ggFVack5mo+BzKsPTU0HIV4tMGG2GsHKZnpBPCCu8vxuHm7RJasvF451/2aWmEY4
         cPaQbVZmAI2zsk73BmC8FKxoOpXuQWxAM/nmsRuXrxF0r6Tcn4Km2vFOO8yjO3mgRXq7
         cTucM/zwi+8cacoX9N02kPG3e6lwCO+PfxP4GyZQKAmj2GZCE53ZXpkX3ry6Jo0XLH8V
         Efq2nFeCGA28EyB3zxUxgcGBIOPpQOgNWqlCV6BRKXqnvdhKm6C2bz8UIlQ+7+/4GoIa
         owGkKvzqwpUUvpHjxyuoFpzsPWQxQciS6rG2pJCTykathheImQJM6ndpDCHCgP5hXr/Y
         fu7Q==
X-Gm-Message-State: AOAM5301xBp9UxaknkDkvoi/eEBdnoW2EyS9jFqTZ+Jhq21zjmG8iHJb
        ebrHrEbjh4YqW/PXKF7tqcU1qSvZ/xusJsx5Lms87vgk
X-Google-Smtp-Source: ABdhPJyN1gZIkufeB4+YNBpx+HLIO1xUNrnOeyyxhVECRP1q+YwhH4KYNe+xQmQYGlfrAAc1FK+Ze2tb54Z9+HgFz/A=
X-Received: by 2002:a17:906:e47:: with SMTP id q7mr11347125eji.279.1591125069424;
 Tue, 02 Jun 2020 12:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com> <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
In-Reply-To: <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Wed, 3 Jun 2020 00:40:58 +0530
Message-ID: <CA+ARAtoDzoU=eu0mJom7LwVF60k4CtiuBha-RC7zkx9o7O=H3A@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
To:     Git Users <git@vger.kernel.org>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>,
        congdanhqx@gmail.com, Junio C Hamano <gitster@pobox.com>,
        liu.denton@gmail.com, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 3, 2020 at 12:31 AM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> I also noticed one other thing. A quote from
> Documentation/CodingGuidelines regarding the usage for reference:
>
> >  Optional parts are enclosed in square brackets:
> >    [<extra>]
> >    (Zero or one <extra>.)
> >
> >    --exec-path[=<path>]
> >    (Option with an optional argument.  Note that the "=" is inside the
> >    brackets.)
> >
> >    [<patch>...]
> >    (Zero or more of <patch>.  Note that the dots are inside, not
> >    outside the brackets.)
> >
> >  Multiple alternatives are indicated with vertical bars:
> >    [-q | --quiet]
> >    [--utf8 | --no-utf8]
> >
> >  Parentheses are used for grouping:
> >    [(<rev> | <range>)...]
> >    (Any number of either <rev> or <range>.  Parens are needed to make
> >    it clear that "..." pertains to both <rev> and <range>.)
> >
> >    [(-p <parent>)...]
> >    (Any number of option -p, each with one <parent> argument.)
> >
> >    git remote set-head <name> (-a | -d | <branch>)
> >    (One and only one of "-a", "-d" or "<branch>" _must_ (no square
> >    brackets) be provided.)
>
> So, according to this, I think the usage should be ...
>
>      git submodule--helper set-branch [-q | --quiet] [-d | --default] <path>
>
> ... and ...
>
>      git submodule--helper set-branch [-q|--quiet] [-b |
> --branch]<branch> <path>
>

Apologies, my mail client messed a little with the formatting.
This should actually be:

    git submodule--helper set-branch [-q | --quiet] [-b | --branch]
<branch> <path>

> ... respectively.
>
> > +             NULL
> > +     };
>
> ---
> Footnotes:
>
> [1]:
> https://github.com/periperidip/git/commit/9a8918bf0688c583740b3dddafdba82f47972442#r39606384
>

-- 
Sivaraam
