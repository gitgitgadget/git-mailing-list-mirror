Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCAAC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA4A60F0F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhI1AcZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhI1AcY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:32:24 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A130C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:30:46 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id az15so20194499vsb.8
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUajd8BuYCMnkpD0TcgEHnMpE07FPV7rlDx6X9WW7bE=;
        b=gXbFeZk0OT715qWp+nKbEzJ8KMzza4Ylc+kXlTf26GH3BLZ3l0H0X1XIXgz91LnODw
         NmX/JaBeaXA4fkTJWCOPW4CshVldBdOzb73ueGnU5zY3GXfWQTXQB/b5pvj/qOmIjogK
         nZL2C7Qasi/ahCknpLNbqTj3GAB0fO2waE1Wb/z2oRUUU4uFw6XyVoGLkSa5UeIy+UUo
         o9L5FItpXwRnGWNocs/gvG+J/jmY4gDgNy+xmbq1B09AH+kp4L7PPePe2gUr0qe8UOrz
         GjmbRUHbyrkL+ZicqJ9PDmB5UlxHs1o0+DlIwBTPeRJPLxhjWJ0AopQ+Vl7SW7P92Ay1
         z0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUajd8BuYCMnkpD0TcgEHnMpE07FPV7rlDx6X9WW7bE=;
        b=bKtc6DIOWowV0Ij27BkRRp5XpWQFpXwbYcacp/A+FPUcr6Hj/rVhIACAgUTr6Ele2x
         NI5WNWCiZthNLg0IdTksmL+osHDD9PG1ky0POC6la1kXaVcpiHAMWwNVVAvzWABiCVXa
         PQFNLK7cgo+BJ8628J1ENqtPlhtu5lPSGijb77n/WqYLwYInkDYYBLxrS1rXYA0r48l+
         /3x3i+iDdnCLHDUkMUpE0R+3DaeB8ryCmwDMyynfN0HKnb7Vi/H3DoIQpnmDfjCPxu8K
         I4l6Raj5CGpHl/rL0fXq4nEsRv2kSPndtQ+xfUxTFIIg96dNbz55h7GBe8D66kRiUrQm
         9+ug==
X-Gm-Message-State: AOAM532kHqHCbvbMO3/pA/FGJ6QtdjAf2DzH5ze98HraMBiIMt3D0B9U
        tDSL7+TYTAQltuvQzZJ6lzyko0VhUfTZj+3dIPU=
X-Google-Smtp-Source: ABdhPJwT4Y3/wcGMFCmhPApm+Eq8yL8wVXcDn1b3vw1MER/RywRD7lYzC9z6YV+2f8JINMVqRMehMeNSPaUR54hHArE=
X-Received: by 2002:a67:fa41:: with SMTP id j1mr2749984vsq.11.1632789045261;
 Mon, 27 Sep 2021 17:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210903170232.57646-3-carenas@gmail.com> <20210927230438.3759964-1-jonathantanmy@google.com>
In-Reply-To: <20210927230438.3759964-1-jonathantanmy@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 27 Sep 2021 17:30:34 -0700
Message-ID: <CAPUEsphk9b0TpUDgW9qkG=ehKx+hPi5GNtqTP2o2MeL1VpHHPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 4:04 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > +ifneq ($(filter gcc5,$(COMPILER_FEATURES)),)
> > +DEVELOPER_CFLAGS += -Wno-incompatible-pointer-types
> > +endif
>
> I noticed today that I wasn't warned about some incompatible function
> pointer signatures (that I expected to be warned about) due to this
> line - could the condition of adding this compiler flag be further
> narrowed down? gcc -v says:

Apologies; it is gone already in "seen" (and hopefully soon in "next")
by merging js/win-lazyload-buildfix[1]

>   gcc version 10.3.0 (Debian 10.3.0-9+build2)
>
> On my system, if I remove that line, "make DEVELOPER=1" is still
> successful.

Correct; it was only needed in Windows, will narrow it further.

Carlo

[1] https://github.com/gitster/git/tree/js/win-lazyload-buildfix
