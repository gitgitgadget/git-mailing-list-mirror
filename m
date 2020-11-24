Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC5AC6379D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E6E20B1F
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMnXxIko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgKXUWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbgKXUWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:22:11 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1D8C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:22:10 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d8so1914617lfa.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uFKISs0/7PgRp39dmJGfWRIaApfJT7W+5V/3wHlRlU=;
        b=HMnXxIkoNOUIki3MBaWA69hqfOD+a+dbuQ1yk0542HCcIvcVlpZ4ZmysK6ZnBOK/5W
         leLxk6T7Wi1Q0PomMmC8VX3YfHTkDj6Ui8rObQeLDAoU38c63b2EP/egmTIxOThLQHfq
         rE/SrCZ4jeTPEcCLJ2kfMW3mEmEwowHbP6tOqv1PGa9+n4n9dav0itLtjekrUDOzWbWe
         YOtQAOftkte1cNuWD2R/zzzmHVjLwG93nGeyM8dtjSTs474e4Iam5apylNFxJXLaL4pj
         CyDhH7uXre5n5F9yf2Er/zodeex16ia845PljuwekxN1/fuvH3q0SfkVSc4FILw1b9lp
         pnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uFKISs0/7PgRp39dmJGfWRIaApfJT7W+5V/3wHlRlU=;
        b=Z5jrmHGZup3fy7U+41pfXg85llny3C8ih3Ki3e1hiikeWPs5bLFMi5zgwIV5Tl+VXk
         KgV8U7hI6hmX1fEbD7QmELuQXBTfOw1ssmeRsmVbXpQfleiNRYkFUNRRBBzTjwE+2NUt
         ETP7g4bL9Ypaq0M7nPXwaHvpWztAIJd2NwN3kCUCQD6wv/zXJy2PgiLgrXDIVpnAahLb
         3jjp6csCYk31n1/ouTy+NbQ0o6xJKDkr/ayZu9s/qUNCotS5D9INc8hkhxQgzdC3bz57
         zYDLZPWkFGngee9y3tjZuEveq+Cx/ZKlD8pQRZzljJIhddgQyhTgNl1nhdmi+uS/FNLj
         cxSg==
X-Gm-Message-State: AOAM5307I5X7ECWlQhq/DQKGl8peSExYRf+uhdDNPbM+UrvUd83l0aje
        7uTzm6dJkANvkEOJ5aHdVluu7Fs11aJv7CxVqyU=
X-Google-Smtp-Source: ABdhPJwdUq4pFmpb/18EkggrDPXPdSmc0YiTVBD4DrDHMdmoIVwXHCTdz+zfBrXBTDrXu1Ar7ztI1FMEumHIbgwkwiA=
X-Received: by 2002:a19:4154:: with SMTP id o81mr2382654lfa.540.1606249329223;
 Tue, 24 Nov 2020 12:22:09 -0800 (PST)
MIME-Version: 1.0
References: <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net> <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net> <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net> <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
In-Reply-To: <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 24 Nov 2020 13:21:57 -0700
Message-ID: <CAMMLpeSoGtqeCm6u-zrHqvPhW7brvNk_kwde3uqmbPcP1JgMHg@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 8:41 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> 1. git pull # fail by default unless it's a fast-forward
> 2. git pull --merge # force a merge (unless it's a fast-forward,
> depending on pull.ff)
> 3. git pull --rebase # force a rebase (unless it's a fast-forward,
> depending on pull.ff)

I'm not sure that we need a new --merge flag for this. It sounds like
we just want pull.ff to default to "only" if pull.rebase is not set,
and if pull.rebase is set (or --rebase or --no-rebase is passed on the
command line) then pull.ff should default to "true". If I understand
correctly, that would get us everything we want without adding any new
variables or making any major changes to how Git works.

-Alex
