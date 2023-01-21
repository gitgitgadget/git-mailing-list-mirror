Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECC1C05027
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAUBzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjAUBzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09D73175
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so6983466wml.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJnOxb1cLASqWG2X9iEps6E7+klucQ5hQSjiTh0I9gE=;
        b=nrYEhXnAr0bQt4CEVWVom530cjgB1gsIAKjCvLNodTxXxn/m5rFeLknit3joQzYSwY
         6RjF14ITtKlvxp4rbyfxKXzWfe+4MrKXdjM38egIl68vvkax2lyt0NAsmP+DylSZuECe
         DwUQ43lSvK7dbM/cwkd1yRtcMNbuEBWmqFL3Ug2baxhbrffrr7SVU2519HhidWl55dJ8
         Qheg9s9PB3jLax8a/M7Yb/a8BuexzJSGGDOiqL6BuFajIjM75hZE5f4Sfcb4eFks5E78
         2HksfXtPeX1xQwZEqVjHO8hQJhI1IGoyioHKsRo4S/OsnHUE6651Kb8lu1aXpFZzdKEQ
         3Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJnOxb1cLASqWG2X9iEps6E7+klucQ5hQSjiTh0I9gE=;
        b=QptTcovWXHDQLc4dS4dGXmvAkWxdoAwet8bP2bQ40Jvx7rMTIKmHxUjy6i/pfrdDQ0
         hUyS7O2jypa9FWFxTJo5k6n4S5WGLYkQ6v8wnMbkbk4XEoVSJKyBa1LuJNzVDsCLn6IP
         5D7pi2552VYi2SbyGEdkERf+rDcToQET+RHJzY84X+IkNQCueS4PN9Lx5r3xqjHtx8V4
         liazn0YeC58GbqFWGXWu5oodSlSYxGQTFhBCyXxZB1G5KhoRJxdyGY5Pbtxr/hLQ2bw+
         kCStG48GE+1lDUu9j3yTeoWkDbDTtN7ad+kVbgS5uLLnZt6ZRJWq02+DctcXwZCOjvZr
         Q2Sw==
X-Gm-Message-State: AFqh2krCJdV83x8SDMjofV07Oqj0pQTQimH1mPbVglvUJwm7G1moFdAW
        zTCczz54VJGKz6M9VZF8u4NpW2721Eo=
X-Google-Smtp-Source: AMrXdXteOa6mgyGkJiHt/c/WL6t+8ccafM8NkePS5iRXJ3IAsIhJL3YqEMtkruyuY2d+sO0CsUkKbw==
X-Received: by 2002:a1c:f317:0:b0:3d0:480b:ac53 with SMTP id q23-20020a1cf317000000b003d0480bac53mr16495946wmq.12.1674266131391;
        Fri, 20 Jan 2023 17:55:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c00d900b003daf672a616sm3717996wmm.22.2023.01.20.17.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:31 -0800 (PST)
Message-Id: <a1e61ac8f2184b5d3f71ae279633342c997d9319.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:23 +0000
Subject: [PATCH v3 4/7] rebase: fix docs about incompatibilities with --root
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
index 3929535c0cd..3f12d242d83 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -567,10 +567,7 @@ See also INCOMPATIBLE OPTIONS below.
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
 
@@ -649,7 +646,7 @@ are incompatible with the following options:
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

