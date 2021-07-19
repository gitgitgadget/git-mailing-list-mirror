Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E46C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DFA6113A
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352577AbhGSQ5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357791AbhGSQwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:52:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCECC0613BD
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 09:59:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v6so31493144lfp.6
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fADUF3XBzHOdM11aWIIDAfcvjleivP+opuL9K8mBlr4=;
        b=IsG/kZ3Sjl7u6FOAlvl4POJEPEdrDwdZLsZnur27W4keGujqsjBaFiOMB4eYU8IsOs
         3PDImeIUgOV8veLUYDllUAwcdY08Y7WMF/pPsjCLkGhKOX0DM+TdwaoviaJp1qvf+5gV
         w+XIvrzZuOZRiDcxGt1YMYtHtL1UQ4rPCZb5ZMX25prZtWlvQa+Mx2ZvPPuqm5x2VVs4
         bIVNZyBQ74ee2Q8coajNrclOkw9AqC+rlMjRQsDkyUGys/AHnkWLrhr2t2Ozd1+cwcoe
         a9NF40OkKHhtx+vpV2VDs7SCrGSdNgZ5c6i6majToAM9S3u0m+0YS+Uxd1iu8aVXHEg3
         cimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fADUF3XBzHOdM11aWIIDAfcvjleivP+opuL9K8mBlr4=;
        b=rxqX38UYHTPIlzxljuq5iul7018F7MptP+8FKb1doqDZjdhzEj9VOSPyUbOf2HbgcV
         MTCybhomdrXKwT97JEpSTZkYD08hgmecm38/9kf0jSMVAiJkASI4nFgAnpilyUOBUxDz
         VUIioodk4zZQHixs+BKl6YQ9Mh0HtPgyf6PG3SZzyzBeIewqcDSpU3e0ALJXMSsLXNUI
         zJvWKBo1w0TwMHC2CFHy9zV81GbMtlCWf3YY4uSBGlSzqmHO0egYptqFebqcsV7VVpQo
         55fXWP4+MP291zT1uRimvpvEubY5hsYWZOLvHiqHD4dy5slPa2l4TIA21FfTkkAASHDx
         Bgtg==
X-Gm-Message-State: AOAM532JD0utlAkwuo0cM3CuUj05P0os//nLX2JDX9rmi+0++Ir7zAfV
        wSXr7+EJDkQhr+Ooi+Vjms7aEMgAwqch6Wn5Mmk=
X-Google-Smtp-Source: ABdhPJyy9Wrk+/kZAMO9q5uiTIxNHEOhyiXMTP3qWKZt3p6OqZR0iDlDHqClTnaG7at0OrLW3eE/rDTKhneNX5lWyBw=
X-Received: by 2002:a19:c795:: with SMTP id x143mr4548544lff.42.1626715135959;
 Mon, 19 Jul 2021 10:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com> <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com>
In-Reply-To: <87h7gsvybx.fsf@evledraar.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 19 Jul 2021 11:18:44 -0600
Message-ID: <CAMMLpeRhHn5ndPYzihm0rCidjNQM8c7b+Ta-JSZ=jidbEr=VRg@mail.gmail.com>
Subject: Re: progress test failure on fedora34
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 2:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jul 14 2021, Alex Henrie wrote:
>
> > On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Wed, Jul 14 2021, Fabian Stelzer wrote:
> >>
> >> > Hi,
> >> > The test t0500-progress-display.sh in current master fails on latest
> >> > fedora34.
> >> > The break was introduced with:
> >> >
> >> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> >> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> >> >
> >> > Kind regards,
> >> > Fabian
> >>
> >> I have not been able to reproduce this, it seems the below E-Mail was
> >> word-wrapped by your mailer, which is especially bad here since gettin=
g
> >> to the bottom of this requires looking at the whitespace.
> >>
> >> Is there a way you could tar that up and send it (to me personally is
> >> fine, or some pastebin or whatever).
> >>
> >> I am able to reproduce something that looks like this if I
> >> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we set i=
t to
> >> 80, and that the progress.c code just ends up with an
> >> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other fan=
cy
> >> logic) in progress.c, I'm not seeing right now how this could happen..=
.
> >
> > This test also fails for me when using QTerminal or Konsole, but it
> > passes on XTerm and LXTerminal.
>
> I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce it,
> resized the window etc., always get COLUMNS=3D80 if I add some printf
> debugging.

Actually, it looks like the difference was that I didn't resize the
XTerm or LXTerminal windows. The tests pass on all four if the
terminal emulator window is exactly 80 columns wide, and they fail on
all four if the window is any wider or narrower.

-Alex
