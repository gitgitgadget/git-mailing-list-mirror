Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B9C1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755562AbcGKRXV (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:23:21 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36555 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbcGKRXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:23:20 -0400
Received: by mail-wm0-f42.google.com with SMTP id f126so99170633wma.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 10:23:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fi+sHxG8zVVHCF8SIspSHO2aPtv/3g1AE0BTkN7aY1U=;
        b=QlhCOQ9KCGIL3Koczw8eRGD5fCaVTMpiDHS2yKX80VeQNkGjmSD/96EuvoKTg5VVma
         TkPX5hX2d5qYyzyflKo9qOrgcGxuZhjkTz3Mva+jQ0tdE3mc+JRYSn4uRFxkUiQSIxDt
         PnLarhIjBbX/RXGVuaoiO8kTaB5WhEXXUJ7rz9xsYCKjvTVUNEgjNfsZhaFJkQSpMA74
         OEH2YHkew2MJ157er3o7S9DPwyrJb64f68+ZxTbDonqnH44yQfO9w5HSP1WzvntI7/4O
         WiX0B2gSsowolxuf7hz1R+rp61U5g97u6qjmW7qRLnYlI4yO5ReCfw4Ox6iQoQY22cWd
         i73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fi+sHxG8zVVHCF8SIspSHO2aPtv/3g1AE0BTkN7aY1U=;
        b=TREFpKYPyQMi4NFMkFEzvijMEw8haGgZ9j4qQLUTbh3VaLB8BZZunz7lPw5xRH2co2
         dyNZcXGXgkLcmfHkQoitt5/B6O/8jvpwz74kWM2bMx2AHeDTL/1fXrsZN9qZqBlnaxPg
         ZdRTXuOHhDKYFzaXsFbbMvkpLyeDF6f550jUhz1sS3KYAYHocyIyLvL7vU5mJsn8oF9e
         CWraa6Bfvf0qMfY8oLPa/ypBBb/bQWwsOoQUmCc+39kqrpCqjlOQjGrWq2lrw6C+AjTf
         VQNQWQYQ/o/kXweEr1/VMf1djkxZx8yNpRqN3rGuilPjh68Bp2BHZCfWPRFHTsEIg8Xw
         kaCA==
X-Gm-Message-State: ALyK8tKBH834aaDM63gp0Xml7Xcgk/xCdkXBeZbC0y+8xBnKoIjpND+6381E2tYq61S3Mg==
X-Received: by 10.194.30.4 with SMTP id o4mr836542wjh.110.1468257798356;
        Mon, 11 Jul 2016 10:23:18 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id si2sm829442wjb.19.2016.07.11.10.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jul 2016 10:23:17 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 0/8] Add configuration options for split-index
Date:	Mon, 11 Jul 2016 19:22:46 +0200
Message-Id: <20160711172254.13439-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.250.g7087ccc.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Goal
~~~~

We want to make it possible to use the split-index feature
automatically by just setting a new "core.splitIndex" configuration
variable to true.

This can be valuable as split-index can help significantly speed up
`git rebase` especially along with the current work to libify `git
apply`.

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

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    - Patches 1/8 to 4/8 introduce the functions that are reading the
      configuration variable and tweaking the split index depending on
      its value.

    - Patches 5/8 and 6/8 add some documentation for the new feature.

    - Patch 7/8 adds a few simple tests.

    - Patch 8/8 cleans up the old "sharedindex.XXXX" previously
      created by split-index.

Future work
~~~~~~~~~~~

One thing that is probably missing is a mechanism to avoid having too
many changes accumulating in the (split) index while in split index
mode. The git-update-index documentation says:

	If split-index mode is already enabled and `--split-index` is
	given again, all changes in $GIT_DIR/index are pushed back to
	the shared index file.

but it is probably better to not expect the user to think about it and
to have a mechanism that pushes back all changes to the shared index
file automatically when some threshold is reached. The threshold could
be for example when $GIT_DIR/index size is larger than 25% of the
shared index size. Opinions, test results or test ideas are welcome on
this.

Links
~~~~~

The last iteration of the git apply libification patch series is
there:

http://thread.gmane.org/gmane.comp.version-control.git/298344/

This patch series is also available here:

https://github.com/chriscool/git/commits/config-split-index


Christian Couder (8):
  config: add git_config_get_split_index()
  split-index: add {add,remove}_split_index() functions
  read-cache: add and then use tweak_split_index()
  update-index: warn in case of split-index incoherency
  Documentation/config: add information for core.splitIndex
  Documentation/git-update-index: talk about core.splitIndex config var
  t1700: add tests for core.splitIndex
  read-cache: unlink old sharedindex files

 Documentation/config.txt           |  4 ++++
 Documentation/git-update-index.txt |  6 ++++++
 builtin/update-index.c             | 20 ++++++++---------
 cache.h                            |  1 +
 config.c                           | 10 +++++++++
 read-cache.c                       | 44 +++++++++++++++++++++++++++++++++++++-
 split-index.c                      | 18 ++++++++++++++++
 split-index.h                      |  2 ++
 t/t1700-split-index.sh             | 44 ++++++++++++++++++++++++++++++++++++++
 9 files changed, 138 insertions(+), 11 deletions(-)

-- 
2.9.0.250.g7087ccc.dirty

