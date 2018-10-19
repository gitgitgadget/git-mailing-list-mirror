Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42CA1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeJSW7L (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:11 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39400 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSW7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:11 -0400
Received: by mail-lj1-f178.google.com with SMTP id p1-v6so31091295ljg.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNmDIfwi6mwBy/soNB7O5r8uJfRuVAu8HQV0+q18e9k=;
        b=lr6VacD8ZD+GCmJh/LuDGiDcNRceQFeZHPRW6+WV/mlZn95lBbcpOggn4rImvbF0gP
         Ad9V2JYLCbpzK89rgMds75UTTBI9c2uGQhr2VCAXVXWm2apJrXkY6i2lPyG//xTht5th
         hETN8K00FoFOGn4FnBKTcMzgRMSCVzQavccjLa9BO8XEnpC724AoR09R/9fMWtDNYwqi
         wzEv9iEjQn5Uxwrn7VEazcw5ENJK3ituOxR1MC8YSZuylWuiw6Arzj+pgZUsYrxurDBp
         KHB6M+zSF2HYmq3JbrQZZtWqTk6MmoMO5dEEJUlA9YUpUboGo5dmg3/q1sIUSSxBa4ND
         xTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oNmDIfwi6mwBy/soNB7O5r8uJfRuVAu8HQV0+q18e9k=;
        b=qskeL2+XPQqIhEhz9TcaQLOcbVc2VX6fDBpx4Ukl9V918BaNIFcXmcJtjzSInzKFZn
         8MtFzsru80fU34s6tlC99BBOkD8wvrpD+WImflXNX+z01U1SZjvV30xEjvhsaFxvBs4r
         xDL/9i3EeYEl2Jcpa+mP2vQShKrY2LR9jVweXl8bJguaXjYCOECyRa6UJ5x0JvgscQfV
         gVDME60QvA2eOjqvru3vKeO0uRpnp0FAm5FlI66TwSdt9PngaOyFCeD6aNDQf0/O2VYN
         rdfUzGf62wqyJvCobB4uW9emxPfQ6pXprquIf4tgUEtQGmUF3kJnQsaXC6PvW+ZRiKuA
         gkhw==
X-Gm-Message-State: ABuFfoifui74nfzEkqw104Jl30RpDxx4Jg3oitG0ko6odjhBg33e7tU7
        XSzOA1mO74VdCLdZVfd5Wfhwu0Cf
X-Google-Smtp-Source: ACcGV601T/fuTsWFIiBM0sC08Wfd5b0VNi5vlgt0k2zxC1oPFAuwQHXeg3dhCwVaKD8omlbk2r8A7Q==
X-Received: by 2002:a2e:6353:: with SMTP id x80-v6mr22216119ljb.11.1539960761623;
        Fri, 19 Oct 2018 07:52:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/WIP 00/19] Kill the_index, final part
Date:   Fri, 19 Oct 2018 16:52:18 +0200
Message-Id: <20181019145237.16079-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan I see you start removing more references of the_repository in
another series (haven't really looked at it yet) so this is just heads
up so we could coordinate if needed. Still WIP, not really ready for
review yet.

This series removes use of the_index outside builtin/ and t/helper/.
The only the_index reference left is in repository.c. The macro
NO_THE_REPOSITORY_COMPATIBILITY_MACROS is now flipped to
USE_THE_INDEX_COMPATIBILITY_MACROS. "the_index" is forbidden by
default.

After this I think we can start pushing the_repository outside library
code. Then perhaps clean them up in builtin code too and you can
finally get rid of it. But I don't think that'll happen in a year's
time.

Nguyễn Thái Ngọc Duy (19):
  wt-status.c: remove implicit dependency on the_index
  wt-status.c: remove implicit dependency the_repository
  list-objects-filter.c: remove implicit dependency on the_index
  list-objects.c: remove implicit dependency on the_index
  sequencer.c: remove implicit dependency on the_index
  sequencer.c: remove implicit dependency on the_repository
  notes-merge.c: remove implicit dependency on the_index
  notes-merge.c: remove implicit dependency the_repository
  repository.c: replace hold_locked_index() with repo_hold_locked_index()
  checkout: avoid the_index when possible
  read-cache.c: kill read_index()
  read-cache.c: replace update_index_if_able with repo_&
  transport.c: remove implicit dependency on the_index
  sha1-name.c: remove implicit dependency on the_index
  merge-recursive.c: remove implicit dependency on the_index
  merge-recursive.c: remove implicit dependency on the_repository
  read-cache.c: remove the_* from index_has_changes()
  cache.h: flip NO_THE_INDEX_COMPATIBILITY_MACROS switch
  Flip NO_THE_REPOSITORY_COMPATIBILITY_MACROS

 apply.c                              |   5 +-
 attr.c                               |   1 -
 blame.c                              |   4 +-
 builtin/add.c                        |   1 +
 builtin/am.c                         |  11 +-
 builtin/blame.c                      |   3 +-
 builtin/cat-file.c                   |   7 +-
 builtin/check-attr.c                 |   1 +
 builtin/check-ignore.c               |   1 +
 builtin/checkout-index.c             |   1 +
 builtin/checkout.c                   |   5 +-
 builtin/clean.c                      |   1 +
 builtin/clone.c                      |   1 +
 builtin/commit.c                     |  10 +-
 builtin/describe.c                   |   3 +-
 builtin/diff-files.c                 |   1 +
 builtin/diff-index.c                 |   1 +
 builtin/diff-tree.c                  |   3 +-
 builtin/diff.c                       |   3 +-
 builtin/difftool.c                   |   1 +
 builtin/fsck.c                       |   1 +
 builtin/grep.c                       |   4 +-
 builtin/hash-object.c                |   3 +-
 builtin/log.c                        |   4 +-
 builtin/ls-files.c                   |   1 -
 builtin/merge-index.c                |   1 +
 builtin/merge-ours.c                 |   1 +
 builtin/merge-recursive.c            |   2 +-
 builtin/merge-tree.c                 |   3 +-
 builtin/merge.c                      |   5 +-
 builtin/mv.c                         |   1 +
 builtin/notes.c                      |   2 +-
 builtin/pack-objects.c               |   2 +-
 builtin/pull.c                       |   4 +-
 builtin/push.c                       |   3 +-
 builtin/read-tree.c                  |   1 +
 builtin/rebase--helper.c             |  15 +-
 builtin/replace.c                    |   2 +-
 builtin/reset.c                      |   1 +
 builtin/rev-parse.c                  |   4 +-
 builtin/revert.c                     |   6 +-
 builtin/rm.c                         |   1 +
 builtin/submodule--helper.c          |   1 +
 builtin/update-index.c               |   1 +
 builtin/write-tree.c                 |   1 +
 cache-tree.h                         |   2 +-
 cache.h                              |  35 +--
 convert.c                            |   1 -
 diff.h                               |   2 +-
 dir.c                                |   1 -
 git.c                                |   4 +-
 list-objects-filter-options.c        |   2 +-
 list-objects-filter.c                |   7 +-
 list-objects-filter.h                |   1 +
 list-objects.c                       |   3 +
 merge-recursive.c                    | 194 ++++++------
 merge-recursive.h                    |   6 +-
 merge.c                              |   4 +-
 name-hash.c                          |   1 -
 notes-merge.c                        |  16 +-
 notes-merge.h                        |   6 +-
 pathspec.c                           |   1 -
 preload-index.c                      |  11 +-
 read-cache.c                         |  44 ++-
 ref-filter.c                         |   2 +-
 repository.c                         |   9 +
 repository.h                         |  16 +
 rerere.c                             |   8 +-
 rerere.h                             |   2 +-
 revision.c                           |  12 +-
 revision.h                           |   2 +-
 sequencer.c                          | 435 +++++++++++++++------------
 sequencer.h                          |  27 +-
 sha1-name.c                          |  56 ++--
 submodule.c                          |   1 -
 t/helper/test-dump-fsmonitor.c       |   4 +-
 t/helper/test-dump-untracked-cache.c |   1 +
 t/helper/test-tool.h                 |   1 +
 transport.c                          |   7 +-
 transport.h                          |   3 +-
 tree.c                               |   1 -
 unpack-trees.c                       |   1 -
 wt-status.c                          |  97 +++---
 wt-status.h                          |  21 +-
 84 files changed, 673 insertions(+), 508 deletions(-)

-- 
2.19.1.647.g708186aaf9

