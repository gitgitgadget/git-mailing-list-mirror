Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036A8E7C4E9
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjJDSSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjJDSSa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 14:18:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6670A7
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 11:18:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32336a30d18so132558f8f.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696443504; x=1697048304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBBGcxISST1P9ReGHJjUt9XfMzQN41CQCCAMvugdggs=;
        b=BQtmi+ABUhqomML6fdbGlhYRxQrA6lPPO4TCcAh+C9qkoJQodCOtAEO8iaUWxGQEoF
         /DqHuuAcPHREgQRRahRytSpBmDj+6PyvQrowJCWL6YkGhsNrZYus9Ck3WX1m126xmrge
         H+7lUdG8IA/cvEYv+s0mX79GvbVRsulCstAcHcIwGuapEU1ISqG5zL1rKXa5TQvXIhdQ
         GcYWnVuwF5I0BF2+xfQyUGL18Y9oDLLxirub1YPe2Q24ShV0wFK6hwvmTPW690CmJdnm
         3Zsq0bjn70aHK0/6STl4OnrP3n25VghnUyyUU/Ju+04nidZpECWzrmsbSE0i81foDNRf
         tcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443504; x=1697048304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBBGcxISST1P9ReGHJjUt9XfMzQN41CQCCAMvugdggs=;
        b=oPghe1JxxbdZaF24o5OPpPYbfj7VASYyEhEfayj4K43aTMyjvcJmZG/0diTQmTrpN1
         DwYp2aLCejkKBRLfv9Z0Dx9b6UjikPNcsPAql//rroofvLUIzR/+R/GoKktbTlfZi0me
         jTohOd/+cb8rbBFl+NALiqYUYvP41dKv/el50lAmyS9PivsE6HBuBFkhHQxB5hNjQ1yh
         zD99TPOfSYgA6cW93SXsAo330vo6WVf3BHjmUsx7xZ7yZcQMy+6Cuut5PUphLzfXlCTG
         EiO1nlqs4rXM3ulQO2KCBQBfHh5kJCts93U5V+0ixHb+ELakNvq65Hr/WYnIJqeaDiND
         AcUQ==
X-Gm-Message-State: AOJu0YzJHEMHXVHD+MHIFwqlAm7xmX6TmpX4TFIp83Hx4IcA8p3wB4ND
        be4SVn7rM382Kol0CC1SGMNQof/AsbE=
X-Google-Smtp-Source: AGHT+IFfZfK9BTqpYm8zLclD1KNGZE59CUAs2yMY7Hbq4tSikwcCkKInc1camzrj7fpTjsnZEhmEMg==
X-Received: by 2002:adf:f546:0:b0:317:634c:46e9 with SMTP id j6-20020adff546000000b00317634c46e9mr3021512wrp.43.1696443504178;
        Wed, 04 Oct 2023 11:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d570c000000b00327bf4f2f16sm4523167wrv.30.2023.10.04.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:18:23 -0700 (PDT)
Message-ID: <52d9e1803526bf1f267d23f6ef163049f8be77b7.1696443502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
        <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 18:18:21 +0000
Subject: [PATCH v2 2/2] attr: add attr.allowInvalidSource config to allow
 invalid revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The previous commit provided the ability to pass in a treeish as the
attr source via the attr.tree config. The default behavior is that when
a revision does not resolve to a valid tree is passed, Git will die.

When HEAD is unborn however, it does not point to a valid treeish,
causing Git to die. In the context of serving repositories through bare
repositories, we'd like to be able to set attr.tree to HEAD and allow
cases where HEAD does not resolve to a valid tree to be treated as if
there were no treeish provided.

Add attr.allowInvalidSource that allows this.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/config/attr.txt |  7 ++++++
 attr.c                        | 16 ++++++++++---
 t/t0003-attributes.sh         | 45 +++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/attr.txt b/Documentation/config/attr.txt
index e4f2122b7ab..00113a4950e 100644
--- a/Documentation/config/attr.txt
+++ b/Documentation/config/attr.txt
@@ -3,3 +3,10 @@ attr.tree:
 	linkgit:gitattributes[5]. This is equivalent to setting the
 	`GIT_ATTR_SOURCE` environment variable, or passing in --attr-source to
 	the Git command.
+
+attr.allowInvalidSource::
+	If `attr.tree` cannot resolve to a valid tree object, ignore
+	`attr.tree` instead of erroring out, and fall back to looking for
+	attributes in the default locations. Useful when passing `HEAD` into
+	`attr-source` since it allows `HEAD` to point to an unborn branch in
+	cases like an empty repository.
diff --git a/attr.c b/attr.c
index bb0d54eb967..1a7ac39b9d1 100644
--- a/attr.c
+++ b/attr.c
@@ -1202,21 +1202,31 @@ void set_git_attr_source(const char *tree_object_name)
 
 static void compute_default_attr_source(struct object_id *attr_source)
 {
+	int attr_source_from_config = 0;
+
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
 	if (!default_attr_source_tree_object_name) {
 		char *attr_tree;
 
-		if (!git_config_get_string("attr.tree", &attr_tree))
+		if (!git_config_get_string("attr.tree", &attr_tree)) {
+			attr_source_from_config = 1;
 			default_attr_source_tree_object_name = attr_tree;
+		}
 	}
 
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
 
-	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
-		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source)) {
+		int allow_invalid_attr_source = 0;
+
+		git_config_get_bool("attr.allowinvalidsource", &allow_invalid_attr_source);
+
+		if (!(allow_invalid_attr_source && attr_source_from_config))
+			die(_("bad --attr-source or GIT_ATTR_SOURCE"));
+	}
 }
 
 static struct object_id *default_attr_source(void)
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 6342187c751..972b64496e7 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -346,6 +346,51 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+bad_attr_source_err="fatal: bad --attr-source or GIT_ATTR_SOURCE"
+
+test_expect_success 'attr.allowInvalidSource when HEAD is unborn' '
+	test_when_finished rm -rf empty &&
+	echo $bad_attr_source_err >expect_err &&
+	echo "f/path: test: unspecified" >expect &&
+	git init empty &&
+	test_must_fail git -C empty --attr-source=HEAD check-attr test -- f/path 2>err &&
+	test_cmp expect_err err &&
+	git -C empty -c attr.tree=HEAD -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attr.allowInvalidSource when --attr-source points to non-existing ref' '
+	test_when_finished rm -rf empty &&
+	echo $bad_attr_source_err >expect_err &&
+	echo "f/path: test: unspecified" >expect &&
+	git init empty &&
+	test_must_fail git -C empty --attr-source=refs/does/not/exist check-attr test -- f/path 2>err &&
+	test_cmp expect_err err &&
+	git -C empty -c attr.tree=refs/does/not/exist -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bad attr source defaults to reading .gitattributes file' '
+	test_when_finished rm -rf empty &&
+	git init empty &&
+	echo "f/path test=val" >empty/.gitattributes &&
+	echo "f/path: test: val" >expect &&
+	git -C empty -c attr.tree=HEAD -c attr.allowInvalidSource=true check-attr test -- f/path >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'attr.allowInvalidSource has no effect on --attr-source' '
+	test_when_finished rm -rf empty &&
+	echo $bad_attr_source_err >expect_err &&
+	echo "f/path: test: unspecified" >expect &&
+	git init empty &&
+	test_must_fail git -C empty -c attr.allowInvalidSource=true --attr-source=HEAD check-attr test -- f/path 2>err &&
+	test_cmp expect_err err
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
-- 
gitgitgadget
