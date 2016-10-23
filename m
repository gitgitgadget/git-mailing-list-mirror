Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE8A720229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756118AbcJWJ1N (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33967 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbcJWJ1L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id d199so5245642wmd.1
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sorFy5fhm+LLROOQ3P0BirgO1nzFKT2rP+NNfvqoW4k=;
        b=RDij5U2a+a4TN0Zprm3FTKc61lWQWK0y/rxarXaSYZ8VVBibcyRLalVLvtjh8lc2mL
         ZUGJA8Vqfi/tFW8uyPBYdMk6JnO/eHnXigBB9LpA0Gfr+5z2zKdoLOp2PPvyt2lwVzEU
         Hio1TWQ5v/Lgh8KU2EPUXa/wjUHX3o01BW/k+YgZKDaREnuHkoVAfzsMJwIuE3Jlt5rn
         Ls1F2Rr48kf+RDQKpx43QkZ3ke8/ZbOizsr77K1A1xW7/cQnYOwmhHPNUj48Dsdlq4Bb
         SYPoHHbXo5Pi/R9OnWekdRjRskKVKs2DEv/TkaW53k4HxYqAmaU0ndPzq/K/p1ETiuKY
         pwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sorFy5fhm+LLROOQ3P0BirgO1nzFKT2rP+NNfvqoW4k=;
        b=V8a/NPjHkDMD2eEjy0PF1fNBzL+F7RZIMy3fh3tYnbMqNXw0hDum8xLCVu1fsegh97
         Qbms+ixFjeP5tcVFbls2XQ09rx4VI9NqjQNVNNTkAbH9kmE7nBBZdD3bIQkHGZpW9fxJ
         nbMvy7VKtVXZ00EEctPiUjx+PMyLKxGOZVuhgpHgCQldZy1WG1/B6oL0nVgl7XK+tZ/D
         7IKrzw7tbmm/SzjDLcvAZRxL0LPRSt7ft6rcJiDBYJEb9VdY9w7qLvf9g0UbZ/n1Tq2o
         zeq7Vu6gY5/n5HCkY2cqqyyKLMpLamlvKosVu/I5obw8SSvTFQW9BdF2uBfuhc0Q99NZ
         05tA==
X-Gm-Message-State: AA6/9RnXV1axQq7d/I8LeGfsESha7dYuFbVB+osojM1yy44sdaGYhdAO2tjUV/oZgMhNmQ==
X-Received: by 10.28.158.209 with SMTP id h200mr17851457wme.54.1477214829830;
        Sun, 23 Oct 2016 02:27:09 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 00/19] Add configuration options for split-index
Date:   Sun, 23 Oct 2016 11:26:29 +0200
Message-Id: <20161023092648.12086-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
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
that has been recently merged to master
(see https://github.com/git/git/commit/81358dc238372793b1590efa149cc1581d1fbd98).

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
    index file reaches 20% (by default) of the number of entries in
    the shared index file. The new "splitIndex.maxPercentChange"
    config option lets people tweak this value.

    - splitIndex.sharedIndexExpire

    To make sure that old sharedindex files are eventually removed
    when a new one has been created, we "touch" the shared index file
    every time it is used by a new split index file. Then we can
    delete shared indexes with an mtime older than one week (by
    default), when we create a new shared index file. The new
    "splitIndex.sharedIndexExpire" config option lets people tweak
    this grace period.

    This idea was suggested by Duy in:

    https://public-inbox.org/git/CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com/

    and after some experiments, I agree that it is much simpler than
    what I thought could be done during our discussion.

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Except for patch 1/19, there are 3 big steps, one for each new
configuration variable introduced.

The main difference between this patch series and the RFC patch series
sent last July is that the Step 2 and 3 are new and have been
implemented as suggested by Duy. Thanks Duy!

    - Patch 1/19 is a typo fix in a comment that can be applied
      separately.

Step 1 is:

    - Patches 2/19 to 5/19 introduce the functions that are reading
      the "core.splitIndex" configuration variable and tweaking the
      split index depending on its value.

    - Patch 6/19 adds a few tests for the new feature.

    - Patches 7/19 and 8/19 add some documentation for the new
      feature.

Step 2 is:

    - Patches 9/19 and 10/19 introduce the functions that are reading
      the "splitIndex.maxPercentChange" configuration variable and
      regenerating a new shared index file depending on its value.

    - Patch 11/19 adds a few tests for the new feature.

    - Patch 12/19 add some documentation for the new feature.

Step 3 is:

    - Patches 13/19 to 16/19 introduce the functions that are reading
      the "splitIndex.sharedIndexExpire" configuration variable and
      expiring old shared index files depending on its value.

    - Patch 17/19 adds a few tests for the new feature.

    - Patches 18/19 and 19/19 add some documentation for the new
      feature.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/config-split-index

The previous RFC version was:

  https://github.com/chriscool/git/commits/config-split-index7

On the mailing list the related patch series and discussions were:

  https://public-inbox.org/git/20160711172254.13439-1-chriscool@tuxfamily.org/

Christian Couder (19):
  split-index: s/eith/with/ typo fix
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
  config: add git_config_get_date_string() from gc.c
  read-cache: unlink old sharedindex files
  t1700: test shared index file expiration
  Documentation/config: add splitIndex.sharedIndexExpire
  Documentation/git-update-index: explain splitIndex.*

 Documentation/config.txt           |  28 +++++++
 Documentation/git-update-index.txt |  39 ++++++++--
 builtin/gc.c                       |  15 +---
 builtin/update-index.c             |  25 +++---
 cache.h                            |   6 ++
 config.c                           |  39 ++++++++++
 read-cache.c                       | 119 +++++++++++++++++++++++++++-
 sha1_file.c                        |   2 +-
 split-index.c                      |  24 +++++-
 split-index.h                      |   2 +
 t/t1700-split-index.sh             | 154 +++++++++++++++++++++++++++++++++++++
 11 files changed, 417 insertions(+), 36 deletions(-)

-- 
2.10.1.462.g7e1e03a

