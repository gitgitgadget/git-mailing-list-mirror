Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B816BC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739D206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLmvPfz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLTRJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:52 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46297 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTRJw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so8917394edi.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uVWVkAWdK8NPheHLR3+zR3f2L46Kca6cZCwfB2Fdw/I=;
        b=mLmvPfz3KCc4GycpjFKpPgZjO/EZ2g5ZC7qDwyHio2GWi+c0j93l8hhGb8cbp1T1/i
         eLTh/3XeXdwvWv3YYR6c7pqRfkOXkFBAQkXM4da4uMOWNivSTAtT1fQUppBXUZY9VBG2
         lpi16CYSMWuGr1xi+VuNqqmI42LK6+S8Fv0RnpPZvBqnQ7WB27FCoGBe45GoDIryQibZ
         M9r12f3XQzUb+gCohJGfvUsl6I+0EtCxNmIVBanEZBHGb3cdqUJrz7Lnesjs+7gyON3N
         HyzuWc8mVI4D0HVLEcD3ShBjnBbeYAbsjUl7kRzEguwGVznuXh13fwO4vzy+nX3VPWYz
         O15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uVWVkAWdK8NPheHLR3+zR3f2L46Kca6cZCwfB2Fdw/I=;
        b=eIbOByiSJOojfQh76+VqbwLQeczlmBOFVVsmbafPAvjuyox2G4oDcOpSsaimRrysSp
         1Af47G91apJZi8l3Be+Z5KpcoOLP57CpcJvHqSvR7G9jMMK3joX+SvdeCOZAHQ82T4D0
         35XaVouZeWvkHeEMBe2t5DA2wM34HDF1FLCIRgf85yIwSgfNS7/ZzC6alBEXx4khwczP
         Brlezo35+dQcoWup50GxXrSgbxVnI4hohr8OtfwuWCSQcIaZN0x5oLoJBqWQQbgaBFsx
         ElBb9pjCtD/to2XKN6ykgDQDcILHCt3CCQgIZqUvEy6EV3bEHf8AnUqB57IBbN+v3ou3
         eZqw==
X-Gm-Message-State: APjAAAVSx0qxBQeDZrkYS7OsP6ORr8RWTQO5QRX3q3kjsNoqIGyI3n/v
        diNICBw6y+W54fIzqcicmiFk3Ffp
X-Google-Smtp-Source: APXvYqxjCblyhJ0GwZ87MqxSzcXm19JjLspDEXNsL6DWcsbMxeuci16Q0T9Yhwlfs4y93AGdl1VfhQ==
X-Received: by 2002:aa7:da03:: with SMTP id r3mr16953625eds.163.1576861789782;
        Fri, 20 Dec 2019 09:09:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm1140184ejb.43.2019.12.20.09.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:49 -0800 (PST)
Message-Id: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:33 +0000
Subject: [PATCH 00/15] rebase: make the default backend configurable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series does a lot of work around making the default rebase backend
configurable:

 * provide configurability of handling empty commits and iron out
   differences between backends
 * increase/fix capabilities of the merge/interactive backend to make it
   workable as the default
 * document the remaining differences in backends more thoroughly
 * add an --am option for explicitly requesting the am-backend
 * extend merge/interactive backend testing to put it on par with the am
   backend
 * add a 'rebase.backend' config option and:
 * switch the rebase.backend default value from 'am' to 'merge'.

Areas I'd like reviewers to focus, in priority order:

 * Patch 15 (Are we ready to switch the default backend? Or should we leave
   this patch out for now? Junio suggested we may be ready or at least are
   close[1])
 * Patch 1 (Does my empty handling make sense? Do others agree I fixed 
   --keep-empty, or do they view it as breaking it?)
 * Patch 8 (Do the updates to the documentation of behavioral differences
   make sense? Is it too long?) * Patch 11 (okay to change the
      git-completion shell prompt slightly, especially in light of patches
      15 & 16? We did a prompt change previously when we merged the merge
      backend with the interactive one, so I assume so, but just want to
      make sure people have a chance to chime in.)
   
   

If it's too soon to switch from the 'am' to 'merge' backend, we can just
drop the last patch and I'll resubmit it later. I generated this series
mostly through switching the default first and then watching what broke, but
moved the patch to the end to make it easy to drop.

Briefly, reasons for switching the default backend boil down to the fact
that the am-backend drops information and thus limits what it can do. This
manifests in different ways:

 * lack of tree information that would allow us to warn users that new files
   in old directories might want to move along with the other files that
   were renamed with those directories[1]
 * incorrect application of patches in the presence of non-unique context
   lines[2], which could be avoided with access to the original files
   involved.
 * less information available to annotate conflict markers (since am creates
   fake ancestors and commits on top of them, and doesn't have access to the
   original commits)

[1] https://lore.kernel.org/git/xmqqa78d2qmk.fsf@gitster-ct.c.googlers.com/
[2] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
[3] 
https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/

Elijah Newren (15):
  rebase: extend the options for handling of empty commits
  t3406: simplify an already simple test
  rebase, sequencer: remove the broken GIT_QUIET handling
  rebase: make sure to pass along the quiet flag to the sequencer
  rebase: fix handling of restrict_revision
  t3432: make these tests work with either am or merge backends
  rebase: allow more types of rebases to fast-forward
  git-rebase.txt: add more details about behavioral differences of
    backends
  rebase: move incompatibility checks between backend options a bit
    earlier
  rebase: add an --am option
  contrib: change the prompt for am-based rebases
  rebase tests: mark tests specific to the am-backend with --am
  rebase tests: repeat some tests using the merge backend instead of am
  rebase: make the backend configurable via config setting
  rebase: change the default backend from "am" to "merge"

 Documentation/config/rebase.txt         |   8 ++
 Documentation/git-rebase.txt            | 150 ++++++++++++++++----
 builtin/rebase.c                        | 181 +++++++++++++++++++-----
 contrib/completion/git-prompt.sh        |   2 +-
 rebase-interactive.c                    |   4 +-
 rebase-interactive.h                    |   2 +-
 sequencer.c                             |  80 ++++++++---
 sequencer.h                             |   6 +-
 t/t3400-rebase.sh                       |  36 ++++-
 t/t3401-rebase-and-am-rename.sh         |   4 +-
 t/t3404-rebase-interactive.sh           |   2 +-
 t/t3406-rebase-message.sh               |  19 ++-
 t/t3407-rebase-abort.sh                 |   6 +-
 t/t3420-rebase-autostash.sh             |   2 +-
 t/t3421-rebase-topology-linear.sh       |   4 +-
 t/t3424-rebase-empty.sh                 |  89 ++++++++++++
 t/t3425-rebase-topology-merges.sh       |   8 +-
 t/t3427-rebase-subtree.sh               |  16 ++-
 t/t3432-rebase-fast-forward.sh          |  59 ++++----
 t/t3433-rebase-options-compatibility.sh |  13 +-
 t/t5407-post-rewrite-hook.sh            |  12 +-
 t/t5520-pull.sh                         |  27 +++-
 t/t6047-diff3-conflict-markers.sh       |  13 +-
 t/t7512-status-help.sh                  |  12 +-
 t/t9106-git-svn-commit-diff-clobber.sh  |   3 +-
 t/t9903-bash-prompt.sh                  |   6 +-
 26 files changed, 582 insertions(+), 182 deletions(-)
 create mode 100755 t/t3424-rebase-empty.sh


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-679%2Fnewren%2Frebase-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-679/newren/rebase-fixes-v1
Pull-Request: https://github.com/git/git/pull/679
-- 
gitgitgadget
