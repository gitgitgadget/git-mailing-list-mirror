Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C991FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757032AbcLQO4E (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:04 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32827 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbcLQO4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so10582413wmu.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+cjlMXkLljXHta+5PKr0Umi3tMtFov3rkjjeeYhWOYA=;
        b=cSf62yZuYxjZrxYb6E9Gs37LQPBMejhte2xlvIaBroHJfY8JnnYV7c6O1uDDOAWS3f
         EVSSkigwDwa9mu4n+9AikRzBJWciYQjVoe0qCU1JLMx+Qf90Cbxmmy/YGEWI0EbswIW1
         XKy1dYeK+4vglsaKls/5Vc5da/fWtk+b68QtQvav2MaVv+o2URji8geRBLki3eSxM6zM
         UGXZVq2DcTeu5WoizWDYd9FO1FWQzYlemEsoW/2vnRAB4xP7ytT6skt23norszhs/RQQ
         8N88J7gtWh0rYNdeNf5XIdfG4FO1Li5y8jvaKMnbjCyS7HiyZ42ksFwejCu4qSuHoeqq
         MtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+cjlMXkLljXHta+5PKr0Umi3tMtFov3rkjjeeYhWOYA=;
        b=jNoRAh+cztDCE4Kak1Q1dzXocGqn95RBhxiA9/XE1ox/MOiEcBZttm2AHBduQEMfoh
         bfacrvXE88qsF9/p/brSCLVsFJIref/sCmRNXKWzuuyQN+jTfRW53+ayvpnUlhsM5Oo9
         QlAKkhR+l32RPGQakOFjpjfuVHEfWGpMeuJYQznrEPKdlfphokhru5aeWNuQ7t2KZ9pu
         OvXpVuZYtqW9bD92IxerqOTFka/1o3VF7DSrl7dfcxusAAKkyhoLyTgUtqpWOKB56DDQ
         w3VFSlTrbJMJNCLsJW5HE8KteOggU+SRiQc6h2KRa1xpQKvEPMz4AKJjI9stZsWRb9u8
         UT6A==
X-Gm-Message-State: AIkVDXJmpT2YCgEax9QHHgOeT6mZNGN0ot+SCXkSqtpMeb5AHq2N+YD38ypN1aDARLDAnQ==
X-Received: by 10.28.153.201 with SMTP id b192mr7207721wme.61.1481986561965;
        Sat, 17 Dec 2016 06:56:01 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:00 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/21] Add configuration options for split-index
Date:   Sat, 17 Dec 2016 15:55:26 +0100
Message-Id: <20161217145547.11748-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
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

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Except for patch 1/21, there are 3 big steps, one for each new
configuration variable introduced.

The main difference between this patch series and the v1 patch series
sent last October is that Step 3 has a few new commits to also update
the mtime of the shared index file when a split index based on the
shared index file is read from.

    - Patch 1/21 marks a message for translation. It is a new patch
      and it can be applied separately. (The patch 1/19 in v1, which
      was a typo fix, has been merged separately into master already.)

Step 1 is:

    - Patches 2/21 to 5/21 introduce the functions that are reading
      the "core.splitIndex" configuration variable and tweaking the
      split index depending on its value.

    - Patch 6/21 adds a few tests for the new feature.

    - Patches 7/21 and 8/21 add some documentation for the new
      feature.

    The only change since v1 in this step is that some warning
    messages in 5/21 have been marked for translation as suggested
    by Duy.

Step 2 is:

    - Patches 9/21 and 10/21 introduce the functions that are reading
      the "splitIndex.maxPercentChange" configuration variable and
      regenerating a new shared index file depending on its value.

    - Patch 11/21 adds a few tests for the new feature.

    - Patch 12/21 add some documentation for the new feature.

    The changes since v1 in this step are:

        - an error message has been marked for translation in 9/21,
        - camelCase is used in the same error message as suggested by
          Duy in 9/21,
	- "return error(...)" is now used as suggested by Junio in
          9/21,
	- too_many_not_shared_entries() is now "static" as suggested
          by Ramsay in 10/21,
	- changes made in write_locked_index() have been reorganized
          as suggested by Duy in 10/21,

Step 3 is:

    - Patches 13/21 to 16/21 introduce the functions that are reading
      the "splitIndex.sharedIndexExpire" configuration variable and
      expiring old shared index files depending on its value.

    - Patch 17/21 adds a few tests for the new feature.

    - Patches 18/21 and 19/21 are new patches. They update the mtime
      of the shared index file when a split index based on the shared
      index file is read from. 18/21 is a refactoring to make the
      actual change in 19/21 easier.

    - Patches 20/21 and 21/21 add some documentation for the new
      feature.

    The changes since v1 in this step are:

	- a warning was removed from 14/21 as suggested by Junio,
	- code to touch the shared index file as been refactored into
          a function in 14/21,
	- a function has been renamed git_config_get_expiry() in 15/21
          as suggested by Junio,
        - error messages have been marked for translation in 16/21 as
          suggested by Duy,
	- "return error_errno(...)" is now used as suggested by Duy in
          16/21,
        - patches 18/21 and 19/21 are new following Duy's suggestion,
	- patches 20/21 and 21/21 are updated to take changes made in
	  19/21 into account.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/config-split-index

The previous versions were:

  RFC: https://github.com/chriscool/git/commits/config-split-index7
  v1:  https://github.com/chriscool/git/commits/config-split-index72

On the mailing list the related patch series and discussions were:

  RFC: https://public-inbox.org/git/20160711172254.13439-1-chriscool@tuxfamily.org/
  v1:  https://public-inbox.org/git/20161023092648.12086-1-chriscool@tuxfamily.org/

Christian Couder (21):
  config: mark an error message up for translation
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

 Documentation/config.txt           |  28 +++++++
 Documentation/git-update-index.txt |  43 +++++++++--
 builtin/gc.c                       |  15 +---
 builtin/update-index.c             |  25 +++---
 cache.h                            |   8 ++
 config.c                           |  42 +++++++++-
 read-cache.c                       | 142 ++++++++++++++++++++++++++++++++--
 sha1_file.c                        |   2 +-
 split-index.c                      |  22 ++++++
 split-index.h                      |   2 +
 t/t1700-split-index.sh             | 154 +++++++++++++++++++++++++++++++++++++
 11 files changed, 441 insertions(+), 42 deletions(-)

-- 
2.11.0.53.gb263787

