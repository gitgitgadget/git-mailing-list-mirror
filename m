Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7506C1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfGAUUs (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:48 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33981 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAUUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:48 -0400
Received: by mail-pf1-f201.google.com with SMTP id i2so9453302pfe.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q5QeI0tDEWjThRt/IPSRYbL/y6mt0+UXqsgB2FHUb/g=;
        b=AzyMNgX+8UG5h1rHuSv6+HOu/s+6XLCKZq1hMtL2CUvx5wPHcyNASTM7C4HmcN+6Gk
         oCJRMHo5J+D4PvhB2WckUuDNNjF4ALBz1dFPHTQn8/DJAt8TQeSyBzihu+Bs8TNbj/I0
         /fCGC1FbZg0eHEdAZJvjrcPn5MDHxT3KvutxVIsi7DvmP4FDOL9ZsUI7HICV7C7X8zJ4
         6mCD7AIl2kUkg0QDMkoh5F2U01ZoKOHvL46f6CWarwlJmB2hK5VsFTJkAC8nv+EVwEpp
         gNzS0/qxrXsKnkuj4MpFeSh044bFLI0EicE8lmVtxXv942kSxC7DFnaezgh90j+hfwEN
         GM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q5QeI0tDEWjThRt/IPSRYbL/y6mt0+UXqsgB2FHUb/g=;
        b=VFlMwWKhFpwnOx0+uWCMC6ubH14Ra60O9kPSM2LLruWKCr7YSTUJOs9NFTyszrWk/w
         iCqzG7F/NHtMi2RcoNKrA7qc4OlrgKJeoj0GTJ/gfsZ0IaQH+oX7HAKkpQUpo1SKDSsJ
         xsuBcvj/XGky/qwHhNdAF4Hn2MuW1o+9j1LwpVRA/i+AVHitruRNNGl9Nskk/VHOyJ6B
         W7oKrtkUblWm4OmSD/QgNU4bDwkHn32HaPyT1/+lQv5i2+qqV26vL5LBd6HN1IjlGMXo
         uuTJ7PXnLjXi9aPXpeUYL5hcZ8LCcJ/CF+ckxxY53BhRpdGKUZTaoMCVSwVFKgYDUDUb
         aiMQ==
X-Gm-Message-State: APjAAAVZ4ygPLPMw23GtrATVfhwVvN00JUiFW7EGdSYJzCkJed2DEBqy
        g8S+sGaGTsumpKqpewJ0bbChs7BQkehsOHGx0egbwqNDF3rcvbTcQictzPlO+/39nDWnDRBf3vQ
        2mshJSoeQ7eDni3C0tbG2ge2do8g/q2eVesoNvtsX6hL3l6SpTjTw/cVpyhies6UUlfXIY75TIA
        ==
X-Google-Smtp-Source: APXvYqz0Ncg4A2G5qKtf/0ttpoG0maKcKERMUFOzctY4vTG0yXhKi5W7/OjGnzRwdy4eL/r4sMW6dU67FLTwvgkAjaY=
X-Received: by 2002:a65:51c8:: with SMTP id i8mr3244026pgq.116.1562012446916;
 Mon, 01 Jul 2019 13:20:46 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:11 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 10/13] walken: add unfiltered object walk from HEAD
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide a demonstration of a revision walk which traverses all types of
object, not just commits. This type of revision walk is used for
operations such as creating packfiles and performing fetches or clones,
so it's useful to teach new developers how it works. For starters, only
demonstrate the unfiltered version, as this will make the tutorial
easier to follow.

This commit is part of a tutorial on revision walking.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: If3b11652ba011b28d29b1c3984dac4a3f80a5f53
---
 builtin/walken.c | 91 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/builtin/walken.c b/builtin/walken.c
index 03a50158fb..b613102cfb 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -11,9 +11,15 @@
 #include "parse-options.h"
 #include "pretty.h"
 #include "line-log.h"
+#include "list-objects.h"
 #include "grep.h"
 
 
+static int commit_count;
+static int tag_count;
+static int blob_count;
+static int tree_count;
+
 /*
  * Within init_walken_defaults() we can call into other useful defaults to set
  * in the global scope or on the_repository. It's okay to borrow from other
@@ -95,6 +101,74 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static void walken_show_commit(struct commit *cmt, void *buf)
+{
+	commit_count++;
+}
+
+static void walken_show_object(struct object *obj, const char *str, void *buf)
+{
+	switch (obj->type) {
+	case OBJ_TREE:
+		tree_count++;
+		break;
+	case OBJ_BLOB:
+		blob_count++;
+		break;
+	case OBJ_TAG:
+		tag_count++;
+		break;
+	case OBJ_COMMIT:
+		/*
+		 * BUG() is used to warn developers when they've made a change
+		 * which breaks some relied-upon behavior of Git. In this case,
+		 * we're telling developers that we don't expect commits to be
+		 * routed as objects during an object walk. BUG() messages
+		 * should not be localized.
+		 */
+		BUG("unexpected commit object in walken_show_object\n");
+	default:
+		/*
+		 * This statement will only be hit if a new object type is added
+		 * to Git; we BUG() to tell developers that the new object type
+		 * needs to be handled and counted here.
+		 */
+		BUG("unexpected object type %s in walken_show_object\n"),
+				type_name(obj->type);
+	}
+}
+
+/*
+ * walken_object_walk() is invoked by cmd_walken() after initialization. It does
+ * a walk of all object types.
+ */
+static void walken_object_walk(struct rev_info *rev)
+{
+	rev->tree_objects = 1;
+	rev->blob_objects = 1;
+	rev->tag_objects = 1;
+	rev->tree_blobs_in_commit_order = 1;
+	rev->exclude_promisor_objects = 1;
+
+	if (prepare_revision_walk(rev))
+		die(_("revision walk setup failed"));
+
+	commit_count = 0;
+	tag_count = 0;
+	blob_count = 0;
+	tree_count = 0;
+
+	traverse_commit_list(rev, walken_show_commit, walken_show_object, NULL);
+
+	/*
+	 * This print statement is designed to be script-parseable. Script
+	 * authors will rely on the output not to change, so we will not
+	 * localize this string. It will go to stdout directly.
+	 */
+	printf("commits %d\n blobs %d\n tags %d\n trees %d\n", commit_count,
+	       blob_count, tag_count, tree_count);
+}
+
 /*
  * walken_commit_walk() is invoked by cmd_walken() after initialization. It
  * performs the actual commit walk.
@@ -166,13 +240,18 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	/* We can set our traversal flags here. */
 	rev.always_show_header = 1;
 
-	/*
-	 * Before we do the walk, we need to set a starting point by giving it
-	 * something to go in `pending` - that happens in here
-	 */
-	final_rev_info_setup(argc, argv, prefix, &rev);
 
-	walken_commit_walk(&rev);
+	if (1) {
+		add_head_to_pending(&rev);
+		walken_object_walk(&rev);
+	} else {
+		/*
+		 * Before we do the walk, we need to set a starting point by giving it
+		 * something to go in `pending` - that happens in here
+		 */
+		final_rev_info_setup(argc, argv, prefix, &rev);
+		walken_commit_walk(&rev);
+	}
 
 	/*
 	 * This line is "human-readable" and we are writing a plumbing command,
-- 
2.22.0.410.gd8fdbe21b5-goog

