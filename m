Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE50C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 05:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjEBFAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 01:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEBFAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 01:00:30 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28230CF
        for <git@vger.kernel.org>; Mon,  1 May 2023 22:00:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8a59daec5so30819751fa.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 22:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683003626; x=1685595626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abQkyGsAOLAeO+Q8reMR8cUGg8KdRZ8sBw/5mIIgCN8=;
        b=F+LRA9EENAccDR9JgB2w4cL5P+3tfFpDLX8UAhct4CSvfHnEe+AzpQTXhkRBzG8V5y
         hfbTklYOOeXSod6zNlgiW1ReJxy5jzP4et9NU0cY4whb1NPQVopUJVjAAxxxWOgq/mqk
         inZbhhCj/o1Cbj/hNocea42ACzQLEAU4iquJMSq0iEKy1OOA2IeZxokIlkOEO0N4xMQL
         cyOQwLlkmgu7WoeqLkVYHPZLfLwZ2+TG9ejwV7RBkEQrPc75idmOTV1oLL8SFX/urVif
         4N1E5Oa6maeFHeTvqRM36I1Hf8685vXNFLs9e4O+MXYpfFTuZM8iv1oLM6AjAlf1G1Xi
         hVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683003626; x=1685595626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abQkyGsAOLAeO+Q8reMR8cUGg8KdRZ8sBw/5mIIgCN8=;
        b=RNpT0wOeysVeMviFwwtOJeMNJzLSV8bnE2hjkj0tDPk+8jkZTi0S0kDBPBMCuLTPLM
         ncHJqq+Nww4SWAJ3KYz+x/sZp2MemXjnHnig8yM3udpKMOgXKYXvkNTTwYXSjHQk+95X
         uPvr/G1bf2M36ni6lZIfHHwClit6IZjHJJS5esF37np2j3INP73CW9k9qIu74VZIhS8B
         Fmz1PczCVsBYebwpQ+eUezdniifQcSG7Tf6RgtwFxMy9Qt7tFEU9InFzkc+SH/QfjYw4
         qF+eOPqux4xjwCNayI8FSV0y6mAGIXL8vWUORUhZh5rjpIYX55x+89XmGBoWtiLs2WrW
         cJ7Q==
X-Gm-Message-State: AC+VfDxzZunFVjLDw3pyeVotZK3Wb34C8xg+8LiXM2YwUC9YzBwctc4p
        aPUMkQE6D4s8EUDhICUZwy0S+ssM8V94Kmc3Blg=
X-Google-Smtp-Source: ACHHUZ7SvRUT0ssgRJA9oAFtiGmUInDfXuzgJnqQvJ4LS/EXTKMvOaw5eviN2FQFwjeNKUxrvnj/eKL0Val8k1YIRqc=
X-Received: by 2002:ac2:5147:0:b0:4f1:26da:54ab with SMTP id
 q7-20020ac25147000000b004f126da54abmr457891lfd.51.1683003626467; Mon, 01 May
 2023 22:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <7b55f82e62ecf761b804432c8d08dffabbb7605f.1682194651.git.gitgitgadget@gmail.com>
 <230501.86zg6ohuw7.gmgdl@evledraar.gmail.com> <CABPp-BEPy4R1R1X1o1oMs6sEECVjEoLeRXripEi7k8ZO-CrbuA@mail.gmail.com>
In-Reply-To: <CABPp-BEPy4R1R1X1o1oMs6sEECVjEoLeRXripEi7k8ZO-CrbuA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 22:00:14 -0700
Message-ID: <CABPp-BHymt9COEjnTRTbg_vHa4s6-CL7Bh+9q0PfoiE0SRcRrg@mail.gmail.com>
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

On Mon, May 1, 2023 at 6:06=E2=80=AFPM Elijah Newren <newren@gmail.com> wro=
te:
>
> On Mon, May 1, 2023 at 9:35=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason <avarab@gmail.com> wrote:
> >
> > On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
> [...]
> > > --- a/tree-diff.c
> > > +++ b/tree-diff.c
> > > @@ -6,6 +6,19 @@
> > >  #include "diffcore.h"
> > >  #include "tree.h"
> > >
> > > +/*
> > > + * Some mode bits are also used internally for computations.
> > > + *
> > > + * They *must* not overlap with any valid modes, and they *must* not=
 be emitted
> > > + * to outside world - i.e. appear on disk or network. In other words=
, it's just
> > > + * temporary fields, which we internally use, but they have to stay =
in-house.
> > > + *
> > > + * ( such approach is valid, as standard S_IF* fits into 16 bits, an=
d in Git
> > > + *   codebase mode is `unsigned int` which is assumed to be at least=
 32 bits )
> > > + */
> > > +
> > > +#define S_DIFFTREE_IFXMIN_NEQ        0x80000000
> > > +
> > >  /*
> > >   * internal mode marker, saying a tree entry !=3D entry of tp[imin]
> > >   * (see ll_diff_tree_paths for what it means there)
> >
> > As it's only used in tree-diff.c, should this change not be instead
> > changing how we define S_IFXMIN_NEQ itself, and combining the two
> > comments seen here (the latter only partially, in the context).
> >
> > Not that this makes things worse or anything...
>
> Hmm, that makes sense; I'll make the tweak.  Thanks for the suggestion.

Although maybe I'll have to do it in a follow-on series?  Junio merged
the series to next today, so...I guess I'll just add it to my "header
cleanups" notes.
