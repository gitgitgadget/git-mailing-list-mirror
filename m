Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E44C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 11:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJMLgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJMLgI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 07:36:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62047125715
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:36:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so1201125wmq.4
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P517ZpTBDJ0yZ30HitP6FM8P5Sbu7m8DVgG9jSF/a2Q=;
        b=PuGtWdEsktOlHdN4dfN88LeAX0WFHYWxWRlwrYcSAS5BrKcEI6Ddcc+LFgg25/aa10
         bxaXTJAYV1dZea2JQVOaXBwQXnc13BZjhw5AIhGp6y56yojJqyPqCbuYuGBZ7YEAxmyf
         K26LrrejY+A41TtMXY0kDDIIebQbnunqp/hRzTHO3ptThEx5O4H7MYGUsr5jhilz74Uc
         XqHUXZiQfEP30gw9ccviOGVJN56CipZ+90JyHWmR+jVQT8MatXTEzoJCCADWWujUCQEp
         TbRtu90YRNzLi/lvAZS0yxZB8lUdTp0WHaOtXbjwNG7cSQv+vVaqeVlBrUj8ycBR52yg
         HNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P517ZpTBDJ0yZ30HitP6FM8P5Sbu7m8DVgG9jSF/a2Q=;
        b=IXk2I9yo0PcWTB/5MObVZTL+rXXm5YBCvnc3jYCa39BEPE6sc/0P9aLZ0fXeHSRjAs
         qLf/jmKWa4GsbDR5mhifJepFX7+S40cAO7AlSsIJI8VZNDcFdfgqsmaOI51VoVXh6rS8
         5Ae5BtjFjZZ7YSQgYnrbcFh60aB3/u11wAdpwLqrdlp/Qvvot0yAwL9kqWo2Zfx0wcaG
         gVZarF/MMejfv0iH5lYJCmBaNPjHgCnKOQc8tLG5LqwYP85gKRbIpM2Zvx4JdOQtu4na
         WPNw5fagPokj0gk3V2qP3nWcWaZlkHQ1vOg8nN64zcbW3NnB2hRxi3QVjPj3tcqKX+6f
         1NLw==
X-Gm-Message-State: ACrzQf3l050eXQo8UeGgWCDxoasMOH08Yy8B5K0gvQ5pZSefxm+pqEJa
        TJVgffUZ3gcZ6r9tJSpRi3MKwElfXBM=
X-Google-Smtp-Source: AMsMyM66ldlvANPkYhAgPbwNRBHASgmVtIPr8Shz82Ikf9GlPlVCXiYaVzQ8OZkxq7J7ZB+H8J5PhQ==
X-Received: by 2002:a1c:e90b:0:b0:3b4:fb6c:7654 with SMTP id q11-20020a1ce90b000000b003b4fb6c7654mr6120606wmc.98.1665660962560;
        Thu, 13 Oct 2022 04:36:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003b477532e66sm10774423wmq.2.2022.10.13.04.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:36:01 -0700 (PDT)
Message-Id: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
References: <pull.1359.git.git.1665597148042.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 11:35:58 +0000
Subject: [PATCH v2 0/2] archive: Add --recurse-submodules to git-archive command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible to include submodule contents in an archive command.

The inspiration for this change comes from this Github thread,
https://github.com/dear-github/dear-github/issues/214, with at least 160
👍🏻 's at the time of writing. (I stumbled upon it because I wanted it as
well).

I figured the underlying implementation wouldn't be too difficult with most
of the plumbing already in place, so I decided to add the relevant logic to
the client git-archive command.

One of the trickier parts of this implementation involved teaching read_tree
about submodules. Some of the troublesome areas were still using the
the_repository references to look up commit or tree or oid information. I
ended up deciding that read_tree_fn_t would probably be best off having a
concrete repo reference since it allows changing the context to a subrepo
where needed (even though some of the usages did not need it specifically).

I am open to feedback since this is all quite new to me :)

TODO:

 * working implementation
 * valgrind
 * add regression tests
 * update documentation with new flag
 * submit to mailing list

Alphadelta14 (2):
  archive: add --recurse-submodules to git-archive command
  archive: fix a case of submodule in submodule traversal

 archive-tar.c                 | 14 +++--
 archive-zip.c                 | 14 ++---
 archive.c                     | 99 ++++++++++++++++++++++++-----------
 archive.h                     |  8 +--
 builtin/checkout.c            |  2 +-
 builtin/log.c                 |  2 +-
 builtin/ls-files.c            | 10 ++--
 builtin/ls-tree.c             | 16 +++---
 list-objects.c                |  2 +-
 merge-recursive.c             |  2 +-
 revision.c                    |  4 +-
 sparse-index.c                |  2 +-
 t/t5005-archive-submodules.sh | 84 +++++++++++++++++++++++++++++
 tree.c                        | 93 ++++++++++++++++++++++----------
 tree.h                        | 11 ++--
 wt-status.c                   |  2 +-
 16 files changed, 269 insertions(+), 96 deletions(-)
 create mode 100755 t/t5005-archive-submodules.sh


base-commit: e85701b4af5b7c2a9f3a1b07858703318dce365d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1359%2FAlphadelta14%2Farchive-recurse-submodules-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1359/Alphadelta14/archive-recurse-submodules-v2
Pull-Request: https://github.com/git/git/pull/1359

Range-diff vs v1:

 1:  41664a59029 = 1:  41664a59029 archive: add --recurse-submodules to git-archive command
 -:  ----------- > 2:  68f7830c6d9 archive: fix a case of submodule in submodule traversal

-- 
gitgitgadget
