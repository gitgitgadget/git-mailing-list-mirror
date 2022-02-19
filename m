Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9068CC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 16:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242665AbiBSQpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:45:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbiBSQpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 11:45:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B575F4E9
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so8504410wml.5
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XS/de9nZ8Iv+oNlhfd/f9n9uf/JZJYBvZ/8IR+hcM2U=;
        b=Mox7Tah4HbnfVhMCQFmX5C7PY35VPJ1TqZO8BnihXt7l75uWbF4ZRQqHbJZHRhhMN8
         TXx55ZlFgjMgITSl1A94qdYY7RjDDa+taaz4oBa9j19iOjNkmSt2MPVxR8v3Ft66mJ/H
         XvYVu2WzW4C0j4oHFujyr4YuKhvfuiikp+pRCW1AiQz02UtISlZJlUgXZAzX2Jaz5RC9
         VXNLUerRRYn6V6jrKJJEfon4IQiGM7C/aefoEskeAx+LQOxWm04Doun5AYuzLydFLtsR
         YdN2QC2vrkh4JSvvJfYF/HeC/4SlPUFqGZkiXJ6G7/DZiY90sKmm6sGU56u9YlBqVKvO
         RGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XS/de9nZ8Iv+oNlhfd/f9n9uf/JZJYBvZ/8IR+hcM2U=;
        b=P5YLMvzNtn/iDh7NgbsxOW5IQ7IioYlsq/jDHIptAEHcCLZUsTqwbIK52Zt0eOp/Xb
         yKOch1zrnW50N2XhkLZYmOoC8GONQ3Y6hkGp0PcEIkuJgcM1aEuUxqWJsxH+fLa+zwE2
         vuTl/vsyrUWhvdWtjZqBp0UQBcmHXnBCrFUD4qL7gqwppwnh0j6Gp2RCxbqxzQImVZw0
         c7SipjiTAQ4hn/yYokpe1tqNmwVl1VtVMXb3tnd6dfi2uRau9jsFveRff0gixYp6Wa+G
         S3CJeHvzqquDyE1prXLCDTFlEebk6XfVmoXjPhfwF6nSPACWpE4pg/TmKnaTxOF34PR8
         0Grw==
X-Gm-Message-State: AOAM533buVw7psI+TuGXmieKAwACKyKq5yQ3z+kN/M3pNYlEwF+te+Bi
        rYkVSlncoYHZH2+EUUHPmh3jGuya5jw=
X-Google-Smtp-Source: ABdhPJxVFrlYt7f228OZddc+BXiL84lBGASzuw2jx9jqaW/tyytwM2ZevJJ7EBuJPvwNIqTH927qdg==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr15193906wmp.41.1645289088196;
        Sat, 19 Feb 2022 08:44:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3sm25600629wri.109.2022.02.19.08.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 08:44:47 -0800 (PST)
Message-Id: <5215b7f7179824468da9476891833ff4cdb28404.1645289086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 16:44:41 +0000
Subject: [PATCH v5 1/5] sparse-checkout: correct reapply's handling of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4e256731d6 ("sparse-checkout: enable reapply to take
--[no-]{cone,sparse-index}", 2021-12-14) made it so that reapply could
take additional options but added no tests.  Tests would have shown that
the feature doesn't work because the initial values are set AFTER
parsing the command line options instead of before.  Add a test and set
the initial value at the appropriate time.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          |  6 +++---
 t/t1091-sparse-checkout-builtin.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a311483a7d2..fcd574f5fc1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -789,15 +789,15 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 	if (!core_apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
 
-	reapply_opts.cone_mode = -1;
-	reapply_opts.sparse_index = -1;
-
 	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
 		return 1;
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3592d124424..ce5e7c19efa 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -495,6 +495,34 @@ test_expect_failure 'sparse-checkout reapply' '
 	git -C tweak sparse-checkout disable
 '
 
+test_expect_success 'reapply can handle config options' '
+	git -C repo sparse-checkout init --cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --no-cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --cone --sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	index.sparse=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
-- 
gitgitgadget

