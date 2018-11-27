Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59691F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbeK1Dv7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:51:59 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38652 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbeK1Dv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:51:59 -0500
Received: by mail-lf1-f50.google.com with SMTP id p86so17013584lfg.5
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oI44N2nlbIQvETupUxV2Zc0UF+0MsB9+wyvyh0XPBCY=;
        b=c0eu9bokSSxfpgT/gFStAE0aH+zsWxn6/vsTxL7u+7/Vy4joErdTGmb5z+XgzIuCeF
         xCoGRhfNKSGcps9DAF0U/HsuN8AwPSa5tMCIVv7XU0VgzZI79rJMcbWvntwCPnsYDRgu
         eMAXQYQngeUimCEgb7wBqkKB/P7I+DqsHUEJRD4Ha0zO8z21ou1sMXUdMQqM+SgJKR3u
         g85j11+u8Mc47SzuRNyTCSo6/Jrg5k7/YcwW5eGdVvy+6kAUqyFqTEpZTppxuvzRoez4
         sZdHTRgG94S3EH7RKp76bNjSlPoe9ThiKuOlSMUAK/o8oVf9QWcVB7TzeKaDxXhV4sQi
         Wo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oI44N2nlbIQvETupUxV2Zc0UF+0MsB9+wyvyh0XPBCY=;
        b=VnmsC4WGAAu0fjKOOcGxzBU0ZcZLdtYkzU01V+YGfnGiXO5hxFupH9dsnbCHI1GyKi
         80/dpHdTC+1MpmsNqaqT1ktNOrgOxeg/5W0LfdhXe6myL7ck6rCUxTTTvmll+K/0KhrI
         NgAO75GxgiIzlY+8hpq0L75vaBuch/aTcJGxzWNiEJ77EPKZd81mRHSv654k0KbdJtFD
         ER9GT3FTD2mWoRz7iKnv6CTs9TcPbD/xwXVZ8yl0W0deTWeEsorjauzrZS1xDTEzeneA
         FOnia2runD6zrSRHedOzA8aN2hLOj3QF4DT7sO5jsa68e24gxGeT0jhJcuxj6ClOTG46
         vHvw==
X-Gm-Message-State: AGRZ1gI+m1wDrZQ0puF73W29knYSWSfej3p0WL85ffRD2EcF9fPHekQb
        rM+X3jFMwYIHUPupN1Sa/nQ=
X-Google-Smtp-Source: AJdET5cmsFl4mSzYjGXCLcxgojN0Wo82NuiVe8FQsbq95POkkW1nTTjKmzgN9E+FQbXQX6mVlfbzxg==
X-Received: by 2002:a19:5349:: with SMTP id h70mr18832899lfb.50.1543337607157;
        Tue, 27 Nov 2018 08:53:27 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:25 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
Date:   Tue, 27 Nov 2018 17:52:04 +0100
Message-Id: <20181127165211.24763-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181120174554.GA29910@duynguyen.home>
References: <20181120174554.GA29910@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 is just a bit better to look at than v1. This is by no means final.
If you think the command name is bad, the default behavior should
change, or something else, speak up. It's still very "RFC".

v2 breaks down the giant patch in v1 and starts adding some changes in
these new commands:

- restore-paths is renamed to checkout-paths. I wrote I didn't like
  "checkout" because of completion conflict. But who am I kidding,
  I'll use aliases anyway. "-files" instead of "-paths" because we
  already have ls-files.
- both commands will not accept no arguments. There is no "git
  checkout" equivalent.
- ambiguation rules are now aware that "switch-branch" for example
  can't take pathspec...
- the last patch tries to hide "git checkout" away. The command
  example updates show how these will be used. Which probably helps
  figure better names or defaults for them too

One thing I notice that we often use "git checkout -- <path>" and
rarely "git checkout <tree-ish> -- <path>". Which makes me think
perhaps "git checkout-files" should not use "--" to separate the two.
We'll have this instead

    git checkout-files [--from=<tree-ish>] <paths>


Oh and of course I'll be waiting for the new --index from Thomas
before submitting submitting any thing serious for 'next'. We still
have plenty of time.

Nguyễn Thái Ngọc Duy (7):
  parse-options: allow parse_options_concat(NULL, options)
  checkout: make "opts" in cmd_checkout() a pointer
  checkout: move 'confict_style' to checkout_opts
  checkout: move dwim_new_local_branch to checkout_opts
  checkout: split options[] array in three pieces
  checkout: split into switch-branch and checkout-files
  Suggest other commands instead of "git checkout"

 Documentation/git-branch.txt           |   8 +-
 Documentation/git-check-ref-format.txt |   2 +-
 Documentation/git-format-patch.txt     |   2 +-
 Documentation/git-merge-base.txt       |   2 +-
 Documentation/git-rebase.txt           |   2 +-
 Documentation/git-remote.txt           |   2 +-
 Documentation/git-rerere.txt           |  10 +-
 Documentation/git-reset.txt            |  18 +-
 Documentation/git-revert.txt           |   2 +-
 Documentation/git-stash.txt            |   6 +-
 Documentation/gitattributes.txt        |   2 +-
 Documentation/gitcli.txt               |   4 +-
 Documentation/gitcore-tutorial.txt     |  18 +-
 Documentation/giteveryday.txt          |  24 +--
 Documentation/githooks.txt             |   5 +-
 Documentation/gittutorial-2.txt        |   2 +-
 Documentation/gittutorial.txt          |   4 +-
 Documentation/revisions.txt            |   2 +-
 Documentation/user-manual.txt          |  54 +++---
 advice.c                               |   2 +-
 builtin.h                              |   2 +
 builtin/checkout.c                     | 256 +++++++++++++++++--------
 git.c                                  |   2 +
 parse-options-cb.c                     |   2 +-
 sha1-name.c                            |   2 +-
 wt-status.c                            |   2 +-
 26 files changed, 271 insertions(+), 166 deletions(-)

-- 
2.19.1.1327.g328c130451.dirty

