Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF4BC77B7C
	for <git@archiver.kernel.org>; Tue,  2 May 2023 01:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjEBByu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjEBByt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 21:54:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9E82121
        for <git@vger.kernel.org>; Mon,  1 May 2023 18:54:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f00d41df22so25505540e87.1
        for <git@vger.kernel.org>; Mon, 01 May 2023 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682992486; x=1685584486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB38QXEbrWKt8OKOrzasDNWQrlZWgVN1aBG5ORqCks0=;
        b=YsBJStmZN/bFNGFIzpMZ6cGSwubMLza3KKBrf6RdJCURlpINwCOVyG6icrGKLCoCzp
         ISugxE79hbkkTG1+D/R8vZinujCFnKb11Yr3Ohsp+ZH8CCZREm6d+IwxqOzYBV3WS5bw
         02W5WkJycerbkaD/a6CIGvvPmy06OLST6Fxf1W2vGKBwV5ZZz2Z/o3TSbryNXN9hm6N1
         vjReTjmnHZduyRLhMkPc6b21cEf9vQs8TK3mhdaorvPAQM1Vjv3svxG/yfUNWj/xpKyL
         YeVkKYwluaGA4N6U7h39ZKJfWEeLjS1L4ogx/sb006fTVeonOF/QQ7+eM/RulF6U3o4F
         HuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682992486; x=1685584486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jB38QXEbrWKt8OKOrzasDNWQrlZWgVN1aBG5ORqCks0=;
        b=hd8BJrKECJ+a7HAzBmXNNLiVTe5fhljwBj3a9VKjte9Cxe24rb5ye7y6mnSzQsklsv
         kCyfX7pgJQptdTAdSC6PIMOteEUF8wpRwcZb2yL++3dGGaiFKkWjW2ajn/KHV6PLR7kN
         1GhxrOv/OB/8oZSeYTLEdVzebtvoMXHeS+A2tB1tFP/vzwwmHQ701nxM6JaEFkxtjiI8
         19/W7QWotlr3O0UCebL0VrMF1Z15N0xKwcMFI/7QJOwE4cWU+bPRcq7sfDGryhbv4AHu
         YRtcxiWLmuBisjlluXrL9ol3hazSQWj+0/5ECAHq3nSwk/vjNynXXVIHeX3RfDSW0ABv
         yXtw==
X-Gm-Message-State: AC+VfDz/s5MCtDSC0PqpY7pd5wn36TfzpVU7ji1BkIYEKNzqj8Ps7MfR
        cYWEe/LmS445czvbQ7Wql8JInSQCBK3pOLJoMRo=
X-Google-Smtp-Source: ACHHUZ6bewTYVOcI2QyHoJvmJGLCwdbvkWHHncoiG99dJ7Qowt4eQTHGNg5+FeMnXwS/Kz3OYZ+ptj7lqE82yUOlHDI=
X-Received: by 2002:ac2:511d:0:b0:4f0:13e3:a291 with SMTP id
 q29-20020ac2511d000000b004f013e3a291mr4163680lfb.28.1682992485848; Mon, 01
 May 2023 18:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
 <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com> <7479e72ffd612addd9d71118647849d99c5870f8.1682194652.git.gitgitgadget@gmail.com>
 <230501.86mt2ohtt0.gmgdl@evledraar.gmail.com>
In-Reply-To: <230501.86mt2ohtt0.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 May 2023 18:53:00 -0700
Message-ID: <CABPp-BGOAd=CY2vrd-GjFzk-889MukKX1nbwwi5+9F+UC0aWuw@mail.gmail.com>
Subject: Re: [PATCH v2 19/22] commit.h: reduce unnecessary includes
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

On Mon, May 1, 2023 at 9:59=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>
> On Sat, Apr 22 2023, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> Re earlier comments: If I rebase to make this the first commit
> everything compiles, i.e. nothing here relied on the earlier split-offs
> of cache.h into other headers.
>
> You need to make a choice of whether to first split out cache.h, and
> then do commits like these, or the other way around.
>
> I'm not sure whether it's better to do it the other way around. If you
> do that it's clear e.g. add-interactive.c's implicit dependency on
> tree.h via commit.h has nothing to do with what would be the subsequent
> split-up of cache.h.
>
> Or maybe this is fine. I'm just trying to get some picture of what
> depends on what in this series...

Yes, there is some freedom about the ordering of patches, and I had to
make a choice.

I found a number of the cleanups like this one for commit.h
interspersed with the other changes, but I intentionally grouped them
at the end to get a good high level overview, namely:

(A) Continue splitting declarations from cache.h to separate headers
(B) Do other header cleanups found during that work

I could have reversed the order, but since the series was motivated
and organized around (A), it made more sense to me to put those
patches first.

Besides, the last time I moved a few miscellaneous cleanup patches to
the front of the series, someone else responded thinking the purpose
and motivation was about those first few patches[1], so I wanted to
avoid a repeat of that problem.  ;-)

[1] https://lore.kernel.org/git/CABPp-BFZBWTG1VF6N8teVMYxoUdOeciKGwPq1g-G1K=
5--My5uQ@mail.gmail.com/
