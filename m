Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FDDC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 12:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiITMoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiITMn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 08:43:58 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FB675CC7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:43:52 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id e205so2122411iof.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=yszDKYzkVKBv3nUlpzaxHxBYMeWfWSoICKA+/2kR5xQ=;
        b=JFQKT8NfSOzc2KgSAow3QcDUgw08aQO7xcOuDsJ4lYXh356Z0wAkcy/8e1ADFwDMii
         3vpSw7/d81O9frDd4HUpeUXISMhGg4cziumk8aD3DAIOwOah1i61F+TWlxKe5ldOqodZ
         SLwmj2zdY0k1rJhbZrnKHqoEpqMIm2td5XzhGdjb5aBb4vLQNVUkvdHMXWCdc/YOfVeu
         sPMyOgeY+DC/e++7EABmVTuKDblV8xW5e5WzOxFcNWo+MhDz8ee+kN8S78PjIR5o3R2L
         tBdGJ1weMwVC9Ryy1j0Y6HA+t/znU+FHyH7wyGLHczgqH7kAOTM9iExyrqLXWgKreji0
         cNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yszDKYzkVKBv3nUlpzaxHxBYMeWfWSoICKA+/2kR5xQ=;
        b=wNh5415LRV2pNB+VdE9sxDnGQNo+96e3u+2DYthyd6CB9ZcLY6aPdvhcO8Wk665Q3t
         8c++C6nWqpFDUYRLDmOmWqWSfcDn/Z60rb086r7ynbGZ3MfS1LQm3ahgOp183CnvFqGi
         x4eLqEjxJATOiXPF/uBjRRcFCJExCgvETtjT63dasjXMITXPHDBLT05gRpQWLqN3Xm4M
         fuorqEZggEpOtjiZH6gFS5e/iKB51rWwoIBxRZSjKY58h2E/3hR4mMQDzgcCUoqGJAr7
         RAP16XMesW5uYw6iC5NXFht+DXp24KgC0+LoyBznwpgKKW+mLm9BK4SmDNvs9P7Vl2+O
         Pufw==
X-Gm-Message-State: ACrzQf27ZY4WcTQnLGnwvKFzYPBYQfs8PbgVc04YnDWvwLLxSS28gbGH
        475NEN8llwIvtF+2xxrYwCgLHY3+4Lgh/wS7H34=
X-Google-Smtp-Source: AMsMyM6rNqt1HZTMG1dYkkIFtSt8K2kXNXTKte2kj+a2nE31IrDyM/jL17zpFlukAz3wqoh84I+npEG9XOOPEr4axBs=
X-Received: by 2002:a05:6638:2392:b0:35a:6ba9:7424 with SMTP id
 q18-20020a056638239200b0035a6ba97424mr10165334jat.93.1663677831655; Tue, 20
 Sep 2022 05:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1355.git.1663420281187.gitgitgadget@gmail.com> <433bf552-db20-9989-92c5-ee625ce9337a@github.com>
In-Reply-To: <433bf552-db20-9989-92c5-ee625ce9337a@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 20 Sep 2022 20:43:40 +0800
Message-ID: <CAOLTT8Rxh7dVJL6gGe1KPnTNOgPdQky06deOe0L5qczE0eh64g@mail.gmail.com>
Subject: Re: [PATCH] scalar: fix wrong shell hashbang
To:     Victoria Dye <vdye@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=B8=80 04:08=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > $SHELL_PATH_SQ haven't been set in scalar's Makefile,
> > bin-wrappers/scalar will begin with wrong hashbang "#!",
> > fix it by setting $SHELL_PATH and $SHELL_PATH_SQ in
> > scalar's Makefile.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     scalar: fix wrong shell hashbang
> >
> >     The bin-wrappers/scalar seems like missing setting $SHELL_PATH_SQ w=
hich
> >     lead to I can't execute bin-wrappers/scalar correctly, which output
> >     error:
> >
> >     zsh: exec format error: scalar
> >
> >     (this bug will not turn out in bash)
> >
> >     The bin-wrappers/scalar begin with wrong hashbang "#!", which canno=
t
> >     figure out by zsh. So this patch want to fix this problem.
> >
> >     v1: Setting $SHELL_PATH and $SHELL_PATH_SQ in scalar/Makefile.
> >
>
> Thanks for finding this! However, while your patch fixes the error you've
> identified (I was able to recreate both the original issue and apply your
> patch to fix it), I believe it has already been fixed in 'next' by
> 7b5c93c6c6 (scalar: include in standard Git build & installation,
> 2022-09-02) (archive: [1]).
>
> [1] https://lore.kernel.org/git/bc2092a7a7aae640b547bde8db0c0a26ce31278a.=
1662134210.git.gitgitgadget@gmail.com/

It seems that this problem has been solved, thanks!

--
ZheNing Hu
