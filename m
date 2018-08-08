Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12601F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeHHVUR (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37638 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeHHVUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so2931445wrr.4
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sw7kBEPRPKLnYaUtl9DyQrDFSkDu77JarsgvJYm08QM=;
        b=mvoM5d6U44thrf/b5Ag6DDoyTa9R67do036K2eQhmg0+jAlbqpnC8xY5zak3L84GVA
         WK4wSBsTzndCDeAefpUNrNB0yJDbfCa/lyWgnA3fPHUjMxbBEcx7kOOxuMrO6lWN05Cl
         qBZ/SFUUv5FBhvRAdPWFMj9b+N9yQS6VfSk56ycizuwXGlPUhc9zSulfYTqW2g91Jpz+
         1DL6jYFdy3NV1K0n4rrEpZzZeDbGYyLm5Y5xvQhn6d+vDnKM6LcflRu4HqGodT9bx2FD
         hVwAl7OXw7NPV9o3F6i7pigt4V/Bpe7EOnsLZ0Zchsa835zZRip7rpv7CbKiImKLCQIC
         RI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sw7kBEPRPKLnYaUtl9DyQrDFSkDu77JarsgvJYm08QM=;
        b=ZSXd8Ekr9jp/zX2MeKabpFF0rYIXMPC5NIDrXX356jaUMf9E2YV+danNF4uS/pf7+y
         M+RbQ+VLpsGgqcpNBFor9CQOmDNm022y1hF4/qMMb5AbnCZBqpAcwDnRMoG9lZMgCGGE
         txxHwAF8hgYaKzjI21pBjJDgzn6ZqdsR/v3y2zMlXBw+SCSB2ONDE7Qqz9XrHS6IUq7V
         PKrn132O3O38hEIjfo2ZvxBbP81YQiU7SwWCLO5Cjkk0YSZHw2dUpzfSCuhZ2crW/CYP
         J32BlPkM7EBz5ui9r09cGLNqWpUOvTAlxeQVtK+xd53bStcWi1zoD4baRstiFGgReib0
         yHxA==
X-Gm-Message-State: AOUpUlESuHtkIBkrEkoVbDhXl5KJQpcsLI6U2toBi2uSoZPoRkLoX0E4
        Kw+996p1hZp4csBHHmY7mKaNjAIC
X-Google-Smtp-Source: AA+uWPxIP/ZoOSzuM9ClmSByFupJoT4EKZFk24jsGKPjVkRc8a5lWWCdfqG94DdzADFm1O2yBRcZrQ==
X-Received: by 2002:adf:a401:: with SMTP id d1-v6mr2645873wra.121.1533754754892;
        Wed, 08 Aug 2018 11:59:14 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:14 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 00/26] Convert "git stash" to C builtin
Date:   Wed,  8 Aug 2018 21:58:39 +0300
Message-Id: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Here is the whole `git stash` C version. Some of the previous
patches were already reviewed (up to and including "stash: convert
store to builtin"), but there are some which were not
(starting with "stash: convert create to builtin").

In order to see the difference between the shell version and
the C version, I ran `time` on:

* git test suite (t3903-stash.sh, t3904-stash-patch.sh,
t3905-stash-include-untracked.sh and t3906-stash-submodule.sh)

        t3903-stash.sh:
        ** SHELL: 12,69s user 9,95s system 109% cpu 20,730 total
        **     C:  2,67s user 2,84s system 105% cpu  5,206 total

        t3904-stash-patch.sh:
        ** SHELL: 1,43s user 0,94s system 106% cpu 2,242 total
        **     C: 1,01s user 0,58s system 104% cpu 1,530 total

        t3905-stash-include-untracked.sh
        ** SHELL: 2,22s user 1,73s system 110% cpu 3,569 total
        **     C: 0,59s user 0,57s system 106% cpu 1,085 total

        t3906-stash-submodule.sh
        ** SHELL: 2,89s user 2,99s system 106% cpu 5,527 total
        **     C: 2,21s user 2,61s system 105% cpu 4,568 total

        TOTAL:
        ** SHELL: 19.23s user 15.61s system
        **     C:  6.48s user  6.60s system

* a git repository with 4000 files: 1000 not changed,
1000 staged files, 1000 unstaged files, 1000 untracked.
In this case I ran some of the most used commands:

        git stash push:

        ** SHELL: 0,12s user 0,21s system 101% cpu 0,329 total
        **     C: 0,06s user 0,13s system 105% cpu 0,185 total

        git stash push -u:

        ** SHELL: 0,18s user 0,27s system  108% cpu 0,401 total
        **     C: 0,09s user 0,19s system  103% cpu 0,267 total

        git stash pop:

        ** SHELL: 0,16s user 0,26s system 103% cpu 0,399 total
        **     C: 0,13s user 0,19s system 102% cpu 0,308 total

Best regards,
Paul Ungureanu


Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Paul-Sebastian Ungureanu (21):
  sha1-name.c: added 'get_oidf', which acts like 'get_oid'
  stash: update test cases conform to coding guidelines
  stash: renamed test cases to be more descriptive
  stash: implement the "list" command in the builtin
  stash: convert show to builtin
  stash: change `git stash show` usage text and documentation
  stash: refactor `show_stash()` to use the diff API
  stash: update `git stash show` documentation
  stash: convert store to builtin
  stash: convert create to builtin
  stash: replace spawning a "read-tree" process
  stash: avoid spawning a "diff-index" process
  stash: convert push to builtin
  stash: make push to be quiet
  stash: add tests for `git stash push -q`
  stash: replace spawning `git ls-files` child process
  stash: convert save to builtin
  stash: convert `stash--helper.c` into `stash.c`
  stash: optimize `get_untracked_files()` and `check_changes()`
  stash: replace all `write-tree` child processes with API calls
  stash: replace all "git apply" child processes with API calls

 Documentation/git-stash.txt |    7 +-
 Makefile                    |    2 +-
 builtin.h                   |    1 +
 builtin/stash.c             | 1562 +++++++++++++++++++++++++++++++++++
 cache.h                     |    1 +
 git-stash.sh                |  752 -----------------
 git.c                       |    1 +
 sha1-name.c                 |   19 +
 t/t3903-stash.sh            |  190 +++--
 9 files changed, 1714 insertions(+), 821 deletions(-)
 create mode 100644 builtin/stash.c
 delete mode 100755 git-stash.sh

-- 
2.18.0.573.g56500d98f

