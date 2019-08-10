Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F161F731
	for <e@80x24.org>; Sat, 10 Aug 2019 20:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfHJU1n (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 16:27:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38404 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfHJU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 16:27:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so1207606qts.5
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/Naw8DHkRN9//ylxRUZZ/mVPnDuBDbLQ71SsI0FQZ4=;
        b=npFNwyriOiysnsttxocRWFUTUFeWFZU2rTXQZJtmVqY3tY1cUqDIv15cF58kHaAEOU
         gWPaB9ZQ6gozx3Vu3JvabdbCe1nOaZf+dG6F4OqrLQv43u+A7wY2vWlN8BgA0DmKkomZ
         oV/wNtFs5xpRztgP6MfUyyo+fjwHSD7/7C/p+68QJNIyknxhkE36E6tU07cIsgozWNiZ
         ZxdR4CoOf7a7Fm/JrHPJ8EZCGUOyfBjiHGgeh53rBNDLD+KkyX1/bOEjnKe5RvYua6bf
         fP28UiuuKB5zY/9eqXpL0e/M2ZsuiKdin5157ZKg3WBV+UldA73dC2iTxWwK2aSwbci7
         NxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T/Naw8DHkRN9//ylxRUZZ/mVPnDuBDbLQ71SsI0FQZ4=;
        b=J84erVznWQVP/8gzqnKdoO0w+OIWe0Chr3whznM1Vlhr2jIFJF3itwxsujlB+t8yU1
         6hb98y5d1BfZKAW3TxYYNgWaF9y4YzudYB9EV260AIsGjeN78i1bQC7ArvlXShV1E/fQ
         tknRpDEtLJ9pyC2MRBRg/eE6yfC8qLCpTp8hTY4CyuguDIhXZ11n1wufOLbVMZddR/lt
         yFYmSiuK0x3cSN2SrlSDkCUZl9+M+3oPZfsfs7ySScIqVO71FWFLTxxy8PA7AVe3aZgw
         CKJG8aFGhy59DfeD60lQBhMlGUebBDtLSP2NOUoLEPacGe5PG2fs7keAAFn6iXxTA1fQ
         QnaQ==
X-Gm-Message-State: APjAAAXDTfA1wdHQrekisroWEajFX/bY7LYowrUrG2ORxj7Lv/AWfSof
        mG28+yhs9J782CEAlLZmQGSbjwa+5Z0=
X-Google-Smtp-Source: APXvYqw/x4s+MQBbMtDl+3l1t9uX2ThpbadTRmMV+j0UYzgebPPiDiGU1KkRLVaVVvY4gMg4QYB7CQ==
X-Received: by 2002:a0c:9163:: with SMTP id q90mr24565030qvq.37.1565468862214;
        Sat, 10 Aug 2019 13:27:42 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u1sm54384295qth.21.2019.08.10.13.27.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 10 Aug 2019 13:27:41 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [GSoC][PATCH 0/4] grep: re-enable threads when cached, w/ parallel inflation
Date:   Sat, 10 Aug 2019 17:27:26 -0300
Message-Id: <cover.1565468806.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series focuses on allowing parallel access to zlib inflation and
using that to perform a faster git-grep in the non-worktree case.

Threads were disabled for this case at 53b8d93 ("grep: disable
threading in non-worktree case", 12-12-2011), due to performance drops.

However, by allowing threads to perform inflation in parallel, we can
regain the speedup. This is a good hotspot for parallelism as some test
cases[1] showed that it can account for up to 48% of execution time.
And besides that, inflation tasks are already independent of each other.

As a result, grepping 'abcd[02]' ("Regex 1") and
'(static|extern) (int|double) \*' ("Regex 2") at chromium's
repository[2], I got (means of 30 executions):

     Threads |   Regex 1  |  Regex 2
    ---------|------------|-----------
        1    |  17.3557s  | 20.8410s
        2    |   9.7170s  | 11.2415s
        8    |   6.1723s  |  6.9378s

As a reference, just enabling threads in the non-worktree case,
without parallel inflation, I got:

     Threads |   Regex 1  |  Regex 2
    ---------|------------|-----------
        1    |  17.1359s  | 20.8306s
        2    |  14.5036s  | 15.4172s
        8    |  13.6304s  | 13.8659s

For now, the optimization is not supported when --textconv or
--recurse-submodules are used, but I hope to send another patchset for
that still during GSoC. We may also try to allow even more parallelism,
refining the added 'obj_read_lock'.

[1]: https://matheustavares.gitlab.io/posts/week-6-working-at-zlib-inflation#multithreading-zlib-inflation
[2]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

travis build: https://travis-ci.org/matheustavares/git/builds/570255029

Matheus Tavares (4):
  object-store: add lock to read_object_file_extended()
  grep: allow locks to be enabled individually
  grep: disable grep_read_mutex when possible
  grep: re-enable threads in some non-worktree cases

 Documentation/git-grep.txt | 12 ++++++++
 builtin/grep.c             | 22 +++++++++++---
 grep.c                     |  4 +--
 grep.h                     |  8 +++--
 object-store.h             |  4 +++
 packfile.c                 |  7 +++++
 sha1-file.c                | 61 ++++++++++++++++++++++++++++++++++----
 7 files changed, 105 insertions(+), 13 deletions(-)

-- 
2.22.0

