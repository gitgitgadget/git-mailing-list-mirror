Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EB6C6377E
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2C6100C
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 19:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352112AbhGSSWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350521AbhGSRlB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:41:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E507AC061768
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g8so25902985lfh.8
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8k0u9hkpsjGafzbLk/F4J92uRiXghCCa70hwz4cwgBw=;
        b=XDXVa0fgAgfbYVvQ+13i1SbzreNnRFIcBZwhrA9lMdirB8rLk+WByeFRruPs5TjrAe
         /n/GH+b1WwuCHetxMQiDcTsuVidJO/zTiFvF6ceNaH9DdbJLl6cEjmvCuD1nNf+tkTOH
         9IPPS+Vr03c9ZXCvRcZvVuG9BBbSHeoD906z/RA/DM9QQrX88eyd9nM9CYw0p2KDea7Y
         JwREztSrT5RHSNFN1H0p9vnVXObB2IcqQWn1S4leD3cqMkiGa4viw2ZZbbV6pW6gmvvJ
         5n4f46e92xkwl4AHwhGesmUsAZdiLfVQePQI+8pkwFQLGj4l2uAVn1WozhC/3KTGc41/
         Cgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8k0u9hkpsjGafzbLk/F4J92uRiXghCCa70hwz4cwgBw=;
        b=CCraIVXCxsnwqRRtAxvAlNwvyP0TcZUDJ2KQ3z0M4mHAEKG0irhDljb+JnzNAb86O8
         TYLynwjlfL1Qzo6tRLLjwL6b+aHCpZEAZFL22omPzMLiRuDcoX4j6jSQIPlVGT0snYDj
         uRdHm9HyRWR9YIzih4L5gxdsCUTPjJbkXfpZCfnOSEGgyvncNfRXyNMWzqf8XDQhzOh3
         t6/8Sx6qM8CsZRPOhWPdwkuFaXmxXTUZpOPHngyYsBzunUauPPfIJ1urq2gtoCjRpL4z
         XvGEzdiiRRyQUH9NNIllccXM/DR4LR6Zp2MLmIlWYkv6daovBBnVACa6GTNFjXZdhXdE
         YvhA==
X-Gm-Message-State: AOAM530DEekZ6vrty1vG6EsPhkv+/SyJDvE3ZhS2zIsTE1iHlfAFVjco
        /V73ZcEbIrwSuvYGtzFjK/77iybvEBLpSOD/P7U=
X-Google-Smtp-Source: ABdhPJyMPsQ//sWmFE2oOZ3dmq6l+U8iAKiSdTpyzSW+2CC8it4bZPQ4mp+Ztl3dZHe+iHPta4PoHINCh8xqOL71DZ4=
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr19427024lff.148.1626718884205;
 Mon, 19 Jul 2021 11:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com> <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com> <CAMMLpeRhHn5ndPYzihm0rCidjNQM8c7b+Ta-JSZ=jidbEr=VRg@mail.gmail.com>
In-Reply-To: <CAMMLpeRhHn5ndPYzihm0rCidjNQM8c7b+Ta-JSZ=jidbEr=VRg@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 19 Jul 2021 12:21:13 -0600
Message-ID: <CAMMLpeSBCiMbr4QRckW4Df2bJq-7t_oj4s+6W3TpWZdYRMKVHg@mail.gmail.com>
Subject: Re: progress test failure on fedora34
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 11:18 AM Alex Henrie <alexhenrie24@gmail.com> wrote=
:
>
> On Sun, Jul 18, 2021 at 2:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> >
> > On Wed, Jul 14 2021, Alex Henrie wrote:
> >
> > > On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > > <avarab@gmail.com> wrote:
> > >>
> > >> On Wed, Jul 14 2021, Fabian Stelzer wrote:
> > >>
> > >> > Hi,
> > >> > The test t0500-progress-display.sh in current master fails on late=
st
> > >> > fedora34.
> > >> > The break was introduced with:
> > >> >
> > >> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
> > >> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
> > >> >
> > >> > Kind regards,
> > >> > Fabian
> > >>
> > >> I have not been able to reproduce this, it seems the below E-Mail wa=
s
> > >> word-wrapped by your mailer, which is especially bad here since gett=
ing
> > >> to the bottom of this requires looking at the whitespace.
> > >>
> > >> Is there a way you could tar that up and send it (to me personally i=
s
> > >> fine, or some pastebin or whatever).
> > >>
> > >> I am able to reproduce something that looks like this if I
> > >> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we set=
 it to
> > >> 80, and that the progress.c code just ends up with an
> > >> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other f=
ancy
> > >> logic) in progress.c, I'm not seeing right now how this could happen=
...
> > >
> > > This test also fails for me when using QTerminal or Konsole, but it
> > > passes on XTerm and LXTerminal.
> >
> > I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce it,
> > resized the window etc., always get COLUMNS=3D80 if I add some printf
> > debugging.
>
> Actually, it looks like the difference was that I didn't resize the
> XTerm or LXTerminal windows. The tests pass on all four if the
> terminal emulator window is exactly 80 columns wide, and they fail on
> all four if the window is any wider or narrower.

I have narrowed the problem down to the `tput` command in test-lib.sh:
When `tput` runs, $COLUMNS is reset to the width of the terminal
emulator window.

-Alex
