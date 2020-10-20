Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C462C388F2
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D44122256
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O97I46oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439004AbgJTWRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbgJTWRg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:17:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DAEC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:17:36 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s21so3852267oij.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6gPPQalbw6KeOsq5T4qHJg3RrcjUYvz1abpEuIt21Y=;
        b=O97I46oobGsSJZv52ZotOQ2IwbcVP9ap5YKGl8f2jl5LpbkGqJYSAVeiPRLgmu9QzI
         MoNWZoiK2DncoedBpN8V605okZgN0j7AOYlCKRVU3Pra9AOd3c1g5Vl7IeOia+FCFcDf
         DSwRloHpsumhtkz/xQKns2PsGXRabYpNhu3IxWZaW3FOcruFky4Pf5ajWRR2r34uCiFa
         515EKKFQIxsA0qMO6RXdmxMPNdWP/ZeXoU0uJkCN+Y5bw5lqQlExO99PA+6CgdUGEr3J
         9rh+GlW9k5m44gPsLkNF1msW2C7lNhN6JY2rT+6C96WZW/e4J4Aiw6dNGKEVCFRmaPA7
         Mqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6gPPQalbw6KeOsq5T4qHJg3RrcjUYvz1abpEuIt21Y=;
        b=BrsoLGPwDeVOQNdAG9MPj+9nf6l0M7sY//bcswyiPpdDy1uCjE37rHyTth9dAm4w1N
         7ka1oTzpsiexT1XT6cucgAlNL2tb729YuMVQJjJ/1FsDdfWksauTKN8exC6Ny36DQKtj
         rWszLUYG07lsyYGg9EnvrIjvtXU0CMT5mkJuZJSrdVIfIYEU8wRD4bzu4JvRNRmO1l37
         3paSdsSWawjUM5IKHJPV9iuyHGpPfnH2a1XzPWji2miiKL7Wb0MeGC9cG1/fBleTMLTs
         FVMMbfemIgDoAPhxyFKSabbqMcGFQunjJNnSWLqSGDiV63IK9XqraB/zS+S/N/GhwM2v
         gQGw==
X-Gm-Message-State: AOAM531jHI0yNowFCi6/YoX6CoKAFPJ7KUsX4uvALWmv29QguWJnwwJW
        DSgvpr+g3Rj1bZRFgryWZ6Rm5jt16UssTLRC5GYckl0t0DhlwA==
X-Google-Smtp-Source: ABdhPJz3PubFSHgRcdktYelqbxvrLA5as2JPLRBSzDYR5tubist59Q0b8SXmeQv3XjwH87yub9uX2woJTzq7HQleguE=
X-Received: by 2002:aca:d444:: with SMTP id l65mr132805oig.29.1603232255867;
 Tue, 20 Oct 2020 15:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.v3.git.1603147657.gitgitgadget@gmail.com>
 <pull.756.v4.git.1603201264.gitgitgadget@gmail.com> <b534cd137a833de802d6d95c1affb8d2d8f7de85.1603201265.git.gitgitgadget@gmail.com>
 <20201020220629.GF75186@nand.local>
In-Reply-To: <20201020220629.GF75186@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Tue, 20 Oct 2020 23:17:23 +0100
Message-ID: <CAN8Z4-Uedr-6ThkyWCtVgRSrdTW+N0yeOQTUqFtqAj8QsGBEdQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] perf lint: add make test-lint to perf tests
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > --- a/t/perf/p3400-rebase.sh
> > +++ b/t/perf/p3400-rebase.sh
> > @@ -9,16 +9,16 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
> >       git checkout -f -B base &&
> >       git checkout -B to-rebase &&
> >       git checkout -B upstream &&
> > -     for i in $(seq 100)
> > +     for i in $(test_seq 100)
> >       do
> >               # simulate huge diffs
> >               echo change$i >unrelated-file$i &&
> > -             seq 1000 >>unrelated-file$i &&
> > +             test_seq 1000 >>unrelated-file$i &&
> >               git add unrelated-file$i &&
> >               test_tick &&
> >               git commit -m commit$i unrelated-file$i &&
> >               echo change$i >unrelated-file$i &&
> > -             seq 1000 | tac >>unrelated-file$i &&
> > +             test_seq 1000 | tac >>unrelated-file$i &&
>
> The rest of this all looks good, but I think adding 'tac' here is still
> wrong; this isn't available everywhere, so we would want to find an
> alternative before going further. Is there a reason that you couldn't
> use a different 'N' in 'test_seq N' here?

Hey. I think there's some confusion. I didn't add `tac`. It was
already here. I didn't even notice it until Junio mentioned it.

--Nipunn
