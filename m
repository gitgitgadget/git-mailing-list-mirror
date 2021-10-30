Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4578C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F815603E9
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 22:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhJ3W1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 18:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3W1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 18:27:00 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9AAC061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so22299777wrf.11
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPqCj1okxE2ZS8WTRCBkeeVRZlIqr3auXRpeKc8/5KE=;
        b=Z5wB8NEJWzfMOVL5xuGCzljCKQh1lIH9RBF+dUDTuvvtdrb/pkmGyABzDQNK1bBLMN
         Ow9eMny6veQuQmETDHUl8E1h/eiulYk6yecjXMSMjcUcz+wwK7pLdyhF23Uy8kXOOASH
         mJfc5Q9MdUHv5A40SqMC78GJiwTbgSg85RfCm+CwNFu4tHk/pf/PGaKQVOU7Rl4HO8F4
         Er0aSO1+2C53SkLHKpULtDhcJNbPkBYIVe0rhjIoWRxtd9FVkR/uc87X0zB2qd8g9JEE
         qd2Gx7qGdSpVsIX6+1AxLly9auax93JACu6XjQf8X6Ifqwbwj8PcSRMTqdDN8kXv9sGZ
         dEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPqCj1okxE2ZS8WTRCBkeeVRZlIqr3auXRpeKc8/5KE=;
        b=hGTYpwOx5mZQiBSFhAtpX5N5luWdUBCR7ZqIlmsRPGMuL/0ox7klh/XEBSqhEBE7M1
         82yVOsJXgsXsc+vhCWSvUkOtMqwSxY2ZFERNiINtgU7kHHeV9fII2GpHaFm39Sf4qKn0
         CVJ+VJxFKeIkn7O3Ds1lvedof/oYblljFdStHrkeeIpaXlpOCCEiFva+FLZ4AyPb3ERr
         5E7ae4AnRj/5MI2cFM6ZWrh5f6oUBda6QnN8mypghAQcR/ASFE3Wm4aQQATlyXzL7fmT
         KmqPHn3nGAPOm5ogdyLWfQk4Npb6juyfvLG+Jv5hvnM/KMHTPn5U0FAuKBRaUS8pqeCb
         gjYA==
X-Gm-Message-State: AOAM531UbtHCbRi4kAUjoqogY7fu3ReWGlBjj4KIvVudiY4idzqdnCcY
        6saW+L6WWlgEAs5w8dAMZfZOGBQZAYc=
X-Google-Smtp-Source: ABdhPJx+kJQ4CHXkvdI+qhmPj0XyS0VyB3jr+X35SCCjMymM2CFfJst4umCGRoRSsWlFRX2VSNUQlQ==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr26349344wrz.54.1635632667832;
        Sat, 30 Oct 2021 15:24:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6sm8193399wmq.17.2021.10.30.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 15:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/15] leak tests: remaining non-svn non-p4 tests as passing
Date:   Sun, 31 Oct 2021 00:24:09 +0200
Message-Id: <cover-00.15-00000000000-20211030T221945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up to the now-landed series[1] to mark various tests as
passing under SANITIZE=leak.

Existing passing tests were found with:

    rm .prove; GIT_SKIP_TESTS=t0027 prove -j8 --state=save t[0-9]*.sh :: --immediate
    GIT_TEST_PASSING_SANITIZE_LEAK=true prove -j8 --state=passed

These are all the tests that aren't "git-svn", "git-p4",
Windows-specific, or icase, need to write to / etc.

As before I've merged this to "seen" and all tests pass with whatever
we've got in-flight at the moment, so this should cause minimal
disruption. Passing CI run on top of "master" at [2].

1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20211012T135343Z-avarab@gmail.com/
2. https://github.com/avar/git/actions/runs/1403093377

Ævar Arnfjörð Bjarmason (15):
  leak tests: mark a read-tree test as passing SANITIZE=leak
  leak tests: mark "sort" test as passing SANITIZE=leak
  leak tests: mark most gettext tests as passing with SANITIZE=leak
  leak tests: mark some misc tests as passing with SANITIZE=leak
  leak tests: mark some rev-list tests as passing with SANITIZE=leak
  leak tests: mark some rev-parse tests as passing with SANITIZE=leak
  leak tests: mark some update-index tests as passing with SANITIZE=leak
  leak tests: mark some notes tests as passing with SANITIZE=leak
  leak tests: mark some apply tests as passing with SANITIZE=leak
  leak tests: mark some diff tests as passing with SANITIZE=leak
  leak tests: mark some add tests as passing with SANITIZE=leak
  leak tests: mark some clone tests as passing with SANITIZE=leak
  leak tests: mark some status tests as passing with SANITIZE=leak
  leak tests: mark some config tests as passing with SANITIZE=leak
  leak tests: mark some fast-import tests as passing with SANITIZE=leak

 t/t0071-sort.sh                             | 1 +
 t/t0200-gettext-basic.sh                    | 1 +
 t/t0201-gettext-fallbacks.sh                | 1 +
 t/t0202-gettext-perl.sh                     | 1 +
 t/t0204-gettext-reencode-sanity.sh          | 1 +
 t/t1002-read-tree-m-u-2way.sh               | 2 ++
 t/t1300-config.sh                           | 1 +
 t/t1303-wacky-config.sh                     | 2 ++
 t/t1307-config-blob.sh                      | 2 ++
 t/t1308-config-set.sh                       | 1 +
 t/t1309-early-config.sh                     | 1 +
 t/t1310-config-default.sh                   | 1 +
 t/t1420-lost-found.sh                       | 2 ++
 t/t1503-rev-parse-verify.sh                 | 1 +
 t/t1506-rev-parse-diagnosis.sh              | 1 +
 t/t1513-rev-parse-prefix.sh                 | 1 +
 t/t1515-rev-parse-outside-repo.sh           | 2 ++
 t/t1600-index.sh                            | 1 +
 t/t2000-conflict-when-checking-files-out.sh | 1 +
 t/t2100-update-cache-badpath.sh             | 1 +
 t/t2101-update-index-reupdate.sh            | 1 +
 t/t2102-update-index-symlinks.sh            | 1 +
 t/t2103-update-index-ignore-missing.sh      | 1 +
 t/t2104-update-index-skip-worktree.sh       | 1 +
 t/t2105-update-index-gitfile.sh             | 1 +
 t/t2200-add-update.sh                       | 1 +
 t/t2201-add-update-typechange.sh            | 1 +
 t/t2202-add-addremove.sh                    | 1 +
 t/t2204-add-ignored.sh                      | 1 +
 t/t2404-worktree-config.sh                  | 1 +
 t/t3302-notes-index-expensive.sh            | 1 +
 t/t3303-notes-subtrees.sh                   | 1 +
 t/t3320-notes-merge-worktrees.sh            | 1 +
 t/t3702-add-edit.sh                         | 2 ++
 t/t3703-add-magic-pathspec.sh               | 1 +
 t/t3704-add-pathspec-file.sh                | 1 +
 t/t3908-stash-in-worktree.sh                | 1 +
 t/t4000-diff-format.sh                      | 2 ++
 t/t4003-diff-rename-1.sh                    | 2 ++
 t/t4004-diff-rename-symlink.sh              | 2 ++
 t/t4005-diff-rename-2.sh                    | 2 ++
 t/t4006-diff-mode.sh                        | 2 ++
 t/t4007-rename-3.sh                         | 2 ++
 t/t4009-diff-rename-4.sh                    | 2 ++
 t/t4010-diff-pathspec.sh                    | 2 ++
 t/t4011-diff-symlink.sh                     | 2 ++
 t/t4012-diff-binary.sh                      | 1 +
 t/t4020-diff-external.sh                    | 1 +
 t/t4024-diff-optimize-common.sh             | 1 +
 t/t4027-diff-submodule.sh                   | 1 +
 t/t4029-diff-trailing-space.sh              | 1 +
 t/t4032-diff-inter-hunk-context.sh          | 1 +
 t/t4033-diff-patience.sh                    | 1 +
 t/t4034-diff-words.sh                       | 1 +
 t/t4035-diff-quiet.sh                       | 1 +
 t/t4037-diff-r-t-dirs.sh                    | 1 +
 t/t4040-whitespace-status.sh                | 2 ++
 t/t4046-diff-unmerged.sh                    | 2 ++
 t/t4049-diff-stat-count.sh                  | 2 ++
 t/t4050-diff-histogram.sh                   | 1 +
 t/t4054-diff-bogus-tree.sh                  | 2 ++
 t/t4062-diff-pickaxe.sh                     | 1 +
 t/t4063-diff-blobs.sh                       | 2 ++
 t/t4100-apply-stat.sh                       | 2 ++
 t/t4101-apply-nonl.sh                       | 2 ++
 t/t4102-apply-rename.sh                     | 2 ++
 t/t4105-apply-fuzz.sh                       | 2 ++
 t/t4106-apply-stdin.sh                      | 2 ++
 t/t4109-apply-multifrag.sh                  | 2 ++
 t/t4110-apply-scan.sh                       | 2 ++
 t/t4112-apply-renames.sh                    | 2 ++
 t/t4116-apply-reverse.sh                    | 2 ++
 t/t4118-apply-empty-context.sh              | 2 ++
 t/t4119-apply-config.sh                     | 2 ++
 t/t4123-apply-shrink.sh                     | 2 ++
 t/t4126-apply-empty.sh                      | 2 ++
 t/t4127-apply-same-fn.sh                    | 2 ++
 t/t4128-apply-root.sh                       | 2 ++
 t/t4129-apply-samemode.sh                   | 2 ++
 t/t4130-apply-criss-cross-rename.sh         | 2 ++
 t/t4132-apply-removal.sh                    | 2 ++
 t/t4133-apply-filenames.sh                  | 2 ++
 t/t4134-apply-submodule.sh                  | 2 ++
 t/t4136-apply-check.sh                      | 2 ++
 t/t4139-apply-escape.sh                     | 2 ++
 t/t5002-archive-attr-pattern.sh             | 1 +
 t/t5200-update-server-info.sh               | 1 +
 t/t5307-pack-missing-commit.sh              | 1 +
 t/t5555-http-smart-common.sh                | 1 +
 t/t5602-clone-remote-exec.sh                | 1 +
 t/t5603-clone-dirname.sh                    | 2 ++
 t/t5701-git-serve.sh                        | 1 +
 t/t5704-protocol-violations.sh              | 2 ++
 t/t6005-rev-list-count.sh                   | 1 +
 t/t6102-rev-list-unexpected-objects.sh      | 1 +
 t/t6136-pathspec-in-bare.sh                 | 1 +
 t/t7101-reset-empty-subdirs.sh              | 2 ++
 t/t7103-reset-bare.sh                       | 2 ++
 t/t7511-status-index.sh                     | 1 +
 t/t7515-status-symlinks.sh                  | 1 +
 t/t7525-status-rename.sh                    | 1 +
 t/t7526-commit-pathspec-file.sh             | 1 +
 t/t9302-fast-import-unpack-limit.sh         | 2 ++
 t/t9303-fast-import-compression.sh          | 2 ++
 104 files changed, 152 insertions(+)

-- 
2.33.1.1570.g069344fdd45

