Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B06C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 08:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3F861448
	for <git@archiver.kernel.org>; Tue, 11 May 2021 08:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhEKIEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 04:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhEKIEr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 04:04:47 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A55C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 01:03:41 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso16829656ote.1
        for <git@vger.kernel.org>; Tue, 11 May 2021 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Il/RZu7X8bSwODUYLblzfiyio8lfrMGkEeg7nRe+9Aw=;
        b=uvmZSz1Qko1vcd5OLMZJYaj7J4mVYRS0WoAslL4A4e5xPulC6PHRMp+1WB1J0S2bAK
         Gu1qU8ei1YWXpYqMzdIRhKRX5s1plH2O3AifiDbvr2P6wLkkJ1dY1lfElQSFcVaeXQt9
         siXWFH4GkA0etm5D3wA4350oZf7TtuS8ANty8+mT8WWscx01tjz5Qak+1tyIkpHjUkQl
         UM5GmwNSplz1G5F5QHuerfmyRi7jhYvVG3dX4kiSSGVdGpjLqsIvVb7qTRyAiq87chXe
         J8hRwhzHKkR01xQ4yUrJjfrZLHVGoXJZalVNVachXbE+onjnkdJ3sRhQQYrp1VdnHggk
         Je5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Il/RZu7X8bSwODUYLblzfiyio8lfrMGkEeg7nRe+9Aw=;
        b=Isvb6tDts2xmlqM0km0/bAZr3D9+NwtWt51O3NENCogin7YTP7ELCtLHBe51AipLy4
         X/zw8PbBuZk0UlSuXNhAXUIPSYYCI221SR9/ceYLUBojkVO6IEm2dVWIVB9Xu2Ue14w5
         56JehfTkGOWutoXeee8mInOrT3LTgLtbhKSsmgDeXNQ1TMjBeG9KV9VZhbIdE1/EsQ3F
         X3Tj1l61rpkCUF5/nyvDiUvjKN7aFt5TorVQeyW8RMdBZKtSWKWAvhz8Phy9fTP1kBzO
         zwf+D+fRtMg2UM8dRzGalt2gOL/KZqTUHmDL6/NrMeDKYaB9FKVozDa1wURER3Tsqosv
         k61w==
X-Gm-Message-State: AOAM531LsryIymOW6LjjR49p1IAJwBjiW5O63e/Z7sSZo/fIfJbKNeMM
        fRjPDdZbQ4FrgTWbzsAAWhc=
X-Google-Smtp-Source: ABdhPJyeMgHAx6s4wLQCcEcXJWt1C00PCVfOyHeVFRLxkdUYIuSWmHAlVIeEFF4QP0cq8X0LDyArUA==
X-Received: by 2002:a9d:5f82:: with SMTP id g2mr24778751oti.4.1620720220420;
        Tue, 11 May 2021 01:03:40 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id s85sm3194710oos.4.2021.05.11.01.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 01:03:39 -0700 (PDT)
Date:   Tue, 11 May 2021 03:03:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <609a3a5a7aa08_5d5d32088@natae.notmuch>
In-Reply-To: <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <609a07ca6a51c_5afe12088b@natae.notmuch>
 <YJogn8cUtSP/BAbJ@coredump.intra.peff.net>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 10, 2021 at 11:27:54PM -0500, Felipe Contreras wrote:
> > Jeff King wrote:
> > > It does create a situation where people like Randall on NonStop might
> > > need to do part of their dev work on another, more mainstream platform.
> > > But I suspect that is already the case.
> > 
> > Or use distributed tarballs with already built documentation.
> 
> For users, yes. But the context above is about people who are
> contributing to Git, and writing their own new documentation. Presumably
> they'd like to build it to see the output.

I'm a developer, I've added 261 lines and removed 212 lines to the
documentation, and I've very rarely built it. Why? Because it takes too
long.

But you were talking about Randall, who I don't know what his role is,
but my bet is that he is a packager. It's not the same thing. Randall
has contributed only one patch to the Documentation, and it was to
install pre-formatted documentation. Precisely what I thought he would be
interested in.

In fact, the bulk of his contribution was to install-doc-quick.sh, which
needs git-htmldocs and git-manpages. Two repositories I didn't even know
existed. So that's yet another option for him.

Of course Randall can say if he sees himself as a developer.

> > > That does make things a little less convenient; Debian stable, for
> > > instance, still has 1.5.8.
> > 
> > And it has git 2.20.1, released at the end of 2018.
> > 
> > I've never understood developers worried about how the bleeding edge
> > would build in ancient platforms, when ancient platforms don't care
> > about the bleeding edge.
> 
> Again, this is about developers. Are there people contributing new
> documentation to Git who are doing so on Debian stable, and would be
> inconvenienced by needing to upgrade their toolchain?

Developers don't need to create (or use) debian packages. They can
simply do `gem install asciidoctor` and be done with it. Some may even
create a docker container to install all the doc toolchain in order to
avoid polluting their main environment.

I for one would start building the documentation more if all I needed is
one dependency.

> > > I'm unclear when support for python asciidoc goes away here. Is it part
> > > of step 6 (because it does not have another way of generating them)? Or
> > > does it live on forever as a non-default legacy system? I'd prefer not,
> > > but as long as we are clear about the primary target and leave it up to
> > > people interested in the legacy to do the compat fixes, that might be
> > > OK.
> > 
> > How about we leave the legacy system in place as an alternative, and
> > decide later what to do with it?
> 
> That's what I was asking.
> 
> Leaving it forever does mean supporting xmlto forever, which complicates
> the Makefile (and that support will bitrot if people are not actually
> building it).

Indeed. If and when it's clear the xmlto part has bitrotten, and
people are happy with the asciidoc toolchain and output, then it can be
obsoleted.

That would be my vote (I don't think there will be a strong need to main
the xmlto parts).

It doesn't need to be decided today though.

-- 
Felipe Contreras
