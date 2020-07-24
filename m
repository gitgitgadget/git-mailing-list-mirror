Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B25C433E3
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 12:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FB8206C1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 12:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Smv55fjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXMzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgGXMzS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 08:55:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BE6C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 05:55:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c2so1116293edx.8
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b74RXnAmSubUJzUK3Nv5aE426sfTzzbqQZ/K4t0m0Ww=;
        b=Smv55fjfmcU4o1dpx3w8dtco8QpOjWI+A5oPrkslxsdD103EgH1VsTOQr9GP34Inrh
         4O45hS+zIcF3mxIEAC8N4VnSCmpWeija3uoe4f2u6kcpNOtcCreKwvmeESalYxM4T0MT
         rjv6KIP6ZPhNq6AE34Flg4LjmU8lZWM1FsTn50XrtQYy644CvVdB40npQL5DiUuoLbkt
         5dnBU5j4QluBOu+MBYFBw9q6QxhWI8x6Yc8ZSLkP35l3MpKDqm5+YKTTS8SwhxCnpYYH
         81JEhelDCkGmmZB+mEXh7DUnmSLywUC6YlbEqvduKgEa5kO6WgjWkhoERiTo/GAByFZe
         0MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b74RXnAmSubUJzUK3Nv5aE426sfTzzbqQZ/K4t0m0Ww=;
        b=LgoVoZRsX/QeJHF8Ia0dd6M41Tlp6Ev/4T1OKRKU2rATiwX+zfH1AsKYJvO865HDrQ
         dr14bXDS2D/8yrQI2ogaUmzLHAUoqiQDRaHD9XNSm+Jkf3fw3T6NfLwFDQP39O2bm/8s
         RehDMuvaYeOEIu5ASgE72aZrpr5ErORXjUqruwEiAA1/CEgUXcsQbet00TtqYPAYG+U+
         SlkcXGgwV6fy2BqrMWMJ2R2F1KxDtH5pZyTj4oTaQFeI56Da2GuYj0qgrpBBy3LM+A9y
         fJ4p/tew+/22TO0BKcz37NwYhd48MNgDqPvVhM2SvpbI1cFSVLg0PX8xmzwltFzMVeDr
         Zryw==
X-Gm-Message-State: AOAM532zuKLu4Ips+mbTcPbeZWXCYJmT+85ZckkRbjydh6eLq5/u4Qge
        H/4oCVYmA8iWThw+hkGZhqbDS0+ZsIs1LBI05m8BqQoHat95+g==
X-Google-Smtp-Source: ABdhPJwdZLTF2H/U/ifnaG7ysGgK7v9jXL/hJ55y7xuSvnI7ObZBbW3g4dqR+VZ3DRphI586I6z4Zexpv8WAKy03pLY=
X-Received: by 2002:aa7:d0d1:: with SMTP id u17mr9081130edo.13.1595595317079;
 Fri, 24 Jul 2020 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200723205928.GB3579560@google.com> <xmqq1rl1q35q.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rl1q35q.fsf@gitster.c.googlers.com>
From:   Carmen Andoh <candoh@google.com>
Date:   Fri, 24 Jul 2020 08:55:05 -0400
Message-ID: <CA+TwhoLmR7vi0R6R-Wac7bvFoy+XQzX_OhGb090fzo=7REo4Hg@mail.gmail.com>
Subject: Re: Git Inclusion Summit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

First test of inclusion: be inclusive of time zones.
I've updated the whenisgood [1] to accept a broader time range.  From
6am to 9pm Pacific to be more doable for people in EMEA and APAC. To
those who have already responded with time preferences, can you submit
another response with the new times? Jonathan's suggestion of having
multiple half days at different times could be a good compromise (one
day you wake up early, another day you stay up late).

[1] https://whenisgood.net/9z2diyy

On Thu, Jul 23, 2020 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > Carmen Andoh wrote:
> >
> >> There's been some conversation about holding a virtual contributor
> >> summit focused on inclusion [1]. I've volunteered to work with
> >> Jonathan Nieder=E2=80=99s team on organizing this event.
> >
> > Welcome!
>
> Yup, welcome and thanks for helping.
>
> > Thoughts about how to get reasonable coverage for people in different
> > time zones?  It's subtle, but the whenisgood link appears to assume
> > U.S. pacific time --- I'd be willing to start a little earlier or end
> > a little later if it makes participation from other time zones easier.
>
> FWIW, we've timed coordinated security releases at late afternoon
> European, which translates to early afternoon Eastern and late
> morning Pacific time.  It was a bit inconvenient when I was in east
> Asia where it is past midnight but it was OK as it was convenient
> for everybody else.
>
> The intended population may be somewhat different for this event,
> but I suspect that the difference is not all that much.  Or am I
> not being inclusive enough for our Asian friends by assuming so?
