Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96BC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CDE610FC
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbhDISrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbhDISru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:47:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB46C061762
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:47:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 12so6583829wrz.7
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=tXCoHmsL86/YGStKl83bGaMef2JoEFHfl0Kf5PBoDkw=;
        b=jXkYwSzSspTXXhBpqNJy7tyGwoA3eRMBqbvZyGSliPx1HLbbukAeeS5Ue7U/0lozvu
         4KFXo9gvScVTTA3ohMnUyA2+U4CmiWvBro0No16jVO77uyKGPLn+O99tJQAPTkdpsPZL
         nkF6d1TJngqBvQrLLZahf8Gk/7B948CffXwmcefnZ09/a/HvDRQMiHe4dge44cSs3cA2
         vmzVxsoV5e+BWTv990FBMFXfOraE6ahmWYeCX53hISoxeUPXcBT/hJec/MXvXFb/zUrL
         tC50dveznIZi+tjDc63eM3CbkxKGjTLvQ0CekL9/v13GWbCWeQTDClbN1FPCHusppqHj
         isiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tXCoHmsL86/YGStKl83bGaMef2JoEFHfl0Kf5PBoDkw=;
        b=M4uNufJ+xfZ5baHkVqO79g1jXowzFBKPZ8/9B1NRI6L95iTU1Y28VEOmi+6Wc3yZ1d
         PstwCpuiCslcP9Le2aSMzKpAsZKMgzS6riaG5v+294FT1DK9I42Fp7stAlVBhl7BAeqC
         sRj/EvD++35vAi+e/9eGqgHH6h6TcWQwm/M//pIXTs4Te5LsgVC7wn2FeNozIstwt8T9
         TF7Xv7MzJxDcsgalet03ejGtBqZkQsZT5wqMbuU/YlUCBu6W65t2rAMEqUC+bAS9GUEF
         scHJjEY8RYBrXJ9JAEgdvFJbNO0M7GbYLnoskCExxuu2qApLtVB6cPbXZJif9mzWSH/n
         j4xA==
X-Gm-Message-State: AOAM530pG00mlapjOjiJXuqIyr5wRjupOICcq0Sb2Q5Z78PADbTgWwKe
        Bx/BlkQNHg3GEBQISC0myd+k9SwIgyU=
X-Google-Smtp-Source: ABdhPJxALc5AgmxqW/Qq61I4hpn6gfdwJdRA4qHUly6A/YZUxt8xQN5ZET3UQ6uqLPExYpQm7vMvbQ==
X-Received: by 2002:adf:d851:: with SMTP id k17mr19161782wrl.254.1617994053793;
        Fri, 09 Apr 2021 11:47:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e23sm5049144wmk.15.2021.04.09.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:47:33 -0700 (PDT)
Message-Id: <pull.929.git.1617994052.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 18:47:19 +0000
Subject: [PATCH 00/12] Fix all leaks in tests t0002-t0099: Part 1
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andrzej Hunt <andrzej@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes approximately half of the real leaks I've found while
running t0002 - t0099 under LSAN.

2 more series will likely be needed to allow t0000-t0099 to pass with LSAN
enabled. (I have all the necessary fixes ready and tested on my machine,
although I want to revisit some of my changes before I'm happy enough to
send them out for review - either way I figure it's easiest to deal with one
batch at a time, so I'll hold off on sending those out for now. One series
is going to consist almost entirely of UNLEAK annotations that are boring
and not worth merging until the real leaks are fixed.)

The exciting news is that once we succeed in getting t000-t0099 to run leak
free, we'll be a significant step closer to being able to run the entire
test-suite leak-free:

 * before the merging of ah/plugleaks (fixing leaks in t0001): 53% of test
   cases fail when LSAN is enabled (12386/23330).
 * with ah/plugleaks + this series + my 2 currently unpublished series: 34%
   of test cases fail when LSAN is enabled (7829/23342).

(I haven't bothered to test most of the intermediate stages, but ISTR that
ah/plugleaks which only had a marginal effect - somewhere on the order of
51-52% test cases were failing after that work merged.)

On the topic of avoiding regressions: I've started running a subset of the
test-suite with LSAN enabled (in addition to the full test-suite with ASAN
and UBSAN) on my Github fork of git, automatically on a daily basis. This
should hopefully help catch any new leaks that appear (and also new
ASAN/UBSAN issues). [The entire test-suite takes around 35 minutes with ASAN
or UBSAN enabled, which isn't too bad compared to the default
linux-gcc/linux-clang jobs which take a similar amount of time - although
they run the test-suite twice with 2 configurations.]

Andrzej Hunt (12):
  revision: free remainder of old commit list in limit_list
  wt-status: fix multiple small leaks
  ls-files: free max_prefix when done
  bloom: clear each bloom_key after use
  branch: FREE_AND_NULL instead of NULL'ing real_ref
  builtin/bugreport: don't leak prefixed filename
  builtin/check-ignore: clear_pathspec before returning
  builtin/checkout: clear pending objects after diffing
  mailinfo: also free strbuf lists when clearing mailinfo
  builtin/for-each-ref: free filter and UNLEAK sorting.
  builtin/rebase: release git_format_patch_opt too
  builtin/rm: avoid leaking pathspec and seen

 bloom.c                |  1 +
 branch.c               |  2 +-
 builtin/bugreport.c    |  8 +++++---
 builtin/check-ignore.c |  1 +
 builtin/checkout.c     |  1 +
 builtin/for-each-ref.c |  3 +++
 builtin/ls-files.c     |  1 +
 builtin/rebase.c       |  1 +
 builtin/rm.c           |  2 ++
 mailinfo.c             | 14 +++-----------
 revision.c             |  1 +
 wt-status.c            |  4 ++++
 12 files changed, 24 insertions(+), 15 deletions(-)


base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-929%2Fahunt%2Fleaksan-100-part1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-929/ahunt/leaksan-100-part1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/929
-- 
gitgitgadget
