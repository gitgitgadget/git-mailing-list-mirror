Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65CC388F9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6862820717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk/lcN6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbgKWWzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387788AbgKWWzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:55:44 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D948C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:55:44 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p22so861675wmg.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=et78JqhEJVv3fqTKmE3C0UqkaQ5RAT/RfzFvqFCsD8w=;
        b=gk/lcN6IgmfnR8x4uvzwSiytGPqvbgaISOAkvAhz1TNv28NHCBb5O/BGk8dh8psAYO
         owhguxL9cOar7ZDDgLQw7A47Zc5ZbJ1wE3BNWHMYgc+k21Edy8TwMzJ1fqjS7eby8276
         nhmL2emHU/gNQE6sn6by2+YBM//CL2qeYrvpY085VggDie66MiIVopBTnVoDv5PQggfx
         JayVcVdIzgd5mqvMcsUvXo9NQMCuoXBc+kMejM4x0LuR8gzCIGsMYpsC67My0MCmPkUV
         ip6JrkUd3mF0f5qUMeRqFRfZwQzqSuaGx5yhiRKo5cfTfE448Xgkl8GhUGrHTK+kSiFu
         p3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=et78JqhEJVv3fqTKmE3C0UqkaQ5RAT/RfzFvqFCsD8w=;
        b=jIqdcfQmY2ckoVnmN53SE2rPuKtNvE88CvPFPdjuj8SiiRtGmjJL0pVfr4gsQFdthB
         ql2A9SK9TYbF8I1lBumCeI9FXPqpJ1Arhd1bLt0dg7Pfb2KE0iPUKxUPa0JZg0sHpkye
         AaIZV8Rafk0bKpOcGjJFe7hnZyZz5ouGrvmTC8S06p4t0bp38fbK3rj9HiGqXEnKO48b
         qUAJXDNseFAorecSWoWH/zWWofg0lHA1PAmRcHJV5Jr5z9CXN9B1sNzdlsJ+otKzlP0a
         gb6Y21Pzb78bcHlWIPgQ2AzAs4EezQBWE922Ws9EsHEmz3R9pbc5ZZImk39XGK37aUM+
         28XA==
X-Gm-Message-State: AOAM533os2GdLnQ/Rl6BBCl2IouLZEdIFutUbPDX08WIgtS6Qyi1svrM
        aLfVhChMHad0cmp48y0JvJNR3Sl4ynTaPMhwrGzz/TUKlvFnJA==
X-Google-Smtp-Source: ABdhPJxf+hJDVypBKgN++zf8I8+PdeuAQEsdYaR7vcTpDpe+RySkyLwVHhAMFDXJxfJ6VAQJpMDqouXn/6KXYdUvXgU=
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr1170769wma.48.1606172143104;
 Mon, 23 Nov 2020 14:55:43 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
In-Reply-To: <X7wuMvHRURK1QS/Q@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 16:55:31 -0600
Message-ID: <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Jeff King <peff@peff.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 3:48 PM Jeff King <peff@peff.net> wrote:
> On Mon, Nov 23, 2020 at 02:34:18PM -0600, Felipe Contreras wrote:

> > There has never been a "pull.mode=ff-only" option; that's what I tried
> > to introduce.
>
> There is pull.ff=only these days, which also squelches the message. But
> you're right that it was never the default.

But that's not the same thing. The whole point of "pull.mode=ff-only"
was to print a message like:

  The pull was not fast-forward, please either merge or rebase.

Cheers.

-- 
Felipe Contreras
