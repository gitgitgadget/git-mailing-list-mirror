Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A88C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D314613C5
	for <git@archiver.kernel.org>; Sat,  8 May 2021 17:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhEHRm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhEHRmY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 13:42:24 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA50C061574
        for <git@vger.kernel.org>; Sat,  8 May 2021 10:41:21 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u16so11847712oiu.7
        for <git@vger.kernel.org>; Sat, 08 May 2021 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bSPTNMGM7gK/xrg0CsnGaJi3D9swj0MHLbSmckBDL5U=;
        b=EQQWC7RbbQKiTxv+1nl7havObnJsKzHasYr9KlvoBQZqT7FRByz5+DNPuSU7ZIB8Vt
         DnncUgOaS35EQJhh/VVRRcKeVNUDK0A+ZoG4cdiiQX++MevtUQwikU07fIeb/qa2rR5w
         nqvYyELYUgOKZgdN6tDpDzM0zwevhODXDgxwOQT0uEXJVrT+jmSsHvvoVYvnYHzUO1tg
         cBAs94nhTKINPmNvVPuWQ1cam7KoG0lpuVty/dHsMkDpSaUSw7FVH5JB0gP0j0xQBeWq
         sZ/Dz2WMIE5GEVDkoM0n5q81jAm3s13v1/harYsgV47O8wDujAcUjnekhj4rdqvgv0Ub
         HMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bSPTNMGM7gK/xrg0CsnGaJi3D9swj0MHLbSmckBDL5U=;
        b=M1sQwkKhLQ5H3jNsEDif6kMXiBBx3ygGqd1seSM4dtcuoRib1i5iJHSF4jqDIFGN1R
         EryZI9xSvxCqNb4En+b5BIca552wSyN2J61lg6MQTvIqiXZ3RS1d06mGNFrHhvmcUr4Y
         IEgy/Y9NAyAnCXQ5CuDQqy0daxudXSo59K6CFUfPVhNZHF7iZByniNGLM4R0x5Lxb6/Y
         Oe26gNs5DDswSYgzy3K5QW4tve4rku+OJCxjmPm9G/Eqx3/s///8QZcghKgejB3NcbjY
         btxc6F0XY5i6BHwwYHN7mDaykvImKJMjP8AsC5kbSGCjzQKEZnXlnz3bFviBjijwONNS
         D5nA==
X-Gm-Message-State: AOAM532GJgC+9NzJvafn/ZFJ3XjRLT1O/zz3QZCk50jeKa2sNaZVC0DK
        kbauoeU37kDNm72OiXIax1WBudeCYZG2jXWHkcc=
X-Google-Smtp-Source: ABdhPJwkPv2a9+AkEOkboHdb6OEXFb5a3PYxhxZsa63obCORHYoFeryMPYCSQvTaP66OA0ns7GXf4TgGCGTWAQ6RA3s=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr19103924oia.39.1620495680976;
 Sat, 08 May 2021 10:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
 <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com> <a3bd253fa8e8ae47d19beb35327d8283ffa49289.1620432500.git.gitgitgadget@gmail.com>
 <xmqq8s4pv87t.fsf@gitster.g>
In-Reply-To: <xmqq8s4pv87t.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 May 2021 10:41:09 -0700
Message-ID: <CABPp-BG7Rp7QtSSDCwjmOC=SJZ7Uuw8Uddtu+VHbiFaRQAUJKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 8, 2021 at 3:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +             # alpine-linux-musl fails to "rm -rf" a directory with such
> > +             # a deeply nested hierarchy.  Help it out by deleting the
> > +             # leading directories ourselves.  Super slow, but, what else
> > +             # can we do?  Without this, we will hit a
> > +             #     error: Tests passed but test cleanup failed; aborting
> > +             # so do this ugly manual cleanup...
> > +             while test ! -f directory-random-file.txt; do
> > +                     name=$(ls -d directory*) &&
> > +                     mv $name/* . &&
> > +                     rmdir $name
> > +             done
>
> Another thing: this not being a test_when_finished handler means it
> would not help after a test failure.

test failures are irrelevant here; this code is here to help
test_done's directory cleanup, which only fires when all tests pass.


But if I restructure the series, this whole section of code
disappears.  I'll do that...
