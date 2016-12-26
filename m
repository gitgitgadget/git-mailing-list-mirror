Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EC5200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754392AbcLZKWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:35 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32788 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbcLZKWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:34 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so48028592wjc.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oDsuaxodsqhvbHzN0sptKoRpKuxWJpz9ek/Vd49kwCg=;
        b=qBT9jZDArYHTDMcRn0oszyscULyBolNGTVxhxQ5HnRyWdttBEIQthmf9DRbl/OkVYq
         vpDxjopbfgIxil86LYXb+iBPiWmvCvruoSHR+1WW5GLIwvi27Oylkr6v4X1iy/ehHrfz
         Q63zFqQrJuumJvxvoYF0XQXn3enKJq2Ptypsz0wc3xxXU1Ls8msnsHTZzvCqIeFVLKlH
         uNwvanbMTnewf2BESZQZyWHXQCcUo+XIdR/0psUO4BHGfVr5yrgDT6WDRMPd1eJJXQ/U
         zo1Wn0U8zSs5GuVZri1J1szI0ONyFrpne+41SxqwiF4ESxy80ZANuSaXriCCnOzBurLz
         E1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oDsuaxodsqhvbHzN0sptKoRpKuxWJpz9ek/Vd49kwCg=;
        b=RJUua2Zan2mJB4K355L8TqRd7ZOPxn2fuo315Or1scSBP5mhbCReXmb7DALw6yklk4
         bockArTkUCMNm8hh86FbQbLeGqvjSOvHD2VmOmljr8MW1hFH2GiaujnaLGocpP0Ef1qj
         4sSbhpwFkveo8Kyvdcz3p15IUmUjNOQLlFxFmUFpBTlinxEqJU+yIzuAzO8nBhVHNxx3
         zap/NdXZ4/j+i1Ct8xiysdj3RPpE9RUFD4g9iTL3+zAmOPpcPRLDH3bl2lJ0SS3ReMcr
         uW+7peGZnD7ZQ5yKAYiSbHMpjnJXRCqFHjWkfGsOEpGgXJrtPcJfhtGpsbEpRSUdVeN3
         ezAA==
X-Gm-Message-State: AIkVDXLAlSAK02OjiO0AIKqPZgl2PTxrrf17ZBKGHojP8VCICae/IddHyL45fxg3l9+1eQ==
X-Received: by 10.194.71.69 with SMTP id s5mr23261394wju.197.1482747752737;
        Mon, 26 Dec 2016 02:22:32 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:32 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 00/21] Add configuration options for split-index
Date:   Mon, 26 Dec 2016 11:22:01 +0100
Message-Id: <20161226102222.17150-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
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

Except for patch 1/21, there are 3 big steps, one for each new
configuration variable introduced.

There only a few small differences between this patch series and the
v2 patch series sent a few weeks ago. Only two commits have been
changed a little, as suggested by Duy.

    - Patch 1/21 marks a message for translation. It was a new patch
      in v2 and it can be applied separately. (The patch 1/19 in v1,
      which was a typo fix, has been merged separately into master
      already.)

Step 1 is:

    - Patches 2/21 to 5/21 introduce the functions that are reading
      the "core.splitIndex" configuration variable and tweaking the
      split index depending on its value.

    - Patch 6/21 adds a few tests for the new feature.

    - Patches 7/21 and 8/21 add some documentation for the new
      feature.

    The only change since v2 in this step is that an unnecessary
    variable initialization has been droped in 2/21, as suggested by
    Duy.

Step 2 is:

    - Patches 9/21 and 10/21 introduce the functions that are reading
      the "splitIndex.maxPercentChange" configuration variable and
      regenerating a new shared index file depending on its value.

    - Patch 11/21 adds a few tests for the new feature.

    - Patch 12/21 add some documentation for the new feature.

    There are no changes in this step since v2.

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

    The only change since v2 in this step is that the full shared
    index path is passed to the can_delete_shared_index() function in
    16/21 as suggested by Duy.

Links
~~~~~

This patch series is also available here:

  https://github.com/chriscool/git/commits/config-split-index

The previous versions were:

  RFC: https://github.com/chriscool/git/commits/config-split-index7
  v1:  https://github.com/chriscool/git/commits/config-split-index72
  v2:  https://github.com/chriscool/git/commits/config-split-index99

On the mailing list the related patch series and discussions were:

  RFC: https://public-inbox.org/git/20160711172254.13439-1-chriscool@tuxfamily.org/
  v1:  https://public-inbox.org/git/20161023092648.12086-1-chriscool@tuxfamily.org/
  v2:  https://public-inbox.org/git/20161217145547.11748-1-chriscool@tuxfamily.org/

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
 read-cache.c                       | 143 ++++++++++++++++++++++++++++++++--
 sha1_file.c                        |   2 +-
 split-index.c                      |  22 ++++++
 split-index.h                      |   2 +
 t/t1700-split-index.sh             | 154 +++++++++++++++++++++++++++++++++++++
 11 files changed, 442 insertions(+), 42 deletions(-)

-- 
2.11.0.209.gda91e66374.dirty

