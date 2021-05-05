Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37737C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0838D61057
	for <git@archiver.kernel.org>; Wed,  5 May 2021 18:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhEESFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbhEESEB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 14:04:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F15C0610DA
        for <git@vger.kernel.org>; Wed,  5 May 2021 10:52:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id m13so2915385oiw.13
        for <git@vger.kernel.org>; Wed, 05 May 2021 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FBzn6FOR7ua9aMScQgtWaQzhwTxH7s2TNSLklJyj3EM=;
        b=M5bAslZwmqajF4jHIoUsLL/wgSCXQwXKSrwvV6HF6g4TMt7SrYnK0R+nUgBR/FeHWZ
         4xmzWzpQpNMYDKqaDg99Q0GBiJNNEM2VRUdldGNcL00B/wDkVE0LsvQKFnhaZrbEqROQ
         hfsekFLk/LGXHDuIr0Em0uZXRELF3Wd2dgsZyDP0Xplb3zSPgzBfS9KjpB67JG73lOxI
         843m1ryR0wdbPvWaqSN0vheDK5Xz98MILvrNO7Hj8nz+TuEjUAnKwJF0hLsohkVQ310K
         j+KdVpKSKxHnHO4AOVK/ztfBC5UpTjnU4KOKimDOiF0z1Rns/9qZUVbdWHniiZnXP5Mc
         b+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FBzn6FOR7ua9aMScQgtWaQzhwTxH7s2TNSLklJyj3EM=;
        b=BsvrWCcUtZyp5ozuogt8RzzeeCrfqw/NE0FEzE7bEouHYCrEYJZYfBSLWdz7lV7jOQ
         KGj1Vy9MEiKyUiFbY2A1BiN5smena6w1f1Y2SCa2b6PrjrqhlhFR1voS9p+O/Y4XukJo
         XBE7HwLATP9bl9E08VTy1/XK7XrEvijABrhhkvQhrLm+mIObsGdx/dh8FG3EHWuM8W8i
         kNG1roxMPLGZg5GREMq2vnTiWtsqenuzBt4u1xy0ekLGmPEHVg9eeQ1KkY3/7nRpi5JY
         u4+w7OBtZKQSujRmlSJ+a9f1UQYvsXhLNu0idR8YvtqbtqtsBwCoplwMMnew5fHkfJ+q
         o9yQ==
X-Gm-Message-State: AOAM531/JPWBQT9P3ERiCQn/dMWV0VtdH3cluK/tg2hxha+wcY4/IaNY
        VdtxDmhkkbBLjopYFAP9tSs=
X-Google-Smtp-Source: ABdhPJwMQa83pQrYHjd3mcGnOKkTLy9ZQ3p5julYMfgFRUClwrT8/lK/mbvzkJsMZA6ThjB2DwxG+g==
X-Received: by 2002:a54:4d04:: with SMTP id v4mr7944493oix.115.1620237125222;
        Wed, 05 May 2021 10:52:05 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id k20sm32289otb.15.2021.05.05.10.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:52:04 -0700 (PDT)
Date:   Wed, 05 May 2021 12:52:03 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?R8OhYm9yIEZhcmthcw==?= <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <6092db4384938_1d2452084a@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2105051554250.50@tvgsbejvaqbjf.bet>
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2105051554250.50@tvgsbejvaqbjf.bet>
Subject: Re: git switch/restore, still experimental?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> Which leaves us with two hard choices regarding switch/restore, none of
> them really being comfortable:
> 
> - we scrap switch/restore because their usability is not really all that
>   improved relative to `git checkout`.
> 
> - we leave switch/restore as-are (because by now, changing the options or
>   the design would be almost certainly disruptive to users who already
>   tried to adopt the new commands, I being one of those users).

There's another option:

 - we revamp completely switch/restore (because any users relying on
   them by now were warned they shouldn't assume these commands to stay
   as they are).

> I say that neither of them is a really splendid choice because the
> original goal is not only not accomplished, but I would say it is even
> harder now than it was when we accepted switch/restore into an official
> release, because of that experience with switch/restore. We simply do not
> have the right expertise on this list, and therefore anything we do will
> always have that "UX designed by an engineer" feel.

I disagree. Engineers can create a good UI, especially after trying
for a while failed attempts.

Cheers.

-- 
Felipe Contreras
