Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E315C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 22:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiCUXAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiCUW7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 18:59:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2A36BA11
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:46:42 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a17so18603053edm.9
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 15:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2vS48Ma8BAIQC2ntWbne40U6C1Pa5FFdsklf4N64aAM=;
        b=GFsj0oXWR5RuJQ8qG9SuF8Rs635iLTWy+Z3WNsvYZp0MAPPtwfLB5VdcOI/aXvlwPp
         5TQ6tEAzG65UELfqaag+nFZPyzCjTB5PYrj4lSspsl3/T5u7UrSa2tXz20CellJg6gJO
         JINtGzjF/8XCKYS3a1QCAUJ6ey2bTU/cbU7T+O7Uuqo3BvDfTNbJwIcft7m97xbUMoHS
         /dVlFHVtOBgaHayTS18I+ggrkNVByxpZVLj5PQYLuwHWcbb6JIv+vaDRdCpPZtLVTIr+
         zeW26wFD5p02lNG0PTmcH7N39fkMmoju8BRhqFXXttvP7gzd3qszCTwAinuUTOIn7kYa
         5hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2vS48Ma8BAIQC2ntWbne40U6C1Pa5FFdsklf4N64aAM=;
        b=nDQ+DY5BOpXf8uv0QQ50e0b4eMTLgvDgubYUBAMtls/IkrLoWheZ1P6RbCYmUCiuLC
         js9mCnAmDEfv6xVAufD+OxC5TFijvLJw6ww7aSulg3B9V7OcxR1rYy7km82xQhVwtf6Z
         42BpbBBz/XR0CFDuGe2NKN+x+Ccb0bNajFPej3lb9CAoElEqJ4NlbfXLm/3YUzcEmZxo
         f5GyfJRtliR5Oc0yszvTe7wx0qmvL6j1jbfP8mRLBbWyUilelK8h1LnT7oBwu/QC1xwi
         KXMfVB+k46UyXVCkI59DbAmSZ6GqpDyo+qj0y63SLayhrlRl6F5QDVEhWkvwwytg4366
         ko4Q==
X-Gm-Message-State: AOAM5300M5NnxsSuuRhux7d5H/LqvYj/YqbcfnYVucsULC2B2tDvJweO
        6DeAgf1LOwcUR7ewcaIFEZgulcYg+5MDHs+GyQyPUsaRUiA=
X-Google-Smtp-Source: ABdhPJwwO0UoNtd1fhDGLHSyCdkBQkr8MFvpvFjrJd7CdFec+3F4jRekWv+G5XDDB0bIUZdRfPfqGDmuqwTrdSemqNY=
X-Received: by 2002:a2e:9b96:0:b0:249:8705:8f50 with SMTP id
 z22-20020a2e9b96000000b0024987058f50mr4263333lji.73.1647900577230; Mon, 21
 Mar 2022 15:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com> <54797dbc52060b7fa913642cd5266f7e159a5bc9.1647760561.git.gitgitgadget@gmail.com>
 <220321.865yo79wkf.gmgdl@evledraar.gmail.com>
In-Reply-To: <220321.865yo79wkf.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Mon, 21 Mar 2022 15:09:25 -0700
Message-ID: <CANQDOdeox=Wox94SW+oUgbLDdLZ+KOdw6AWdBzwFkR18xmaNtQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] update-index: use the bulk-checkin infrastructure
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 21, 2022 at 8:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Sun, Mar 20 2022, Neeraj Singh via GitGitGadget wrote:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > The update-index functionality is used internally by 'git stash push' t=
o
> > setup the internal stashed commit.
> >
> > This change enables bulk-checkin for update-index infrastructure to
> > speed up adding new objects to the object database by leveraging the
> > batch fsync functionality.
> >
> > There is some risk with this change, since under batch fsync, the objec=
t
> > files will be in a tmp-objdir until update-index is complete.  This
> > usage is unlikely, since any tool invoking update-index and expecting t=
o
> > see objects would have to synchronize with the update-index process
> > after passing it a file path.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  builtin/update-index.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/builtin/update-index.c b/builtin/update-index.c
> > index 75d646377cc..38e9d7e88cb 100644
> > --- a/builtin/update-index.c
> > +++ b/builtin/update-index.c
> > @@ -5,6 +5,7 @@
> >   */
> >  #define USE_THE_INDEX_COMPATIBILITY_MACROS
> >  #include "cache.h"
> > +#include "bulk-checkin.h"
> >  #include "config.h"
> >  #include "lockfile.h"
> >  #include "quote.h"
> > @@ -1110,6 +1111,9 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
> >
> >       the_index.updated_skipworktree =3D 1;
> >
> > +     /* we might be adding many objects to the object database */
> > +     plug_bulk_checkin();
> > +
>
> Shouldn't this be after parse_options_start()?

Does it make a difference?  Especially if we do the object dir creation laz=
ily?
