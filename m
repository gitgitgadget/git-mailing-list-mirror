Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CACC77B7F
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjESESQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjESESH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:18:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E681510DF
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f41d087b3bso27741275e9.0
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684469877; x=1687061877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EX9LtBIJU7ApbRd/VXHaVpi3R2zVjemKHKAo2nnI0E=;
        b=fe4WjiPPnt8J0qNmuElOfzoLFLwRnaVZXM2j7NoQaB1dXNlQHHKxDdtZDJ+DvDxAYb
         96eyykCFLagd/lHNz4rudULlbW/DpRqPsgYx8ZV4YTE8ZJ4UTVFTQNXSB2KqQoKdD9uz
         l/7m/a/3SttK8+JVScF5AhDQlV7rwsJgT6eMzIyg+a/3ZxwWcjk13PFX3NaERjODCsp4
         xiHkGLv1rnnNgxN5r+rWiBDfaApCTWP20a3wThdxDRHT6EuCVwYMQmTXKcD/084Bk95g
         8OdSlu4apljxKln4pihfEPt2wVlHbrQcKiX6Hlooo20kbA3V3MAZuJcQ8GhgbVtH9ZTD
         Q03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469877; x=1687061877;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EX9LtBIJU7ApbRd/VXHaVpi3R2zVjemKHKAo2nnI0E=;
        b=EJBpY2qUIHRVD7MhQp+b3W/YYBvquHgGEdvnXm++sWE21U/AVl7f8qa5QAKg1d0zgO
         3zDPiHNaEWi1/qTIQJ+uI4GVUKnUg6mmg/t+Rl3S/Kn6uU/d08fDj5vXg1cP55u87D7s
         zrwpUBun+MTRfpiAaTS4CrwNk2NX/8RyPAy1cMdyk5LF+fgnYvb9H57vwZVL0ULqeVJL
         /QzwTSLpUFErDMDrFHyvDpDKrRk5wO/LmGq8xisL3S2c8OBCiVjDUFrNsVg3pwN/vPmR
         ba1uTyXiWSR0yt9oGdxJVKHCEli4r+Lp1BPTMCGOmrFgzz8/0VJ/E0hohPRGq04Wb4+a
         iZZg==
X-Gm-Message-State: AC+VfDwLKzrOEdRrGZt9nNAZP312pdzeFVfD/Iw7CvsHVgcUN0Q9ncX2
        rhwPKYK3gRffiR30R/8O3mF+kUKRM1s=
X-Google-Smtp-Source: ACHHUZ7R/cyEh13g6a/SoynMinGZmc+6ha2Ay13EN6SBybtg7hDRkOs7VKqLyjPXp6VsK21+QXn8eg==
X-Received: by 2002:adf:e781:0:b0:309:4642:8793 with SMTP id n1-20020adfe781000000b0030946428793mr427216wrm.15.1684469877204;
        Thu, 18 May 2023 21:17:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v25-20020a05600c215900b003f423508c6bsm971354wml.44.2023.05.18.21.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:17:56 -0700 (PDT)
Message-Id: <ea10e7964a990cff7ceaeec6257908001dc403e9.1684469874.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
References: <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 May 2023 04:17:50 +0000
Subject: [PATCH v4 2/6] show-branch doc: say <ref>, not <reference>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>,
        Junio C Hamano <gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The glossary defines 'ref' as the official name of the thing,
and the output from "git grep -e '<ref' Documentation/" shows
that most everybody uses <ref>, not <reference>.  In addition,
the page already says <ref> in its SYNOPSIS section for the
command when it is used in the mode to follow the reflogs.

Strictly speaking, many references of these should be updated to
<commit> after adding an explanation on how these <commit>s are
discovered (i.e. we take <rev>, <glob>, or <ref> and starting from
these commits, follow their ancestry or reflog entries to list
commits), but that would be a lot bigger change I would rather not
to do in this patch, whose primary purpose is to make the existing
documentation more consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-show-branch.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 71f608b1ff1..58cf6210cde 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -74,8 +74,7 @@ OPTIONS
 	that is the common ancestor of all the branches.  This
 	flag tells the command to go <n> more common commits
 	beyond that.  When <n> is negative, display only the
-	<reference>s given, without showing the commit ancestry
-	tree.
+	<ref>s given, without showing the commit ancestry tree.
 
 --list::
 	Synonym to `--more=-1`
@@ -88,8 +87,8 @@ OPTIONS
 	the case of three or more commits.
 
 --independent::
-	Among the <reference>s given, display only the ones that
-	cannot be reached from any other <reference>.
+	Among the <ref>s given, display only the ones that cannot be
+	reached from any other <ref>.
 
 --no-name::
 	Do not show naming strings for each commit.
@@ -132,10 +131,11 @@ are mutually exclusive.
 
 OUTPUT
 ------
-Given N <references>, the first N lines are the one-line
-description from their commit message.  The branch head that is
-pointed at by $GIT_DIR/HEAD is prefixed with an asterisk `*`
-character while other heads are prefixed with a `!` character.
+
+Given N <ref>s, the first N lines are the one-line description from
+their commit message. The branch head that is pointed at by
+$GIT_DIR/HEAD is prefixed with an asterisk `*` character while other
+heads are prefixed with a `!` character.
 
 Following these N lines, one-line log for each commit is
 displayed, indented N places.  If a commit is on the I-th
-- 
gitgitgadget

