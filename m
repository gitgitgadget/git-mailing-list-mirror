Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E6C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 11:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbiCHLzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 06:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiCHLzr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 06:55:47 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB63614A
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 03:54:51 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id u124so13233267vsb.10
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 03:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqWdNJoxZFnSaFWZIyTL4WKM64nartftvJAKx15Qf/o=;
        b=PkHTv0qZuMyhYzKERHRE7xP4QedHM2qZPdEnr1uSIWMkHbX6ML183C2SfGB56wrXey
         fJrOtSq1ORVavEgg50OXtgDBu/5jC8T0AwAUtIGnLDBXWSerSIycIVd7RkpaB9sJbMIK
         I8q3yzX4/qMkNlJhHdz2S5cBMlC5PB6JozvLUYlJufJuoBA9tCLnN3DUNFhsczFVmLFO
         rISXXOWoJo5XtJ4PoqpVB5c+io5DVk67SbDU1snVlvjQIQ1ysM8j2stYBeWOdDEJjzJm
         dZn+7tI3lQ+FHF/YQoQRgikX7RokyQNGrOSVjK/ZHSg6mlrdePPcuVwwUE4QSKWDg9zI
         PnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqWdNJoxZFnSaFWZIyTL4WKM64nartftvJAKx15Qf/o=;
        b=HdwpLyW4XTFfnvgELBJvJjsC5vf9jXATt4GkFmwXCIveoLke/T7Is7kQ05AgMedvzx
         NXkdQq15pHCHHophjH5EYr0VvZvCEC3ibctgxQP5Mzxz+mObZPb/Sj6qaEcBlfNWOISp
         AU4DtndEcUElJRfFbs0OYtxUlh7dAs+u0Y/RYo3fWhYeePsNPk/P6Mt1nTIJxkuZYoN9
         YRySZ/HRNCBwjA2xozt2cfpC4wb1d/McKqM4oIk1yAFUUdK2rJlQjgHY0eoBw2/MHIct
         8kDtBadJlVvaGV/yiFiYNQdiKHN6atAKL+1DRVPPcL6zXJXhVMtAEVy8MePNAotAioad
         j4Yg==
X-Gm-Message-State: AOAM532xhse5eamlzCKeUIu2683ZeXs/T2jhWK+AddqxnUAKkz4FXEeb
        j0UXENFMEfafdMPyBtKUBEoA79FIofNXa85i0XYIbLYGN6M=
X-Google-Smtp-Source: ABdhPJyn6f4M+ytm9jk98lwi2GrrxOSdu+FHB8gsbXWhJImyAGuwaPDt1EpvnTKVsMxymYln4IPm+MSohASzwJISmG4=
X-Received: by 2002:a67:f814:0:b0:320:c172:d783 with SMTP id
 l20-20020a67f814000000b00320c172d783mr4005606vso.13.1646740490477; Tue, 08
 Mar 2022 03:54:50 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
In-Reply-To: <CAPMMpog=qBwLrxss_ci6ZMM+AjbdrF8tszXLW7YH1Zqr+m7mPQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 8 Mar 2022 12:54:39 +0100
Message-ID: <CAFQ2z_Oht=-QrzoH8FW_Jm-B7u9O0wXUaY-ifwZah6gkcgVVSA@mail.gmail.com>
Subject: Re: Keep reflogs for deleted (remote tracking) branches?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 12:28 PM Tao Klerks <tao@klerks.biz> wrote:
> As far as I can tell, even "core.logAllRefUpdates=always" does *not*
> keep any reflog entries around, even temporarily (until reflog
> expiry), once a ref  is deleted - do I understand that correctly? Is
> this behavior intentional / reasoned, or just a consequence of the
> fact that it's *hard* to keep "managing" per-branch reflogs for
> branches that don't exist?
>
> I am planning a workaround using server hooks to "back up" refs that
> are being deleted from specific namespaces, in my specific case, and I
> imagine that a system like github keeps track of deleted stuff itself
> for a while, but I find this "per-ref reflog disappearance" behavior
> puzzling / out-of-character, so wanted to make sure I'm not missing
> something.

I think this behavior is motivated by directory/file conflicts. If you
have a reflog file in refs/logs/foo, you can't create a reflog for
refs/foo/bar, because that would live in refs/logs/foo/bar

At Google, we keep reflogs in a completely different storage system
altogether, which avoids this problem, and I wouldn't be surprised if
other large hosting providers do something similar.

-- 
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
