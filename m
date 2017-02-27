Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BC41F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdB0SCM (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34119 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so1364729wrc.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NljBw7FVTNKv490tYyvsLKkKNaGPZiC76lqTi1dMmtI=;
        b=lAkReSun9JxVtbOkkiRbhnuvwUKAd8E5D7CzV7b6gm00sC6m1VoixyaTlE0PZsuItc
         rcmssb52L2ARzsDQveER4wMlNBbtwaCulvgxVc12zau228aK4Gc8qOppBoPab9ZZ6byS
         WTIiqd5sMRdhDbGT/Yf0lb2e4OCixSt/WoeqTEWO3HC8Gu7pYAFwTHRU9rkRqEFfgEBt
         eHEZ8bFZuYvDPrcHGi3Mfil/EHoPzOr2/7PK2ezjhepyrKXe8ZTWaeZ8gN/W0f30kBG+
         azW9VSaRnkuJIkhkgnbmGvU3hdI8URPUxBeh7nlm8iz6Q8JjGjqG4G+VHjo5ziXJv1N2
         iNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NljBw7FVTNKv490tYyvsLKkKNaGPZiC76lqTi1dMmtI=;
        b=gnJwbaqR/bgb60zfyeo9JdY2DwooQ+H1+GM5suYuzD7huCr92ylnaYgUrtOmat8i/j
         a9VP+018bP8OfPJHLfxYqiU8KCqXjqdd42jUd5qXVbE2+esoFieWjvkkd64wFbaEfkmD
         thUX+nkVnC4dPDIBjDTJYyN7RUAcYjtB4gFMOXVzInl8EJc0PE9kqKjxbM7DbdtDZ03f
         1lECuD/uvZtCOFT16b6WZSIoJfwubZb8xljuvoVte3SZ7cfm23kNDW1GU4mwWS/kJ2aa
         Rl8QdrRReMeWRhs/o10SON90gnOHAn9S2qXpO/5q+yPG1cTv/KNw9re36NnwwTlA8n0K
         leZA==
X-Gm-Message-State: AMke39mrQcZXWx4bF7c/Yoq7YZnKL0K/qeevZUgESXg538xyoRf67BY7hlMCXEUWuJAZUQ==
X-Received: by 10.223.142.34 with SMTP id n31mr15166378wrb.11.1488218436247;
        Mon, 27 Feb 2017 10:00:36 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:35 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 00/22] Add configuration options for split-index
Date:   Mon, 27 Feb 2017 18:59:57 +0100
Message-Id: <20170227180019.18666-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~

We want to make it possible to use the split-index feature
automatically by just setting a new "core.splitIndex" configuration
variable to true.

This can be valuable as split-index can help significantly speed up
`git rebase` especially along with the work to libify `git apply`
that has been merged to master
(see https://github.com/git/git/commit/81358dc238372793b1590efa149cc1581d1fbd98)
and is now in v2.11.

Design
~~~~~~

The design is similar as the previous work that introduced
"core.untrackedCache". 

The new "core.splitIndex" configuration option can be either true,
false or undefined which is the default.

When it is true, the split index is created, if it does not already
exists, when the index is read. When it is false, the split index is
removed if it exists, when the index is read. Otherwise it is left as
is.

Along with this new configuration variable, the two following options
are also introduced:

    - splitIndex.maxPercentChange

    This is to avoid having too many changes accumulating in the split
    index while in split index mode. The git-update-index
    documentation says:

	If split-index mode is already enabled and `--split-index` is
	given again, all changes in $GIT_DIR/index are pushed back to
	the shared index file.

    but it is probably better to not expect the user to think about it
    and to have a mechanism that pushes back all changes to the shared
    index file automatically when some threshold is reached.

    The default threshold is when the number of entries in the split
    index file reaches 20% of the number of entries in the shared
    index file. The new "splitIndex.maxPercentChange" config option
    lets people tweak this value.

    - splitIndex.sharedIndexExpire

    To make sure that old sharedindex files are eventually removed
    when a new one has been created, we "touch" the shared index file
    every time a split index file using the shared index file is
    either created or read from. Then we can delete shared indexes
    with an mtime older than one week (by default), when we create a
    new shared index file. The new "splitIndex.sharedIndexExpire"
    config option lets people tweak this grace period.

    This idea was suggested by Duy in:

    https://public-inbox.org/git/CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com/

    and after some experiments, I agree that it is much simpler than
    what I thought could be done during our discussion.

    Junio also thinks that we have to do "time-based GC" in:
 
    https://public-inbox.org/git/xmqqeg33ccjj.fsf@gitster.mtv.corp.google.com/

Note that this patch series doesn't address a leak when removing a
split-index, but Duy wrote that he has a patch to fix this leak:

https://public-inbox.org/git/CACsJy8AisF2ZVs7JdnVFp5wdskkbVQQQ=DBq5UzE1MOsCfBMtQ@mail.gmail.com/

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Except for patch 1/22 and 1/22, there are 3 big steps, one for each
new configuration variable introduced.

There only small differences between this patch series and the v3
patch series sent a few months ago.

    - Patch 1/22 marks a message for translation. It is not new and
      can be applied separately.

    - Patch 2/22 improves the existing indentation style of t1700 by
      using different here document style. It is a new preparatory
      patch suggested by Junio.

Step 1 is:

    - Patches 3/22 to 6/22 introduce the functions that are reading
      the "core.splitIndex" configuration variable and tweaking the
      split index depending on its value.

    - Patch 7/22 adds a few tests for the new feature.

    - Patches 8/22 and 9/22 add some documentation for the new
      feature.

    There is no change since v3 in this step.

Step 2 is:

    - Patches 10/22 and 11/22 introduce the functions that are reading
      the "splitIndex.maxPercentChange" configuration variable and
      regenerating a new shared index file depending on its value.

      Patch 11/12 has a few changes suggested by Junio since v3, see
      https://public-inbox.org/git/CAP8UFD3_1EN=0EsD12Cew1MuW8yhtPAZw0M_g3wmvKFk-uGXxw@mail.gmail.com/

    - Patch 12/22 adds a few tests for the new feature.

    - Patch 13/22 add some documentation for the new feature. The
      added documentation has been reworded a little bit since v3 as
      suggested by Junio.

Step 3 is:

    - Patches 14/22 to 17/22 introduce the functions that are reading
      the "splitIndex.sharedIndexExpire" configuration variable and
      expiring old shared index files depending on its value.

      Patch 15/22 has a few changes suggested by Ramsay and Junio in
      http://public-inbox.org/git/a1a44640-ff6c-2294-72ac-46322eff8505@ramsayjones.plus.com/
      http://public-inbox.org/git/xmqqbmunq6mg.fsf@gitster.mtv.corp.google.com/

      The main change is that the new freshen_shared_index() will now
      warn if the split-index file has been written but the shared
      index file could't be freshened.

      Another change is that in 17/22 the new
      "splitIndex.sharedIndexExpire" config variable now defaults to
      "2.weeks.ago" instead of "one.week.ago" in v3.

    - Patch 18/22 adds a few tests for the new feature. It is changed
      a bit to account for the change in 17/22.

      Also some flakyness in one of the tests has been fixed by using
      a 5 second, instead of 1 second, delay, thanks to Ramsay and
      Peff, see
      http://public-inbox.org/git/818851a6-c3ef-618e-4146-518fbe6bd837@ramsayjones.plus.com/

    - Patches 19/22 and 20/22 were new patches in v3. They update the
      mtime of the shared index file when a split index based on the
      shared index file is read from. 19/22 is a refactoring to make
      the actual change in 20/22 easier.

      Patch 20/22 has been changed a little bit since v3 to take into
      account changes in 17/22.

    - Patches 21/22 and 22/22 add some documentation for the new
      feature. Patch 21/22 has been changed to avoid using "mtime" as
      suggested by Junio.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/config-split-index

The previous versions were:

  RFC: https://github.com/chriscool/git/commits/config-split-index7
  v1:  https://github.com/chriscool/git/commits/config-split-index72
  v2:  https://github.com/chriscool/git/commits/config-split-index99
  v3:  https://github.com/chriscool/git/commits/config-split-index102

On the mailing list the related patch series and discussions were:

  RFC: https://public-inbox.org/git/20160711172254.13439-1-chriscool@tuxfamily.org/
  v1:  https://public-inbox.org/git/20161023092648.12086-1-chriscool@tuxfamily.org/
  v2:  https://public-inbox.org/git/20161217145547.11748-1-chriscool@tuxfamily.org/
  v3:  https://public-inbox.org/git/20161226102222.17150-1-chriscool@tuxfamily.org/

Christian Couder (22):
  config: mark an error message up for translation
  t1700: change here document style
  config: add git_config_get_split_index()
  split-index: add {add,remove}_split_index() functions
  read-cache: add and then use tweak_split_index()
  update-index: warn in case of split-index incoherency
  t1700: add tests for core.splitIndex
  Documentation/config: add information for core.splitIndex
  Documentation/git-update-index: talk about core.splitIndex config var
  config: add git_config_get_max_percent_split_change()
  read-cache: regenerate shared index if necessary
  t1700: add tests for splitIndex.maxPercentChange
  Documentation/config: add splitIndex.maxPercentChange
  sha1_file: make check_and_freshen_file() non static
  read-cache: touch shared index files when used
  config: add git_config_get_expiry() from gc.c
  read-cache: unlink old sharedindex files
  t1700: test shared index file expiration
  read-cache: refactor read_index_from()
  read-cache: use freshen_shared_index() in read_index_from()
  Documentation/config: add splitIndex.sharedIndexExpire
  Documentation/git-update-index: explain splitIndex.*

 Documentation/config.txt           |  29 ++++
 Documentation/git-update-index.txt |  43 ++++-
 builtin/gc.c                       |  15 +-
 builtin/update-index.c             |  25 +--
 cache.h                            |   8 +
 config.c                           |  42 ++++-
 read-cache.c                       | 157 ++++++++++++++++--
 sha1_file.c                        |   2 +-
 split-index.c                      |  22 +++
 split-index.h                      |   2 +
 t/t1700-split-index.sh             | 324 +++++++++++++++++++++++++++----------
 11 files changed, 539 insertions(+), 130 deletions(-)

-- 
2.12.0.22.g0672473d40

