Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E533C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73553611CB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhECO70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhECO7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:59:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A25C061761
        for <git@vger.kernel.org>; Mon,  3 May 2021 07:58:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 124so8511218lff.5
        for <git@vger.kernel.org>; Mon, 03 May 2021 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cf4huCvwaVtIMgNzGcSnj/bC/bu85Wjf/wcw8mv7/yE=;
        b=Xag3jS2uhx9E5aKOuWD7+84zyZFjjiIjWLlYXJQ4utu+z7vG+jVZynjxDeE3IwSO9p
         hbWLov4MA2TLECHAGL56vGqygJ637oL5oK5xfgSvqHs6aAot6z1vtQ/IQUKnbWqdeBP1
         edBhp2a7ng6pEMxh9AfR27aa7Oe3oAxdWKQIoh6Kn7KGeNHDXg8BVMVkSKeAlXtkfdrD
         oVdhhdVtfljK5dxn/iudr2qsb2ZnpXfWGbI6ppOJcoaq4QPxiBZmASkrKuHvMrOxuLJe
         AEx5DZwVCfmWi8oLfXOowEhOQPnpn1rzIVQchD/ksHAFlpnrNP6Ikfe5i0F8muMCSQxJ
         Xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cf4huCvwaVtIMgNzGcSnj/bC/bu85Wjf/wcw8mv7/yE=;
        b=jdzYnVBt1z/A+y9orAQs4IOKJAr/N6sQd2NLWyiHwK/YjEGwHjqYuyNyuYP6GQOKiz
         SkhJiuB/A5DfHe/W94EVI5SmhP+ebQfG+1xeQX7G/cFLicLcdx5QpOmBViMyvDt5Ww7q
         fKeVyBhaxY0QR9OyeYZWPm0Amenf6qJrdEOOgO/HPSA2FFV8jhQmIGTp/+Cpt1fPm+xI
         aqeVUgcZfGKPCG590kUKd6WnzVzOex3JU2XKzh6sQgPMbdf0QAAxesdmAm2mzzjic3TJ
         O+gaHFws4joIaAIcZZblJU1JFchd7FeewcQvukP+5PcVFOSUFXjH9GjzuqoqG4SoVMb9
         akMw==
X-Gm-Message-State: AOAM533mVSf//8nLzOK1UH4gWPXnohipT+f3RrG/VItKhpSY1bGqXbm3
        3yEnJeoMMIlGSgh7xZB+nQQxxmiozEZUhrIFkzyijA==
X-Google-Smtp-Source: ABdhPJwY/i8XN6e8gmUSkfA1TbxAFenjJXHN9V6MXMoBETbcAX6lJS39eMEIqjAbZmRLtQjX6BEaIjaAWAb4YPBsyRo=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr13187855lfh.2.1620053908634;
 Mon, 03 May 2021 07:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br>
 <eae6d3a1c16e440f18fd60d69b061d15ffbfe8e7.1619818517.git.matheus.bernardino@usp.br>
 <20210502075920.d2rdmuix7r34sas2@tb-raspi4>
In-Reply-To: <20210502075920.d2rdmuix7r34sas2@tb-raspi4>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 3 May 2021 11:58:17 -0300
Message-ID: <CAHd-oW46GR8cWHPq65QHHfrsN-9MN1xO301eADwLigwaLq7Y-w@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] parallel-checkout: add tests related to path collisions
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 2, 2021 at 4:59 AM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Fri, Apr 30, 2021 at 06:40:32PM -0300, Matheus Tavares wrote:
> >
> > diff --git a/t/t2081-parallel-checkout-collisions.sh b/t/t2081-parallel=
-checkout-collisions.sh
> > new file mode 100755
> > index 0000000000..f6fcfc0c1e
> > --- /dev/null
> > +++ b/t/t2081-parallel-checkout-collisions.sh
> > @@ -0,0 +1,162 @@
> > +#!/bin/sh
> > +
> > +test_description=3D"path collisions during parallel checkout
> > +
> > +Parallel checkout must detect path collisions to:
> > +
> > +1) Avoid racily writing to different paths that represent the same fil=
e on disk.
> > +2) Report the colliding entries on clone.
> > +
> > +The tests in this file exercise parallel checkout's collision detectio=
n code in
> > +both these mechanics.
> > +"
> > +
> > +. ./test-lib.sh
> > +. "$TEST_DIRECTORY/lib-parallel-checkout.sh"
>
> Why this $TEST_DIRECTORY ?
> Aren't all files under the t/ directory, where test-lib.sh is as well ?

Good point. From what I understand, the reason why we need the macro
here is that, when running the test with --root=3D<path>, the trash dir
might actually be at a path outside `t/`. So the test can't rely on
`./` to read files from `t/`. We don't need the macro for
`test-lib.sh` because the working dir is only changed after it is
sourced (by `test-lib.sh` itself).
