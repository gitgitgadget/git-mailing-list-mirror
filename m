Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FB1C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBBF20735
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sathyasays-com.20150623.gappssmtp.com header.i=@sathyasays-com.20150623.gappssmtp.com header.b="WvNhQvfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgKDPu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDPu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 10:50:28 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB45C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 07:50:28 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id o13so15173821ljj.11
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 07:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sathyasays-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI6/1S7ar11ZlOnd+3xyPsGU/Dks8eOlsEnGzi+jaxw=;
        b=WvNhQvfSuJlgMDzGIso4KiiO+sfHM65LjCmMZvKmZv6UUwQAKgSaAH611ddIR61Dym
         irBqBDpOn2JTj+/4kcTn/lt5fCISoCrl7FuzjIR06YjUN68kGcu8kD4zXcXThTlR7Cth
         sAP7Fkh8XXpi7gfsXpG4Dr1vUeE644wcbQWwtExKwK8zNjE1BJaHZmDL2A5mBkOPi2Mf
         L7KJd17lCfSchA776Pe+dRf+LxYSM11T1VTjyRS07qp2OuACRAUVMx5fMb9yx9oPltM1
         POzKYl7nJy4DGxtgrhgGEqzaf1ph7Z3p+MayM5fyQMMoBmlLvTNvWIjdon579SkzBMz9
         SdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI6/1S7ar11ZlOnd+3xyPsGU/Dks8eOlsEnGzi+jaxw=;
        b=OD2eHtbyGlc/AtWc0ApivcQstj0pFEJ3EToIbaRlfa8X03NOv/wSc3D4eEi9QX5/wI
         HDOdbqrAX/vyn1UfZmfyniUAy6o0qRVMzf+cb7EmI3huy3tewvJBeKsAaRtTuGGuymCr
         beoaghWYPyXuBg+e4zzIZtOrjf+WZZ9TvkbscnFP1TMxhacrr15ZFiF1oebfRfjCoOue
         fkOXFiNFSKtU1bir4Fl/mbHvilUWhCIUIQY/LgPli+Nfr+PVb0Ie5ScJl6n7sGMUuNS5
         vq+YPTjIqpGRTccI8vy8RlSD56x/8bfmg31g5EgPUBcCUQoaeavAFjsBfrgDEMIGKJAi
         fMkw==
X-Gm-Message-State: AOAM533G4Z8ozfeDtB6TTmkTYplHEkAG7ImlPYGio6B929IdbV2xwdRf
        +LoCnfxWY0EUKH1ynhPFm9x9/wq8awXtYxon9Ts+dg==
X-Google-Smtp-Source: ABdhPJwat4iyYNeUzZaCeJYBGGJ80oanu0VZ8HYZvfQmOLqRCEoWD4QMMM6Tn7hAWSindtqnseIX71pccKEI8So7RcE=
X-Received: by 2002:a2e:5d4:: with SMTP id 203mr483188ljf.137.1604505026440;
 Wed, 04 Nov 2020 07:50:26 -0800 (PST)
MIME-Version: 1.0
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <0581272e-6ad2-42d9-0196-b804ee304619@gmail.com> <CAMsWJsxyW=JUh=XGCkGG3LhOsZASwFHtx9b6ziNi_uHa918Scw@mail.gmail.com>
 <20201103192327.GA462936@coredump.intra.peff.net> <0b6657a6-afc2-7862-de43-94868f9419a5@gmail.com>
 <233ea345-68ea-fdfb-9c7d-1c2cb4f7e4ba@gmail.com>
In-Reply-To: <233ea345-68ea-fdfb-9c7d-1c2cb4f7e4ba@gmail.com>
From:   Sathyajith Bhat <sathya@sathyasays.com>
Date:   Wed, 4 Nov 2020 17:49:50 +0200
Message-ID: <CAMsWJswaTaEaKs+Brsy0YB26n4X4WAbu9J-1U88vZLjcQwKs5w@mail.gmail.com>
Subject: Re: Segfault in git when using git logs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Nov 2020 at 23:04, Derrick Stolee <stolee@gmail.com> wrote:

> The issue has been fixed in GitLens, so please update your
> extension to verify.
>
> [1] https://github.com/eamodio/vscode-gitlens/commit/d980c7b831961f932ae68ed6e8ab08f71983b9a9
> [2] https://twitter.com/eamodio/status/1323729485338914817?s=20

I re-enabled the extension today and was able to get by the whole day
without any crashes - well, there was one but I couldn't repro it or
find the logs for the same.

Thank you folks for reporting to Gitlens, truly appreciate the work
goes behind the scenes

Cheers,
Sathya
