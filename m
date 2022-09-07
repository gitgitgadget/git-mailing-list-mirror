Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8AC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 15:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIGP5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIGP5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 11:57:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1A897ECF
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 08:57:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso9797735wmr.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=3Zh4Ps1Xn44Mo2EgWfojpHD6GwioPiuk32qKGLPi0+4=;
        b=blg9Hd09mipuF3m8lHsIdmYHWgIWX8QyAYYgxGuENagOy/8/xSugkYz4SE8f+JBG6Y
         aHjeVzFeSQr1Qy/XrWVkTqW9pai+V8xQ6GO4zHXGfJj0fIi2Q/DZVAHsQym81lG6OioP
         Jj1rAC9CTOMKpA4xpzYnBdmCjgRf0Miytud1/BYRd9nQDic2cfsqyKn+XuzIwcb1HsBR
         t22udMvB4e5YTDNIHuHb0iKv4e8iUMk8cO0aduYFYgaUKJlhiAg/YScnPUhSLc3vpL+c
         dxoApt7gIl5tkKox9gM6JUJVvapCwxlcUJM6CNTGHXJ5i4uvrkKGDYGEyAKiUqm3eRsF
         INqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3Zh4Ps1Xn44Mo2EgWfojpHD6GwioPiuk32qKGLPi0+4=;
        b=tJFHPJI7lbkVCJwUWm3PfmwTd+Yf2Xzo3MlTL8f9ZwOo9XuPqdeIKcKnAVgD68EHvQ
         4n4WJND0Z2rq8JsZrNl/CQlpXNLWJvk6V4Zxbj/b2rBMTbbU2xoi2AYktKph8ldrPvVJ
         R64VCzdq9yW/MctdDd+Xvm6rEzYj4KljcaebLJ0yF5SXL0saGb4Ho5IkrR11K+mE/55J
         swOpogD+3Ik3hbS+PJuy8HewazrjYW6CG5+zsKsh5/v16L4j2tHRmHE5czvPCBdBoAFb
         ViT+Kl5qlDrINg+uaqsp6W4Z8H5C8uMs1Z5Kdsiza7OwhMgQ5GysVYN4V1LLxfLMVOuY
         QJng==
X-Gm-Message-State: ACgBeo3lLcc/k3ndT6MW5+byMOr+IO+MdX8fzNa0BBD65WZlOFytpD8K
        n+fsroD4Vct0HrCxsLg06y996rHgNTFbNmcmI1B90QPdMOg=
X-Google-Smtp-Source: AA6agR5+zG/KEYnTiJFJ9jbadg9hdc6aNuCuPjSfYW/2DQ/s2f3PYFE5t2gvm+W0uT60FgSuEh1naYGAdqzDQWmREDo=
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr17502509wml.51.1662566223426;
 Wed, 07 Sep 2022 08:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <YxKo2l5nBoOa9Jfa@coredump.intra.peff.net> <CA+4x=b-GYMnZygHXOfNb3CdSRoxUeT80n=gSCLyfCA9WsB0wEw@mail.gmail.com>
 <Yxf9yETBi3k6Wasl@danh.dev>
In-Reply-To: <Yxf9yETBi3k6Wasl@danh.dev>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Wed, 7 Sep 2022 11:56:27 -0400
Message-ID: <CA+4x=b9M+HRWdDx-Mr4q0NiRQESwJ5uEkOBL_nVPPPHhXs7i_g@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I was confused by the "0 left".  With one more besect it says

9f489ac6bbb755fa4c83289e44cad12f3b765d69 is the first bad commit

That appears to be
 [9f489ac6bbb755fa4c83289e44cad12f3b765d69] Merge branch 'dl/zero-oid-in-ho=
oks'

.. Lana (lana.deere@gmail.com)

On Tue, Sep 6, 2022 at 10:11 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2022-09-06 15:37:45-0400, Lana Deere <lana.deere@gmail.com> wrote:
> > This is the final output from git bisect:
> >
> > $ git bisect good
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [d8d3d632f4165955da49032d50279c20cfbde2e5] hooks--update.sample: use
> > hash-agnostic zero OID
> >
> > Does that offer any hint about what is going on?
>
> It is still bisecting, can you continue to bisect until it says
> something like:
>
>         first bad commit is ...
>
>
> >
> > Incidentally, some but not all of the pulls produced additional
> > output.  Maybe it's a clue?
> >
> > $ ~/tmp/git/install/bin/git pull
> > warning: Pulling without specifying how to reconcile divergent branches=
 is
> > discouraged. You can squelch this message by running one of the followi=
ng
> > commands sometime before your next pull:
> >
> >   git config pull.rebase false  # merge (the default strategy)
> >   git config pull.rebase true   # rebase
> >   git config pull.ff only       # fast-forward only
> >
> > You can replace "git config" with "git config --global" to set a defaul=
t
> > preference for all repositories. You can also pass --rebase, --no-rebas=
e,
> > or --ff-only on the command line to override the configured default per
> > invocation.
>
> This is a hint in some version of git for 2 modes of pull, you can
> ignore it.
>
> --
> Danh
