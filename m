Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245EEC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2BE20719
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ut7Lxc0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYVZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:25:14 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36773 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:25:13 -0400
Received: by mail-pf1-f201.google.com with SMTP id h125so3321869pfg.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=CTb3GKNfYHEvFLe38L5T1NbjjlEPzxOpUtdudDcCkSU=;
        b=ut7Lxc0viogk67aEik3XJMj0gKc/wx7sxgKkIgkw7lMrCs+oOnXHoBCIJcUanw9D1J
         eCgcH7M3ePuwFHNZs8PmIULklQsNdf+0qqeCEMRekWLJUtTYf3vg1DgTcjDMY6tX0uzx
         UWoMH5z8otOHdBS7Dq1MslxpRbk+9nvX3ZZK0UFJqMi9jDRbMEynDUDKDJzVbYcFA9ti
         toAN0vbwV6MAQTktAcotBSSudTqA9+0FGHf43qLAenpPeN3z9/TuclSVvyAWuHh5vNfR
         cGMi75uzS5drVDz/Zda7gFxVoxT9p6ITvnZZMF4r9vr8XgicQ0FJxfzgYniNNPZ+v17u
         SsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=CTb3GKNfYHEvFLe38L5T1NbjjlEPzxOpUtdudDcCkSU=;
        b=gRoC5vrQUoxcxGHHc0ynBqAU9/lm9kW8ii8ErZS2HcgQwTrNKVC+XE5CZzcc8st6hu
         3ZoUxTdvla23hKvIeRxyorI7ueRBrZ7CKwyNmaWXNLAScr+wA7c7V3A2UhcKtcit8Rdo
         GfegRxoslFFrGxKrZdY3LY+2jkLbCyluuR1duJ3u/QleUa89HnQVp5Bo132DXDhpFF0L
         1S7I+yZWQ765eQryEQQwzZEVa5kZE62YSL0LfCtxzuk1Sy+m/u3pIs1chs19vHfQXj5r
         lQZ+41Fc35Nf/nFlZ41VGYnVaQrV/twMvRSzdrMCalfmyU4aorvYhZlcU6tXaPXhiGwS
         7Q+w==
X-Gm-Message-State: ANhLgQ2sjoH+GM0NmgGUnSeQAjdom2aDS0oinCqczJhHMAmHs6uzcPux
        u9F1naFAn9qdlJstjhIJe27ot2m97z7ONZj8TIt/cQuXdTgwujRwfreesin94a8w69+RRVWTQfH
        1JY9IBxjeg/pOTA6qnZTGWx76ZxWYzSTWef8l9VtD98nSyEr6ao/pthA/pwjts8gLeTNCMpk4Eg
        ==
X-Google-Smtp-Source: ADFU+vsOQyxUP+vYRtIKpQjVGkjht15jkYJMFhT7g+qlEWUpNTrDSfiEEij47nnpKmZU3bw8/bNftC/RMWnK2BdGEdU=
X-Received: by 2002:a63:c050:: with SMTP id z16mr4862149pgi.177.1585171512421;
 Wed, 25 Mar 2020 14:25:12 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:24:55 -0700
In-Reply-To: <20200323214340.182724-1-emilyshaffer@google.com>
Message-Id: <20200325212500.135046-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v11 0/5] add git-bugreport tool
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

Please ignore v10; it seemed that I had a ref .git/bugreport as well as
a ref .git/refs/heads/bugreport and the former was pointing somewhere
stale, so v10 was identical at least to v9 if not also to v8. :|

This hopefully really does include the MSVC changes as well as the clang
changes and addstr noise fixes. I'm really sorry for the noise.

 - Emily

Emily Shaffer (5):
  help: move list_config_help to builtin/help
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
 compat/compiler.h               |  41 +++++++++
 generate-cmdlist.sh             |  19 -----
 generate-configlist.sh          |  21 +++++
 help.c                          | 131 +++++++----------------------
 help.h                          |   2 +-
 strbuf.c                        |   4 +
 strbuf.h                        |   1 +
 t/t0091-bugreport.sh            |  61 ++++++++++++++
 14 files changed, 455 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/git-bugreport.txt
 create mode 100644 bugreport.c
 create mode 100644 compat/compiler.h
 create mode 100755 generate-configlist.sh
 create mode 100755 t/t0091-bugreport.sh

-- 
2.25.1.696.g5e7596f4ac-goog

