Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7A0C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 07:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4425D20829
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 07:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ+O6Qgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKJHzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 02:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJHzz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 02:55:55 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD42C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 23:55:54 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id f23so9466841ejk.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 23:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8CBr4O45BczsTAxSZdu9reZODiJe3wDzqJpR6cvsm0=;
        b=fZ+O6QgrGZI0KYfBaYrf8uYgu1w916lqiIZPKdanEEWMrIcmH2UJ0YvtcuODKuCMS4
         Kic3KInZ8f0HcFtz2dD32maFTdiHnOr/ywPg5hQBoTw3x6mW8OJnCU5na+8a2haPUSa1
         N7ayK+lW8LQghZ7vHV2yUWh48OTBB6nm0DGZW7welDp8kHE8HYX9BZH0L77I7Nkcybhv
         xLzBvlxhaN4j6Z+GXZP3Iw+cpoU5W9Bh894am3/jHPoVBhZ7zmARtHbG9HN4A4fmu6EU
         +4zg6Pcc6lidZsbNa86B3tOXb3sBgH6O8qJ+aLArJ8DMEC2veG3ztq5koB26ej3QVEaB
         2O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8CBr4O45BczsTAxSZdu9reZODiJe3wDzqJpR6cvsm0=;
        b=qjEq/7t6bawBOdOOtUIqKvadPGQdik6ao6xOH87i3HagTL+EYct3bhNc92nVees2JK
         97F6za9uy6I0ZAx3g/GHGN8fudsFEE/s9nxkjpsNmmpmRGWeiRPtwoy7ICYfkYMb/NQT
         ErFbnvq0fC3X83GE0vsmw6F24dvDUjJ9a7sRXzC+FvB0RyX/+0mJwmGdhjJAr2QI7fcD
         9MM9DyQ9sK1mIk2AuBYQT7lH+NqQRqB2WM+ISTwWEXEYzNu6BqpoX+NAuL8YPNswA0L1
         1/DsX/n9WImrj50qQMFCaiwDmCxXZm74l5/QWsxF8Ne5YQW5jPe/nuhV2qbufUxN1t4g
         ipBg==
X-Gm-Message-State: AOAM532wkvkAxkED8EcujziXqt7+9uFygIkBzMdRAWW5RRrIVzn2neAI
        6JH+8YZcaDgpZ4jfbBozBvWtfrjRtdd9u1u5+S0=
X-Google-Smtp-Source: ABdhPJw7870K60Xg5+znk86APUvunFHNWRPemmf12aNAdbtSZWnFHviU0JkcXurByq8eKH186G99hAFvqFj9VukQKis=
X-Received: by 2002:a17:906:9455:: with SMTP id z21mr18725255ejx.160.1604994953388;
 Mon, 09 Nov 2020 23:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20201025212652.3003036-1-anders@0x63.nu> <20201025212652.3003036-7-anders@0x63.nu>
 <CAP8UFD1nYgqT1k1Mc=Ea3AZkb-TdhPBzXo+N+4nWgYVxEBxzRA@mail.gmail.com> <87y2jap4ch.fsf@0x63.nu>
In-Reply-To: <87y2jap4ch.fsf@0x63.nu>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 10 Nov 2020 08:55:42 +0100
Message-ID: <CAP8UFD0SkCHpSeZ0aWO21mj7+DJJ0GRJhkSCeKzbUsgQkwVLRw@mail.gmail.com>
Subject: Re: [PATCH 06/21] t4205: add test for trailer in log with nonstandard separator
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 11:12 PM Anders Waldenborg <anders@0x63.nu> wrote:
>
>
> Christian Couder writes:
>
> > On Sun, Oct 25, 2020 at 10:27 PM Anders Waldenborg <anders@0x63.nu> wrote:
> >>
> >> ); SAEximRunCond expanded to false
>
> Please disregard this line. It is an unfortunate and most embarrassing
> artifact of messed up git send-email and stmp forwarding over ssh. Which
> hopefully have been sorted so it doesn't happen next time. It obviously
> shouldn't be part of the commit massage in any of the patches in the
> series.

Ok.

> >> Signed-off-by: Anders Waldenborg <anders@0x63.nu>
> >
> > Why is this new test important?
>
> The test that checks that 'git log --pretty=format:%(trailers)' shows
> the output in the form "Closes: 1234" even if input was "Closes #1234"
> is interesting both because it checks that this behavior is kept intact
> in the patches later in the series which modifies handling of separator
> and because it is a behavior that can be surprising and not well defined
> in documentation and those tend to be the ones that are easiest to
> accidentally break.

Ok, I would suggest adding some of the above in the commit message of
the next version of the patch.

> Maybe the addition of the test should come later in
> the series where the changes that potentially could break it happen.

Maybe. I found the series a bit confusing because it seemed to me that
the cover letter wasn't explaining very well what it does. I just
commented on the cover letter. Hopefully in the next version it will
be better, and it will then be easier to see if patches should be
moved around.

> It seems like you stopped reviewing my patch series at patch 06/21. That
> is IMHO just before it starts to get interesting :)  Now I don't know if
> rest of it was rubbish or uninteresting or just there was no time to
> look at it.

It was a combination of not much time and the cover letter not making
it easy to understand the whole series. I was hoping that the next
version would have more explanations in the cover letter and also in
some commit messages.

> I've updated according to the suggestions, but not sure if I should
> repost the series with just such small adjustments.

I think it's worth reposting with an improved cover letter and other
small adjustments.

Thanks,
Christian.
