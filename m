Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD411FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 10:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbdCFKQz (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 05:16:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36018 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbdCFKPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 05:15:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id v190so12865063wme.3
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 02:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hBQ84JKIP4c0fHhV1tKYF0jlD9wJqeY4A8Yhgdi9adE=;
        b=ZDRpLmBgW8EhTFv4MvVQYyG+52B/dkWtp5a60Y17UwtJMcKrcc2n54Xv/F4Hw4fvax
         lsouXnyhwMfEQtDwO0tzhGQX8HcU4g8jKkWyBLCdeRN0NhtZa0X93KteSWis5+CFXWOm
         eQ6HRHx9+1U5IxX1C8fi7+kroipJUC5yZ1KAaa9XwWXyo4/3Kc81v2AvGU+tSCIalgOl
         zdSVrKceKYBSEDdGwxc/DdmJTfd3nWY8hjiHloXS2IKLWdCGisP6QLsOCF+pe8opU9BJ
         APfFtMWcJzbfdeqM0Wb+nGkAxQ7xUMxL1oJL9DEHdGMkq7RK0VsmroEag3uNnmvaWBdO
         12Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hBQ84JKIP4c0fHhV1tKYF0jlD9wJqeY4A8Yhgdi9adE=;
        b=VZFQxlRjWMx5pWVbspzIqI9cIxhnotSBD8NbR95g6u1ahNz8UDzVI0yRQmhfVlzy9S
         c0p2VlwV8RzcUAHKgXvpJmyUEqtaYQc30U6SrZYEQ5Nns8GT/4c45XyfmdTBUHyUJGau
         ODTv1DzXWlVaSnC9IhQ1X/tpB+tmkTTwBykEL+JsqK7qLnVXLFO7/+fdFy6pzdTnwHVr
         u3Oo45XBSiL6j+Xon97aVTi5kF975MA0d/YmdcWSdBNyYtZi4EGM9B3XJPzTOSOqzdTI
         NFllQCyB71FaB0XkGwuhHE7WrTyLRnLgTSUqc3FGNnfErgB6sTkiIqeIECmf9+a6W2Zc
         RL7Q==
X-Gm-Message-State: AMke39kg414euZtJxwHhbKrudk5NVve5hQL6Bs3C1o9jRn1VK/NIw3gJkPYr02W2eJ2o1w==
X-Received: by 10.28.66.77 with SMTP id p74mr13508215wma.107.1488793337309;
        Mon, 06 Mar 2017 01:42:17 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:15 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 00/22] Add configuration options for split-index
Date:   Mon,  6 Mar 2017 10:41:41 +0100
Message-Id: <20170306094203.28250-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
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
    with an mtime older than two weeks (by default), when we create a
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

There are very few and very small differences between this patch
series and the v4 patch series sent a few weeks ago. The small
differences are all in patches 15/22 and 17/22. The other patches are
the same as in v4.

Except for patch 1/22 and 2/22, there are 3 big steps, one for each
new configuration variable introduced.

    - Patch 1/22 marks a message for translation and can be applied
      separately.

    - Patch 2/22 improves the existing indentation style of t1700 by
      using different here document style.

Step 1 is:

    - Patches 3/22 to 6/22 introduce the functions that are reading
      the "core.splitIndex" configuration variable and tweaking the
      split index depending on its value.

    - Patch 7/22 adds a few tests for the new feature.

    - Patches 8/22 and 9/22 add some documentation for the new
      feature.

Step 2 is:

    - Patches 10/22 and 11/22 introduce the functions that are reading
      the "splitIndex.maxPercentChange" configuration variable and
      regenerating a new shared index file depending on its value.

    - Patch 12/22 adds a few tests for the new feature.

    - Patch 13/22 add some documentation for the new feature.

Step 3 is:

    - Patches 14/22 to 17/22 introduce the functions that are reading
      the "splitIndex.sharedIndexExpire" configuration variable and
      expiring old shared index files depending on its value.

      In patch 15/22 a warning message starts with "could" instead of
      "Could" as suggested by Junio.

      In patch 17/22, can_delete_shared_index() has been renamed
      should_delete_shared_index() and error_errno() has been changed
      to warning_errno() as suggested by Junio.

    - Patch 18/22 adds a few tests for the new feature.

    - Patches 19/22 and 20/22 update the mtime of the shared index
      file when a split index based on the shared index file is read
      from. 19/22 is a refactoring to make the actual change in 20/22
      easier.

    - Patches 21/22 and 22/22 add some documentation for the new
      feature.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/config-split-index

The previous versions were:

  RFC: https://github.com/chriscool/git/commits/config-split-index7
  v1:  https://github.com/chriscool/git/commits/config-split-index72
  v2:  https://github.com/chriscool/git/commits/config-split-index99
  v3:  https://github.com/chriscool/git/commits/config-split-index102
  v4:  https://github.com/chriscool/git/commits/config-split-index121

On the mailing list the related patch series and discussions were:

  RFC: https://public-inbox.org/git/20160711172254.13439-1-chriscool@tuxfamily.org/
  v1:  https://public-inbox.org/git/20161023092648.12086-1-chriscool@tuxfamily.org/
  v2:  https://public-inbox.org/git/20161217145547.11748-1-chriscool@tuxfamily.org/
  v3:  https://public-inbox.org/git/20161226102222.17150-1-chriscool@tuxfamily.org/
  v4:  https://public-inbox.org/git/20170227180019.18666-1-chriscool@tuxfamily.org/

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
 builtin/gc.c                       |  18 +--
 builtin/update-index.c             |  25 +--
 cache.h                            |   8 +
 config.c                           |  42 ++++-
 read-cache.c                       | 157 ++++++++++++++++--
 sha1_file.c                        |   2 +-
 split-index.c                      |  22 +++
 split-index.h                      |   2 +
 t/t1700-split-index.sh             | 324 +++++++++++++++++++++++++++----------
 11 files changed, 540 insertions(+), 132 deletions(-)

-- 
2.12.0.206.g74921e51d6.dirty

