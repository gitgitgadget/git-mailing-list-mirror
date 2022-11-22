Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83DC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 17:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiKVRY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 12:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiKVRYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 12:24:24 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D309748ED
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:24:23 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so2514811pjj.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 09:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6w/zgdbW7pcV3GvyfmoOmWU0YyW7g3CXqmJi+Ts7/I=;
        b=vSDsT6Kn/P2Tv3qfPTsqn6d+gGFJNiT//+598VHdMX5mqpGrMbvYAcE4CnW0U2PC3E
         upRxSZG7/YZZFy1UhCRiLGXklk7AyOfDZkHf3Lqt7gWjJDVlTVsfuPVcXrfJRrFSM36p
         wu7nf3fe+J0xVjd8p6u+ylyh+AXh4FQi+w49/meLFLbq77U9aa+UhRkHMe/O8HA9e0QR
         iZy2Md3waVWE+pmYCV2ZsO8gr2O9REFNcX+z0ZSYVCtbIrH2HbXdNMO0XZMcIXgAysbH
         Z1qTdnDRVg4bvdZQZNoLpnAseDGYminFJaychk52uoum61lg9mEKB713j/Qob3dMBjnh
         NTew==
X-Gm-Message-State: ANoB5pmh/uUE+o7iMf2+W4iRNeokO5NlO8t/0aByQ7wCZG7qbwbVUgUX
        ouxgLxgj0tttyWYeglAvGBeFEueL9ZIWeVTRiKc=
X-Google-Smtp-Source: AA0mqf6wYmXQnkgo1dWbGYnz31RaOr/hIvohlEn6Fjdk+7aMtLbhASKkIfHUHmQIWygzWmpLBcEmMn1sdZqW+4wye+M=
X-Received: by 2002:a17:90a:898b:b0:218:bbfb:72e1 with SMTP id
 v11-20020a17090a898b00b00218bbfb72e1mr9266489pjn.64.1669137862525; Tue, 22
 Nov 2022 09:24:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com>
 <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
 <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com> <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
In-Reply-To: <CAPig+cTrpnVOW0Y2m5xtPhLudY=rPCn3qPQA0RSso7ueFytZbQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 12:24:09 -0500
Message-ID: <CAPig+cR=kkWVuBDh2FS+869a_P_xaLj5NaCgW7q3M_utLrgSsg@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Rudy Rigot <rudy.rigot@gmail.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 12:18 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 22, 2022 at 11:52 AM Rudy Rigot <rudy.rigot@gmail.com> wrote:
> > > you might write the commit message like this
> > - the end of what I get when running 'sh ./t7508-status.sh -v':
> > https://gist.github.com/rudyrigot/ee80f3d59231f25698c9dd6c48d8ab85. It
> > seems like 2 of my 3 tests are failing, but the output isn't very
> > helpful to figure out why.
>
> The second 'gist' URL seems broken, so I can't comment on the exact
> output. Without having seen the actual problem, I can't really provide
> direct feedback for fixing the precise issue, however...

Despite the URL of the second git being broken, I notice that you have
some "-v" output tacked onto the first gist. Indeed, the "-v" output
isn't very helpful here. What I normally do when debugging failing
tests is run with "-x" and "-i". The "-x" shows all the output the
test produces, including any error messages. So "./t7508-status.sh -x
-i" would likely make it easier to diagnose such failures. (But first
try the suggestion I made in my previous reply for isolating the new
tests in their own repository.)
