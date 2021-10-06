Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B7C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FAE610C9
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbhJFOrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbhJFOrk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 10:47:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B7C061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 07:45:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id z40so1298570qko.7
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v2Foiu59pwp4tYBwws1CaLyWCch5N8XEi9lcAFyLlLs=;
        b=pOIY3noIoOnbOxIR4UoqkNLc+NAhED0WOzB0oRMn7fr19BQwWjoHELD6Tnc82kdO35
         5jHX/Hzb2HLsyWwrKoldErJOr2AZlbrjv/IHsenbeMx7mkigXDd70rSAhCcZ1fJTAiPH
         y+oeNCEg1L6KGQS1c0qbKHSE8vWRtgUluhz1qYvtpUa+U8rC7ehHVdXNrP7Xn0/1Ex7E
         eeBDJ8i9Wtzn+rw6+7MOGIAJqKT1QPbXeYMfnmJ7MbbGb2IybXqZlsahDMKLaa76Zsjy
         R/eL35lK49bCCjCANGCH2P2gNPW3YFXktN9c5hLnNqpVw7NUzkrnDj/blH2lQUG1IHdb
         Nvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v2Foiu59pwp4tYBwws1CaLyWCch5N8XEi9lcAFyLlLs=;
        b=OwTBK0sqcUGW5yErlIOiM3RxPkbbMmb5jsZNUPz3kAlY9fhCia7yHxUoRbDi0GhJ87
         9pMaPQKaMQb2LdW8vpJcQOaH8nrSGdZhS2gAS2dS4CswrZ1r/b/mdi/zNaQkQXc1v13j
         k/N3ggjM3p+z7m2Zn9nVg6JNfo+NBJVcMejfn/GwwZlEQAX4Hrccv2Pzi8/3QRlvvsNX
         X4molJCGF1Y8t3uGewyhvIcjv8x3qbal/RDLsOwqu2c23s7NwfknrH0NApl9Z03g0j7V
         rWcA5TULsJJkLSB0qiaADpGA115hg/Ownfazcn5IC+AeRaMQ8I3Fi6EOoJC2OerJyZCC
         BEdQ==
X-Gm-Message-State: AOAM532qxx7t1oXc1+07REPitH5vItOD8erTIqafsiOTpzKBbpoFJlgn
        G4BxIbNPqOidwlM87hZR9L50FDmdvi8A/svw3v+vbwIVxP1wHA==
X-Google-Smtp-Source: ABdhPJy/yZv45aHFZ0z1cuJtB0jlOoHHlaswjOwWuKwrxZ3uwp6VueUARe0FYaOoh+W2q37emPmVbuuogNWLobaslME=
X-Received: by 2002:a37:bf85:: with SMTP id p127mr1137916qkf.259.1633531547585;
 Wed, 06 Oct 2021 07:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABkJDHFOMkf-Pouaw3rtjtM+KFhPxnYtCiMbqKYCraXFb_9qQw@mail.gmail.com>
 <7b4b59a4-7e58-3db2-d934-d570cdebbf31@gmail.com> <CABkJDHHDjwviVmCR=tu3JBx+7BMmbmesOrkymq0fH4PXE5=i1g@mail.gmail.com>
 <135f854b-7975-a6a0-69ea-8697583a87b2@gmail.com> <CAJDDKr7itDvy1WPoC=kBPpT4_qm6MKWWfxwt96wQJKnGBGW5ng@mail.gmail.com>
 <CABkJDHFMy6yS40jn-NJ8mwrv6jxdjgNWQ6mJmEK1FYV0gvpLEQ@mail.gmail.com>
 <CABkJDHEZuZSun0spZ8SAcgQQvu-zamnJiqGk7VnS6agU-_KqqA@mail.gmail.com>
 <20211004075600.5lbqed4mnwfsy4al@yadavpratyush.com> <CABkJDHGdzOFW5yP43LZtuUrV7WsDTvAi+kxka84-5P7ShbV9FQ@mail.gmail.com>
 <20211006113912.n7xpnuzd25256cjm@yadavpratyush.com>
In-Reply-To: <20211006113912.n7xpnuzd25256cjm@yadavpratyush.com>
From:   Sashank Bandi <bandi.rao999@gmail.com>
Date:   Wed, 6 Oct 2021 20:15:37 +0530
Message-ID: <CABkJDHFap2DmjMr1Ri-Mrud+msChB3uEGRKYyczAxfmaLnF6jA@mail.gmail.com>
Subject: Re: [INFO] Does Git GUI support Dark Mode on Windows 10 ?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Does the Windows installation come with any other themes? You can use
> `ttk::style theme names` to list all available themes.
It contains all these themes in Windows 10 x64.
"winnative clam alt default classic vista xpnative"
Based of [0] (the best source I could find),
"winnative", "vista", "xpnative" are Windows-only but built-in themes and
"clam", "alt", "default", "classic" are built-in themes for all OSes.
And this is part of the reason I am considering "default" to be the
base of the new theme that I want to create instead of "vista".

> > > I think it would be nice if we can have a theme picker in the options
> > > menu though, so that is something you might want to look into.
> > Yes, I thought of adding a menu between "Tools" and "Help". It will
> > contain 3 options(system, light, dark) as I said before.
>
> I think it would be better to put it in the "options" dialog.
Ok.

> I don't mind carrying themes in the git-gui repo since Tk theming
> support is not very well documented or standardized. But please do be
> careful of licence compatibility when porting code.
No, I want to imitate the look. And I don't actually know much about
the license or legal side of the software so I try to avoid it at all
costs and start from scratch.
Kinda like "Linux is Unix-like, but it doesn't contain Unix's code" -
The great Linus Torvalds.

The "equilux" theme is GPLv3, but I didn't find a license file in the
repo. In the "Help > About" part of Git GUI, you mentioned it being
GPL(I think v1). Please include it in the repo too.

[0]: https://wiki.tcl-lang.org/page/List+of+ttk+Themes
