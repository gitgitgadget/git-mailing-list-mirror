Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF4DC433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 02:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiCLCCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 21:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLCCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 21:02:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D762A164C
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 18:01:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id yy13so22677007ejb.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 18:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDI9TfFEb52u+qPiipOEQ/HmXgI7TkvLU7/TUVtdcYo=;
        b=bpPrQ0OyedPopytcDcAGLAK2mxEROYgXC8BW3M5pPX8g6D94ufQVht95x+KXOV8Xd+
         5OSmi8qx/dBuEZ/ow7CoeDFibavj1l6AltTqniDfDBZsFQUYrAMuNZv408uw6XmlliXC
         gldVilkmsuqN1lwU4nd5u8mbdvRRUuDaZF8NKJUU5JC3bmM7wwKEdBrqrLJnhktk8ESI
         YnwWwzrWwu9t3KtWRSzhqkvmn8wkgBMsy4Rfn7+BZXsjq4BSPZ5RCNJ9BDWjmhLoe5YM
         irK75J/ASEnKfvIXDU6f+RoSbMizQSAhayJkMDwm9Y78XT13xoWFpy63YJ2Lt2e4RSYG
         kDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDI9TfFEb52u+qPiipOEQ/HmXgI7TkvLU7/TUVtdcYo=;
        b=NrwrBLKnnr9BEAYFhKLyo+jSpxOExOFPXl/6UHsPt5o/TzG1u4yzgJjmf1RUAm2hrD
         01+HKQh0982JYDsgp6GO8a/U4QZt4cNw198Pev215wnh9uNlmCDPI8x9mHW3VgLHyHoV
         Gb7KWJ35w5dpI8qNDiFqa0oRV/WQ6xcgC809vfY5H+Hc7GOz68f8eavhHOokTOQjRMi2
         WFbKLTi1AWY/eoJkAPtCYE4YlHHKxqjunuqbhpUmVftiUmUFQN7Jv0EvcQmmQ8smTU6Q
         ydJ0WwWCnT+p/ZhmT1kVXGxVjKsmgLv0Rq1f+Gf2dqipJM9sDqxtOvqCAkFz5FNfjVBq
         l/6A==
X-Gm-Message-State: AOAM531KGdCNI2c3znmdptPHEEiDQooiuUv7NFDiMpLXuGu39WoHc1GX
        hQP3vFPaV1D3VzTzT8SKrEAD5uBBR+lS7wpKKcFQtgo7oqI=
X-Google-Smtp-Source: ABdhPJxWG7k28GMCK7ou1aXtFvB+E+c+jyUjVs05zTvi+LwiJOEj0qbKkJHMcKtAl5J6iI5SqjV48Hy9JXJTfrSoTAk=
X-Received: by 2002:a17:906:f24d:b0:6da:a270:fcee with SMTP id
 gy13-20020a170906f24d00b006daa270fceemr10754159ejb.476.1647050509094; Fri, 11
 Mar 2022 18:01:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <b174b42ed82a45f57959a2a493dcfb32bf26c12d.1646725188.git.gitgitgadget@gmail.com>
 <cbbf31e0-14fb-07fa-db12-aecbbeb1e592@github.com>
In-Reply-To: <cbbf31e0-14fb-07fa-db12-aecbbeb1e592@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Mar 2022 18:01:37 -0800
Message-ID: <CABPp-BHeYA1jErw7rm2fk6CE9W-meskX2xkTiAei-kCazyjLdQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] sparse-checkout: make --cone the default
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 6:26 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 3/8/2022 2:39 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Make cone mode the default, and update the documentation accordingly.
>
> Doc changes look good.
>
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -397,7 +397,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
> >
> >       /* Set cone/non-cone mode appropriately */
> >       core_apply_sparse_checkout = 1;
> > -     if (*cone_mode == 1) {
> > +     if (*cone_mode == 1 || *cone_mode == -1) {
>
> Part of me likes the fact that you're pointing out "if it is
> enabled directly or not set at all", but maybe it would be
> best to do
>
>         if (*cone_mode) {
>
> What do you think?

How about if I switch it, but add a comment since the special "unset"
value of -1 may not be clear:

    if (*cone_mode) { /* also handles "not specified" (value of -1) */
