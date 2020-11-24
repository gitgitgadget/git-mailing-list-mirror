Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8980BC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5CA20729
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctqjBmcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgKXAIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgKXAIa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:08:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4540AC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 16:08:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so20531149wrb.9
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 16:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00Kt//0l099CzUj5Cf8KXSROC5acIbrAL+tEqQLeiXM=;
        b=ctqjBmcK2OOP+eELH6Ng2cgJistUeJkx+YlnP61GfG/GHTVJGPbu9d+gIwe28OP1zN
         349EVDNjVnM4yGM0QgI7oVJeV/7CHcPc6s1twp4ozHq13O67l6TqRoaioRMpWDi/6SSw
         jTwU58JLNYEIBAXRH2lTGIqZHhCo8/cH5OQqZ+NUtEfPnLXy0OQOOL03UuoZlNE7WHtq
         aGbYFS8hMcOIxqKGP22u/hPxr3bC2cUA/oiT8g8eTDXWDoubGHqCN4nPdYPMa7eZKuT3
         qOZomFd8PLYfZKloTqpK2xL7hw3zFf+vZKJQpxJJIe2cOCJ01yGubfNkIsQrkGlqo2RV
         OEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00Kt//0l099CzUj5Cf8KXSROC5acIbrAL+tEqQLeiXM=;
        b=YnlMmID+Im5yH43o8WGcSsPJcHogVl7aehVMpaMHp15AUlX0bpawb79ArawbjP0o57
         LSCZ2FI7/Hfa2ZKhw/ybLNSk+oAglsOw2a3tC+ojn7pwNadXmEgBTSEvykGOtHQK5A6F
         gKfLCxWJuCTV9smlRap16RVbm87ngySI0uGfXegHlvDPvE1oIc0gjSRNe0Y/cFmM0Ce/
         lMLrfawWv/VXJvPv3QJlcb0QvhSmTb+CH1QgXYTsJ1+sz6QxhfGe0DuBDZPnllw3ILsg
         DQ6o5qjgz3aP9qpiVol4ASt7S0ysbHM88R84o7Mg5PqdcyUGQ0fSG0Vd3rrr0Nsi+5Od
         CxqA==
X-Gm-Message-State: AOAM531kY87bCpXhhrj2L1g2Ib5A7GdJxz1vxgzOL8VcaxwsD/eKrX6P
        slPpySC9rDcWXgVvweAGIHN88GSj5u5reWxrXGI=
X-Google-Smtp-Source: ABdhPJwv7v+5hih6CrlvwUl/zLLBpLH8kKOtX4IbE18l/ybosGkUZtfeq8Zv44snaXB2NTmJGLoA7paQmqeQwmkE7DY=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr2094200wrr.319.1606176508366;
 Mon, 23 Nov 2020 16:08:28 -0800 (PST)
MIME-Version: 1.0
References: <20201123224621.2573159-1-felipe.contreras@gmail.com>
 <20201123224621.2573159-2-felipe.contreras@gmail.com> <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
 <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com>
In-Reply-To: <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 18:08:17 -0600
Message-ID: <CAMP44s0r1vf7x-wHP-b6KQRU7mcPSZzcMRK2VqqxU_SJRDs+kg@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 5:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Mon, Nov 23, 2020 at 3:46 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > This patch leaves everything in place to enable this new mode, but it
> > only gets enabled if the user specifically configures it;
> >
> >   pull.rebase = ff-only.
>
> Why not use the existing pull.ff=only option instead of adding a new one?

Because that option is only for the merge.

I'd have no objection in refactoring this option so it's used for
both, but this breaks existing behavior. A user that has
"pull.ff=only", and does a "git pull --rebase" might expect it to
work.

My main interest is what happens when the user has not configured
anything, which I defined with a "push.mode=default", any option (e.g.
--rebase/--merge) would override that default.

-- 
Felipe Contreras
