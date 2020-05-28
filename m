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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143CC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C5020776
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="komfj2O7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391581AbgE1XQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391508AbgE1XQT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:16:19 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DFC08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 16:16:17 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p126so386818qke.8
        for <git@vger.kernel.org>; Thu, 28 May 2020 16:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8FFSdr6OLk535LNAAgAE+trhmTh0PTHx+rpyqENFA9Q=;
        b=komfj2O7dj7OPIXTV6QHs46TS0qbnmWEKx55DoUQoJdR7rJmAWjrMQJFyFRwJH2mJC
         PT75FCDByfYSGyErjNJyRV/HIAssxjLq/NHMFixre0oZYQs+ywD+ktash+4S8G87vHB+
         P1tROeLiQTl3MqzE7PeGwDmm6fLsUJqZTuE71nllaOiaDrs+gyDTkUIt9XRBKIPw7rCM
         3r2APbaPs0MEPTFmNhFUVMFEVx5Vtz9nvFFIT2MFvD+4P+69/Bxxl+nL43N3bpcauV2j
         lNZP2+kTP3ewRbah+8rkiQi61RF9MuV7Tj9iZdRoD861xS0w5gr8BT5IO6p813KLstMj
         xCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8FFSdr6OLk535LNAAgAE+trhmTh0PTHx+rpyqENFA9Q=;
        b=HO3gDLyDar1KCEmWYaOQ0hmkBnm5l2lxokASbBKKq07/TCLyouSrJq0hUNcsvJZGZq
         19xOmEcnkqdEEu7Y+PrdcTSlnn01S6kw73DSYOTMrmrKupeKsF62Ad/QFMJEsLmW/A5H
         xSleACTMlMYijD/TZJR7oFqfqAENK5y9JJOBSlt46EM1k6cv4MaXq4iqvqclOADmqelB
         r3KRxG1OTT7Q3dm3BOgnbGNZ4JBoY37zlCVizLpWcoE+89Xq48SKe2QZdZK1UKQSKrhv
         mK9kVpnCzAZT3S73y0EQMHM6OW7re47RwhriVUSJpovdKu7SG0YN1ygjFBSIeT8HM/20
         A3Rw==
X-Gm-Message-State: AOAM531D+oG4+1v6EyB8wf8FSKldRpR/7BttIVIWwa/3Lc/GTljh5pVa
        WkRF9c3+hOa/qSfbNAXv+tpK7tlfb1fhcFMLK7r8yUN64HEJG0J0Kmq3gQFEykTqFBov38DRJw4
        AhkHiR1Bly8meaSyGNi7Y0WY5DGx0r4pukZKtLQ49FVhbbSTXsgFd5YKn5tok17KnMbKmwlyyig
        ==
X-Google-Smtp-Source: ABdhPJwMCp42D6f6YMXRKKdESfvDXyPsN3+LD+EFN/iSWTwCV7YxCDaR+UfQkX6Vk1UOPt15FTbzM/odwSz+mG09Z9w=
X-Received: by 2002:ad4:57a2:: with SMTP id g2mr5636576qvx.137.1590707776811;
 Thu, 28 May 2020 16:16:16 -0700 (PDT)
Date:   Thu, 28 May 2020 16:16:08 -0700
Message-Id: <20200528231608.59507-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting with 2.27.0, 'git bugreport' can gather diagnostic info and
drop the user into an editor with a template for a useful bugreport.
Advertise this feature to users who want to report a bug in Git.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Hi all,

Since this patch deals with some prominent information about how to
contact the community, I figured it was worth passing through the list
for feedback rather than just sending a PR to the website repo.
Discussion prior to this patch here:
https://github.com/git/git-scm.com/issues/1464

In the index.html.erb diff I'm interested in wordsmithing feedback; this
is the page which appears at https://git-scm.com/community. The diff in
_debugging.html.erb is modifying the list of references in
https://git-scm.com/docs - I'm interested in feedback on whether this is
the best header to include git-bugreport under.

Thanks and sorry for the off-repo noise.

 - Emily

 app/views/community/index.html.erb       | 11 +++++++----
 app/views/shared/ref/_debugging.html.erb |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/app/views/community/index.html.erb b/app/views/community/index.html.erb
index 6927e19..bfcb089 100644
--- a/app/views/community/index.html.erb
+++ b/app/views/community/index.html.erb
@@ -36,10 +36,13 @@
 
   <p>
     Bugs in git can be reported directly to the mailing list (see above for
-    details). Note that you do not need to subscribe to the list to send
-    to it. You can help us out by attempting to reproduce the bug in the latest
-    released version of git, or if you're willing to build git from source, the
-    <a href="https://github.com/git/git/tree/next"><code>next</code> branch</a>.
+    details). Note that you do not need to subscribe to the list to send to it.
+    If you are using git 2.27.0 or later, you can run <code>git bugreport</code>,
+    which generates a template to guide you through writing a useful bug report
+    and gathers some diagnostic information about your environment. You can
+    help us out by attempting to reproduce the bug in the latest released
+    version of git, or if you're willing to build git from source, the
+    <a href="https:/break/github.com/git/git/tree/next"><code>next</code> branch</a>.
     Sometimes an attempted fix may be pending in this branch, in which case
     your feedback as to whether the fix worked for you will be appreciated.
   </p>
diff --git a/app/views/shared/ref/_debugging.html.erb b/app/views/shared/ref/_debugging.html.erb
index 286a690..4732b75 100644
--- a/app/views/shared/ref/_debugging.html.erb
+++ b/app/views/shared/ref/_debugging.html.erb
@@ -2,5 +2,6 @@
 <ul class='unstyled'>
   <li><%= man('git-bisect') %></li>
   <li><%= man('git-blame') %></li>
+  <li><%= man('git-bugreport') %></li>
   <li><%= man('git-grep') %></li>
 </ul>
-- 
2.27.0.rc0.183.gde8f92d652-goog

