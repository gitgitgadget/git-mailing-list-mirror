Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193DDC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23D561246
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhKJQXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhKJQXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 11:23:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD988C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 08:20:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so12898703edv.1
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ExY0I+mqW9altdlVDv0BcOKdo0MtI6I+7BYGGlOwvgE=;
        b=eWZsXFIFNW0SMIxwMbxeTSddYPkdZGJ4EYpc+UHTHK0pkBQvbYICc/a5W8ZMtJMNbK
         xX+hve7bqzZIbZOGk6xIQm4QFZQd/DdeIB10EzhMy9WqivEd2WlLughFmOadGcfl+VUk
         yO4W6BJSXzIN9Z94Vz1dVZY8r5iU4dYVF926CDfCCSegxs1AqClX3klIcGhYMxqkKF/Z
         FWx+puWcGc7iKciWBoexsiVhvQa6+lgbO+hBpeu9OTEbjUHHhP8aSOWSiY7z2IxHhbtj
         rHbkbAdsGLAKoszyqT1iRZ33G1nW9xJX8/OZrIt86bhZuCOpiy5NBRdIYX8SXf+OUWDl
         gTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ExY0I+mqW9altdlVDv0BcOKdo0MtI6I+7BYGGlOwvgE=;
        b=UUfRkBg7BBYBmd+zAPiKr2n6N6RNkRt2vXvEGii0IFZK++cevOGpIarffltOqPQLqT
         D/X8trL1v72Eg20DCtKzneHQsRi6qxSqIGKhSO6lacEsp1Dgj5Meaqm4YLk1NjsytFVe
         f3/Bes6vJ/4HX3A88h6KarhmUzt0LMu/diArmuFE1TAQLH4h72QZ9c+ewzkDlIIEi61I
         34Ip19cpQexnXPegRl72PCnqda27GTDDsPzGccXlKiTfaQ0+s66kEM5WII3Ph3bHHs+U
         MctpOc7V2pYXxtl5MuLIfGgV3GzpMmSFRez8DcJp9m1BTSFGMaJ8sQIcaL2K4U285/Ty
         /MiQ==
X-Gm-Message-State: AOAM5327r6pDV+ON+/NmLP5zfpjjCzEiUJrUHE1ggLHP1cNVVsU97k2a
        YDdxnRygiSI9Zh+it7ieoFo=
X-Google-Smtp-Source: ABdhPJxoWgXFerNHqbKB5LwXrlY8TovcZ56lpgRSVcsi5fFwgaYUmpm5xtmb/uciYBRuVrNDGuYa9w==
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr296129ejz.499.1636561212136;
        Wed, 10 Nov 2021 08:20:12 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ch13sm121214edb.97.2021.11.10.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 08:20:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkqKY-0017uQ-Qu;
        Wed, 10 Nov 2021 17:20:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
Date:   Wed, 10 Nov 2021 16:58:59 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
        <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
        <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
        <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
        <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
        <xmqqtugl102l.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111101332130.21127@tvgsbejvaqbjf.bet>
        <211110.86h7cki0uo.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111101547120.21127@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111101547120.21127@tvgsbejvaqbjf.bet>
Message-ID: <211110.86mtmcgeyt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 10 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> If we're not OK with $(wildcard) as a pattern that would mean changing
>> all of these to hardcoded (in some cases quite big) lists somewhere:
>>
>>     [...]
>
> No, it would only mean changing these instances if we have a concrete
> need. I fail to see a concrete need.
>
> That does not mean that we should make the situation even worse by
> converting currently hard-coded lists to wildcards. There is, once again,
> no concrete need for that, and there is the good reason Junio brought up
> against such a churn: it is too sloppy.

I don't it's sloppy. It's just a different approach. It's also an
approach we use now. Add a new build in and your addition in t/*.sh and
Documentation/*.txt will be picked up & built. We just won't pick up the
*.h or builtin/*.c implicitly.

So whether we need to do this now is one thing, but saying it's a big
change in workflow seems to be rather exaggerated.

>> [...] I think we should remove that LIB_H thing entirely.
>
> I think we should take a break from refactoring code where it is unclear
> what purpose the refactoring serves.

I'm not advocating ripping LIB_H out right now, and have not submitted
any patches to do so.

I'm asking you a follow-up question about your claim that LIB_H is
needed for building from a tarball. I don't think it is, but perhaps I'm
missing something.

It would be useful to get an answer to that for the list records, so
that while it's fresh in your mind we can get an answer one way or the
other.

I agree there's no a strong reason to change it now, but being able to
do so in the future might be useful.

At that point someone will probably dig up this thread. Whether "do we
need LIB_H for what Johannes suggested?" is a dead end or not I'll leave
to you.

>> > And to be honest, even `LIB_H` and `FIND_SOURCE_FILE` would quite
>> > potentially better be hard-coded (with a CI check to ensure that
>> > they're up to date).
>>
>> That would be a bug, just because I don't build on Windows doesn't mean
>> that I wouldn't like "make TAGS coccicheck" to find compat/win32/ at
>> all.
>
> Talking about `coccicheck` in the context of the discussion whether we
> should make sweeping changes in our Makefiles, all while we're supposedly
> in the -rc phase, strikes me as a distant tangent of a distant tangent.

For the past few releases I think I've probably submitted more
last-minute rc fixes than most. In my case it's mostly a matter of
starting some builds and waiting for them to complete:
https://xkcd.com/303/

So yeah, I think we should focus around release time, but saying that
any other ongoing discussion is a needless distraction seems like a
bridge too far.

That being said the reason I'm submitting these sorts of fixes now is
directly related to making rc testing easier.

I test on some obnoxiously slow VMs or otherwise limited computers on
the GCC farm. When something breaks between releases having each step of
a bisect take 30m or 60m makes a big difference.

So having a Makefile that doesn't over-build stuff is important to
release testing.

But getting that across has been frustrating at times. I've pretty much
stopped testing on AIX because my few-lines of patches to the Makefile
to make that drastically easier were categorically rejected. The
response to some other things like over-building <xyz> has been
somewhere between "I don't see why you care, my computer is fast enough"
and "why don't you port ccache to <90s era *nix OS that barely compiles
Hello World without issues".
