Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E93C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 15:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243089AbiANP7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 10:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbiANP7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 10:59:47 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC7EC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso8318852wma.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S1PaJJPg2o30UCucYg9eejKkU83zrUc2phIaz5eaHU4=;
        b=HTA2kC8UbvNB5OtUSbz+5NYGK6Wb8/lEpVP7Ja7IgI5yBueSz2EEVkHa9u4bFCh/vA
         4+Id9xe0wnbR7/tRiIYc29vpHJKX4Y1+z8KjbjDFAf5OOpspCdj6mhRvuW1tkXTBoPD0
         80hizZEJAtgU8bdwntons4xVUOXuW2j0NN8xd7HphEGnsOQFHxAVYrarrZAGPivxux+3
         HGnm7ATx/Hqa74D6KGcfYsTaI/BEkpBaTmRunA30tAWn5CkP4jWsbMiZJXu9GFfwPrKs
         Hnva01CAHzHg1Wm39Q39wOoMMnp19kQb8rfmKEWtwMqP9r+5ubftirsDLbeir45oQgtD
         wgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S1PaJJPg2o30UCucYg9eejKkU83zrUc2phIaz5eaHU4=;
        b=Nye9aaZu7ARcYbHoDiG6rpN44ZVg/3D3LuVfMTatLX9IpXqbltN47J8ggFSPzYS4/2
         54OxHEmk8VogVqUd2mOMI463emOeC5+s6BB7rA82QAJAaJgZvM8RgzWxnk/xU9BHVUtc
         qRIApPCT2cI7JOfOmI8VLugz48y1WcgJsKz7uFnscK9zWVvc6qz9xeqvk2huAwwFPwdn
         bkr6Mhq6s/qxNv8fcixjJxqprWe3AueXC17QTpJZ1qViEFe4Xr1p9wf7/3q1x/rvP8t9
         Jm4VNOCzzeUrB/fZoVNHea10ubTxeaARFOtq6rFIl975WNi54R5aSMxBiC7hCDIEobIf
         +YBA==
X-Gm-Message-State: AOAM531dPu41Qt5EOEvJNmGFPlIuAYqj0KVTtPT8kBT578VlisI/233V
        nHPMYPRtSEwUGLpZLCXBZ4v+gWMcBF4=
X-Google-Smtp-Source: ABdhPJwpctzlkqcOzDSLu/0Rves43LIVnZIoGU2MugUzT2KRkehw3pK/uVo+X2wcTAsm6HkX4zFdwQ==
X-Received: by 2002:a7b:c921:: with SMTP id h1mr8901448wml.66.1642175985674;
        Fri, 14 Jan 2022 07:59:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm6752255wrm.117.2022.01.14.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 07:59:45 -0800 (PST)
Message-Id: <d50d804af4e17ff1613ae40e3b5cf1b1bd0986a0.1642175983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
        <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jan 2022 15:59:39 +0000
Subject: [PATCH v2 1/5] t1011: add testcase demonstrating accidental loss of
 user modifications
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

If a user has a file with local modifications that is not marked as
SKIP_WORKTREE, but the sparsity patterns are such that it should be
marked that way, and the user then invokes a command like

   * git checkout -q HEAD^

or

   * git read-tree -mu HEAD^

Then the file will be deleted along with all the users' modifications.
Add a testcase demonstrating this problem.

Note: This bug only triggers if something other than 'HEAD' is given;
if the commands above had specified 'HEAD', then the users' file would
be left alone.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 24092c09a95..1b2395b8a82 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -187,6 +187,27 @@ test_expect_success 'read-tree updates worktree, absent case' '
 	test ! -f init.t
 '
 
+test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
+	echo "/*" >.git/info/sparse-checkout &&
+	read_tree_u_must_succeed -m -u HEAD &&
+
+	echo dirty >init.t &&
+	read_tree_u_must_fail -m -u HEAD^ &&
+	test_path_is_file init.t &&
+	grep -q dirty init.t
+'
+
+test_expect_failure 'read-tree will not throw away dirty changes, sparse' '
+	echo "/*" >.git/info/sparse-checkout &&
+	read_tree_u_must_succeed -m -u HEAD &&
+
+	echo dirty >init.t &&
+	echo sub/added >.git/info/sparse-checkout &&
+	read_tree_u_must_fail -m -u HEAD^ &&
+	test_path_is_file init.t &&
+	grep -q dirty init.t
+'
+
 test_expect_success 'read-tree updates worktree, dirty case' '
 	echo sub/added >.git/info/sparse-checkout &&
 	git checkout -f top &&
-- 
gitgitgadget

