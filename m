Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3EC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B12611CD
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 08:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhDOI63 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhDOI62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 04:58:28 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E9C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:58:05 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id k12so1689213vkn.7
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ka/3cRmarexfmehCfM/1T9oyOBYvx0AWPolKPPFIzJY=;
        b=u+TuXVMVaw4bq5W6JGR4uSJwG8c7AjlryWToyi/74Woe2PIvYILGn3WebGH/obaD2v
         UvTzs2V+RHwUi3xm+vcVTC1tl/0Pn9KklsYfFSTtYjckucx9DG7RQKGyy8jHTgfaTXI4
         dnlS8YC8M4sArfVSQqgRXtztZQ6OAONEROM/BlWBsKlS//PD8B5ff6oOhMn+eroyzVkc
         2uTPODPyl00LabzthdZ4rWhxrCC3gFjvLCyvNRVSPrygjx0XKBCVzOnpz+D7iuJYNuLi
         P+I5j3SQfz1ZWeX3aUvN3dhT9SXl5oHrfL2+ctw8teJ3iJV2ost0Z3remBLgZw2ygh3d
         kWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ka/3cRmarexfmehCfM/1T9oyOBYvx0AWPolKPPFIzJY=;
        b=TlvNrR/okP4sXvVHPSe2RODQdxNuw2vVAMmlMf/HDuqIeixSKYLkPct9Ana1uMl05p
         fn1azyhYLAUxYQF2/bQ2K4nnE//YD0k/AJQ2BalfPbXm2pZhpvGr3cZmrPIUxNsN5YCI
         LXfUcFJeIMR3+7zc04dA6yyncdGwtfvCzYx5QkFXdR3cM19gT16VZ7/Na8G/6F6keF3S
         9QEUTTD3S45NEBgELsHdUNQyaTjQxNnyIuvti1DGSegC3fdcDkGbh/PQHByNQyIKcibK
         idvshUJVmo3VSATGNxo51rjvsxfiPcZnSCfo7JakooG3ARwHqTMyWtU3MJZh8Y8s4AZO
         o9GA==
X-Gm-Message-State: AOAM533BhcooEpdrLdYo8/Q90vTV9KLViPwfxCowt3EQuhsGiVy2O28D
        vV79jG2mCf7ZGNL50G2y7vfGiTvq2o8wyIt/z5XLgg==
X-Google-Smtp-Source: ABdhPJyw7301Yr0kunhUvOmQPp+yF1NOSfILKneKMn88qWklIVfC/xuEt1YkTzU84zu4B90gXnZjcWe8NmqG2teSKVc=
X-Received: by 2002:a1f:2c15:: with SMTP id s21mr964143vks.8.1618477084389;
 Thu, 15 Apr 2021 01:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
 <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com> <9297b9c363f6d922443d261375759046e303351d.1618255553.git.gitgitgadget@gmail.com>
 <87a6q2egvy.fsf@evledraar.gmail.com>
In-Reply-To: <87a6q2egvy.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 15 Apr 2021 10:57:53 +0200
Message-ID: <CAFQ2z_NusDzvVUjm7+pyuBc9wosuLD+rUdDwLO=hQbiRTs08PA@mail.gmail.com>
Subject: Re: [PATCH v6 07/20] reftable: reading/writing blocks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 10:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > Includes a code snippet copied from zlib
> > [...]
> > +int ZEXPORT uncompress_return_consumed (
>
> Pending the "how is this integrated?" question I had in
> http://lore.kernel.org/git/87fszuej8y.fsf@evledraar.gmail.com it's a bit
> odd to have a "compat" we unconditionally compile.
>
> Since this is for post-2017 zlib doesn't putting it in top-level
> compat/* and having a flag to enable it make more sense, and then not
> renaming the function.

Thanks. I've moved this into compat/ for the next version of the series

(how should I track this info. Is the email here fine, or do I somehow
have to work this into the commit message?)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
