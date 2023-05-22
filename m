Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2DDC7EE2A
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjEVT3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjEVT3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:29:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F43186
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3094871953bso3352395f8f.0
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783744; x=1687375744;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baRKp++XNGqFLZImIKBUEPkFSQEx4N2m9iIFFysV+mU=;
        b=E03xrW98DAm3Rm0FHBStw4TymNFezocWgA3HSfEuF4xR8Iot4BpM7XWYtbDANApD0g
         101Oq3kmQfRroT4K8p37q3H5x4m3ScMc5o4Bw+yIsXyc2Qm0BbXRpO9xWUSe+22a9E+V
         RUEDT2R8rAH306fh8rJL0mStpTVSxxi4I6Cqqek6ZbWUlHHuQFUdI5s15KE0/h48Wtac
         6uCnuAsUTrrtfsNnhjfEGlMZ4c5U6IGde4GkeT077fyzwv4BCWhJgpU9tS+Q6Zbj0U9D
         QJBfACkGLCeDwelLO3MdwIDJL5rNNUgo0bezZekw3Yc55/9r/pgzUONzdeuN5TYcHPn3
         zpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783744; x=1687375744;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baRKp++XNGqFLZImIKBUEPkFSQEx4N2m9iIFFysV+mU=;
        b=HqWL+wDt081ZOTwTQBDjx57rrVEQE8L035r7gB5ZpH+3jfY/cHaO6L0J8sIJqnIa/x
         ur61DEik4Fu0QhEjfK1T+35ZRAPROkJCkunxnvOe6XAUhxELiSizU1gRNYUWcc2EOBcf
         2jX9SXX5cT5CqwAvzmd0dogetubYomBgGzGakgp366FFMygCDmIrUhrua1NP134DuyVc
         WaNs3C6B27/nX2QcYmKbaYNnMKjaeKOcSGVa5W02Fq6MR60haRBbgvJYf7CuXodyXxOF
         yhMgWSY8YpsMRi3pCOM7TqYBxWhyF2utWsDcWSKZEaYm/7ilSVBhHLg5/UsdTrT8cad0
         B5PQ==
X-Gm-Message-State: AC+VfDw3tr7QlnIc5DZkL6RoGHlP7goKftyNQU9IupS9lyxwQW51d5Bo
        iJ+PMHBOjHaN9FsacrdipyTxNs5/63k=
X-Google-Smtp-Source: ACHHUZ7XNvi3i78A6+D03vPemDezxDx1ZKDXWZoNFVbyXC0YaKdG4UvO3Mcwkyrgb8D05Hv3iLJsZw==
X-Received: by 2002:adf:f342:0:b0:306:30ea:a072 with SMTP id e2-20020adff342000000b0030630eaa072mr7519266wrp.53.1684783744226;
        Mon, 22 May 2023 12:29:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d670a000000b0030903371ef9sm8718249wru.22.2023.05.22.12.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:29:03 -0700 (PDT)
Message-Id: <1bacd52a432ecb89bc41b49a9e6317f8a5b15171.1684783741.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 May 2023 19:28:56 +0000
Subject: [PATCH v2 1/6] revisions.txt: use description list for special refs
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
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The special refs listed in 'gitrevisions' (under the '<refname>' entry)
are on separate lines in the Asciidoc source, but end up as a single
continuous paragraph in the rendered documentation (see e.g. [1]). In
following commits we will mention additional special refs, so to improve
legibility, use a description list such that every entry appears on its
own line. Since we are already in a description list, use ':::' as the
term delimiter.

In order for the new description list to be aligned with the description
under the '<refname>' entry, instead of being aligned with the last
entry of the "in the following rules" nested list, use the "ancestor
list continuation" syntax [2], i.e., leave an empty line before the
continuation '+'. Do the same for the paragraph following the new
description list ("Note that any...").

While at it, also use a continuation '+' before the "in the following
rules" list, for correctness. The parser seems not to care here, but
it's best to keep the sources correct.

[1] https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltrefnamegtemegemmasterememheadsmasterememrefsheadsmasterem
[2] https://docs.asciidoctor.org/asciidoc/latest/lists/continuation/#ancestor-list-continuation

Suggested-by: Victoria Dye <vdye@github.com>
Based-on-patch-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/revisions.txt | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 9aa58052bc7..ab5b8cf880b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -30,7 +30,7 @@ characters and to avoid word splitting.
   explicitly say 'heads/master' to tell Git which one you mean.
   When ambiguous, a '<refname>' is disambiguated by taking the
   first match in the following rules:
-
++
   . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usually
     useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`
     and `CHERRY_PICK_HEAD`);
@@ -44,19 +44,25 @@ characters and to avoid word splitting.
   . otherwise, 'refs/remotes/<refname>' if it exists;
 
   . otherwise, 'refs/remotes/<refname>/HEAD' if it exists.
+
 +
-`HEAD` names the commit on which you based the changes in the working tree.
-`FETCH_HEAD` records the branch which you fetched from a remote repository
-with your last `git fetch` invocation.
-`ORIG_HEAD` is created by commands that move your `HEAD` in a drastic
-way (`git am`, `git merge`, `git rebase`, `git reset`),
-to record the position of the `HEAD` before their operation, so that
-you can easily change the tip of the branch back to the state before you ran
-them.
-`MERGE_HEAD` records the commit(s) which you are merging into your branch
-when you run `git merge`.
-`CHERRY_PICK_HEAD` records the commit which you are cherry-picking
-when you run `git cherry-pick`.
+  `HEAD`:::
+    names the commit on which you based the changes in the working tree.
+  `FETCH_HEAD`:::
+    records the branch which you fetched from a remote repository with
+    your last `git fetch` invocation.
+  `ORIG_HEAD`:::
+    is created by commands that move your `HEAD` in a drastic way (`git
+    am`, `git merge`, `git rebase`, `git reset`), to record the position
+    of the `HEAD` before their operation, so that you can easily change
+    the tip of the branch back to the state before you ran them.
+  `MERGE_HEAD`:::
+    records the commit(s) which you are merging into your branch when you
+    run `git merge`.
+  `CHERRY_PICK_HEAD`:::
+    records the commit which you are cherry-picking when you run `git
+    cherry-pick`.
+
 +
 Note that any of the 'refs/*' cases above may come either from
 the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
-- 
gitgitgadget

