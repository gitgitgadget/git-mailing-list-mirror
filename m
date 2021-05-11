Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3711AC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 07:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0323061920
	for <git@archiver.kernel.org>; Tue, 11 May 2021 07:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhEKHQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 03:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhEKHQd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 03:16:33 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E6C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 00:15:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n184so18146152oia.12
        for <git@vger.kernel.org>; Tue, 11 May 2021 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fmErCFtkbnmxjlc6FzGrLUXgydiNwpCtCb5In+Er7+I=;
        b=pwjTSxMV0B52B4PiMQpRSjpSmh2aGH5BC11JwHe2T5CGfa0eOT8BfakOzpkKGzJ8vp
         xIsT2rTg17jA5aPo/T7v89PJvVxhLYV8CRmNt7VFYSuV2YzTf9dMHvr+XXwtZqSe+ps+
         Ag0is00REM7BzJ56Qb2axSrmfEa4iCtTFJvpw0Skdof9NRv2M5l+CbRgC8QC2JlfYTif
         ppAhajeEuEw4y6enyMCAg7/fY/h21/sU9NraYIAwPOThKiUfsF5jLKcXr3ZgGO4u+gqZ
         w2BBoXXU4wvSnsVP5Tf9L0sP2jepahyWRozjOGWCoepHEuhn2T4JBJiCxpn0mGTQdhYw
         ugfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fmErCFtkbnmxjlc6FzGrLUXgydiNwpCtCb5In+Er7+I=;
        b=W81cPb71xV+/qpZmGt51wDFCdJ647sRZy7t6fEGFgM7OSRQ/5OS0HLD1ZG7sao4sMw
         dVtY9gd2zx7irHkPAlLQj80F1Q4O2JgY4grb00O9UVEvgUk6B1n3W30e29nbS9jzifkY
         Y2rGJSLvYxmBXRqIeQA1vsQQycVvFnmFh/EjB9cE7TqLjj6hybUUtsifTZ9lGLBs+nQh
         PrvPmFmz82P6PKNEf3wMzs4JiUI0rVvbyEy8oac2l8qCbAnD/gvQKgOOZLAthFJ/jGv+
         SjxAIpk/6SoTRK/E8TxrtFI9NhDoApyORq4hAEaOlBOQvZjUqI1kpaHcY5DQWs2KxmLl
         QUKQ==
X-Gm-Message-State: AOAM533sYZLCjUNhdoNqldIqPLKso/9S+m3Cvk3PnTHIcALDTEOV/5yc
        YVNbt8db90Yyl9ZXHzrSq4c=
X-Google-Smtp-Source: ABdhPJy63KgfowSjGfeMW9MKY748jvp9pC242UMlKD12+ST/RAaGS4d2Hjbos50lnZL57uLgBd4gjw==
X-Received: by 2002:a05:6808:bd6:: with SMTP id o22mr2407432oik.129.1620717326463;
        Tue, 11 May 2021 00:15:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id v1sm3578263ott.32.2021.05.11.00.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:15:25 -0700 (PDT)
Date:   Tue, 11 May 2021 02:15:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <609a2f0c7353b_5d5d3208a7@natae.notmuch>
In-Reply-To: <8735uuvois.fsf@evledraar.gmail.com>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com>
 <xmqq35v01ua3.fsf@gitster.g>
 <6093cc63a4e81_325720840@natae.notmuch>
 <87h7jfvq09.fsf@evledraar.gmail.com>
 <609465b55e183_577f20852@natae.notmuch>
 <8735uuvois.fsf@evledraar.gmail.com>
Subject: Re: git switch/restore, still experimental?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, May 06 2021, Felipe Contreras wrote:
> =

> First of all, I think we're in rather violent agreement about the real
> matter at hand here, and are at best talking about the design of the
> keychain for the bikeshed...

Indeed. The design of the hypothetical keychain for future bikesheds.

> > Which command is that?
> >
> >   git create branch --checkout?
> >
> > I'm following the order of the words from left to right.
> =

> I'm just pointing out that git in general and certainly not the *nix
> tradition it follows tries to make commands readable in anything like
> English sentence order. If you attempt to read "log", "status", "rebase=
"
> etc. commands like that you'll at best end up sounding somewhat like
> Yoda.

Right, but git is infamous for having a UI that leaves a lot to be
desired. I'm less concerned about the status quo of git's UI than I am
of what could be.

Inertia is something that just can't be ignored on commands that people
have been using for 15 years.

My point is that new commands should not follow the inertia of old
commands, especially when we know that historically the UI is the thing
that needs more improvements. In fact, we should do the *opposite*. It's
the less-than-stellar UI that created the need for switch/restore in the
first place.

> > In this case however we have a rare occasion in which both consistenc=
y and
> > natural language meet, we should not squander it.
> >
> > In fact, to be even more consistent we could add a -n option to git
> > branch, which would be reduntant but more explicit, like --list.
> =

> Indeed, I agree with all of that. I.e. we should move to "switch" to
> "-n" instead of "-c" etc., and add a "-n" to "branch" for
> consistency. After all that's my upthread proposal...
> =

> I just don't think it's worth trying to make the argv readable as a
> sentence, even if we had no backwards compatibility to worry about.

Well, we would need to look at particular examples to see if the
counter-examples make more sene or not.

Either way my contention is that it doesn't hurt.

I will take a look at switch/restore and see if a linguist approach
gives more low-hanging fruit.

Fortunately none of that matters for your particular proposal which is
just good.

Cheers.

-- =

Felipe Contreras=
