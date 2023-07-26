Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1339C001DE
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 03:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGZDFZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGZDFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 23:05:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413991BFA
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:08 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso63306735e9.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340706; x=1690945506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hySmWU7x/kfBtFCVeRCwBytWjCDEYpGXg7PK34zGjxg=;
        b=RxnljFwa1rSdHV5EZr/Ur+JmHqsa0GjA0Fy9FFIbo/5Trqbc3HKQtbg+k9leGLQeSH
         GBrks+7cI2GpONJLzRCmWzmegdGB+0OODoxvlJcqsR/zqZJOZ6w5UCt2oNom7JdeE3vJ
         5/d88w/IaNeuE6EIXlp/4UUu8vBEGLwb+QJHKeeN7tuzcL7IB3zEl8GNKekDe7IVmVzy
         sAK1DJacKHDQ3t0ZHkgSLRYgQXjDent+Wlccv3lOdG8c2I+oG+3XstDDDd+YzBFb6aua
         9tequCCOgdpueZ2PgRxZFVfIgKc594HxIRI6TljKtMmcdvsE+u54hj3uRb+Uv5ONX3+h
         j1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340706; x=1690945506;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hySmWU7x/kfBtFCVeRCwBytWjCDEYpGXg7PK34zGjxg=;
        b=Ziia0g8ANfXsMF5qIm+kP7DT1dVDIvqBAZkSmZ4KepTut+LIi+UIgGUGRYfjj/zjtw
         hCLz3ZgtLkLQMxRzvD0zCqKg0+RjcSPCYJ2Y9GkKJ3SkeM2whvcYskKRHk658qukLyH/
         qmEZJ7daPruDYserf0Nz8ATHU/LDuBwXPhvSKskQNmxMCtpm64SDKKJp8XYwgRjYqQ0K
         o69KCuz+kPPrqj108kEtMSnkqX6IvnW2TN5dWFk2jyV9ekCd/mbrrQZOjcl5zjAakrmn
         ySDSAJg7x4o87jlImg0REc2cU+UhNFyfE5a11gCqpLm6Aq4hmkVKiNbbaMA0/wPaookc
         C6sQ==
X-Gm-Message-State: ABy/qLb4RXWjQbbF7OSiKI8swVC2ZDImELz9sQTcAOBQuIistKY+yyTU
        ICemD2SgJWg9Qvp9+/giG8w4UvArmNE=
X-Google-Smtp-Source: APBJJlEvTni1PpkQTwcCnJgYgTz31CsRH1pjr3XyN6zAijnPrT7CfenUH/oteXidYZZ+xsDnz/8bzw==
X-Received: by 2002:a7b:ca51:0:b0:3fb:b530:a4e4 with SMTP id m17-20020a7bca51000000b003fbb530a4e4mr492029wml.8.1690340706027;
        Tue, 25 Jul 2023 20:05:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6285000000b0031455482d1fsm18308425wru.47.2023.07.25.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:05:05 -0700 (PDT)
Message-ID: <1273f50c8a884e6afc5be6cb10fe178ed8efbede.1690340701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 03:05:01 +0000
Subject: [PATCH v3 5/5] SubmittingPatches: simplify guidance for choosing a
 starting point
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Background: The guidance to "base your work on the oldest branch that
your change is relevant to" was added in d0c26f0f56 (SubmittingPatches:
Add new section about what to base work on, 2010-04-19). That commit
also added the bullet points which describe the scenarios where one
would use one of the following named branches: "maint", "master",
"next", and "seen" ("pu" in the original as that was the name of this
branch before it was renamed, per 828197de8f (docs: adjust for the
recent rename of `pu` to `seen`, 2020-06-25)). The guidance was probably
taken from existing similar language introduced in the "Merge upwards"
section of gitworkflows in f948dd8992 (Documentation: add manpage about
workflows, 2008-10-19).

Summary: This change simplifies the guidance by pointing users to just
"maint" or "master" for most cases. But it also gives an explanation of
why that is preferred and what is meant by preferring "older"
branches (which might be confusing to some because "old" here is meant
in relative terms between these named branches, not in terms of the age
of the branches themselves). We also explain in detail why it would be a
bad idea to use "next" or "seen" as starting points, which may not be so
obvious to new contributors.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 105 +++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 28 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 40467372c0d..559c02c90c5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -10,34 +10,83 @@ available which covers many of these same guidelines.
 [[choose-starting-point]]
 === Choose a starting point.
 
-In general, always base your work on the oldest branch that your
-change is relevant to.
-
-* A bugfix should be based on `maint` in general. If the bug is not
-  present in `maint`, base it on `master`. For a bug that's not yet
-  in `master`, find the topic that introduces the regression, and
-  base your work on the tip of the topic.
-
-* A new feature should be based on `master` in general. If the new
-  feature depends on other topics that are in `next`, but not in
-  `master`, fork a branch from the tip of `master`, merge these topics
-  to the branch, and work on that branch.  You can remind yourself of
-  how you prepared the base with `git log --first-parent master..`.
-
-* Corrections and enhancements to a topic not yet in `master` should
-  be based on the tip of that topic. If the topic has not been merged
-  to `next`, it's alright to add a note to squash minor corrections
-  into the series.
-
-* In the exceptional case that a new feature depends on several topics
-  not in `master`, start working on `next` or `seen` privately and
-  send out patches only for discussion. Once your new feature starts
-  to stabilize, you would have to rebase it (see the "depends on other
-  topics" above).
-
-To find the tip of a topic branch, run `git log --first-parent
-master..seen` and look for the merge commit. The second parent of this
-commit is the tip of the topic branch.
+As a preliminary step, you must first choose a starting point for your
+work. Typically this means choosing a branch, although technically
+speaking it is actually a particular commit (typically the HEAD, or tip,
+of the branch).
+
+There are several important branches to be aware of. Namely, there are
+four integration branches as discussed in linkgit:gitworkflows[7]:
+
+* maint
+* master
+* next
+* seen
+
+The branches lower on the list are typically descendants of the ones
+that come before it. For example, `maint` is an "older" branch than
+`master` because `master` usually has patches (commits) on top of
+`maint`.
+
+There are also "topic" branches, which contain work from other
+contributors.  Topic branches are created by the Git maintainer (in
+their fork) to organize the current set of incoming contributions on
+the mailing list, and are itemized in the regular "What's cooking in
+git.git" announcements.  To find the tip of a topic branch, run `git log
+--first-parent master..seen` and look for the merge commit. The second
+parent of this commit is the tip of the topic branch.
+
+There is one guiding principle for choosing the right starting point: in
+general, always base your work on the oldest integration branch that
+your change is relevant to (see "Merge upwards" in
+linkgit:gitworkflows[7]).  What this principle means is that for the
+vast majority of cases, the starting point for new work should be the
+latest HEAD commit of `maint` or `master` based on the following cases:
+
+* If you are fixing bugs in the released version, use `maint` as the
+  starting point (which may mean you have to fix things without using
+  new API features on the cutting edge that recently appeared in
+  `master` but were not available in the released version). If the bug
+  exists in an older version (e.g., commit `X` introduced the bug, and
+  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then
+  use the tip of the maintenance branch for the 2.30.x versions in the
+  `maint-2.30` branch in https://github.com/gitster/git[the maintainer's
+  repo].
+
+* Otherwise (such as if you are adding new features) use `master`.
+
+This also means that `next` or `seen` are inappropriate starting points
+for your work, if you want your work to have a realistic chance of
+graduating to `master`.  They are simply not designed to be used as a
+base for new work; they are only there to make sure that topics in
+flight work well together. This is why both `next` and `seen` are
+frequently re-integrated with incoming patches on the mailing list and
+force-pushed to replace previous versions of themselves. A topic that is
+literally built on top of `next` cannot be merged to 'master' without
+dragging in all the other topics in `next`, some of which may not be
+ready.
+
+For example, if you are making tree-wide changes, while somebody else is
+also making their own tree-wide changes, your work may have severe
+overlap with the other person's work.  This situation may tempt you to
+use `next` as your starting point (because it would have the other
+person's work included in it), but doing so would mean you'll not only
+depend on the other person's work, but all the other random things from
+other contributors that are already integrated into `next`.  And as soon
+as `next` is updated with a new version, all of your work will need to
+be rebased anyway in order for them to be cleanly applied by the
+maintainer.
+
+Under truly exceptional circumstances where you absolutely must depend
+on a select few topic branches that are already in `next` but not in
+`master`, you may want to create your own custom base-branch by forking
+`master` and merging the required topic branches to it. You could then
+work on top of this base-branch.  But keep in mind that this base-branch
+would only be known privately to you.  So when you are ready to send
+your patches to the list, be sure to communicate how you created it in
+your cover letter.  This critical piece of information would allow
+others to recreate your base-branch on their end in order for them to
+try out your work.
 
 Finally, note that some parts of the system have dedicated maintainers
 with their own separate source code repositories (see the section
-- 
gitgitgadget
