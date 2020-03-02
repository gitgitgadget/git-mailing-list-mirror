Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FE4C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533AC21739
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 23:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LP5rAqU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBXEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:04:09 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47397 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXEI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 18:04:08 -0500
Received: by mail-pg1-f202.google.com with SMTP id l15so827801pgk.14
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 15:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=R971yZ5aSyyBslOa3WzP1B5DuDP9bMK2dmycmv4pDb0=;
        b=LP5rAqU3QRgz8gvlBhVOL/fwLCj8O837AXW/GSeFTRvLKzB6wL4IbLDXeMLzBMM9w5
         3RK+CADpuGJZcSWBksUEltRsuJXr7FdZpUqMtkwwPJmlrdYHHP5Ls8n31u/mvnVOpA7p
         IFUBssOcio3aQmRrGjuszrhHOQHlecnjwFoBWDcRZqIsT/Lh9ZqJllZaDn6Gs9y6vCi3
         lz3TlIIVDChFYmWIxsKIfKAT2NkjJarnPlnpAMMvr2DLfZv49Z7ejsSBShHt9XJVKCfx
         J6n7eQRCcIkA9IMJqjabSwL4qXd9xnhHWtTxyZPKrFFhnklSZejs1xloCFZALgzeq+a5
         djwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=R971yZ5aSyyBslOa3WzP1B5DuDP9bMK2dmycmv4pDb0=;
        b=Dcsf5bykbdKKKb5WxrxReAEYjobkhy1Bg0Dg1XrtP7HPsMI5KwuxqXMxieJQGeNmfV
         mq2MWQqRwwaNAnBeP3GG+MrQXYi/uM/spMYN9ejFR4jnC/ARyG/h7UbaXqLzgUoXfBeA
         KxtnDOeAzBpVcSab87Eks1ug6x/qx+YXiOhfgakAth7wWyVPhJDDtFnSZIv1BgD4KjfE
         P7GqWELy2Bo46ZyKNIT9EigOefWqvoQ10LID/v4EA0rIEUF1eNSbPYZNG9Cd9d6Gupuz
         YWSPLwEJP8RGY4lc2q11HFpdGPRVdLB6l9eMZ3/7+Lmx5Nqc/Uf/35pZsWMwgqLdS/PH
         oxRA==
X-Gm-Message-State: ANhLgQ3ZdTmDmcgHBGt0nP4Msi+29UffUxcrCNNqbmPbfQl9bP4O9MFl
        hMQlf/Wm6/DpZUM/spCSLv86/xLuNnJWZYjKDbRkYtJFbCHJCXQg3IapH0NYBQ5PVpKsmX5dNOL
        QmH2oHOh6Mt732p+InQQ1qWY/FsS3nNC+/c7p8c0FqGXzNM+p8oe+9wCemc0siOgHJSMuk+bs7A
        ==
X-Google-Smtp-Source: ADFU+vszBHSSrO8Q2269fyBljWIG5+Pg8isGde/nsr3l15sjoROPecOFi2zBm23xSXfaV1I04jXoNHRkAkxUA9I3LxM=
X-Received: by 2002:a63:a707:: with SMTP id d7mr1095515pgf.390.1583190247266;
 Mon, 02 Mar 2020 15:04:07 -0800 (PST)
Date:   Mon,  2 Mar 2020 15:03:55 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200302230400.107428-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v9 0/5] add git-bugreport tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Martin=20=C3=85gren?=" <martin.agren@gmail.com>,
        Aaron Schrab <aaron@schrab.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "=?UTF-8?q?SZEDER=20G=C3=A1bor?=" <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did run this set through the Azure Pipelines CI [2] and hope that
means it's platform-safe; if that's not the case, please let me know
your concerns.

For the relevant patches, I made the following changes since v8:

 - More portable strftime format
 - Use open() instead of fopen_for_writing() in order to specify O_CREAT
   | O_EXCL | O_WRONLY.
 - Fix a use-after-free.
 - Add i18n/l10n macro all over the place; per [3] let's translate the
   whole contents of the report, because it's easy to force to a
   different language and we may not be the only ones reading reports
 - Use a lot less strbuf_complete_line() - when we're making library
   calls, we have control over the format, so we do know whether it ends
   in \n or not; let's not waste the time checking it.
 - Minor nit on uname header phrasing
 - Reword the structure of compat/compiler.h to separate libc and
   compiler.
 - Add MSVC reporting in compat/compiler.h (thanks Dscho).

Thanks all.
 - Emily

[1]: https://lore.kernel.org/git/20200225235558.GG212281@google.com
[2]: https://github.com/gitgitgadget/git/pull/566
[3]: https://lore.kernel.org/git/xmqqimjukzzv.fsf@gitster-ct.c.googlers.com

Emily Shaffer (5):
  help: move list_config_help to builtin/help
    Note that this patch is still required for this series because the
    help library (for version/build info) is unusable without it.
  bugreport: add tool to generate debugging info
  bugreport: gather git version and build info
  bugreport: add uname info
  bugreport: add compiler info

 .gitignore                      |   2 +
 Documentation/git-bugreport.txt |  52 ++++++++++++
 Makefile                        |  18 +++-
 bugreport.c                     | 142 ++++++++++++++++++++++++++++++++
 builtin/help.c                  |  86 +++++++++++++++++++
 command-list.txt                |   1 +
 compat/compiler.h               |  38 +++++++++
 generate-cmdlist.sh             |  19 -----
 generate-configlist.sh          |  21 +++++
 help.c                          | 131 +++++++----------------------
 help.h                          |   2 +-
 strbuf.c                        |   4 +
 strbuf.h                        |   1 +
 t/t0091-bugreport.sh            |  61 ++++++++++++++
 14 files changed, 452 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.25.0.265.gbab2e86ba0-goog

