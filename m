Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AF51F453
	for <e@80x24.org>; Fri, 21 Sep 2018 01:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeIUHaN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 03:30:13 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:56210 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388824AbeIUHaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 03:30:13 -0400
Received: by mail-io1-f74.google.com with SMTP id m15-v6so16745891ioj.22
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UtgVuBqe+NeyRHsnZJjXoH6ySnvdEJuPxQfqnbbc3tk=;
        b=VdrcPFB2P4eCvEMNzCwvUR9IjBW3x+DjSJC+p5VCLeHXEvcugMHWOxm3QfgfN5eCSd
         V+/dTeJoMf+8n83xFp3akI8Nj8y7hx2+IU4XYeT6KszbSiUTR6dySmeLUjLfULdgush5
         CClqWEkW9Wcctscota32dJ9GYczq5qiqFQ2TaNwn56j54O7YH/uPoLCXO6/Rgk0yTuPZ
         fw5ynYtxov5WOxeMYaa1Ls71OoL8p7syppooIq07sZ2oSr9UkND+VM5rx3Lj311ZHDXC
         OafCfqSHPPtLBDrExM76lB/wniXdeUh7MwncyCWZw3T4FqdK84KDd96wlKpB8OjnkyF/
         9WrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UtgVuBqe+NeyRHsnZJjXoH6ySnvdEJuPxQfqnbbc3tk=;
        b=ruj6rfrpjAqfXzJTz/GWlHR9yB9wdR22EfjHBIsJ69CPcX6kpV8teVptOXZsTQsg1W
         W6mX0xdhvNl/YoL6VANKkmhqOUOcqXsnx5KnIFl3+1C6oKjDSsl68Jt1LGnFiALQOcP4
         tA+Dg+NfMBdzXuDjxlC/NGcAZF44+WRnQ2Y01sK88WLlhQLrkVmCsXFpEfb23pBZrQwb
         DP79u4QadgRhT5kLiIVlQgteY3m4ofGzYiAF5TRhVPPfsmvQyuxzg9lIAWgrFhJU0jSx
         sxlWLvCmofUXm01N8ac2LRx4mYR48sNhcLAjxKOccSTAw6Eohl65/csWFM8Tgp19TYk9
         Tc7Q==
X-Gm-Message-State: APzg51CWBsWutBmyL/HgwadceSN0j6kcE/hPYpJQ6HbUUzAIUFIrYb2d
        6CR4NRyYoA9jVMknebSXEigRGIWtBii2oOGDzi5bf74+B4cnoB7Srx2+OosgS9YyaFRn4vYLs9G
        1U16qOeO/AFm0o86WCRML2goxS2RROb3LRnJVVoaE68D40V8iw3l8Skpsliw=
X-Google-Smtp-Source: ANB0VdaUr3Q3npENHSt1VOrkVCCANjl7/c2sjpuZM9eA6Exz+htsRzunizDqNpeR8Oet5FlFqQ6DPsfs7Dyn
X-Received: by 2002:a6b:ca84:: with SMTP id a126-v6mr30214072iog.45.1537494228430;
 Thu, 20 Sep 2018 18:43:48 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:43:26 -0700
In-Reply-To: <cover.1536969438.git.matvore@google.com>
Message-Id: <cover.1537493611.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH v3 0/5] Clean up tests for test_cmp arg ordering and pipe placement
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two of the commits have changed drastically (see second and third points below)
so I'm sending this again.

Summary of changes since last time:
 - Remove the hacky linter check which makes sure pipes are placed at the end of
   the line in tests - I may add this back in a more polished form when I have
   time.
 - Unbroke t9101 git-svn test which I had broken pretty badly in v2 of the
   patchset.
 - Cleaned up and generalized the wording of the added points in
   CodingGuidelines.

Thank you,

Matthew DeVore (5):
  CodingGuidelines: add shell piping guidelines
  tests: standardize pipe placement
  t/*: fix ordering of expected/observed arguments
  tests: don't swallow Git errors upstream of pipes
  t9109: don't swallow Git errors upstream of pipes

 Documentation/CodingGuidelines         |  27 ++
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
 t/t5616-partial-clone.sh               |  30 ++-
 t/t5701-git-serve.sh                   |  14 +-
 t/t5702-protocol-v2.sh                 |  10 +-
 t/t6023-merge-file.sh                  |  12 +-
 t/t6027-merge-binary.sh                |   4 +-
 t/t6031-merge-filemode.sh              |   2 +-
 t/t6112-rev-list-filters-objects.sh    | 224 ++++++++-------
 t/t7201-co.sh                          |   4 +-
 t/t7406-submodule-update.sh            |   8 +-
 t/t7800-difftool.sh                    |   2 +-
 t/t9100-git-svn-basic.sh               |   2 +-
 t/t9101-git-svn-props.sh               |  34 ++-
 t/t9133-git-svn-nested-git-repo.sh     |   6 +-
 t/t9600-cvsimport.sh                   |   2 +-
 t/t9603-cvsimport-patchsets.sh         |   4 +-
 t/t9604-cvsimport-timestamps.sh        |   4 +-
 38 files changed, 504 insertions(+), 366 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

