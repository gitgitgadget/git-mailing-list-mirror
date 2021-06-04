Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A6C47083
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB32E6140F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFDFhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 01:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhFDFhf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 01:37:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E82EC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 22:35:36 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a21so8712869oiw.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 22:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=nxs2mFjUgMXOaJpNOnfs/TNYQihP34zh5Wo+uXh6WG4=;
        b=jJA4NbfPwKkM78Sy/rJh1u5rnqXGoM5q+tdKq5ea2D00FKHI+JCV/f20g/M6YdzVV+
         ZKMfX2+tiFyvtc8eczJ5AePPz6fybEID0u8jOTvWEKOz+L7BUURQ9WGJbCzjE6BSuw8D
         ZVDrIwh7D/v+dBDCN5dVzWYfoSLAxXWJXrryZq5V8kSMahRivrXL8EWkNyb/fHEXCcNw
         5OzY2OBb8rkcQscssVD3MFROaGg/h35jMTK73OWqo7n3JZFeVwt0bR3bm9OzVxgjs+1N
         lKuhem3aVIhoQFni6BXRswJ8V0t62NpdHaHmnlwl0XPoGId1wzboTEy0MAGDhOytN6EE
         cAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=nxs2mFjUgMXOaJpNOnfs/TNYQihP34zh5Wo+uXh6WG4=;
        b=YGJjEm4CCAbD1kmOkvOh1q2FuZ8iQyLeZAoxPmMq0xg2dGNik3hEohMXYaoQbDdI7Y
         oZahj8nMF+8pnTlZ50BWv7wCn5Bt6CiwN3No5vgY3u+SXalSX3BPkQ7axrvQz0BdEKko
         utDU0qLVoi0n6eonoyb7R+GbfK4R50+YYI6nnaZWClG5+AZ5cEM8ti0jpGh27bjE/foU
         6ZX+GtlgRPViPzgDbs4L1T4rsOBFmqgTbuaaD8VYjpaLOPMLVTetnraEyQx5kRHaqYLT
         Z5pFzx5YC9NtopFsvdXilTUgWYnN6LSUjk7pjeLGThgkfWJwveAme4AcvLW4lAjRU6nQ
         R3WQ==
X-Gm-Message-State: AOAM531wq7Vd5ugEs0zZV9JpqO62nKaw0mXLBycS2nYxd0yBTSSTCYNX
        vwE/0GQuURiLBRSk67DCZjs=
X-Google-Smtp-Source: ABdhPJw7Rxk+eu5S1RKvrt5w9MaXn88/4QrcTV+cH3ARR//rdsOGwa82R344lELuFdVW0lbD4C49ug==
X-Received: by 2002:aca:340a:: with SMTP id b10mr9920513oia.95.1622784934585;
        Thu, 03 Jun 2021 22:35:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 16sm271786otm.57.2021.06.03.22.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 22:35:34 -0700 (PDT)
Date:   Fri, 04 Jun 2021 00:35:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60b9bba4b792c_3bd685208ec@natae.notmuch>
In-Reply-To: <CAPig+cSXbCTymdrUOZwFBeUNMWuhnGb91Ar9Jth2cHCG2xav+g@mail.gmail.com>
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com>
 <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
 <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <CAPig+cSXbCTymdrUOZwFBeUNMWuhnGb91Ar9Jth2cHCG2xav+g@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Thu, Jun 3, 2021 at 9:11 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > Eric Sunshine wrote:
> > > Google requires 2fa to be enabled in order to create app passwords,
> >
> > That doesn't make sense.
> 
> What doesn't make sense? My statement?

Your statement.

> > It's like complaining that you need to lose a limb in order to use
> > prostetics...
> > App passwords are a suboptimal solution in case you cannot use 2fa for a
> > certain application.
> 
> Nevertheless, that's what Google requires.

No. Google doesn't require app passwords, nor 2fa.

> > If you cannot use 2fa for any application, then don't enable 2fa, and
> > then you don't need an app password. Just use your regular password.
> 
> Google has been clamping down on "regular password" use for
> third-party applications/sign-ins for several years now and they
> heavily discourage it.

Perhaps, but they don't requier 2fa. If you don't want to use 2fa, then
use regular passwords.

Or just don't use Gmail.

-- 
Felipe Contreras
