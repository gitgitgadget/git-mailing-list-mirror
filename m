Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C9FC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 06:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394F720738
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 06:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8ho2AUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIPGm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 02:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgIPGmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 02:42:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646DC06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 23:42:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r7so8680000ejs.11
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 23:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duBR6MkcSR2zIQxMrKI4puIZjpMuTxn8hwWtGB6yemI=;
        b=H8ho2AUuVZIPrkv43ss4asZ9DyZbBOm3LoDNfmEWwBjBcPqDDUfFj9hoZ9ivc4oCkL
         Tx+mz9m4TCa4UG5ROY2eLOl1RC+/NnmJPuN4o6CcOCrakTpIl5INkX9g2up0h6r0BxqW
         fPIYTWoIAwVu1s2uRHpqASbzWouMZgJs3YCSvCShxrKitiiiTzoDX30n5zfKdw3XlN39
         JTIuYdShPQ4cYDRcZjEpDWNC170MSdpYx5y89XmG+37HCT0NPIpj7CTFijPw13oaS9Ho
         I9k6S+f/mJo43ayVZ5mENOXiwY1yaybcgHuRCVqHsiCYVWOPu1jGyyoT0xxOP5pVFJLW
         roJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duBR6MkcSR2zIQxMrKI4puIZjpMuTxn8hwWtGB6yemI=;
        b=iaZuJvAOlxswaSQFF0aijzlMBGDyehLqQx5Wh6GtOnbOu5Vtu0DekFHKTukfJUJ/bc
         QDEeMXqtvGoPiA/hzQl3wIatEwxafppZNYd80Y8T7ydiXwuNbWLMVdLLAOZpzOgSRwb3
         mOt4QB8apM1wXXRDjiGWh5gEsb0mD56MsfqdhpPZ3WwakMWUMzhUaM0qP0mP+m+y0ey3
         KBdR1tKP+tiMkePWKCnA5jPWGLFjUY0yYmH8oiriGYV8gB2GlHxDvbAE8BAgoCSfKXo9
         GvJHY3yzSpWXoCUsGBw+rUn5plIq/0LDW17kE6i80YVHuvZxF743QBMHBJjEqWrEQkXy
         b4/g==
X-Gm-Message-State: AOAM531o2LQDCcjA1SfmblMgPa0t/bOzAZBVhs4GUbEuhcNVwmWS6XG0
        IVT2AVe8TFTVTa6u7g3MVx1Ew5KxP0luRHuXYyw=
X-Google-Smtp-Source: ABdhPJzSbkV6/i9eFrWrc+bm9OoGBStaV0l6B0TuxthBQm+u+FvLLb+hMw7iYNQq0Q9CFEzNhiVQfeHbpi4wJVTAgGM=
X-Received: by 2002:a17:906:819:: with SMTP id e25mr24482622ejd.211.1600238572321;
 Tue, 15 Sep 2020 23:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net> <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
In-Reply-To: <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 16 Sep 2020 08:42:40 +0200
Message-ID: <CAP8UFD3QD_DP7h_Pkv246O9_PehZKx9iW5PyFmT6HMYqJ=i2NQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 31, 2020 at 8:55 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Aug 28, 2020 at 8:56 AM Jeff King <peff@peff.net> wrote:

> >   - updates to our applicant materials (proposed projects, but also
> >     microproject / patch suggestions)
>
> It looks like many micro-project ideas from GSoC 2020 are still valid,
> and I have a few new ones, so I am ok to create a micro-project page.

Here is a new page with micro-project ideas for Outreachy applicants:

https://git.github.io/Outreachy-21-Microprojects/

I added only one new idea about modernizing test scripts, though I
know someone is already working on modernizing t7001. But I think it
can be applied to other test scripts.

While at it I also removed the GSoC 2020 material from the home page
and made a few cosmetic changes related to historical materials.
