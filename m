Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BBFC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0679E22527
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="VLwAvwqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfLLREl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:04:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41039 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729927AbfLLREl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 12:04:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so2240605lfp.8
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yV64ITC9a6iVSinJG242v4iY7ffIrQgt1f0pjkjQCIQ=;
        b=VLwAvwquzy6q0U3XvySGXwWDrSbfShRGoHiY5fA1MX6ikcwvAh4FOBlkB6i372Nnot
         RsodHdJpbCQpUq1bI08JwxK+PYXRUWllKfleg8qoiUV6XFnfkvCmZCqpDVzj9cM53TiF
         pbOAvsxVNd4pmIlOptj6laauB0qpvqG0slDW/tmSZ+5fMKehsDzQZV4Iy4SwIOjGkJyq
         eKvWkmxKIqcC8xx8FNZ4Yu4ot/a8by5LYPeHJePOMEAXPde9ZNYK+A7C5QtA8YVaBVfE
         Mrn3P7eb6ixpjvMs9Ej6vypEycZyyp6tRLB3ICuBb366oF4FVfeDx3TSy2yxCqkG2hXK
         r3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yV64ITC9a6iVSinJG242v4iY7ffIrQgt1f0pjkjQCIQ=;
        b=F63Te9SbxhKzuM7CHnvX9ssk+irQ3xv1gj9VHEApJ9eAFat0AsHcHHFOTVhquTSjAs
         yMDsdZRkiNjm3eyGPIoXivpYI6aVxoVqbR4Sgn4C0YfPPKAi3MUh3Nxq0AZFgl8f2zEr
         HizQNJKdZpNNWCGlDnYFG3KCBvG9sjRAUmNsm4V0qM1/Ob5T0OglL32BJOKfVz1zAaKw
         vpH8fhELuARb1UV3/vtpeyZxS7RLexi6eKRCRp0qnr3pD4qc81KJVScl3w6ON210JUJ8
         DpO99fGm8Ek6Q42SRPGK/Tc1NHAjJtL33GJ623L+fhD1fYwfxsD6O0J8PGRL5lPXgD4n
         +9iQ==
X-Gm-Message-State: APjAAAU55hRELj4sqLPrI/YUXv1UkzTyxM1kWBWsYMHrwjn67ndA+2V4
        HwB2lkHzz2hDaaibtm+o9rs8K3xT40AQnk6LagEiDQ==
X-Google-Smtp-Source: APXvYqyejeC/QsoFwRJuAlVZeSUm+PEhjFIbAboE6+K3zjfPsblcPI9FO57atRrcfU2LUgyutthskg88g46sq4gsOu4=
X-Received: by 2002:a19:f006:: with SMTP id p6mr6264005lfc.94.1576170279727;
 Thu, 12 Dec 2019 09:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207003333.3228-2-yang.zhao@skyboxlabs.com> <20191210103014.GF6527@szeder.dev>
 <CABvFv3Lud80UzFXa6BRMGLwRV6gsJpNcs-mrgOiNHoJL0d+koA@mail.gmail.com> <20191212141322.GK6527@szeder.dev>
In-Reply-To: <20191212141322.GK6527@szeder.dev>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Thu, 12 Dec 2019 09:04:24 -0800
Message-ID: <CABvFv3J8JjXGeAXSWDmK5zDav8qYNQ6Ce-8dPGAmuySGj8xvNg@mail.gmail.com>
Subject: Re: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7 environment
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 6:13 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> > The CI scripts as it is currently does not separate compiling and testi=
ng for
> > non-Windows builds. I don't see a good way to only run a specific set o=
f tests
> > given a particular environment without re-architecturing the CI pipelin=
e.
>
> Building git and running the test suite is encapsulated in the
> 'ci/run-build-and-tests.sh' script, while installing dependencies is
> encapsulated in 'ci/install-dependencies.sh', just in case Azure
> Pipelines Linux images don't contain both Python 2 and 3 (Travis CI
> images contain 2.7 and 3.5)  So I don't think it's necessary to touch
> 'azure-pipelines.yml' or '.travis.yml' at all.

Yes, and this is implemented as a single step as far as the CI
pipeline is concerned. It does not produce a build artifact that can
then be loaded into multiple environments for running tests.

Unless there's a very good reason to _not_ use Azure Pipeline's
built-in Python version selection support, I believe it's more
desirable in the long-run to leverage the feature rather than maintain
some custom solution.

--=20
Yang
