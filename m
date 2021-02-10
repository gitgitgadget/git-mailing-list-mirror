Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F78C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 05:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3761E64DE1
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 05:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhBJFoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 00:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhBJFoI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 00:44:08 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A0EC061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 21:43:28 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id f1so265901oou.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 21:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dFRbsWsHfOx1L00aNj6/16/gnNmBiX87mypW/IPgOiY=;
        b=oATdnjGMWuktGJFzK37XBZFkh+q1yRP97FkeMZtD2OV8aQVCC3rWDFx3Jk3L4MSmoh
         LR8sthsu82NZ+auvt0BrC6DiymmSAR6RnPIJlbHsfhECcbOR0XCJ8/cJVyAoJ7GsXYsc
         JMRStl8XiG0kC7/MSfIUbpCU6p45tbLbnj38+i51TVYGn6QEafpkf0UOxGfZx/2XHiVW
         8K9aejty3TeesPmRsEUPhrU6pYw3wzggG/WXlSGbq++MWNUdN68IVtS9IuuyF988GBoM
         kTmXhsUBnHwjR+mw/gD5GqilPF4M+/+rpJ+DXTIvEgCNmEbSPdHP+yKUHSeNjf7Yrzdt
         FMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dFRbsWsHfOx1L00aNj6/16/gnNmBiX87mypW/IPgOiY=;
        b=jFtXf924WwDCdmLIidOpAyVZXXCXrowIXlFkBnJQH/9wgv/SL0ileLXgoG3sSABKib
         Eb0JWBy9DKDi2GazSzwkLEXss2WWRFNYLEkDxmkXECBuI/xsv5tNbrh8j6hlk6yJyJRx
         5oKwgyYNThIVNsqW4tfV6UVQ+ISuSfdGszAW/Dl8GIHvCh1e+k+lFHPvsjnxGbuaqRAe
         e0uT152UqIpVdcK3KhG4UhrFtGxtyf0uz5B9FiijxSvtY3X2FCmPZVTtJYhfuLoG+uwY
         G2xR2ObAhEan/OIskLY8Medcgmqec2ui1vqG6zhPJoV8hq/6QD+wXdag2TV7c5UVWS1W
         0KRw==
X-Gm-Message-State: AOAM5318vy6KGZ1o8eBYn/oR4qSmoQnMPOfsUvy/xzf3HHqOFkOMSDZ3
        3reHjeN1tNwpxQMJhlWfPsYRYUD6dsfvLBJb2OE=
X-Google-Smtp-Source: ABdhPJz/gR1mdVhwWdVWBdXrv2Y96fMmJ9sQ9Tr7i9AnK8W2kqCnPb1VbwMhFON/6o1WZkoKXJCQcEuzVNx+F2pVXyo=
X-Received: by 2002:a05:6820:347:: with SMTP id m7mr1039040ooe.75.1612935808105;
 Tue, 09 Feb 2021 21:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-4-charvi077@gmail.com>
 <xmqq5z325k3j.fsf@gitster.c.googlers.com> <CAPSFM5dN=gs7m8VskCPMzD10i42ETQ_7UzuGKmi=X-xs2QkYSg@mail.gmail.com>
 <CAPig+cSoa4Vw0N53vJgMCWiW5yVS0j1H0ejS_01xs1WDF2d82g@mail.gmail.com>
 <xmqq5z312h5w.fsf@gitster.c.googlers.com> <CAPig+cR0aC-XynowmvAz23-h=LP8+vhF7_c3fUg+M+XHg5o8bA@mail.gmail.com>
In-Reply-To: <CAPig+cR0aC-XynowmvAz23-h=LP8+vhF7_c3fUg+M+XHg5o8bA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 10 Feb 2021 11:13:16 +0530
Message-ID: <CAPSFM5dHL-QzzO0tw=1eAwXZ47gp_8xy4L70vgAsStLGaGF3dA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c'
 rebase-todo help
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 10 Feb 2021 at 00:43, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Feb 9, 2021 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > > Here's another more concise attempt:
> > >
> > >     like "squash" but keep only the previous commit's log message,
> > >     unless -C is used, in which case keep only this commit's message;
> > >     -c is same as -C but opens editor
> >
> > Nice.
>
> For conciseness, I intentionally omitted "the", however, upon
> reflection, it probably would be a good idea to insert "the" between
> "opens" and "editor".

Okay, I agree this is also very easy to understand and will update it.

Thanks !
