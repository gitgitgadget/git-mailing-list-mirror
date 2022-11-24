Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6924C43219
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 20:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiKXUXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 15:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKXUWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 15:22:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6FD5C0DE
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:54 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1962029wmp.5
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bFiO51UyTE2D3lTycCdsOTBmALDPaRF9AseQ8lhbDI=;
        b=QE+Q0PQOSJZE6/dk2y9vaMAMPYCNVWV/qEG0x2nwtdCXIJusreDbkippK8J33wE5NF
         ABzdFhPrfp0GqvPGHzenCWKe8yfYZskrLf8vW8V/VT/maaGQP+AJXewW2Re0G2lFOMI5
         k9diaRdUWxmeWaGIkvInl+wYPWW5xFPad9kmZUt6srAeUqRBgGXMBbrtJPvF8O+YTmOs
         n9T1x4kLIoPovaFhNc3zEQ1Xmt/eE4YhtV0PsqwgkH+yIPcMBdPYqYiTEtHyQhiVDPLk
         48UU6xurb8sFiCEf6D4wsEMsDUVbaa7KCG+9xeKll1kD5lPBee45xeTTwAcxogJLq5dd
         zxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bFiO51UyTE2D3lTycCdsOTBmALDPaRF9AseQ8lhbDI=;
        b=1SXVWisDYN9t7ErNBjduogMJegIQfWihOVJ0csUkXLrr25nLZhK8bT/wWGlz3k+qUd
         dbPGTcgDCcBZ3j+5AsnWz7GLpD8Nb+wqJbakNcKnH4prIxl5pvRNB/q2S0PAnaJF/eLa
         1SKRVyjk4frm5oKTCNqykv9vb6x7HGqhQqgK0Tll7tK+r4ZDfJD6WLSR25J4BXr7t1YR
         2yAoFlZ/RlrZ5SNoCFWdJUd6mPqiSCpLsVmGlJHdAyFJ4jYRQNfHTnRq1bs2Ce7vKeoR
         iwZ1ffF9aogMLLa08kwSm4EPpxWOVgPAu+gl6X6rtVpzC5rk/ggGsHIpWLWOpWjcc7/Y
         NZ2Q==
X-Gm-Message-State: ANoB5pkai4UWlB365NYtOn4NlHZG60HtKlHA5bWyaDlOebKBUwHh8qL2
        rDEm6XkZ69VaqEEjwm+0J/yb5YgVGEM=
X-Google-Smtp-Source: AA0mqf52PpuKzT+ftv68wUYOxzLZH9g18kyFhMrXGKfdEaYGx3jiCGg6LPgoFbdlXvHuFwqknqAj8g==
X-Received: by 2002:a05:600c:4254:b0:3cf:7197:e693 with SMTP id r20-20020a05600c425400b003cf7197e693mr25219371wmm.49.1669321372742;
        Thu, 24 Nov 2022 12:22:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003cfa622a18asm6722562wma.3.2022.11.24.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 12:22:52 -0800 (PST)
Message-Id: <8d49a718038c1e7504f512b0d04709b9c2d28df7.1669321369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 20:22:48 +0000
Subject: [PATCH 3/3] var: allow GIT_EDITOR to return null
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
index e215cd3b0c0..77e9ef3081a 100644
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
+    return git_editor();
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
