Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E961F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbeIZEoF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35616 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeIZEoE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id y21-v6so204465edr.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EGu5BaMF48W6ZcnKtxx5T4sVDEVc7jWv6b/8qtwp9iA=;
        b=lE889Y6Ve7jT9KMxQFeN9mpA5Owr+fTdLXCpNSDWuFTe3/3aMDmdaSIwTFPOwajjWU
         5CiDY0gO6ugGEDCdmnO/COJGD9U5fYyCL8eLH94s3VGWuKS1BZWafWfdhXUxAL3dnWbH
         iydc+IvtuVjvNpv/L7w9a8TIbC2N6Vt6ArXTp+Z1zBlHcCUif3vlhX4mV0uGCijYxFKW
         oFr726VJJD3ii8r+uu6C95o6AUPY6KlDEOWVY7Mb1fHzPv7BEGfFo22xZywiwUftvT72
         Y9EDufLoO9bug7aUdyxDgmjyH8fsjl4zlR+YiP+NiyULeiTkwqVPW3IoKZdhb0yebvzF
         gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGu5BaMF48W6ZcnKtxx5T4sVDEVc7jWv6b/8qtwp9iA=;
        b=lvrh2iBg056A1dxuvhxbogaG5cJNlA5ZdzZ/nJQAEQjlAbuZNIGM7PuMMbrRUq9cww
         6jcCWcnwUJMh/LytC1Tfql1LiUMKSXqfZFb6+oLckcAMGIVr2IBatFT3REn8RyLeqZIO
         ii5q21U2psZIDtxrbKFjF0v12jZg2vJwMJHOJjRwS3Mz2ESn7XtcAWjm6h6ZljEvkCeB
         zSmRzHoz3JuBf2JpEqvaoSX7HA/4LrEDtx/QtKXOKSYN2oQ4UyfRzFDc32UxP18LguUh
         vfU0vwnWpkEhcx3brBWo4tP6TIAKayv0MGxUB9Y7OoKy+b6DXfDjvhMkdI027lz5FJRC
         ejww==
X-Gm-Message-State: ABuFfognhOTeH7pugphPm6x+NNSFhSNsHl+AIfLgg214NQlDzcGJ8e/s
        krMwechr57zd3xr8pRlBDrqjByat
X-Google-Smtp-Source: ACcGV61oOEh+S3azaoB2+k410vpUrtUpI+P5M1Yu/k8WdkUH833RdUZPNNTf109vEy1s/T53ZckIYA==
X-Received: by 2002:a50:9043:: with SMTP id z3-v6mr4757910edz.216.1537914858672;
        Tue, 25 Sep 2018 15:34:18 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:18 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 00/21] Convert "git stash" to C builtin
Date:   Wed, 26 Sep 2018 01:33:11 +0300
Message-Id: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is a new iteration of `git stash`, based on the last review I got.
This new iteration brings mostly code styling fix issues in order to make
the code more readable. There is also a new patch "strbuf.c: add
`strbuf_join_argv()`". By making some small changes, the code is now a
little bit closer to be used as API.

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Paul-Sebastian Ungureanu (16):
  sha1-name.c: add `get_oidf()` which acts like `get_oid()`
  strbuf.c: add `strbuf_join_argv()`
  stash: update test cases conform to coding guidelines
  stash: rename test cases to be more descriptive
  stash: add tests for `git stash show` config
  stash: convert list to builtin
  stash: convert show to builtin
  stash: mention options in `show` synopsis.
  stash: convert store to builtin
  stash: convert create to builtin
  stash: convert push to builtin
  stash: make push -q quiet
  stash: convert save to builtin
  stash: convert `stash--helper.c` into `stash.c`
  stash: optimize `get_untracked_files()` and `check_changes()`
  stash: replace all `write-tree` child processes with API calls

 Documentation/git-stash.txt  |    4 +-
 Makefile                     |    2 +-
 builtin.h                    |    1 +
 builtin/stash.c              | 1595 ++++++++++++++++++++++++++++++++++
 cache.h                      |    1 +
 git-stash.sh                 |  752 ----------------
 git.c                        |    1 +
 sha1-name.c                  |   19 +
 strbuf.c                     |   15 +
 strbuf.h                     |    7 +
 t/t3903-stash.sh             |  192 ++--
 t/t3907-stash-show-config.sh |   83 ++
 12 files changed, 1851 insertions(+), 821 deletions(-)
 create mode 100644 builtin/stash.c
 delete mode 100755 git-stash.sh
 create mode 100755 t/t3907-stash-show-config.sh

-- 
2.19.0.rc0.23.g1fb9f40d88

