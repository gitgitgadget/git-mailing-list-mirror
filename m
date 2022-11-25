Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3518C43217
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 23:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiKYXyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 18:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYXyj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 18:54:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EF26AEB
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 15:54:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x2so8243478edd.2
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 15:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dfyVGtw5wHAjJPeIoY+IvUxfWwMuvxnO2A8jILJoDX0=;
        b=gDuRH/3d/3jSKhbRWxNAJ9kdEMK+/j4JuQojiD4C1UvcXv+5zM7fCKxJbdc3l8oORW
         easKd+sZiKgcLd4lrPyvQD92YG857woeq0PUPqOBM3PMrwVZDxQOwXrYf9M8AXznGQg/
         lsIqMoyWdK3rsujdmh/czy1ACfEruYinq0inzba5v7owlB3wuEg30SzmlbCzPVc8ztnW
         fJ6Gtals9rNaQnasKbcWLv7Kn4nZ3pnMz8WJUzFvq/43/8TKbtZxamBlIyS2LQD/q7bk
         dPpxfa9hk0BOy2H/ebXdegelo4h7zA0oEVNFTmEqii3kWqptnGROWPlhpy2Io7lJGsd5
         FEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfyVGtw5wHAjJPeIoY+IvUxfWwMuvxnO2A8jILJoDX0=;
        b=0R1cdRVjwWQmansDPNL/zS2pAID1E83/WOoIOmhx6nidPDhhqqXL68DpdxSSNnUY6F
         TwztiYpDMDHxu84yGc+gX4wiBcue8aI0EDDnVnN8S833zMqn/xiKciC1bY+Yt01NQGjK
         nAwYTOZaz9IoY6EUYDFdLVH0sB9oKnGFfIbQfhlL2LjNLGz9Ta4QrAvI+8ZXGKbkBBHK
         8/Q6d8CDJvEH1MIeWlRtzz6KmyvfID8MLRFNqZFBb4Zok1x87iV4KYqFNFwu/Vqmx6D2
         a/Y9SKNcmeEwapu9318lc+uxz1Wo86zmYMb44OY4edc/IR0mzMxPQ7wm3AtdinV8V3Fp
         ttxw==
X-Gm-Message-State: ANoB5pm6RUwKr83vo8BfFxL0LOL+lyjscQQmJ3Zi2feBbbbXmiPVedFL
        JAm3Kg71cqZX2H84ubeB5xZsO7PIKdgbWgej
X-Google-Smtp-Source: AA0mqf6cBiH4j6KOk6dw4Wx73acILD0eqTbHLkmcs8KnShpt0wOxQtAH4ee4nk817oY1QI6h1cS1/g==
X-Received: by 2002:aa7:c04f:0:b0:45c:f13b:4b96 with SMTP id k15-20020aa7c04f000000b0045cf13b4b96mr3159911edo.129.1669420476186;
        Fri, 25 Nov 2022 15:54:36 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id y41-20020a50bb2c000000b0045bd257b307sm2336261ede.22.2022.11.25.15.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 15:54:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyiWh-000ddU-16;
        Sat, 26 Nov 2022 00:54:35 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
Date:   Sat, 26 Nov 2022 00:52:50 +0100
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
 <221125.8635a7o123.gmgdl@evledraar.gmail.com>
 <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
Message-ID: <221126.86h6ymmvyc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 26 2022, Yoichi Nakayama wrote:

> On Fri, Nov 25, 2022 at 6:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I'd really like to have some closer and smarter emacs integration like
>> this.
>>
>> But I don't see why we need to run the grep ourselves, pipe it to a
>> temporary file, and then discover that we're using emacs, and --eval
>> code into it to switch to that buffer, and fake up a "M-x grep" command
>> with a compilation buffer to make it look like we ran M-x grep in the
>> first place.
>>
>> Let's just ... run M-x grep earlier? Then we can skip all the earlier
>> steps.
>
> There are two reasons.
>
> First, I want to reuse the modes that git-jump already have. In
> addition to mode_grep,
> mode_{diff,merge,ws} exist, and if we re-implement each for editor
> support, I think it will be
> difficult to maintain.

Yeah, maybe that'll be painful. I haven't poked much at it...

> Second, there is a difficulty passing arbitrary arguments properly to
> Emacs Lisp properly.
> For example, your version will cause error with
>         git jump grep "hello world"
> My early patch was doing something similar. But the second problem was
> hard to deal with,
> so I switched to using a temporary file.

To the extent that that's painful couldn't we write the grep expression
/ arguments to the tempfile, then feed the tempfile to the ad-hoc elisp
code?

It would then read it, get the argument to grep for, and we'd call (grep
that-argument).
