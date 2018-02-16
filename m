Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EECC1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756576AbeBPRqf (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 12:46:35 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47035 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756565AbeBPRqd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 12:46:33 -0500
Received: by mail-pg0-f65.google.com with SMTP id a11so2938615pgu.13
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eh1958kaGOHuoMDDhuRsO+eoXgg8lYSH20CNhMI3NwM=;
        b=lP8sIuR+hhf0a1WvcabyEdWr7y7Xvp783/YrigiJOZy+ssDOFWz7fF4JAOCmbWTFXJ
         2LkOj0mWNRT6Of4dpmun+9R1Q7HWLWJH8avmfOV0yvM4vnWlfZWHszY8MMVkXjHQEWRV
         0mlCASzMRNNobohCzqp9ndrjJMaRBajrG0z+z4BYPdteWqwvIg3Y9FXCp15Lb4Du8pzO
         M5olduIF1c5ADJLGfxZ5HR4xALqaF9ZetD50tKF01fcRPqRNqxazW5BJCJU4z4SICTDD
         km0wqPlH3u+2gjxHnjoVD2OOJT10BX0dbJFW+h+QbjpnE1tSgRZ1Aqgw0dWBdO0pcysc
         qTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eh1958kaGOHuoMDDhuRsO+eoXgg8lYSH20CNhMI3NwM=;
        b=LdowFFShOlzfOBMk1VuVepjv5hpoqWv/BXIgzbHVHD+syDJyMUweAwkjQQ27+YBD+o
         btxEakh/WxqTZAd/ZmSALrqOWkgnGjF0Y2ylKSmzi1d7awcW1LgG57f3WvWcX8xQNIiJ
         TDYsbZ2A5xoi7falj8/QRpAbrBmy05qwp9yJXOb9Ow2ZJmadAaROewTGbCOzDpCFAd4j
         hkJ504z1JISkGVu6/3vDTSG0vppxMLbxvkQgmnebfYr1TVKN053hiVXjyf1K4PZ7DV0w
         DmhHDkkA37d9ZBLao2wM57R64jjpZQS/lyYXtJhXvMxMi7zKDmGvXcQMxmdW7HzgizWs
         5inw==
X-Gm-Message-State: APf1xPC2Jot2eZzysH+lW3saSdH0ZPEDF/yJoTXQveS+flmLwFpfD1IQ
        VAPqhSZaAcf+2CGPJqegDDAlxg==
X-Google-Smtp-Source: AH8x224Ybd7UUtPapUOUh59+iSAEZWU9pkjcyx/t1MMQCDGQhSKPiQ5jgrQZ+HQSHrxYiVjTURu2GQ==
X-Received: by 10.99.47.132 with SMTP id v126mr5771637pgv.129.1518803192711;
        Fri, 16 Feb 2018 09:46:32 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h15sm8726639pfi.56.2018.02.16.09.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 09:46:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, pclouds@gmail.com,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCHv2 00/16] Moving global state into the repository object (part 1)
Date:   Fri, 16 Feb 2018 09:46:10 -0800
Message-Id: <20180216174626.24677-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* duplicated the 'ignore_env' bit into the object store as well
* the #define trick no longer works as we do not have a "the_objectstore" global,
  which means there is just one patch per function that is converted.
  As this follows the same structure of the previous series, I am still confident
  there is no hidden dependencies to globals outside the object store in these
  converted functions.
* rebased on top of current master, resolving the merge conflicts.
  I think I used the list.h APIs right, but please double check.
  
Thanks,
Stefan

v1:
This is a real take on the first part of the recent RFC[1].

Jonathan Tan suggested[2] that "sha1_loose_object_info to handle arbitrary repositories"
might be a good breaking point for a first part at that RFC at patch 38.
This series is smaller and contains only 26 patches as the patches in the big
RFC were slightly out of order.

I developed this series partly by writing patches, but mostly by cherrypicking
from that RFC on top of current master. I noticed no external conflicts apart
from one addition to the repositories _INIT macro, which was easy to resolve.

Comments in the early range of that RFC were on 003 where Junio pointed out
that the coccinelle patch ought to be not in contrib/coccinelle, so I put it
in a sub directory there, as 'make coccicheck' doesn't traverse subdirs.

brian had a questoin on patch 25 in the RFC, but that seemed to resolve itself
without any suggestion to include into this series[3].

Duy suggested that we shall not use the repository blindly, but should carefully
examine whether to pass on an object store or the refstore or such[4], which
I agree with if it makes sense. This series unfortunately has an issue with that
as I would not want to pass down the `ignore_env` flag separately from the object
store, so I made all functions that only take the object store to have the raw
object store as the first parameter, and others using the full repository.

Eric Sunshine brought up memory leaks with the RFC, and I would think to
have plugged all holes.

[1] https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
[2] https://public-inbox.org/git/20180207143300.ce1c39ca07f6a0d64fe0e7ca@google.com/
[3] https://public-inbox.org/git/20180206011940.GD7904@genre.crustytoothpaste.net/
[4] https://public-inbox.org/git/CACsJy8CGgekpX4cZkyyTSPrj87uQVKZSOL7fyT__P2dh_1LmVQ@mail.gmail.com/

Thanks,
Stefan

Stefan Beller (16):
  repository: introduce raw object store field
  object-store: move alt_odb_list and alt_odb_tail to object store
  object-store: free alt_odb_list
  object-store: move packed_git and packed_git_mru to object store
  object-store: close all packs upon clearing the object store
  pack: move prepare_packed_git_run_once to object store
  pack: move approximate object count to object store
  sha1_file: add raw_object_store argument to alt_odb_usable
  sha1_file: allow link_alt_odb_entries to handle arbitrary object
    stores
  sha1_file: allow prepare_alt_odb to handle arbitrary object stores
  sha1_file: allow sha1_file_name to handle arbitrary object stores
  sha1_file: allow stat_sha1_file to handle arbitrary object stores
  sha1_file: allow open_sha1_file to handle arbitrary object stores
  sha1_file: allow map_sha1_file_1 to handle arbitrary object stores
  sha1_file: allow map_sha1_file to handle arbitrary object stores
  sha1_file: allow sha1_loose_object_info to handle arbitrary object
    stores

 builtin/am.c             |   2 +-
 builtin/clone.c          |   2 +-
 builtin/count-objects.c  |   6 +-
 builtin/fetch.c          |   2 +-
 builtin/fsck.c           |  13 +++--
 builtin/gc.c             |   4 +-
 builtin/grep.c           |   2 +-
 builtin/index-pack.c     |   1 +
 builtin/merge.c          |   2 +-
 builtin/pack-objects.c   |  19 +++---
 builtin/pack-redundant.c |   6 +-
 builtin/receive-pack.c   |   3 +-
 cache.h                  |  45 ++------------
 environment.c            |   5 +-
 fast-import.c            |   6 +-
 http-backend.c           |   6 +-
 http-push.c              |   1 +
 http-walker.c            |   4 +-
 http.c                   |   6 +-
 object-store.h           |  80 +++++++++++++++++++++++++
 object.c                 |  27 +++++++++
 pack-bitmap.c            |   4 +-
 pack-check.c             |   1 +
 pack-revindex.c          |   1 +
 packfile.c               |  64 ++++++++++----------
 packfile.h               |   2 +-
 path.c                   |   2 +-
 reachable.c              |   1 +
 repository.c             |  22 +++++--
 repository.h             |   7 ++-
 server-info.c            |   6 +-
 sha1_file.c              | 123 +++++++++++++++++++++------------------
 sha1_name.c              |  11 ++--
 streaming.c              |   5 +-
 34 files changed, 314 insertions(+), 177 deletions(-)
 create mode 100644 object-store.h

-- 
2.16.1.291.g4437f3f132-goog

