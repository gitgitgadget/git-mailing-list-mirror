Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1328C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 12:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiGAMsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiGAMsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 08:48:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A6F109A
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 05:48:09 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v185so2112009ioe.11
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=36G1Mv3Wfkf+VE7wpC84VY8Ib/jwtECFdCF6xIjBGGM=;
        b=WW/QeoV42Hc/ZBddEx4HqrKA1ANj5eMrwnumK9EhW+GiKmb53A+0L2MWwm/6SAE6wE
         LS/8yuYoKS3CruW+DJQJmKutWMdyQRjhds5/b/mkA//txrF+0BcDzV/FEzsTdua0Yi1Y
         zUiae+qXuRHvPihQxjYStcZq7hWTjzgpF66FMsv0mbtc9gLgAxieWLjzfy8v+mI4SQL/
         MOGgoSHf/0gM4EIIQETGUOEe0xj7cDNJclbfLZz3npEwj+pOF8rMC4wYIHaZgGDQ08YL
         RVZaCr2la/Fg/c6aiQP9egEnSst0f0agBijaBR7yKGz0MkQ2WEYsTttvlRvP62U9fq+0
         fxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=36G1Mv3Wfkf+VE7wpC84VY8Ib/jwtECFdCF6xIjBGGM=;
        b=7KlH0EBSP7x3VYaTDzXR8RBDRkinmLffA9zLTRd2WINs1u+QgjA8pu4YnsOA4ednkq
         RqqnDcK8Y/Id9F5CuJj6Gnb4FDp/rjzOKra2vPHCCczeAaxCSFVOlWFdT3NYEr99NZ2N
         zwOK4oF+v8BNxxfTa0rhrADB6PfNbps13cvFIVjNLq90FfyHujltOItPI8MJNzD9tnmq
         rpiY50zec6q4e7fduruoQ5z2//qpUy61gHEhSLaj4uV8wCHdiSuK6zlGcwuaa9undA7/
         t7TAuCqo0fRc0SVsMawXHcGeP4BhCo2HYOd7/oZHHzYTtl15qAAxi4nYjNaveWaQ5GU9
         3T7g==
X-Gm-Message-State: AJIora+iLpYKvAI3p5SJqopJ6nnNF1cljeBata7U9PgGyJQmoUNJV7BN
        EfAVFa2+PTK+O7gxnKIA8cmK6IjM5rYFEwARU44=
X-Google-Smtp-Source: AGRyM1sae6Uqg0uSWHLElLAoZjZNUMf++lYZMfXYEfOuWdoBkT1I+dUkGR8a05jAxYBEKcPquOqKfAueLOr0Tn5uGlc=
X-Received: by 2002:a05:6638:ec9:b0:339:c3a2:b14c with SMTP id
 q9-20020a0566380ec900b00339c3a2b14cmr8965358jas.128.1656679688472; Fri, 01
 Jul 2022 05:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com> <a556feaa-5f72-7c83-7156-fe91f18fc24a@gmail.com>
In-Reply-To: <a556feaa-5f72-7c83-7156-fe91f18fc24a@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 1 Jul 2022 20:47:57 +0800
Message-ID: <CAOLTT8QgsdkCrfYY9Of7qgDkvvZc+=Bao4irX6xq_C5wr4vb6Q@mail.gmail.com>
Subject: Re: [PATCH v4] ls-files: introduce "--format" option
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C 23:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi ZheNing
>
> This looks good, I don't have much to add beyond the comments others
> have left.
>
> On 26/06/2022 16:29, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> > +FIELD NAMES
> > +-----------
> > +Various values from structured fields can be used to interpolate
> > +into the resulting output. For each outputting line, the following
> > +names can be used:
> > +
> > +objectmode::
> > +     The mode of the file which is recorded in the index.
> > +objectname::
> > +     The name of the file which is recorded in the index.
> > +stage::
> > +     The stage of the file which is recorded in the index.
> > +eolinfo:index::
> > +     The <eolinfo> of the file which is recorded in the index.
> > +eolinfo:worktree::
> > +     The <eolinfo> of the file which is recorded in the working tree.
> > +eolattr::
> > +     The <eolattr> of the file which is recorded in the index.
> > +path::
> > +     The pathname of the file which is recorded in the index.
>
> I think starting with this shorter list of field names is a good idea,
> we can always add more fields later if there is a demand for %(flags) etc=
.
>

Agree.

> > +test_expect_success 'git ls-files --format with --debug' '
> > +     git ls-files --debug >expect &&
> > +     git ls-files --format=3D"%(path)" --debug >actual &&
> > +     test_cmp expect actual
> > +'
>
> What's the motivation for being able to combine --format with --debug?
>

I guess it may help us get debug informations together with --format output
when we are doing some tests.

> Best Wishes
>
> Phillip

ZheNing Hu
