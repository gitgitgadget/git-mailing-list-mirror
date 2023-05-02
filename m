Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07497C77B7C
	for <git@archiver.kernel.org>; Tue,  2 May 2023 01:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjEBBoh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 21:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBBof (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 21:44:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB81BC7
        for <git@vger.kernel.org>; Mon,  1 May 2023 18:44:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8db10a5d4so31279411fa.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682991873; x=1685583873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nADrXfVUPxBW2gvyEdHT08KNokTHd3GFL+1G8pHwX2o=;
        b=N1762fvyKHTxBnMsZ75umCu330863QbBp2Z/KkN371kpI4AkGJIXvPoL3DYDtR/ewJ
         NEffvLNtTv7aLoKoEMU2P5/nr1NAYLH5jvipr0cmIEPhhczTDrQVocwvvCUGoD1T2+w8
         RSP4USe16MpPpbik5kEtCWYU6gCrIab+ozyUjkg89jEvyeWNAluoNFuKfuwBzZIM3Y4z
         ZN8g7yaQtKAT1KSw93zIbzr+Z/DmYAKqjmF3j8CFnjrrrdB/yvrDdV1EHKegD+6/i4Xi
         kMikiDRZ9FC2kvxCZDqS6ftqLB0jubvtgK700KQAmK0HuDwjO0C7wD/DPGTmpCf4MwnS
         d/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682991873; x=1685583873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nADrXfVUPxBW2gvyEdHT08KNokTHd3GFL+1G8pHwX2o=;
        b=HWuoH6Xau8KhYZ49hCPnCyBfDOMOP2I8oX4EdVl9Szcc1GQtJD1E7xqpaxBmhWpB4r
         n8h+Va2Ro03jSNlP5TZ6PS1neQapc/vI3MnanfbXa9LFBf3boyOgjb7ycbUeOwKi6E0x
         5TWbhhzYzeKa3cPuy5uxhOCRhmYyD+wHf92Cn82Zqew8AWn7RDdW3RXCjOJHXBJcOijE
         bxa6J+tzCdmx4k2ZDiM/BDodLkz9fJBCDd8+jZAQR1mcdaUMhBSvx4IhiYOFVwpJwHr5
         vGpJnSe11aSeBPmaF9Q4zk9m4WGs0Q4t0Op3LtZwwo+Oew6mdRX8ZgaXpZ+qDiGR/BF7
         uEqQ==
X-Gm-Message-State: AC+VfDxWq9ZGKAo76kbQyCJ+u4je/snnotH2GCm4kVe9j+k0uj2alFQv
        uUiTn1l2TEcbQMiNFUB3igxeWknjk85KDYzbYzQ=
X-Google-Smtp-Source: ACHHUZ6F4yFgDwfMYaquwsWhnkdAbWKo4K1FP2yUrkf0b9AkOF6u9D68IB9fMdU+T45RoNJao8zebflp4NY0aWG2UdQ=
X-Received: by 2002:a2e:99c3:0:b0:2a7:6f82:4a87 with SMTP id
 l3-20020a2e99c3000000b002a76f824a87mr4087087ljj.35.1682991872611; Mon, 01 May
 2023 18:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <b459b60de89750d0226c7c4f1c7c28de249b475b.1682194652.git.gitgitgadget@gmail.com>
 <230501.86r0s0hu7a.gmgdl@evledraar.gmail.com>
In-Reply-To: <230501.86r0s0hu7a.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 18:43:00 -0700
Message-ID: <CABPp-BEjYwVKVXzjmC00rFtiXOPCz6QihCS+RfR_BB8wbFJdZQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/22] cache.h: remove unnecessary headers
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

On Mon, May 1, 2023 at 9:50=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
> On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  cache.h                              | 2 --
> >  compat/fsmonitor/fsm-ipc-darwin.c    | 1 +
> >  compat/fsmonitor/fsm-listen-darwin.c | 1 +
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/cache.h b/cache.h
> > index 591c67b0595..bdedb87e83b 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -4,8 +4,6 @@
> >  #include "git-compat-util.h"
> >  #include "strbuf.h"
> >  #include "hashmap.h"
> > -#include "gettext.h"
> > -#include "string-list.h"
> >  #include "pathspec.h"
> >  #include "object.h"
> >  #include "statinfo.h"
> > diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-i=
pc-darwin.c
> > index e62f093cc19..bc68dca0cae 100644
> > --- a/compat/fsmonitor/fsm-ipc-darwin.c
> > +++ b/compat/fsmonitor/fsm-ipc-darwin.c
> > @@ -1,5 +1,6 @@
> >  #include "cache.h"
> >  #include "config.h"
> > +#include "gettext.h"
> >  #include "hex.h"
> >  #include "repository.h"
> >  #include "strbuf.h"
> > diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fs=
m-listen-darwin.c
> > index 5eb6402ab82..18c0e3913dc 100644
> > --- a/compat/fsmonitor/fsm-listen-darwin.c
> > +++ b/compat/fsmonitor/fsm-listen-darwin.c
> > @@ -29,6 +29,7 @@
> >  #include "fsmonitor--daemon.h"
> >  #include "fsmonitor-path-utils.h"
> >  #include "gettext.h"
> > +#include "string-list.h"
> >
> >  struct fsm_listen_data
> >  {
>
> If I rebase this topic to make this the first commit everything
> compiles, i.e. nothing here relies on what came before.
>
> Given the extensive earlier moves I think it would be better to first
> remove unnecessary includes from cache.h, before starting to split it
> up.

Interesting.  I originally had this patch earlier as you proposed, but
in writing the cover letter found it made it simpler to explain the
high level overview by moving it.  It's really nice to be able to say,
"this series continues to focus on splitting declarations from cache.h
to separate headers...and then makes other cleanups I found while
doing that", which naturally suggested the opposite ordering from what
I originally had.
