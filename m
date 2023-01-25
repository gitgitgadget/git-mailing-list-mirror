Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D2C27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjAYEEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjAYEEE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9C4902C
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so12846359wms.2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo1OaFfMKCy9YnGPXFMgi8mGCm66FoS1sHfeN+xzdBU=;
        b=DJomfAVXIxlRKBE0ZEBsxXAyeoK1IibOsFDpye5dbcBO5YTaisACbQIjI6nVgBF/T/
         qOK4uwJXxYmd6izTaffzXqO6uj+8L+Ed6kPnROB3MJLle/npxEgKIYAyvZF9gPQsF5e7
         UzkPXTKoKR4M8IQd8Ue0LMl8SHzCW+BjYxr1WvstnNoQ9TCF9Ycy5tPPdfCEbGVY5lHq
         YCv7kXkydwbBn43ymiNVPvaTCk+vzqYF7ag1b2wlocRnJrKQqSHDQA4kvgWgN7BKX5Kx
         WRDRL6jKfv+mrr5dWEL9KxS2UvlG+1uK/dhTgapwS2dL/hlB5/Hp9xme6Cxvo6wr02G1
         GYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo1OaFfMKCy9YnGPXFMgi8mGCm66FoS1sHfeN+xzdBU=;
        b=CVZxtCt2ZHXPzgTiQkt+z+pU9xXyDuecW1luTEZjio50a+coQNj9GkD9WoXHSlGAXj
         4VOKWLkzcwf7cd7JN7zBYcI5sVJqqtOEEtK1j1894BPzoTPT9dfP9YO+Ot5sBTO3SLJg
         041RkXzhXoZoJaAKxFhnA8kCwpmx4IeW5k50Dw4vnLtrahsVv978Eq2QwJzL5wyGGX/l
         iaU4Hq/37hJScOUyq2WlxU4WkgXdxB4J0upJEl98iMsurM2K30x5Xo+yHBbl+Oay3q0G
         xmrdFCbIfbiBU7ohNcqmXkGyPRksbuf5bXG+Uouc+S3JBUiPUxdcov+erwpqsjgjqxjf
         oDXw==
X-Gm-Message-State: AFqh2kqT/EoLUCFeugkhGjodrU20bP5EXq78kzNjk7qUI0Azzfvz+zSK
        V80a7qPVxC5RfJNfcxsOilZaXQ0Y+sg=
X-Google-Smtp-Source: AMrXdXu2KHa38XbyAdIaKV0U4at1G/JnorUBL3qxrrlO0r59Qfjr9i5RbNpyy1gU1qPZWEaEsnBLbA==
X-Received: by 2002:a05:600c:1e23:b0:3d9:103d:9081 with SMTP id ay35-20020a05600c1e2300b003d9103d9081mr27172141wmb.28.1674619440772;
        Tue, 24 Jan 2023 20:04:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10-20020adfdcca000000b002bbddb89c71sm3194086wrm.67.2023.01.24.20.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:00 -0800 (PST)
Message-Id: <b702f15ed7c2c48dc0f502ed0d7d6491c2056408.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:48 +0000
Subject: [PATCH v5 04/10] rebase: fix docs about incompatibilities with --root
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 5dacd4abdd ("git-rebase.txt: document incompatible options",
2018-06-25), I added notes about incompatibilities between options for
the apply and merge backends.  Unfortunately, I inverted the condition
when --root was incompatible with the apply backend.  Fix the
documentation, and add a testcase that verifies the documentation
matches the code.

While at it, the documentation for --root also tried to cover some of
the backend differences between the apply and merge backends in relation
to reapplying cherry picks.  The information:
  * assumed that the apply backend was the default (it isn't anymore)
  * was written before --reapply-cherry-picks became an option
  * was written before the detailed information on backend differences
All of these factors make the sentence under --root about reapplying
cherry picks contradict information that is now available elsewhere in
the manual, and the other references are correct.  So just strike this
sentence.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           | 7 ++-----
 t/t3422-rebase-incompatible-options.sh | 4 ++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7d01d1412d1..846aeed1b69 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -574,10 +574,7 @@ See also INCOMPATIBLE OPTIONS below.
 --root::
 	Rebase all commits reachable from `<branch>`, instead of
 	limiting them with an `<upstream>`.  This allows you to rebase
-	the root commit(s) on a branch.  When used with `--onto`, it
-	will skip changes already contained in `<newbase>` (instead of
-	`<upstream>`) whereas without `--onto` it will operate on every
-	change.
+	the root commit(s) on a branch.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -656,7 +653,7 @@ are incompatible with the following options:
  * --reapply-cherry-picks
  * --edit-todo
  * --update-refs
- * --root when used in combination with --onto
+ * --root when used without --onto
 
 In addition, the following pairs of options are incompatible:
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 9b9e78479f6..f86274990b0 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -65,6 +65,10 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --update-refs A
 	"
 
+	test_expect_success "$opt incompatible with --root without --onto" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --root A
+	"
 }
 
 # Check options which imply --apply
-- 
gitgitgadget

