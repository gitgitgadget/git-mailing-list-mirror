Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B14C77B73
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjEVT3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjEVT3J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:29:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA414138
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30948709b3cso3487689f8f.3
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783744; x=1687375744;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7M+lNVlFEOAais5uKaO3uZFYU2yl9sl6FsCdXx6HPM=;
        b=OypIEQ6cwAJ8Q2QZKY30hEqdSweQiPsEbLULXvGxnHxcLZEY8DdjrIR8SM+qVntZad
         xApzauSEUQwbQ2CiHDQQy5W41MmVtIDoBKwaaRHjqQGsLCbjCUQ+HDn690LTgsFUrqar
         ORZGPUZAoCOlAK0r9mR4Wh4esjUL9glNDALiQIAudj7awQhbmkt0ZxZztFChPoH3Z82H
         P9AjTu9KLA2gTajvwR3zUDctIu5Klx87LfPvAyFQZPQszdpSKy0uvE2JbTL0TnNHg6DC
         IjlraSB5B9yitIaaWY1t3UwKNYqzeqjKLjgDdAgUHFhr1fFBwrxHJEjVK7apv/cWG12N
         mA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783744; x=1687375744;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7M+lNVlFEOAais5uKaO3uZFYU2yl9sl6FsCdXx6HPM=;
        b=drvLFa0CajAS3KUHFW5yHf2ifLfFKGLZvHH2CCfFfnIF9aM8H1J+zTfM9ljdzATUJ4
         pB8svu0pxUkDnmEj6wdfNpMFcVAd1NRQgBBszkdJAtcPwr5MSI2fOw+4u0s2Wl1/kdDH
         U346PKQillQ7jB4uFoQg5he3V0cG91fY+GaX0W6SrDYceje21Gr6B6aOK84t83dxOAMI
         pumdTX0FA9I7QnK2mx4KmLlPucfT3zLUa9IQFaXfZ9FFRyuKLlflpQgnzWUCGUTX4Ef4
         91c+d4MN6kXUgoCrSHxMZ1vFN489SY1WYOgSUkU7APZT2yK6yPh7PWOjJtE71a5XLRup
         gVJA==
X-Gm-Message-State: AC+VfDy1yl2nP7BWygop4iuWbyxHXDEJosQH3OR73G7eMXGaI1pk9rAl
        //80pRw2d7YBlwEfCqB88NamHdjT/mg=
X-Google-Smtp-Source: ACHHUZ6dvLHBtr/lmi1QHLdK32dUgAUoQK6782CLbw0NQHkkUURygK4dqyHn7NtelMY+uJSHCRpP1w==
X-Received: by 2002:adf:dcca:0:b0:2f0:2d92:9c81 with SMTP id x10-20020adfdcca000000b002f02d929c81mr8971563wrm.19.1684783743508;
        Mon, 22 May 2023 12:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d4ccd000000b003078bb639bdsm8544210wrt.68.2023.05.22.12.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:29:03 -0700 (PDT)
Message-Id: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 May 2023 19:28:55 +0000
Subject: [PATCH v2 0/6] Document 'AUTO_MERGE' and more special refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for the review!

Changes since v1:

 * Addressed typos and wording suggestions from Elijah
 * Incoporated Eric's wording suggestion
 * Added a preliminary patch adressing Victoria's suggestion, based on the
   what Taylor sent.

This version is not a "fixups on top", it's a complete new version. I don't
see the point of merging typos to master if we can instead wait for 'next'
to be rebuilt after the upcoming release.

v1: This series adds documentation (and completion!) for AUTO_MERGE. In
doing so I noticed that some other special refs where not mentioned in
'gitrevisions' nor suggested by the completion, so I also tried to improve
that.

Since the changes are in the same parts of the same files, I thought it made
more sense to send everything in the same series to avoid conflicts, but I
can send the AUTO_MERGE patches on top of the other ones in a separate
series if that would be preferred.

Here is a breakdown of the patches. First the "other special refs" patches:

 * [PATCH 1/5] revisions.txt: document more special refs
 * [PATCH 2/5] completion: complete REVERT_HEAD and BISECT_HEAD

Then a preparatory cleanup for the AUTO_MERGE patches:

 * [PATCH 3/5] git-merge.txt: modernize word choice in "True merge" section

Finally the AUTO_MERGE patches:

 * [PATCH 4/5] Documentation: document AUTO_MERGE
 * [PATCH 5/5] completion: complete AUTO_MERGE

Thanks Elijah for this very useful feature! Dscho, I'm CC-ing you since you
opened https://github.com/gitgitgadget/git/issues/1471, I hope that's OK.

Cheers,

Philippe.

Philippe Blain (6):
  revisions.txt: use description list for special refs
  revisions.txt: document more special refs
  completion: complete REVERT_HEAD and BISECT_HEAD
  git-merge.txt: modernize word choice in "True merge" section
  Documentation: document AUTO_MERGE
  completion: complete AUTO_MERGE

 Documentation/git-diff.txt             |  9 ++++-
 Documentation/git-merge.txt            | 11 ++++--
 Documentation/revisions.txt            | 50 ++++++++++++++++++--------
 Documentation/user-manual.txt          | 27 ++++++++++++++
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 79 insertions(+), 20 deletions(-)


base-commit: a0f05f684010332ab3a706979d191b9157643f80
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1515%2Fphil-blain%2Fdoc-auto-merge-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1515/phil-blain/doc-auto-merge-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1515

Range-diff vs v1:

 -:  ----------- > 1:  1bacd52a432 revisions.txt: use description list for special refs
 1:  66c7e514157 ! 2:  3e3240a78f8 revisions.txt: document more special refs
     @@ Commit message
       ## Documentation/revisions.txt ##
      @@ Documentation/revisions.txt: characters and to avoid word splitting.
         first match in the following rules:
     - 
     + +
         . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
      -    useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
      -    and `CHERRY_PICK_HEAD`);
     @@ Documentation/revisions.txt: characters and to avoid word splitting.
       
         . otherwise, 'refs/<refname>' if it exists;
       
     -@@ Documentation/revisions.txt: you can easily change the tip of the branch back to the state before you ran
     - them.
     - `MERGE_HEAD` records the commit(s) which you are merging into your branch
     - when you run `git merge`.
     -+`REBASE_HEAD`, during a rebase, records the commit at which the
     -+operation is currently stopped, either because of conflicts or an `edit`
     -+command in an interactive rebase.
     -+`REVERT_HEAD` records the commit which you are reverting when you
     -+run `git revert`.
     - `CHERRY_PICK_HEAD` records the commit which you are cherry-picking
     - when you run `git cherry-pick`.
     -+`BISECT_HEAD` records the current commit to be tested when you
     -+run `git bisect --no-checkout`.
     +@@ Documentation/revisions.txt: characters and to avoid word splitting.
     +   `MERGE_HEAD`:::
     +     records the commit(s) which you are merging into your branch when you
     +     run `git merge`.
     ++  `REBASE_HEAD`:::
     ++    during a rebase, records the commit at which the operation is
     ++    currently stopped, either because of conflicts or an `edit` command in
     ++    an interactive rebase.
     ++  `REVERT_HEAD`:::
     ++    records the commit which you are reverting when you run `git revert`.
     +   `CHERRY_PICK_HEAD`:::
     +     records the commit which you are cherry-picking when you run `git
     +     cherry-pick`.
     ++  `BISECT_HEAD`:::
     ++    records the current commit to be tested when you run `git bisect
     ++    --no-checkout`.
     + 
       +
       Note that any of the 'refs/*' cases above may come either from
     - the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
 2:  f3a47758f9d = 3:  70487d66459 completion: complete REVERT_HEAD and BISECT_HEAD
 3:  62b68829c5a ! 4:  f1d99453f54 git-merge.txt: modernize word choice in "True merge" section
     @@ Commit message
      
          The "True merge" section of the 'git merge' documentation mentions that
          in case of conflicts, the conflicted working tree files contain "the
     -    result of the "merge" program". This probably refers to RCS' 'merge'
     +    result of the "merge" program". This probably refers to RCS's 'merge'
          program, which is mentioned further down under "How conflicts are
          presented".
      
 4:  0cdd4ab3d73 ! 5:  612073d9508 Documentation: document AUTO_MERGE
     @@ Commit message
      
          In git-merge(1), add a step to the list of things that happen "when it
          is not obvious how to reconcile the changes", under the "True merge"
     -    secion. Also mention AUTO_MERGE in the "How to resolve conflicts"
     +    section. Also mention AUTO_MERGE in the "How to resolve conflicts"
          section, when mentioning 'git diff'.
      
          In gitrevisions(7), add a mention of AUTO_MERGE along with the other
     @@ Documentation/git-diff.txt: If --merge-base is given, use the merge base of the
      +by the special ref `AUTO_MERGE`, which is written by the 'ort' merge
      +strategy upon hitting merge conflicts (see linkgit:git-merge[1]).
      +Comparing the working tree with `AUTO_MERGE` shows changes you've made
     -+so far to resolve conflicts (see the examples below).
     ++so far to resolve textual conflicts (see the examples below).
       
       For a more complete list of ways to spell <commit>, see
       "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
     @@ Documentation/git-diff.txt: $ git diff HEAD       <3>
           would be committing if you run `git commit` without `-a` option.
       <3> Changes in the working tree since your last commit; what you
           would be committing if you run `git commit -a`
     -+<4> Changes in the working tree you've made to resolve conflicts so far.
     ++<4> Changes in the working tree you've made to resolve textual
     ++    conflicts so far.
       
       Comparing with arbitrary commits::
       +
     @@ Documentation/git-merge.txt: happens:
          tree files contain the result of the merge operation; i.e. 3-way
          merge results with familiar conflict markers `<<<` `===` `>>>`.
      -5. No other changes are made.  In particular, the local
     -+5. A special ref `AUTO_MERGE` is written, pointing to a tree corresponding
     -+   to the current content of the working tree (including conflict markers).
     -+   Note that this ref is only written when the 'ort' merge strategy
     -+   is used (the default).
     ++5. A special ref `AUTO_MERGE` is written, pointing to a tree
     ++   corresponding to the current content of the working tree (including
     ++   conflict markers for textual conflicts).  Note that this ref is only
     ++   written when the 'ort' merge strategy is used (the default).
      +6. No other changes are made.  In particular, the local
          modifications you had before you started merge will stay the
          same and the index entries for them stay as they were,
     @@ Documentation/git-merge.txt: You can work through the conflict with a number of
          highlighting changes from both the `HEAD` and `MERGE_HEAD`
      -   versions.
      +   versions. `git diff AUTO_MERGE` will show what changes you've
     -+   made so far to resolve conlicts.
     ++   made so far to resolve textual conflicts.
       
        * Look at the diffs from each branch. `git log --merge -p <path>`
          will show diffs first for the `HEAD` version and then the
      
       ## Documentation/revisions.txt ##
      @@ Documentation/revisions.txt: characters and to avoid word splitting.
     - 
     + +
         . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
           useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
      -    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
     @@ Documentation/revisions.txt: characters and to avoid word splitting.
       
         . otherwise, 'refs/<refname>' if it exists;
       
     -@@ Documentation/revisions.txt: run `git revert`.
     - when you run `git cherry-pick`.
     - `BISECT_HEAD` records the current commit to be tested when you
     - run `git bisect --no-checkout`.
     -+`AUTO_MERGE` records a tree object corresponding to the state the
     -+'ort' merge strategy wrote to the working tree when a merge operation
     -+resulted in conflicts.
     +@@ Documentation/revisions.txt: characters and to avoid word splitting.
     +   `BISECT_HEAD`:::
     +     records the current commit to be tested when you run `git bisect
     +     --no-checkout`.
     ++  `AUTO_MERGE`:::
     ++    records a tree object corresponding to the state the
     ++    'ort' merge strategy wrote to the working tree when a merge operation
     ++    resulted in conflicts.
     + 
       +
       Note that any of the 'refs/*' cases above may come either from
     - the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
      
       ## Documentation/user-manual.txt ##
      @@ Documentation/user-manual.txt: $ git diff -3 file.txt		# diff against stage 3
     @@ Documentation/user-manual.txt: $ git diff -3 file.txt		# diff against stage 3
       
      +When using the 'ort' merge strategy (the default), before updating the working
      +tree with the result of the merge, Git writes a special ref named AUTO_MERGE
     -+reflecting the state of the tree it is about to write. Conflicted paths that
     -+could not be automatically merged are written to this tree with conflict
     -+markers, just as in the working tree. AUTO_MERGE can thus be used with
     -+linkgit:git-diff[1] to show the changes you've made so far to resolve
     ++reflecting the state of the tree it is about to write. Conflicted paths with
     ++textual conflicts that could not be automatically merged are written to this
     ++tree with conflict markers, just as in the working tree. AUTO_MERGE can thus be
     ++used with linkgit:git-diff[1] to show the changes you've made so far to resolve
      +conflicts. Using the same example as above, after resolving the conflict we
      +get:
      +
     @@ -1,5 +1 @@
      ++Goodbye world
      +-------------------------------------------------
      +
     -+Notice that the diff shows we deleted the conflict markers and both versions,
     -+and wrote "Goodbye world" instead.
     ++Notice that the diff shows we deleted the conflict markers and both versions of
     ++the content line, and wrote "Goodbye world" instead.
      +
       The linkgit:git-log[1] and linkgit:gitk[1] commands also provide special help
       for merges:
 5:  88cc7a80f31 = 6:  17226c56e7b completion: complete AUTO_MERGE

-- 
gitgitgadget
