Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD4C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BB061440
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhDUJxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhDUJxh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 05:53:37 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07334C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:53:05 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id 66so20849457vsk.9
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q8kxvcZ+F9nHM26i15oNv0eBDNdXOHz6jUtd2XirjtM=;
        b=kg17xrDOO+gL4a3k017pI2crh9/g6u7g2x2KWY328QThAcll5ZUf+/ljR5HiBwpmq0
         6gVeDLgKqLkKbFSmTq+9oxXe6ThQWFx4KnutAXTmNBbgD9wcXL6g5bYBPOoD4H9Yg8XY
         FgiKa6vWmg3usW17pltvLlEZ29MfLEZLrszJLcBkbpG9gYjgsp3Ph0KbZqSpMpd/XrXD
         OGrALz1PcOLpXcjB/MqDsp7S5emLCVnNl1r/fS0bIDBTKrpyU97BydZPmKclJEDucBRD
         DkXxroWFrgoqcHFz+x5msuholE9pN/fPpho5pDEnyXTgwzPPlwvz9xV31pYg5IsxqEVB
         8Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q8kxvcZ+F9nHM26i15oNv0eBDNdXOHz6jUtd2XirjtM=;
        b=cKrbRcP797nXyyP7KaLow+UX70DTRStWoq8viagy+mYDVkRW3fbXI52t8BIJRWCyrp
         VVuPlZTH8ptIE8c90S/YstrpGhzt7laChxKAOJlyg91ek766at+FvQHC/RqH0O6VOSwW
         yWnORWPO5MELV89NRiBPXVtD0DQVkMkts1sT7gxjpaze6id7Gaar0MesuNd/B+988Ek1
         pjKH14HVweN1H+7B+/4zRUfvjFPuuUQiPHw+wMhBQz3Lr9Y3+JKpSqjOQsNO5SpmFPYT
         M/+026tLZS4qBSMz60/skl7yrAa7DYHPoqqAH383XC5s6AWrt9M0q9r7zrQfSb3bVJXW
         UN4Q==
X-Gm-Message-State: AOAM533uUcMU5rOJxwno2VSU+4XAVP22BUfU/ARxzFRnvjgdaY4ei8Vx
        0433otl4821yzylcKLZGh6wo5dfRurIKjJ6AsgiMVhGSB+g=
X-Google-Smtp-Source: ABdhPJxlxA7KRzffdKEhoBDYutHiWudMsiK85hTpqM9rtpRCbba3VFBI2KGYSFeEPtBdJzyRGMHG0YEQUggx9v3ddxw=
X-Received: by 2002:a67:7d42:: with SMTP id y63mr25344494vsc.5.1618998783976;
 Wed, 21 Apr 2021 02:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <878s5c3wti.fsf@evledraar.gmail.com>
In-Reply-To: <878s5c3wti.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 11:52:52 +0200
Message-ID: <CAFQ2z_MF3SbKf8yXBvkOcLGg03dVxJW3F=c6ZDUtstEbZUUMCQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/28] reftable library
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 9:45 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > The commits up to "hash.h: provide constants for the hash IDs" should b=
e
> > good to merge to 'next'.
>
> With how Junio queues things up perhaps submitting this as another
> "prep" series would be good, to reduce future reviewer fatigue,
> i.e. anything we can make land on master makes re-rolls that much
> smaller.

will do.

> > There are several test fixups, but I've put them in another series beca=
use
> > GGG enforces max 30 commits.
>
> I left a bunch of comments on the test prep series now. Probably good to
> have it split up regardless of GGG limits.
>
> Re the comments I left on the test series. I'm very happy to see the
> start of addressing the "it must be tested" concerns I had in
> https://lore.kernel.org/git/87wnt2th1v.fsf@evledraar.gmail.com/

It may look like the start, but I've been improving the number of
tests that pass continuously since I posted the first version of this
code over a year ago.

> I don't see the point of having re-rolls of this topic while the test
> changes topic it's based on hasn't finished
> marking/splitting/refactoring the various tests that do and don't depend
> on the file backend.
>
> At least when I review it I'm just left with going in circles digging
> into one of those failing test, figuring out if it's really
> refs/files-backend.c specific or not etc., and as long as we can't turn
> on GIT_TEST_REFTABLE=3Dtrue in CI as part of this series I don't see a
> path to making it advance to next->master.

The point of posting updates is to garner feedback, especially from
people familiar with the Git code itself. If you would like this
effort to move forward faster, I am most in need of review for the
part that glues the library together with the git code itself (ie. the
commit introducing refs/reftable-backend.c).

> > Due to using uncompress2, this build fails on the Linux32 builder; what=
 is
> > the magic incantation to run autoconf?
>
> Doesn't this just need a NO_UNCOMPRESS2 for Linux32 in ci/lib.sh? See
> the lines just below that for e.g. NO_REGEX for another CI target.

Thanks!

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
