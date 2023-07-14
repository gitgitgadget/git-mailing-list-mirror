Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34807EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjGNGCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjGNGBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58802D45
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so14837565e9.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314502; x=1691906502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od1fD7yLr8jKEtZ3kaTZ6Ig2iw/IIdNioHnxhqZ3/vA=;
        b=KC4bz2l3i62NKotqWiCeQ5IhU9rOHv2X/LcSMwyQjPp8jCQ6ivjZNCt6F5bxfMIVza
         H/eDA8fZ8gbCx92H6XiZBb5mfX2PNAsJIspPhpj4xDGgfZzsn0sfvHdf0959Meqf17V8
         e7SlAZ0xEJhZdM4Tj7A+9vJiKTNkfSAACJok74immvjeS+vxLkv3GszDFNeS7yCQy0UT
         y+FgZcUWtTZA5sNXmtKGT4lRHxaoKEkbVKsDDLccxM73kRjYgKud09yt2WzSOZ8EirnD
         IXkNV0Ex+HS4qDce4xDKXs/OSHOYayylbaJoDdsxBLnt91Qc9euvOcuUk737SFLNj9//
         fMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314502; x=1691906502;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Od1fD7yLr8jKEtZ3kaTZ6Ig2iw/IIdNioHnxhqZ3/vA=;
        b=OcWAm4pPqyEqfvAYWt9qbd7oAiRISu2UBZBoibIXds/ZYm03MoKcnm2zKC3L3h/6n7
         XOMharfw8mVB1VR9tGF7oDpMVMiDYfYbcwQccaN//VFzOPy90NLZjmvb4+ot1Ljm4t+g
         Lf2NgZxx4ZSKpWx8F59wN/QYNP/RA9Z//jzz4MjHLp+DKeBtVRSPeM/KeJ8m0mTeaQxk
         A4ZahRsUVJzL/jMKv49ZKtXK/eTo703t5UdVZ3FGYjfxeu1R+fxUCUA7zAaIIHvBTNVB
         TiEEefhOdLLa07WcePpU0GYv6gSkQPdTnDOXmnMzI0wWKu8GuVDgVdgR1ka7RVZ4AkHi
         iS4Q==
X-Gm-Message-State: ABy/qLZa0AKHdPwXs1H8Ddc9M7aim6MYAIUymVwOxLDzCUMDTZD5b/Bm
        RSxRTxADzQy5PozxeAclTPRKx/1yyvI=
X-Google-Smtp-Source: APBJJlExtY15RnlxqVZ0zbBdTP7ngsCD9//bOkKzN0f1WkE7hxtAj/0C6+ow3ZhBn3ZI0t7UjZP37Q==
X-Received: by 2002:a05:600c:22d7:b0:3fb:e2af:49f6 with SMTP id 23-20020a05600c22d700b003fbe2af49f6mr2920056wmg.39.1689314501890;
        Thu, 13 Jul 2023 23:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c024500b003fba6709c68sm590617wmj.47.2023.07.13.23.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:01:41 -0700 (PDT)
Message-ID: <5ec91d02b7ae767cc9b2395e1c0fa10e1424c0c5.1689314493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 06:01:33 +0000
Subject: [PATCH v2 5/5] SubmittingPatches: simplify guidance for choosing a
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
"maint" or "master". But it also gives an explanation of why that is
preferred and what is meant by preferring "older" branches (which might
be confusing to some because "old" here is meant in relative terms
between these named branches, not in terms of the age of the branches
themselves). We also add an example to illustrate why it would be a bad
idea to use "next" as a starting point, which may not be so obvious to
new contributors.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 96 +++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 28 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 40467372c0d..f1774c91e9c 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -10,34 +10,74 @@ available which covers many of these same guidelines.
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
+  `master` but were not available in the released version).
+
+* Otherwise (such as if you are adding new features) use `master`.
+
+This also means that `next` or `seen` are inappropriate starting points
+for your work, if you want your work to have a realistic chance of
+graduating to `master`.  They are simply not designed to provide a
+stable base for new work, because they are (by design) frequently
+re-integrated with incoming patches on the mailing list and force-pushed
+to replace previous versions of these branches.
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
