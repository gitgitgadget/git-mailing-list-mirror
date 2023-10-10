Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BACD8CB7
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbjJJTtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjJJTtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:49:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2F294
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:49:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40666aa674fso57218335e9.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696967383; x=1697572183; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SXwzsrYVHpSrGmJnJ6i2YP+NlwkNsW//1KiAGOAVGA=;
        b=JFnUeRXAVpPx5xXKloV+nnZnfXc0ROcfn7tObfi2k7SCQr7Ca4SpbhabT1Anm3N7HG
         ONWTdPetz6jA3tpRXVFz5WJ9gpB3mOUisFrn2f7cf2zWdCSrIbTAV8mipQB0K01uqxqs
         WyfTaj/Wv2eZrlZQGPS+SA31Dcl23P2ppPdaLfIL64GunKQme7OdwW/SOv0cBsoU2xNb
         DYamQ28f8YXF44sNns1wRAnIwz2H7rAEMfkMCu3q2RhbDP22phuFjv1g8RWj8w0e0T4k
         Hrv57zHg1GsP+JssD/9vUMNScWO8jFx+rWjTEWbDdci3TEyMy4TdoYzLSudxjAm1WuC3
         xYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967383; x=1697572183;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SXwzsrYVHpSrGmJnJ6i2YP+NlwkNsW//1KiAGOAVGA=;
        b=AYtplrXs0/3SgCyvP4Ose275V7/bUDNkfmLNEfjVD/pLwtECPKOknJBaLVrOPI3vof
         svtWGEF3d03ljt2KDulzx738GuEOby96YofmawP9iPNzei3Jce+cou395J6TvkIhnU/o
         AeFkl105Y9HVrKX2EcQk9RmAxQqcMDsmhZoHcWCdgF49v2DxHGku9UCKdNl46PwKY3sF
         SZgkHHHJDLPWpY1V7WwT3md6Lqd7Qlz8IuPc/+zWfRI0vljN2CUY91JgHEQJVAYdLQF1
         jzMhx46Xl7iDB85RDfCRuNrxSZ8WX7R0ubHONzwckIUnhJ5qwQIY10aqTaWg1OxhSxXe
         1utQ==
X-Gm-Message-State: AOJu0YzYPt5jf63Xe8X8Vo5pTo2Xlpr9f4qFALekBQqPm3o/9vs03wuI
        aVmJlNutQ2gkQn8W5iAivpYnQGdYqFc=
X-Google-Smtp-Source: AGHT+IH2YpGbT9JG4mLbFH5OuaYSkmFYlMw+ck3HzmDE5JYADjUH3W6xIOaECSFV1PiJbSoFE0U5gQ==
X-Received: by 2002:a5d:4c87:0:b0:319:85e2:6972 with SMTP id z7-20020a5d4c87000000b0031985e26972mr16355595wrs.42.1696967382809;
        Tue, 10 Oct 2023 12:49:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k23-20020a5d5257000000b003177074f830sm13451212wrc.59.2023.10.10.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:49:42 -0700 (PDT)
Message-ID: <dadb822da99772cd277417f564cf672f65d1cc24.1696967380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
References: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
        <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Oct 2023 19:49:40 +0000
Subject: [PATCH v3 2/2] attr: add attr.tree for setting the treeish to read
 attributes from
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

44451a2 (attr: teach "--attr-source=<tree>" global option to "git",
2023-05-06) provided the ability to pass in a treeish as the attr
source. In the context of serving Git repositories as bare repos like we
do at GitLab however, it would be easier to point --attr-source to HEAD
for all commands by setting it once.

Add a new config attr.tree that allows this.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/config.txt      |  2 ++
 Documentation/config/attr.txt |  5 +++
 attr.c                        |  7 ++++
 attr.h                        |  2 ++
 config.c                      | 14 ++++++++
 t/t0003-attributes.sh         | 62 +++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+)
 create mode 100644 Documentation/config/attr.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 229b63a454c..b1891c2b5af 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -371,6 +371,8 @@ other popular tools, and describe them in your documentation.
 
 include::config/advice.txt[]
 
+include::config/attr.txt[]
+
 include::config/core.txt[]
 
 include::config/add.txt[]
diff --git a/Documentation/config/attr.txt b/Documentation/config/attr.txt
new file mode 100644
index 00000000000..be882523f8b
--- /dev/null
+++ b/Documentation/config/attr.txt
@@ -0,0 +1,5 @@
+attr.tree:
+	A <tree-ish> to read gitattributes from instead of the worktree. See
+	linkgit:gitattributes[5]. If `attr.tree` does not resolve to a valid tree,
+	treat it as an empty tree. --attr-source and GIT_ATTR_SOURCE take
+	precedence over attr.tree.
diff --git a/attr.c b/attr.c
index bf2ea1626a6..0ae6852d12b 100644
--- a/attr.c
+++ b/attr.c
@@ -24,6 +24,8 @@
 #include "tree-walk.h"
 #include "object-name.h"
 
+const char *git_attr_tree;
+
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
 static const char git_attr__unknown[] = "(builtin)unknown";
@@ -1206,6 +1208,11 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
+	if (!default_attr_source_tree_object_name) {
+		default_attr_source_tree_object_name = git_attr_tree;
+		ignore_bad_attr_tree = 1;
+	}
+
 	if (!default_attr_source_tree_object_name &&
 	    startup_info->have_repository &&
 	    is_bare_repository()) {
diff --git a/attr.h b/attr.h
index 2b745df4054..127998ae013 100644
--- a/attr.h
+++ b/attr.h
@@ -236,4 +236,6 @@ const char *git_attr_global_file(void);
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
 
+extern const char *git_attr_tree;
+
 #endif /* ATTR_H */
diff --git a/config.c b/config.c
index 3846a37be97..21a1590b505 100644
--- a/config.c
+++ b/config.c
@@ -18,6 +18,7 @@
 #include "repository.h"
 #include "lockfile.h"
 #include "mailmap.h"
+#include "attr.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
 #include "quote.h"
@@ -1904,6 +1905,16 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_attr_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "attr.tree"))
+		return git_config_string(&git_attr_tree, var, value);
+
+	/* Add other attribute related config variables here and to
+	   Documentation/config/attr.txt. */
+	return 0;
+}
+
 int git_default_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
@@ -1927,6 +1938,9 @@ int git_default_config(const char *var, const char *value,
 	if (starts_with(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
+	if (starts_with(var, "attr."))
+		return git_default_attr_config(var, value);
+
 	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
 		return git_default_advice_config(var, value);
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index e6b1a117228..b0949125f26 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -40,6 +40,10 @@ attr_check_source () {
 	test_cmp expect actual &&
 	test_must_be_empty err
 
+	git $git_opts -c "attr.tree=$source" check-attr test -- "$path" >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+
 	GIT_ATTR_SOURCE="$source" git $git_opts check-attr test -- "$path" >actual 2>err &&
 	test_cmp expect actual &&
 	test_must_be_empty err
@@ -342,6 +346,46 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
+
+test_expect_success 'attr.tree when HEAD is unborn' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo $bad_attr_source_err >expect_err &&
+		echo "f/path: test: unspecified" >expect &&
+		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
+		test_must_be_empty err &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'attr.tree points to non-existing ref' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo $bad_attr_source_err >expect_err &&
+		echo "f/path: test: unspecified" >expect &&
+		git -c attr.tree=refs/does/not/exist check-attr test -- f/path >actual 2>err &&
+		test_must_be_empty err &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'bad attr source defaults to reading .gitattributes file' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo "f/path test=val" >.gitattributes &&
+		echo "f/path: test: val" >expect &&
+		git -c attr.tree=HEAD check-attr test -- f/path >actual 2>err &&
+		test_must_be_empty err &&
+		test_cmp expect actual
+	)
+'
 
 test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
 	test_when_finished rm -rf test bare_with_gitattribute &&
@@ -356,6 +400,24 @@ test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success '--attr-source and GIT_ATTR_SOURCE take precedence over attr.tree' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		git checkout -b attr-source &&
+		test_commit "val1" .gitattributes "f/path test=val1" &&
+		git checkout -b attr-tree &&
+		test_commit "val2" .gitattributes "f/path test=val2" &&
+		git checkout attr-source &&
+		echo "f/path: test: val1" >expect &&
+		git -c attr.tree=attr-tree --attr-source=attr-source check-attr test -- f/path >actual &&
+		test_cmp expect actual &&
+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree check-attr test -- f/path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
-- 
gitgitgadget
