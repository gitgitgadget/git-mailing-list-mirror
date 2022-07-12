Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA2C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiGLHeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiGLHeL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:34:11 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D776F32DBE
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:34:09 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id e69so12580230ybh.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGJl/lAY6z6QzP0n7OnAbdA61LxS1w8VY+cf+y/qyU0=;
        b=IOtI6TPhC3RuLxrPbSB/Vc7fBrMXQwDlr5jovl/bRXbvZ/TiHD+qDuS96Jfl/kUf3E
         TqQQcn7iext0hz4fKF4cph4Y3SykU2IekmpFqWrFZVPlA8m66Hg8UGB4BvaIIRGm+EWL
         PRTE9HhjCjg+fkOKZjrbt2094qI/eInliE26CZ1Agqxmszaknn023+jfcS5Img5E03Z+
         Djphx6IPcxXOWas/U5XNz1qor95IXgBezfXU5EJAq/gf+Cfp1mh0Xa9aTV+dm/rEpCV+
         +fxf5EZOIBNPHsJ8zwnrLajBQa8wTMIcA48ZsEJruXUD41wyUpzEXJzeTwdnREhxCbmq
         BKyg==
X-Gm-Message-State: AJIora+BHp0J/cZQUtFYUfvbw+ylToV2GrJCQBM8GKvch08zm43zMaXU
        AlHHhWuF1o6Bre5O3FoqIEXywpDioeZFryrtSig=
X-Google-Smtp-Source: AGRyM1vbks7w7gFi0KCnFbYk/2mqtHPhVl3sN4zagenW2925Xw9NCYyEgDw2U+YXPc+x6w4QScQCl2fU+CSXU0CEwi4=
X-Received: by 2002:a25:ac90:0:b0:66e:3a1f:c293 with SMTP id
 x16-20020a25ac90000000b0066e3a1fc293mr20912230ybi.462.1657611249060; Tue, 12
 Jul 2022 00:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081135.74964-1-sunshine@sunshineco.com>
 <CAO0brD0PBXDqe2HDdjg1ZhXWoYZihQ0=SY80UR+Cy3xRqqH8Sg@mail.gmail.com>
 <CAPig+cQJWgerk08j=1b=aWRZsKBu3BnEACQuiqktU4BwzM-xaA@mail.gmail.com>
 <xmqq7d4kp8l6.fsf@gitster.g> <CAPig+cQMJcUc4gpRDpR=Q8M44rTjUA7SWgXNmzrnDH7V12z0dQ@mail.gmail.com>
 <220712.86lesy6cri.gmgdl@evledraar.gmail.com> <CAPig+cSgNB=SzAZLhXvteSYmy0HvJh+qWHMYyBxcX_EA9__u4A@mail.gmail.com>
 <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
In-Reply-To: <Ys0hhYjPExuNWynE@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jul 2022 03:33:58 -0400
Message-ID: <CAPig+cQeC4_+22rzHFtdvNwL2PqpTLtS-32t0hwcemNKOA36bQ@mail.gmail.com>
Subject: Re: [PATCH] unpack-objects: fix compilation warning/error due to
 missing braces
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2022 at 3:23 AM Jeff King <peff@peff.net> wrote:
> On Tue, Jul 12, 2022 at 03:13:50AM -0400, Eric Sunshine wrote:
> > > Since this is only a warning, and only a practical issue with -Werror I
> > > wonder if a config.mak.dev change wouldn't be better, i.e. to provide a
> > > -Wno-missing-braces for this older clang version.
> >
> > I'm in favor of this. It would, of course, require extra
> > special-casing for Apple's clang for which the version number bears no
> > resemblance to reality since Apple invents their own version numbers.
>
> I got PTSD reading that thread again, but in case anybody wants to dig
> into this, I think there are some hints from the last time we discussed
> this (starting at the end of this message and the subthread):
>
>   https://lore.kernel.org/git/YQ2LdvwEnZN9LUQn@coredump.intra.peff.net/

Thanks for digging up that link, and sorry for triggering PTSD.
