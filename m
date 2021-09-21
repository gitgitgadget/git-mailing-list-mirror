Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB57C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B18611CE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhIUX1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhIUX1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:27:15 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005CC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:25:46 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p12-20020ad4496c000000b0037a535cb8b2so6912679qvy.15
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0JrrrinbbrYe9656QjePLbTRR0FTuZfwQgqc/6p155I=;
        b=KWv+VLWzearmudOoGKlZ4lrR6UKRo4ndgsmtkG5v1PpAp9ARvD4tGNYE7ooQi0O465
         PR+atVOUtUWINU4kQgsZA3TdsnaZYiz/mzbmcaYrGunGBW0mkxrf9JCyB2iNSK6xXHuX
         eWxZv1epDMR+4fWgRSgT0A0Um1e81d2LUuXf06vwHXOeTO0wxA4NWyedyt0DddmNwWMM
         UsY1skv8+fHSA4cRMzcTkvGMDBDEcfaj/2d/paJpGgRcCai/wOXc8s1zESDK2qkDr8tb
         bSUEYPbHneUcwsXsMDKJIdiQmEW210Fnuf9oIQSV0By0HD8dBKH/rl53UMx+4KZtkgvF
         UDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0JrrrinbbrYe9656QjePLbTRR0FTuZfwQgqc/6p155I=;
        b=rjMTpuOQNgiTW+ooxQQ+sRi6E1nXEcYfUGQHnruGA01i3MnJrkU958F19jueFlnFf4
         HhYKZxqgyxMuHagl+fZGbPbKjzgxQ2QtPj5YH2KFd0vzxhVIT28Z8x9Sha8thWTs4/em
         9rTwEiG3VaHPr3ax57WwO9u4l1oOGHvFTcia6HSxVjz94PKbBfId6M0LAEx2g4bJ6PA3
         iJT8hrM5GGo8APbV4QPBB2Dj/hayWXQ8wXzMOB5Z/9UtwYvEP69tygpCKFJiV2Lxo1Im
         x2w4hKnIB+DZ3jOqiucii4CBkRsTQWpq5XIpbAodo7P+ol+E5DHfAidWbXG6/KWwIJYj
         mK3w==
X-Gm-Message-State: AOAM533ETcg5d57CiEw5BK914oM5LQ81TqibQI2Tmh3H0jIKXYtM5LSE
        Jak5lT6WrrG7HKVOMX88lGa2dUR8AE3La7Z9yN4roGyh6F0GETBo5Os2MB5OsW1b2NXBDzwFuE2
        5BU5awrOdiIoE0XwLguGvYop9LSFLloMKcaelElqrLNZmbjNXEBoJeigUoWc0XJg=
X-Google-Smtp-Source: ABdhPJzK38GmJEuYge3hHcfPM62qCTb2bNiI9GxvsWw6K4BRftdBLk1ReT7AdSpNNYyPApZFUDw9+RycVlc6Rw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:7108:: with SMTP id
 m8mr38820314ybc.246.1632266745076; Tue, 21 Sep 2021 16:25:45 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:25:27 -0700
Message-Id: <20210921232529.81811-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [RFC PATCH 0/2] branch: implement in-process --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are an attempt to implement git branch
--recurse-submodules in-process. This is part of the general submodule
UX improvements discussed in [1]. Specifically, this is the use case
discussed in the section titled "Create Mode (git switch -c / git
checkout -b)", but without checking out the newly created branch.

Doing this in-process allows "git switch -c" and "git checkout -b" to
reuse create_branch(), instead of relying on a child process to create
the branch. create_branch() nominally takes a struct repository *
parameter, but there is some hidden reliance on the_repository and
global state.

Broadly speaking, I'd like to know how we should approach
"--recurse-submodules", particularly when we are implementing [1]. I'm
sending these patches as an RFC because I think this is somewhat
indicative of submodule issues.

In this patchset, branching works slightly differently between the
superproject and submodule (skip ahead for specifics). There are two
very obvious alternatives that can address this:

* A: only implement --recurse-submodules behavior after we are able to
  eliminate any kind of dependence on the_repository/global state that
  shouldn't be shared.
* B: implement --recurse-submodules as child processes, which won't be
  bothered by global state.

My cursory thoughts on the matter are that A seems like a good direction
for code health, but it seems difficult to do in practice. B seems
hacky, but it might be a good stopgap while we work on A.

Obviously these aren't the only options and this isn't the end of the
discussion, so I'd appreciate any thoughts on the matter :)

Changes:
* refactor the refs.h functions to accept struct repository * where
  reasonable.
* add two new functions to refs.h that accept struct
  repository *, repo_ref_transaction_commit() and
  repo_ref_transaction_prepare().
* change ref_transaction_commit() and ref_transaction_prepare() to be
  thin wrappers of their repo_ counterparts.
* use repo_ref_transaction_commit() in create_branch()
* add a create_branches() function to builtin/branch.c that recursively
  creates branches in submodules

What doesn't work (marked with NEEDSWORK):
* branch tracking is disabled for submodules because remotes.c only
  holds state for a single repository
* similarly, bare repository checking does not work as expected because
  environment.c only holds state for a single repository

What is questionable (specific to these patches, not
--recurse-submodules in general):
* files-backend.c only uses the_repository to validate the oid being
  used and it is the only ref backend that does so. Instead of passing
  struct repository * through more places in refs.h, we might be able to
  eliminate this check altogether. This is discussed briefly in [2].
* create_branches() implements its own submodule iterating, which is
  similar to that of ls-files, but wholly different from
  submodule--helper.c.

[1] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
[2] https://lore.kernel.org/git/20210916172432.1073546-1-jonathantanmy@google.com/

Glen Choo (2):
  refs: pass struct repository *r through to write_ref_to_lockfile()
  branch: add --recurse-submodules option for branch creation

 branch.c                  | 26 +++++++++------
 branch.h                  |  4 +--
 builtin/branch.c          | 69 ++++++++++++++++++++++++++++++++++++---
 builtin/checkout.c        |  4 +--
 refs.c                    | 21 ++++++------
 refs.h                    | 18 +++++++---
 refs/debug.c              | 14 ++++----
 refs/files-backend.c      | 30 ++++++++---------
 refs/packed-backend.c     |  7 ++--
 refs/refs-internal.h      |  7 ++--
 t/helper/test-ref-store.c |  2 +-
 t/t3200-branch.sh         | 58 ++++++++++++++++++++++++++++++++
 12 files changed, 199 insertions(+), 61 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog

