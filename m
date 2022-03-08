Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F618C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiCHOkc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347555AbiCHOkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF8238D9D
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t11so28899549wrm.5
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RxrhDEZAKd1TxOQXR/q4fcpzONcBLxkiP9hpg49quRw=;
        b=O2fjw40CHBQE/K8AR/0TJxndePsrHxJrVyCOHyoAdgYngviJ/9CRM7pQzYmJEGBAPC
         8S4zGHs1yunoTZiGT+Kgz6JLJm4LC5CQTiLw4ky0EJGB56HT3aiQkbup30d23i4veVg5
         0x/O/sc768sU9ElC3tnt4GxOBDe7R86mXUUs8V69ZukeScN72ZXmSpMX9Buhkz+nx9bZ
         yQMH9dJftee4vZ6aF8s6aTL1e6I9BwCZObGrO8eZoZZPqZAQov8oeQQDrEXRb06VSLpE
         BEqNX4zx2abDjrcFboDDQOq5LQxT+rVsoTEJiDCxNkZ/9o3+MOvXC02/HzBcZxhrwUl7
         U+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RxrhDEZAKd1TxOQXR/q4fcpzONcBLxkiP9hpg49quRw=;
        b=Z18KxtD2aeeFkyQ84B/xxcHxOgX8S4a8xpiqZviBE6KhirOhJC9NQEb6M+zJ2o+7YE
         1qaCH+7P/64vOaUIat5sR/EP8Ej8GT1SlU4bbHX82YTziuzi2x+94udFy8Ol87WazViW
         X9F0A5GMdTxvhaexMtIMy8ad9Xq/vlN9cW21c3S0XkSFspYoebDPBt78AO7Xts4RsS3j
         ULfcoEGV0a0uaCEnGlxvG0CzHZG2EXZ3xXeWYk/mMzaWckuZwWSsTYh+M6XGdQWed+gt
         N8n98Gs06dXAjDkYDyY3zkyMthQjO5CHKwIZy2q2hiPYvUl2qLmTqrR9Svm1JnHqbOCk
         AhXg==
X-Gm-Message-State: AOAM533dnYEcKzYTH56AWr9zQ61CIBGXcAe43rtAS4rEdNBLuFLzJ0P3
        pUTOcLyRpWovBeh2dsZUnMsbTBmo+Uw=
X-Google-Smtp-Source: ABdhPJy0wIC19CMgn2eT5fs5cDm/gEBSd5jDobd6msc3u8ewD4w8hsMuQ6nryPolwpCHTuFpkOfb+g==
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id i16-20020a5d5850000000b001f02d5bdc35mr12385786wrf.344.1646750366418;
        Tue, 08 Mar 2022 06:39:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020adfbc11000000b001f023d197b8sm14004629wrg.68.2022.03.08.06.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:25 -0800 (PST)
Message-Id: <efc03168818e9328d4d1f47f9d48fe2a46d1e2c9.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:13 +0000
Subject: [PATCH v3 06/12] MyFirstObjectWalk: update recommended usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change consolidated traverse_commit_list() and
traverse_commit_list_filtered(). This allows us to simplify the
recommended usage in MyFirstObjectWalk.txt to use this new set of
values.

While here, add some clarification on the difference between the two
methods.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/MyFirstObjectWalk.txt | 44 +++++++++++------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index ca267941f3e..8d9e85566e6 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -522,24 +522,25 @@ function shows that the all-object walk is being performed by
 `traverse_commit_list()` or `traverse_commit_list_filtered()`. Those two
 functions reside in `list-objects.c`; examining the source shows that, despite
 the name, these functions traverse all kinds of objects. Let's have a look at
-the arguments to `traverse_commit_list_filtered()`, which are a superset of the
-arguments to the unfiltered version.
+the arguments to `traverse_commit_list()`.
 
-- `struct list_objects_filter_options *filter_options`: This is a struct which
-  stores a filter-spec as outlined in `Documentation/rev-list-options.txt`.
-- `struct rev_info *revs`: This is the `rev_info` used for the walk.
+- `struct rev_info *revs`: This is the `rev_info` used for the walk. If
+  its `filter` member is not `NULL`, then `filter` contains information for
+  how to filter the object list.
 - `show_commit_fn show_commit`: A callback which will be used to handle each
   individual commit object.
 - `show_object_fn show_object`: A callback which will be used to handle each
   non-commit object (so each blob, tree, or tag).
 - `void *show_data`: A context buffer which is passed in turn to `show_commit`
   and `show_object`.
+
+In addition, `traverse_commit_list_filtered()` has an additional paramter:
+
 - `struct oidset *omitted`: A linked-list of object IDs which the provided
   filter caused to be omitted.
 
-It looks like this `traverse_commit_list_filtered()` uses callbacks we provide
-instead of needing us to call it repeatedly ourselves. Cool! Let's add the
-callbacks first.
+It looks like these methods use callbacks we provide instead of needing us
+to call it repeatedly ourselves. Cool! Let's add the callbacks first.
 
 For the sake of this tutorial, we'll simply keep track of how many of each kind
 of object we find. At file scope in `builtin/walken.c` add the following
@@ -712,20 +713,9 @@ help understand. In our case, that means we omit trees and blobs not directly
 referenced by `HEAD` or `HEAD`'s history, because we begin the walk with only
 `HEAD` in the `pending` list.)
 
-First, we'll need to `#include "list-objects-filter-options.h"` and set up the
-`struct list_objects_filter_options` at the top of the function.
-
-----
-static void walken_object_walk(struct rev_info *rev)
-{
-	struct list_objects_filter_options filter_options = { 0 };
-
-	...
-----
-
 For now, we are not going to track the omitted objects, so we'll replace those
 parameters with `NULL`. For the sake of simplicity, we'll add a simple
-build-time branch to use our filter or not. Replace the line calling
+build-time branch to use our filter or not. Preface the line calling
 `traverse_commit_list()` with the following, which will remind us which kind of
 walk we've just performed:
 
@@ -733,19 +723,17 @@ walk we've just performed:
 	if (0) {
 		/* Unfiltered: */
 		trace_printf(_("Unfiltered object walk.\n"));
-		traverse_commit_list(rev, walken_show_commit,
-				walken_show_object, NULL);
 	} else {
 		trace_printf(
 			_("Filtered object walk with filterspec 'tree:1'.\n"));
-		parse_list_objects_filter(&filter_options, "tree:1");
-
-		traverse_commit_list_filtered(&filter_options, rev,
-			walken_show_commit, walken_show_object, NULL, NULL);
+		CALLOC_ARRAY(rev->filter, 1);
+		parse_list_objects_filter(rev->filter, "tree:1");
 	}
+	traverse_commit_list(rev, walken_show_commit,
+			     walken_show_object, NULL);
 ----
 
-`struct list_objects_filter_options` is usually built directly from a command
+The `rev->filter` member is usually built directly from a command
 line argument, so the module provides an easy way to build one from a string.
 Even though we aren't taking user input right now, we can still build one with
 a hardcoded string using `parse_list_objects_filter()`.
@@ -784,7 +772,7 @@ object:
 ----
 	...
 
-		traverse_commit_list_filtered(&filter_options, rev,
+		traverse_commit_list_filtered(rev,
 			walken_show_commit, walken_show_object, NULL, &omitted);
 
 	...
-- 
gitgitgadget

