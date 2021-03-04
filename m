Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C34C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8798664F60
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhCDSzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:55:15 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44737 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhCDSy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 13:54:57 -0500
Received: by mail-ed1-f54.google.com with SMTP id w9so2727393edc.11
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 10:54:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N10PtsNPFFZLazxFNEDsTLf4MNO21rtX4+lppOf8+hY=;
        b=BcWqT2VsBt/3kA+NgSwwDyNZoDNBoW8oSrtmlWLLhMS3l1Pth/685ltOAh9uvaUy9b
         6u1SIM8uPnUSNh3u2Dze/Q57sxN2k5MId4CRK1ZyZfDIC+1tEhehWmcT8sIMzHD8iM+L
         vXNNC/X3A0LGzgz+YW9HBG0trCTucO2qtroNJMbLRdcjk2JZPx3FTf8kCTbP02DfI8FT
         kCArzwH/vYVaIEfvocYcC5I+oaEGQRfmxeg1CB3p6h/sH/dymasDYjZIdYnxFunlJQbi
         oLchrcUdg2DR31IIUcAywYT6l5Dw/1iSqobFfRnjVcKxwfwB3vD4zb+nt/UI92Yzatss
         lJyQ==
X-Gm-Message-State: AOAM533YKdMz3Y8NkmQHudmq7i0WP/NVohoZjxvee/pdnZpmj1Xuv2hT
        LIjdYyBe6Ua4UeW9DBG4pnUNmUw+l7wuek6/k3DVxBIP
X-Google-Smtp-Source: ABdhPJyEHooZy9ZWFOpCDJ4dSvB8CVB8nNvQp8H6tEzrlTcKCOGNYN3j67ZXyYawPRGjZDMIx57xeUspxSCO2+gR4gw=
X-Received: by 2002:a50:9ecf:: with SMTP id a73mr5871811edf.181.1614884056546;
 Thu, 04 Mar 2021 10:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20210304184455.sah45hzavctfnhwa@yadavpratyush.com>
In-Reply-To: <20210304184455.sah45hzavctfnhwa@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Mar 2021 13:54:05 -0500
Message-ID: <CAPig+cR8WA-KpuBsOjqbR2yGMwiszwe_ZEeQzpV-DutCh0aaww@mail.gmail.com>
Subject: Re: [GIT PULL v2] git-gui pull request
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 1:45 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> In light of the recent breakages on macOS, this PR contains a revert of
> the offending commit. I will add it back in the next version with
> problems on macOS fixed.
>
> This highlights the need for me to figure out a way to test on macOS. It
> is not a good strategy to put breaking bugs in a release and hope to fix
> it in the next one. And macOS has been a regular offender. Dunno if it
> is possible without owning the Mac hardware though...

A couple suggestions:

Send pull requests to Junio early and often. His tree gets tested more
widely than the stand-alone git-gui, so breakage is more likely to get
detected earlier rather than later in his tree, thus giving us a more
comfortable margin for dealing with problems.

The majority of the problems noticed on macOS have not been specific
to macOS itself. Rather, they are specific to the old version of Tcl
which ships with macOS. Therefore, an easy way for you to detect these
problems early is to install an old version of Tcl on your development
machine and ensure that you test against that version before sending a
pull request. I think that this approach alone would catch all of the
outright breakage problems we've seen recently on macOS. (It won't
catch aesthetic issues, but those tend to be minor compared with the
outright breakage.)

Thanks.
