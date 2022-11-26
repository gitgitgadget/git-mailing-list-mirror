Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38871C46467
	for <git@archiver.kernel.org>; Sat, 26 Nov 2022 14:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKZOSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 09:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKZOSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 09:18:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140812035E
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:18:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso5299285wmp.5
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 06:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/qOVLeuDoqh1lbPOmbnTlzvzkhEMmLJS0FfumeNAyQ=;
        b=XXuVLiK/SVVUQlBuWgooHfQbJ7mA0bPsWJDAxbKzEci5uXu57srde7c/7/S5uCZFoR
         JRmLbUpj127r0MyTAJPBVNjnov8cUjsdh+9wkeO6SsRuq59pi12Ippk0gr3K9XCgnTf/
         2jCQ+OpSb9ORirY99MhzZj+LwK9PsziYMxqa9wQQRkKcwZIy1Us8SSKlimb2ZB+9KGC7
         PCqL81SuFO+uuCcvWa4nIZqQkaeaA9oqWgHvStABc0z+a7I4JvNEg6Mbo6aZo3cj7Z+l
         54L85NHXpKNdpOBpk8EzU/rhWspXtclJ71sZ5cEEMHR6i23s3L9uk8Bp2p3NWjeaWTTD
         xMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/qOVLeuDoqh1lbPOmbnTlzvzkhEMmLJS0FfumeNAyQ=;
        b=EG/q4BPPX2kyAI82g+GD1V6YAfc5XIGSN0Zv86vF7u2F9UvJTnPmwb9pfYAIUGywO3
         8nSNhZWKDaXhkLnxgZiim6B2My6dYGBSSpIenTxtSc3GB9+F4EURKpJqHiTh6n4NPi9D
         D2FYq9CZcWCs/W5RzXq65uj/h8sTlXD0re0uEA7wdhcaAUpBeuxLOK0ID+Av8BaHcuYM
         Nrd55frD7NsKKYVMkAAyBmkf2m/rwPITsbt2eSmKk/HpO+OQFTQOCM86DAtfK99TVYFi
         Uy6iJWnl3ZciGQywg+YNKjtBDlPrsq1lShSRLPImTr1W6Xo27T1nNRtfUCxDXDoNOgA+
         O9Bg==
X-Gm-Message-State: ANoB5pkGpgSvpxCkBeODh76zDKTKamgGx45EnL/jXJ634BzAMwaMJaau
        9x61qipd5KtmpYe/7LeDJpPgv5CRGB8=
X-Google-Smtp-Source: AA0mqf4qiMVQpljH/UH9IEopl8bkO/JAU35PtVcRMbQQm/cyWZH+LZ+5NodZBRJwXdnsRdmk/z2+Lg==
X-Received: by 2002:a05:600c:511c:b0:3cf:6c05:809e with SMTP id o28-20020a05600c511c00b003cf6c05809emr19211213wms.74.1669472279468;
        Sat, 26 Nov 2022 06:17:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adffac4000000b002420a2cdc96sm2336313wrs.70.2022.11.26.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 06:17:58 -0800 (PST)
Message-Id: <889fdf877a13067ece785c9c694ed17dcde19b32.1669472277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>
References: <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
        <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 26 Nov 2022 14:17:56 +0000
Subject: [PATCH v3 1/2] var: do not print usage() with a correct invocation
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
 builtin/var.c             | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 10 deletions(-)

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
index 491db274292..5cbe32ec890 100644
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
@@ -81,7 +78,9 @@ static int show_config(const char *var, const char *value, void *cb)
 
 int cmd_var(int argc, const char **argv, const char *prefix)
 {
-	const char *val = NULL;
+	const struct git_var *git_var;
+	const char *val;
+
 	if (argc != 2)
 		usage(var_usage);
 
@@ -91,10 +90,15 @@ int cmd_var(int argc, const char **argv, const char *prefix)
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

