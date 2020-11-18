Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF47C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD1C2220B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZS2bwrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgKRTS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgKRTS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:18:58 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C2C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:18:58 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id v8so1153533vso.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1uZ9rXfpM2ZERfAg8XtkwgyTxbaGSz8yIaC/SAJz2cI=;
        b=CZS2bwrpQIQPvsbJ6BkkvNmku+T2GRi692B6sQbQl80oa7sS2lBpfzMBfaaWRMkW8q
         DAXZYCnxUeaX0XmkPJUvora5jPWGIKnZ7D0/kRs16M5z2ME3QkIXM9fLJ1LSHSRwxn5Y
         4bX52Q+Z+bm5uTMRJFyi1Fj/aUvSOwE2+pvSPjbIs3EZeAX9C0ll73HTFufNK02QbZCl
         dCDg7kL4d7WaV5p8JlSJdYg1GHkROA9vLDXRbvc+HaUs7Gq+5CtIk1aNpdfNdVZz/keU
         k1bmPhc9EJEkKdCg6k+Y0fV6in2nheTgSMtujr5FdFdIJaILglVVxTqYNl0HiR+oaL9L
         Q4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1uZ9rXfpM2ZERfAg8XtkwgyTxbaGSz8yIaC/SAJz2cI=;
        b=c9RhglR7Zdw5gtX+TszmeqVlZxim9v+d4Ji+hSpI6j+d4u7jKiVAL6MxdjTX4B1mD+
         6f2X/f0jnBigofVua+kA8gUqcIvIaH0qVMtzaUDQoaIemD9EcqJ4xnLkFK1K2lbmG+h6
         eKWA1qoJDOVDyZHMAK70cZsdwrvun59A79b3RXM5TnTuCbji768Il2YU11gwSYEaZjGC
         RAqOCFm/LbwTYF11ZcKwD3GhGZl9EvNAyHtDvVDAP6vlDo3d9yn2kYBjrOrz5TRGcdmi
         GRcTDODUZycTRrxR/QBJ7N0b6haguhDIK6/8KjjNvDOweDaPtlJrM9+DykjaqO3D9y55
         Hq0w==
X-Gm-Message-State: AOAM531RVaeHRsI9z4Ldo3BKdd3gBc+wlJx1mwIMDWJmFeAOMljxB5ft
        c2o1eaotDggqBWhnQXLgg+FdDg0JjeUiCATC6v0=
X-Google-Smtp-Source: ABdhPJw8hhvVETedh5D6SneAT/kxfGM7s8gubhAlth/7PJvgaBF6zYccYSE2bxlnyBOgeWaDfdPdizbDOqBqVVEgRps=
X-Received: by 2002:a05:6102:22fb:: with SMTP id b27mr5092223vsh.49.1605727137842;
 Wed, 18 Nov 2020 11:18:57 -0800 (PST)
MIME-Version: 1.0
References: <348a2a4a-dfdb-190b-edac-01e9ad4c2d4d@greg0ire.fr>
 <CAN0heSrU5zzgR_FDZcEopPP2EmSQnraZXO4v8Smx8=fWcXa0uQ@mail.gmail.com>
 <e666e806-d8c6-0b8d-c583-e4a8ee0ee806@greg0ire.fr> <CAN0heSr9=_So-sUhQN86vawBEkJhnrHHsd3OcSYZMZ-idZGFAQ@mail.gmail.com>
 <5a2d70eb-da75-ff59-8ac1-6ba81e1632da@web.de> <a205cb0c-95ec-7f9e-0dea-8fd5b4bc694f@greg0ire.fr>
In-Reply-To: <a205cb0c-95ec-7f9e-0dea-8fd5b4bc694f@greg0ire.fr>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 18 Nov 2020 20:18:44 +0100
Message-ID: <CAN0heSrqs9GLo6DA8aWGG8JON4NmGCEiw63pR0BJRZHRTZOaFA@mail.gmail.com>
Subject: Re: phpdoc diff in git -L is not the correct one
To:     =?UTF-8?Q?Gr=C3=A9goire_PARIS?= <postmaster@greg0ire.fr>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 18 Nov 2020 at 09:17, Gr=C3=A9goire PARIS <postmaster@greg0ire.fr> =
wrote:
> On 11/15/20 12:40 AM, Ren=C3=A9 Scharfe wrote:
> >
> > The --function-context options of git diff and git grep try to show
> > comments by including non-empty lines before function lines.

> >    This
> > heuristic might work for -L :funcname:file as well (patch below), but
> > breaks seven tests in each of t8001-annotate.sh, t8002-blame.sh and
> > t8012-blame-colors.sh.
>
> I haven't written C in 10 literal years but I think I managed to apply
> this patch, and something looks wrong: it's looking too "far" before:
> See for instance: --- commit 1a8a640f87cad94d36713f45e5e257de20930171
> Author: Michael Moravec <me@majkl.me> Date: Mon Mar 5 04:01:58 2018
> +0100 Upgrade to Doctrine CS 4.0 diff --git
> a/src/Doctrine/Instantiator/Instantiator.php
> b/src/Doctrine/Instantiator/Instantiator.php ---
> a/src/Doctrine/Instantiator/Instantiator.php +++
> b/src/Doctrine/Instantiator/Instantiator.php @@ -31,12 +33,14 @@ */
> private static $cachedInstantiators =3D []; /** - * @var object[] of
> objects that can directly be cloned, indexed by class name + * Array of
> objects that can directly be cloned, indexed by class name. + * + * @var
> object[] */ private static $cachedCloneables =3D []; /** * {@inheritDoc}
> */ public function instantiate($className) --- Here it's picking changes
> in the phpdoc of the property that precedes `instantiate`, (when using
> git log
> -L/instantiate\(/,-14:src/Doctrine/Instantiator/Instantiator.php) What's
> wrong? -- greg0ire

So to reproduce, it's first something like this?

  git clone https://github.com/doctrine/instantiator.git
  cd instantiator
  echo '*.php diff=3Dphp' >>.gitattributes

Then this?

  git log -L/instantiate\(/,-14:src/Doctrine/Instantiator/Instantiator.php

Or should that be the following?

  git log -L :instantiate:src/Doctrine/Instantiator/Instantiator.php

I played around a little, but couldn't seem to hit 1a8a640f87 as you
mentioned.

Martin
