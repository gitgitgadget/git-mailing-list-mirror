Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C4C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiKVQwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbiKVQwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 11:52:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0EBF3C
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:52:33 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id n189so5568800yba.8
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 08:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yzMaVYox1/3BJadPiJRbXkyq1bP6DDYGVD0wqAVndgc=;
        b=eZy40UCkcmgOqeewX6nCHlj1/uRlcxAQMO88J2aVSCxSgtChDF4qPG37fuFepWTvX6
         VArBmGi1Xb1yjztdTEvYEKL2aieLY1J4+dH9AMrb4E9NTm10Xrl6lpI2QKEDHw2D0hdr
         ZVPgv0M55DA6A6wVzfYXcpUz1e2xka/nsXGxnRkM4TSgMQ/cg0+PHDnScgYkDoPAvYje
         u+cjq1boQuURnTjLbb6xb97aQycEcPJ2H9XTWiHs+qYh4V1wmaScHtB6G2rxI8ZYYFwN
         e+jf/2+5W3EMQ+yw6jfvALy3c71pXFgnztrNvaWeS692asHrPsT0TModaedsKoya8xj8
         PNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzMaVYox1/3BJadPiJRbXkyq1bP6DDYGVD0wqAVndgc=;
        b=GJyNnlCXLUV4xtyDRBRNg1oTpEj9AkAKtH191PqmNgEtkUuG4+2BHLTwN8tQ6+xkSV
         c+vwrifAAPqmAMrOfBCTQ+OmDrNZxgk5HKICaUWTBDfrj5DljSmWPCrnga8oENoq+o6K
         5eHPU/BsCijn0w8XitivSIaBkTvhoe+fVw8ueZqljmgI4ypfjyfAvEOzrQRFvZny3jD2
         b0VLY9SXXUrOtFG48lMq+19kLUnPMeILm4k/Rl6gMSMC/79GDh/k/+KNS36FTcX/LSaI
         2hUySnK1d9h9rm4r4b3hgjJHnfgCmq+hWF2Wr0z0p9OOQA43RLPxpqhDasd4OmJP3sDx
         nUeg==
X-Gm-Message-State: ANoB5plhHTGwx4EhsgM876SoHxKSd12HSAidTEPh7XdyJou/j6mrkV0r
        5kCQohBtjLgMn//MQFvPX4AKPdSRPJuYZLrqGH4=
X-Google-Smtp-Source: AA0mqf5f2jM68HghMMg4bDC5odhlsrozbmzlPaCpWvHtkDYvX44bazp5apH3iYtNE4rzc5EnDMeSNNGgMJHXLseP2V4=
X-Received: by 2002:a25:7653:0:b0:6e3:4ca6:1dca with SMTP id
 r80-20020a257653000000b006e34ca61dcamr4257403ybc.414.1669135952613; Tue, 22
 Nov 2022 08:52:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com>
 <pull.1384.v6.git.1668547188070.gitgitgadget@gmail.com> <CAPig+cRPQ7bmG6+U+oQGGUFiSiHoMMpMk8FDJ7GMJvwCXifa9g@mail.gmail.com>
 <CANaDLWJM1VRivm8VLqxg+w8K-+49E0km6AgOzWzN9X=TgzaEiA@mail.gmail.com> <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
In-Reply-To: <CAPig+cQgu=i6pZTzoNYGZ_6X=DGdmwa=dPhSQVqD+eLCZCGJSg@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 22 Nov 2022 10:52:21 -0600
Message-ID: <CANaDLWJ+Suye98QKub9nfnknLEsyQ4PK1LxDkPmzGC_-hApkFw@mail.gmail.com>
Subject: Re: [PATCH v6] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Most likely it wasn't a glitch, but rather (I'd guess) that Windows CI
> uses "main" already, whereas Unix CI's still use "master".

My intuition was that it was something like that indeed.

> you might write the commit message like this

The current phrasing was initially copied as is from a past review
feedback; I have no issues at all replacing it with yours.

> So, if there is an existing test script in which
> these new tests might fit, it's better to add them to that script
> instead

Oh, sorry about that, it hadn't occurred to me that there could be a
downside to using new test script numbers.

I'm 100% on board with the thinking, but I'm struggling quite a bit to
implement it. There are several existing test scripts where these new
tests would fit very well semantically (t7060-wtstatus.sh,c,
t7512-status-help.sh, t7519-status-fsmonitor.sh, ...), and I spent
quite some time yesterday trying to move the 3 news tests to those.
For some reason, test_cmp is not giving me a diff anymore when working
in those script files, so I feel in the dark about what the tests are
failing about, and I'm stumped about what to try next.

What I mean: for instance, if I introduce an intentional mistake in
the test and run './t7065-wtstatus-slow.sh -v', I get this section
that clarifies what the issue is:

--- expected    2022-11-21 23:46:00.000000000 +0000
+++ actual    2022-11-21 23:46:00.000000000 +0000
@@ -1,4 +1,4 @@
-On branch maine
+On branch main

Here is a gist https://gist.github.com/rudyrigot/b31fcb6384e829ca7586818758e48d0b,
with:

- the patch as I currently have it on t7508-status.sh (it's a bit
longer than it was, without the isolation in a separate script I've
had to do a few things to mitigate the side effects from other tests
in the script)
- the end of what I get when running 'sh ./t7508-status.sh -v':
https://gist.github.com/rudyrigot/ee80f3d59231f25698c9dd6c48d8ab85. It
seems like 2 of my 3 tests are failing, but the output isn't very
helpful to figure out why.

Would you (or someone else) have pointers to help me get through this one?

I'm tempted to throw in the towel, since it sounded like it wasn't too
huge a deal if this lived in its separate script file, and that other
people's bandwidth (which I'm aware is what I'm requesting here) is an
even more scarce resource. So I'll submit a new patch with everything
else but this, so there's the option to still proceed with it if
that's the most sensible path forward. But I have to admit I'm quite
frustrated that I couldn't figure this last one out by myself, so I'm
more than happy to dig more into it, if anyone has guidance.

Thanks a lot.
