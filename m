Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480F220A10
	for <e@80x24.org>; Sun,  1 Oct 2017 14:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdJAO4W (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 10:56:22 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53414 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAO4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 10:56:21 -0400
Received: by mail-wm0-f41.google.com with SMTP id q132so6354365wmd.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuCmziosLbK3S00hZinN09eoUnswNAT5Q3KbSYFBtn4=;
        b=tv2aV+AEDl3NOe5rTX6VZWYyWo5XCef0vjdfafHYStklcEyUl4YUXlcGllL2hzkcqY
         VWL4x5Mhd8Ik/Q7Ju+gZlsj9JCfckV6dsosj2uKOzCr44OGDvnikuiuWv7VlkC6LdfQX
         +oh2075rtG1/Y6fvETsXlhhv0GDURcqFCWfi3KuQeauJXt0/tfNQ3Io5jTHwRbsw+haB
         Q8cASQP7uku9et5gmL2XtvyBXyXkN/duPBLdHg2xZHpTgAOGB8y0zt9tGFo1LlcwbeMV
         RHaRY+7LlbdWdY9qoI3lHlBTUadNHbJJpkpHOFUsMKaj+v+uCtMMdfyx9alWHnrdYfOB
         AFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuCmziosLbK3S00hZinN09eoUnswNAT5Q3KbSYFBtn4=;
        b=iYne1F+1c2JYHu31H5nPCD1/MR+UxzAs1itUiVXCf/Fp6tGXjZKkuiNBldpz6wei3f
         lMlOlCOUc9R/8JAPssx3l8eg/FNRY81U6jRnmxD5zBmzcg98XL5CXJg1cNoslQfCy0/b
         iVUK1EdfFkmkN5fEf8B3oksGtmYCoWt74710pygNMSwl3iFkI0cB7Xxz/fIX1ZNZXXYo
         o/H6E2N5z8sBCqq04IoaYGgrtDqNqr5fwiVWuZjQQ3XULuXgblbaX7qXryzGPxRpAROl
         aBdBvc5+cT2tmGHO45aoFr9IqypleVS1CGnOKMmagXSbAzAePLg8n2w8k/krhomeMox5
         6TYA==
X-Gm-Message-State: AHPjjUgV3J7fKfLrWp2uLmi4boHodc7qADUZd//gVpfw1HmNNgL5MDm8
        WRK7hXAiQ6eSUPd3yN9Mx/1fTQ==
X-Google-Smtp-Source: AOwi7QAZylrV5jSC2rM7OZcPlRaVXVW7bbLPxWVqvd8mlZWCh9LdFD9LruF31jCYf5qvYQNb0/gSsg==
X-Received: by 10.28.173.1 with SMTP id w1mr8239424wme.3.1506869779664;
        Sun, 01 Oct 2017 07:56:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id w82sm10473516wme.5.2017.10.01.07.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Oct 2017 07:56:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/11] various lockfile-leaks and -fixes
Date:   Sun,  1 Oct 2017 16:56:01 +0200
Message-Id: <cover.1506862824.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.727.g9ddaf86
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A recent series allowed `struct lock_file`s to be freed [1], so I wanted
to get rid of the "simple" leaks of this kind. I found a couple of
lock-related cleanups along the way and it resulted in this series. It
feels a bit scary at eleven patches -- especially as this is about
locking -- but I hope I've managed to put this into understandable and
reviewable patches. Reviews, thoughts, opinions welcome, as always.

1-2

Instead of allocating and leaking `struct lock_file`s, initialize them
on the stack. These instances were identified by simple grepping.

3-4

Documentation fixes for lockfile and temporary file APIs.

5-7

No need to represent the same information twice. No need for the caller
to provide a (static) lock for us now that we can safely manage our own.

8-11

Error-handling in read-cache.c was a bit lacking and over-eager at the
same time. Sometimes we'd leave the lock open when we should commit it,
sometimes we'd roll it back when we should only close it. We'd also
crash under rare circumstances. Patch 9 addresses a bug in the API which
most likely hasn't hit anyone and maybe never would, but if we don't
have the functionality, I don't think we should pretend like we do.

Martin

[1] https://public-inbox.org/git/20170905121353.62zg3mtextmq5zrs@sigill.intra.peff.net/

Martin Ågren (11):
  sha1_file: do not leak `lock_file`
  treewide: prefer lockfiles on the stack
  lockfile: fix documentation on `close_lock_file_gently()`
  tempfile: fix documentation on `delete_tempfile()`
  cache-tree: simplify locking logic
  apply: move lockfile into `apply_state`
  apply: remove `newfd` from `struct apply_state`
  cache.h: document `write_locked_index()`
  read-cache: require flags for `write_locked_index()`
  read-cache: don't leave dangling pointer in `do_write_index()`
  read-cache: roll back lock on error with `COMMIT_LOCK`

 apply.c            | 25 ++++++++-----------------
 apply.h            |  8 +++-----
 builtin/am.c       | 27 ++++++++++++---------------
 builtin/apply.c    |  4 +---
 builtin/checkout.c | 14 ++++++--------
 builtin/clone.c    |  7 +++----
 builtin/diff.c     |  7 +++----
 builtin/difftool.c |  1 -
 cache-tree.c       | 12 ++++--------
 cache.h            | 19 +++++++++++++++++++
 config.c           | 17 ++++++++---------
 git-compat-util.h  |  7 ++++++-
 lockfile.h         |  4 ++--
 merge-recursive.c  |  6 +++---
 merge.c            |  8 +++-----
 read-cache.c       | 26 ++++++++++++++------------
 sequencer.c        |  1 -
 sha1_file.c        | 16 +++++++---------
 tempfile.h         |  8 ++++----
 wt-status.c        |  8 ++++----
 20 files changed, 110 insertions(+), 115 deletions(-)

-- 
2.14.1.727.g9ddaf86

