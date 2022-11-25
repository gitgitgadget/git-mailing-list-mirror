Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF687C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKYQwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 11:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiKYQwh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 11:52:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC11EBF4A
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:52:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g12so7589251wrs.10
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07ZZvCLDIn4yQGVyo5QcAQiSuRC0whLl9O0qLIeWzfw=;
        b=jKnIApCzUsTh2W+dX7gvcVSMuuTosejn343uPgr5h0zmFp2oW/qs/OJtM73de8pvmN
         k24nIpIwAUZXLqC3La3fdqJe4nTsM4ynhkgTx93yf3hjKd3ZMWYIaBGzXUgHo1k4zt/w
         FbzoGZmyHqcIchUBq1zcmzgopNllJhT46uWtpPXs+eGCK9CIJKRXD0OEojErZTcT8s80
         nCsbNMqnD7amI+VA3WQcUlJSzBL4uutkjdlUEcxYeQdUkFTygBBBn++A2WL27Qv+ks78
         l8yxdupDDnDkBpGXR0EgEBRj9+CUrx0/DzW/NDRcvPHWLunJCiGDGQcronGKiic+2XA+
         4J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07ZZvCLDIn4yQGVyo5QcAQiSuRC0whLl9O0qLIeWzfw=;
        b=i6DKhrv7YwmN1LLphAqzm3iYHL/+PZah6JDNw+4UOijxEuvQXpuItQ/JRpjaLIto/f
         61eRJot4w9m/9UIkp3wvxAYvTW9LV9ERSYF0w7RHA3D88eAXvt7qn3h2NHXTY+oMmvkp
         cAkzwqmeDZDDHWPm3Q1zeJAFtXD8yuMPXeoNYd6iTFVLY/j81fNoAkyA6Or0xHLq3dr7
         TDqnpDqSxqE6QIy8bof9biWEOMqqBxrz67E1xSNHM4wVN3tNJ4Jty8pvODwi6JulFjEo
         0PAvP0hq6/stPZMgMmD55gGkU/M/qPrw0hOdxUh3iJzwtFjx5QeslPAMknEk7PhlDte6
         CBYQ==
X-Gm-Message-State: ANoB5pkYa5ssGvk72yPY8NVbrnTFGZz8Pb3PhwlFvdd3rNqwiBDuSCfX
        CrfqvdgXB8A0JXepIlRH0yGyZuiZedw=
X-Google-Smtp-Source: AA0mqf6kvFKACKI6/Px6pMmUxkSHyc+1jYehn9QPXR8rAMn7AAFR34H3gJS7hPNbQLB/gNTHh8czZQ==
X-Received: by 2002:a5d:4090:0:b0:241:f675:c8cf with SMTP id o16-20020a5d4090000000b00241f675c8cfmr7815654wrp.480.1669395154070;
        Fri, 25 Nov 2022 08:52:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s6-20020a5d4ec6000000b0023662245d3csm4087613wrv.95.2022.11.25.08.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:52:33 -0800 (PST)
Message-Id: <a7ff842a3e8d30cad7f18427bc812f542b998efc.1669395151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
        <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 16:52:30 +0000
Subject: [PATCH v2 1/2] var: do not print usage() with a correct invocation
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
 builtin/var.c             | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

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
index 491db274292..e215cd3b0c0 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -56,18 +56,15 @@ static void list_vars(void)
 			printf("%s=%s\n", ptr->name, val);
 }
 
-static const char *read_var(const char *var)
+static const struct git_var *get_git_var(const char *var)
 {
 	struct git_var *ptr;
-	const char *val;
-	val = NULL;
 	for (ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
-			val = ptr->read(IDENT_STRICT);
-			break;
+			return ptr;
 		}
 	}
-	return val;
+	return NULL;
 }
 
 static int show_config(const char *var, const char *value, void *cb)
@@ -81,6 +78,7 @@ static int show_config(const char *var, const char *value, void *cb)
 
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
+	const struct git_var *git_var = NULL;
 	const char *val = NULL;
 	if (argc != 2)
 		usage(var_usage);
@@ -91,10 +89,15 @@ int cmd_var(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 	git_config(git_default_config, NULL);
-	val = read_var(argv[1]);
-	if (!val)
+
+	git_var = get_git_var(argv[1]);
+	if (!git_var)
 		usage(var_usage);
 
+	val = git_var->read(IDENT_STRICT);
+	if (!val)
+		return 1;
+
 	printf("%s\n", val);
 
 	return 0;
-- 
gitgitgadget

