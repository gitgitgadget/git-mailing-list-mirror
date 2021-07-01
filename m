Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509AEC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38122613FD
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 13:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhGANvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhGANvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 09:51:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712A0C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 06:48:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so8579971eds.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Pd8TnySGfEQesi9JMX8hJ5HYjd//Q4NDTQt5QahJHZ4=;
        b=MFZkjOiCaFVQHHnXxCasGupDywiqPbm37LFVmqrQf7suCregl2VW0xVny4i/Q/NyBI
         sbY8fXA5fJeHM3t/8AZMEKJZfmBhBICuH8qVYzxMCgu7f7kaGSCdnTo+WhtmiM2L/ApO
         uaD23skSSKjTcXh14h/aigd3LoriZzIV8YKbFlI8bIxKE3wmHp0DYVhib7czf1RVkHeI
         qfYtSl6VS8JsOkVw3kFzJwS+cwf7DanIz0Z8rB8ei2ZRqsIrXeMDLwZwu14KrTNlmZv1
         k2JDdS9w3CvBiM8CVK2ig0onLIIoumdKU1Eoc+ixO/tktOQCeuRkPfaNB126omtqbFuJ
         1qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Pd8TnySGfEQesi9JMX8hJ5HYjd//Q4NDTQt5QahJHZ4=;
        b=nSZjZvwmjHqokNG1qNJcWA3GnuzJ3+cxoRfNMxlb/Bsfq7eUhJYbqW+OsLCxisFXnd
         p+hvHt7qO3JNvJC0QX9KgM9v7/EWRkmbaOisfUJIOLhJ+ZFXaMkV4HJoHmB2jurSi12H
         YuuiYo8Yne9gim6i4JJCO3BNt4fW7dGJe5ilDiLmLWnBeEzFmA+ZN8JtCo/ArGi5vnt8
         rpmk8BR+o3vNJoCU7Scb5cppJvm68FCbIsHtI/h6Y0AXw3qUz70HVbyorumdWauPIh1Y
         tbEeBP2TPrF6CjY/DQ35l8pMQofwTesZ5rBc3AbxdLAVgZ+u8QtI8mK9J4QAFvvUcEkZ
         mSZA==
X-Gm-Message-State: AOAM530Z9/RemKpuP/qi14mwxQ2fFhr93obSLOaMrHiM5IfeeSAS92AW
        mk1Xlq2yJBVY/6BEkG+hq2g=
X-Google-Smtp-Source: ABdhPJz4pLV5Onf4MdBdo5WiwFGOGU1bp0sL0D2pBi2GCjlsadNLfLQvrILhYuO8bnH6m8tPi617jQ==
X-Received: by 2002:a05:6402:458:: with SMTP id p24mr28489599edw.142.1625147307851;
        Thu, 01 Jul 2021 06:48:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n22sm2560705eje.3.2021.07.01.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 06:48:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Date:   Thu, 01 Jul 2021 15:42:23 +0200
References: <xmqq4kdft122.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq4kdft122.fsf@gitster.g>
Message-ID: <87r1gicfh1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, Junio C Hamano wrote:

> * jh/builtin-fsmonitor (2021-05-24) 30 commits
>  - t/perf: avoid copying builtin fsmonitor files into test repo
>  - t7527: test status with untracked-cache and fsmonitor--daemon
>  - p7519: add fsmonitor--daemon
>  - t7527: create test for fsmonitor--daemon
>  - fsmonitor: force update index after large responses
>  - fsmonitor: enhance existing comments
>  - fsmonitor--daemon: use a cookie file to sync with file system
>  - fsmonitor--daemon: periodically truncate list of modified files
>  - fsmonitor--daemon: implement handle_client callback
>  - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
>  - fsmonitor-fs-listen-macos: add macos header files for FSEvent
>  - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
>  - fsmonitor--daemon: create token-based changed path cache
>  - fsmonitor--daemon: define token-ids
>  - fsmonitor--daemon: add pathname classification
>  - fsmonitor--daemon: implement daemon command options
>  - fsmonitor-fs-listen-macos: stub in backend for MacOS
>  - fsmonitor-fs-listen-win32: stub in backend for Windows
>  - t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
>  - fsmonitor--daemon: implement client command options
>  - fsmonitor--daemon: add a built-in fsmonitor daemon
>  - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
>  - config: FSMonitor is repository-specific
>  - help: include fsmonitor--daemon feature flag in version info
>  - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>  - fsmonitor--daemon: update fsmonitor documentation
>  - fsmonitor--daemon: man page
>  - simple-ipc: preparations for supporting binary messages.
>  - Merge branch 'jk/perf-in-worktrees' into HEAD
>  - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor
>
>  An attempt to write and ship with a watchman equivalent tailored
>  for our use.
>
>  What's the status of this one?

I think Johannes's reply to the last WC applies[1]:

    I am not Jeff, but I know that he is busy getting back to it, and
    plans on submitting a third iteration.

FWIW I'm still curious about some details on the performance concerns
that seem to have prompted this built-in fsmonitor endeavor, as I asked
about (but didn't get a reply to) in [2].

Not as a "we shouldn't have this, let's keep using the hook", but just
curiosity about why we've seemingly gotten such different performance
numbers on the watchman hook v.s. a built-in approach.

I suspect (but don't know) that the reason is that the built-in is
perhaps integrating differently with git somehow, in a way that we could
retrofit the hook approach to also do (if anyone still cares about the
hook approach).

In any case I'm interested in *why* the new approach is faster, given
that I've done some testing (again, noted in [2]) that suggest that
bottleneck in the previous pipeline wasn't at all what Jeff H. thought
it was.

1. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2106171135530.57@tvgsbejvaqbjf.bet/#t
2. https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/
