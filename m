Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2731F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeLTTov (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36197 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLTTou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so3506947wmc.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upu0ZCgdwsx5YEQxN8mzcF1BkVrFtL478j+9OYcaoAE=;
        b=a2wK9Y3pZ+lLLNt+KFgeMD86haZnliOQw6Btig/HFpeeS1YZpldudw05FXkoMbDJHh
         12km6+ZIEgueFMRUM/IoiaOPQ+eGjIxHp+wuWXfSygd3UZ0nq+DrF1mFHxvjTobrWstL
         k0L+ly81YkYI5FuRfj3GT1X9axhoPMI5ycRzyE2qixmsLcIZC7RotIgyA0xcHMY4kaLp
         c+BwX/LZi4tndcfhD1+AjtALWy2B7D/w18fuHScS3hr7t2dRyZ0bP2MbF1YsRXHWToOc
         mHmQTeU51YkuFJt3TptYPszQTPV7ryXf6GMiBrGYkkxNjpuV0FiZ9SjSZM5cTs49u8pr
         kksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upu0ZCgdwsx5YEQxN8mzcF1BkVrFtL478j+9OYcaoAE=;
        b=Yd2WXJcW4KlKCb+2ajmZoyGA9kArGDZMKZD7dQdvySPPjmbXQt7/Ia0OhkrQRZeY12
         igerBk0SiqDRfc9QFp/Dy1rkIY7GtOk6Wa1zT15EWdhtKfKCNBDoZpiLes05BJQCSQvH
         r9ytsDUotCfoaqw3gYyzcarUIV6UYz94bhrBt79MDZM4INrUq4NcZ1GH7p1kacpWyoBR
         URb23ND6t/zfYJnezquydz7HrVAizotcGe9KDcF60KpkenNJPQZiBiVRWqzcIOoq6k1j
         SQRF2J3mOgdHXavhGVd6oxZjWbwBgVNS7tQqSWvwP4/KgthazD2tq+wyoQU6xcylTMHx
         5vLA==
X-Gm-Message-State: AJcUukfeio7WVUEPVxCcSz8dpDaBRSvkgCfF8sVPeqN99JEQ/tWe36xI
        B7mFVN0XTm1e3ckjCwOqXIiRZ4vXoaM=
X-Google-Smtp-Source: ALg8bN5OE4D++ldMydxeKmr92iWHdTJdTnZsOLGSa06bifaYHIxNwspp9L7fPXMNVyGDUzHXdMUcLw==
X-Received: by 2002:a1c:dd04:: with SMTP id u4mr14316wmg.84.1545335088553;
        Thu, 20 Dec 2018 11:44:48 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:48 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 00/26] Convert "git stash" to C builtin
Date:   Thu, 20 Dec 2018 21:44:16 +0200
Message-Id: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <https://public-inbox.org/git/cover.1542925164.git.ungureanupaulsebastian@gmail.com/>
References: <https://public-inbox.org/git/cover.1542925164.git.ungureanupaulsebastian@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is a new iteration of git-stash which also takes
sd/stash-wo-user-name into account. I cherry-picked
some of dscho's commits (from [1]) to keep the scripted
version of `git stash` as `git-legacy-stash`.

Thank you for your suggestions!

Best,
Paul

[1]
https://github.com/dscho/git

Joel Teichroeb (5):
  stash: improve option parsing test coverage
  stash: convert apply to builtin
  stash: convert drop and clear to builtin
  stash: convert branch to builtin
  stash: convert pop to builtin

Johannes Schindelin (4):
  ident: add the ability to provide a "fallback identity"
  stash: add back the original, scripted `git stash`
  stash: optionally use the scripted version again
  tests: add a special setup where stash.useBuiltin is off

Paul-Sebastian Ungureanu (17):
  sha1-name.c: add `get_oidf()` which acts like `get_oid()`
  strbuf.c: add `strbuf_join_argv()`
  strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
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
  stash: optimize `get_untracked_files()` and `check_changes()`
  stash: replace all `write-tree` child processes with API calls
  stash: convert `stash--helper.c` into `stash.c`

 .gitignore                          |    1 +
 Documentation/git-stash.txt         |    4 +-
 Makefile                            |    3 +-
 builtin.h                           |    1 +
 builtin/stash.c                     | 1636 +++++++++++++++++++++++++++
 cache.h                             |    2 +
 git-stash.sh => git-legacy-stash.sh |   34 +-
 git-sh-setup.sh                     |    1 +
 git.c                               |    6 +
 ident.c                             |   20 +
 sha1-name.c                         |   19 +
 strbuf.c                            |   51 +
 strbuf.h                            |   16 +
 t/README                            |    4 +
 t/t3903-stash.sh                    |  192 ++--
 t/t3907-stash-show-config.sh        |   83 ++
 16 files changed, 2001 insertions(+), 72 deletions(-)
 create mode 100644 builtin/stash.c
 rename git-stash.sh => git-legacy-stash.sh (97%)
 create mode 100755 t/t3907-stash-show-config.sh

-- 
2.20.1.441.g764a526393

