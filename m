Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42ACF1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965241AbeEJOTe (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39905 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeEJOTc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:32 -0400
Received: by mail-lf0-f66.google.com with SMTP id j193-v6so3223013lfg.6
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhBcO3QiNArXWmLeCpuT49qGClx/SG7BSBkQLUq+ETc=;
        b=P/jTC03neox2imI+QWTISGLvaWNDWOdwYrMx6PCSewMFJHkiWHX3QG45bKK1QUq7vX
         sddUNlEFeJcdvcHA4o5+Fp6KhTYXaG35IRdJ8Up/Gx+pCw5gYT16hDlGXX8L7GSOMPm0
         hVcURL4OCf9MHFXM2U2QVHIDDSnA+CAUdJqGwwa3w06jiUODzBYBscnQoAtvLIlZBhsT
         YBuw/q7TLUQYbNJ+dLdlPAFZK48McUol7rJ5IBmI6ByvB3/j2O1KdwdGoB2pu4fmi5N4
         WVFanH1x+xfcBYI4SPU8Sv/Q2lQgMGieDJYU27ALypjhAo/lidByGdO7QRyOw7wiAi3V
         dplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jhBcO3QiNArXWmLeCpuT49qGClx/SG7BSBkQLUq+ETc=;
        b=iiZg4iGs78FS5UEb0/mcxnM947Q9IGfh3LvMT1RmBek/ipz+Iz9f8PPJsgO6ftKksL
         K5xMWny2awCyt4unAn4tNQd4CfOk3SQ1fnJN8CSIJHc58G20jhEBXYeGXH8Gy9ZzUzDB
         jwBoJxZwCIaxtaHwkARidnmvjeQC5zEcoM7Iat+S5cVgYpmvp5jpCOr9kuO9/XX4yy/N
         hxPQ2ZQy2zRYKNM2JVEqv8uxhjOtygMSjHKkfR9y8gbvIJDaFYDVmV3E1FWRIx9FATkV
         H6yKCJnIag4wJjbR3k7a+yWL5j+FYGFSEJSGjIY0LsfN9cpHuGreI2Lw9FQPjzZ5Q/Eo
         du/g==
X-Gm-Message-State: ALKqPwe4/hjaSewURmMktE3D/XalAmEyXE74oetTm4eLlBzESXfkdM1g
        g1MhdVe5Us10e2/mZfBnJ1c9Sw==
X-Google-Smtp-Source: AB8JxZr/QFvbwj794i/0+BwF6xcQfKqPu1lvxMv65BM77qS1+WR071ofl5KgqJzChlhngqxeEi0B8Q==
X-Received: by 2002:a2e:9bcb:: with SMTP id w11-v6mr1332763ljj.76.1525961971188;
        Thu, 10 May 2018 07:19:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/9] completion: avoid hard coding config var list
Date:   Thu, 10 May 2018 16:19:18 +0200
Message-Id: <20180510141927.23590-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is part of the attempt to automate more in git-completion.bash.
This series is about making 'git' binary provide the list of
recognized configuration variables and feeding it to git-completion.bash.

The approach is less than ideal. Unlike parse-options, we don't have a
reliable source for configuration variables. Instead, we go grep
config.txt for variable names.

This should work most of the time even if it might miss some variables
if we start to write funny things in config.txt. But compared to the
current approach "every now and then, manually go through config.txt
(or something) and update _git_config() function", this is still
definitely better.

The result is about 200 more completable options (from current 324).
Granted most of this is fsck message ids, but I'm sure it has picked
up a few good config variables and will continue so in the future.

While at there, this config list is also available to the user via
`git help --config` if you can't remember the exact config name you
want and don't want to go through that big git-config man page.

PS. Yes too many complete options (524 now) is not that helpful. I
have a plan to deal with this but probably after I'm done with the
--no-xxx completion topic. Stay tuned.

(on top of nd/command-list)

Nguyễn Thái Ngọc Duy (9):
  Add and use generic name->id mapping code for color slot parsing
  grep: keep all colors in an array
  fsck: factor out msg_id_info[] lazy initialization code
  help: add --config to list all available config
  advice: keep config name in camelCase in advice_config[]
  am: move advice.amWorkDir parsing back to advice.c
  completion: drop the hard coded list of config vars
  completion: support case-insensitive config vars just a bit
  log-tree: allow to customize 'grafted' color

 Documentation/config.txt               |   3 +-
 Documentation/git-help.txt             |   5 +
 advice.c                               |  51 ++--
 advice.h                               |   1 +
 builtin/am.c                           |   5 +-
 builtin/branch.c                       |  28 +-
 builtin/clean.c                        |  28 +-
 builtin/commit.c                       |  40 +--
 builtin/help.c                         |  14 +
 config.c                               |  13 +
 config.h                               |   4 +
 contrib/completion/git-completion.bash | 340 +------------------------
 diff.c                                 |  60 ++---
 fsck.c                                 |  49 ++--
 generate-cmdlist.sh                    |  20 ++
 grep.c                                 | 113 ++++----
 grep.h                                 |  21 +-
 help.c                                 |  74 ++++++
 help.h                                 |  18 ++
 log-tree.c                             |  36 +--
 t/t4254-am-corrupt.sh                  |   2 +-
 21 files changed, 387 insertions(+), 538 deletions(-)

-- 
2.17.0.705.g3525833791

