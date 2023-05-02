Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD26C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 01:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjEBBZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 21:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjEBBZT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 21:25:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C9199C
        for <git@vger.kernel.org>; Mon,  1 May 2023 18:25:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eff50911bfso3839083e87.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 18:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682990715; x=1685582715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i75gJrl5qIdMkZrPn8zyxXYFv9FhFrurETjO0Nb0o8=;
        b=j035p4oCgnlMdwhNuJvnAMJ+QzUP/EASSzT6J81MQmhfxWPGWNRJGLfO/yBMCyWDv1
         q10Nij1wxU4j7q8iFmYmjUufXo5MrdbsiVgfnq9eRBNI6qFPHOccg9plZipyJwbhyuKv
         6a//rUYrLu+ekRO4XxJ+8laMAlt8WBQ1gzHhflSRz72SKdlDsMh1PEshOPpFv4oCohnj
         mMo+Z8nXPd98nuvRfQNbbv1AOl5HIfBDKkK2WLA8QBPezmh758n8UrMWrWmqagsNwDHY
         EbWS9YGiqb6vFJyBE2RY3EiZ6LXBNTVGBzAyHJIS6FAlWx61uUBWrkZgVL3OA9P2mrvf
         0gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682990715; x=1685582715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i75gJrl5qIdMkZrPn8zyxXYFv9FhFrurETjO0Nb0o8=;
        b=cUVtwmEX0N8QVBtscGL+u54hzHZql28PdTai+zvhPAbmoujSOmP6CEaAtG8Mhntk1/
         bK/c9xUiEQ5eVNLpQn2vDoTmm4zw5FxD55QjZ6E5dUWJM7Z4o5q7cweos/Q37MrWK37E
         X9jK2uijtN2GUQaQV9NmVHNh0TkpZK4OdogFxZyovo36lSCHOac56KAvQVPp5G/7nnTz
         UEV+hcQSF7pbgQ7PdosXIL1kJ46sKGWgipStQkfA+C+xOlM+8Obn6gXk2+f9KxWe/kui
         KbZu1F2yMDLYzv9Fs62452IOdHaIM0NEV2a6bL4+eGgr4ds+1JesZPMVAb2zIl+PbtRZ
         QNrg==
X-Gm-Message-State: AC+VfDyHd8TVpxpInVDpW2b7YgP63tOhfk5R7bUJoAkwkOnsG5UL57j5
        ZpVHMq5kybjNlsjP/UvD4m0As82KKSXbt1s2oLU=
X-Google-Smtp-Source: ACHHUZ6Gkc9kvpbvIIW/h/kMaAem4+wexBSUG+6e/qAU92PNcjlJGSK89sAYmnuPOj9sU74lq+eGKbgMRmJM4iHqFCY=
X-Received: by 2002:ac2:52b1:0:b0:4cc:96f8:f9c6 with SMTP id
 r17-20020ac252b1000000b004cc96f8f9c6mr4168282lfm.5.1682990714700; Mon, 01 May
 2023 18:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <960b5438ce494a29cc93501cdf4ba4745740f374.1682194652.git.gitgitgadget@gmail.com>
 <230501.86v8hchuay.gmgdl@evledraar.gmail.com>
In-Reply-To: <230501.86v8hchuay.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 18:25:00 -0700
Message-ID: <CABPp-BEoCtmSwicpukd8SQZaL7ffTAW6su0mys3tXapr1UufEw@mail.gmail.com>
Subject: Re: [PATCH v2 16/22] treewide: remove cache.h inclusion due to
 previous changes
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

On Mon, May 1, 2023 at 9:48=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
> On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
>
> The "Subject" says "due to previous changes", but...
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  archive-zip.c                 | 2 +-
> >  bundle-uri.c                  | 2 +-
> >  color.c                       | 2 +-
> >  combine-diff.c                | 2 +-
> >  common-main.c                 | 2 +-
> >  config.c                      | 2 +-
> >  copy.c                        | 2 +-
> >  credential.c                  | 2 +-
> >  daemon.c                      | 2 +-
> >  date.c                        | 2 +-
> >  diagnose.c                    | 2 +-
> >  environment.c                 | 2 +-
> >  ll-merge.c                    | 2 +-
> >  match-trees.c                 | 2 +-
> >  midx.c                        | 2 +-
> >  object-file.c                 | 2 +-
> >  packfile.c                    | 2 +-
> >  pkt-line.c                    | 2 +-
> >  range-diff.c                  | 2 +-
> >  ref-filter.c                  | 2 +-
> >  t/helper/test-match-trees.c   | 1 -
> >  t/helper/test-mergesort.c     | 1 -
> >  t/helper/test-oid-array.c     | 1 -
> >  t/helper/test-oidtree.c       | 1 -
> >  t/helper/test-parse-options.c | 1 -
> >  t/helper/test-read-midx.c     | 1 -
> >  t/helper/test-string-list.c   | 1 -
> >  tree-diff.c                   | 2 +-
> >  tree-walk.c                   | 2 +-
> >  tree.c                        | 2 +-
> >  wrapper.c                     | 3 ++-
> >  31 files changed, 25 insertions(+), 31 deletions(-)
> >
> > diff --git a/archive-zip.c b/archive-zip.c
> > index ef538a90df4..d0d065a312e 100644
> > --- a/archive-zip.c
> > +++ b/archive-zip.c
> > @@ -1,7 +1,7 @@
> >  /*
> >   * Copyright (c) 2006 Rene Scharfe
> >   */
> > -#include "cache.h"
> > +#include "git-compat-util.h"
> >  #include "config.h"
> >  #include "archive.h"
> >  #include "gettext.h"
>
> I tried making this change before this series was applied, and
> everything compiled...

Yeah, this actually could have been done as part of b7b189cd5ae
("treewide: reduce includes of cache.h in other headers", 2023-04-11),
which was from the series before this one.

> > diff --git a/bundle-uri.c b/bundle-uri.c
> > index 6d44662ee1f..ec1552bbca2 100644
> > --- a/bundle-uri.c
> > +++ b/bundle-uri.c
> > @@ -1,4 +1,4 @@
> > -#include "cache.h"
> > +#include "git-compat-util.h"
> >  #include "bundle-uri.h"
> >  #include "bundle.h"
> >  #include "copy.h"
>
> That's not the case here, but this could instead be squashed into the
> 05/22 in this series, i.e. as soon as we add this copy.h, we don't need
> cache.h anymore.
>
> > diff --git a/color.c b/color.c
> > index f8a25ca807b..83abb11eda0 100644
> > --- a/color.c
> > +++ b/color.c
> > @@ -1,4 +1,4 @@
> > -#include "cache.h"
> > +#include "git-compat-util.h"
> >  #include "config.h"
> >  #include "color.h"
> >  #include "editor.h"
>
> I did not look further, but all of the rest of these look like they'd be
> better off squashed into the respective "split this out" commit. I don't
> think keeping the "move declarations for ..." as "move-only" commits is
> worth it, as opposed to getting rid of this one, and making those
> atomic.

So, while that could be done, I found it harder to review my own
changes personally, and thought others would as well.  If you're
looking through several dozen files for a single change (add one new
header), it's easy to fly through and be confident you didn't miss
anything, but when there are sometimes two changes (also replace
cache.h with git-compat-util.h, or just outright remove it if
git-compat-util.h is already included), then that slows review down
dramatically.

In the previous series, I addressed this by splitting each patch into
two -- (1) move declarations to new header and add new relevant
include, (2) remove the cache.h includes that was allowed by that
change.  See patches 7-18 at
https://lore.kernel.org/git/pull.1509.git.1680361837.gitgitgadget@gmail.com=
/#r
.

But having half a dozen commits labelled "treewide: remove cache.h
inclusion due to header changes in previous patch", seemed like a bit
of a pain too.  So I instead batched them up and did them all at once.
I could revert back to how I did it in the previous series, but I
think I'd want to keep the commits that are adding a new header
separate from the ones that remove includes of cache.h.
