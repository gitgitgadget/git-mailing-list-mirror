Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D37C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392BB610CF
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 20:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhHSUKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 16:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHSUKj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 16:10:39 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DFC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:02 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id m10-20020a056214158ab029035a6c1e5f3eso5305274qvw.7
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Pcynat2bFy1Af25C2O+UGTuZVpkW6K4h8MEk/OItTbM=;
        b=LwhUL52+BWW2+j6jDpXFKDTR3aWVmydGsBlVYySwbULZPgyYOH9SxJPX7WeYLmFA8g
         4eDisYuE96zsOlvFCZKaOqpQwlb6trg2qH9O6jXlcD1vyds8vixui8jOvDMismvqKbQY
         GKfxqAW1YrZcu/n5tpdzh0ltQ+W5jIwrpaAjxjwxMNwRlGVMBnXaZQky8979gmaXyiXu
         rV7dsVTJdQtIV17iTgGGLyNnYUaJz8Sf5dUVfqSCAcXVYL8jOh2yu9t2PmZpZZBuC7oU
         Bya16aAYMYa7cvX8V2G2meOthS5wFTTfVTrElZyJ5MAEOrDgi3PjCr5hGJlG0jVsZSaZ
         E5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Pcynat2bFy1Af25C2O+UGTuZVpkW6K4h8MEk/OItTbM=;
        b=WGhJLRVP0LR6Y3siowL7P54BlAjnsph96FiXksCsKwjvrRQ7GKsykPTZeJo80Cr2CT
         w5lA+gfdzB60YwQGmHtkX/KKm98Ciy6oQHpm6CoWuP0rBcHjmpPgPD4dW2t8FeB/9+ss
         SGoAB0b5JRUJ2npbl7mg+KIViP1JZZfUa9hBo4liHbHvxiebS631wAIZKJ8RxQQ9BrlX
         E0q4qxAYQUaLzm41wKjPT8S/OEPUgDpuXCnf88jes7u8Pe691FeAuAUCSiJMLNjZqakW
         fztqx/SoHxYlcufYU54/pCIMFIocEYt/RZmw6Va5ydnLJ3cLEvWt9XOzpa1gqgIGC9ZZ
         0WGg==
X-Gm-Message-State: AOAM532+J+HDee0RxkVdaXEhDweYkU6I15JDKGm6o6Nqbcljmi72aBIN
        TudpxzFnm+c416IZfQMusrCoQI5lLJeFBlqSL03xnS+C87RHRC1yepKIXkliFYhSqiElIB7RR8l
        Nfrh+ASqXjyEZEFEke4+UDYztheBj4onGqWSWnbVnSyYSAR1zaJ7iknelut5tS/j7UQ6WUOQlfA
        ==
X-Google-Smtp-Source: ABdhPJyK2olJ5Yozz5J8qQRe061asBPiBPStm2mmJxs4IMPAM570FzWbAko2PqzkGqk8N7aidYaPyL5JDPOopD78YQc=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:5c:aa12:af53:acbb])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:144e:: with SMTP id
 b14mr16366289qvy.44.1629403801496; Thu, 19 Aug 2021 13:10:01 -0700 (PDT)
Date:   Thu, 19 Aug 2021 13:09:49 -0700
In-Reply-To: <20210616004508.87186-1-emilyshaffer@google.com>
Message-Id: <20210819200953.2105230-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v3 0/4] cache parent project's gitdir in submodules
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2, mostly documentation changes and a handful of small nits from
Junio and Jonathan Tan. Thanks for the reviews, both.

CI run here: https://github.com/nasamuffin/git/actions/runs/1147984974

 - Emily

Emily Shaffer (4):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir record
  submodule: record superproject gitdir during absorbgitdirs
  submodule: record superproject gitdir during 'update'

 Documentation/config/submodule.txt | 15 ++++++++++
 builtin/submodule--helper.c        |  4 +++
 git-submodule.sh                   | 10 +++++++
 submodule.c                        | 10 +++++++
 t/t7400-submodule-basic.sh         | 48 ++++++++++++++----------------
 t/t7406-submodule-update.sh        | 10 +++++++
 t/t7412-submodule-absorbgitdirs.sh |  9 +++++-
 7 files changed, 79 insertions(+), 27 deletions(-)

Range-diff against v2:
1:  a6718eea80 ! 1:  f1236dc9d7 t7400-submodule-basic: modernize inspect() helper
    @@ t/t7400-submodule-basic.sh: test_expect_success 'setup - repository to add submo
     +	git -C "$dir" clean -n -d -x >untracked
      }
      
    -+
      test_expect_success 'submodule add' '
    - 	echo "refs/heads/main" >expect &&
    - 
     @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add' '
      	) &&
      
2:  4cebe7bcb5 ! 2:  2caf9eb8ee introduce submodule.superprojectGitDir cache
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    introduce submodule.superprojectGitDir cache
    +    introduce submodule.superprojectGitDir record
     
         Teach submodules a reference to their superproject's gitdir. This allows
         us to A) know that we're running from a submodule, and B) have a
    @@ Commit message
         superproject directory around on the filesystem without breaking the
         submodule's cache.
     
    -    Since this cached value is only introduced during new submodule creation
    +    Since this hint value is only introduced during new submodule creation
         via `git submodule add`, though, there is more work to do to allow the
    -    cache to be created at other times.
    +    record to be created at other times.
    +
    +    If the new config is present, we can do some optional value-added
    +    behavior, like letting "git status" print additional info about the
    +    submodule's status in relation to its superproject, or like letting the
    +    superproject and submodule share an additional config file separate from
    +    either one's local config.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/config/submodule.txt ##
     @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy::
    @@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy::
      	clone proceeds as if no alternate was specified.
     +
     +submodule.superprojectGitDir::
    -+	The relative path from the submodule's worktree  to the superproject's
    -+	gitdir. This config should only be present in projects which are
    -+	submodules, but is not guaranteed to be present in every submodule. It
    -+	is set automatically during submodule creation.
    ++	The relative path from the submodule's worktree to its superproject's
    ++	gitdir. When Git is run in a repository, it usually makes no difference
    ++	whether this repository is standalone or a submodule, but if this
    ++	configuration variable is present, additional behavior may be possible,
    ++	such as "git status" printing additional information about this
    ++	submodule's status with respect to its superproject. This config should
    ++	only be present in projects which are submodules, but is not guaranteed
    ++	to be present in every submodule, so only optional value-added behavior
    ++	should be linked to it. It is set automatically during
    ++	submodule creation.
     ++
    -+	In situations where more than one superproject references the same
    -+	submodule worktree, the value of this config and the behavior of
    -+	operations which use it are undefined. To reference a single project
    -+	from multiple superprojects, it is better to create a worktree of the
    -+	submodule for each superproject.
    ++	Because of this configuration variable, it is forbidden to use the
    ++	same submodule worktree shared by multiple superprojects.
     
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
    @@ t/t7400-submodule-basic.sh: test_expect_success 'setup - repository to add submo
     +	git -C "$sub_dir" clean -n -d -x >untracked
      }
      
    - 
    + test_expect_success 'submodule add' '
     @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add' '
      	) &&
      
3:  df97a9c2bb ! 3:  d278568a8e submodule: cache superproject gitdir during absorbgitdirs
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    submodule: cache superproject gitdir during absorbgitdirs
    +    submodule: record superproject gitdir during absorbgitdirs
     
    -    Already during 'git submodule add' we cache a pointer to the
    +    Already during 'git submodule add' we record a pointer to the
         superproject's gitdir. However, this doesn't help brand-new
         submodules created with 'git init' and later absorbed with 'git
         submodule absorbgitdir'. Let's start adding that pointer during 'git
4:  a3f3be58ad ! 4:  6866c36620 submodule: cache superproject gitdir during 'update'
    @@ Metadata
     Author: Emily Shaffer <emilyshaffer@google.com>
     
      ## Commit message ##
    -    submodule: cache superproject gitdir during 'update'
    +    submodule: record superproject gitdir during 'update'
     
    -    A cached path to the superproject's gitdir might be added during 'git
    -    submodule add', but in some cases - like submodules which were created
    -    before 'git submodule add' learned to cache that info - it might be
    -    useful to update the cache. Let's do it during 'git submodule update',
    -    when we already have a handle to the superproject while calling
    +    A recorded hint path to the superproject's gitdir might be added during
    +    'git submodule add', but in some cases - like submodules which were
    +    created before 'git submodule add' learned to record that info - it might
    +    be useful to update the hint. Let's do it during 'git submodule
    +    update', when we already have a handle to the superproject while calling
         operations on the submodules.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
-- 
2.33.0.rc2.250.ged5fa647cd-goog

