Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E37C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99FF60F46
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhKATcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhKATcb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:32:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AB6C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:29:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w15so67995164edc.9
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LDGsSfkI4LEpqrI7AZItTsLdFiQ39/QGxeSE/0Fvy7k=;
        b=KVtzjlMO2EG9IoMr6RK1MJbKUwe9AY7WNSeze9cr8yoyhxe6c3IS8pu7r48mH/riW0
         MLkWamK3AyYsRFasrCnkgL39NIWM1Gruyeh2fLb0cgcAbHuOi5AtkmsVzHZZwwsfSEEp
         sdiuSwIetYrfPtKBxLtK2JTN+KWig0LhO8n8L5cqbajRy3r5c0feUh6qeZ8aaSVXjXVQ
         vtmdWgFzfB4ru4e9EOZAUKS8Puj4hRiG4LYu58GnN/hT2KWkF44h3SZ1UBTKTt0P6KRS
         moGxTIepTfIWi6koFOikaob2bsqUH5BEaLBXRsnPnT9Y0T4+16ypb+GuPjn2c0ynEcB2
         Xh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LDGsSfkI4LEpqrI7AZItTsLdFiQ39/QGxeSE/0Fvy7k=;
        b=NfRzjJQpuTVi/rAv+F6mHN95/ghoEmkCKU1iXfX4JNqyLG+lbrAsPnRVfrDCT8sk8e
         5dNhXwqhAPsUv4ouP3mJQFL/cpIpvB4IGD5NSTZcLUJtuKsIwoCuIy9vnrvU1Uwc9plL
         QRFtsBHL+bRBGYskDWxV1rYhvqQWSnSObetL10Guv5ApcyyD0ma0NObg4iQoYjW/XqFI
         F5OhL579tof9CPYjmUoVKmYF7Khf3lWsXYi8ZciLDXp5NV7lanITWAiqyATCeP/Y7Idq
         v9YTsMFr7NvReJLnfuNf3YG1qBhXZ1EExkddDHuBnVtg5qHAf3/sEWzI+6UYFgi6JeL1
         oyBQ==
X-Gm-Message-State: AOAM533126o+/Ej08lFaf4xYaC+P7qb/Awm5nQQE/Cl3wjc9YhaD5FSn
        w1R++5mzR3Elk1uQIozbfYs=
X-Google-Smtp-Source: ABdhPJyiURPGuoMfKQoUOq9fx5ikQzgmXN6SXxkcaCTI0WzmzVrWZkxi6DKr8NbNWmgls/NmNd6ssQ==
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr39957612eje.341.1635794996155;
        Mon, 01 Nov 2021 12:29:56 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ht20sm7461995ejc.97.2021.11.01.12.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:29:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mhd0F-002Bfn-Cx;
        Mon, 01 Nov 2021 20:29:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: ab/only-single-progress-at-once (was: What's cooking in git.git
 (Oct 2021, #07; Fri, 29))
Date:   Mon, 01 Nov 2021 20:27:25 +0100
References: <xmqqr1c3e57a.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqr1c3e57a.fsf@gitster.g>
Message-ID: <211101.86wnlr3c98.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 29 2021, Junio C Hamano wrote:

> * ab/only-single-progress-at-once (2021-10-27) 8 commits
>  - progress.c: add & assert a "global_progress" variable
>  - various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
>  - pack-bitmap-write.c: don't return without stop_progress()
>  - progress.c: add temporary variable from progress struct
>  - progress.c tests: test some invalid usage
>  - progress.c tests: make start/stop commands on stdin
>  - progress.c test helper: add missing braces
>  - leak tests: fix a memory leaks in "test-progress" helper
>
>  Further tweaks on progress API.
>
>  Correction of the course may be required?
>  cf. <211025.8635opi8om.gmgdl@evledraar.gmail.com>
>  cf. <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>

Re-rolled a v5 to address that discussion:
https://lore.kernel.org/git/cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com/

Per the re-roll the discussion doesn't directly affect this series, it
was on a part of the commit message that's musing about some WIP/POC
code I wrote, and which might use the new interface added in 8/8 in the
future.

In any case, I updated the commit message to note the potential issues
with that WIP code that were raised.

But as far as this progressing (aside from the rc period & all that) I
don't see why it should be blocked on that.
