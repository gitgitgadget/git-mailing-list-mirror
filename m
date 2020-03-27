Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82840C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE9206DB
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 21:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qibRk5DP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0Vvo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:51:44 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41801 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgC0Vvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 17:51:44 -0400
Received: by mail-wr1-f45.google.com with SMTP id h9so13323795wrc.8
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 14:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=rZZeUeJHMRrY6JRQmhHgE7czo4hPj5rGCJJkNV206gw=;
        b=qibRk5DPS0Q5idhY+kocqwAhQ/LwWNhHIYVS9vDAbiUzIeihqJ569LHrFwnH1VFuG9
         unWwHuIYL8MxEbrUkdM1N/LKZhMfyRA9bfuYlz5e13mUJOqD82TR4YCf5OGejPj+wT24
         vyTvEbhOKACvF6/fDp+e54g8d30/nKrpqhRY33hIV9DNThTa21EK/JkzOO6SQtYvxmjz
         tZiXJKzrGb7y7AKIez68DLv8TodQXki6wJvtnDm5gqG9X74Eq+MvgHfiWAW+b4R5K7AX
         W1awppaabnBexvux6yHlEB8iQ4zJvL3h5fpFIXIBRLkxD4Qb0waBnh2KuTv5xnC9goM8
         /yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rZZeUeJHMRrY6JRQmhHgE7czo4hPj5rGCJJkNV206gw=;
        b=trtcOdUkKtv0mTkb1yBoNABZOsjqVITKznwdw/w1HOYZv4XJoDLomNuiMbZBiMmGpu
         BqcWlQmTfVkyPwozR4sd2AksPe1tnzdFH4bxfGrWurMqQSmQblgTEdnETRGXNctzAqfP
         UNMpXVnxM96k/FdERp7CeZYeK/QU/zoSkxk+zb8CPl5qQxhoDxtxBsPGQK5RYH6mbdTx
         68Jxmm+F2FnIdPbmCdAG2cVUezI4DekS1BugkcwyuZ9PDyo2hHARSpLBPFy3uptl/d8s
         kgHn6SeJdO/lEwqP9tA3+bFFiQFu7gRMVhcl9/lw9eOt2GiXwnqFLJgUWE+0/p6XHz9l
         1vxw==
X-Gm-Message-State: ANhLgQ07pMUaUJFNkesyy8p2cjWv9Nj/dQ67ibLyTFt+z/LpPqHyMKP6
        jJTs/a/n72pzv+np0cQO3hk2Urg+
X-Google-Smtp-Source: ADFU+vtVN+uhpZ8wSp6EkzTXj2kH73pS7cs2YOVoj7q+2mtm0tefdh9uGX91XdBfKhFgbmOTUY3pHQ==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr1633331wrr.109.1585345901695;
        Fri, 27 Mar 2020 14:51:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm9256969wmm.6.2020.03.27.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:51:41 -0700 (PDT)
Message-Id: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 21:51:40 +0000
Subject: [PATCH] pull: avoid running both merge and rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When opt_rebase is true, we still first check if we can fast-forward.
If the branch is fast-forwardable, then we can avoid the rebase and just
use merge to do the fast-forward logic.  However, when commit a6d7eb2c7a
("pull: optionally rebase submodules (remote submodule changes only)",
2017-06-23) added the ability to rebase submodules it accidentally
caused us to run BOTH a merge and a rebase.  Add a flag to avoid doing
both.

This was found when a user had both pull.rebase and rebase.autosquash
set to true.  In such a case, the running of both merge and rebase would
cause ORIG_HEAD to be updated twice (and match HEAD at the end instead
of the commit before the rebase started), against expectation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    pull: avoid running both merge and rebase
    
    Cc: Norbert Kiesel nkiesel@gmail.com [nkiesel@gmail.com], Jeff King 
    peff@peff.net [peff@peff.net]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-739%2Fnewren%2Favoid-merge-and-rebase-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-739/newren/avoid-merge-and-rebase-v1
Pull-Request: https://github.com/git/git/pull/739

 builtin/pull.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 3e624d1e008..19899b45c1d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -976,6 +976,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 	if (opt_rebase) {
 		int ret = 0;
+		int ran_ff = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
@@ -992,10 +993,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			if (is_descendant_of(merge_head, list)) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
+				ran_ff = 1;
 				ret = run_merge();
 			}
 		}
-		ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
+		if (!ran_ff)
+			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
 
 		if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
 			     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))

base-commit: 274b9cc25322d9ee79aa8e6d4e86f0ffe5ced925
-- 
gitgitgadget
