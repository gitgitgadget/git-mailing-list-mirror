Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72053C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDNR67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjDNR6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 13:58:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6383CB
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q6so6892933wrc.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681495123; x=1684087123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzM/60mSsNR0KJGFhVd8L6Cxs85i7APO+rqheyEtKZg=;
        b=XFTz5SkMt1o7//p+xxYXwxktA2TjYMr3X8mZv/SNaicz7vZpOochoeLzcRruTzOto8
         i2HBsZWe6ASq5tu4JaCeawYWCoB90BiS2B7A0IXhQqFtP34wtC2jcsusi5hL4PMRY8uK
         QL0IsBUhQ4OtOnCYJZ/fC+lHdlshuWgtRRdpZGhK1Yfml40Yd1YWK3x/WA6RHfjlFj/N
         xaTE4G7oDDW/KMO5UOipXqGzanAVzu3V3hCpRC+MMkDxwJqExSCxmOdUzY5itoYfuzUN
         /Xl4lrytlwKyrDBFhU5Uqmov9eVeyRPRJ1Ac2ce8p0oSdu9Cr4497t9a54doxFBZYXep
         +cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681495123; x=1684087123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzM/60mSsNR0KJGFhVd8L6Cxs85i7APO+rqheyEtKZg=;
        b=Rbj1JkQ0MY4iNPTHDqiRegwRTWfe4G/M1MZH0GThG9Cd53+buztWjPodKaRJLvQpHk
         izAEA3chG9Zn3SWVnowiqzFCYENBWKVlhhG3b7XSsf7iYAa4vtXKKHhC2wuC2pL4AEAu
         06xUVIm4nTaL8d0+mlRJDCwJkeqlvimwYhh6SD9ZJtpFYL8ZNIhNPserFCAN9yPf27Ik
         RE3FfgIfrtKigMFAhYTRvhO2wiD5LT3uAj6fE4l86rWmyZGO505/9AlDerFpU3DxEpq9
         nRlVxUtYine9nfDRE0P4/On/IF6wgxwyOEfW9HQUX7By17PiGxuUgeH9T5f9nhvvYode
         YWAw==
X-Gm-Message-State: AAQBX9dGHLIkjcEjXw45OStLrXtx4J931KhMU7UGumJL4gu5PcnfRx5f
        dxNF8vNt8n+EchGIE71lY3+CBoJKWSY=
X-Google-Smtp-Source: AKy350bfarretQ65YLVO5valisWdUAJnlh0xTKS8YVIGItItFyiMyNcnv5rc/SPyHup7cMZUw87V5g==
X-Received: by 2002:a5d:6291:0:b0:2f4:215a:98c5 with SMTP id k17-20020a5d6291000000b002f4215a98c5mr4927555wru.70.1681495122737;
        Fri, 14 Apr 2023 10:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w13-20020adfec4d000000b002efb6e0c495sm4011251wrn.91.2023.04.14.10.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:58:42 -0700 (PDT)
Message-Id: <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 17:58:37 +0000
Subject: [PATCH 4/5] Documentation: document AUTO_MERGE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 5291828df8 (merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a
conflict, 2021-03-20), when using the 'ort' merge strategy, the special
ref AUTO_MERGE is written when a merge operation results in conflicts.
This ref points to a tree recording the conflicted state of the working
tree and is very useful during conflict resolution. However, this ref is
not documented.

Add some documentation for AUTO_MERGE in git-diff(1), git-merge(1),
gitrevisions(7) and in the user manual.

In git-diff(1), mention it at the end of the description section, when
we mention that the command also accepts trees instead of commits, and
also add an invocation to the "Various ways to check your working tree"
example.

In git-merge(1), add a step to the list of things that happen "when it
is not obvious how to reconcile the changes", under the "True merge"
secion. Also mention AUTO_MERGE in the "How to resolve conflicts"
section, when mentioning 'git diff'.

In gitrevisions(7), add a mention of AUTO_MERGE along with the other
special refs.

In the user manual, add a paragraph describing AUTO_MERGE to the
"Getting conflict-resolution help during a merge" section, and include
an example of a 'git diff AUTO_MERGE' invocation for the example
conflict used in that section. Note that for uniformity we do not use
backticks around AUTO_MERGE here since the rest of the document does not
typeset special refs differently.

Closes: https://github.com/gitgitgadget/git/issues/1471
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-diff.txt    |  8 +++++++-
 Documentation/git-merge.txt   |  9 +++++++--
 Documentation/revisions.txt   |  6 +++++-
 Documentation/user-manual.txt | 27 +++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 52b679256c4..a85cc756ebc 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -102,7 +102,11 @@ If --merge-base is given, use the merge base of the two commits for the
 Just in case you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
 in the `--merge-base` case and in the last two forms that use `..`
-notations, can be any <tree>.
+notations, can be any <tree>. A tree of interest is the one pointed to
+by the special ref `AUTO_MERGE`, which is written by the 'ort' merge
+strategy upon hitting merge conflicts (see linkgit:git-merge[1]).
+Comparing the working tree with `AUTO_MERGE` shows changes you've made
+so far to resolve conflicts (see the examples below).
 
 For a more complete list of ways to spell <commit>, see
 "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
@@ -152,6 +156,7 @@ Various ways to check your working tree::
 $ git diff            <1>
 $ git diff --cached   <2>
 $ git diff HEAD       <3>
+$ git diff AUTO_MERGE <4>
 ------------
 +
 <1> Changes in the working tree not yet staged for the next commit.
@@ -159,6 +164,7 @@ $ git diff HEAD       <3>
     would be committing if you run `git commit` without `-a` option.
 <3> Changes in the working tree since your last commit; what you
     would be committing if you run `git commit -a`
+<4> Changes in the working tree you've made to resolve conflicts so far.
 
 Comparing with arbitrary commits::
 +
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 23aefe28851..3f61389c1c2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -196,7 +196,11 @@ happens:
    can inspect the stages with `git ls-files -u`).  The working
    tree files contain the result of the merge operation; i.e. 3-way
    merge results with familiar conflict markers `<<<` `===` `>>>`.
-5. No other changes are made.  In particular, the local
+5. A special ref `AUTO_MERGE` is written, pointing to a tree corresponding
+   to the current content of the working tree (including conflict markers).
+   Note that this ref is only written when the 'ort' merge strategy
+   is used (the default).
+6. No other changes are made.  In particular, the local
    modifications you had before you started merge will stay the
    same and the index entries for them stay as they were,
    i.e. matching `HEAD`.
@@ -336,7 +340,8 @@ You can work through the conflict with a number of tools:
 
  * Look at the diffs.  `git diff` will show a three-way diff,
    highlighting changes from both the `HEAD` and `MERGE_HEAD`
-   versions.
+   versions. `git diff AUTO_MERGE` will show what changes you've
+   made so far to resolve conlicts.
 
  * Look at the diffs from each branch. `git log --merge -p <path>`
    will show diffs first for the `HEAD` version and then the
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 98b8f89bc8d..b42a2bb30a5 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -33,7 +33,8 @@ characters and to avoid word splitting.
 
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
-    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
+    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD`, `BISECT_HEAD`
+    and `AUTO_MERGE`);
 
   . otherwise, 'refs/<refname>' if it exists;
 
@@ -64,6 +65,9 @@ run `git revert`.
 when you run `git cherry-pick`.
 `BISECT_HEAD` records the current commit to be tested when you
 run `git bisect --no-checkout`.
+`AUTO_MERGE` records a tree object corresponding to the state the
+'ort' merge strategy wrote to the working tree when a merge operation
+resulted in conflicts.
 +
 Note that any of the 'refs/*' cases above may come either from
 the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index dc9c6a663a9..99e5f652e92 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1343,6 +1343,33 @@ $ git diff -3 file.txt		# diff against stage 3
 $ git diff --theirs file.txt	# same as the above.
 -------------------------------------------------
 
+When using the 'ort' merge strategy (the default), before updating the working
+tree with the result of the merge, Git writes a special ref named AUTO_MERGE
+reflecting the state of the tree it is about to write. Conflicted paths that
+could not be automatically merged are written to this tree with conflict
+markers, just as in the working tree. AUTO_MERGE can thus be used with
+linkgit:git-diff[1] to show the changes you've made so far to resolve
+conflicts. Using the same example as above, after resolving the conflict we
+get:
+
+-------------------------------------------------
+$ git diff AUTO_MERGE
+diff --git a/file.txt b/file.txt
+index cd10406..8bf5ae7 100644
+--- a/file.txt
++++ b/file.txt
+@@ -1,5 +1 @@
+-<<<<<<< HEAD:file.txt
+-Hello world
+-=======
+-Goodbye
+->>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
++Goodbye world
+-------------------------------------------------
+
+Notice that the diff shows we deleted the conflict markers and both versions,
+and wrote "Goodbye world" instead.
+
 The linkgit:git-log[1] and linkgit:gitk[1] commands also provide special help
 for merges:
 
-- 
gitgitgadget

