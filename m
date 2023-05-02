Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60122C77B7C
	for <git@archiver.kernel.org>; Tue,  2 May 2023 01:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjEBBHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBBHn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 21:07:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D711A
        for <git@vger.kernel.org>; Mon,  1 May 2023 18:07:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4eff4ea8e39so3763485e87.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989659; x=1685581659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmNK3BCBxsbi0w4t8VmsN7XNHy6iGTiVup5F/7uvBNY=;
        b=rCyU0kANriL/XfouU5OXcaTV5pVcBDH3tWfhDTQi8B5Y+Ut16CUrXzA3nfxQnB/Lgt
         064ichRMR9euHYw9MpPIsiTCrHjHz037pthgnURIvDrm6hdyrY74X9p5wmHALXFZkII+
         S+iKTZw0f6ZwBm5boGF6v35jDEeRy5oDeZzftJZ4U5Es14Ig+kSSTpysvS6z1yEIMl5V
         6+dHv3gtiELSWo3cw+5Dmt3TE1SpE8hilpNoNdb3wZcOhv10I5hkicTmM/EwDZndT7J3
         03ojD7CEET43MxToJla5uQZNt5hHo9QFGaZuctT8OwqGMc6e85GZnGFEQSjaZmaG96Uf
         Tmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989659; x=1685581659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmNK3BCBxsbi0w4t8VmsN7XNHy6iGTiVup5F/7uvBNY=;
        b=fLg5IOxswU0Z8DXeYoD8D3Th/RS27Qog1zGseTNECCQSebiOonzJprSDpygkP04vKI
         2v4w57kNzTwU1pDt76emfo8eQNT0bkaX6vG3P1S3Y5cW7c83qonTnU46ulftu9UjCMY5
         VGqSncyA8na37jmx+Tv4TlK1Y2mBCftLKxOO/Wpt7+mzg5k14v44ke8cRFqLnB97x0uV
         nl+arJlBxIFcoCqKLDd7IyspiTryn5aBkHz9ZNiw7n7GbU/WKH5N9ykiaht6MrBV9x+T
         OAWku+wJmiCVEgcPet8SiRnw+mdOLqyOrT7l35GuwR5uoKA/URHGHK9y6IiY4mcURqF+
         dHyA==
X-Gm-Message-State: AC+VfDxhPnprcOVrArlI9AnTYyKprQgkn5+2o5upkIRYoAWKn6mHuMlB
        cs30DAPe6kK2D+uVxAn10eI3r+VvCZNuO8y8LLc=
X-Google-Smtp-Source: ACHHUZ5SF98fC2r/jHadI9lcv3tKmT06xeO3p1JydcbSC2ULYUVgkDzoiMeNvs7DT9WcRBKPA4Wz5Ltuxq60KLPK7Cw=
X-Received: by 2002:ac2:5551:0:b0:4e9:8016:bfcc with SMTP id
 l17-20020ac25551000000b004e98016bfccmr3977463lfk.30.1682989658572; Mon, 01
 May 2023 18:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
 <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com>
In-Reply-To: <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 18:06:00 -0700
Message-ID: <CABPp-BEPy4R1R1X1o1oMs6sEECVjEoLeRXripEi7k8ZO-CrbuA@mail.gmail.com>
Subject: Re: [PATCH v2 12/22] tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define
 from cache.h
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2023 at 9:35=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
> On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
[...]
> > --- a/tree-diff.c
> > +++ b/tree-diff.c
> > @@ -6,6 +6,19 @@
> >  #include "diffcore.h"
> >  #include "tree.h"
> >
> > +/*
> > + * Some mode bits are also used internally for computations.
> > + *
> > + * They *must* not overlap with any valid modes, and they *must* not b=
e emitted
> > + * to outside world - i.e. appear on disk or network. In other words, =
it's just
> > + * temporary fields, which we internally use, but they have to stay in=
-house.
> > + *
> > + * ( such approach is valid, as standard S_IF* fits into 16 bits, and =
in Git
> > + *   codebase mode is `unsigned int` which is assumed to be at least 3=
2 bits )
> > + */
> > +
> > +#define S_DIFFTREE_IFXMIN_NEQ        0x80000000
> > +
> >  /*
> >   * internal mode marker, saying a tree entry !=3D entry of tp[imin]
> >   * (see ll_diff_tree_paths for what it means there)
>
> As it's only used in tree-diff.c, should this change not be instead
> changing how we define S_IFXMIN_NEQ itself, and combining the two
> comments seen here (the latter only partially, in the context).
>
> Not that this makes things worse or anything...

Hmm, that makes sense; I'll make the tweak.  Thanks for the suggestion.
