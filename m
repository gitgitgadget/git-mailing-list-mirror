Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2533C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 19:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5C20836
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 19:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="EggHY6CZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLJTJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:09:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37717 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfLJTJa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 14:09:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so21158267lja.4
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EZm3W71ophoSBnTB9/KsHjc9lu1mfcSk2ogPcebxMs8=;
        b=EggHY6CZGNFWMIP6R/p1AJRzWkiyT7yMtEDt+yNzKCesocLVRGZz/Szc6ffsqKSoOv
         VqAbeBbUoo19jdoQJlekaLdWSeJmJ1oIRiWSytyTbRDwK01GLAi4iR3B7tKoJPTUyx9S
         vdcykMBqIXW/5OP/y/85x+8nnmmnGnAvkxXkjcAH93WEGW5Hsa/6QL1/Qxys9JUsVee8
         JcH7U4pSS133jBL9JhrmqKqbpK/fXLm+oWX9OAa2lQ9uRmXX7blIeQmeujspzQ60f1oN
         /kv5mk6cuyJe3sp1g5VginHt7ajLQcWohiLbVHXc6G/EfDpVa6rStnIKHYlZMM+02GKG
         RB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EZm3W71ophoSBnTB9/KsHjc9lu1mfcSk2ogPcebxMs8=;
        b=PDUA2h26BXHrslfW2y+uqbyVlY0vwQwljLnYRWkreJU6XNT06uN9La5bzsUZR+erQ2
         V5EODU82V8wTF6LpxPUn3RIlHnlnl1U6K62EKOG4Z/vNahrjnPP4sdHwBD2PLplR8y/n
         izvSxHERnyH3QB3tmBrp1Boc6x2z/kuHUU/tYoUEAQUMEsO/B8FjVUp3gWmP37OSvoQH
         3RgWOOUvPAjlimJ1DiQWwOE+P2BHtlUWlP16LAfNS6rC1JCedplFMq0pBirqyquCbKhz
         SkiYWLPZK/7CCXxVkeQfTa7PfPuruiyLd8PxFTCOOTQ49bhdwgalOfFOlqGboMmnyEw8
         Z2ag==
X-Gm-Message-State: APjAAAWlsUa4cIwNZhAP0LfHTfj5+Z3m9fZLxOPhiriPdeLmw3PZ4yvF
        qp1F39YYPpl/2R44YYTMTISuQoQ7YIiU/6cMtxZi1A==
X-Google-Smtp-Source: APXvYqz7UIb0s1R7/91lGZqTO+2v8/Dd8joZOmzVoGU1ALOIBGhtCjGALFj037SWrAXubda6C6ezd8qQu8k+WzDkKuE=
X-Received: by 2002:a2e:a408:: with SMTP id p8mr3722545ljn.145.1576004967372;
 Tue, 10 Dec 2019 11:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207003333.3228-2-yang.zhao@skyboxlabs.com> <20191210103014.GF6527@szeder.dev>
In-Reply-To: <20191210103014.GF6527@szeder.dev>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Tue, 10 Dec 2019 11:11:09 -0800
Message-ID: <CABvFv3Lud80UzFXa6BRMGLwRV6gsJpNcs-mrgOiNHoJL0d+koA@mail.gmail.com>
Subject: Re: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7 environment
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 2:30 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
> On Fri, Dec 06, 2019 at 04:33:19PM -0800, Yang Zhao wrote:
> > diff --git a/azure-pipelines.yml b/azure-pipelines.yml
> > index 37ed7e06c6..d5f9413248 100644
> > --- a/azure-pipelines.yml
> > +++ b/azure-pipelines.yml
> > @@ -331,7 +331,18 @@ jobs:
> >    displayName: linux-gcc
> >    condition: succeeded()
> >    pool: Hosted Ubuntu 1604
> > +  strategy:
> > +    matrix:
> > +      python27:
> > +        python.version: '2.7'
> > +      python37:
> > +        python.version: '3.7'
> >    steps:
> > +  - task: UsePythonVersion@0
> > +    inputs:
> > +      versionSpec: '$(python.version)'
> > +  - bash: |
> > +      echo "##vso[task.setvariable variable=3Dpython_path]$(which pyth=
on)"
>
> I don't speak 'azure-pipelines.yml', so question: will this build Git
> and run the whole test suite twice, once with Python 2.7 and once with
> 3.7?  I'm asking because 'git-p4' is the one and only Python script we
> have, with no plans for more, so running the whole test suite with a
> different Python version for a second time instead of running only the
> 'git-p4'-specific tests (t98*) seems to be quite wasteful.

The CI scripts as it is currently does not separate compiling and testing f=
or
non-Windows builds. I don't see a good way to only run a specific set of te=
sts
given a particular environment without re-architecturing the CI pipeline.

Furthermore, there's a step in the build that hard-codes the
environment's python
path into the installed version of the script. This complicates being
able to even create
a `git-p4` that runs under different python environments in Azure
Pipelines due to how
`UsePythonVersion@0` pulls python into version-specific directories.
I haven't dug into
why this hardcoding is done in the first place.

So, the question is if it's worth doing this work now when the desire
seems to be dropping
python-2.7 completely in the (near?) future.

--=20
Yang
