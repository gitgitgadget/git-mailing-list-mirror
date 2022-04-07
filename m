Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C61C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345761AbiDGQj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbiDGQj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:39:26 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9299917B0C3
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:37:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q19so8674607wrc.6
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OcKuP5szKC9QdBAWkLw/2yWtY9M4uWGL+c5sLoq0NEA=;
        b=Oxo3tgZY7O3gutochnabTn6IghP/C78FCPhX+YQGOaxRrTZHU7L9rdti681cJU677F
         9r9VR2wF5Yryxps3Ugx9GqRQh7yJRZbBVOr5P86yNpOisRiC1qNVpqtiibjUp5U7Sqfp
         nq8kcG2AuJU6VOMhP3TeuqrG5cWPHGo9dcCwuBEHnVTpixb8j2IeMmECe7SJPO/jrCkm
         CztQqs07Qvey4Wj4Gh4f9nZWvXsvCab37mLauEZqF3WbFdhhyXIAcWvjIXdsLlg4WwLp
         NgsDR2tWHkTJcJqTcKJ2KcUzmlHdzl0cVgdGTtKxyEHyITTrAZ4uAXc9SCU9DViCHk4g
         mHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OcKuP5szKC9QdBAWkLw/2yWtY9M4uWGL+c5sLoq0NEA=;
        b=QIJedaQ0AcU23/3k6RUG1HpLuL+9ZscCOGa25sanl2RMHuCbKKoNKryeCquyAc6JZ6
         D4C6jCoePUMbmSpuw6ik+joZRa+eP0ARmVMq8MonIMawN/oOaVGh/+mGsk+QxFOm6oGR
         0ILA17CdWQSDKaiCq5ZFQbghMPMQvxlzQe99LDZdAQubdoxxiuZTuBXI15aSSIhAELcK
         t1NALru1Q8CPiLNsBJAVlqmDbz+5tAVXhm4yfToIie9hCqkvBtTz7wR9S7ORU7mUV3v0
         v9eS8XqKJ4XFs1lCd3is3hSSSzGBq3ZL49BtYX1ZVxBbvuZtDuVBUUyP5A01lIzkiEom
         54CA==
X-Gm-Message-State: AOAM5339Hd5f7KFUIIqqqjEXiJd7+TqUYLpgroqx+zaR0ZrICw/kv3e6
        AwQxfRkadlEdTLAHYEI0hRg9B1vcF3w=
X-Google-Smtp-Source: ABdhPJz4JkAtIxc6CP4mRgsqtxGvuINruv1S/R9x3XY3jtlWlwvdOMCMPy8GOPwxAvFX7nPn62fe+Q==
X-Received: by 2002:a05:6000:3c7:b0:207:8c51:c07b with SMTP id b7-20020a05600003c700b002078c51c07bmr2371383wrg.17.1649349444882;
        Thu, 07 Apr 2022 09:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b0038cd5074c83sm8597977wmq.34.2022.04.07.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:37:24 -0700 (PDT)
Message-Id: <8c2fdb5a4fc3317c05324da54692036e36fc15f3.1649349442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Apr 2022 16:37:19 +0000
Subject: [PATCH 1/4] t1092: add compatibility tests for 'git show'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 236ab530284..74792b5ebbc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1151,6 +1151,22 @@ test_expect_success 'clean' '
 	test_sparse_match test_path_is_dir folder1
 '
 
+test_expect_success 'show (cached blobs/trees)' '
+	init_repos &&
+
+	test_all_match git show :a &&
+	test_all_match git show :deep/a &&
+	test_sparse_match git show :folder1/a &&
+
+	# Asking "git show" for directories in the index
+	# does not work as implemented. The error message is
+	# different for a full checkout and a sparse checkout
+	# when the directory is outside of the cone.
+	test_all_match test_must_fail git show :deep/ &&
+	test_must_fail git -C full-checkout show :folder1/ &&
+	test_sparse_match test_must_fail git show :folder1/
+'
+
 test_expect_success 'submodule handling' '
 	init_repos &&
 
-- 
gitgitgadget

