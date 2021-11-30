Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA11CC433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbhK3VTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhK3VTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:19:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A1C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:16:04 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so92207294eda.11
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=h/9+SgFfjIklqjZ2y56buJsm1QH6P0AVbWso60ZgpWA=;
        b=plyZlGEmHDHdlWFXVc88agR4p0DTuNhrfePl90yP0hlMDVhY9cf/hbTKaTAYIhvCqE
         PQzz8NU8OOCDqAXdqr8yQtaYDmSKYdzm8VRLWXiWUYEOIgUXRE7yygzjyjN7QnEzzrzA
         PA/wSWB6s41dMP4OHF7LTbZfcYGHKMgVnpsUedNxgQrFHSeP5Wu27yv+hV8OkWR67qlt
         2E9RRrQf15RuQUa5C0JT1uOGTuTqFXIWxIv9liUvJmUCQgXj6CHjtv1afTUPTnPz7juo
         8Seij+ER/cDx+Hg8OZ6aGM1MLDteH7f/YIe0vMiKjcm4FoE7158040b0xX8NDwvZ5dl7
         Qnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=h/9+SgFfjIklqjZ2y56buJsm1QH6P0AVbWso60ZgpWA=;
        b=bQLgVpCvYdUCtK7NycrMd4lWcTPzzgYKwfugwwl5PGFqJTe3KZVOOzH6/DVptwoLY9
         sltDm3YIoRutdeXRxHjCmxYBKjQq0I6JWd91ZhLL6NGo0pevmJn15459GrO8IpBXBmaP
         pATL+eq2f36g9l061JG+V2kYV6oxXopKJ5qkfkApPc8UHOArZU3C6l20I/XRyEEQ9qb1
         QbhNVgYuCeZRFdB1q6zfNcYBl78qPoxmEf+5jSptMlWcvb1KBum0lmkx+8tNtpgr5hXo
         ah3CQQbSM0boJhgzFJaYsc0d9cF4bKDNV22dToy/yB9CUoBWp5HpuMDb41HWeDeJTyb+
         Nipw==
X-Gm-Message-State: AOAM5318INoEYtm/QO1pWwltlDfNwLUDy3UTF0AZaLtLneIn8h9QPds6
        0VmHvul/ZvZzQYkUWryzGwd1l/fBfJ4=
X-Google-Smtp-Source: ABdhPJyl5G3hGfzT7qKwlapfVodj/LdfmSfaTBOJJeDnj8SsMAfzsRwD3BWoHxzA/XP9dstqq5U7Gw==
X-Received: by 2002:aa7:d997:: with SMTP id u23mr2300442eds.164.1638306963196;
        Tue, 30 Nov 2021 13:16:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q7sm11799646edr.9.2021.11.30.13.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:16:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msATq-001A64-BL;
        Tue, 30 Nov 2021 22:16:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: ab/config-based-hooks-2 (was: What's cooking in git.git (Nov 2021,
 #07; Mon, 29))
Date:   Tue, 30 Nov 2021 22:12:23 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqzgpm2xrd.fsf@gitster.g>
Message-ID: <211130.86bl21cpkd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Junio C Hamano wrote:

> * ab/config-based-hooks-2 (2021-11-24) 18 commits
>  - run-command: remove old run_hook_{le,ve}() hook API
>  - receive-pack: convert push-to-checkout hook to hook.h
>  - read-cache: convert post-index-change to use hook.h
>  - commit: convert {pre-commit,prepare-commit-msg} hook to hook.h
>  - git-p4: use 'git hook' to run hooks
>  - send-email: use 'git hook run' for 'sendemail-validate'
>  - git hook run: add an --ignore-missing flag
>  - hooks: convert worktree 'post-checkout' hook to hook library
>  - hooks: convert non-worktree 'post-checkout' hook to hook library
>  - merge: convert post-merge to use hook.h
>  - am: convert applypatch-msg to use hook.h
>  - rebase: convert pre-rebase to use hook.h
>  - hook API: add a run_hooks_l() wrapper
>  - am: convert {pre,post}-applypatch to use hook.h
>  - gc: use hook library for pre-auto-gc hook
>  - hook API: add a run_hooks() wrapper
>  - hook: add 'run' subcommand
>  - Merge branch 'ab/config-based-hooks-1' into ab/config-based-hooks-2
>
>  More "config-based hooks".

I know Emily's keen to get to the conclusion of the "config-based-hooks"
story. I think it's gotten a lot of careful review already, and it would
be nice to have it land soon in this cycle so the follow-up topics can
be queued after it.

I re-rolled it a ~week ago[1], but that was a trivial change to save you
from dealing with a compilation error as it got merged with my own
"ab/run-command" (it was using "env", not "env_array")[1]. Other than
that there's been no change to it for the last month since the v4[2].

1. https://lore.kernel.org/git/cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com/
