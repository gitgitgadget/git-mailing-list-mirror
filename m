Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B646EC56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC432086A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 22:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ+qKPje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbgKXWMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 17:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388279AbgKXWMA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 17:12:00 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FEC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:12:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a186so368847wme.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYvgm7FPjXWJQ45uOC8GPhd4vnxLFBs5gBUbNiWI48Y=;
        b=mZ+qKPjeFUdEjj11QJq/GiinFyc+uIOJwq9I80txXU9Noj7FnI5URImC1e0SuAdYpC
         gLORajtE0KPMLYfJqqTIDio82bPpJ2laWZ3l5r6CDmudBVKLvdR7BAZHM3z86RWGaGN4
         uzaJAU+XJOJ6VHnDUQ3p1HY6bzTUm0iarV8oukM4u19+Lixfs5QVqRihCCMOFiWxvYBX
         C3WmNEN0q98APOKc+frTtn5H4Qjd8z3k6XGE041nzCT9RqlnlYyOt6Xt580sRP9R5pE0
         H4CgQa5Ow1TkcS/cxGaNnXM4sbCkNHpxnLGtOHUxmDMkzjMvJPxTWwNLNuymeT9YeMM+
         0fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYvgm7FPjXWJQ45uOC8GPhd4vnxLFBs5gBUbNiWI48Y=;
        b=fIwmkx5cRP1kmgTineTs0LK3PmpecVi3bNYtu4Sbj2eL26nNMQZYzWXrN/yibgzJGp
         cbqzY4jYjdiEykgiglZsmLeyUTbKrtl+cUfJKE02IX+s0o/dFIwxH8cD2UQZ3pNCwQeK
         /rDMiVd0A9b4WV4OI0K6XWHhCURqFL2QMPxoF3EF+oOULDvUNjVpLKasXbtKaj8PiEVV
         F+hmgE0ovW+zdLMqoz2L7gSophWvkHZE2jQ2yLHdrP6dE1a4nc6EF6ieY7UnuJ9RaIhk
         sEVCSKOdVHOTLotgljhPTFBPzJjuZ9/pfiWevsWtBIhX7qJ04JKS1ZRHAyMqkpXoGSS0
         KQtg==
X-Gm-Message-State: AOAM532+k9/tNufnZfCe1zv+uk9B+Filq5u0eIivu+JnTHsQyXfgkm/H
        q79ainrp21QZ4cxAXToiNcIEq5PLN78s2CQ0xEU=
X-Google-Smtp-Source: ABdhPJzQlYQOgZD4emQ5kWk7UFCawoWHVjT6taxaBc5rTOjZEcj6Yql0DWMlftlXbPGTafkQy+Gb7Zi+70zbZSLC3ew=
X-Received: by 2002:a1c:a145:: with SMTP id k66mr466356wme.173.1606255918097;
 Tue, 24 Nov 2020 14:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net> <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net> <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net> <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
 <CAMMLpeSoGtqeCm6u-zrHqvPhW7brvNk_kwde3uqmbPcP1JgMHg@mail.gmail.com>
In-Reply-To: <CAMMLpeSoGtqeCm6u-zrHqvPhW7brvNk_kwde3uqmbPcP1JgMHg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 16:11:47 -0600
Message-ID: <CAMP44s2z3vv2LwoMesydVL3qWrJh0VvHSUy+FpnqguoipRRD9g@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Mon, Nov 23, 2020 at 8:41 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > 1. git pull # fail by default unless it's a fast-forward
> > 2. git pull --merge # force a merge (unless it's a fast-forward,
> > depending on pull.ff)
> > 3. git pull --rebase # force a rebase (unless it's a fast-forward,
> > depending on pull.ff)
>
> I'm not sure that we need a new --merge flag for this. It sounds like
> we just want pull.ff to default to "only" if pull.rebase is not set,
> and if pull.rebase is set (or --rebase or --no-rebase is passed on the
> command line) then pull.ff should default to "true". If I understand
> correctly, that would get us everything we want without adding any new
> variables or making any major changes to how Git works.

Before making "pull.ff=only" the default, we need a transitional
period in which if it's unset, a warning is printed when pulling a
non-fast-forward branch. This is what my patch did several years ago.

And yes, it should be possible to do what you suggest, but have you
tried? I suspect both the code and the documentation would be quite
convoluted.

Cheers.

-- 
Felipe Contreras
