Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D9C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90084206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vSgI0Re+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKUWU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:29 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53340 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:29 -0500
Received: by mail-wm1-f45.google.com with SMTP id u18so5457617wmc.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=pwjLSHBumkUD+0kNVtgFg27ZOp0NQrlj1Prucvgqdgg=;
        b=vSgI0Re+yoM0bA4I1XqFM9PNl2YmyUI5iV5mryoHmemCl/z3AR6eKK48EEO5FDc5fi
         CoGDgQ5fYoEe0DJa0PQUhKFLey/MYzDjw+S6aPB4NQ/k6qhI3+gv0nS0E3BIuxuEhofy
         U1ceiVE1gLyx2AxETUCdHzcZXXN2VKm8S7KFrUX/YUEtWe3Cc8cSyD5gZEuw/ZDLfYPm
         qliO/DEhBF+ZrEzKGnSE4fr7C9snglRNLhccwkmmEpi4tiCVeg3dDutsZfYWM3+LVy0u
         GQnl490aIX4WrtkE1f+hiLhszeQwYrZuwdiQdQxeMmU/ivxB7qVNsoUxr6pOdh+tZnUI
         x4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwjLSHBumkUD+0kNVtgFg27ZOp0NQrlj1Prucvgqdgg=;
        b=Sy0GknahNxNAIthlggTGO1N3RRAGkp6T2MuCUE8Ga4qvXdD5ZctMXTbIh/fMVBxEFE
         75bjLbZdcsCWFEZx2ysPOi7y1iSR6SE2zDGdsnUAPmqKjNV+IkgeeaTAKPrUVCfpJriz
         F0Q0efofp25HK4mt/A9jwWVpJCEFiwic8k5gUwuFKvct/TVcptH1F7CLT5PvH3P48PpU
         7Yj/SYnccGaj3QzcFVWmL34irobriYrGW0KRlVs2W0Cy6byK/5qsYywbaZIxwGXytvhX
         J5i9hoTn/ImZqGaTUPSDcb7Jk0iOQbOyYlotwDT0/2sUVgdyFw8M0hph9h3sOmhXrDFF
         KDbg==
X-Gm-Message-State: APjAAAUOh7UyByStI+l3KVDikzzJQz+g/LhVrWTiaqruCTlmV4btoeL8
        plLHbLkOP159k0qxXWcJU/ADieLf
X-Google-Smtp-Source: APXvYqwWdFPBz/rGl9KDKPCihnly4XGCZyd3D6F2BBfXNTv3/bYcEE8UWcAy1zFa8FXDZGT59s4N4g==
X-Received: by 2002:a7b:c934:: with SMTP id h20mr6081360wml.56.1574374827486;
        Thu, 21 Nov 2019 14:20:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a17sm5087481wrs.33.2019.11.21.14.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:27 -0800 (PST)
Message-Id: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:15 +0000
Subject: [PATCH 00/11] Improve testability with GIT_TEST_FSMONITOR
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GIT_TEST_FSMONITOR environment variable allows run-time specification of
the fsmonitor hook. Initially used by t7619-status-fsmonitor.sh, we can
enable it across the test suite to see how it affects Git's behavior. In
particular, we can specify the version of the hook that requests a result
from Watchman to get actual updates to the files in the repo.

In many cases, our tests are simply not ready to handle this option.
fsmonitor does not integrate well with features such as split index, bare
repos, or submodules. Other times, we need to disable it because the test is
being specific about what files Git inspects during a 'status' call.

The long-term vision is to be able to run CI builds using a file-system
watcher like Watchman to get better coverage on this feature. These patches
get us closer, but there are still some issues around overloading the
Watchman interface when the tests are run in parallel. When using "prove -j8
t[0-8]*.sh" I see some failures that do not reproduce when running the test
scripts in isolation (on Linux).

Thanks, -Stolee

Derrick Stolee (11):
  fsmonitor: disable in a bare repo
  fsmonitor: do not output to stderr for tests
  t1301-shared-repo.sh: disable FSMONITOR
  t1510-repo-setup.sh: disable fsmonitor if no .git dir
  fsmonitor: disable fsmonitor with worktrees
  t3030-merge-recursive.sh: disable fsmonitor when tweaking
    GIT_WORK_TREE
  t3600-rm.sh: disable fsmonitor when deleting populated submodule
  tests: disable fsmonitor in submodule tests
  t7063: disable fsmonitor with status cache
  t7519: disable external GIT_TEST_FSMONITOR variable
  test-lib: clear watchman watches at test completion

 config.c                                     |  5 +++++
 t/t1301-shared-repo.sh                       |  1 +
 t/t1510-repo-setup.sh                        |  1 +
 t/t2400-worktree-add.sh                      |  2 ++
 t/t3030-merge-recursive.sh                   |  2 ++
 t/t3600-rm.sh                                |  1 +
 t/t4060-diff-submodule-option-diff-format.sh |  3 +++
 t/t5526-fetch-submodules.sh                  |  2 ++
 t/t7063-status-untracked-cache.sh            |  3 +++
 t/t7402-submodule-rebase.sh                  |  3 +++
 t/t7406-submodule-update.sh                  |  2 ++
 t/t7506-status-submodule.sh                  |  3 +++
 t/t7508-status.sh                            |  3 +++
 t/t7519-status-fsmonitor.sh                  |  3 +++
 t/t7519/fsmonitor-watchman                   |  1 -
 t/test-lib-functions.sh                      | 15 +++++++++++++++
 t/test-lib.sh                                |  2 ++
 17 files changed, 51 insertions(+), 1 deletion(-)


base-commit: dd0b61f577f041f1119bb3288451f8f9b7f9e3f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-466%2Fderrickstolee%2Ftest-watchman-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-466/derrickstolee/test-watchman-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/466
-- 
gitgitgadget
