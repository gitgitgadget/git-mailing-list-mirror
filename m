Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED12C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF54761466
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhD3U7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbhD3U7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 16:59:09 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F75C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:58:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id i11so9328426oig.8
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KUf9KdMSO7w6IAScJmDsGEVJtowQ0z8Fn0FrGodL890=;
        b=e/5iELRaJf3mlnevHMteB7bEmAI67m5l9oxa3L5HfrTQXyCmoYG+B6SGgYDvyO/GrS
         C3zHPL0y0CkrULvN3J5dzsfzIno9mmrhp+T2/IXP2KTAtjgWXOg4kISATvHvxjxPBu60
         8D/3J+2hNFb1wqmTDOKDQ+2Mg7L2ss0uSk4suAPJSqFvlitTU1j9FVDsvj5jo7VPQLwr
         IYgxMgiapklKiO3dbJozssFXDvUU7vlBAgtOJKJeFUIo5ENOc37bLELCDGuzRWn0LPYR
         fmS/zOWsEl1/kBDMk5LUZp1bMuBY/wx7hjWEK6J7yjp3Gv6Wqq3CCT4KmxSI1sSaKkCy
         WwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KUf9KdMSO7w6IAScJmDsGEVJtowQ0z8Fn0FrGodL890=;
        b=XQbQfUhFXWQw2+0IuM8NJECSo8RBJNYTHJHW6skFD2ioNsCBGIpXH9cpvqqQDH/4+d
         BATbbrzREF8dLy83vGr6y6gvLuq9CAVQKuByCtduo+8kZU8pQ4xHTUhX31meFij+06a8
         bzRnRMLDk5FZd+uaBoEeR/d3Pe2uL4Ttoz2X86CIZifpvuzSm0dTTjHFr5vcrTfTSBW6
         tTMOErPLksDW1Xvb3/HrP2k4csii7rzLkrWFsD6pgKYZKbAW9HqMqMp+RyNeSu7wS9G7
         RLVbC+gWmxLWj5WV9FHXnPUgVNRo+gHWlYIaglUaAQ8O99WQDaC38RDyONzXn3o0raEr
         fTMA==
X-Gm-Message-State: AOAM532727Cq3JnF3QP1Ioy0v4TjQly7RCDRw1vuMBdXbimmBCuqxYyI
        o1qKzN6QunLgNs3M5ps3swc=
X-Google-Smtp-Source: ABdhPJxBlIXGSB/QudGt1+FQWnUYS+3evAG76Je8d1AlPZY8yT4PH16m6S5qNgJJM8xxULwZmtfmWg==
X-Received: by 2002:a05:6808:1385:: with SMTP id c5mr3054633oiw.85.1619816298877;
        Fri, 30 Apr 2021 13:58:18 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q10sm967202ooo.34.2021.04.30.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:58:18 -0700 (PDT)
Date:   Fri, 30 Apr 2021 15:58:14 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
Message-ID: <608c6f662db37_2cb20829@natae.notmuch>
In-Reply-To: <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
Subject: Re: Pain points in Git's patch flow
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth wrote:
> On Sun, Apr 18, 2021 at 10:54 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=

> <avarab@gmail.com> wrote:
> =

> > And thank you for participating in the discussion. I think it's
> > especially valuable to get a viewpoint like yours, i.e. someone who (=
per
> > this E-Mail below) gave up in frustration with the current developmen=
t
> > flow.
> =

> To be fair, Git's contribution flow isn't the only reason why I chose
> to stop contributing. Another reason is the very lengthy and tedious
> discussions that too often spark from rather small changes.

I completely agree with this assessment.

In the spectrum from all code is allowed (0) to only perfect code is allo=
wed
(100) I'd say the git project is around 95. It's good in the sense that
user expectation rarely breaks, but on the other hand not much progress
happens.

Personally I would turn the dial of perfectedness down to 90, or even
80.

It's because of this focus on perfection that discussions get tedious,
and thus perfect becomes the enemy of good.

But since the current maintership is never going to change that focus, I
think a fork of git is necessary.

Cheers.

-- =

Felipe Contreras=
