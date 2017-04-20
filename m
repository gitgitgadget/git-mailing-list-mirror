Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D672207BC
	for <e@80x24.org>; Thu, 20 Apr 2017 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942593AbdDTL03 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 07:26:29 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35841 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942132AbdDTL01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 07:26:27 -0400
Received: by mail-oi0-f52.google.com with SMTP id r203so46052802oib.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jV9u4y3pf9zx0vHwLUu715jRASeurQGBhB5PavqUWPI=;
        b=CgtuqaIS/hHxl9hd8AmyT4Kf6lfUh377/UESq9P0pQF28UC7AYEdylS3JrpkGPytCZ
         PqsTouDKaaXDvCVLEFw9wMCLpde5cwWHgNGs6J/CLg62hO8T1nntM82GVtDtEQSrdazv
         rE9/bA7dxqUrjmoN9fzxW+ogrS81DKWJZWTFDyTX8eVVtVPrQQvUnBbXIHu8DjuOXXDe
         SZQKZTUKrgvyDSCwpXrNP/FyK+AXsCxSIYEK/BD9lNTIoz2+Em3mCNXL9GydO2r4Rep7
         ujUz0EwAkYe6jVVBjxDnH7Zx0/t2miYDpvMYby2y9g/mCuWIW7ouCXRlZjjsqcUXqqQl
         8FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jV9u4y3pf9zx0vHwLUu715jRASeurQGBhB5PavqUWPI=;
        b=TOVZ7O9uYZ6sRMCGiiwPG90Lxgkd3V8HQ9bgmQnunWtRxgN3KrixJYB9l/UNmBYOh1
         /yBLvTERNxUJNng53psySKcbZmnOcTYDYkCrhU816KrhswGAmHU4loCf88irdv6RBXtc
         ALfS2j65E58dLXnmNGmzwEOhXyGJaaPXO/y9s3kSzG4WOT9C04d9Uvz0o8lF0stpy1XO
         lBaYg4M7+9NRpQc6t8PWeQAIhR9VyLkMPNcbtztl3zl8RmYHwJXnDIt3P1d1UvhMCw4T
         oeiqm75o0/D7Y/XQetjO+ikOA7f+o2JtazBVPHJs1sKlaXsw0nnIs9x5gvOEaxWlj25F
         ygtA==
X-Gm-Message-State: AN3rC/4B2LXeQyWO6e3VuuMl2e18p1rzOgeCOmaFOqPY+9voeXdGZvFj
        MQLq2evB84lAxg==
X-Received: by 10.84.222.9 with SMTP id w9mr9950451pls.89.1492687581373;
        Thu, 20 Apr 2017 04:26:21 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id a77sm10053234pfe.33.2017.04.20.04.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 04:26:20 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 18:26:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/15] Handle fopen() errors
Date:   Thu, 20 Apr 2017 18:25:54 +0700
Message-Id: <20170420112609.26089-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of you may recall a while back, nd/conditional-config-include
failed on Windows because I accidentally fopen()'d a directory in a
test, but it's not considered an serious error unless it's on Windows,
where fopen(<dir>) returns NULL.

A couple of suggestions were thrown back and forth, but I was a bit
busy to follow up. Now that I have time, I have audited all fopen()
calls and try to fix them up for good. There 15 patches, but they only
change one or two lines each. I split them anyway so you can pause
between patches and see if it really makes sense, as changes are all
over the places.

There are still a few iffy fopen() calls in sequencer.c though. I only
fixed the easy ones in there.

The last patch may fail on some platforms since I want to make sure
that fopen(<directory>) == NULL is an expected behavior, even though I
could only test FreeBSD and Linux (and know Windows behaves the same).
At least when people shout up, we could start adding
FREAD_READS_DIRECTORIES on those platforms. That's the goal.

Nguyễn Thái Ngọc Duy (15):
  config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
  bisect: report on fopen() error
  blame: report error on open if graft_file is a directory
  clone: use xfopen() instead of fopen()
  log: report errno on failure to fopen() a file
  commit.c: report error on failure to fopen() the graft file
  remote.c: report error on failure to fopen()
  rerere.c: report error on failure to fopen()
  rerere.c: report correct errno
  sequencer.c: report error on failure to fopen()
  server-info: report error on failure to fopen()
  wt-status.c: report error on failure to fopen()
  xdiff-interface.c: report errno on failure to stat() or fopen()
  config.c: handle error on failing to fopen()
  t1308: add a test case on open a config directory

 bisect.c              |  5 ++++-
 builtin/blame.c       |  5 ++++-
 builtin/clone.c       |  2 +-
 builtin/log.c         |  3 ++-
 commit.c              |  5 ++++-
 config.c              |  8 +++++++-
 config.mak.uname      |  3 +++
 remote.c              | 12 ++++++++++--
 rerere.c              | 10 +++++++---
 sequencer.c           |  5 ++++-
 server-info.c         |  5 ++++-
 t/t1308-config-set.sh | 13 ++++++++++++-
 wt-status.c           |  2 ++
 xdiff-interface.c     |  4 ++--
 14 files changed, 66 insertions(+), 16 deletions(-)

-- 
2.11.0.157.gd943d85

