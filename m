Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE91C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382128AbiDTUqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDTUqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2C340F6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b19so3823425wrh.11
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hHqma9BOGY3BvRa2kn/TQXzqPsxwYvWIIQc1V0vRm74=;
        b=EAkvK3ZYoDBgjZM1Pk7LmTu5izPVIPz9fUbCxGdswilV9vuGuXqEizI9KfrAPoArrw
         earCk4YNq/s4SqpH3P6WD0mtsEo9E83payk7ERLiO/CBITbLPs9jRd5vwNCvHja5l9uk
         PTfKRXCIe8Rap089calQX4tWG6pJ6P6+kQd5zu+mZRqQUWbQRwLKY2Dh/qiO7pxREeWi
         b0OXRpGXK0RsITxOXGbBppc8oRI8xXbQOH/gBo1lPuNyw59HWoEM7m8UiBKw4wqS9wKd
         yZPSV5fA82UIxb876mc9sByPFKUckrtZiEGDAXoxUIoxslOW1JKn+kCkdBxODpWW0zQP
         Uabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hHqma9BOGY3BvRa2kn/TQXzqPsxwYvWIIQc1V0vRm74=;
        b=uzkvBExA8q+fjajl9e577ATwwh9dWMZmAvNeItIxW83avCU+kEmwDVLN8OxbbOH1Fu
         VBn4XDJyw6BLuWGU2IxjkjYDAEIFbgrssmp+cwg9rR5h7GZW12pnl9EgRktqhZ0p8cxP
         LiyUv9AUV7vYfalYdn3DSkZUh/h0iv4QBPtvvkkQP6yU08lEVyyIqZ1dh8mz+bbxwgos
         89ko/I/JOtFDKjCdQZOB2ekQiLCCAw0KQUlDphNKM7riYjZwD1tzwiDNuIDjCuo6RVxZ
         rCo02X4JF7qJxHtEtlU7T+tM1WVcEKcto7d5gbwm6fwy0LPVQB1ZCmvnzFFezwLMH5mR
         hdCQ==
X-Gm-Message-State: AOAM533GwppbmxiZGHzovnt6Z0FZdMPHRP/lGbRTBzznpVm3Y53yJDOT
        l0HD7KRQNVUE5PW/8A6ixpOYeupNTAY=
X-Google-Smtp-Source: ABdhPJxfEQybqrJFnk61UaJkS8itILtTl4iixgZr7BrQoRpiwwXrinomVhNb1QTU4BXVWy4lQd2qQg==
X-Received: by 2002:a5d:4b4c:0:b0:207:b0b5:b28f with SMTP id w12-20020a5d4b4c000000b00207b0b5b28fmr16485501wrs.280.1650487401323;
        Wed, 20 Apr 2022 13:43:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5-20020adfd1e5000000b0020a97e7ba9fsm796855wrd.92.2022.04.20.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:20 -0700 (PDT)
Message-Id: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:50 +0000
Subject: [PATCH v5 00/28] Builtin FSMonitor Part 3
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
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 5 of FSMonitor part 3. This version:

 * refactored the submodule test in commit 23 to let me reuse parts of it in
   a later commit.

 * Added a new commit 28 to silence a stray warning when FSMonitor is
   implicitly started in a recursive git submodule absorbgitdirs call and
   receives the --super-prefix argument. The warning was harmless, but was
   confusing to users.

This warning was seen by a user in our experimental release of FSMonitor in
Git-for-Windows.

1:  23bfb8c516 =  1:  8b7c5f4e23 fsm-listen-win32: handle shortnames
 2:  d14f171460 =  2:  5b246bec24 t7527: test FSMonitor on repos with Unicode root paths
 3:  4db2370d04 =  3:  8a474d6999 t/helper/fsmonitor-client: create stress test
 4:  f2c0569c90 =  4:  004b67b62e fsmonitor-settings: bare repos are incompatible with FSMonitor
 5:  b2599bb9d2 =  5:  e1e55550c1 fsmonitor-settings: stub in Win32-specific incompatibility checking
 6:  9ad6d87ccc =  6:  2d68fc9a46 fsmonitor-settings: VFS for Git virtual repos are incompatible
 7:  7652c79ab3 =  7:  94ae2e424f fsmonitor-settings: stub in macOS-specific incompatibility checking
 8:  2f2a523552 =  8:  b2ca6c1b20 fsmonitor-settings: remote repos on macOS are incompatible
 9:  0297d80388 =  9:  a3cc4b3b16 fsmonitor-settings: remote repos on Windows are incompatible
10:  b6dfd609ad = 10:  8f1f484075 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
11:  db5197b44b = 11:  8d48d9c562 unpack-trees: initialize fsmonitor_has_run_once in o->result
12:  3f154d0251 = 12:  088c7b3334 fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
13:  4aade7b560 = 13:  00fab62666 fsmonitor--daemon: cd out of worktree root
14:  d8ebac2a9b = 14:  6552f51802 fsmonitor--daemon: prepare for adding health thread
15:  7fb0795e25 = 15:  f2bf07cd73 fsmonitor--daemon: rename listener thread related variables
16:  e90adcd06d = 16:  2a44f2eded fsmonitor--daemon: stub in health thread
17:  d9b91a998c = 17:  854fb5e365 fsm-health-win32: add polling framework to monitor daemon health
18:  0e95ee0d01 = 18:  3af1fe0d61 fsm-health-win32: force shutdown daemon if worktree root moves
19:  48a590d202 = 19:  f1365cdd40 fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
20:  36ab239fd9 = 20:  15698d64ed fsmonitor: optimize processing of directory events
21:  3010b22e69 = 21:  9d0da8fc22 t7527: FSMonitor tests for directory moves
22:  85cdb4d84f = 22:  040c00cfd6 t/perf/p7527: add perf test for builtin FSMonitor
23:  29063455c8 ! 23:  5db241f7d2 fsmonitor: never set CE_FSMONITOR_VALID on submodules
    @@ t/t7527-builtin-fsmonitor.sh: do
     +# dirty submodules.  (See the "S..." bits in porcelain V2 output.)
     +#
     +# It is therefore important that the top level status not be tricked
    -+# by the FSMonitor response to skip those recursive calls.
    ++# by the FSMonitor response to skip those recursive calls.  That is,
    ++# even if FSMonitor says that the mtime of the submodule directory
    ++# hasn't changed and it could be implicitly marked valid, we must
    ++# not take that shortcut.  We need to force the recusion into the
    ++# submodule so that we get a summary of the status *within* the
    ++# submodule.
    ++
    ++create_super () {
    ++	super=$1 &&
    ++
    ++	git init "${super}" &&
    ++	echo x >${super}/file_1 &&
    ++	echo y >${super}/file_2 &&
    ++	echo z >${super}/file_3 &&
    ++	mkdir ${super}/dir_1 &&
    ++	echo a >${super}/dir_1/file_11 &&
    ++	echo b >${super}/dir_1/file_12 &&
    ++	mkdir ${super}/dir_1/dir_2 &&
    ++	echo a >${super}/dir_1/dir_2/file_21 &&
    ++	echo b >${super}/dir_1/dir_2/file_22 &&
    ++	git -C ${super} add . &&
    ++	git -C ${super} commit -m "initial ${super} commit"
    ++}
    ++
    ++create_sub () {
    ++	sub=$1 &&
    ++
    ++	git init "${sub}" &&
    ++	echo x >${sub}/file_x &&
    ++	echo y >${sub}/file_y &&
    ++	echo z >${sub}/file_z &&
    ++	mkdir ${sub}/dir_x &&
    ++	echo a >${sub}/dir_x/file_a &&
    ++	echo b >${sub}/dir_x/file_b &&
    ++	mkdir ${sub}/dir_x/dir_y &&
    ++	echo a >${sub}/dir_x/dir_y/file_a &&
    ++	echo b >${sub}/dir_x/dir_y/file_b &&
    ++	git -C ${sub} add . &&
    ++	git -C ${sub} commit -m "initial ${sub} commit"
    ++}
     +
     +my_match_and_clean () {
     +	git -C super --no-optional-locks status --porcelain=v2 >actual.with &&
    @@ t/t7527-builtin-fsmonitor.sh: do
     +	git -C super/dir_1/dir_2/sub clean -d -f
     +}
     +
    -+test_expect_success "Submodule" '
    -+	test_when_finished "git -C super fsmonitor--daemon stop" &&
    -+
    -+	git init "super" &&
    -+	echo x >super/file_1 &&
    -+	echo y >super/file_2 &&
    -+	echo z >super/file_3 &&
    -+	mkdir super/dir_1 &&
    -+	echo a >super/dir_1/file_11 &&
    -+	echo b >super/dir_1/file_12 &&
    -+	mkdir super/dir_1/dir_2 &&
    -+	echo a >super/dir_1/dir_2/file_21 &&
    -+	echo b >super/dir_1/dir_2/file_22 &&
    -+	git -C super add . &&
    -+	git -C super commit -m "initial super commit" &&
    -+
    -+	git init "sub" &&
    -+	echo x >sub/file_x &&
    -+	echo y >sub/file_y &&
    -+	echo z >sub/file_z &&
    -+	mkdir sub/dir_x &&
    -+	echo a >sub/dir_x/file_a &&
    -+	echo b >sub/dir_x/file_b &&
    -+	mkdir sub/dir_x/dir_y &&
    -+	echo a >sub/dir_x/dir_y/file_a &&
    -+	echo b >sub/dir_x/dir_y/file_b &&
    -+	git -C sub add . &&
    -+	git -C sub commit -m "initial sub commit" &&
    ++test_expect_success "Submodule always visited" '
    ++	test_when_finished "git -C super fsmonitor--daemon stop; \
    ++			    rm -rf super; \
    ++			    rm -rf sub" &&
    ++
    ++	create_super "super" &&
    ++	create_sub "sub" &&
     +
     +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
     +	git -C super commit -m "add sub" &&
24:  6e99f5e4f2 ! 24:  93de3707d2 t7527: test FSMonitor on case insensitive+preserving file system
    @@ Commit message
         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
     
      ## t/t7527-builtin-fsmonitor.sh ##
    -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
    +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
          my_match_and_clean
      '
      
25:  cef7dbbaf0 = 25:  d890c2e2d9 fsmonitor: on macOS also emit NFC spelling for NFD pathname
26:  bc2d5a7a93 = 26:  7c60623555 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
27:  176c530c3f = 27:  9724c41d18 t7527: test Unicode NFC/NFD handling on MacOS
 -:  ---------- > 28:  b8325fb7c7 fsmonitor--daemon: allow --super-prefix argument


Jeff Hostetler (28):
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
  t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
  t7527: test Unicode NFC/NFD handling on MacOS
  fsmonitor--daemon: allow --super-prefix argument

 Makefile                               |  19 +-
 builtin/fsmonitor--daemon.c            | 104 ++++++-
 builtin/update-index.c                 |   4 +
 compat/fsmonitor/fsm-health-darwin.c   |  24 ++
 compat/fsmonitor/fsm-health-win32.c    | 278 +++++++++++++++++
 compat/fsmonitor/fsm-health.h          |  47 +++
 compat/fsmonitor/fsm-listen-darwin.c   | 122 ++++++--
 compat/fsmonitor/fsm-listen-win32.c    | 413 ++++++++++++++++++++-----
 compat/fsmonitor/fsm-listen.h          |   2 +-
 compat/fsmonitor/fsm-settings-darwin.c |  89 ++++++
 compat/fsmonitor/fsm-settings-win32.c  | 137 ++++++++
 config.mak.uname                       |   5 +
 contrib/buildsystems/CMakeLists.txt    |   8 +
 fsmonitor--daemon.h                    |  11 +-
 fsmonitor-settings.c                   |  92 ++++++
 fsmonitor-settings.h                   |  29 ++
 fsmonitor.c                            |  73 ++++-
 fsmonitor.h                            |  11 +
 git.c                                  |   2 +-
 t/helper/test-fsmonitor-client.c       | 106 +++++++
 t/lib-unicode-nfc-nfd.sh               | 167 ++++++++++
 t/perf/p7527-builtin-fsmonitor.sh      | 257 +++++++++++++++
 t/t7519-status-fsmonitor.sh            |  32 ++
 t/t7527-builtin-fsmonitor.sh           | 367 ++++++++++++++++++++++
 unpack-trees.c                         |   1 +
 25 files changed, 2275 insertions(+), 125 deletions(-)
 create mode 100644 compat/fsmonitor/fsm-health-darwin.c
 create mode 100644 compat/fsmonitor/fsm-health-win32.c
 create mode 100644 compat/fsmonitor/fsm-health.h
 create mode 100644 compat/fsmonitor/fsm-settings-darwin.c
 create mode 100644 compat/fsmonitor/fsm-settings-win32.c
 create mode 100755 t/lib-unicode-nfc-nfd.sh
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh


base-commit: 5eb696daba2fe108d4d9ba2ccf4b357447ef9946
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1143%2Fjeffhostetler%2Fbuiltin-fsmonitor-part3-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1143/jeffhostetler/builtin-fsmonitor-part3-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1143

Range-diff vs v4:

  1:  23bfb8c5165 =  1:  8b7c5f4e234 fsm-listen-win32: handle shortnames
  2:  d14f1714604 =  2:  5b246bec247 t7527: test FSMonitor on repos with Unicode root paths
  3:  4db2370d046 =  3:  8a474d69999 t/helper/fsmonitor-client: create stress test
  4:  f2c0569c901 =  4:  004b67b62e3 fsmonitor-settings: bare repos are incompatible with FSMonitor
  5:  b2599bb9d2e =  5:  e1e55550c10 fsmonitor-settings: stub in Win32-specific incompatibility checking
  6:  9ad6d87ccce =  6:  2d68fc9a46a fsmonitor-settings: VFS for Git virtual repos are incompatible
  7:  7652c79ab35 =  7:  94ae2e424f1 fsmonitor-settings: stub in macOS-specific incompatibility checking
  8:  2f2a5235522 =  8:  b2ca6c1b201 fsmonitor-settings: remote repos on macOS are incompatible
  9:  0297d80388a =  9:  a3cc4b3b16d fsmonitor-settings: remote repos on Windows are incompatible
 10:  b6dfd609adb = 10:  8f1f4840751 fsmonitor-settings: NTFS and FAT32 on MacOS are incompatible
 11:  db5197b44bb = 11:  8d48d9c5623 unpack-trees: initialize fsmonitor_has_run_once in o->result
 12:  3f154d02517 = 12:  088c7b3334c fsm-listen-darwin: ignore FSEvents caused by xattr changes on macOS
 13:  4aade7b560a = 13:  00fab626663 fsmonitor--daemon: cd out of worktree root
 14:  d8ebac2a9b2 = 14:  6552f51802b fsmonitor--daemon: prepare for adding health thread
 15:  7fb0795e25e = 15:  f2bf07cd739 fsmonitor--daemon: rename listener thread related variables
 16:  e90adcd06db = 16:  2a44f2eded1 fsmonitor--daemon: stub in health thread
 17:  d9b91a998ce = 17:  854fb5e3658 fsm-health-win32: add polling framework to monitor daemon health
 18:  0e95ee0d01b = 18:  3af1fe0d61d fsm-health-win32: force shutdown daemon if worktree root moves
 19:  48a590d2026 = 19:  f1365cdd40c fsm-listen-darwin: shutdown daemon if worktree root is moved/renamed
 20:  36ab239fd9a = 20:  15698d64edd fsmonitor: optimize processing of directory events
 21:  3010b22e690 = 21:  9d0da8fc22b t7527: FSMonitor tests for directory moves
 22:  85cdb4d84f2 = 22:  040c00cfd6f t/perf/p7527: add perf test for builtin FSMonitor
 23:  29063455c83 ! 23:  5db241f7d2f fsmonitor: never set CE_FSMONITOR_VALID on submodules
     @@ t/t7527-builtin-fsmonitor.sh: do
      +# dirty submodules.  (See the "S..." bits in porcelain V2 output.)
      +#
      +# It is therefore important that the top level status not be tricked
     -+# by the FSMonitor response to skip those recursive calls.
     ++# by the FSMonitor response to skip those recursive calls.  That is,
     ++# even if FSMonitor says that the mtime of the submodule directory
     ++# hasn't changed and it could be implicitly marked valid, we must
     ++# not take that shortcut.  We need to force the recusion into the
     ++# submodule so that we get a summary of the status *within* the
     ++# submodule.
     ++
     ++create_super () {
     ++	super=$1 &&
     ++
     ++	git init "${super}" &&
     ++	echo x >${super}/file_1 &&
     ++	echo y >${super}/file_2 &&
     ++	echo z >${super}/file_3 &&
     ++	mkdir ${super}/dir_1 &&
     ++	echo a >${super}/dir_1/file_11 &&
     ++	echo b >${super}/dir_1/file_12 &&
     ++	mkdir ${super}/dir_1/dir_2 &&
     ++	echo a >${super}/dir_1/dir_2/file_21 &&
     ++	echo b >${super}/dir_1/dir_2/file_22 &&
     ++	git -C ${super} add . &&
     ++	git -C ${super} commit -m "initial ${super} commit"
     ++}
     ++
     ++create_sub () {
     ++	sub=$1 &&
     ++
     ++	git init "${sub}" &&
     ++	echo x >${sub}/file_x &&
     ++	echo y >${sub}/file_y &&
     ++	echo z >${sub}/file_z &&
     ++	mkdir ${sub}/dir_x &&
     ++	echo a >${sub}/dir_x/file_a &&
     ++	echo b >${sub}/dir_x/file_b &&
     ++	mkdir ${sub}/dir_x/dir_y &&
     ++	echo a >${sub}/dir_x/dir_y/file_a &&
     ++	echo b >${sub}/dir_x/dir_y/file_b &&
     ++	git -C ${sub} add . &&
     ++	git -C ${sub} commit -m "initial ${sub} commit"
     ++}
      +
      +my_match_and_clean () {
      +	git -C super --no-optional-locks status --porcelain=v2 >actual.with &&
     @@ t/t7527-builtin-fsmonitor.sh: do
      +	git -C super/dir_1/dir_2/sub clean -d -f
      +}
      +
     -+test_expect_success "Submodule" '
     -+	test_when_finished "git -C super fsmonitor--daemon stop" &&
     -+
     -+	git init "super" &&
     -+	echo x >super/file_1 &&
     -+	echo y >super/file_2 &&
     -+	echo z >super/file_3 &&
     -+	mkdir super/dir_1 &&
     -+	echo a >super/dir_1/file_11 &&
     -+	echo b >super/dir_1/file_12 &&
     -+	mkdir super/dir_1/dir_2 &&
     -+	echo a >super/dir_1/dir_2/file_21 &&
     -+	echo b >super/dir_1/dir_2/file_22 &&
     -+	git -C super add . &&
     -+	git -C super commit -m "initial super commit" &&
     -+
     -+	git init "sub" &&
     -+	echo x >sub/file_x &&
     -+	echo y >sub/file_y &&
     -+	echo z >sub/file_z &&
     -+	mkdir sub/dir_x &&
     -+	echo a >sub/dir_x/file_a &&
     -+	echo b >sub/dir_x/file_b &&
     -+	mkdir sub/dir_x/dir_y &&
     -+	echo a >sub/dir_x/dir_y/file_a &&
     -+	echo b >sub/dir_x/dir_y/file_b &&
     -+	git -C sub add . &&
     -+	git -C sub commit -m "initial sub commit" &&
     ++test_expect_success "Submodule always visited" '
     ++	test_when_finished "git -C super fsmonitor--daemon stop; \
     ++			    rm -rf super; \
     ++			    rm -rf sub" &&
     ++
     ++	create_super "super" &&
     ++	create_sub "sub" &&
      +
      +	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
      +	git -C super commit -m "add sub" &&
 24:  6e99f5e4f2a ! 24:  93de3707d26 t7527: test FSMonitor on case insensitive+preserving file system
     @@ Commit message
          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
      
       ## t/t7527-builtin-fsmonitor.sh ##
     -@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule" '
     +@@ t/t7527-builtin-fsmonitor.sh: test_expect_success "Submodule always visited" '
       	my_match_and_clean
       '
       
 25:  cef7dbbaf04 = 25:  d890c2e2d97 fsmonitor: on macOS also emit NFC spelling for NFD pathname
 26:  bc2d5a7a930 = 26:  7c606235557 t/lib-unicode-nfc-nfd: helper prereqs for testing unicode nfc/nfd
 27:  176c530c3fa = 27:  9724c41d18d t7527: test Unicode NFC/NFD handling on MacOS
  -:  ----------- > 28:  b8325fb7c78 fsmonitor--daemon: allow --super-prefix argument

-- 
gitgitgadget
