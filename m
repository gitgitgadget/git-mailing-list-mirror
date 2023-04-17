Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A823C77B70
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 07:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjDQHEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDQHEi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 03:04:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88AB7
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 00:04:37 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7606d6bb669so46843339f.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681715076; x=1684307076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl96F+pjRT62fDu1bIrqG7b+q6Jz9RsBgcFcnEX+Ik0=;
        b=kuXixF2mXtg1kImV6YqGhtg0AOzQYBHrda80+U/dwy2d2IejZDmU3jqWaZvpOXjk6V
         LWEkx/Lv9mTfHpnrvIvRj5n3y9eRJrdatlsATVJ8AXJwKmnUXcQtr8/68szcxRRhDKMH
         90tHgk0wEAzShm6y0iYV5lgv8R5O70214NZQw15CYZRzw0tUFKki6R2A8lgZz8elMxW9
         UsqVe97ZXMdx8fzxKsJB5mibwlK1ko1PRmc6tkMgQ+L9i8YywyWMd9abBhulz8FiJnaL
         33VAjWuG3iZyz4yfTwGIP6+BWW3iZ5QEg9aPYfAyncAPOUEuaZHZUIEHq2zcrcQyUcI+
         lUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715076; x=1684307076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tl96F+pjRT62fDu1bIrqG7b+q6Jz9RsBgcFcnEX+Ik0=;
        b=RPD/r8BZ6L4TMfT0v9MllyG/MicpN08rOlVY9Cr8FdcGeKw/Os4HysEbqAFHUyDJWK
         4A+Fbo4R7QraK7c+Bwuhr5evsmOCRN9iJ5lFGz8O17I/R7YRMgVbSN+p3bWr58LoO26/
         tc54Ycuh9zCQTW/y7fSrxwbT/i4hl49zc60dV4ON7sBTQSPBX972xp3pQh4QfPzeaLDb
         4Eb8VfY9p0ftjENF5TFilc5E64xjtrOQAtCgDdfWXU5ZTlBUYNMngKaWObk/GTDvS8XV
         hwmWcLqMCB0GYSMO7cVzJJOyEua8C9LhUBg9e7j19doQU5ricEyTHnl0WRkNcRPFywgP
         Affg==
X-Gm-Message-State: AAQBX9eH6Pkq8Hw/9g0OM7pcDFcqCCCX9y2vjH9Gsy/2oPz5zaZptmvJ
        pEZ2x68aDKO2t2yiGhkg+ivfWlpINXy9QhBhE+o=
X-Google-Smtp-Source: AKy350ajjtqGBZL7xOcFWFXQf5auVXgtAwqJny6+RDAL+an0yvboRPAjnTFXtZDQ/1DNmuTWYTefH46uFy97sXu/PkQ=
X-Received: by 2002:a92:c842:0:b0:32b:2f04:140f with SMTP id
 b2-20020a92c842000000b0032b2f04140fmr355159ilq.5.1681715076613; Mon, 17 Apr
 2023 00:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com> <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
 <xmqqk03jcwxz.fsf@gitster.g>
In-Reply-To: <xmqqk03jcwxz.fsf@gitster.g>
From:   Samuel Ferencik <sferencik@gmail.com>
Date:   Mon, 17 Apr 2023 09:04:25 +0200
Message-ID: <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
>>> system name, i.e. the output of `uname -s`.

The discussion about https://github.com/gitgitgadget/git/pull/1429 seems to
have stalled on several points. I'll try to summarise; let's see if we can move
forward.

(I am the reporter of https://github.com/git-for-windows/git/issues/4125, which
led to this PR. I am vested in making progress here.)

1. name of the setting (`os` vs `uname-s` vs `sysname`)
   * dscho@ suggested `os`; Phillip and Philip suggested `uname-s` and
     `sysname`, respectively
   * I vote for `os`; I'm afraid perfect is the enemy of good here as
     * `man uname` says `-s` gives "the name of the operating system
       implementation"; no other `uname` switch comes closer to whatever
       concept "OS" represents
     * this is also correct on Windows (the "Windows" string) - see below
     * I find it extremely unlikely a future unforeseen git feature would have
       a better use for `includeIf os` (in parallel with `includeIf sysname`),
       i.e. I don't worry that we're squatting on a good name for a poor
       use-case
2. casing (use of `/i`)
   * dscho@ implemented case-insensitive comparison but without test coverage,
     documentation, and it's inconsistent with the other `includeIf` options
     that support the `/i` switch.
   * I propose that we compare case-sensitively because
     * no user can reasonably complain about this if the documentation is
       clear; the OS names are definitive and stable and it's not a big deal
       getting the case right for "Linux"
     * without the case insensitivity being documented, the users who [discover
       the insensitivity and] rely on it are risking breakage; plus the git
       maintainers are exposing themselves to the effects of Hyrum's law
       (https://xkcd.com/1172) - it's a disservice for both sides
     * this still allows us to add support for `/i` later (should a use-case
       emerge)
     * it is consistent with the other settings
     * it requires less code (incl. tests) and shorter documentation
3. handling Windows (MinGW, WSL)
   * As implemented currently, `includeIf "os:Windows"` would work in
     git-for-Windows. I think that's desirable, and no-one suggested otherwise.
   * In contrast, Philip points out `includeIf "os:Linux"` would be the way to
     match on WSL. Is that an issue? Do we want WSL to match "os:Windows" or
     "os:WSL"? As a Windows user, when I switch to WSL I do expect a "proper"
     Linux experience (unlike when I run "Git bash" on Windows, which is more
     like a port of utilities, but still Windows). I think this treating WLS as
     Linux is OK-ish, and we may get away with not discerning WSL. Thoughts?
4. documentation (w.r.t. the details in 1. - 3.)
   * We should document all of 1. - 3. I'm happy to give it a go if we can
     reach consensus.
   * Specifically, the documentation should mention that the OS string equals
     "Windows" in Git-for-Windows, and `$(uname -s)` otherwise; it should list
     examples, incl. "Linux" and "Darwin"; it should mention the case
     sensitivity.
5. tests (potential segfaults)
   * Johannes points out the tests hide segfaults. I haven't looked at this
     closely but hopefully Johannes's suggestion ("use test_cmp or
     test_cmp_config") is a clear enough pointer. I can try to fix this.
6. what's the use-case?
   * As the reporter of https://github.com/git-for-windows/git/issues/4125,
     here are my use-cases, i.e. settings that I currently set conditionally
     per OS (using `includeIf gitdir`):
     * different `difftool.path`, `mergetool.path` per OS (e.g. paths
       containing `C:\Program Files\...\...exe` vs Unix file paths)
     * different `merge.tool` per OS (I have a BeyondCompare license for Linux
       only)
     * different `core.autocrlf`: `true` on Windows, `input` otherwise
     * `core.whitespace` set to `cr-at-eol` on Windows
     * `core.editor` set to `gvim` on Windows
   * Note all of the use-cases above would cope with WSL reporting "Linux",
     except of `merge.tool`.

I hope this revives the discussion; I know it's been a while but I would
appreciate your input. If possible, please refer to the numbered points (1 - 6)
for clarity.

I'm happy to iterate on dscho@'s PR if we can reach consensus.


On Fri, 14 Apr 2023 at 01:44, Junio C Hamano <gitster@pobox.com> wrote:
>
> Philip Oakley <philipoakley@iee.email> writes:
>
> >> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
> >> system name, i.e. the output of `uname -s`.
> >
> > This `uname -s` doesn't work well on Git-for-Windows (GfW) / Windows
> > because GfW has its own internal compatibility code to spoof the result.
> > ...
> > Or just drop the mentions of "<uname-s>" in this commit message and
> > rename it 'sysname' to match the field of the struct utsname?
>
> FWIW I do not mind "sysname".  It is much better to say
>
>         [includeIf "sysname:Linux"] path = ...
>
> than "os:Linux", as "sysname" informs us the granularity used to
> identify the system better than "os".
>
>
>
