Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455801F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeC1RY4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:24:56 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:40250 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC1RYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:24:55 -0400
Received: by mail-pg0-f44.google.com with SMTP id g8so1191490pgv.7
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mg5UDX9pWFUhcGozs+qpfvKzPk9QR7oKX2F+7sI1amw=;
        b=Vrx/ubc2z/pXqHJKKOBspkaAT8MS3pTEPpgkIPi8VWtnDXzbaqHgFxqFYN5zUp8R6t
         CDgFqeuxvvtYjEdc9LLj9TneQc0IllWiGxTKgJ4bKeYlml3A9BOMPJvCEKHyzTf/VSLw
         NjQw8DXcXw9CgJWHAZk/bI8S9gRpiG68XfA+7zP0sxOY0/48vKqKSexmasqsi6v+QZmV
         uyMqTMyvlNSq4dDQqIbK7/ZVLczsVfPk7I0OTyxjFBURA4Tywh0HrVS0fX7wYbtXmbSs
         SE9B9UD8gnhK3It3ytgmoljOGQjQILFfOKXk3XKgaA9Hhh5UgQoHpJQhhP3U3VKd+oyM
         nx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mg5UDX9pWFUhcGozs+qpfvKzPk9QR7oKX2F+7sI1amw=;
        b=lhENVoYHrgHYFtBUAbJaKYxMHnSBryc2dxLTSXNWom2PG7IZFFJFwNXoPRdW39sL99
         Fd1RUyM1OP4e8w8ra9nMOxP96GDCWvQQtTe2CzGShcxunWYORILKO3H1ba1wxHJyihV9
         7lBWDZZhCnS1/8Foas2DwP5h64cA6uOQPuNTHgkK1+NZvUeeWj1gsE0ZYlnwhlpSKKo9
         sYVT9EbJoxm963rDBbRdfluuIP/Me6PbyvA88PHTXH1eyR1WmkmDIozDpZ62MbXHKvF4
         RUvRcS9fFMeBkUjUyhCacVN/RRYR0mxUjxPpqHhIzWYbLegFBxrcy+KF3qvI26eKo+X6
         jc9A==
X-Gm-Message-State: AElRT7GS3PveUwgHIQoXWuZnHPkRLsXpXl4HPGZMmzyaBCM6Eg0G5zrw
        l6QuCGmnI7xwZPfAMCGoudGY32r4Bao=
X-Google-Smtp-Source: AIpwx4/s1Zr9JCn01RsSreIdnShBdm58y5Jt8jZ8T4DZpKXThJR1VQPZTyFBsB21ZmajyAJq0D89HQ==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4-v6mr4632596plt.31.1522257894318;
        Wed, 28 Mar 2018 10:24:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id c18sm8602696pfd.100.2018.03.28.10.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:24:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: [PATCHv2 0/6] Moving submodules with nested submodules
Date:   Wed, 28 Mar 2018 10:24:43 -0700
Message-Id: <20180328172449.27012-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
* addressed memleaks and messy code in patch 5
* removed the extern keyword where applicable
* extended the commit message, stating we want to rename submodule_free
  in the future.
* picked up Jonathans patch and added it as a nice finish of the series.
  I did not see the need or aesthetic desire to put that patch earlier
  in the series.
  
Thanks,
Stefan

v1:

This fixes the bug reported in [1] ("Bug: moving submodules that have submodules
inside them causes a fatal error in git status")

[1] https://public-inbox.org/git/20180306192017.GA5797@riseup.net/

Thanks,
Stefan

Jonathan Tan (1):
  grep: remove "repo" arg from non-supporting funcs

Stefan Beller (5):
  submodule.h: drop declaration of connect_work_tree_and_git_dir
  submodule-config: allow submodule_free to handle arbitrary
    repositories
  submodule-config: add repository argument to submodule_from_{name,
    path}
  submodule-config: remove submodule_from_cache
  submodule: fixup nested submodules after moving the submodule

 .../technical/api-submodule-config.txt        |  2 +-
 builtin/grep.c                                | 14 ++---
 builtin/mv.c                                  |  6 +-
 builtin/submodule--helper.c                   | 17 +++--
 dir.c                                         | 63 ++++++++++++++++++-
 dir.h                                         | 12 +++-
 repository.c                                  |  2 +-
 submodule-config.c                            | 29 ++++-----
 submodule-config.h                            | 15 +++--
 submodule.c                                   | 40 ++++++------
 submodule.h                                   |  1 -
 t/helper/test-submodule-config.c              |  8 ++-
 t/t7001-mv.sh                                 |  2 +-
 unpack-trees.c                                |  2 +-
 14 files changed, 137 insertions(+), 76 deletions(-)

-- 
2.17.0.rc1.321.gba9d0f2565-goog

