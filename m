Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70A8C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9109A60232
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhHaNbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhHaNbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 09:31:51 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E6C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:30:56 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id q3so26783616edt.5
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wh+Fnw8nHbIuM9WPxtSAcVapdPQ13+t9MqBY+UsoVvA=;
        b=RsLa1/Nwr0VupzwgxmQLtZ1LO5ZhJIOnQ5VuEQmJkzfJeQ7xF3EovKBguQ+TvtM7RL
         6/UCnRfQ0t1KLQ7KyKGNrQUfmBuKNGOtVfBAYXV2EC0wplZPyw1ReRmHKAtqXmtaaEYY
         NPM+fxQXrk2lj7n17epXjghsR2QS0USLZPXpEIllsjg1Uo/6z+YWffbA0bDhJd23Xz3T
         kiU61YSzuGH6nbqGhpO1wVxogVy1O3zwqKYiggJtmNYhUAoMT4amoDqvP08vegsYEbA9
         3ZQzKrXnE6zxO3TeSvODkgCv3mqKhyc0NmoRtVHvnK1XQu66nEuCV3+LZh/Xlb7FcoJq
         hm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wh+Fnw8nHbIuM9WPxtSAcVapdPQ13+t9MqBY+UsoVvA=;
        b=Vy/23Y7b0f6sgiEA5nyAgJe5vhu20hBNQ+MCnbzFmWiKZPIOYfmjtOSYfM1LYmur24
         ey++BtcVjTmwDrR0jaga567mZByJFtCq/keOJmSonAjNcyuJwiUU/XVDNmjeCdo8WWy0
         RNP2C4aYybY/dO1oS6qJjciKQQm4jC9Y53R68NozbsfcMArvzcX61JT54vdyIAOJOQHo
         UbwTOXh1DzBxqj2JySL+bB9xL8tlGbxiS4WMcRTeo1tZ2O6iyVpj+d0XuhicVRmOPCse
         Gj5kPf26hLDIjqXveiKnCfzKFb4Ep+B/zw4FqGwhftejlFzK/9fxqjsjZPuAWdEmUX6b
         /nqg==
X-Gm-Message-State: AOAM531OtL7r6NwM9X1mThdo0dB48CsUlpMuRDLeKMjQxrlkffXbczy7
        LV8gxyYuDNAlr4L8d0tgKeEJnWvut/3+GguA+h4=
X-Google-Smtp-Source: ABdhPJxSwF9dSP+PzG/RYUF81Pg2QZJXC9ffGszXp8Nf7CPyN/QxCPNsczkxaZqPpiHL7JOWbfQd1fVBIihbkKmM+Mg=
X-Received: by 2002:aa7:cb13:: with SMTP id s19mr30327674edt.87.1630416654772;
 Tue, 31 Aug 2021 06:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD197_XdFZ--khJa_E7bkG4VCsD0dPVP60AD=AfQU6Sz1w@mail.gmail.com>
 <CAP8UFD2YgpjB4oMEE7X2G4f_hN4=-mKcwBEAXn=qpkXCCWjVWg@mail.gmail.com> <3ce1938f-e1df-f549-0f0c-a1b09e545b44@iee.email>
In-Reply-To: <3ce1938f-e1df-f549-0f0c-a1b09e545b44@iee.email>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 31 Aug 2021 15:30:43 +0200
Message-ID: <CAP8UFD3Zn4ChS0kD30uY_XywM7h+4gi_aPLaFtzzeu_Xs_j=0Q@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 78
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        German Lashevich <german.lashevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 9:53 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> Tuesday? 31st August..

Yeah, sorry for the confusion.
