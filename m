Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4F0C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C513161A7C
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 23:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348163AbhKOXTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 18:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346015AbhKOXQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 18:16:30 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388EDC03E021
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:17:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m20so32640489edc.5
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X3pdQS0BnOvI1WA9u0iLCWbsnE4ll9LjulsL7wZNtNw=;
        b=KSSniRsdilVkannhIBUjGAsuVMvPYVAxRiKgxs0PgXZl/O044j+2EX9ATvRM4aoRaX
         c6VAJDzgRtaKX8MEYWbyoyhxT/uPl3NwaINUfFn8sEo+z/IYMJTrJGK5/duhPwvwWHrb
         KO6APER8rpGOSgqxIFgWcFr5qUr20H6llQ1rEz0hzzXAd/8a1MpyiTzDnYvW7u6Q555j
         t9ZpWIY7vtEV2D6xV3PtrvKTesrTIy2f2QORw3UzGmuQJRbI0aCLKv50aq08QUHeBj3M
         wdBo3wwtye39S/tZe57F0m58ALWW/envUZTajRMujNazQeC5vInacFCoU//HllnIHIV2
         tpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X3pdQS0BnOvI1WA9u0iLCWbsnE4ll9LjulsL7wZNtNw=;
        b=Bv1yePQ4o9jDN8GBb6G3888+rl59peqRdw+XqD88+D8ApamiF3uHMNjhZ5nRxNsUTW
         ZnBTNVktJU8B4WYySKw5X0gag+kjWMuC8aPxsfIovC9V3EzafDGlD459R2cLmkZNhxOk
         AokQmJHCLs7u/ZSfXFqZOxLNhzFdmwc4h9bR80phGzZ0jyQ8TKrxJlQlEy1pBfplZxgq
         KlHR8FbRMrPsgqPGXs17HhRAEPwpg7fvF8MUW1xzkV9tqfE5AebdiLXtKyS0EbKZNpaM
         TeR7rcdbwQz+4evN1bgZg5/4j1L6pnAU4tDAJte3IBo01yGgvySNi9iTNkw16XLEzt9u
         9emw==
X-Gm-Message-State: AOAM5324setXGotvlsQH/nkhLh7YKp312Tl/8BdFNaQFp1Sy4c791qtx
        hMBg7YvDNWdGj8yKV/Tj2eZFF7KQRFTQEHEvScw=
X-Google-Smtp-Source: ABdhPJy1SbCjx/Ey16ydkj93LI7DhWiw9pjRFZtyZVPIzXK3Dkakc73w9vqTPLNgyrx8rpv65bfefXvsQG94nG0zrcM=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr3292117ejc.74.1637014621739;
 Mon, 15 Nov 2021 14:17:01 -0800 (PST)
MIME-Version: 1.0
References: <xmqqv90tfhh2.fsf@gitster.g> <211115.861r3hrz61.gmgdl@evledraar.gmail.com>
In-Reply-To: <211115.861r3hrz61.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 15 Nov 2021 14:16:50 -0800
Message-ID: <CABPp-BES7SX06i3+AZS2gxkGdbS6nHy5r00E_WhMaSpZ6PdjrA@mail.gmail.com>
Subject: Re: ab/mark-leak-free-tests-even-more (was: What's cooking in git.git
 (Nov 2021, #04; Sun, 14))
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 12:35 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Nov 15 2021, Junio C Hamano wrote:
>
> > * ab/mark-leak-free-tests-even-more (2021-11-01) 15 commits
> >  - leak tests: mark some fast-import tests as passing with SANITIZE=3Dl=
eak
> >  - leak tests: mark some config tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some status tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some clone tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some add tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some diff tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some apply tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some notes tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some update-index tests as passing with SANITIZE=3D=
leak
> >  - leak tests: mark some rev-parse tests as passing with SANITIZE=3Dlea=
k
> >  - leak tests: mark some rev-list tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark some misc tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark most gettext tests as passing with SANITIZE=3Dleak
> >  - leak tests: mark "sort" test as passing SANITIZE=3Dleak
> >  - leak tests: mark a read-tree test as passing SANITIZE=3Dleak
> >
> >  More tests are marked as leak-free.
> >
> >  Will merge to 'next'?
>
> That would be great. I've got a rather large queue of leak fixes
> pending, and due to marking up the tests incrementally they've pretty
> much got to go in sequence.
>
> For this sort of topic that's just marking existing tests as running
> under the linux-leaks job I'd think it could proceed relatively quickly
> after it's not been causing test smoke on master/next/seen for a bit,
> which with the release cycle has been a couple of weeks in this case.

I just gave it my belated review; I think it's helpful and also pretty
simple.  Merging to next seems like a good plan to me.
