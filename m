Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59570C43217
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKYQwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 11:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKYQwi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 11:52:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA6E005
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:52:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id g12so7589315wrs.10
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owRpfCeHlsuvjyFn8Hn0Ng5eco+cuLhoGbEZ9My1ngw=;
        b=K1hfvg1S7IHe4+bJBVffmhFVsumYthbc99xBqBZ4cPfwvtFQP9wM95oEB/W1oahbKT
         qOvoel1uKsd3+N/pbQJmgMQ9aLQgHRW9qK6uH/InZ6otB8f+VRA6txs/CrKRDndseasV
         SSRN5/PuYGEkOU0mbseNPZIkV34j1diTzXzMN0vAjJWnWc4GYnIjnP05Oe4z04IUOseC
         eGw5yW3AKuDXBxqq2NhxNcAkVMcRs7XXdhteBqTn8xD7NhLhGKake/FSzjYTiHxb+egX
         wNrZjr6I0xKyqwkLxVr2zrImX59+C70zE/XaOBdU/dYtB0lITSBJLxwFpNsdkIQYB6oE
         wSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owRpfCeHlsuvjyFn8Hn0Ng5eco+cuLhoGbEZ9My1ngw=;
        b=bBwtz/DoLBdXvmtXAXqgYgaT0mt7f1CB6uzcxLG0SrX+Om82Odf767Ed+Liz8ElyFb
         pE1JMoB1utRa5Q7d686P4GREY7tuUW9AJBNwrRLj5InXGoqueD/5tonqY3iER5KDAAIQ
         cG0fVhGt3mRdfcSLMk/5c+0qso4pzv1lLpVZO4NSwtm4KZQSLlpsq1WWJcN+kNvNqbxb
         LotSTcrnCO3uGBMEVaurX8SkA4b5yWCWN5yUowGZ01wKFGOXvE+mPfSLpfktpuswkv+K
         /qQpii8YxFjbyIBK0CvhSUieeEFVogcQaZXLhxF4L90TgIkYbLtk8SJeAfAa7V5blqGx
         Xutg==
X-Gm-Message-State: ANoB5pkabv9QFYGV8fSm+m74zko2nCUs9skXuWMCLspRUvPFFP0PxU7Y
        1ul8HBpRqmcI3rzn4r8cJd7iKEiWhPE=
X-Google-Smtp-Source: AA0mqf5NuvrO7lPTHLZ98gZ1V+k8+kf+sbbvfPs4yF3VXPCu1Xd6Wa5wjmza3z0lEGZIFpSg+264XA==
X-Received: by 2002:adf:fdc7:0:b0:241:d7ab:db8f with SMTP id i7-20020adffdc7000000b00241d7abdb8fmr15394048wrs.285.1669395155028;
        Fri, 25 Nov 2022 08:52:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d6a8b000000b0022584c82c80sm4169680wru.19.2022.11.25.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:52:34 -0800 (PST)
Message-Id: <427cb7b55ac3fead1651cbad7318b9c0bb454b08.1669395151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
        <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 16:52:31 +0000
Subject: [PATCH v2 2/2] var: allow GIT_EDITOR to return null
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

The handling to die early when there is no EDITOR is valuable when
used in normal code (i.e., editor.c). In git-var, where
null/empty-string is a perfectly valid value to return, it doesn't
make as much sense.

Remove this handling from `git var GIT_EDITOR` so that it does not
fail so noisily when there is no defined editor.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 builtin/var.c      |  7 +----
 t/t0007-git-var.sh | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index e215cd3b0c0..5678ec68bfe 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -11,12 +11,7 @@ static const char var_usage[] = "git var (-l | <variable>)";
 
 static const char *editor(int flag)
 {
-	const char *pgm = git_editor();
-
-	if (!pgm && flag & IDENT_STRICT)
-		die("Terminal is dumb, but EDITOR unset");
-
-	return pgm;
+	return git_editor();
 }
 
 static const char *pager(int flag)
diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
index e56f4b9ac59..bdef271c92a 100755
--- a/t/t0007-git-var.sh
+++ b/t/t0007-git-var.sh
@@ -47,6 +47,75 @@ test_expect_success 'get GIT_DEFAULT_BRANCH with configuration' '
 	)
 '
 
+test_expect_success 'get GIT_EDITOR without configuration' '
+	(
+		sane_unset GIT_EDITOR &&
+		sane_unset VISUAL &&
+		sane_unset EDITOR &&
+		>expect &&
+		! git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with configuration' '
+	test_config core.editor foo &&
+	(
+		sane_unset GIT_EDITOR &&
+		sane_unset VISUAL &&
+		sane_unset EDITOR &&
+		echo foo >expect &&
+		git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with environment variable GIT_EDITOR' '
+	(
+		sane_unset GIT_EDITOR &&
+		sane_unset VISUAL &&
+		sane_unset EDITOR &&
+		echo bar >expect &&
+		GIT_EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with environment variable EDITOR' '
+	(
+		sane_unset GIT_EDITOR &&
+		sane_unset VISUAL &&
+		sane_unset EDITOR &&
+		echo bar >expect &&
+		EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with configuration and environment variable GIT_EDITOR' '
+	test_config core.editor foo &&
+	(
+		sane_unset GIT_EDITOR &&
+		sane_unset VISUAL &&
+		sane_unset EDITOR &&
+		echo bar >expect &&
+		GIT_EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'get GIT_EDITOR with configuration and environment variable EDITOR' '
+	test_config core.editor foo &&
+	(
+		sane_unset GIT_EDITOR &&
+		sane_unset VISUAL &&
+		sane_unset EDITOR &&
+		echo foo >expect &&
+		EDITOR=bar git var GIT_EDITOR >actual &&
+		test_cmp expect actual
+	)
+'
+
 # For git var -l, we check only a representative variable;
 # testing the whole output would make our test too brittle with
 # respect to unrelated changes in the test suite's environment.
-- 
gitgitgadget
