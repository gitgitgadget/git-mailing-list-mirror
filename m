Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A9C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJTXZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJTXZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:25:49 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9905DF70BA
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id ls4-20020a17090b350400b0020d63c0efb9so2883707pjb.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=80/v3YF2aCgCoW92rbnhw65bo6nYsU29oCUHxbOm6SA=;
        b=GWjtfilaE/AkSzi/7MtNRMHj2KYa2fiy1mXwnMQHRwoYYiZNDwVIShch/B+F1JrpTx
         wwpaSYQrRQ1dHZaJ+MIyO+W+i6JiXEG3br1O3fBmncp0ZNX9854mgWgKwYp4EC0PDMHw
         qQECgp3em2v1xwmQhGg5pjyglnYgqk1J+9RhbjHFQnIIoC5uzhlFYQkmkhXY+KgpQZle
         Rg4vnV7TG3bp88NQJRWN+/SBVbgnXZwDa1YvfDR6MvDosptgIlA77GIm16hqbfmaZTCN
         sOUYgRpOzRBb230qgkP8ya/IDpc99w88EfqZqv3GAPRPtNxLg5nBPaDIYOsLICsshyKc
         CJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80/v3YF2aCgCoW92rbnhw65bo6nYsU29oCUHxbOm6SA=;
        b=h/IH2oBk29ctpbLSvKJLAQzj37xduJCNj2Pn77fKu33k07gyIljFPVsurEQ9kkxE89
         YTYkYLeraCtsyKdUQLAtVhkgWAabdzrlZWvEmgvIpRohaO7jYoQgEjm7snTobG6qhJx5
         hvStAyIS4IET6/POGlRoPqlQS5bJrIhA+rId7QwOcYTe8Siyrg9dnGId62dSI1D6ARL3
         Yu/LVNPiTty6ixuAqYEE3654WQyGi5F1HPIhjDyDwpd/SmjZDPIRwcczaB91QBMC8siU
         BLAT2rRBb9b1CRbUr2Ume4eO2C5VdLU8uQaD0xkvGO17tD5eM311dQ4CAhcO4Pqu8v47
         wN+w==
X-Gm-Message-State: ACrzQf1c7lUiGs8D7IVl9oG0BzGkDcrNMWFT5GQFBY9FemWCR2a4ja+u
        XU1H3WTRv8GFQZR7nIEhfm+4xdmdW7VCutanNruRkxkK9PE0/BFI1rBK1yzXMikbRP7GUPBdw2r
        NEeCTxt9yCovBuQ9qZvupVmn8CutN7swrk1//PPg2FGtWXH5O26lMzhx6UFKw36Vo3Q==
X-Google-Smtp-Source: AMsMyM6hPFTbw9t9VeDKMt/pBnkcG5dwhYP+MsQA4L1ZGf6qNv+rs29MEpHgE7fLDi6/1GtHh658+z+bS38/qrA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:cc4a:0:b0:439:1c48:2fed with SMTP id
 q10-20020a63cc4a000000b004391c482fedmr13763140pgi.618.1666308343822; Thu, 20
 Oct 2022 16:25:43 -0700 (PDT)
Date:   Thu, 20 Oct 2022 23:25:26 +0000
In-Reply-To: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221020232532.1128326-1-calvinwan@google.com>
Subject: [PATCH v3 0/6] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter for context:
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

Changes since v2

Rebased on top of Avar's v3 run-command refactor[1]

pipe_output_fn has been decoupled from 'err' and now uses a new
variable in run_processes_parallel_opts, 'out'. This simplifies much
of the logic and testing difficulty of the previous patch, since 'out'
only holds output from child processes and nothing else.

Added a new patch to add hide_output to run_processes_parallel_opts. I
previously was reseting 'err' as to not print output from child
processes, but that was an unnecessary complication. A simple option to
not print output is much cleaner.

Added a setup patch before "submodule: move status parsing into function"

Fixed many stylistic changes and rewrote some documentation recommended
by Avar -- thank you for your reviews!

[1] https://lore.kernel.org/git/cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com/

Calvin Wan (6):
  run-command: add pipe_output_fn to run_processes_parallel_opts
  run-command: add hide_output to run_processes_parallel_opts
  submodule: strbuf variable rename
  submodule: move status parsing into function
  diff-lib: refactor match_stat_with_submodule
  diff-lib: parallelize run_diff_files for submodules

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 102 +++++++++++--
 run-command.c                      |  29 +++-
 run-command.h                      |  30 ++++
 submodule.c                        | 232 +++++++++++++++++++++++++----
 submodule.h                        |   9 ++
 t/helper/test-run-command.c        |  19 +++
 t/t0061-run-command.sh             |  36 +++++
 t/t4027-diff-submodule.sh          |  19 +++
 t/t7506-status-submodule.sh        |  19 +++
 10 files changed, 457 insertions(+), 50 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

