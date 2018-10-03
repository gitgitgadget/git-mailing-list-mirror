Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5DB1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJCXPZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:15:25 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:45204 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:15:25 -0400
Received: by mail-io1-f73.google.com with SMTP id g133-v6so5904242ioa.12
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C3Ws0a7KsaShCKCkIpuWJmF4QXDLzCdH6oCi97N3S3Y=;
        b=pjKZfe9l4Opd5GrdBEHmJffFWMdOb8Zvn1yyIQtuoRQa3ZxD4lwwgSsdoRvp9q9HDk
         DFU5xIce63sGvvLXDANOPBj+X7mZUB+N07gTAVPhwnfGSQ4tghbf/omyDKF7wBf6Z7h9
         3ppbEGJwGUjpa6chpgunpvPiE+gA9LQmA7dCxxpqVZjrGcsK+vPQl6e6SBzkDSrKOloe
         DzWdpFbm7Wr0kyd1S1gpRFtibaCGKye+sQjqFtVQQ40ivDj0/dAaR4r1C20xiEAbFqC+
         K1SdIyzOraVh4IxVM6fXTkwzcvlQD40Dg1my7HOdkPQSai3VyK2FJ9xKdTVvxB//jSsg
         loRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C3Ws0a7KsaShCKCkIpuWJmF4QXDLzCdH6oCi97N3S3Y=;
        b=NfF9Qm0FwTM+RzYmNgYbMOtudQ/6NzDmSUHA3AR0dr0ghAsLw4+Jp++vbutcpXPLSe
         RxADmY5s1xUJxt33GcXnOHPRt/pCEKqFFk9n/aIBby8c94sE1zlHHIAsWoLrdpljKZHh
         a+6/Dik3DGZjyKFO/K2xak79b0OHgxEXYhBlWwXmQIKaWXyXmgdRi9j8XFfUOTeNef6p
         U8yJKPkESeWDjHaY8taHNaBTXbcCDAc+Q3SRU1ECtaHXVGiCwA7MQzfZGyUq3GC35bnj
         3llZbCKF1LUFsTfctTjIQOA7XuSKTol5+NeldWoKknRodSrApaEWS5Oq4k9wDM+mT0n6
         n3yw==
X-Gm-Message-State: ABuFfojUTR56PDcM9Ua4+uU5T39cOYUTuGBV4F08bugBfuRSi1ltaWwy
        Ir1WBKxcA4s0jX5VjY3HoU8vtBsPCWsn1FMPrtc8dPO40GGSZrKZzM4GBQZNZLoMv22tSXl/saE
        Kh0HO4rwAW9A1feBSOL8r0Co6GpWseFNOUv/pL0FcozApwgUSN/KJ9WRECDA=
X-Google-Smtp-Source: ACcGV60iFGA7sWgv85ThQy7elFzZPjCDBIpl5wk4mvw0GJAFHsvEY7LpYuArh4onNjPSZtHeXLFi+92ceC9Z
X-Received: by 2002:a24:ee43:: with SMTP id b64-v6mr5828390iti.3.1538583978372;
 Wed, 03 Oct 2018 09:26:18 -0700 (PDT)
Date:   Wed,  3 Oct 2018 09:25:58 -0700
In-Reply-To: <cover.1536969438.git.matvore@google.com>
Message-Id: <cover.1538581868.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 0/7] Clean up tests for test_cmp arg ordering and pipe placement
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply suggestions by Szeder and Eric from last version of the patch,
namely:
 - Use a sensible example for how one can unknowingly drop a Git exit
   code in tests.
 - Fixed the message for the second commit.
 - Move the test-specific coding guidelines to t/README from
   Documentation/CodingGuidelines.
 - Particularly forbid invoking Git in ways that will mask crashes, but
   don't say this for non-Git commands, since validating them isn't or
   job.
 - Including a guideline about dropping exit codes for command
   substitution.
 - Reformat Do/Don't lists in Documentation/CodingGuidelines, and make my
   added points have consistent format. This is a new commit.

There may be other changes I didn't list above, but I would have
mentioned them in prior mails.

I created a new commit which cleans up invocations of git-rev-list so
that positional arguments are last, since my other patchset modifies the
tests where most of these mistakes are present, and I want the tests
added in the other patchset to be consistent with the code around it.

Thank you,

Matthew DeVore (7):
  t/README: reformat Do, Don't, Keep in mind lists
  Documentation: add shell guidelines
  tests: standardize pipe placement
  t/*: fix ordering of expected/observed arguments
  tests: don't swallow Git errors upstream of pipes
  t9109: don't swallow Git errors upstream of pipes
  tests: order arguments to git-rev-list properly

 Documentation/CodingGuidelines         |  18 ++
 t/README                               |  68 +++--
 t/lib-gpg.sh                           |   9 +-
 t/t0000-basic.sh                       |   2 +-
 t/t0021-conversion.sh                  |   4 +-
 t/t1006-cat-file.sh                    |   8 +-
 t/t1300-config.sh                      |   9 +-
 t/t1303-wacky-config.sh                |   4 +-
 t/t2101-update-index-reupdate.sh       |   2 +-
 t/t3200-branch.sh                      |   2 +-
 t/t3320-notes-merge-worktrees.sh       |   4 +-
 t/t3400-rebase.sh                      |   8 +-
 t/t3417-rebase-whitespace-fix.sh       |   6 +-
 t/t3702-add-edit.sh                    |   4 +-
 t/t3903-stash.sh                       |   8 +-
 t/t3905-stash-include-untracked.sh     |   2 +-
 t/t4025-hunk-header.sh                 |   2 +-
 t/t4117-apply-reject.sh                |   6 +-
 t/t4124-apply-ws-rule.sh               |  30 +--
 t/t4138-apply-ws-expansion.sh          |   2 +-
 t/t5317-pack-objects-filter-objects.sh | 360 ++++++++++++++-----------
 t/t5318-commit-graph.sh                |   2 +-
 t/t5500-fetch-pack.sh                  |   7 +-
 t/t5616-partial-clone.sh               |  50 ++--
 t/t5701-git-serve.sh                   |  14 +-
 t/t5702-protocol-v2.sh                 |  14 +-
 t/t6023-merge-file.sh                  |  12 +-
 t/t6027-merge-binary.sh                |   4 +-
 t/t6031-merge-filemode.sh              |   2 +-
 t/t6112-rev-list-filters-objects.sh    | 237 +++++++++-------
 t/t7201-co.sh                          |   4 +-
 t/t7406-submodule-update.sh            |   8 +-
 t/t7800-difftool.sh                    |   2 +-
 t/t9100-git-svn-basic.sh               |   2 +-
 t/t9101-git-svn-props.sh               |  34 ++-
 t/t9133-git-svn-nested-git-repo.sh     |   6 +-
 t/t9600-cvsimport.sh                   |   2 +-
 t/t9603-cvsimport-patchsets.sh         |   4 +-
 t/t9604-cvsimport-timestamps.sh        |   4 +-
 39 files changed, 568 insertions(+), 398 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

