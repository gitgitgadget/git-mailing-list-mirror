Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF088C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D0222210
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 23:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgLAXOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 18:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgLAXOu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 18:14:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C591BC0613D6
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 15:14:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so35989wmi.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 15:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emp39Ux7LezyW4R5YhXD7s92rVOfXY0fn21O4AvzbQo=;
        b=JdCHBNMn4tiN86/0HnyOOTZlYtpXfbEDiolQYbWDa5RA1VVtjGuhjxvNVsEdAittRQ
         2hUBcAo1DvYKpRyNJvuFfq8C2XpjQBEjtU27h6aBbOHyau7AwoRgncVYIxDIGKT+Fn3H
         mU6F4yEoGYspLn9z/K3XHUDJOIng7vPop7XYPO4VfGANNzMqncnTTXV0rGCrd8uPSpMY
         roSp8/iDxxK2Sw1ULdRZobVerX9V3e8i3dhtrgwlKmEAFHWWWOr64IyNJToq+Hr8asXJ
         LRiF6uYet8VN8KPxE5YZD+/9ziBYInjxaWzfJOZ3dybAcnwBWmPrbm5jcz/70kF8+ANf
         Q3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emp39Ux7LezyW4R5YhXD7s92rVOfXY0fn21O4AvzbQo=;
        b=JYsh7mIliWm/noXBd40YwmzpJWGGYMcVzgR0LN/f6S+SOdZ1/GXuoUdHp/gR0gm2Kd
         L0HBDMnPnpkI3IWQ4Q6TLYVHxGjLhkftdtqlydKTKsUAep9QNpl2QFCACkbTuG/upU1X
         n19CjgrdkbLKhGrPEK0VmveLIpKfsT7z/q+S8a23rmKRfPe+WBAYJUNMQj0+KkgxkqpK
         DIV4k48R9Kf9OWeJPusYN+7h+4yUWZqfGmS0ZxlxAIE4GKW4DfWmwweAEouR3UTeAJqL
         manX4te3IT7ul9CrS1WD9mi/vaMnsI8nDomdiguD7fo6i9vc6lrIkhdAZHEFYlJugUWn
         Df+A==
X-Gm-Message-State: AOAM530k3d8dUFtVkez3N85xjcxsxbqHXGieP+dPEu2v0ELFyzL05jq0
        Lmzw9J6gMENoOdHOOMnTAqNJToXIPXR2je9bUEo=
X-Google-Smtp-Source: ABdhPJz98pShrwpQwSFK3qTKs4LdCQp+0sy/5+enJVGGVjYCYkfJQgPSD+7EYX8HqNYIcBLe9pPmlTTewWlkaDaO3sw=
X-Received: by 2002:a1c:6008:: with SMTP id u8mr4827401wmb.173.1606864448590;
 Tue, 01 Dec 2020 15:14:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com>
 <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
 <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
 <CAMP44s0v92C+uUwoeBJxRv2MPCd2RuCPn8FVBUztNM9VOdjJgA@mail.gmail.com>
 <87wny1vjg0.fsf@evledraar.gmail.com> <CAFQ2z_OJQf3+b0TT6BmAV9q9G9c2icbLK0EqrEjpYmpi8g9Fsg@mail.gmail.com>
In-Reply-To: <CAFQ2z_OJQf3+b0TT6BmAV9q9G9c2icbLK0EqrEjpYmpi8g9Fsg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 1 Dec 2020 17:13:56 -0600
Message-ID: <CAMP44s1cKGsOtHNVsquznSQZ3x0ri7dj-PQ=4LGN4VTAFe=tow@mail.gmail.com>
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

On Tue, Dec 1, 2020 at 7:35 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
> > On Tue, Dec 01 2020, Felipe Contreras wrote:

> > > But it doesn't have to be posted on github.com/google/, it doesn't
> > > have to be posted on github.com at all. If the code is under an open
> > > source license, you (or anyone) can post it anywhere.
>
> I am also bound by my employment contract to follow company
> instructions. While you (Felipe) can post code where you want, the
> same is not true for me.

I understand that, but what if a stubborn person decides to do that,
and the code starts diverging from github.com/google/? So essentially
a fork is created.

I don't think that's in the best interest of Google, and that would
force their hand to either a) allow you to contribute to the open
repo, or b) allow open source people to contribute to the google repo.

I find it silly that these thought experiments have to be explained to
corporate lawyers, or worse; they actually have to be done so the
lawyers get the point. But alas, that's what working in a big
corporation entails.

Good luck with that. (No sarcasm intended)

-- 
Felipe Contreras
