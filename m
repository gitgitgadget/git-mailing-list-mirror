Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22309C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjGZP7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjGZP6c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 11:58:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D6319A1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 08:58:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99342a599e9so1170471366b.3
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690387109; x=1690991909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CT8p+nMcMXaIPmgkVFIZf7e3/2UFkE3IU9SSZ6dcs8=;
        b=DdxzkfrMd/kXJEwG31BIjGnoPNggyq6NWu+rp+mZX99cqsPvGb4Xc0+sG++Qvdw4DE
         ltUKsUXRAddjr2fb6YMoCLZXgTHqsSPePf2nZei8Mrsw27+CQxett9ZE0q0aW55N/omb
         D70z+cUFH3JSD3Ao23V46iMZZzUj+PWGiX9eDIxe8fDNWZbY0AEGp+VQ+Ggy68iNVfsH
         WvZLaqpouJ5uTZledxaQJL7fXRsObZVdq0e++L37GpXBw/j+GV3/Q8ngX7CUC6QPcH3V
         iNLKeRMsgNZa+0klHgp64FOmHErcGG6R/XCk1VRMn8Zlm0JTlC+k9twdbU3+TeOJkdGG
         xOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387109; x=1690991909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CT8p+nMcMXaIPmgkVFIZf7e3/2UFkE3IU9SSZ6dcs8=;
        b=bb/HD9OZu4+1TJ7buvXoKhxb3gT0D/97mQRaVGuan1ScjZ/u1bf/ORl2EjkKXqOAmh
         LOkjxp3Nfm8QzryMYLcKJ4DS7ia+csOVSSuej5a3bueFzXrd2f7DS4c2q7R/gBIZyquH
         gPOnhKr3aJ+6HybAY8xNgVMvAMEd07YtE/IdAbtjNfs6V1Eh/gosY5ebXuBKdRzld1td
         7cCPAu5O8KS1nr9SeQskhjwdl8ICKWZi7bZjy7t1ncIJk/50rjtq2wbVKloA3n0LyTW/
         PyucU0/xUK7UCYLqiPukeakHd/LL5xz0OVZUVFZFSUp6zmSHavN17JO06CLvVNlr9T/A
         NVMg==
X-Gm-Message-State: ABy/qLayWfN7jgWmrl+zeI5jpbKQv/US3ZgqudXqb9XtBSLBjzFnHdwa
        SrU1NqPF4DtjdCPvzBBogayXSN6FoC0oBVQE4cA=
X-Google-Smtp-Source: APBJJlE50pB4tKpgu+1ziqXy999DhN6RZyk2kKeLWwfXuU/SBz8OeB91Bsldz9xyPcrJvIPR/IlVmFls1dVZYDVtVFQ=
X-Received: by 2002:a17:906:4d2:b0:997:c5c3:32cc with SMTP id
 g18-20020a17090604d200b00997c5c332ccmr2005381eja.66.1690387109381; Wed, 26
 Jul 2023 08:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqedl3a909.fsf@gitster.g> <20230724194854.3076-1-mirth.hickford@gmail.com>
 <xmqqzg3jltyr.fsf@gitster.g>
In-Reply-To: <xmqqzg3jltyr.fsf@gitster.g>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Wed, 26 Jul 2023 16:57:52 +0100
Message-ID: <CAGJzqsm0pV4SDmK+sN52q1RC5TyAXyxVf2KZSL=7CiJas_V=OQ@mail.gmail.com>
Subject: Re: Credential improvements need review
To:     Junio C Hamano <gitster@pobox.com>
Cc:     M Hickford <mirth.hickford@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Jul 2023 at 19:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> M Hickford <mirth.hickford@gmail.com> writes:
>
> >> * mh/credential-erase-improvements-more (2023-06-24) 2 commits
> >>  - credential/wincred: erase matching creds only
> >>  - credential/libsecret: erase matching creds only
> >>
> >>  Needs review.
> >>  source: <pull.1529.git.git.1687596777147.gitgitgadget@gmail.com>
> >
> > Hi. Is anyone able to help review these changes?
> >
> > https://lore.kernel.org/git/pull.1529.git.git.1687596777147.gitgitgadget@gmail.com/
> > https://lore.kernel.org/git/pull.1527.git.git.1687591293705.gitgitgadget@gmail.com/
>
> Thanks for pinging.  One thing that may help (both patches, my
> understanding is that they are of the same spirit, just one is for
> libsecret while the other one is for wincred) is to describe the
> problem the patches attempt to address a bit more.  For example,
> in one of them:
>
>     Fix test "helper ... does not erase a password distinct from input"
>     introduced in aeb21ce22e (credential: avoid erasing distinct password,
>     2023-06-13)
>
> we can read from the above proposed log message that it is a "fix"
> to some bug, and that the "bug" was introduced by the named commit,
> but there are a few things that it does not explain, that could have
> helped readers to convince themselves that the changes in the patches
> are addressing the right problems and solving them in the right
> way.  For example,
>
>  * how does the "bug" manifest itself in an observable way to the
>    end-users?  "When they do X, they expect Y to happen, but instead
>    Z happens, and doing Z breaks expectation of users expecting Y in
>    this (W) way."
>
>  * what was wrong in the code that led to the "bug"?  Was it testing
>    a wrong condition before making a call to some system service?
>    Was the condition it checked correct but it made a call in a
>    wrong way (and if so how)?
>
> Thanks.
>

Thanks for the suggestions. I'll send a patch v2 with an updated
commit message that tries to answer these questions.
