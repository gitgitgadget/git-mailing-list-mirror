Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E804C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 13:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjEEN7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 09:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjEEN67 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 09:58:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F6516340
        for <git@vger.kernel.org>; Fri,  5 May 2023 06:58:56 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3077d134028so514331f8f.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683295134; x=1685887134;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K3H8LWIcQM3qWKGfV4n7FAsSV5+JegJMntC1tAlUmYU=;
        b=WP7EQcezc0vRwcsksQUgn2hBHv19MsCuXZ/i80BqPWDzzFOOQ6aGWeFjlmXCYJpeZE
         SjgFkUb+0lkSjBYyPFsLl0A2EkMi0yDhKmD60WgTZVE9610vEXe6RqwOHjO3oYG33cVt
         kDaEET8SmOscKiKu9ydwYucNCfeZysDUj5MCumat7dgtaYHWrQjw9CzXYl6AXP75qDNI
         faoR94ZnT9vu5aRbzmbPH0aQyEvO17P/DeNM4HjUF4EHQS77eI05qIrO9Nzcxlc4mZu/
         XPBmSeGOri94S30aryzDwiFNrC59NaczKXuxv7mszkl6Pz/fKEwQ8JiXJuTK0aCk8mR2
         JI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295134; x=1685887134;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3H8LWIcQM3qWKGfV4n7FAsSV5+JegJMntC1tAlUmYU=;
        b=almVTYktDjcPt2+yY67yB0RTVpc2GIA5KjNEz+/axEMffsBE3kKKHgelOM990AqsGA
         PfN2SmnSTaiRezpXtSjhI3qr8abSXmFxKgRcBQD3Ye5QzeS/WZU5Lr9FfiGU2+E9k5YM
         4itSQreRBPSL3UDj2C/KVf84rhy9fvX0Nd99qUlQTmURJtA1jOsjCfbG/eKSMnjzCcYY
         Jww4HMmD/0XMNos5vT+EOGHyL6GS4QBoYKEogvv3W0gSXYNrom39tMSQeWmGvdABt35r
         GRJRQJe9sofgODRQRat1Qwt82SYxVgCBOEPmI3j44qi6Zh/o2+abpdZMnJrwRuGDs//g
         bsAw==
X-Gm-Message-State: AC+VfDxoXjPkrd3oKKR7lVWzU++31rs0tVaNiAKU+YDisyjMoHYPYFcv
        a07GNWEAm4UNecmhPH8ItZLqzW/ZW+k=
X-Google-Smtp-Source: ACHHUZ777UwaCiHiaTaJmK3MUcWZCHyol+BPOA+M6iS63RmE8z1YTrB/a0dFDNInZJl09XZjJGHI8A==
X-Received: by 2002:adf:f410:0:b0:2f4:de63:a0b5 with SMTP id g16-20020adff410000000b002f4de63a0b5mr1478200wro.69.1683295134324;
        Fri, 05 May 2023 06:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020adfe606000000b002e5f6f8fc4fsm2491666wrm.100.2023.05.05.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 06:58:53 -0700 (PDT)
Message-Id: <pull.1505.git.git.1683295133304.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 May 2023 13:58:53 +0000
Subject: [PATCH] doc: merge: improve conflict presentation docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>, Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

Improvements:

1. Remove the sexist example ("Barbie... wants to go shopping")
2. Show real merge marker contents, rather than e.g. "yours:sample.txt".
3. Swap yours/theirs terms for source/target.
4. General wordsmithing.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    doc: merge: improve conflict presentation docs
    
    Improvements:
    
     1. Remove the sexist example ("Barbie... wants to go shopping")
     2. Show real merge marker contents, rather than e.g.
        "yours:sample.txt".
     3. Swap yours/theirs terms for source/target.
     4. General wordsmithing.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1505%2Fadamchainz%2Faj%2Fmerge-conflict-docs-improvements-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1505/adamchainz/aj/merge-conflict-docs-improvements-v1
Pull-Request: https://github.com/git/git/pull/1505

 Documentation/git-merge.txt | 75 ++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0aeff572a59..b4523362e48 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -233,11 +233,11 @@ HOW CONFLICTS ARE PRESENTED
 
 During a merge, the working tree files are updated to reflect the result
 of the merge.  Among the changes made to the common ancestor's version,
-non-overlapping ones (that is, you changed an area of the file while the
-other side left that area intact, or vice versa) are incorporated in the
-final result verbatim.  When both sides made changes to the same area,
+non-overlapping ones, where only one side changed an area, are incorporated
+in the final result as-is.  When both sides made changes to the same area,
 however, Git cannot randomly pick one side over the other, and asks you to
-resolve it by leaving what both sides did to that area.
+resolve it.  Git adds changes from both sides, and optionally the
+original content from the common ancestor, surrounded by merge markers.
 
 By default, Git uses the same style as the one used by the "merge" program
 from the RCS suite to present such a conflicted hunk, like this:
@@ -245,71 +245,70 @@ from the RCS suite to present such a conflicted hunk, like this:
 ------------
 Here are lines that are either unchanged from the common
 ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
+or cleanly resolved because both sides changed identically.
+<<<<<<< HEAD
+Git makes conflict resolution straightforward.
 =======
 Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
+>>>>>>> main
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
 The area where a pair of conflicting changes happened is marked with markers
 `<<<<<<<`, `=======`, and `>>>>>>>`.  The part before the `=======`
-is typically your side, and the part afterwards is typically their side.
+is typically from the target (where you’re merging into), and the part
+afterwards is typically from the source (where you’re merging from).
+
+The default format does not show what the original version contained in the
+conflicting area.  You cannot tell how many lines have been deleted and
+replaced on either side. The only thing you can tell is that the target side
+says "straightforward", while the source side says "easy".
 
-The default format does not show what the original said in the conflicting
-area.  You cannot tell how many lines are deleted and replaced with
-Barbie's remark on your side.  The only thing you can tell is that your
-side wants to say it is hard and you'd prefer to go shopping, while the
-other side wants to claim it is easy.
+You can use an alternative conflict marker style by setting the
+`merge.conflictStyle` configuration variable to either "diff3" or "zdiff3".
+Both of these styles show the original version of the conflicted area, which
+may help you find a better resolution.
 
-An alternative style can be used by setting the "merge.conflictStyle"
-configuration variable to either "diff3" or "zdiff3".  In "diff3"
-style, the above conflict may look like this:
+In the "diff3" style, the above conflict looks like this:
 
 ------------
 Here are lines that are either unchanged from the common
 ancestor, or cleanly resolved because only one side changed,
-<<<<<<< yours:sample.txt
-or cleanly resolved because both sides changed the same way.
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
+<<<<<<< HEAD
 or cleanly resolved because both sides changed identically.
+Git makes conflict resolution straightforward.
+||||||| 81821ce
+or cleanly resolved because both sides changed the same way.
 Conflict resolution is hard.
 =======
-or cleanly resolved because both sides changed the same way.
+or cleanly resolved because both sides changed identically.
 Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
+>>>>>>> main
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-while in "zdiff3" style, it may look like this:
+while in the "zdiff3" style, it looks like this:
 
 ------------
 Here are lines that are either unchanged from the common
 ancestor, or cleanly resolved because only one side changed,
-or cleanly resolved because both sides changed the same way.
-<<<<<<< yours:sample.txt
-Conflict resolution is hard;
-let's go shopping.
-||||||| base:sample.txt
 or cleanly resolved because both sides changed identically.
+<<<<<<< HEAD
+Git makes conflict resolution straightforward.
+||||||| 81821ce
+or cleanly resolved because both sides changed the same way.
 Conflict resolution is hard.
 =======
 Git makes conflict resolution easy.
->>>>>>> theirs:sample.txt
+>>>>>>> main
 And here is another line that is cleanly resolved or unmodified.
 ------------
 
-In addition to the `<<<<<<<`, `=======`, and `>>>>>>>` markers, it uses
-another `|||||||` marker that is followed by the original text.  You can
-tell that the original just stated a fact, and your side simply gave in to
-that statement and gave up, while the other side tried to have a more
-positive attitude.  You can sometimes come up with a better resolution by
-viewing the original.
+The original commit SHA and text are shown after another marker, `|||||||`.
+This region lets you now see that both sides made the edit from "the same
+way" to "identically", as well as editing the following line.  The "diff3"
+style keeps all changed lines within the markers, whilst the "zdiff3" style
+moves the commonly edited line before the marker.
 
 
 HOW TO RESOLVE CONFLICTS

base-commit: 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
-- 
gitgitgadget
