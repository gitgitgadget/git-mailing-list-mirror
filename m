Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D90DC433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16E361241
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhKKRTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhKKRTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:19:38 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69635C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:49 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so4235845pfl.10
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tTrmWxNCyruRysk2nudYPE5Lo9jnP6vXY7iQipTXZ1s=;
        b=j/jB6b4FxQ3Se5PcxKDJ4sg51DQ9MVTR9ODJ4rN/unHQaLhEggis6D99CochlNkZOt
         WcZ8apii80DWE+jbt2OaiTQpjxxMfqRogK+N6LwSWnUvP3ba31AIPC9D0aaTVCcMDHur
         x0x/UxtyLnx+IzxaApoqruvhx+7g2lZ54uvH79kS5rajb5P6WVI+umZY7FJe7hMYOYYL
         wR2oKEzHp7gdz59h28JszfSjiPMtUMBASLHtOI5CG/SiFaaMgSAzOWacGWK0h0XeNg7i
         ijDHtAmD/C93V01WZ+KDyV9m04MLFfJenKSF5gYgQ8xGj7J0HT9hg+Pv9/WpocnjeqPq
         wGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tTrmWxNCyruRysk2nudYPE5Lo9jnP6vXY7iQipTXZ1s=;
        b=wvdjjXx/UZ2Qi2ryItzHuyBVh3rFM/z9Ph3kzFMW/0BCwzqg4oBBfVB7EJXu76MOuH
         NjTO9G6d3W/WkAzESZSK00MBO9Gv6A0EYRj1/JAPQp4Cli6ItLBsL/+I7kNhFNo6qY9u
         55VuCBBvXl49fuRiuhZNNQEBN0Op4kIXyJrlQQT+Cp1RDX/vIG6BJp4Fbenvh4MXha8B
         BwlLsHJI3X6JsVl8bcRjAVLD5B1HQLT0GyhEpKWflT3Hb21qn6KMfr/eUOReRmcY25uZ
         YQmVU7/FXM+xVMgdEt3yMk400jfEwXcFkzrss230Frep0KzH+/9wBOnTsiW6REu5W9Wx
         M6aA==
X-Gm-Message-State: AOAM532Yh0MNAerYRmDEERrO3LmbIdqpB4+yU1B+co27Q1FatTGxxDqx
        vcjQ4fOWJnV/NLLpG2cqs0BkfZzrcqJLNyZo22Ul8PrbvwxeeA4I76kDjXJUjqWL9PrZMp3DcBr
        /LL2XI47pGtKsPPnnrUpTDh3g0Md8Aijtc8niEOZ0pw5KsypfFxUl8Oee+bJ388E=
X-Google-Smtp-Source: ABdhPJwvWY6RHmVMYqIEBN7LcGnEs3EBdWnDhw8BPNSlvX3VpMFpF6R8QWDFhPNpstVTklSQmE1uYpqaEemePQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:70c5:b0:13f:f941:9ad6 with SMTP
 id l5-20020a17090270c500b0013ff9419ad6mr756892plt.28.1636651008795; Thu, 11
 Nov 2021 09:16:48 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:16:40 -0800
Message-Id: <20211111171643.13805-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 0/3] make create_branch() accept any repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

create_branch() accepts a struct repository parameter, which seems to
suggest that it works with any repository, but it actually only works
with the_repository. This series aims to fix this discrepancy.

This series depends on gc/remote-with-fewer-static-global-variables [1]
because setup_tracking() needs tracking information from
repositories other than the_repository.

Note that this fix is not as clean as "just replace the problematic
functions with an equivalent that doesn't use the_repository".

* git_config_set() uses the_repository deep in its call chain. Patch 2
  adds an alternative implementation instead of trying to fix the entire
  call chain.
* We cannot check if a non-the_repository is bare (yet). In patch 3,
  just die instead of trying to perform this check.

While this series isn't perfect, I think it is close enough to an
"ideal" removal of the_repository that it is ready for review. My hope
is to use this series to implement "git branch --recurse-submodules"
in-process. If this series doesn't pass review, I'll implement the
feature with child processes instead.

[1] https://lore.kernel.org/git/20211028183101.41013-1-chooglen@google.com/

Glen Choo (3):
  refs/files-backend: remove the_repository
  config: introduce repo_config_set* functions
  branch: remove implicit the_repository from create_branch()

 branch.c             | 69 ++++++++++++++++++++++++++++++--------------
 branch.h             |  9 ++++--
 builtin/branch.c     |  5 ++--
 builtin/checkout.c   |  7 +++--
 config.c             | 24 +++++++++++++++
 config.h             | 11 +++++++
 refs/files-backend.c | 20 +++++++------
 7 files changed, 107 insertions(+), 38 deletions(-)

-- 
2.33.GIT

