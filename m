Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACCFC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308F761241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347264AbhIXPlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347197AbhIXPk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D136C061766
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i23so28833390wrb.2
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p81KuoHo0hpFPRuL3S/d6BGjmb81vBJTciXyM2X9dQw=;
        b=Bk/YLmXYLwnQF8qGSg9s5sROFVrL8ZwhCCeyGdIBrAY2kMmcmaIhZln7wcTs41hkUG
         uNKgKlgH0AFxk0O0EF48fsR0792HW2V4K7fZRGxl6c0yhJz1QQbPplQ2h+id9WEt4bZG
         TuqUDGHUvDeEK8j4vO0lNwHmGqi/3bmH1HGkOuecM5FoH43q+gEtxJvOnNbNTRnayrt2
         s7xt5iPsWfpfpq6YccB2ix/cub+omppO28G3fQ7FaBZK7DU8//uKODzgb4PLDE+XVApf
         NWJMsehFJyZQ2oYscWJF9C5AgVvvYnvxPPjDOAJiNdJsZNR2FDTKTh4M8Ebeh4YHTj4i
         wyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p81KuoHo0hpFPRuL3S/d6BGjmb81vBJTciXyM2X9dQw=;
        b=Jmi93W27AS13UTb/JS/CNSInl+blIHN8x3JJpZ0YYmZ3ZR++NakRuKLPCFYWNIGQzQ
         wroDI5uHrXulR/0VeE9/WlSZLpWgW9Xn9TVluvlmbV96RyMlykd3WRDS3XJHKhe71vMO
         3w+7RKOK4ChnUwsFrHhm7eXDfsWf/XzkIhxtBFv5hIpujxaQpYaAx6ZDgd64mS51qvUN
         /bB/2lREOIHZF6IwGa3/01PhllIw12kfFcpty0k8lzF8Zvt1+GMNK4M4qfiwB2GThAPm
         80wZsRQa2TRct0/IZ577BlILbvsodWfhjjmf5lejbcBKqwrITKA260jHgP4E6bXiYrfF
         MuEw==
X-Gm-Message-State: AOAM532B2/zzEufNmkCM46bKbEcXr5gC7PggKULz38McnFqbnE6Hj8E8
        30mCAf7qaZR69A3nejDHB+qh5V4j92g=
X-Google-Smtp-Source: ABdhPJyKs7SDl5neY53vDnSGGSmnt4iT+vg6fimcPwySEfgHdbHDiYYYB7X+CQmUktiL5vhvYdma/w==
X-Received: by 2002:a05:600c:3797:: with SMTP id o23mr2830069wmr.111.1632497960271;
        Fri, 24 Sep 2021 08:39:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y9sm14921432wmj.36.2021.09.24.08.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:20 -0700 (PDT)
Message-Id: <4f7b5cdfa36b2edef666aa12ed8aee87405fc884.1632497954.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
        <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:09 +0000
Subject: [PATCH v4 08/13] add: update --chmod to skip sparse paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We added checks for path_in_sparse_checkout() to portions of 'git add'
that add warnings and prevent staging a modification, but we skipped the
--chmod mode. Update chmod_pathspec() to ignore cache entries whose path
is outside of the sparse-checkout cone (unless --sparse is provided).
Add a test in t3705.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/add.c                  |  4 +++-
 t/t3705-add-sparse-checkout.sh | 10 +++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index f8e3930608d..f87b8134b67 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -47,7 +47,9 @@ static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 		struct cache_entry *ce = active_cache[i];
 		int err;
 
-		if (!include_sparse && ce_skip_worktree(ce))
+		if (!include_sparse &&
+		    (ce_skip_worktree(ce) ||
+		     !path_in_sparse_checkout(ce->name, &the_index)))
 			continue;
 
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 3cab82092d4..0ae674a17a9 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -169,11 +169,19 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_must_fail git add sparse_entry &&
 	test_sparse_entry_unstaged &&
 
+	test_must_fail git add --chmod=+x sparse_entry &&
+	test_sparse_entry_unstaged &&
+
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
 	test-tool read-cache --table >actual &&
-	grep "^100644 blob.*sparse_entry\$" actual
+	grep "^100644 blob.*sparse_entry\$" actual &&
+
+	git add --sparse --chmod=+x sparse_entry 2>stderr &&
+	test_must_be_empty stderr &&
+	test-tool read-cache --table >actual &&
+	grep "^100755 blob.*sparse_entry\$" actual
 '
 
 test_expect_success 'add obeys advice.updateSparsePath' '
-- 
gitgitgadget

