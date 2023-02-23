Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280F8C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjBWJPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBWJPH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:15:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE22442BF4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p8so10196126wrt.12
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54dRuSmDoDZRSvOtTbEmZzMk9W9OyB/i/B/eNUPRFMY=;
        b=dkZpLd1YLsKv1ccTzr3LUF8i7AjQwIwO3/CnsAhJiIE1PzQrZxLZpHNoFUBWN2rmAF
         0/UqJG/oWCd4OLMl+JL5NwiHbh7s62Hnj7FQZZsPVqTFHAwNUL2AsgZyf+JhYiXl1w+T
         ci/I3ZFkwvd0Fv9jZDujRDu1pikMFZUyz4jMVlLbV+Ep107toR7ONUiTQmqHZG+Znqgt
         T7Hj41wQiYfAQ31h6LxhudejUWy+1NM1Tsf8KUOihxhNP7HbMk7fmZlrzOWDhtLgasZ/
         cmZ+J7Zv7HrIIqpEVsRJobcrNEDdrGiq4bKVeKpBM1aREvMYtmllpk9mQi/+IrebqJSI
         4Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54dRuSmDoDZRSvOtTbEmZzMk9W9OyB/i/B/eNUPRFMY=;
        b=03Il4L+hB3cfCJm/dDB17i8Ra3HuanswANHnwJYEr8IcyvGRlc9eZuNu617e2qE3x+
         6Ef44k7XFqclv5dU7Htf96aDLEIHAutVUw3ULgvnWWnM9Nsm9N2Ip7Dsu/Gko7ZIrwqr
         JQvNRYQEVSTWBEsBY1iI/+e16RHrBVXyzvIK8FpoAYAx9pdJgmPqd7ylNr2qErYZl+zN
         kyshHOs/PpFPU3yfwDyo060C2VX8hhENPDgsXCSFpxDW0/DMjpMWh5F6g1nAWu8y1j/i
         tavfbnCOdtynNS2sg4INKo6Jlo8q31AdtuGEUIgT+AHDXn2jeudC8vBfgH+p+TA4mWeh
         YtMg==
X-Gm-Message-State: AO0yUKVXgB+5OmQ9ZugoWAxKAycyAr2Bv5pW0+wAxKyz0hEqVXon9qJJ
        20JDC4Kn95cQg9Z3uUKI8onF5UI88uU=
X-Google-Smtp-Source: AK7set/Roqe5k9ERcLKDuFZHQrDJ082YxHAIrJcXGeiQf/e1J8Hsxze/FmDJr1/Rmixs/PE854MZjg==
X-Received: by 2002:a5d:68d2:0:b0:2c7:156c:beb3 with SMTP id p18-20020a5d68d2000000b002c7156cbeb3mr487963wrw.69.1677143704134;
        Thu, 23 Feb 2023 01:15:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020adfdc8d000000b002c557f82e27sm7836274wrj.99.2023.02.23.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 01:15:03 -0800 (PST)
Message-Id: <f5a58123034a708b49aac7076197ad2ccdd3cba1.1677143700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 09:14:53 +0000
Subject: [PATCH 04/11] unpack-trees: clean up some flow control
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The update_sparsity() function was introduced in commit 7af7a25853
("unpack-trees: add a new update_sparsity() function", 2020-03-27).
Prior to that, unpack_trees() was used, but that had a few bugs because
the needs of the caller were different, and different enough that
unpack_trees() could not easily be modified to handle both usecases.

The implementation detail that update_sparsity() was written by copying
unpack_trees() and then streamlining it, and then modifying it in the
needed ways still shows through in that there are leftover vestiges in
both functions that are no longer needed.  Clean them up.  In
particular:

  * update_sparsity() allows a pattern list to be passed in, but
    unpack_trees() never should use a different pattern list.  Add a
    check and a BUG() if this gets violated.
  * update_sparsity() has a check early on that will BUG() if
    o->skip_sparse_checkout is set; as such, there's no need to check
    for that condition again later in the code.  We can simply remove
    the check and its corresponding goto label.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3d05e45a279..0887d157df4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1873,6 +1873,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
 	if (o->dir)
 		BUG("o->dir is for internal use only");
+	if (o->pl)
+		BUG("o->pl is for internal use only");
 
 	trace_performance_enter();
 	trace2_region_enter("unpack_trees", "unpack_trees", the_repository);
@@ -1899,7 +1901,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
-	if (!o->skip_sparse_checkout && !o->pl) {
+	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
 		populate_from_existing_patterns(o, &pl);
@@ -2113,8 +2115,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 		memset(&pl, 0, sizeof(pl));
 		free_pattern_list = 1;
 		populate_from_existing_patterns(o, &pl);
-		if (o->skip_sparse_checkout)
-			goto skip_sparse_checkout;
 	}
 
 	/* Expand sparse directories as needed */
@@ -2142,7 +2142,6 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
 			ret = UPDATE_SPARSITY_WARNINGS;
 	}
 
-skip_sparse_checkout:
 	if (check_updates(o, o->src_index))
 		ret = UPDATE_SPARSITY_WORKTREE_UPDATE_FAILURES;
 
-- 
gitgitgadget

