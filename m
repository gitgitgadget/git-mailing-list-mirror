Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9608C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbiEJXdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 19:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiEJXcq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 19:32:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A121D5008
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so280737wmn.1
        for <git@vger.kernel.org>; Tue, 10 May 2022 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YnGSgwjzx6yg1za1Z1HzxytFQ9bIIkcKN0GE008i7mY=;
        b=IsiANKljeATx8m5Q94EiE7ZIxYt5BNONQCHm6azwonv9ld4N6kSrsusLrNwteLwvlF
         X3BnK0Yh7NVEeYg2PPwIoRtELtIMu7Kq50emyYBfccj4DA4kMf8v3XO5V0NG6VzntKNG
         EmDN5Rsu4WCXFtFa71zDTGq2Sl1wR0GSxUyXf2pKRI2bSW93aX0xlLADK8+daO5DJ+vr
         PtZypBFZBjOjYAZ7M5ae5oLsi9qcfqzn9tzxqsVHIU6LA7hNMQdciEJ4rZ98GXQO4+i5
         MxeOqEk2xY2fu4kPOMBW24PC8gEpQgKnkYzVBU/W21u6dcUvszc/YzilNMIfqpRlNuKF
         tpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YnGSgwjzx6yg1za1Z1HzxytFQ9bIIkcKN0GE008i7mY=;
        b=JxPW3CQHGJt6N64FIBsBZGhWh4vFjBAL+CpEtJWth9P38qUZDJKzUfII0eBue0mblp
         keASrXkR6UD/KY2UQjWNpm8GpA+LHzezTnv/7ZaItWuLJEOUMp3v/PNl4eoe4DFkXIgw
         43LQ8CBBc2MxPM9i1Hu7IvQtagXJ2yODTIGD3sg/nYgQy1hcE8KCa8KgdzkYa5A54ojA
         Ali847tsMZ89uLbdJhkuPps8Zej0dcbOXy7hd4FI8KIsJNbAw9TTu1YoRjlfvhLXgNVY
         dWS3VVrTUqIcOYTxKb+JLjpwWZLnHSRyub481vnWJzs6AZ1d3+C2itkIxbVKe1En+RFb
         LpCA==
X-Gm-Message-State: AOAM533NvaLJr9LvhzUCtX3qS8VIXCbwhJDtCbf34F2Xugf8RIj+lzIm
        3Hd4DdT42cOmmj9YzmMbmli77nnyzfY=
X-Google-Smtp-Source: ABdhPJwiXdm4O6ELzT6IkA6s7azEGD/SLW6U+tPiRi33V2mHTckQepWhUTqluNPzx92F/XQLS0al7w==
X-Received: by 2002:a7b:c4c8:0:b0:394:26c5:b79e with SMTP id g8-20020a7bc4c8000000b0039426c5b79emr2120612wmk.15.1652225563671;
        Tue, 10 May 2022 16:32:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a7bc1c8000000b00394867d66ddsm437688wmj.35.2022.05.10.16.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 16:32:43 -0700 (PDT)
Message-Id: <4b4c38fcc03515c113dc1c15210be6b42baf8029.1652225552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
References: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
        <pull.1171.v3.git.1652225552.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 May 2022 23:32:32 +0000
Subject: [PATCH v3 6/6] unpack-trees: preserve index sparsity
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

When unpacking trees, set the default sparsity of the resultant index based
on repo settings and 'is_sparse_index_allowed()'.

Normally, when executing 'unpack_trees', the output index is marked sparse
when (and only when) it unpacks a sparse directory. However, an index may be
"sparse" even if it contains no sparse directories - when all files fall
inside the sparse-checkout definition or otherwise have SKIP_WORKTREE
disabled. Therefore, the output index may be marked "full" even when it is
"sparse", resulting in unnecessary 'ensure_full_index' calls when writing to
disk. Avoid this by setting the "default" index sparsity to match what is
expected for the repository.

As a consequence of this fix, the (non-merge) 'read-tree' performed when
applying a stash with untracked files no longer expands the index. Update
the corresponding test in 't1092'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 unpack-trees.c                           | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index aaf4d880dbc..19221c14225 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1392,7 +1392,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash -u &&
 	(
 		WITHOUT_UNTRACKED_TXT=1 &&
-		! ensure_not_expanded stash pop
+		ensure_not_expanded stash pop
 	) &&
 
 	ensure_not_expanded stash create &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 7f528d35cc2..a1d0ff3a4d3 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "attr.h"
 #include "split-index.h"
+#include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "fsmonitor.h"
@@ -1839,6 +1840,11 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
 
+	if (!o->src_index->initialized &&
+	    !repo->settings.command_requires_full_index &&
+	    is_sparse_index_allowed(&o->result, 0))
+		o->result.sparse_index = 1;
+
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
 	 */
-- 
gitgitgadget
