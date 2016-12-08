Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1964520259
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbcLHVEH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:07 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33740 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so177712273pgd.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0MNnBh/16U0yd47hRWweG4icvWvRmpgAdaW7/cBxHyg=;
        b=J/KRf/+wXtBokh3P7v6w8rhW3+CtFEdF5if9unpOl5QJz5V5tsfsCT91YzbRlMEPmt
         vzLRlZ3Ddj+iAqsxfosj9mXSXS0b8XVrQ5JXGdG7kUUyOr2Yn6NiT1REKXI4CutTDIbw
         j5/ua5CqucH1o6+0rHuDlLYmdQDxqerMLQEhlIUXmbdSz9Ohfffw7Ub0Gc0/ONu2PPrZ
         Zdp1yN/ETQrYJB8eGgZ6etpYfHiyYNjQQhWwNZIUr0tlMVqpVoiDF6u/IUNX16pqkPcj
         cHXwuwFu8mjb7g0owMwvspYPDXW7eKgslitB1N7dhoQey9IvaBBHOJq1FFl0Jko6Zmzn
         s7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0MNnBh/16U0yd47hRWweG4icvWvRmpgAdaW7/cBxHyg=;
        b=Zyo7WoD7V1bJmhtTi+Ml09jwVJ3bISh9qlt/LjLO2WIkCEBs3LdPeL8MMQQ3HbzZlh
         qt0dBuq8AU3f0RzBQGgM1G6XBd7AP0TFNp5AxF/388cpzzYy4rQf72X/RCXt8GciO3lA
         O1TrsbXt/3UIg76nT4hSs843GR3GMNL4T3nfBtssKEm16ZuPX41VdjCZdvbwzX5qHl4K
         8aX0l9iaONY9BWUHvpJ6ixOeHl699U7FX0zghw01T1ddQkk37iraqDr4C9AnyAQFdMho
         HmGGVcjRaJ9IU380Re6hYrlC/zFXzO/tMa4YL9DmUVyLH5h2cmwRIYWRxGhyihX1R4qM
         vSHw==
X-Gm-Message-State: AKaTC00H1HfCN0B1CJz/DiAg+TaaMpV0UaGwnbOGB07IoQW7w5n13xXFx78wl5EF++loX1iB
X-Received: by 10.99.63.135 with SMTP id m129mr135555847pga.16.1481231013448;
        Thu, 08 Dec 2016 13:03:33 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id a22sm52303338pfg.7.2016.12.08.13.03.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:32 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 0/6] submodule absorbgitdirs
Date:   Thu,  8 Dec 2016 13:03:23 -0800
Message-Id: <20161208210329.12919-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v7:
* do not expose submodule_get_worktrees. The values may be wrong internally,
  but for our purpose we do not care about the actual values, only the count.
  Document the wrong values!
* more strings are _(marked up)
* renamed variables in connect_work_tree_and_git_dir
* unsigned instead of int for options in the submodule helper.
* 

v6:
 * renamed embedgitdirs to absorbgitdirs embedding may be interpreted as
   embedding the git dir into the working directory, whereas absorbing sounds
   more like the submodule is absorbed by the superproject, making the
   submodule less independent
 * Worktrees API offer uses_worktrees(void) and submodule_uses_worktree(path).
 * moved the printing to stderr and one layer up (out of the pure
   relocate_git_dir function).
 * connect_... is in dir.h now.

v5:
* Add another layer of abstraction, i.e. the relocate_git_dir is only about
  moving a git dir of one repository. The submodule specific stuff (e.g.
  recursion into nested submodules) is in submodule.{c,h}

  This was motivated by reviews on the series of checkout aware of submodules
  building on top of this series, as we want to directly call the embed-git-dirs
  function without the overhead of spawning a child process.

v4:
* rebuilt on top of nd/worktree-list-fixup
* fix and test behavior for un-init submodules (don't crash, rather do nothing)
* incorporated a "static" as pointed out by Ramsay
* use internal functions instead of duplicating code in worktree.c
  (use get_common_dir_noenv for the submodule to actually get the common dir)
* fixed a memory leak in relocate_gitdir

v3:
* have a slightly more generic function "relocate_gitdir".
  The recursion is strictly related to submodules, though.
* bail out if a submodule is using worktrees.
  This also lays the groundwork for later doing the proper thing,
  as worktree.h offers a function `get_submodule_worktrees(path)`
* nit by duy: use git_path instead of git_common_dir

v2:
* fixed commit message for patch:
 "submodule: use absolute path for computing relative path connecting"
* a new patch "submodule helper: support super prefix"
* redid the final patch with more tests and fixing bugs along the way
* "test-lib-functions.sh: teach test_commit -C <dir>" unchanged

v1:
The discussion of the submodule checkout series revealed to me that a command
is needed to move the git directory from the submodules working tree to be
embedded into the superprojects git directory.

So I wrote the code to intern the submodules git dir into the superproject,
but whilst writing the code I realized this could be valueable for our use
in testing too. So I exposed it via the submodule--helper. But as the
submodule helper ought to be just an internal API, we could also
offer it via the proper submodule command.

The command as it is has little value to the end user for now, but
breaking it out of the submodule checkout series hopefully makes review easier.

Thanks,
Stefan
Stefan Beller (6):
  submodule: use absolute path for computing relative path connecting
  submodule helper: support super prefix
  test-lib-functions.sh: teach test_commit -C <dir>
  worktree: have a function to check if worktrees are in use
  move connect_work_tree_and_git_dir to dir.h
  submodule: add absorb-git-dir function

 Documentation/git-submodule.txt    |  15 +++++
 builtin/submodule--helper.c        |  69 ++++++++++++++++----
 dir.c                              |  37 +++++++++++
 dir.h                              |   4 ++
 git-submodule.sh                   |   7 +-
 git.c                              |   2 +-
 submodule.c                        | 127 ++++++++++++++++++++++++++++++-------
 submodule.h                        |   5 +-
 t/t7412-submodule-absorbgitdirs.sh | 101 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh            |  20 ++++--
 worktree.c                         |  68 +++++++++++++++++---
 worktree.h                         |   7 ++
 12 files changed, 409 insertions(+), 53 deletions(-)
 create mode 100755 t/t7412-submodule-absorbgitdirs.sh

-- 
2.11.0.rc2.29.g7c00390.dirty

