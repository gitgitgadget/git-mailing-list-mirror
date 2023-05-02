Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D79C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 02:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjEBCyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 22:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjEBCyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 22:54:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B8D3AB8
        for <git@vger.kernel.org>; Mon,  1 May 2023 19:54:22 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so4272627e87.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 19:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682996060; x=1685588060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v2KIb+NCZKE1Oow5llQ5V8R+zymxqkttJWd8LilS7E=;
        b=AB1YZQw+7ojLU3HVwuraMoOEC6jFbTsFu/I97052HWO1WdKWSC6BGCHIAkstBGFKX5
         RbnqW7tGIxFuL50ht/q1otuue+5d/OUhUnXYHTwHtYKuJSlf0TJDjClMRluV2UJnbLf0
         wgVmWkIFUlKwsoCNtgs1XOrgbBHyWr7rU0BYhtXBOd91LQ//Ph0k3jFVa9AGKih8vraX
         8j7fo1H1pXSerdGl/8Ia4t868XEXLariFQOod2bQ3T99mSwMVkpIDouNjFbAjxDGqWEm
         eDPOHXbhOb3o5Cb0JL26PxafKwIQ3wx571Unk/eKjbgBzbpQHV67BGQGpsw+ya5+Z6Hp
         IKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682996060; x=1685588060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v2KIb+NCZKE1Oow5llQ5V8R+zymxqkttJWd8LilS7E=;
        b=aW5uY/oD7k8G+kmQPBgX+UbHsjZqw895b9kdVJZO/qHbNp3ZYgJLOcaan4k8X8YNAO
         elMqGz/j86rsog1Y+Swjn3ilKFLpItaUs6TR9m/KUSmbLd9M+TCEfKOJ7Z3t8DeoL3lb
         2Jm9TG8nvVouLOInq+fy99igbX6r1gn770qoYq2vopxwyyoCyPfbLWoP/uYYjSF+DglD
         oeXeaxDjI4fEI911y+N+icr+JNNvi8/KyCr8kwznarQlvxOJeOJbisr1qCKiND+GPZuO
         XiA3Hmxt3S23qlVfnp5xeitWVexxeJHUaO7zacAYr41jgSN7OA8I89FH7Z3Pu9CsxcWI
         KrxQ==
X-Gm-Message-State: AC+VfDw8tx9FVgpecO51xGfJYOiQObuTht6p2C036jr8nM/DgZfTPzPW
        9MGOdHk3x8TDC883oIPScFRdVIvWIaR8cgKf7Xcqjr1N
X-Google-Smtp-Source: ACHHUZ4oJVQegrjQqCTi1wwPrjaDbvlrf/Js1wqr7uC4jejfBu+77sJ1zStJht+0dON1BMI9sXMNjmfezVr+Rt0gXNc=
X-Received: by 2002:a19:7003:0:b0:4ef:f017:e52 with SMTP id
 h3-20020a197003000000b004eff0170e52mr3911880lfc.5.1682996060198; Mon, 01 May
 2023 19:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <d95f97f5e90da40b285aa8fd678efcff0ae11033.1682194651.git.gitgitgadget@gmail.com>
 <230501.86a5yohsme.gmgdl@evledraar.gmail.com>
In-Reply-To: <230501.86a5yohsme.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 19:53:00 -0700
Message-ID: <CABPp-BHv93VsAZ8=jzDPcNXOyZ1W4Fhf14gusvEp_i9XYE-Xhg@mail.gmail.com>
Subject: Re: [PATCH v2 13/22] hash-ll.h: split out of hash.h to remove
 dependency on repository.h
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

On Mon, May 1, 2023 at 10:24=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > [...]
> > diff --git a/checkout.h b/checkout.h
> > index 1917f3b3230..3c514a5ab4f 100644
> > --- a/checkout.h
> > +++ b/checkout.h
> > @@ -1,7 +1,7 @@
> >  #ifndef CHECKOUT_H
> >  #define CHECKOUT_H
> >
> > -#include "hash.h"
> > +#include "hash-ll.h"
>
> The end-state of this topic is oddly inconsistent in when it uses
> includes, and when it uses forward declarations.
>
> As I note in a reply to 20/22 you're adding forward declares there, I
> think that's fine, but if you opdet for that why not do that here. The
> body of this header only defines one function, which takes a pointer to
> a "struct object_id".
>
> Whereas above you did this change:
>
> > diff --git a/apply.h b/apply.h
> > index b9f18ce87d1..7cd38b1443c 100644
> > --- a/apply.h
> > +++ b/apply.h
> > @@ -1,7 +1,7 @@
> >  #ifndef APPLY_H
> >  #define APPLY_H
> >
> > -#include "hash.h"
> > +#include "hash-ll.h"
> >  #include "lockfile.h"
> >  #include "string-list.h"
> >  #include "strmap.h"
>
> There we really should include it, as we're not dealing with a pointer
> to the "struct object_id", but the struct itself, so we need its
> definition, and don't want to find it implicitly.
>
> > diff --git a/chunk-format.h b/chunk-format.h
> > index 025c38f938e..c7794e84add 100644
> > --- a/chunk-format.h
> > +++ b/chunk-format.h
> > @@ -1,7 +1,7 @@
> >  #ifndef CHUNK_FORMAT_H
> >  #define CHUNK_FORMAT_H
> >
> > -#include "hash.h"
> > +#include "hash-ll.h"
> >
> >  struct hashfile;
> >  struct chunkfile;
>
> Then we have this, where we seemingly could avoid the include as well,
> and just add a:
>
>         struct git_hash_algo;
>
> Anyway, I'm not saying one is better than the other, I'm just wondering
> why you're picking one, but not the other.

Basically, just because I updated all the includes through:
   $ git grep include..hash.h | xargs sed -i s/hash.h/hash-ll.h/
and then tried to compile and fixed up the files that had errors
(usually by making it include hash.h rather than hash-ll.h).  Every
once in a while I might have noticed that a simpler forward-declare
was sufficient but I didn't always look for it.

Anyway, thanks for looking closely and pointing this one out!
Switching this to a forward declaration is another nice cleanup to add
(though perhaps to a future series, as this one is long enough).

> Is it because you know that hash-ll.h doesn't bring in other headers, so
> its inclusion is OK, whereas later in e.g. 20/22 you avoid including
> strbuf.h, because you know that'll bring in string-list.h?

No, it's more "we gotta start somewhere, and stop well short of
complete for the series to be reviewable".

It's really easy to look at pieces of this series and notice all kinds
of additional cleanups that are possible:
  * Emily pointed out that if we're moving a global to a new header,
why not update the code to just delete the global?
  * Calvin pointed out that git-compat-util.h had become a dumping
ground too and needed cleaning.
  * Glen pointed out that some of my reasons for splitting between
hash-ll.h and hash.h would suggest, based on function definitions,
that 2 of the declarations should move back to hash.h.
  * You've pointed out multiple good additional cleanups in your review so =
far
  * I had an ongoing list of dozens of types of changes to make while
working on this and prior series.

Anyone who looks at this series is going to spot additional "what
about this?" things.  They're all great.  But I picked some cleanups
to make, and carried those through.  Because of how I did those
cleanups (note my grep & sed command above, followed by
recompile/edit/repeat cycle), I noticed some additional cleanups that
are likely different than what someone else reviewing them will
notice.  Some of the additional cleanups I noticed are in this series,
but most are delayed for some future series.

> If that's the case maybe we should just move
> strbuf_add_separated_string_list() into some "used by merge-ort.c and
> merge-recursive.c" file, remove the string-list.h includion from
> strbuf.h, and then include "strbuf.h" without fearing the side-effects
> elsewhere?

Ooh, nice catch.  If that function is only used by those two files, it
should be moved to merge-recursive.h (merge-ort.c includes that
currently).  However, Calvin is doing a bunch of work refactoring
strbuf.[ch], and I told him I'd avoid touching it to reduce conflicts
with his in-progress work.  So, I'll let him tackle this one in his
series.
