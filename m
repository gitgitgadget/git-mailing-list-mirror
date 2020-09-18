Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6380AC43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AED20717
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 14:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKMkUlNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIROMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIROMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 10:12:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15EEC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:12:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g7so6890198iov.13
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T8WcJrwZzMT6eBrnurYBchYEK2XGE00z5PadFlqhq8M=;
        b=KKMkUlNPOsXOPyVVC1nFX2zZqGlNoq37sJR3xF1M2MKW0y8vE8ZGm0kY97lhUe9hEV
         Hi078oQQr6YafRPfr1fm+r1JSj2lra8csFrLWRXv4MGE0xgmPuCOySlQ27P+HgbZb6lo
         9H0vA9+VujqAferv54R0S2SNWgdM2cSovmvHMsN34u6GECgkK7j8r0PLmWr/HgMoorY7
         Ue+KSolGrmcwnTB3wHH0Xlo8b6cjTx2UhtrHP0vwnReU+1oyWyw8ujKOlfRM5kQTgHkj
         AYLJS+Ik0/BX4JqSzcxwZaYwl29H0qrKAupNCt3YQ/DvUBz2ARvmMBuj6aTXbB3Svq/R
         RxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T8WcJrwZzMT6eBrnurYBchYEK2XGE00z5PadFlqhq8M=;
        b=kEVFHhNRXFcCXgI8nLnn+RZ/ewtG3GywkA986Hco7nOZ81PLLeYnpz+HPHcYUBHAJm
         5EjWN9dcm75SFKIbsZok89X/s3GM/Q1EC6gJtnQHPwx2iC9nDcCoRgmc4Vy8Kc3vyNbo
         3lx16cEMpkOG+cQbtsuA47Nl0tdeRVdo78lkDfIjyzeeYAqDFk3DLjt/nCySAnOmtrJD
         57fmucec2fbMrIRljpDcXxWGKP8f7tKmf/36K7YQz35/gSAyV879p33DH2SQ+e0rN3MR
         ChftQ0zVM7Ur1ryimYwrfza6Vi2IZBxdayMlT3VLVOYYzfw/aEc8IvZLEPg3tEnkRJjG
         CRXQ==
X-Gm-Message-State: AOAM532CT3gYPTUCuJERDa8KtABKoMPVlTi6CZ0Oiu3YJq69L/PY5WH5
        29zC6nulcC57m3DKDOHe2w2rVQaSaWx7zcZ6lHJsFQM5
X-Google-Smtp-Source: ABdhPJzZAZCVxK/rftuU3zZufsIdmFHtdLnTKk/kGcZqVC/r64uvOMT4TrsA/WNG6MmGm0vaRoBjeyoWg5l5/H+UW+Y=
X-Received: by 2002:a6b:8b8c:: with SMTP id n134mr27407951iod.204.1600438340132;
 Fri, 18 Sep 2020 07:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpGcMJqmUmCR_u3fxSVppzwBo8_6RJG5-WLrXAWXm+OQ6_3bA@mail.gmail.com>
 <20200918140236.GA1602321@nand.local>
In-Reply-To: <20200918140236.GA1602321@nand.local>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 18 Sep 2020 16:12:09 +0200
Message-ID: <CAHpGcML=EFRngwjgaXNE53OOPoEBz+4Qi1v354gAv_vHNYS_gQ@mail.gmail.com>
Subject: Re: Apply git bundle to source tree?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Am Fr., 18. Sept. 2020 um 16:02 Uhr schrieb Taylor Blau <me@ttaylorr.com>:
>
> Hi Andreas,
>
> On Fri, Sep 18, 2020 at 01:13:52PM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Hi,
> >
> > I'm wondering if there's a way to apply a particular head in a bundle
> > to a source tree, for example:
> >
> >   $ git bundle create v5.9-rc1.bundle v5.8..v5.9-rc1
> >   $ cd linux-5.8
> >   $ git bundle APPLY ../5.9-rc1.bundle v5.9-rc1
>
> Sort of. You can specify a refspec when fetching from the bundle to
> fetch only the objects you care about, like:
>
>   cd linux-5.8
>   git fetch /path/to/bundle 'refs/tags/v5.9-rc1:refs/tags/v5.9-rc1'
>
> (or if you prefer, "git fetch /path/to/bundle 'tag v5.9-rc1'"). Then
> once you have the objects locally, you can merge it into your HEAD. You
> can do all of that in one step with:
>
>   git pull /path/to/bundle 'refs/tags/v5.9-rc1'
>
> There's no such thing as 'git bundle apply' though, although I suspect
> 'git pull' is what you wanted anyway.

I was actually looking for a way to apply a bundle to an actual source
tree, not a git repository. Fetching stuff from a bundle into a
repository seems to be reasonably well documented.

Thanks,
Andreas
