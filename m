Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD4C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378DD611BD
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhJMTdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMTdf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:33:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764AC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:31:32 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u5-20020a63d3450000b029023a5f6e6f9bso2013638pgi.21
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bgdpidcxqmIaeZglw7GwreY6Dn4Pm831wVzOquVKMFQ=;
        b=UwaaK0gPgGQadfxijK1fyorqxf+J/gkON6vxNwPNUQAiUE3S2+te794Y81CiGkJhmG
         l57oD/mvo41Pe0lVfLSofW+FiUrwCiZ5MOgNb1orUzVkBjfIoWtd63YCx3IO2zTZo5wv
         5lYWRxafvl5+L5uHEb3E9+J/e5ruvu2GP8XjpxtemH6DAf9g9pEuhb8M5mwmANPjMpW0
         xj4aUn3y8ZLHJCe0pvMudBJBYcaXjWLq9jTU1xkd3I1gOlK+dZXGsOyEI4JFGDG4dfs5
         gOWk3K2Diz2FZCdVuzKct12Lc1ftpnYu3YACiwO0UzHCt6dC67oBxTQhxsdG2HAM3ZrI
         3NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bgdpidcxqmIaeZglw7GwreY6Dn4Pm831wVzOquVKMFQ=;
        b=dfnFCkSUsz2cw6WwrKlBYT93UPPVSsXzYTJJ+jZJimZRix2hy2nK7AuI7wFtB+pffQ
         BhPBpo25Y23OYZmlNYatyul/8dHx3+VbNcQVanMFcUf3TeRB2s95zH1UU/X5neFfkyRF
         rCyWBoiQcsfscmfnhiwO6wV/fyaTJfpODnLCNuwCjeVtHtHY2BdPEo+SlsYC435Vzr1c
         TJ82DrRcsw2ALh5BVwYFVpD6e3LYaSSCsAYsnShc4zHsiSgQ4zT7Fnbq6OA3pjskU3Qp
         RfmhpcPm+7G8LG+5toNGIt90uvamQRk34qmR6p7v4j0l/oyqjXTOQGHfndO6sEYbxf9G
         m2kA==
X-Gm-Message-State: AOAM533QSRnvBZ1keVIvJt921Zwusx6HV8dLhHZ+OYI3ErxenrrAwNDc
        fhqrCFKSS3uijRgsjL+FxBM6YeE2gQ3DMslT4bflZuxzLmPiEr7xnb1ATSKrHn4uPPDhdotHYnc
        C4SaEZqls1EDDn4w5hdKkT0ZyuNMUEZ6xIDotweSjsiv08vR072l2xs/2ueUJs2M=
X-Google-Smtp-Source: ABdhPJy7kkMSnunIWxYt487O0FoDTGkjfc4zmHAtyT8LV13r+WnDxtctm64ZeKzNa9iqNESLkkDo5Ni/MExalg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c643:b0:13f:68b4:4abf with SMTP
 id s3-20020a170902c64300b0013f68b44abfmr908234pls.82.1634153491363; Wed, 13
 Oct 2021 12:31:31 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:31:24 -0700
In-Reply-To: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
Message-Id: <20211013193127.76537-1-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v2 0/3] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to make the remotes subsystem work with
non-the_repository, which will allow submodule remotes to be accessed
in-process, rather than through child processes. This is accomplished by
creating a struct remote_state and adding it to struct repository.

One motivation for this is that it allows future submodule commands to run
in-process. An example is an RFC series of mine [1], where I tried to implement
"git branch --recurse-submodules" in-process but couldn't figure out how to
read the remotes of a submodule.

v2 aims to catch all of the instances of struct remote_state that I had
missed in v1, particularly with the struct branch functions. Because
more repo_* functions were added, the preparatory patches have been
reorganized.

In this version, my biggest uncertainty is in the interfaces of the
repo_* functions. Some functions expect a "struct repository" and one
of its contained members (e.g. "struct branch"). This interface allows
for incorrect behavior if the caller supplies a "struct repository"
instance that is unrelated from the "struct branch". This concern was
raised by Junio in [2].

While this concern is valid, I decided to keep this interface for a few
reasons:

1. The correct way of calling the function is 'obvious'.
2. It is relatively easy to get the contained object (struct branch/remote)
   and its containing struct repository/remote_state (e.g. we don't pass
   struct branch or remote through long call chains). For "struct
   branch", callers usually get the branch from the repo and use it
   immediately. For "struct remote", we don't use container objects
   outside of static functions. If you are interested in seeing all of
   the call sites, you can see a sample commit in [3].
3. The separation between container/contained objects allows us to
   reason better about what the correct interface is. e.g. we might be
   tempted to include a backpointer from struct branch to struct
   remote_state so that we can pass around struct branch and be
   confident that struct branch has all of the information it needs.

   However, I believe that some questions *shouldn't* be answered by
   just struct branch. The prime example in this series is
   branch_get_push() - it conceptually answers 'What is the pushremote
   of this branch', but the behavior we want is closer to 'If
   configured, give me the pushremote for the branch. Otherwise, give me
   the default pushremote of the repo.'. This is arguably a relevant
   detail that should be exposed to callers.

If we want the interface to prevent misuse, we can check that the
correct repository is passed at runtime. Alternatively, if we are
convinced that some questions can only be answered in the context of a
repository, we can take things one step further by using (struct
repository, branch_name) instead of (struct repository, struct branch).

A different concern is that struct repository is added to some callback
signatures even though the function body doesn't use it e.g.
repo_remote_for_branch(). However, this might be more of an accident of
history than anything else - the difference between remote and
pushremote is that remote always defaults to 'origin', whereas
the default value of pushremote is configurable.

Changes since v1:

* In v1, we moved static variables into the_repository->remote_state in
  two steps: static variables > static remote_state >
  the_repository->remote_state. In v2, make this change in one step:
  static variables > the_repository->remote_state.
* Add more instances of repo_* that were missed.

[1] https://lore.kernel.org/git/20210921232529.81811-1-chooglen@google.com/
[2] https://lore.kernel.org/git/xmqq4k9so15i.fsf@gitster.g/
[3] https://github.com/chooglen/git/commit/173e0268fd076044dd6b3cae893eedfa33965942

Glen Choo (3):
  remote: move static variables into per-repository struct
  remote: use remote_state parameter internally
  remote: add struct repository parameter to external functions

 remote.c     | 305 +++++++++++++++++++++++++++++++--------------------
 remote.h     | 130 +++++++++++++++++++---
 repository.c |   8 ++
 repository.h |   4 +
 4 files changed, 312 insertions(+), 135 deletions(-)

Range-diff against v1:
1:  6972ba4dcb = 1:  6972ba4dcb remote: move static variables into per-repository struct
2:  71b1da4389 = 2:  71b1da4389 remote: use remote_state parameter internally
3:  ff12771f06 = 3:  ff12771f06 remote: add struct repository parameter to external functions
-- 
2.33.0.882.g93a45727a2-goog

