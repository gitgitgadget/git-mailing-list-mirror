Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893D9C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A8060F56
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 14:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbhJ0Ol6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237877AbhJ0Olx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 10:41:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B9C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:27 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 82-20020a1c0055000000b0032ccc3ad5c1so4537173wma.2
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rWdQm5Zkkxjg4tRvPMLEws5NQlPaszk/3jdQlcrd+H8=;
        b=dVkfkgw/Jx/ggUgfL1ZNQxbJGATyN4s+juJ87G7jLKnTecpxOYsG3zV2cYvb1sPbc5
         cZet03C6wgl26ZIwVSWySvZBHm+OaaJYzW6uGqR8oW+25eQ78SuwJvy3oDIMBih3cYbu
         mkJbDyzG6XwcI5uyizNJcJ+PSfnh8BNkrgJwvMIP0QnjDx2xwyUcvBh14IN5K6D4XwQY
         8gF0imq4kp1/bOS6SnHf5n/BxFXOd+cPFImJeHeq54GhqHGHvi1CGgH1yuz2zQzZF+Xw
         tKhtdxU3Jrsl14GOnieOFkvVndF6brUoKgE5TDm22ZzEwp2MyZQMpjQ8hRKTi35EQp58
         fXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rWdQm5Zkkxjg4tRvPMLEws5NQlPaszk/3jdQlcrd+H8=;
        b=lOiCiGhcmJMH/QBOIj92op+lXlc0z9263Xm+sQfzwpnxRm5HtgzoH2AFeiQyYzDlTb
         ZgF7WcwmS+3eDLxXIw3f1qpC+69G1nUawzCoIGjwz638GQoORrX17irZ216TVcIGfGTj
         g55w5lFI+9+u9+OozNZc3/Yq3uNIEMwQf+4aw/B/++N5fTk7hyCRZl19ZjN1kZpn/xku
         7d9vP2Nmu825L53wuklgW6H78ppogb2d98q4SHMvcw5LYfVW+MLEKaJx/qATudq2t41M
         kkr74orfUyt5NUXblaDJlpV6v7pCSRR/F8c9iexk+/dnYD6TfAQwbrhm6Vxerddqe85Y
         ir/w==
X-Gm-Message-State: AOAM531vLlyw0jxNSILGDhJ8nYLobzGjHsUWgJI4KZPq5+kU1KX8Jayv
        eAbjxRMKsD4PGVHif8TUjW0NOoyqAPA=
X-Google-Smtp-Source: ABdhPJyeHD9by2pBG7iVEBnMPmEeoy3Bl0ym9mxKg9Slv0LB1CfhSebzGtFqVGBb69wipOdTCubcPQ==
X-Received: by 2002:a05:600c:19cd:: with SMTP id u13mr6030571wmq.148.1635345566252;
        Wed, 27 Oct 2021 07:39:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k10sm3637873wmr.32.2021.10.27.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:39:25 -0700 (PDT)
Message-Id: <1bb2ca92c60be453d7b151e0a1fb5d471a2e5090.1635345563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com>
        <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 14:39:18 +0000
Subject: [PATCH v5 3/8] sparse-index: update command for expand/collapse test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

In anticipation of `git reset --hard` being able to use the sparse index
without expanding it, replace the command in `sparse-index is expanded and
converted back` with `git reset -- folder1/a`. This command will need to
expand the index to work properly, even after integrating the rest of
`reset` with sparse index.

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index c7449afe965..cab6340a9d0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -634,11 +634,15 @@ test_expect_success 'submodule handling' '
 	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
 '
 
+# When working with a sparse index, some commands will need to expand the
+# index to operate properly. If those commands also write the index back
+# to disk, they need to convert the index to sparse before writing.
+# This test verifies that both of these events are logged in trace2 logs.
 test_expect_success 'sparse-index is expanded and converted back' '
 	init_repos &&
 
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git -C sparse-index -c core.fsmonitor="" reset --hard &&
+		git -C sparse-index reset -- folder1/a &&
 	test_region index convert_to_sparse trace2.txt &&
 	test_region index ensure_full_index trace2.txt
 '
-- 
gitgitgadget

