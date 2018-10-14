Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867B31F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeJOFzg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:36 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45674 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeJOFzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id v18-v6so16051939edq.12
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZpdN/pmNMIcOK+iJWOPgScs2lTNPX8oQOQhf4qRFhY=;
        b=V5kuKwMfBgMwrltDxmgpWpQZo7RX1hDEF3M5/0ru5q/aRzCw4csIPOsOIKO3LdXG3r
         EpPygd4RQfg5VUByWjYOZ92HEJqQCCRzwoxfS/9Y2ErWLEPYF8QXNtFl/sof4ZyvX8fj
         KrIe/iETCcJgoR7u7U8Hq4btLm9OHfM2fMwYj6VBAGFtTDzZOtinmwUjvcJrQkbcLPNh
         jNpMF5SOWvc3GLH6SoHQGvUBr+z2OW9xo/Cz0LHRgLoqsLkItg7WcIvafsS465zBjS8y
         20Gv90wlMLDmDBoV0jX7h2FjhzCm25MPQRVBa5XyMLS2LaTke4fRXkrE8aphqjmGdTWq
         gdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZpdN/pmNMIcOK+iJWOPgScs2lTNPX8oQOQhf4qRFhY=;
        b=kOTOokkvdSUeXce4qKxklAImSqn6FYCXHOa5FrtL6/2dv8g9/q9di8V2EfcONHOkaL
         bpJM3q5pse9L7llcCduBqoP6HHDc4svLl7gRXqahsi6QAfrpc6ztLIH7uJ3LUUfCF/ZU
         vv4fC91/dsNSfjGQuq8C1D+uPpuRr/xeUUlKH7ui1iZoy5/nkZgUMmVxJrsRx79bQhLH
         fBc4F3k4JNyahjrCgoVuKPBbIvWMV/0AVyfx4t3GdaecNTnKizzlM8JeGDtgs2hZkf3x
         5k97r4w+UamdMXSE33krH+UjkqnNAQ7P3/VxBR1u0qDXVwEOJAxR4U4/ZqyCb13H21+Q
         4+Qg==
X-Gm-Message-State: ABuFfojYalE9BPJFQPHboUssXiSh1F6RkofqvptobYX4qBQxG3cNOI9A
        3OVNFezAXsOmbjyn0vH03qpajqWR
X-Google-Smtp-Source: ACcGV6170+koHYT3enId31ucEGhH6Kvg0V1xbpJOZCmS8W+bNAInIcWxoPV9vXKsbO/3r7PKHNtVRQ==
X-Received: by 2002:a17:906:3d31:: with SMTP id l17-v6mr16357528ejf.89.1539555189318;
        Sun, 14 Oct 2018 15:13:09 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:08 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 00/21] Convert "git stash" to C builtin
Date:   Mon, 15 Oct 2018 01:11:06 +0300
Message-Id: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <https://public-inbox.org/git/cover.1537913094.git.ungureanupaulsebastian@gmail.com/>
References: <https://public-inbox.org/git/cover.1537913094.git.ungureanupaulsebastian@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is a new iteration of `git stash`, based on the last review.
This iteration fixes some code styling issues, bring some changes
to `do_push_stash()` and `do_create_stash()` to be closer to API by
following Thomas Gummerer's review of last iteration [1]. Also, there
were some missing messages [2], which are now included.

[1]
https://public-inbox.org/git/20181002203730.GI2253@hank.intra.tgummerer.com/

[2]
https://github.com/git-for-windows/git/commit/2af24038a95a3879aa0c29d91a43180b9465247e

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Paul-Sebastian Ungureanu (16):
  sha1-name.c: add `get_oidf()` which acts like `get_oid()`
  strbuf.c: add `strbuf_join_argv()`
  t3903: modernize style
  stash: rename test cases to be more descriptive
  stash: add tests for `git stash show` config
  stash: mention options in `show` synopsis
  stash: convert list to builtin
  stash: convert show to builtin
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
 builtin/stash.c              | 1605 ++++++++++++++++++++++++++++++++++
 cache.h                      |    1 +
 git-stash.sh                 |  752 ----------------
 git.c                        |    1 +
 sha1-name.c                  |   19 +
 strbuf.c                     |   13 +
 strbuf.h                     |    7 +
 t/t3903-stash.sh             |  192 ++--
 t/t3907-stash-show-config.sh |   83 ++
 12 files changed, 1859 insertions(+), 821 deletions(-)
 create mode 100644 builtin/stash.c
 delete mode 100755 git-stash.sh
 create mode 100755 t/t3907-stash-show-config.sh

-- 
2.19.0.rc0.23.g10a62394e7

