Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA46C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62BB6112F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbhIGTpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhIGTpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:45:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85349C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:44:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k4so172767lfj.7
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erMu1/jVmUsKdecBH/pLeSCZZRueA4dd8V5G5Ptyl+w=;
        b=N7OUWjfEIk+gcXKQVpMf9+lKImDx+pdIO01dre+ev1njJv6jIj++3lCdAq7PPgs7nV
         wI6fmY6wzb8PIBPffnuYllSykvPu8AusdTgp+ydR1WjVdK+F1w4GvRLurGK8XOvyfv7I
         6mNYJRomAtAUP6HufmhnWRGdc7oMSHyFGyqG1T7crlHhkcE8qVFotcQiZD7WyZyEb7Gh
         GzwZPcj66PpHAzFch93/NeJC2NRV60sUFT6kjRh2oiM3RoQRKKMAplIplndJbKJ9q7Po
         Pp60zeBJy39LT2CNA7v+Fs1suIEzwklLzIA0Etw/JrJI8gAz7NQdyPO45V82pcaUHnCV
         j37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erMu1/jVmUsKdecBH/pLeSCZZRueA4dd8V5G5Ptyl+w=;
        b=DMLCrVmtkFYfZc7t/75STjP+Xe8YhbjTYyhicYz2Ri/6VcIb4rRmQgMLy/e3HmBivS
         prJtcNuByW/arteBxtJhmX6QIITftwmildiLTRFmCUP30BfdBPAua5GlU43tHwU6PkPl
         IeBS0XTegHy4qJAw/wHl2XSTzH2zGGcYgANGYAnVp+1DssAdJkPc9CuirfgzbFXwq0wW
         lp/XT7WuB+p1X5kO2Ibm8eqIud5APrQMT1P9/H4RRt5G41/FekNfqSsM0yvLObkEz4Ss
         J6B44ajoowd6aB0SoITCjDA5JnCUj8HXTpNxgvGl+EFFQJ33hVOWNKVP9GfNWoK6BkQE
         Xdww==
X-Gm-Message-State: AOAM5313fy939HqOmSrbFZxPfLcf93eUPunxuHKNB2xyMoijzuPQ6x3U
        sHbqhJW8ujD2lxOIJ0qeB9y8QdVwkbw2SSMatTA=
X-Google-Smtp-Source: ABdhPJw32/ik0ABOVPYFUuq1WINWCDEVHyLT+3w7Lby7cYxJFVoT/k0qnozhpI+7pqm5e+G/ZsY/kWgUF0LvzjiENA4=
X-Received: by 2002:a05:6512:2349:: with SMTP id p9mr50296lfu.558.1631043862837;
 Tue, 07 Sep 2021 12:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com> <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Sep 2021 12:44:13 -0700
Message-ID: <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for core.fsyncObjectFiles
To:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks to everyone for review so far! I've responded to the previous
> feedback and changed the patch series a bit.
>
> Changes since v1:
>
>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Contrary
>    to dscho's suggestion, I'm still implementing the Windows version in the
>    same patch and I'm not doing autoconf detection since this is a POSIX
>    function.
>
>  * Introduce a separate preparatory patch to the bulk-checkin infrastructure
>    to separate the 'plugged' variable and rename the 'state' variable, as
>    suggested by dscho.
>
>  * Add performance numbers to the commit message of the main bulk fsync
>    patch, as suggested by dscho.
>
>  * Add a comment about the non-thread-safety of the bulk-checkin
>    infrastructure, as suggested by avarab.
>
>  * Rename the experimental mode to core.fsyncobjectfiles=batch, as suggested
>    by dscho and avarab and others.
>
>  * Add more details to Documentation/config/core.txt about the various
>    settings and their intended effects, as suggested by avarab.
>
>  * Switch to the string-list API to hold the rename state, as suggested by
>    avarab.
>
>  * Create a separate update-index patch to use bulk-checkin as suggested by
>    dscho.
>
>  * Add Windows support in the upstream git. This is done in a way that
>    should not conflict with git-for-windows.
>
>  * Add new performance tests that shows the delta based on fsync mode.
>
> NOTE: Based on Christoph Hellwig's comments, the 'batch' mode is not correct
> on Linux, since sync_file_range does not provide data integrity guarantees.
> There is currently no kernel interface suitable to achieve disk flush
> batching as is, but he suggested that he might implement a 'syncfs' variant
> on top of this patchset. This code is still useful on macOS and Windows, and
> the config documentation makes that clear.
>
> Neeraj Singh (6):
>   object-file: use futimens rather than utime
>   bulk-checkin: rename 'state' variable and separate 'plugged' boolean
>   core.fsyncobjectfiles: batched disk flushes
>   core.fsyncobjectfiles: add windows support for batch mode
>   update-index: use the bulk-checkin infrastructure
>   core.fsyncobjectfiles: performance tests for add and stash
>
>  Documentation/config/core.txt       | 26 ++++++--
>  Makefile                            |  6 ++
>  builtin/add.c                       |  3 +-
>  builtin/update-index.c              |  3 +
>  bulk-checkin.c                      | 92 +++++++++++++++++++++++++----
>  bulk-checkin.h                      |  4 +-
>  cache.h                             |  8 ++-
>  compat/mingw.c                      | 53 +++++++++++------
>  compat/mingw.h                      |  5 ++
>  compat/win32/flush.c                | 29 +++++++++
>  config.c                            |  8 ++-
>  config.mak.uname                    |  4 ++
>  configure.ac                        |  8 +++
>  contrib/buildsystems/CMakeLists.txt |  3 +-
>  environment.c                       |  2 +-
>  git-compat-util.h                   |  7 +++
>  object-file.c                       | 23 ++------
>  t/perf/lib-unique-files.sh          | 32 ++++++++++
>  t/perf/p3700-add.sh                 | 43 ++++++++++++++
>  t/perf/p3900-stash.sh               | 46 +++++++++++++++
>  wrapper.c                           | 40 +++++++++++++
>  write-or-die.c                      |  2 +-
>  22 files changed, 389 insertions(+), 58 deletions(-)
>  create mode 100644 compat/win32/flush.c
>  create mode 100644 t/perf/lib-unique-files.sh
>  create mode 100755 t/perf/p3700-add.sh
>  create mode 100755 t/perf/p3900-stash.sh
>
>
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v2
> Pull-Request: https://github.com/git/git/pull/1076

Hello everyone,
I'd like to bump this review up in people's inboxes since Patch V2
hasn't gotten any traction in over a week.

Thanks in advance for taking a look,
- Neeraj Singh
Windows Core Filesystems Team
