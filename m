Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EC1C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiBJWc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:32:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiBJWc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:32:56 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0E010AA
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:32:56 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so8237004oov.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=We8UXtJ7NiAy647/w51fIZU4m3nOLlChvmZbpdRdB30=;
        b=FAMrGDiJUVDy8w+zgffPG6Jy9vyM0lPWGVuTYxic4rGM8Jo3Oo0ahPHachedGaqZWD
         fZoOHd7eJ2WixNNHE9Ko/gPb67EHhdRsdg+gX+rIUt//Q5l0BBrXl/ZGnaJdCAtopVJ8
         +o/nRSSv2058ZKDA6282WsSAW6jt6k7yOd0TsqutdpedObOab1uR58YwoEdMOtV8KJOC
         Y+LfKTGUn33MxLpZBng5e5fUt2LmIVOXL7yDDvI9ABQbzvO5eh4rLhfmgdPexjILCweN
         nVcdcZIIQrUQCJrA6MWsi8iNfx3Csonnva07HBZfH5hwntnZV9gStGq4zEPXfyRzVYvM
         pTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=We8UXtJ7NiAy647/w51fIZU4m3nOLlChvmZbpdRdB30=;
        b=jOMo/vvWCAxm4p++abj7WSkiwtgHhLsNf1QMzAUmuZrCdIybyIpYSILB+/iuOUQBbq
         sIdxTzC5LrCExL0U3uscKsep/TWeuFucIQYVTnaHjZGMc/4yfAEkYUWXFpaZRX79CW1I
         sdwrFYl7xbuqjf4v9QuSsLW2ksYwEtum5r63D/ds+e/KX/LaLt5GZ8qm+LLUDQbNhh0P
         KoPLvbJNDJjBiEfzE7NTF+mbiflhtBnqUNTYwzBvm2Z8X3eeqsK3MBBtd9YDH3xuihz+
         Ig5Tt2K6TmyWKwpBvWxzGEa7rIdHIsgtTisiKsQYU1ru+Nyjwka6IohcMFVCYmd8EpnP
         JFrw==
X-Gm-Message-State: AOAM5304Abd9W/L77Lw2Rakc7iodtm/dBcoDilX2gLpcABICrxh0/Uuk
        LdfUOmtzW/FFtSla4XvZhAu9VIGXa5A4wUy9fVMqs8lsPlo=
X-Google-Smtp-Source: ABdhPJw9NdQTrJGyGwB/Wu0J8uuYKsqY7oMwAONaSQ4CfmyYsSicZ+KLtdS7EoaRIl7V5A7w4EpgWlEb+mzDEw5UeGA=
X-Received: by 2002:a05:6870:13cc:: with SMTP id 12mr381138oat.56.1644532376072;
 Thu, 10 Feb 2022 14:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20220208231911.725273-1-calvinwan@google.com> <20220208235631.732466-1-calvinwan@google.com>
 <e21c4f77-061c-d125-97cb-1a8cb7692e56@iee.email>
In-Reply-To: <e21c4f77-061c-d125-97cb-1a8cb7692e56@iee.email>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 10 Feb 2022 14:32:45 -0800
Message-ID: <CAFySSZAAq4Q-BXeKHBozcX1byxhma6oKT0JnvOScYJkQ0fFi0w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2=5D_fetch_=E2=80=94object=2Dinfo=2Dformat=3A_client_o?=
        =?UTF-8?Q?ption_for_object=2Dinfo?=
To:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes it does, thank you!


On Wed, Feb 9, 2022 at 4:48 AM Philip Oakley <philipoakley@iee.email> wrote=
:
>
> On 08/02/2022 23:56, Calvin Wan wrote:
> > Add =E2=80=98=E2=80=94object-info-format=E2=80=99 option to fetch. This=
 option allows
> > the client to make an object-info [1] command request to a server
> > that supports protocol v2.
> >
> > The transport implementation uses vtables [2], similar to how Git
> > fetches refs, to determine whether a process needs to be taken over
> > before sending the object-info request. Different protocols
> > require different setups for making requests.
> >
> > [1] https://lore.kernel.org/git/20210420233830.2181153-1-bga@google.com=
/
> > [2] https://lore.kernel.org/git/26f276956001a120cc9105b0071762c2fd4a45c=
5.15=3D
> > 13287544.git.jonathantanmy@google.com/
> >
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> >
> > ---
> > Please ignore the patch above. It was sent with a stale patch message.
> >  builtin/fetch.c              | 26 ++++++++++++
> >  fetch-pack.c                 | 53 +++++++++++++++++++++++
> >  fetch-pack.h                 |  7 ++++
> >  t/t5583-fetch-object-info.sh | 81 ++++++++++++++++++++++++++++++++++++
> >  transport-helper.c           | 12 ++++++
> >  transport-internal.h         |  1 +
> >  transport.c                  | 59 ++++++++++++++++++++++++++
> >  transport.h                  |  1 +
> >  8 files changed, 240 insertions(+)
> >  create mode 100755 t/t5583-fetch-object-info.sh
> >
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 5f06b21f8e..b48d9e93d0 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -29,6 +29,9 @@
> >  #include "commit-graph.h"
> >  #include "shallow.h"
> >  #include "worktree.h"
> > +#include "protocol.h"
> > +#include "pkt-line.h"
> > +#include "connect.h"
> >
> >  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
> >
> > @@ -37,6 +40,7 @@ static const char * const builtin_fetch_usage[] =3D {
> >       N_("git fetch [<options>] <group>"),
> >       N_("git fetch --multiple [<options>] [(<repository> | <group>)...=
]"),
> >       N_("git fetch --all [<options>]"),
> > +     N_("git fetch --object-info-format=3D[<arguments>] <remote> [<obj=
ect-ids>]"),
> >       NULL
> >  };
>
> Doesn't this also need a matching Documentarian update for the option?
> --
> Philip
