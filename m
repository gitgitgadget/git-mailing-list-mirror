Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255BEB64DA
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjGNGBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGNGBk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60312D45
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3141c3a7547so1624564f8f.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314496; x=1691906496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9ev/9iQuNoOgzofaKYMYL897ngOwk5e1M4eO1nkgDo=;
        b=RtiEca/5yoal6ACZPmwoc20ckXs6QfvQN3CflN5q04JK7lv5EakwKzGElp1D3d6+jM
         DYtwm3ALA74fJR21LFcs36NyFuP4mrBaoDPc6L3u4vOZLsVJJ4l4Inclj08wAZNa8+GA
         aEDu3J+plEuPWNw4IRgZqCkJ2XOkM24pBcdVu/gxHwgJIFaXJYR2/k2auXQEp8R3FHtI
         eVH7V7R7+QylZUzrF95X7JlwSFL/raDG6HBk/zvP+WZXMlo3sOxh4BPUKAwbF4qwzR+p
         8lDP//6bHdh54okhqEPf0Fk3GwPtkF5Icp+BOlS5ymZybbj1VjtP52hRrnkEzBQuDb2m
         HCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314496; x=1691906496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9ev/9iQuNoOgzofaKYMYL897ngOwk5e1M4eO1nkgDo=;
        b=Coeaw5MiPJtWTQtUPpcYUFtKaWswPrrn5upLhazBY3QFjapwurVkf5qrYZyrBg8ZNP
         Pr/PvoRuF74YzHmuipom4LPJTWXkRgpgHwb8abecXsXqZdXJlGHe50GpQ/cMpxeSikmx
         zzmj+KCVPw1Mt3hEjgNKbtcQNP4KMECvqzjmYJ2A99J+KEPeTOQ3KejYkAIFXqxlhPTF
         jr3Jr1vgUkghNluR2eLf2V4LR21TZxTXJzS3zs2VgS0uqifeCU/eK1+XPXwp5jESvfLJ
         Qx5lcv/sqIFS6aOC0DVZryiOlAK1RKLEYMyWcEAO5RdvgysFOILkMA8mz5lF0A/cfPtz
         WCQQ==
X-Gm-Message-State: ABy/qLabM82oJKqjP1oTAXPBY50i+MQfFuph53suQfw3/WY6nrdUUiZ1
        5q7bhwcKUewJNANWtoeQ+ND0xdObF20=
X-Google-Smtp-Source: APBJJlEO+0SdKLum88lQJn1KrU/FMPySf+wQ/OwxcmOeBa/Ep8WdlkTscP5IwrurQdx0jyas6vhBLQ==
X-Received: by 2002:a05:6000:1c6:b0:314:10d8:b491 with SMTP id t6-20020a05600001c600b0031410d8b491mr3258823wrx.67.1689314495675;
        Thu, 13 Jul 2023 23:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d66ca000000b00313f9085119sm9852861wrw.113.2023.07.13.23.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:01:35 -0700 (PDT)
Message-ID: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 06:01:28 +0000
Subject: [PATCH v2 0/5] SubmittingPatches: clarify which branch to use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series rewords the "base-branch" section (now renamed to
"choose-starting-point") to be more informative in general to new
contributors, who may not be as familiar with the various integration
branches. Other smaller cleanups and improvements were made along the way.


Updates in v2
=============

 * The language about choosing the "oldest" branch was retained, and
   expanded. It turns out that this language is also present in
   gitworkflows, however the meaning of the word "oldest" was not explained
   properly in the "base-branch" section. This has been addressed.
 * Rename "base-branch" to "choose-starting-point"
 * Patch 04 (emphasize need to communicate non-default starting points) is
   new.

Linus Arver (5):
  SubmittingPatches: reword awkward phrasing
  SubmittingPatches: discuss subsystems separately from git.git
  SubmittingPatches: de-emphasize branches as starting points
  SubmittingPatches: emphasize need to communicate non-default starting
    points
  SubmittingPatches: simplify guidance for choosing a starting point

 Documentation/SubmittingPatches | 125 +++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 41 deletions(-)


base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1556%2Flistx%2Fdoc-submitting-patches-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1556/listx/doc-submitting-patches-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1556

Range-diff vs v1:

 1:  cb4a61eba8d = 1:  08deed14d96 SubmittingPatches: reword awkward phrasing
 3:  d430a4ed8ee ! 2:  8d4b57a8704 SubmittingPatches: discuss subsystems separately from git.git
     @@ Commit message
          SubmittingPatches: discuss subsystems separately from git.git
      
          The discussion around subsystems disrupts the flow of discussion in the
     -    surrounding area, which only deals with branches used for the git.git
     -    project. So move this bullet point out to the end.
     +    surrounding area, which only deals with starting points used for the
     +    git.git project. So move this bullet point out to the end.
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ Documentation/SubmittingPatches: change is relevant to.
       master..seen` and look for the merge commit. The second parent of this
       commit is the tip of the topic branch.
       
     -+Note that some parts of the system have dedicated maintainers with their
     -+own separate source code repositories (see the section "Subsystems"
     -+below).
     ++Finally, note that some parts of the system have dedicated maintainers
     ++with their own separate source code repositories (see the section
     ++"Subsystems" below).
      +
       [[separate-commits]]
       === Make separate commits for logically separate changes.
 2:  203ed19dd1b ! 3:  69fef8afe64 SubmittingPatches: be more explicit
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    SubmittingPatches: be more explicit
     +    SubmittingPatches: de-emphasize branches as starting points
      
     +    It could be that a suitable branch does not exist, so instead just use
     +    the phrase "starting point". Technically speaking the starting point
     +    would be a commit (not a branch) anyway.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## Documentation/SubmittingPatches ##
     -@@ Documentation/SubmittingPatches: project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
     +@@ Documentation/SubmittingPatches: Here are some guidelines for contributing back to this
     + project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
       available which covers many of these same guidelines.
       
     - [[base-branch]]
     +-[[base-branch]]
      -=== Decide what to base your work on.
     -+=== Decide which branch to base your work on.
     ++[[choose-starting-point]]
     ++=== Choose a starting point.
       
       In general, always base your work on the oldest branch that your
       change is relevant to.
     @@ Documentation/SubmittingPatches: Please make sure your patch does not add commen
       your patch after generating it, to ensure accuracy.  Before
      -sending out, please make sure it cleanly applies to the base you
      -have chosen in the "Decide what to base your work on" section,
     -+sending out, please make sure it cleanly applies to the branch you
     -+have chosen in the "Decide which branch to base your work on" section,
     ++sending out, please make sure it cleanly applies to the starting point you
     ++have chosen in the "Choose a starting point" section,
       and unless it targets the `master` branch (which is the default),
       mark your patches as such.
       
 -:  ----------- > 4:  f8f96a79b92 SubmittingPatches: emphasize need to communicate non-default starting points
 4:  55bed55cb88 ! 5:  5ec91d02b7a SubmittingPatches: remove confusing guidance about base branches
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    SubmittingPatches: remove confusing guidance about base branches
     +    SubmittingPatches: simplify guidance for choosing a starting point
      
     -    The guidance to "base your work on the oldest branch that your change is
     -    relevant to" was added in d0c26f0f56 (SubmittingPatches: Add new section
     -    about what to base work on, 2010-04-19). That commit also added the
     -    bullet points which describe the scenarios where one would use one of
     -    "maint", "master", "next", and "seen" ("pu" in the original as that was
     -    the name of this branch before it was renamed, per 828197de8f (docs:
     -    adjust for the recent rename of `pu` to `seen`, 2020-06-25)).
     +    Background: The guidance to "base your work on the oldest branch that
     +    your change is relevant to" was added in d0c26f0f56 (SubmittingPatches:
     +    Add new section about what to base work on, 2010-04-19). That commit
     +    also added the bullet points which describe the scenarios where one
     +    would use one of the following named branches: "maint", "master",
     +    "next", and "seen" ("pu" in the original as that was the name of this
     +    branch before it was renamed, per 828197de8f (docs: adjust for the
     +    recent rename of `pu` to `seen`, 2020-06-25)). The guidance was probably
     +    taken from existing similar language introduced in the "Merge upwards"
     +    section of gitworkflows in f948dd8992 (Documentation: add manpage about
     +    workflows, 2008-10-19).
      
     -    The underlying principle of this guidance was probably something like
     -    "base your work on the earlier-in-history branch so your change can be
     -    merged forward". However, this principle is already concretely explained
     -    in the accompanying bullet points. This principle should only come into
     -    play if none of the scenarios described in the bullet points apply ---
     -    and such a situation would be exceedingly rare.
     -
     -    Also, the guidance's wording of using the "oldest" branch is confusing
     -    when read together with the rest of this section, because three of the
     -    four named branches discussed ("master", "next", and "seen") move
     -    frequently enough to not be considered "old" at all.
     -
     -    For these reasons, remove the guidance _without_ preserving the meaning
     -    of the underlying principle, and instead add an overview of the four
     -    named branches.
     +    Summary: This change simplifies the guidance by pointing users to just
     +    "maint" or "master". But it also gives an explanation of why that is
     +    preferred and what is meant by preferring "older" branches (which might
     +    be confusing to some because "old" here is meant in relative terms
     +    between these named branches, not in terms of the age of the branches
     +    themselves). We also add an example to illustrate why it would be a bad
     +    idea to use "next" as a starting point, which may not be so obvious to
     +    new contributors.
      
          Helped-by: Jonathan Nieder <jrnieder@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## Documentation/SubmittingPatches ##
      @@ Documentation/SubmittingPatches: available which covers many of these same guidelines.
     - [[base-branch]]
     - === Decide which branch to base your work on.
     + [[choose-starting-point]]
     + === Choose a starting point.
       
      -In general, always base your work on the oldest branch that your
      -change is relevant to.
     -+The following branches are the typical starting points for new work:
     +-
     +-* A bugfix should be based on `maint` in general. If the bug is not
     +-  present in `maint`, base it on `master`. For a bug that's not yet
     +-  in `master`, find the topic that introduces the regression, and
     +-  base your work on the tip of the topic.
     +-
     +-* A new feature should be based on `master` in general. If the new
     +-  feature depends on other topics that are in `next`, but not in
     +-  `master`, fork a branch from the tip of `master`, merge these topics
     +-  to the branch, and work on that branch.  You can remind yourself of
     +-  how you prepared the base with `git log --first-parent master..`.
     +-
     +-* Corrections and enhancements to a topic not yet in `master` should
     +-  be based on the tip of that topic. If the topic has not been merged
     +-  to `next`, it's alright to add a note to squash minor corrections
     +-  into the series.
     +-
     +-* In the exceptional case that a new feature depends on several topics
     +-  not in `master`, start working on `next` or `seen` privately and
     +-  send out patches only for discussion. Once your new feature starts
     +-  to stabilize, you would have to rebase it (see the "depends on other
     +-  topics" above).
     +-
     +-To find the tip of a topic branch, run `git log --first-parent
     +-master..seen` and look for the merge commit. The second parent of this
     +-commit is the tip of the topic branch.
     ++As a preliminary step, you must first choose a starting point for your
     ++work. Typically this means choosing a branch, although technically
     ++speaking it is actually a particular commit (typically the HEAD, or tip,
     ++of the branch).
     ++
     ++There are several important branches to be aware of. Namely, there are
     ++four integration branches as discussed in linkgit:gitworkflows[7]:
      +
      +* maint
      +* master
      +* next
      +* seen
      +
     -+These branches are explained in detail in linkgit:gitworkflows[7].
     -+Choose the appropriate branch depending on the following scenarios:
     ++The branches lower on the list are typically descendants of the ones
     ++that come before it. For example, `maint` is an "older" branch than
     ++`master` because `master` usually has patches (commits) on top of
     ++`maint`.
     ++
     ++There are also "topic" branches, which contain work from other
     ++contributors.  Topic branches are created by the Git maintainer (in
     ++their fork) to organize the current set of incoming contributions on
     ++the mailing list, and are itemized in the regular "What's cooking in
     ++git.git" announcements.  To find the tip of a topic branch, run `git log
     ++--first-parent master..seen` and look for the merge commit. The second
     ++parent of this commit is the tip of the topic branch.
     ++
     ++There is one guiding principle for choosing the right starting point: in
     ++general, always base your work on the oldest integration branch that
     ++your change is relevant to (see "Merge upwards" in
     ++linkgit:gitworkflows[7]).  What this principle means is that for the
     ++vast majority of cases, the starting point for new work should be the
     ++latest HEAD commit of `maint` or `master` based on the following cases:
     ++
     ++* If you are fixing bugs in the released version, use `maint` as the
     ++  starting point (which may mean you have to fix things without using
     ++  new API features on the cutting edge that recently appeared in
     ++  `master` but were not available in the released version).
     ++
     ++* Otherwise (such as if you are adding new features) use `master`.
     ++
     ++This also means that `next` or `seen` are inappropriate starting points
     ++for your work, if you want your work to have a realistic chance of
     ++graduating to `master`.  They are simply not designed to provide a
     ++stable base for new work, because they are (by design) frequently
     ++re-integrated with incoming patches on the mailing list and force-pushed
     ++to replace previous versions of these branches.
     ++
     ++For example, if you are making tree-wide changes, while somebody else is
     ++also making their own tree-wide changes, your work may have severe
     ++overlap with the other person's work.  This situation may tempt you to
     ++use `next` as your starting point (because it would have the other
     ++person's work included in it), but doing so would mean you'll not only
     ++depend on the other person's work, but all the other random things from
     ++other contributors that are already integrated into `next`.  And as soon
     ++as `next` is updated with a new version, all of your work will need to
     ++be rebased anyway in order for them to be cleanly applied by the
     ++maintainer.
     ++
     ++Under truly exceptional circumstances where you absolutely must depend
     ++on a select few topic branches that are already in `next` but not in
     ++`master`, you may want to create your own custom base-branch by forking
     ++`master` and merging the required topic branches to it. You could then
     ++work on top of this base-branch.  But keep in mind that this base-branch
     ++would only be known privately to you.  So when you are ready to send
     ++your patches to the list, be sure to communicate how you created it in
     ++your cover letter.  This critical piece of information would allow
     ++others to recreate your base-branch on their end in order for them to
     ++try out your work.
       
     - * A bugfix should be based on `maint` in general. If the bug is not
     -   present in `maint`, base it on `master`. For a bug that's not yet
     + Finally, note that some parts of the system have dedicated maintainers
     + with their own separate source code repositories (see the section
 5:  1db7a1be27f < -:  ----------- SubmittingPatches: define topic branches

-- 
gitgitgadget
