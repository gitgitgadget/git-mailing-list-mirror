Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8B4C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbiEZVtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiEZVtG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608160C9
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so3696330wrc.0
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cMUdbXNk105KsFz3ylqaJRxzsyCSvZy2oM9y02SnAPQ=;
        b=HSo/avmiTJTHUTzL0PhmTMD2VHubnGfK3gT/T/lUivPdpWDuABkTZ3NFTaBBCr4mLa
         TFBYSNiz7DkG0QKxszH/zfb5xk60mLRekmRDsUgDrsV7z3GyqvnJlh9G5gsTT2PuoV75
         MOIidbgrnukw0lLfWht+No+xVYwUAo0SN+SOnjldIa9Wm1SLUS4JFbYv4pTZ9+eMlJ4A
         a0rM8kA3qM0pzIfgz9Rx35vBoC5UbVpRTfZrrgEXN/nzBdXTkAda1FBL0ljDSwcgX1zx
         XA5prlaXeJxPVR/VSMDdfKQJccUJ2P6sFEOTTGxkRQWOlAXUiQxMU6NEi9ZcmrulXiMj
         s1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cMUdbXNk105KsFz3ylqaJRxzsyCSvZy2oM9y02SnAPQ=;
        b=xDKkWcHn6rDOZ74Hw+xOPrPpWvsk6qT6bVmOkPV03etUJhCBKeKqv55KqjSjYRF3D1
         VzJCZ9FjmfZCR6xQIwBvrUNPocwSE6dDVY41z8I4Xa4Q22RfUFag9XPsWmqIlxwmvkxp
         OnMS/uRSaNvdO7meQDR43DwDTmNQy7EFj0kEUmmVYVfuO0eEloHKmUhTkFK6dv8usm5Y
         hnGmTge/IBN1ct16JPD6I7LLJIddZcrElcVklKiHO1XI7BuAD6hBFAnU3PPeendczAVx
         bjhJl7wp/NsyXEiMQhmHggq8yn9MS53x0Bw5vJ8GdB9nKU+I/7rHQAaoOBbta6ZQh9ZS
         jAAQ==
X-Gm-Message-State: AOAM533gVJEuYNC5iuhR/UMuTWUQD9LwHpxSIGknXHId6uMEJeQuuIgT
        uBWwpwnyAUWMAn47cty0i4tkP/gczbA=
X-Google-Smtp-Source: ABdhPJylCm1rQzkZaK1+sYBQAwkCv5YthH0O8aXtirRUno/pjbW++jVQkSaYX1966+Nnve7tRNAiOg==
X-Received: by 2002:a5d:5984:0:b0:20f:dad8:7b6a with SMTP id n4-20020a5d5984000000b0020fdad87b6amr19432265wri.207.1653601738388;
        Thu, 26 May 2022 14:48:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020a0560001b0200b0020ffb018d21sm174477wrz.110.2022.05.26.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:47:59 -0700 (PDT)
Message-Id: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:46:54 +0000
Subject: [PATCH v9 00/30] Builtin FSMonitor Part 3
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 9 of part 3 of FSMonitor.

This version addresses the test failure on t7527.[56] when deleting/renaming
the .git directory using the "GIT~1" spelling. Between v6 and v7, I changed
the way check_for_shortnames() constructed the wchar_t path to .git from a
pair of wcscpy() calls to a swprintf() call. However, I used a "%s" by
mistake rather than a "%ls".

This caused a non-portable behavior. The tests passed with MSVC and with GCC
10.1.0 on my laptop, but failed under GCC on one of the CI build machines.

This was partially hidden by CI machines that have GCC 12 and that fail to
compile Git without the fixes for GCC 12.x.

Jeff Hostetler (30):
  fsm-listen-win32: handle shortnames
  t7527: test FSMonitor on repos with Unicode root paths
  t/helper/fsmonitor-client: create stress test
  fsmonitor-settings: bare repos are incompatible with FSMonitor
  fsmonitor-settings: stub in Win32-specific incompatibility checking
  fsmonitor-settings: VFS for Git virtual repos are incompatible
  fsmonitor-settings: stub in macOS-specific incompatibility checking
  fsmonitor-settings: remote repos on macOS are incompatible
  fsmonitor-settings: remote repos on Windows are incompatible
  fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
  unpack-trees: initialize fsmonitor_has_run_once in o->result
  fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
  fsmonitor--daemon: cd out of worktree root
  fsmonitor--daemon: prepare for adding health thread
  fsmonitor--daemon: rename listener thread related variables
  fsmonitor--daemon: stub in health thread
  fsm-health-win32: add polling framework to monitor daemon health
  fsm-health-win32: force shutdown daemon if worktree root moves
  fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
  fsmonitor: optimize processing of directory events
  t7527: FSMonitor tests for directory moves
  t/perf/p7527: add perf test for builtin FSMonitor
  fsmonitor: never set CE_FSMONITOR_VALID on submodules
  t7527: test FSMonitor on case insensitive+preserving file system
  fsmonitor: on macOS also emit NFC spelling for NFD pathname
  t/helper/hexdump: add helper to print hexdump of stdin
  t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  t7527: test Unicode NFC/NFD handling on MacOS
  fsmonitor--daemon: allow --super-prefix argument
  t7527: improve implicit shutdown testing in fsmonitor--daemon

 Makefile                               |  20 +-
 builtin/fsmonitor--daemon.c            | 116 ++++++-
 builtin/update-index.c                 |  16 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 278 ++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   | 122 ++++++-
 compat/fsmonitor/fsm-listen-win32.c    | 436 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  89 +++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 ++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   | 167 ++++++++--
 fsmonitor-settings.h                   |  33 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 git.c                                  |   2 +-
 t/helper/test-fsmonitor-client.c       | 106 ++++++
 t/helper/test-hexdump.c                |  30 ++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/lib-unicode-nfc-nfd.sh               | 162 +++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 401 ++++++++++++++++++++++-
 unpack-trees.c                         |   1 +
 28 files changed, 2439 insertions(+), 149 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100644 t/helper/test-hexdump.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: 5eb696daba2fe108d4d9ba2ccf4b357447ef9946
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v8:

  1:  26144c58659 !  1:  9353e5863dc fsm-listen-win32: handle shortnames
     @@ compat/fsmonitor/fsm-listen-win32.c: normalize:
      +	wchar_t *p;
      +
      +	/* build L"<wt-root-path>/.git" */
     -+	swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%s.git",
     ++	swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%ls.git",
      +		 watch->wpath_longname);
      +
      +	if (!GetShortPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out)))
  2:  1bf2e36b6ad =  2:  2ae8a02ebe0 t7527: test FSMonitor on repos with Unicode root paths
  3:  4bca494bb22 =  3:  6f8baf5b723 t/helper/fsmonitor-client: create stress test
  4:  663deabc3f6 =  4:  195f90cc9ef fsmonitor-settings: bare repos are incompatible with FSMonitor
  5:  7cb0180a1ed =  5:  0b182569e11 fsmonitor-settings: stub in Win32-specific incompatibility checking
  6:  9774faddc45 =  6:  06d49b0f230 fsmonitor-settings: VFS for Git virtual repos are incompatible
  7:  f7ef7dcffc8 =  7:  2b6e8b0b241 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  dc2dfd67931 =  8:  8068b3bebee fsmonitor-settings: remote repos on macOS are incompatible
  9:  5627038aaa3 =  9:  a5c40a4464d fsmonitor-settings: remote repos on Windows are incompatible
 10:  9a12cc78b5d = 10:  d2569ed3211 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
 11:  aaff000cecb = 11:  27f360b3336 unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  4f2b15d3d1f = 12:  ad8f65efe0d fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 13:  427dec412a5 = 13:  7e302958cd4 fsmonitor--daemon: cd out of worktree root
 14:  51b266b06e1 = 14:  6b271866f67 fsmonitor--daemon: prepare for adding health thread
 15:  594e0ae243d = 15:  df1061c0ff5 fsmonitor--daemon: rename listener thread related variables
 16:  c2b5c02ed38 = 16:  e255a5b7104 fsmonitor--daemon: stub in health thread
 17:  46a5ae2a635 = 17:  f710d305dd4 fsm-health-win32: add polling framework to monitor daemon health
 18:  7cf1be5f8e2 = 18:  b3f5a945d3e fsm-health-win32: force shutdown daemon if worktree root moves
 19:  95cf1299d44 = 19:  d8949ab5df6 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 20:  b020bfb4568 = 20:  8fa7f4fa9be fsmonitor: optimize processing of directory events
 21:  d058d7e0c08 = 21:  6976f1d45ea t7527: FSMonitor tests for directory moves
 22:  f5dac286812 = 22:  81559df45ab t/perf/p7527: add perf test for builtin FSMonitor
 23:  92f5c0d2c8b = 23:  d0c8fecd1a0 fsmonitor: never set CE_FSMONITOR_VALID on submodules
 24:  40b80adbb31 = 24:  41f8cbc2ae4 t7527: test FSMonitor on case insensitive+preserving file system
 25:  ea19a06e8cb = 25:  c8c4c22360c fsmonitor: on macOS also emit NFC spelling for NFD pathname
 26:  66a01db4739 = 26:  1612dcba503 t/helper/hexdump: add helper to print hexdump of stdin
 27:  25c6066eddc = 27:  e5a7f05d9d4 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
 28:  fc3a0e7847f = 28:  b27dc48a650 t7527: test Unicode NFC/NFD handling on MacOS
 29:  25676ca4ec2 = 29:  2905b3bb59e fsmonitor--daemon: allow --super-prefix argument
 30:  d70d2545a5a = 30:  2f0dea304f0 t7527: improve implicit shutdown testing in fsmonitor--daemon

-- 
gitgitgadget
