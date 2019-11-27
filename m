Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D31C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3472070B
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 18:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JR7bnmPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK0SNk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:13:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44719 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfK0SNk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 13:13:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so10117972plb.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 10:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z7M8DuldvNmTrLnvAluAUMvbPUYA2r7LeIPr5Zf2UsY=;
        b=JR7bnmPKII+02om8bIT9ySk9moq8WG+lleIQnh7pctyUho8dy+XymBLBPKg7xHcsoI
         3LEdik0bEuqOof+z6CuUROTHQY9r8RstivhXXvAqGEF1PMI13WlT+0T2UQycwyya0BF8
         nQ7kV2cw6Oerq6WlBQnnhnHxVI0MqffDnsFcP5nFAC/jzqb3e3mWL4fOWg+N/sV1/8vv
         /jAq/REUWpgc2FulFXz5oTPdgMjYcJAx77tfhFy3TcJWdgRjGgBLgOS8lVQHus/Zwthn
         uo0y+KiVfeOpjUFCuOsHXmUXE51MFzZkcBvoLv8x22pKns9khK45uaBZxvifrk4yVyLp
         8xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z7M8DuldvNmTrLnvAluAUMvbPUYA2r7LeIPr5Zf2UsY=;
        b=CNPEihwWQPcqOMwUjj3r0V2Kn2lB/ppkYHnYKlVD0NlavGrmbGKwG+Z+NFBmM41+6t
         L36bZoUYYdXS6meQl4Tjq9a4P9F4Vor5/MWwL6lBeQ9I/oZRbNJhqrzJ7SqDZcuCO8tf
         xMvG0Yt3u/gzCOMkh6apoSI2ecZ8LCsG+d6z9CdjCVUfM67i/WYJwLtTQo0eLuhs0V5E
         v8rTET0xtOvnPyNr1qHFZkswAvIFgjM1ZKTQ8IzYJqUjRFTQ7PLijplR7o2hUFV87WU/
         ad3A3cwrNCqEzyBlqEdbn+dhM9dtVxQrGnSuE/NX9VJ0K04DyxakMEzmEjy4oszT188T
         Pa9A==
X-Gm-Message-State: APjAAAUTK4bdLSq6DrlCJan5V7pfrnRA1GdHGt+4eHMKkXe/OypLVxFD
        zLzXsI9VLpY8Qowi9mwZ7MkId2GJ
X-Google-Smtp-Source: APXvYqwpj9I/2AyMEIwHN+xmkFbSbVH545KdMru3nnkNbWBUrOSBe7V+8hCdqRhNC8ZKhPcoRluWwg==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7mr5421295plb.186.1574878419187;
        Wed, 27 Nov 2019 10:13:39 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 136sm17710041pfb.49.2019.11.27.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:13:38 -0800 (PST)
Date:   Wed, 27 Nov 2019 10:13:36 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] rebase: fix breakage with `format.useAutoBase`
Message-ID: <cover.1574878089.git.liu.denton@gmail.com>
References: <cover.1574820308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apparently, this use case has been broken for a long time... Since
bb52995f3e (format-patch: introduce format.useAutoBase configuration,
2016-04-26). I'm surprised it's only been reported now.

This patchset fixes the breakage by teaching
`git format-patch --no-base` and making rebase use it.

Changes since v1:

* Update some log messages

Denton Liu (5):
  t3400: demonstrate failure with format.useAutoBase
  format-patch: fix indentation
  t4014: use test_config()
  format-patch: teach --no-base
  rebase: fix format.useAutoBase breakage

 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      | 26 ++++++++++++++++++++++----
 builtin/rebase.c                   |  3 ++-
 t/t3400-rebase.sh                  |  6 ++++++
 t/t4014-format-patch.sh            | 14 +++++++++-----
 5 files changed, 42 insertions(+), 12 deletions(-)

Range-diff against v1:
1:  a1741e5434 ! 1:  4089e51041 t3400: demonstrate failure with format.useAutoBase
    @@ Commit message
     
         Ever since bb52995f3e (format-patch: introduce format.useAutoBase
         configuration, 2016-04-26), `git rebase` has been broken when
    -    `format.useAutoBase = true`. Demonstrate that failure here.
    +    `format.useAutoBase = true`. It fails when rebasing a branch that
    +    doesn't have an upstream set:
    +
    +            fatal: failed to get upstream, if you want to record base commit automatically,
    +            please use git branch --set-upstream-to to track a remote branch.
    +            Or you could specify base commit by --base=<base-commit-id> manually
    +            error:
    +            git encountered an error while preparing the patches to replay
    +            these revisions:
    +
    +                ede2467cdedc63784887b587a61c36b7850ebfac..d8f581194799ae29bf5fa72a98cbae98a1198b12
    +
    +            As a result, git cannot rebase them.
    +
    +    Demonstrate that failure here.
     
         Reported-by: Christian Biesinger <cbiesinger@google.com>
     
2:  46fd4113aa = 2:  d288d6c3a5 format-patch: fix indentation
3:  22b1fb14f9 ! 3:  196b5d8dbc t4014: use `test_config`
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t4014: use `test_config`
    +    t4014: use test_config()
     
         Instead of manually unsetting the config after the test case is done,
    -    use `test_config` to do it automatically. While we're at it, fix a typo
    +    use test_config() to do it automatically. While we're at it, fix a typo
         in a test case name.
     
      ## t/t4014-format-patch.sh ##
4:  e072c36e6a = 4:  f7e5325cc0 format-patch: teach --no-base
5:  15e6ccb203 ! 5:  62c59c12e3 rebase: fix `format.useAutoBase` breakage
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    rebase: fix `format.useAutoBase` breakage
    +    rebase: fix format.useAutoBase breakage
     
         With `format.useAutoBase = true`, running rebase resulted in an
    -    error when an upstream was't set:
    +    error when an upstream wasn't set:
     
                 fatal: failed to get upstream, if you want to record base commit automatically,
                 please use git branch --set-upstream-to to track a remote branch.
-- 
2.24.0.504.g3cd56eb17d

