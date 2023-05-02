Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB81C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 02:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjEBC2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 22:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBC2f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 22:28:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E778B3AA6
        for <git@vger.kernel.org>; Mon,  1 May 2023 19:28:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8b62cfaceso31784181fa.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 19:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682994512; x=1685586512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L34jfi+ERCu5Z/QQE86WLqwv3OsbIuADKzY6tbVCoGo=;
        b=lkaeT4fphKq79lBdLAhY4rlZPd93m2rP4dXXCrzK6quZ57eFd9COpqhoY5t76EhSeM
         /Y2EZy7aEKKoRjXufG9wBPL7TUlVGTAzXYxps0rl1Ss8LGCEHJe38RQmZAP7ftRamniy
         c+VR37vtG9nNxrqZTfES4hS3bYda6tF1wLLrgyjDDPd0XhxsnlBe16ZoE8B1a4IXFiIc
         TF8tDxFHuWnETkTJ7hTKmwl1hLpTJCdz+W70g6m8KzngqxR2g5ibqrzUmU0RvyThiVIz
         6ZLaNw2+SF/8OJK1rVW4Pp7qiI0LfzAWjOYWKWxLSFxgmz5/gyDI3XIqgvhks1QHLOuk
         upXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682994512; x=1685586512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L34jfi+ERCu5Z/QQE86WLqwv3OsbIuADKzY6tbVCoGo=;
        b=G8k3QqyFF01G6ib0Kn9GbmdukvLV/RIP+55gtTa6MIC+SGx56kJjt4UU0TslCpH7JG
         bFrU1thDsPNdVUNlt7YlifoiN9Opf6kmKSzPcexmKUCr4FtATKP8F8vSP4vCmEHb5e6v
         ZxRoB+kajkceEi3OCidGxBAshegelNK3a2T/mYW4mXEcqF4dT8KTrXc4bL0VhjwsO3ZK
         XmNjtNTsi0ZQQu1iHyCWfzdrNjf7xnR6jO8gZrwa+LTXSEYOrXQL3qyRkpEYCqFQ7pXc
         DsgShuwcYDBBuNAlhezMs3rJWaz96XYzKDu6vMIDOQzQrQgX6cdtE9kxtXGNsLV+TnMb
         f/JA==
X-Gm-Message-State: AC+VfDxgpN+349C2ZhbGP6N3YSGXGPxoHBgNK7+vSp1EiaKDEAH+1u4u
        WeKX58s6EPE6/OVd1A8NRP5jgMRfZsVlfKSppTs=
X-Google-Smtp-Source: ACHHUZ7c9gSWjrwZxue6sPL7uq7eFxYUw4yf1gz5TUSPT8xCvAGOKyJDRC+O9NAV2yn3LsQ0hMEhWQBlCWvAxCExDxI=
X-Received: by 2002:a2e:b047:0:b0:29c:783d:9241 with SMTP id
 d7-20020a2eb047000000b0029c783d9241mr4488084ljl.23.1682994511509; Mon, 01 May
 2023 19:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <7705cbc2733a52cbaa53adc3dffab58f41eb4105.1682194652.git.gitgitgadget@gmail.com>
 <230501.86ildcht9c.gmgdl@evledraar.gmail.com>
In-Reply-To: <230501.86ildcht9c.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 19:28:00 -0700
Message-ID: <CABPp-BF42SuEObGqcVH0oQLYscrwoScg0TLuQRY7ZnNAhYTV8w@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] object-store.h: reduce unnecessary includes
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

On Mon, May 1, 2023 at 10:10=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  object-file.c      | 1 +
> >  object-name.c      | 1 +
> >  object-store.h     | 8 ++++----
> >  submodule-config.c | 1 +
> >  4 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index 8e0df7360ae..921a717d8a5 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -38,6 +38,7 @@
> >  #include "packfile.h"
> >  #include "object-file.h"
> >  #include "object-store.h"
> > +#include "oidtree.h"
> >  #include "promisor-remote.h"
> >  #include "setup.h"
> >  #include "submodule.h"
> > diff --git a/object-name.c b/object-name.c
> > index 5ccbe854b60..88d839f70bc 100644
> > --- a/object-name.c
> > +++ b/object-name.c
> > @@ -14,6 +14,7 @@
> >  #include "remote.h"
> >  #include "dir.h"
> >  #include "oid-array.h"
> > +#include "oidtree.h"
> >  #include "packfile.h"
> >  #include "pretty.h"
> >  #include "object-store.h"
> > diff --git a/object-store.h b/object-store.h
> > index f9d225783ae..23ea86d3702 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -2,16 +2,16 @@
> >  #define OBJECT_STORE_H
> >
> >  #include "object.h"
> > -#include "oidmap.h"
> >  #include "list.h"
> > -#include "oid-array.h"
>
> It seems to me that this should be split up, there does seem to be an
> unnecessary include here, as the subject claims, at least the
> "oid-array.h include in object-store.h seems to qualify.
>
> Maybe the same applies to thread-utils.h below?

Removing the thread-utils.h inclusion from object-store.h will break
compilation on non-linux platforms; that header is needed for the
definition of pthread_mutex_t used later in the file.

> > -#include "strbuf.h"
> >  #include "thread-utils.h"
> >  #include "khash.h"
> >  #include "dir.h"
> > -#include "oidtree.h"
> >  #include "oidset.h"
> >
> > +struct oidmap;
> > +struct oidtree;
> > +struct strbuf;
>
> But as this shows at least three of these weren't unnecessary, you're
> just replacing them with forward-decls.

Something was necessary, yes, but an #include statement certainly
wasn't.  Here, nothing would need to be recompiled if those other
headers changed, so the include is unnecessary.

> I think that's probably sensible, but I think it should at least be
> discussed.

We have now discussed it.  :-)

Did you want a simple call-out in the commit message, e.g. "Replace
the includes with simple forward declarations of the relevant
structs." ?

> It's also not clear why we want to just stop at forward-declaring
> structs, maybe replacing the dir.h include with:
>
>         int fspatheq(const char *a, const char *b);
>         unsigned int fspathhash(const char *str);

I don't like the idea of having to update function signatures in 3 or
more places when we need to make changes.  In contrast, forward
declarations of structs aren't susceptible to the same need to
update while making other changes.

We have hundreds of forward declarations of structs in the code;
everyone seems to be fine with them.

Whenever we've had duplicate declarations of functions, it's been
treated as a code smell that we've gotten rid of when possible.  In
fact, in v2.40.0, by my search we only had two of these --
xdl_emit_diff() and read_in_full().  And we've since gotten rid of one
of those (namely, read_in_full()).

> Would be too verbose, but if we did that we'd spot that
> e.g. match-trees.c is relying on this header to get its "struct strbuf"
> definition.
>
> I'm perfectly fine to leave that can of worms for some later date
> though...

That's a good find; I also found it separately later in some follow-on
patches so I'll also vote for leaving that can of worms for a later
date.  :-)


And thanks for carefully reading through this series!
