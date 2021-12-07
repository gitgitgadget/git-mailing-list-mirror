Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F212C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbhLGUXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhLGUXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:23:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF2DC061A32
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:20:19 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so349812wmd.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BIl9evXbIJU5ga7x+XAqIZkyBoZRZrQtHMZktJRm6r4=;
        b=n3cx11yEscpdsXrNWoyEhNdLFYtfhfBVfwz6c5EKAhLMZsqvpo9d1bnPEPaWfrIHjo
         vqkI46/m//PxUU9QGiZNYcNlf/lCGsVaFGkgmK7h18kRvfgcRqen12/KJWJbn36B0wAZ
         jVqKKjqa8mDn96OErcNxnMud/NdUjS109e/WdXfxkUh6jpNL9u7jWmFLp5yZkKkL//1z
         wzHHO4QD0CkilJmL3HTd/EMJ/NGKmmcke0RQ29DctrCB5QAXsLKEFjrujJxRGEx6O4Zk
         TKr8mIdr++w477XaJYqKWbbXE9Cicf3hBJDAJAbtwmeSmyhpQPmUTP9Crjyd6Av7bFQY
         +0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BIl9evXbIJU5ga7x+XAqIZkyBoZRZrQtHMZktJRm6r4=;
        b=iq8jelmp+WInOs2YYBh/irf/ahnxeqIPLWjSh5w7kDBzhBgtofiQlAaLY2BLSIxdEd
         0pvkW06FJ3oktATqFpG2eXXQn7A2+rSZWtk6vub4ZgMHDA+QsqSjJOCYc5LVIC47qdDP
         EN0zeqxgkBMxCipAGxg1EC8m9vN1mkxwx8FhXLDngwiDZodeijNBEU2HATr1Mdp8IwdL
         n4Yl9GKtbENdyThlJu2ZphCUdct5ws9ih4Zic6G/qzwRKZfi8z0cIH9UIuJshBBs3WED
         2NZF4wbxJKOfvmQXW8JKexH6whTXEMWVKx+R7FXXx/+mHs+32XaEs1GK9nSe2lHrjetm
         PpoA==
X-Gm-Message-State: AOAM530kAXsvf2QNWtsR3X7nZJPmvaCSsiyfMfNLlnvCo4c2vQBdwFkt
        cR3FqFnYFwOyze6Yo2UaSGImwUkhCew=
X-Google-Smtp-Source: ABdhPJzI5Th0LsyKLIJuRmRsJLcCLyGWYgeyiFkEmPzZKuG1FYDmni6kffo1zxxk4KfxquzVRNMl5A==
X-Received: by 2002:a05:600c:6006:: with SMTP id az6mr10204290wmb.5.1638908417543;
        Tue, 07 Dec 2021 12:20:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm667770wrv.95.2021.12.07.12.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:20:17 -0800 (PST)
Message-Id: <acb10889a1f6a11485330db575e68ac2f9660f2a.1638908410.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
        <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 20:20:07 +0000
Subject: [PATCH v2 07/10] sparse-checkout: enable reapply to take
 --[no-]{cone,sparse-index}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Folks may want to switch to or from cone mode, or to or from a
sparse-index without changing their sparsity paths.  Allow them to do so
using the reapply command.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1ecdc3ddd5a..9d2a05677c4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -759,13 +759,22 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
-	N_("git sparse-checkout reapply"),
+	N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),
 	NULL
 };
 
+static struct sparse_checkout_reapply_opts {
+	int cone_mode;
+	int sparse_index;
+} reapply_opts;
+
 static int sparse_checkout_reapply(int argc, const char **argv)
 {
 	static struct option builtin_sparse_checkout_reapply_options[] = {
+		OPT_BOOL(0, "cone", &reapply_opts.cone_mode,
+			 N_("initialize the sparse-checkout in cone mode")),
+		OPT_BOOL(0, "sparse-index", &reapply_opts.sparse_index,
+			 N_("toggle the use of a sparse index")),
 		OPT_END(),
 	};
 
@@ -777,6 +786,13 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
+
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
+	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
+		return 1;
+
 	return update_working_directory(NULL);
 }
 
-- 
gitgitgadget

