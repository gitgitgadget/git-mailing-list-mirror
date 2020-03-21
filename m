Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C2C43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E842077D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2PBoO2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCUSAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33239 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgCUSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id z65so11175124ede.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tgIF3/hBg7p9znhrfAoOu2pyWFMBsU8xe3pnxWWfp2w=;
        b=b2PBoO2ZxXc4i+MXSIDo7RF7u5RsZK2z+2lSLLIifUJcfvDF/9wzXefLgjGXrL28WF
         iRly2jYEavgzbVxQ9TgtIpQMq78YcjRoVlv7A+6/xEuNmP3v4BdKr5SK0icq460niToT
         jirqk/mwVlpke4Rxa0UJTqqLpNyXAjisvIs2eHYiSh6RZt7vhc7l5tdwhictfHP7aoht
         ltWCwmLMvfj3DiM0l/5TAfAY/zU3uive2W080I6IuyONgAYP/txBWRw8UqWnzsk+hFYw
         peo8zGr/3+m/v+zj4aJ79u5o1Tbzh+YkNN0Oim6N64d390y7l6cN3NunNKE8Vv7gscRf
         A6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tgIF3/hBg7p9znhrfAoOu2pyWFMBsU8xe3pnxWWfp2w=;
        b=WWdwpuaIzCES4OBdoqtBPa0hJUv0lvTwx12+RcTiuaiRgMvvKjxqo33XcOQbaIEtPM
         nIYbBfWB8/GJpIjmsYH4XjAlDgnKj/hi0xBzmQovg7gwbAM/xkBuCnIzSoYrj50EYGDD
         j+JkhWucL6uAZkVC0oipeIPY18uTCPEEkFrK3plrgU05aKfX4ViCKwt8+CR64wDRdRLi
         nCJe74SwIHOrttklTD4LDnqYe17KGEwl+XTuVufsV4K9c7GT5H6p+HFM1xCb/4Z51Ci8
         p14aOKTdxViUV44WgGgwI7qUrE4BwgeNenWY+rlCbzP44kqGKn1M3aB/Oghai3/PvFTk
         0VbQ==
X-Gm-Message-State: ANhLgQ2g0HZIp76OwN7An2fZEQlJzCS6HwlxaAewe/o8HJxDM0k0ZMI+
        T8Mqhj70CtQe/rH/S5bVbYwsTR0Q
X-Google-Smtp-Source: ADFU+vurfmbbaaudbV2EA2pc6lTYb6/qEp6ZfE6ZqMG1qiNKHBduvWccAocXAqE+ggsIhbcdmKOdAw==
X-Received: by 2002:a17:906:33d0:: with SMTP id w16mr13412761eja.257.1584813618366;
        Sat, 21 Mar 2020 11:00:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bs8sm171883ejb.92.2020.03.21.11.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:17 -0700 (PDT)
Message-Id: <79b9cc1df55c7fab9b3c0e8dcc88ca19f23e771c.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 18:00:02 +0000
Subject: [PATCH v2 11/18] sparse-checkout: use improved unpack_trees porcelain
 messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

setup_unpack_trees_porcelain() provides much improved error/warning
messages; instead of a message that assumes that there is only one path
with a given problem despite being used by code that intentionally is
grouping and showing errors together, it uses a message designed to be
used with groups of paths.  For example, this transforms

    error: Entry '	folder1/a
	folder2/a
    ' not uptodate. Cannot update sparse checkout.

into

    error: Cannot update sparse checkout: the following entries are not up to date:
	folder1/a
	folder2/a

In the past the suboptimal messages were never actually triggered
because we would error out if the working directory wasn't clean before
we even called unpack_trees().  The previous commit changed that,
though, so let's use the better error messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 2 ++
 t/t1091-sparse-checkout-builtin.sh | 9 +++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a55c60d7594..aa81199f85d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -112,7 +112,9 @@ static int update_working_directory(struct pattern_list *pl)
 
 	repo_hold_locked_index(r, &lock_file, LOCK_DIE_ON_ERROR);
 
+	setup_unpack_trees_porcelain(&o, "sparse-checkout");
 	result = update_sparsity(&o);
+	clear_unpack_trees_porcelain(&o);
 
 	if (result == UPDATE_SPARSITY_WARNINGS)
 		/*
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 86ae422ff5c..93c650ac038 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -328,16 +328,13 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
 
 	git -C dirty sparse-checkout init 2>err &&
-	test_i18ngrep "error" err &&
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "error.*Cannot update sparse checkout" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
-	test_i18ngrep "error" err &&
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "error.*Cannot update sparse checkout" err &&
 
 	git -C dirty sparse-checkout disable &&
-	test_i18ngrep "error" err &&
-	test_i18ngrep "Cannot update sparse checkout" err &&
+	test_i18ngrep "error.*Cannot update sparse checkout" err &&
 
 	git -C dirty reset --hard &&
 	git -C dirty sparse-checkout init &&
-- 
gitgitgadget

