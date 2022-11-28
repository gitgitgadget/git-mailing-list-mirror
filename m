Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7769C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 09:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiK1Jk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 04:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK1Jk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 04:40:27 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BBF6153
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:40:26 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 136so9454199pga.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 01:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcCd9UdD12YUQPQywwnxXVJbwpLGFO7NzIVJx0qutZc=;
        b=qhAlneR2eStPR+UKJOrX73a4wZ6Els1veme7CVwPzp9EK9XldJ3rzaoXFlAKN5IzaN
         p0q0mnRbQUAlKZ5H6N7xrYEKmwTNV92+VOoRXGLl9j6qeT0Ds5GaYj5qxtmCKANeWbI4
         Dgb11kN4gPEslo80H7tZT941F72ce+vhrvDyj+ltMAyGg+X16foWBcedRjM8LO7NO97c
         Vfn13X/+yFrbDEeuEMFgXMLzqSwhMBNQMzga2yF1F+tYMdrZ3eyiof9Of90oG4cebb4r
         W63YW6as0lEWXcfwe+3Jz1HYyqq3JY7M5ETvG8Zw3b1WdZ2NtUPOg7OBBsEssJV3Ryh9
         tfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TcCd9UdD12YUQPQywwnxXVJbwpLGFO7NzIVJx0qutZc=;
        b=C6Qx/Rcy0DHpDHnHWfr0MBE7nPfBUoDYMTX117EBYpqavtZnGflKchOTjOLABgqq81
         C4rM8xI7z9C+eISRhs9I5r7yp9xGT+WH5FEhyRghgLUEoBBFPdXMqLSnqCEf2rYZL5RR
         qjPH7wMDBZ5JH/+3PXr2N/0Tqn8SeS9VDsnoNoGXX4DL5dENkRBVPKISzsvNBX2MJB1P
         n4ZZ7pC1NWK3JL2ovu7VDt9b91pWTmkrkqIkgm+2+iey4Op6ogKdWNn6NZEiPouWt/gp
         9L1fpPu+r6uomiH7lwG0VIUpzUaINaG+QMZCIZ+QOgAqx8KfAiYMiyiuJRvAJxjHUDh1
         M1Kw==
X-Gm-Message-State: ANoB5pm3wZaAJSrGOpBRZSJ9PqH6FchMFN/U0PpW7OEkL7uRQwXZYahw
        Xf2N4/4gHGzlxYmPBytnP5g=
X-Google-Smtp-Source: AA0mqf4kcwjgS0846SELFxjn7F4V5DbMVJDBWi4zxHQaPARCloIrxOxX9HWupKGXjrFXK+qau3qFZw==
X-Received: by 2002:a63:e609:0:b0:458:cfe7:8dd with SMTP id g9-20020a63e609000000b00458cfe708ddmr25508277pgh.548.1669628425990;
        Mon, 28 Nov 2022 01:40:25 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001785fa792f4sm8298580plb.243.2022.11.28.01.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:40:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: [PATCH v3 00/11] Enhance credential helper protocol to include
 auth headers
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
        <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
Date:   Mon, 28 Nov 2022 18:40:25 +0900
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com> (Matthew
        John Cheetham via GitGitGadget's message of "Wed, 02 Nov 2022 22:09:18
        +0000")
Message-ID: <xmqq5yez76ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Testing these new additions, I introduce a new test helper test-http-server
> that acts as a frontend to git-http-backend; a mini HTTP server based
> heavily on git-daemon, with simple authentication configurable by command
> line args.

I did not try to figure out the reason but the topic with its tests
seem to break in 'seen' the linux-cmake-ctest CI job.

  https://github.com/git/git/actions/runs/3562942886/jobs/5985179202

but the same test does not break under usual "make test".

Can people who are interested in the cmake-ctest stuff take a look?

It is tempting to eject the ab/cmake-nix-and-ci topic that is
already in 'next', under the theory that what that topic does to the
tests "works" for some tests but not for others, and this topic is
an unfortunate collateral damage whose tests weren't something the
other topic did not support well.  If the cmake-ctest stuff is in
such a shape, then it may have been a bit premature to merge it
down.

Thanks.
