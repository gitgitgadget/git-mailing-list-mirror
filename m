Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67ADC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF32078C
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMuZn9kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437800AbgE1Xty (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437793AbgE1Xtr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:49:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CAC014D07
        for <git@vger.kernel.org>; Thu, 28 May 2020 16:49:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u6so882608ybo.18
        for <git@vger.kernel.org>; Thu, 28 May 2020 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qwger4EkEA/L3+WknRNKqdcLjh+FKLiOb9Gq9+esKBM=;
        b=IMuZn9kf5ZeRKKIogR+fqQtIEhI2yILronZ8Q5x6RIRgnBf2Rjh7mCxonFQhEj6oNg
         zNdwyQUcUrMxSPd4v617C7120SkWkL7c5PQw2dhZXm9aSyImqt5IG7+ZSnrHbPBD8WNw
         HMcDjw5Hxqsm4W1fspLJ+Nw1tkM8bNHtq3GxIXcTra0V8Q8keDpeEUECBUNQbnTfZHb5
         phB5ZTFSPONhidAtEq8R9djYROdehc65GJf9NNSAkyXedfAW8Vkm4TNErVO0A2AAG97f
         0btzG5TP0LYBi6TUPNwu3EfimNV2/NaiCLdCVA0GtPQsB4bRV1f9z9h/roJWKceTsT9a
         OqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qwger4EkEA/L3+WknRNKqdcLjh+FKLiOb9Gq9+esKBM=;
        b=QZLTQ1u1drMZS2cw0pweuCgac68ZQmHoTXFXWF2dGzV+YzM3dxi3x9Ko0pWrdDrLLA
         Rrd8hQAVMrEQVHSu+PbaPe+dooHr8ia56nk8F4Y3SCsT1Ks1YyXnzb0Oa863Myn3dbxe
         +VwXGODOFXfPD98NRzT8T3wy68gLaC/1EnqFzWAgjoEhgYHucIkMxoDq/24SebVb07sK
         09qkL5bDhRPhGBWBzPEQKcDlIuRbeXdOjGXNdqV7WIUxaSBNkUK63L4JqisvdBj1at+4
         l+sGMroadOKjHNUFA/15Zrjppa5TOSclWjPEzoNaJ3QbHgWBvvf3r3hfyNLI7joGXxbt
         ir4w==
X-Gm-Message-State: AOAM532r3+7oyNsR52cdVJJn7GzdUdPwpskEN1LFZCjHF6prP5MAVo4R
        zy4b1Sj7PiUM6aKRUtjR76cLkpL/hvh2oVexsY+hSfzs7oWeV+ubiHcQGXmtHlHYwa8iWmzSB0j
        otrkr+trH/jNL54ulRXajXzJCqljAg1c7qNSpZv37gsFlqpFNA8E2cYF8m3Mdc9exixepAE/hvw
        ==
X-Google-Smtp-Source: ABdhPJxnwGHG//jFe4ejWHLHgHaUMHh7PkppvxCcLfY4Uu/WXPFoaaJ8dLa30NrIIEG0WsNyL91t8pK13rhNvH9j9K8=
X-Received: by 2002:a25:904:: with SMTP id 4mr8543143ybj.3.1590709785262; Thu,
 28 May 2020 16:49:45 -0700 (PDT)
Date:   Thu, 28 May 2020 16:49:39 -0700
Message-Id: <20200528234939.145396-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] docs: mention MyFirstContribution in more places
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the MyFirstContribution guide exists and has received some use and
positive reviews, it is still not as discoverable as it could be. Add a
reference to it from the GitHub pull request template, where many
brand-new contributors may look. Also add a reference to it in
SubmittingPatches, which is the central source of guidance for patch
contribution.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
Philippe mentioned out-of-band that they wished for some more pointers
to MyFirstContribution in the Git documentation
(https://github.com/git/git-scm.com/issues/1464#issuecomment-631757274).

Here's a first pass. The change for the GH PR template was easy, since
there are a couple other "here's how" resources listed the same way. But
the change for SubmittingPatches I wasn't so sure about. Since that
document dives right into technical details and doesn't feature some
"other resources" section (at least not that I found), I made a quick
reference at the top, which I was hoping would be unintrusive but also
easy to find for newbies overwhelmed by the large list of rules. It's
not very scalable if we want to add more info, though, so I'm open to
other suggestions.

 - Emily

 .github/CONTRIBUTING.md         | 3 +++
 Documentation/SubmittingPatches | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
index e7b4e2f3c2..c8755e38de 100644
--- a/.github/CONTRIBUTING.md
+++ b/.github/CONTRIBUTING.md
@@ -16,4 +16,7 @@ If you prefer video, then [this talk](https://www.youtube.com/watch?v=Q7i_qQW__q
 might be useful to you as the presenter walks you through the contribution
 process by example.
 
+Or, you can follow the ["My First Contribution"](https://git-scm.com/docs/MyFirstContribution)
+tutorial for another example of the contribution process.
+
 Your friendly Git community!
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4515cab519..d8c6b4d71b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -3,8 +3,9 @@ Submitting Patches
 
 == Guidelines
 
-Here are some guidelines for people who want to contribute their code
-to this software.
+Here are some guidelines for people who want to contribute their code to this
+software. There is also an link:MyFirstContribution.html[interactive tutorial]
+available which covers many of these same guidelines.
 
 [[base-branch]]
 === Decide what to base your work on.
-- 
2.27.0.rc0.183.gde8f92d652-goog

