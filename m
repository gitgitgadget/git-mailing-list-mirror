Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E02C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693C2613DF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFKW4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKW4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 18:56:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDFC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:54:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r5-20020a2582850000b02905381b1b616eso6240110ybk.6
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F/MjF5VPsx8WFT6FxxR8rPIrhUbtYf7+RelZv64e1Lo=;
        b=KZm/QBxwXGRuMzRn7eNDLW93N7Q9MBaojjQJ2wecmaH+2YoE/uM6ZlE/Rfszz4coix
         xFwICvS0BtvpTTf1cTfEy6ASGhfurLDmSLKHePw6KKW5mhbGwN9Appvb6sCgCB8VKd0h
         LBj5xZd811+Gd9KocxL13vnuxG+fNJXEbfVhs/yT8ffGeFpLLszpwQJ5944moec2Xf1s
         mad8dWr1Cp9A2OsKDRya9Ap3PoeRZ46RbBEx66ryF2p4MqwagCxhg1YkKVttaKwiiSEX
         4JmIbvR1ORn2aXRmpFftgzTSnJgAz5iBUB+bgtjLhMRmESUayMAl2ILF+MjmsZT72AKW
         xGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F/MjF5VPsx8WFT6FxxR8rPIrhUbtYf7+RelZv64e1Lo=;
        b=gvRpSxbM1+sER1wj4XuaiXzh8A6OUEGt9cBZz7mAiZNc0tdLQ6hBzWNNt6iPNeS+Rq
         2p8nhhK1pl6wE61PwFoTcEZ9gD78L0dIV9pZoL0vZnUTRaajVOTXHiEFd4yw+RnajRBG
         Tk8B2nmMbN8/PPe98nYK2BmlFVi2fjQDM45M1giH58IEhhR0F4nu6qfFJmwfd1bbrexU
         5xHfxXABxpWl+ddMbcOV7C6FMgrcIwalVlPcGSPB1MfUSXBmnrcnxlaF0VAFXU90hShh
         //AtkyGZQ4GyIRboGmtPoXdp4vPne8sWi2N87xAEeBznnna30pd8RLoYMqZFVoTpRP6A
         e/cQ==
X-Gm-Message-State: AOAM532dxymzoSUU2SPj6S/qdjqaK5YtO4H/9ukNajvHBUfyLgumo/gM
        Idj5Tn2bBLjOxIcPYZE6Ks7OjzGBaZIARtdy60mmd/WmZaYQjd4PEa7jx+y2B8OxzaBTNgeaQsp
        QKc82/kVwtfBKrkhegHGKtKDRNreRWuhYcEsB6Fk/yOUl4cHdviBXtWWfxlKNhfnFSmHoL+7A+w
        ==
X-Google-Smtp-Source: ABdhPJzwMoGTR3IsUsTMtzoK8ClchWndHtVNvKriV8zH+WxWkW/NiHoJ0BwJi7YGV70C823Pp+vyyDD2SN/Ylt0KPhs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c894:862c:2364:ff78])
 (user=emilyshaffer job=sendgmr) by 2002:a25:3d6:: with SMTP id
 205mr9947770ybd.350.1623452073330; Fri, 11 Jun 2021 15:54:33 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:54:24 -0700
Message-Id: <20210611225428.1208973-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 0/4] cache parent project's gitdir in submodules
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
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's necessary for a superproject to know which submodules it contains.
However, historically submodules do not know they are anything but a
normal single-repo Git project (or a superproject, in nested-submodules
cases). This decision does help prevent us from having to support
divergent behaviors in submodule projects vs. superprojects, which makes
sure Git is (somewhat) less confusing for the reader, and helps simplify
our code.

One could imagine, though, some conveniences we could gain from
submodules learning added behavior (though not necessarily *different*
behavior) to provide more context about the state of the project as a
whole, and to make large submodule-based projects easier to work with.
One example is a series[1] I sent some time ago, adding a config to be
shared between the superproject and all its submodules. The RFC[2] I
sent around the same time mentions a few other examples, such as "git
status" run in the submodule noticing whether the superproject has a
commit referencing the submodule's current HEAD.

It's expensive and non-definitive to try and guess whether or not the
current repo is a submodule. submodule.c:get_superproject_working_tree()
does so by essentially running 'git -C .. ls-files -- <own-path>',
invoking an additional process. get_superproject_working_tree() is not
called often, so that's mostly fine. However, [1] attempted to include
an additional config located in the superproject's gitdir by running
'git -C .. rev-parse --git-dir' during startup - a little expensive in
the best case, because it's an extra process, but extremely expensive in
the case when the current repo is *not* a submodule, because we hunt all
the way up the filesystem looking for a '.git'. Adding that cost to
every startup is infeasible.

To that end, in this series I propose caching a path to the
superproject's gitdir - by having the superproject write that relative
path to the submodule's config on creation or update. The goal here is
*not* to say "If I am a submodule, I must have
submodule.superprojectGitDir set" - but instead to say "If I have
submodule.superprojectGitDir set, then I must be a submodule." That is,
I expect we will find edge cases where a submodule was introduced in
some interesting way that bypassed any of the patches below, and
therefore doesn't have the superproject's gitdir cached.

The combination of these two rules:
 - Anything relying on submodule.superprojectGitDir must be nice to
   have, but not essential, because
 - It's possible for a submodule to be valid without having
   submodule.superprojectGitDir set
makes me feel more comfortable with the idea of submodules learning
additional behavior based on this config. I feel pretty unconfident in
our ability to ensure that *every* submodule has this config set.

The series covers a few paths for introducing that config, which I'm
hoping covers most cases.
 - "git submodule update" (which seems to be part of the "git submodule
   init" flow)
 - "git submodule absorbgitdir" to convert a "git init"'d repo into a
   submodule

Notably, we can only really set this config when 'the_repository' is the
superproject - that appears to be the only time when we know the gitdirs
of both the superproject and the submodule.

I'm expecting folks may have a lot to say about this, so I look forward
to discussion :)

 - Emily

1: https://lore.kernel.org/git/20210423001539.4059524-1-emilyshaffer@google.com
2: https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com

Emily Shaffer (4):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir cache
  submodule: cache superproject gitdir during absorbgitdirs
  submodule: cache superproject gitdir during 'update'

 builtin/submodule--helper.c        |  4 +++
 git-submodule.sh                   |  9 ++++++
 submodule.c                        | 10 ++++++
 t/t7400-submodule-basic.sh         | 49 ++++++++++++++----------------
 t/t7406-submodule-update.sh        | 10 ++++++
 t/t7412-submodule-absorbgitdirs.sh |  1 +
 6 files changed, 57 insertions(+), 26 deletions(-)

-- 
2.32.0.272.g935e593368-goog

