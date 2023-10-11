Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F936CDB46B
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 17:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjJKRNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjJKRNs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 13:13:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9DCA4
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:13:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31f71b25a99so33573f8f.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697044425; x=1697649225; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9N2lRyWdgfh5X8DpAMhVnoCceCvWL2e3Hj1tGncUXQ=;
        b=O+0dJc8aaQQiXNO9+//NaJVx4iU168SRlXX2SpQmxRgdqCGE71r1NbwRR4a0soh94T
         p4keMlNVqukAK1oSCMihu9dF0oTBvK2Je+BcY5Wl1SPwGHKKs5oKtF8xyyM3bK4BYVoo
         ER8P4f8T+0uvLwoqeZSuCEGx9P1i+f8DUa6JzAHFHCJOeZqIzI6rRRcd5U0AJz321kBx
         MKWlvmamjbhewUzWyczgmKHyqTNBEhA7PQsl5c9mwixaQHutCeMiPJxhbiq4PRykFnt9
         FEkBIlt45RI9ZtsN5GXWb6uUhY2eOhmRKaxKExs9l1tcXbNTBNliGi4GKNbkT/Nph0SS
         CmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697044425; x=1697649225;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9N2lRyWdgfh5X8DpAMhVnoCceCvWL2e3Hj1tGncUXQ=;
        b=NJGP/Hq6QWzZClqxa/5bWAwXi5xzLdKxvgNtq/DuBfIE/JRi9mhI+W15m+wjafiumQ
         vwhIuWEZnKHxmj/pXuIMn87UG630zkX87/9RtaIvQz3BcN7pyOG6MvVRVDdAiBCNugGX
         yHUHxEB2ReztVAfwgbTXNaX/f5hCw1vWNhse39wQAgUIgY38AMpEez/X0EFwh2vegkGT
         axDzAmw9P0mGaswY33r/7KIlIBnuSoz6MnLjbUBq2bGIIdeN6qwgdHejy7SayOST+8+X
         oXkgZMKl1kRHorX69ecbgtwqrRysHcGYsA1HyAKfMYeISuEPKG2vYXM3524qHm7vhdI+
         Yiig==
X-Gm-Message-State: AOJu0YwnWSShYbNKR3ZUqtVVP9fPcjEAkCdx7FLh85luqC3UPgriezab
        ouTewCOCca/C6J//olGudhGUTHMRHbk=
X-Google-Smtp-Source: AGHT+IH/Ae5PL4rlOHKkQB6iY/m4nRL+yt8DBZuoVYcfltGJ0oNJkCLN25jELTPxjzU15f9h2MVqZw==
X-Received: by 2002:a5d:6e85:0:b0:323:10b8:543e with SMTP id k5-20020a5d6e85000000b0032310b8543emr17850798wrz.49.1697044424859;
        Wed, 11 Oct 2023 10:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00327b5ca093dsm15930855wrz.117.2023.10.11.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:13:44 -0700 (PDT)
Message-ID: <749d8a8082edf05fe184ab73acb7583cf00e2f0a.1697044422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
References: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
        <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Oct 2023 17:13:42 +0000
Subject: [PATCH v4 2/2] attr: add attr.tree for setting the treeish to read
 attributes from
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
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
 Documentation/config.txt      |  2 +
 Documentation/config/attr.txt |  7 ++++
 attr.c                        |  7 ++++
 attr.h                        |  2 +
 config.c                      | 16 ++++++++
 t/t0003-attributes.sh         | 73 +++++++++++++++++++++++++++++++++++
 6 files changed, 107 insertions(+)
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
index 00000000000..1a482d6af2b
--- /dev/null
+++ b/Documentation/config/attr.txt
@@ -0,0 +1,7 @@
+attr.tree::
+	A reference to a tree in the repository from which to read attributes,
+	instead of the `.gitattributes` file in the working tree. In a bare
+	repository, this defaults to `HEAD:.gitattributes`. If the value does
+	not resolve to a valid tree object, an empty tree is used instead.
+	When the `GIT_ATTR_SOURCE` environment variable or `--attr-source`
+	command line option are used, this configuration variable has no effect.
diff --git a/attr.c b/attr.c
index bf2ea1626a6..e62876dfd3e 100644
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
 
+	if (!default_attr_source_tree_object_name && git_attr_tree) {
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
index 3846a37be97..fb6a2db1d9b 100644
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
@@ -1904,6 +1905,18 @@ static int git_default_mailmap_config(const char *var, const char *value)
 	return 0;
 }
 
+static int git_default_attr_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "attr.tree"))
+		return git_config_string(&git_attr_tree, var, value);
+
+	/*
+	 * Add other attribute related config variables here and to
+	 * Documentation/config/attr.txt.
+	 */
+	return 0;
+}
+
 int git_default_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
@@ -1927,6 +1940,9 @@ int git_default_config(const char *var, const char *value,
 	if (starts_with(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
+	if (starts_with(var, "attr."))
+		return git_default_attr_config(var, value);
+
 	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
 		return git_default_advice_config(var, value);
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 5665cdc079f..e9953ce19c5 100755
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
@@ -342,6 +346,55 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
+
+test_expect_success '--attr-source is bad' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
+		echo "$bad_attr_source_err" >expect_err &&
+		test_must_fail git --attr-source=HEAD check-attr test -- f/path 2>err &&
+		test_cmp expect_err err
+	)
+'
+
+test_expect_success 'attr.tree when HEAD is unborn' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	(
+		cd empty &&
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
@@ -353,6 +406,26 @@ test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
 	test_cmp expect actual
 '
 
+test_expect_success 'precedence of --attr-source, GIT_ATTR_SOURCE, then attr.tree' '
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
+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree --attr-source=attr-source \
+		check-attr test -- f/path >actual &&
+		test_cmp expect actual &&
+		GIT_ATTR_SOURCE=attr-source git -c attr.tree=attr-tree \
+		check-attr test -- f/path >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
-- 
gitgitgadget
