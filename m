Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369F2C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8120866
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVkJEvHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgHNOKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNOKs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:10:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A81C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:10:47 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q13so4698726vsn.9
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p0OrfRkhABhTmFsrbzGC0S4kd9tNXXAq2lQCXc6K6oY=;
        b=iVkJEvHLL8HcAW/DQHR8B42xkCdHkeU00OjWAuUE8pnLGzHuIzuZ+EOSQ0UNour2i7
         /u3e/PtzhzFpyPuzkvlhqqmiC3LcsVRPiwraEIdV4EjJ+2QZI3bO3bExDe3Zt70QCx93
         eKlNqSfltPNMa387ryKrF+6+t91EtioRDskp7tH05PQ72q/bWI6/ab02aNKtAgMvg7Mr
         8T5mYPCXdeBsi0AtS/GK/K5DFztRMJPDB7KN2q58auYjVLNknNjQ2JKd3r6nQ/2t9hO7
         7OeFRa4ZIp8a8WDVunz0ElDBEeF8k7kJRc8IaeGuCcQ0q94kysL9ygbEyaGCTIuYHJ7W
         Gkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p0OrfRkhABhTmFsrbzGC0S4kd9tNXXAq2lQCXc6K6oY=;
        b=jvL/AIZyfMTGZk1cyrXzkPM1S39qu88LKooIgTQcelbF4d+lftHzN8vtXG2rt6XcUS
         2EKaSRnTiyN4lDNTWO1JFszNgTGoatlFmgxx5QWnceR0VzXNchJlF/CIY/gFcPVnANjj
         SHePRsHxi6XZ34CwlNCnvp6Azi8xkFl8cS30Hjm0/txCHhfi/gx7wcn8iQyvgt1TP1/W
         +2Blv/82+yiAdHg5BFpNlyvh8s/vOXdHVp5eKfpn/ZOhkImYIcpmpbSSQSxn61V90bkK
         AsQkNEsNYIu2aw9Obc6FN8EjfGql/ynxuTsSn6IryEecIO3zVHZq6e3HcfZgD3RcaXtH
         OOng==
X-Gm-Message-State: AOAM531lxQaHQO8K8DOpgws65IUXqYtuym+iaHOINfQy4CwgyNprx2zi
        lOll8tuusTFVLdx+g671CICMi3Rx6LgEZAMbrIE=
X-Google-Smtp-Source: ABdhPJxZE9dctpFVzkpmZWlM5KbcbX2cX/7opSUnBzKbSeFxSIdpgiOOJ+EbU1ExI3ypPzV7SePGV7Y3c3jfJgraZK0=
X-Received: by 2002:a67:2d16:: with SMTP id t22mr1554266vst.46.1597414247188;
 Fri, 14 Aug 2020 07:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
 <cover.1597406877.git.martin.agren@gmail.com> <bbcd97db8a2c94343950bb0cf8cbd5c9c01b4577.1597406877.git.martin.agren@gmail.com>
 <e216492c-d11a-6733-db64-720d027d3d42@gmail.com>
In-Reply-To: <e216492c-d11a-6733-db64-720d027d3d42@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 Aug 2020 16:10:35 +0200
Message-ID: <CAN0heSp024=Kyy7gdQ2VSetk_5iVhj_qdT8CMVPcry_AwWrhHQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] commit-graph-format.txt: fix "Hash Version" description
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 Aug 2020 at 14:37, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/14/2020 8:21 AM, Martin =C3=85gren wrote:
> > We say that value 1 means "SHA-1", but in fact, it means "whatever
> > the_hash_algo is", see commit c166599862 ("commit-graph: convert to
> > using the_hash_algo", 2018-11-14).
> >
> > Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> > ---
> >  If we want to be more fine-grained in the future, we'll need to say,
> >  e.g., "2 means SHA-1, 3 means SHA-256" or, perhaps preferrably, bump t=
he
> >  version number.
> >
> >  I wonder: Should we instead say "1 means SHA-1, 2 means SHA-256"? It
> >  could be implemented as "easily" as "if (value_from_header !=3D
> >  value_from_the_hash_algo) die(...);" for now. Might that pay off in th=
e
> >  long run?
> >
> >  This relates to Stolee's "in a vacuum" comment [1] ... so maybe we're
> >  fine.
>
> I think that was the intention of the byte, but that is not what ended
> up happening.

When I wrote this patch, I did go with "fix <thing>" rather than
"document SHA-256". For the other patches, it's sort of obvious how
those formats are so old that it's no wonder they assumed SHA-1. But
here, we did go to some trouble to try and future-proof things and
already had NewHash in mind. So that calls for "fix <thing>". But I'm
more and more starting to think that it's the implementation that should
be fixed and that the docs should just be extended to add "2 means
SHA-256".

> If we want that to be the case, then we should do that
> work as part of the 2.29 cycle before we release with the ability to
> create SHA-256 repos (which will lock the commit-graph format for these
> repos).

Part of my reasoning behind [3] was that in exactly a situation like this,
we'd be able to say

  With extensions.objectFormat=3Dsha256, Git 2.29-2.30 will barf at the
  commit-graph files that Git 2.31+ generate, and the other way around.
  Users will be able to remove "old" files and regenerate them, and
  shouldn't use a mixed environment.

and know that those users knew this might happen.

But certainly, if we can avoid it altogether by changing behavior
already in 2.29, that would be better.

[3] https://lore.kernel.org/git/20200806202358.2265705-1-martin.agren@gmail=
.com/

> (By "we" I mean that I would try to do this work in a way that minimizes
> conflicts with the current commit-graph work in flight [1] [2].)

None of those seems to touch `oid_version()`, so if we can just tweak
that function to return 1 or 2 instead of always 1, I guess that's one
way.

> [1] https://lore.kernel.org/git/pull.676.v2.git.1596941624.gitgitgadget@g=
mail.com/
>
> [2] https://lore.kernel.org/git/cover.1597178914.git.me@ttaylorr.com/
>
> >
> > -  1-byte Hash Version (1 =3D SHA-1)
> > -      We infer the hash length (H) from this value.
> > +  1-byte Hash Version (1 =3D SHA-1 in SHA-1 repo, SHA-256 in SHA-256 r=
epo)
> > +      We infer the hash length (H) from the hash algo derived from thi=
s value.
>
> If we are _not_ changing the format to have a meaningful value in
> this byte, then this documentation should be updated to state that
> this byte must always have value 1, as it does not provide any
> information.

We could still go

  1 means whatever extensions.objectFormat says,
  2 means SHA-1,
  3 means SHA-256,
  ...

But maybe that would just be crazy.

Thanks for all your comments
Martin
