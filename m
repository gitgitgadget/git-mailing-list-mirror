Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5575CC53210
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbjADVyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjADVym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:54:42 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963D1EAD6
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:54:41 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id bx21-20020a056a00429500b00582d85bb03bso2510822pfb.16
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjOd64Vt30MPOvxIADLPY9fH/Fiv9AI+iKcqfuY/RWU=;
        b=iKmmHXavuTV/W3sMHTqNsor4XPEzkH8OuUa0wXwfmcZdD4Q2KVAgMRWMyS+wKZY0vB
         /AXr6CI9iXoYQQjG0IEESy359KOasG6G6ZpuQfn+Evkn2jrUSczECTKimf/ZbH6MppuJ
         pAskK0Nx4WtTMxssQ5xzwbFcKYfjI4ApGuJd7iNdwo0rQwEeD9FKpe8U30CoWRukpORu
         iJL7Fe2MtD4BQIMrXxXVwAxU10xUs7RODxS3eObsdyKCzKvGmFyK7QizBxTuLJBl+S65
         1go2ZR+h5yqtBaSPKPWmZ+MZXrVAQ7oJtYmNHJfB1buAQpW7zAAo3PBrPtw3PzAmmLjB
         IrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjOd64Vt30MPOvxIADLPY9fH/Fiv9AI+iKcqfuY/RWU=;
        b=iV4VheWRDlL7eIP7Q3jj3cIMlGRS8Z0mHC4/MieRUfWz8dTZFbwjtUBQwmp8f7RaqC
         /tT+X3kz3tjKnE5eAXchq2HkApQgCdXndSOkZKB618zOhQfpZdjcCV17OOAUWEUEjsX2
         LCOpZ1z1ktJAHg2rqX4hX5ZDlN3gVoMGgtCZscZnWzWd9eYI+RlbBy1riSSy3L/QC01G
         lkonvCegPrX5Jq2DFuMDszitQiU85jYBVTHSefiE5lRrQ7Qv4IkFVhsHy886BJseifFQ
         2B8FG1cjJz1MFl+nKE1c7uCLh+Uh9XScRz9Ko8T7wdYipyf+3O7dMryoKgBVCXJq6Bbh
         MnJg==
X-Gm-Message-State: AFqh2koAUnol3GVLHZA2iudhtneOaMRCoP12lDwhQuxdZI+f1JZ1q/T7
        sjRR+Fjya7zLY47h8mU/Me5hZYB80/ZML8nBY5+5OkBil3gYrheXZSCLf5UBQns10WkErzvrw+o
        1A8iQnurmTnNVeO8KX9s4F4CAZfkLYpWyQ5N8ZAuD6q5t35lSzSYiRNg+cl6IvLoyrQ==
X-Google-Smtp-Source: AMrXdXu9urHrlqhbJIpDAxj0DZYT9iK2+Fn+jLr9vM+tpjYjcQzVTTMODgRBOh9L3aUWARkvpLZApu3EOj+oL3k=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:328d:b0:582:e311:877d with SMTP
 id ck13-20020a056a00328d00b00582e311877dmr424841pfb.54.1672869280892; Wed, 04
 Jan 2023 13:54:40 -0800 (PST)
Date:   Wed,  4 Jan 2023 21:54:09 +0000
In-Reply-To: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104215415.1083526-1-calvinwan@google.com>
Subject: [PATCH v5 0/6] submodule: parallelize diff
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter for context:
https://lore.kernel.org/git/20221011232604.839941-1-calvinwan@google.com/

Thank you again everyone for the numerous reviews! For this reroll, I
incorporated most of the feedback given, fixed a bug I found, and made
some stylistic refactors. I also added a new patch at the end that swaps
the serial implementation in is_submodule_modified for the new parallel
one. While I had patch 6 originally smushed with the previous one,
the diff came out not very reviewer friendly so it has been separated
out.

Changes since v4

(Patch 1)
The code in run-command.c that calls duplicate_output_fn has been
cleaned up and no longer passes a separate strbuf for the output. It
instead passes an offset that represents the starting point in the
original strbuf.

(Patch 5)
Moved status parsing from status_duplicate_output to status_finish. In
pp_buffer_stderr::run-command.c, output is gathered by strbuf_read_once
which reads 8192 bytes at once so a longer status message would error
out during status parsing since part of it would be cut off. Therefore,
status parsing must happen at the end of the process rather than in
duplicate_output_fn (and has subsequently been moved).

(Patch 6)
New patch swapping serial implementation in is_submodule_modified for
the new parallel one.

Calvin Wan (6):
  run-command: add duplicate_output_fn to run_processes_parallel_opts
  submodule: strbuf variable rename
  submodule: move status parsing into function
  diff-lib: refactor match_stat_with_submodule
  diff-lib: parallelize run_diff_files for submodules
  submodule: call parallel code from serial status

 Documentation/config/submodule.txt |  12 ++
 diff-lib.c                         | 104 ++++++++++--
 run-command.c                      |  16 +-
 run-command.h                      |  27 ++++
 submodule.c                        | 250 ++++++++++++++++++++++-------
 submodule.h                        |   9 ++
 t/helper/test-run-command.c        |  21 +++
 t/t0061-run-command.sh             |  39 +++++
 t/t4027-diff-submodule.sh          |  19 +++
 t/t7506-status-submodule.sh        |  19 +++
 10 files changed, 441 insertions(+), 75 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

