Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209DC48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7461361185
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 23:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhFPXeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhFPXeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 19:34:01 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800F4C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:31:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v186-20020a632fc30000b029022192d6757dso2473425pgv.22
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=s5z4wOPN9yV9kB5Pf11Kp4LCwO0YNKzNQtLCdqD3QrE=;
        b=PpgRBv0U6Tpwnib995IGL0eJIFlNz5bCQYxF7sdUTtjVr4UUKn5e3wu4YhnoL/OWaL
         x9RgJdHs8f3yqPDwhFZYD+FTGzyC15OY2tIVvqE/g4eX7ZExoZV+p4PwJUX1QiIOqPND
         qkLgyEeGwESXAbZ6+nI9CQMr7T3uQRmPReLmtVEmE2/4DANvcjJgGh0JzAWhDZVy6tGM
         fIADpZAiyF6d9kMdsmw/g8tjyBSljnG7T8J6UwxtjhR9B3pPnIbXotyUPrkuwUKdx4Hh
         SJ0/AVutUhbiLQRe21ygq1IEzpmQCJr7hcpNJqiN76KoC2zcnRuacV3kbIOMJ/gqnECZ
         802w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=s5z4wOPN9yV9kB5Pf11Kp4LCwO0YNKzNQtLCdqD3QrE=;
        b=tBH8X5GyYRhqfWgWObzvJnJMN+DA9rafafAE1J2aEEEqmHDrmuYVSPkGPyKQ9Em7Du
         CnJG8GwO/I1qNXXgmrHmkZqcgORnDM2f39u6De7MYoF4UogGlk63KICzTBi0EhjxRiih
         OyvCljwTLG3e1T+NpXf4w4CT5kKO1mMvQBc9fnr2UTeXZ9P62emOo4hN1gufY8us6vxO
         6CoQTCa7w1Vdzzy56aPT88e+WOld4+aKOfYxlI9jrJ5DE4VsFw+1myHvYaRmiwvrxKba
         7kpWw10dPV+5mV07HbSoKhuTMbLIUvOdzAlS7pXgzSFhuPDR22tPqQtY3obXEgyHMH1E
         qTDw==
X-Gm-Message-State: AOAM531kXiBRBUVYggGaDD61G/x38C0vVbyNa6lTh23yTnYXU15LH8q1
        vNzo8ASlt5WeYTWoW0Z3/Pl/40Gp8p4Oy04vexE3ikxjaUU11PHwtr8NbQrwDiQFTAYH6lm+MKi
        yOBB0Kc7Xy3sqGGrpqDn1b+v+bsCeONaY+TTXVHhYc5KqD6gI+YUS5P2VpZp6T3Uz0KnGUU2wVI
        /5
X-Google-Smtp-Source: ABdhPJwjqYruNkpdSsdqYKuv5appiRGWO2YTfmz/ISu52woAQcFQeG4uhZ7BwOtj5x+3hHE2gddKfPO+82q6tSBMvmJG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8493:b029:11a:faa6:5bf6 with
 SMTP id c19-20020a1709028493b029011afaa65bf6mr1915388plo.42.1623886313660;
 Wed, 16 Jun 2021 16:31:53 -0700 (PDT)
Date:   Wed, 16 Jun 2021 16:31:47 -0700
Message-Id: <cover.1623881977.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a continuation of the work from [1]. That work described the
reasons, possible features, and possible workflows, but not the
implementation in detail. This patch set has an MVP implementation, and
my hope is that having a concrete implementation to look at makes it
easier to discuss matters of implementation.

This but does not use any features from es/config-based-hooks but is
implemented on that branch anyway because firstly, I need an existing
command to attach the "autoupdate" subcommand (and "git hook" works),
and secondly, when we test this at $DAYJOB, we will be testing it
together with the aforementioned branch.

I have had to make several design choices (which I will discuss later),
but now with this implementation, the following workflow is possible:

 1. The remote repo administrator creates a new branch
    "refs/heads/suggested-hooks" pointing to a commit that has all the
    hooks that the administrator wants to suggest. The hooks are
    directly referenced by the commit tree (i.e. they are in the "/"
    directory).

 2. When a user clones, Git notices that
    "refs/remotes/origin/suggested-hooks" is present and prints out a
    message about a command that can be run.

 3. If the user runs that command, Git will install the hooks pointed to
    by that ref, and set hook.autoupdate to true. This config variable
    is checked whenever "git fetch" is run: whenever it notices that
    "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
    hooks.

 4. To turn off autoupdate, set hook.autoupdate to false. Existing hooks
    will remain.

Design choices:

 1. Where should the suggested hooks be in the remote repo? A branch,
    a non-branch ref, a config? I think that a branch is best - it is
    relatively well-understood and any hooks there can be
    version-controlled (and its history is independent of the other
    branches).

 2. When and how should the local repo update its record of the remote's
    suggested hooks? If we go with storing the hooks in a branch of a
    remote side, this would automatically mean (with the default
    refspec) that it would be in refs/remotes/<remote>/<name>. This
    incurs network and hard disk cost even if the local repo does not
    want to use the suggested hooks, but I think that typically they
    would want to use it if they're going to do any work on the repo
    (they would either have to trust or inspect Makefiles etc. anyway,
    so they can do the same for the hooks), and even if they don't want
    to use the remote's hooks, they probably still want to know what the
    remote suggests.

    So using a branch provides a well-understood way of storing the
    hooks on the remote, transmitting it to the local repo, and storing
    the hooks in the local repo.

    So: what should be the default name of this branch? Presumably, "git
    clone" would need to be able to override this.

 3. How should the local repo detect when the remote has updated its
    suggested hooks? I'm thinking when a certain local ref is updated.
    Right now it's hardcoded, but perhaps "git clone" could detect what
    "refs/heads/suggested-hooks" would correspond to, and then set it in
    a config accordingly. Other options include remembering what the
    remote's "refs/heads/suggested-hooks" used to be and always
    comparing it upon every "ls-refs" call, but I think that the local
    ref method is more straightforward.

 4. Should the local repo try to notice if the hooks have been changed
    locally before overwriting upon autoupdate? This would be nice to
    have, but I don't know how practical it would be. In particular, I
    don't know if we can trust that
    "refs/remotes/origin/suggested-hooks" has not been clobbered.

 5. Should we have a command that manually updates the hooks with what's
    in "refs/heads/suggested-hooks"? This is not in this patch set, but
    it sounds like a good idea.

There are perhaps other points that I haven't thought of, of course.

[1] https://lore.kernel.org/git/pull.908.git.1616105016055.gitgitgadget@gmail.com/

Jonathan Tan (2):
  hook: move list of hooks
  clone,fetch: remote-suggested auto-updating hooks

 builtin/bugreport.c |  38 ++------------
 builtin/clone.c     |  10 ++++
 builtin/fetch.c     |  21 ++++++++
 builtin/hook.c      |  13 +++--
 hook.c              | 118 ++++++++++++++++++++++++++++++++++++++++++++
 hook.h              |   5 ++
 t/t5601-clone.sh    |  36 ++++++++++++++
 7 files changed, 202 insertions(+), 39 deletions(-)

-- 
2.32.0.272.g935e593368-goog

