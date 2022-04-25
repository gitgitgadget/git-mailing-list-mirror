Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6CBC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbiDYRww (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244093AbiDYRwe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93481201BB
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t6so18527645wra.4
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=v9+u+iEfBHf3/6XHwdPSjezaWzBqGr/mDaFjvcPrHmM=;
        b=nMHqO8bjwb9bofgpl17azFHh8UxuGcDDfFURdbMyfGxNkLQ1UjbgM3asEqu7O6R1VB
         lInY5X6nht4+Q+EU4IKGVgE6+BCkTg63AUuXU3A7jF8LuQZg5K1kUqqqV+ZQrUD9vnDH
         2tnqhUIrsf7oeY1NrtTT51OqID7GqLK9+UDfTnvGMOgq5OXFlTHoGVwPJQFLcs/dDy5T
         hj3YizJh4JppOmWXNXoVeal4LAhZ/4zMAVk1lup+cW1bybfjrR0G3MvvP/0wnMumRncx
         oozG469cgqtR1Bk7MBfPhbqQCvb5xnzFOrGfOwJ48213xhRGOd6mISTG73upS4or6u2K
         wx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=v9+u+iEfBHf3/6XHwdPSjezaWzBqGr/mDaFjvcPrHmM=;
        b=zlCwlL4IeI1cvaZfClXhFckxqiZjXpcQho7+VfyelqFZGY1HR7D3ckGnNT6ovpgfAJ
         TjCrvpTed4pCyT5+IgCYygBcw5fsME06ON4yVSpYYIfkXMIKylgbrnIibbbw9W++aQ4m
         9RTgGreH+FJjTQEOVphd9rfkbLmHhKg4MF/i3iY3QqaFV4Z4Lps5wwQfgBiIqNCeRu0K
         GeRozpwQl2sb4wwEGhXkWD7JsS3118jFUaOm9gZQNaADO8THoYAJFhV2C63jHxDWSdAk
         7Ehx/0Bkc8X5tmY875WzDuREQxenpcPxu5MukLrHyZYqNNe/hMjKqRmJ8yj7zSWOXAci
         8DMg==
X-Gm-Message-State: AOAM530amIoeGX/x8fDT5gqkqSfix6+Y6uZ/XfouraT95KIz7gc1mjvF
        r/xfaLmAm92jSuBhzICgD/j35mn23z4=
X-Google-Smtp-Source: ABdhPJz4FdtVVlfgcuu8J3jWTHVK2kCzJglgttmSsYUHMjWNv8FnPNBWRhe2EJULYI4Y2AOeHDOUwA==
X-Received: by 2002:a5d:5011:0:b0:207:ac6e:55c4 with SMTP id e17-20020a5d5011000000b00207ac6e55c4mr15185021wrt.631.1650908967874;
        Mon, 25 Apr 2022 10:49:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600018a300b0020a8b2341f9sm13041934wri.18.2022.04.25.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:27 -0700 (PDT)
Message-Id: <76f2a9e87223e1c1ebf2de6629c46bdf7ad326f1.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:16 +0000
Subject: [PATCH 6/7] stash: merge applied stash with merge-ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Change the merge function used in 'do_apply_stash()' from 'merge_recursive'
to 'merge_ort_recursive'. In addition to aligning with the default merge
strategy used by 'git merge' (6a5fb96672 (Change default merge backend from
recursive to ort, 2021-08-04)), this allows 'git stash <apply|pop>' to
operate without expanding the index by default. Update tests in 't1092'
verifying index expansion for 'git stash' accordingly.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/stash.c                          | 3 ++-
 t/t1092-sparse-checkout-compatibility.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 16171eb1dab..cd77d448546 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -7,6 +7,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "dir.h"
@@ -554,7 +555,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 	bases[0] = &info->b_tree;
 
 	ret = merge_recursive_generic(&o, &c_tree, &info->w_tree, 1, bases,
-				      merge_recursive, &result);
+				      merge_ort_recursive, &result);
 	if (ret) {
 		rerere(0);
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a8c1c345ab0..8545a865e04 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1377,7 +1377,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash &&
 	ensure_not_expanded stash list &&
 	ensure_not_expanded stash show stash@{0} &&
-	! ensure_not_expanded stash apply stash@{0} &&
+	ensure_not_expanded stash apply stash@{0} &&
 	ensure_not_expanded stash drop stash@{0} &&
 
 	echo >>sparse-index/deep/new &&
@@ -1391,7 +1391,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	oid=$(git -C sparse-index stash create) &&
 	ensure_not_expanded stash store -m "test" $oid &&
 	ensure_not_expanded reset --hard &&
-	! ensure_not_expanded stash pop &&
+	ensure_not_expanded stash pop &&
 
 	ensure_not_expanded checkout-index -f a &&
 	ensure_not_expanded checkout-index -f --all &&
-- 
gitgitgadget

