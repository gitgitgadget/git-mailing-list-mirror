Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiCKWss (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiCKWsO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:48:14 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7262B852E
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:23:03 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id g17so17469129lfh.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2qJ23nWvWZ9axeniJ605UeBMrAN+t3AkBKOWhdO/OZg=;
        b=lJMdr7WvZUz1h4uTI0Z0jFbl/j4ZjvQtRUmC2dMlTgznvrvRwn6N4uaQ2RB3f8PGvT
         5LPmoQ0L+VAUAUH8LL6aQLM+9D7Bxmc6VAH3JvRlfT4A6SVuTwqXLHFbZimD1OKYJJUb
         CbKWr9vCV8ZL5/ERqjBjbBh+ees0SItOK0cgxq35lL7H2ew8vBppYLQT7gwPLWQDKgu0
         8Yz2lAIO5y7/gg6KpYAmxJp4OueambRdPCZhif/stT5PTRnDoeWPFdXTmG1IjTk3v7Js
         V90LfoaULzbWd9SjB0CXNFxMfiD4J0mNs77gT7unZGLmOleoo4ozZkP4JWJWasWrofQG
         QU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2qJ23nWvWZ9axeniJ605UeBMrAN+t3AkBKOWhdO/OZg=;
        b=tvtDs7nOiEq1IoxPg/PjFoDet1NkU+wePPfHfP3k0GEPae69nGcgI/vllmtriyhtcR
         c6tUxwBkWGBYoQBEqO+5R1K/HPLHM8IT7lxRa6ItF2sfsCuRerjwIhUIMDeBf5ORQEtn
         orUn+sM5iljurvowvkLBDvLgwCFQXkqGEM5T9Utw0FhOMOEdT0vB+5ArDM2CB7hv0HKU
         gcKvmHGn6NDsiBX65tjUJ4lVcRl8w2TJZgRFcxmOSGDCJQ0s/SCd0C1uByavYl8z/y3F
         mEqUx8c4VBQZr7rEUllz5zZ4p0YBAEQ4T6uPeRxuImIwcouhs2xnh2cvppja+aZE7zGc
         xLyA==
X-Gm-Message-State: AOAM531SzoZZBFnwRA/+KjLZgk3CzP5RfnbqITXN4Gg3jAi3vVFKu6n3
        zjllHDNOaTw69Wz/QgQlc67DA1CyyhQ=
X-Google-Smtp-Source: ABdhPJypzZPvzwpgxwkAG73h7luvM2wXqBNWt50LVMHFwFES32eEhghewh8sOnrq7boJNYYjAZHy5w==
X-Received: by 2002:a5d:4d8b:0:b0:1f0:61f2:73d2 with SMTP id b11-20020a5d4d8b000000b001f061f273d2mr8326135wru.15.1647033304392;
        Fri, 11 Mar 2022 13:15:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 186-20020a1c19c3000000b0038990c0925fsm12191985wmz.14.2022.03.11.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:04 -0800 (PST)
Message-Id: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:47 +0000
Subject: [PATCH 00/16] Builtin FSMonitor Part 2.5
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm calling this series part 2.5. It should be inserted between parts 2 and
3. I'll send a new version of part 3 after I send part 2.5.

This series is a bunch of "fixup!" commits for part 2. It addresses feedback
on part 2 that wasn't received until after part 2 had graduated to "next".

I was originally planning to include them at the beginning of part 3, but
since there are so many, I thought it would be easier to add a fixup series
in the middle. (And since GGG has a limit of 30 commits, I couldn't add them
to either existing series without going over the limit.)

Most of the commits deal with translation markings for die/error messages
and fixing && chains in the tests. And there were a few readability
improvements.

Jeff Hostetler (16):
  t/test-lib: avoid using git on LHS of pipe
  update-index: convert advise() messages back to warning()
  compat/fsmonitor/fsm-listen-darwin: split out GCC-specific
    declarations
  t/helper/fsmonitor-client: cleanup call to parse_options()
  fsmonitor--daemon: refactor cookie handling for readability
  t/perf/p7519: use grep rather than egrep in test
  t/perf/p7519: cleanup coding style
  t7527: add parameters to start_daemon to handle args and subshell
  t7527: fix && chaining in matrix_try()
  t7527: delete unused verify_status() function
  fsmonitor-ipc: add _() to calls to die()
  compat/fsmonitor/fsm-listen-darwin: add _() to calls to error()
  compat/fsmonitor/fsm-listen-win32: add _() to calls to error()
  fsmonitor--daemon: add _() to calls to die()
  fsmonitor--daemon: add _() to calls to error()
  fsmonitor-settings: simplify initialization of settings data

 builtin/fsmonitor--daemon.c          |  63 ++++----
 builtin/update-index.c               |  12 +-
 compat/fsmonitor/fsm-darwin-gcc.h    |  92 +++++++++++
 compat/fsmonitor/fsm-listen-darwin.c |  95 +----------
 compat/fsmonitor/fsm-listen-win32.c  |   6 +-
 fsmonitor-ipc.c                      |   4 +-
 fsmonitor-settings.c                 |   3 +-
 t/helper/test-fsmonitor-client.c     |  17 +-
 t/perf/p7519-fsmonitor.sh            |  23 +--
 t/t7527-builtin-fsmonitor.sh         | 233 +++++++++++++--------------
 t/test-lib.sh                        |   3 +-
 11 files changed, 276 insertions(+), 275 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-darwin-gcc.h


base-commit: 1a9241e1fee9d418e436849853f031329e792192
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1174%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2.5-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1174/jeffhostetler/builtin-fsmonitor-part2.5-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1174
-- 
gitgitgadget
