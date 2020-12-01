Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C5FC83011
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EE420857
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 10:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5ikfVw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgLAKjB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgLAKjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 05:39:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6694C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 02:38:20 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o1so1857548wrx.7
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 02:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBXWGBv7PVwlNlU4CBMzfUB7VP4BeaBENuQpxL+cyhQ=;
        b=M5ikfVw7sd0chSTURdu1hG8ODQZRH3JDfMNW9uhlWjSknpYOMn5xCIXUHBbAysSyol
         k7hduIObFagabz32ufTYyX+RjcpIRUXUn4DG0lhWRxYt5WC1x9632jSe2muwB/gCqwol
         9oqNmwrAAtW6TlHiubreBxNaTqkCTA5L5G7+5q5QLxJAOS9piLBFB5T3DaYufAt2QfFX
         QzQJVy4NIf2PtvmJQ8bbHPBuI47AYZteqQspMr64QHv8qItsbPRGceh0T/OLl0XruYP7
         c0hAF1pSKmpsQ2RVJBH99t83am6Qfj33L6gEiWF9miGoejy8mqHrJWshGhjaCZb7p2Vd
         a3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBXWGBv7PVwlNlU4CBMzfUB7VP4BeaBENuQpxL+cyhQ=;
        b=LltKGJEJNZ6AdOIB0ozPF3ivhFs5/iIHREVSzgJmCRyUuEWcG0zKQfBneicF7Otf9t
         g8+DSkv5WMQkvpFKqePkNLVKqrK3rWf88fYQOy2BsYux212D3IWP9v+VCtO0ieaAoWqu
         OzRcHDrlAXn30c9/70UoSqqvxrz8GPobSMLjaM0xbSGTw2JY0OTDE/0sND981tzJRx0U
         zJnXbiieSdYvRC3IEydODsBGTGShV3Arv8XKy1oEKNIhgpS+LS1MacVW5kL+o21wkkO8
         /jgG8OQ/5ekGOKf+yd82baGzgY3DwmIbBxrXO/8xdhrO6dvFF8/p1KS1UyE+fF4+y5vR
         TU6w==
X-Gm-Message-State: AOAM533trkE+NyyvVAz/XKNV66hzHHKBLIII2PEkxozsJ+fvtbJXbJpJ
        GacPrtlcHJ3Nrt34/M5LdFtgbyUV6MEoDCLdH4Q=
X-Google-Smtp-Source: ABdhPJxr07ohhGOYUbdcXHTqA2iq0kWJlaDM/dAqAJe2ZQ1GCw1Y/ztrqBucH9Zi4TcyYS4QFFI0PljOU91fSKw0mN0=
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr2949852wrw.139.1606819099317;
 Tue, 01 Dec 2020 02:38:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
 <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com> <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
In-Reply-To: <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 04:38:08 -0600
Message-ID: <CAMP44s0v92C+uUwoeBJxRv2MPCd2RuCPn8FVBUztNM9VOdjJgA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 1, 2020 at 3:51 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> On Mon, Nov 30, 2020 at 10:21 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > On Mon, Nov 30, 2020 at 2:28 PM Han-Wen Nienhuys <hanwen@google.com> wrote:

> > Sounds to me Google has not made its mind about actually contributing
> > these changes.
> >
> > Or am I missing something?
>
> The restrictions are not about the patches themselves. They are about
> restricting what gets posted under github.com/google/ .

I see.

But it doesn't have to be posted on github.com/google/, it doesn't
have to be posted on github.com at all. If the code is under an open
source license, you (or anyone) can post it anywhere.

-- 
Felipe Contreras
