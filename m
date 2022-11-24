Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E1CC43219
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 20:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKXUW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 15:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKXUWx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 15:22:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957875D6B5
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:52 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r9-20020a1c4409000000b003d02dd48c45so4363617wma.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeoPzZNAcaYC1zuFX5PF+xFJXa4vS6XRQyzAYX7eilA=;
        b=MtqS9/gbzvYLSooRdBRYtveCiTa3HlWGnHI0Y/RrkNHI0gIH2s0KDuSmTxe+cy6g2E
         Q6QnCTLnKgnguBwUt9o5f+ZUeZL6LdjjBqDVqhHkvXWZ+93bVMNNMrk2VUWwV0quE5iN
         Px6K0JGFNSmCmsSKHw1YuKnXRSXS5D72tHXq8QbAjMiUZedY4mfUchf+Q9W393cu8pK9
         W97xweFFZIpagV0HVqY2XpNmLv6ku6p6hT0SJKstJviB4KhjbJWHTZUM6cLAaZKEejb9
         rKvVlGA1Q3b1VRDOlCAZawbtxHM6832trzX64s+toIr0obGzxP/IKMO69BzvoE1WKmIB
         qevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eeoPzZNAcaYC1zuFX5PF+xFJXa4vS6XRQyzAYX7eilA=;
        b=lhPmFcF0qRgAYaZINdIG88by0uFgAmhMy+gznrpeXixyoOiurvDsKEX6ACFryc0Sxt
         V+E4qPv99X6g1YiAfE9iSCh5+u3SMfDgUXsXvjzyVQPgJQl8YxbVVXLOJd4vQIo5Ybal
         xc++EbXlBeBJFTdmHccPAP3Dq4H5+XYasaFQHEZbp35dXZcDjzFRW+nHaN5rX3HGC1oO
         1mpRWEm9ypgvZPolwYI5vl+ANKew2wRMwQzk4YpCDDkY3qbr2ICIDKJO0/fZHo59q9jk
         q/QDaqKk8F/LCU2sQpt8LaVDhcD2smUa1TKbR+bDmxSlaRS41b1PKroeDBKr+Xs2vdj4
         ZzcA==
X-Gm-Message-State: ANoB5plej/WogTh21TMUa29LE48r2Ydgk6UPBUp/bk4vYqAsCq0BlhbI
        axvPpvwdcwJZqYEc0yiha2s5k0LPKO8=
X-Google-Smtp-Source: AA0mqf5ENB7wv1c60kNdzcmZNjb7SYNTLIZJpaHP+N+GV854RwJOucpFKqP7zQSIcecrAafPXsBQYg==
X-Received: by 2002:a05:600c:54e4:b0:3c6:d39c:fc4b with SMTP id jb4-20020a05600c54e400b003c6d39cfc4bmr13588619wmb.14.1669321370961;
        Thu, 24 Nov 2022 12:22:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020a1c6a02000000b003b4868eb71bsm6531588wmc.25.2022.11.24.12.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 12:22:50 -0800 (PST)
Message-Id: <d5f571f0bb352c0ec9cd8d1162c14cc26ccfa52c.1669321369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 20:22:46 +0000
Subject: [PATCH 1/3] var: do not print usage() with a correct invocation
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

Before, git-var could print usage() even if the command was invoked
correctly with a variable defined in git_vars -- provided that its
read() function returned NULL.

Now, we only print usage() only if it was called with a logical
variable that wasn't defined -- regardless of read().

Since we now know the variable is valid when we call read_var(), we
can avoid printing usage() here (and exiting with code 129) and
instead exit quietly with code 1. While exiting with a different code
can be a breaking change, it's far better than changing the exit
status more generally from 'failure' to 'success'.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-var.txt |  3 ++-
 builtin/var.c             | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 6aa521fab23..0ab5bfa7d72 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -13,7 +13,8 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Prints a Git logical variable.
+Prints a Git logical variable. Exits with code 1 if the variable has
+no value.
 
 OPTIONS
 -------
diff --git a/builtin/var.c b/builtin/var.c
index 491db274292..776f1778ae1 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -56,6 +56,17 @@ static void list_vars(void)
 			printf("%s=%s\n", ptr->name, val);
 }
 
+static const struct git_var *get_git_var(const char *var)
+{
+	struct git_var *ptr;
+	for (ptr = git_vars; ptr->read; ptr++) {
+		if (strcmp(var, ptr->name) == 0) {
+			return ptr;
+		}
+	}
+	return NULL;
+}
+
 static const char *read_var(const char *var)
 {
 	struct git_var *ptr;
@@ -81,6 +92,7 @@ static int show_config(const char *var, const char *value, void *cb)
 
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
+	const struct git_var *git_var = NULL;
 	const char *val = NULL;
 	if (argc != 2)
 		usage(var_usage);
@@ -91,9 +103,14 @@ int cmd_var(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 	git_config(git_default_config, NULL);
+
+	git_var = get_git_var(argv[1]);
+	if (!git_var)
+		usage(var_usage);
+
 	val = read_var(argv[1]);
 	if (!val)
-		usage(var_usage);
+		return 1;
 
 	printf("%s\n", val);
 
-- 
gitgitgadget

