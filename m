Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7470E7C4E7
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 18:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjJDSSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjJDSSa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 14:18:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F270BF
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 11:18:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so130389f8f.3
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696443503; x=1697048303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zLkouxQ8uIAcXIsnxRd/ch5Qk5tIZ/NPnI+/iSnVhU=;
        b=jFwDHJrma5Itd6+GBRNQqJRR1gB8WUq8CANYZVcOCtkXUrwOJhKWrfJP0HLOmZ/LSJ
         dGT8E8O5qWkw4vPXu/JbIUEzeoC5X6Id+gieVn1tUzU0udq5mWqaPZ0UVGqaeLzQhq+J
         CVuUUCtmWkaF7SSJ3dO4JsR4TmaSiwepi0rs22RJ+A0pk2j+ylCy86UAJVE2o8IZG6Mw
         gCDWhTuofjTN5SQ8xVb9HjTF4sQFp8KA0wpMMUa1FnKHMKfE2jd14wblEcFrh5YHqh/L
         B4Ms2qn/b17WglRFgts+ca76L8M90rm6CPNBeN6VBCIBoDnuQd0xKu/HzXa0sqYh4GfX
         /3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443503; x=1697048303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zLkouxQ8uIAcXIsnxRd/ch5Qk5tIZ/NPnI+/iSnVhU=;
        b=Pj1FGJBIQkXWBkp0yAEKSTALn/tG5l8DBmAzf0qM0zLKfyMl08iNaWxI+Tf5VTKJ24
         +E1++ePIwiuEOvKDms2Nf2Rlj09UJdIKbQMNH3FCZuF86vw3zCYpT8u2N5M1VQsbhbXd
         qlKEPSR8Z7naJGlrJWWsHMU0cxgE4ch4/5GR6y/pAGOD7QlmnmZTQXjI/oVJ6TZGVhlC
         nJA9560fQ7zBD264P+UtdVR+ZCt8N2MKBevwJ2v78xL2ctwuaG5F7RTtHTzCDZ6s6Vxd
         P36eOoMc917KgpiLU6WSWRF1dbhNZJwcL+j70vQN00bngQPUmf4YJZmMu7uSlBU6MDNK
         3G6w==
X-Gm-Message-State: AOJu0YzwgWEEIJRS7uOM8sNZmoBfidfqN66Hm/rEDBAwNHtcDJWGHsLP
        rYvk9Sm5KmWOFXFUzLxxybjlHV81zjg=
X-Google-Smtp-Source: AGHT+IH46Y7C4Xd28mZWkKsllHWQQtRctdYVjl0uwOwNY+lhyW8oMT6sT0L663IcZotaDaZJsQJBug==
X-Received: by 2002:a5d:6d41:0:b0:323:2f54:b6cb with SMTP id k1-20020a5d6d41000000b003232f54b6cbmr3007299wri.8.1696443503314;
        Wed, 04 Oct 2023 11:18:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y22-20020a1c4b16000000b0040642a1df1csm2065905wma.25.2023.10.04.11.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:18:23 -0700 (PDT)
Message-ID: <446bce03a96836f35f94e9ef8548cf4a2b041ba8.1696443502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
        <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Oct 2023 18:18:20 +0000
Subject: [PATCH v2 1/2] attr: add attr.tree for setting the treeish to read
 attributes from
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

44451a2e5e (attr: teach "--attr-source=<tree>" global option to "git",
2023-05-06) provided the ability to pass in a treeish as the attr
source. In the context of serving Git repositories as bare repos like we
do at GitLab however, it would be easier to point --attr-source to HEAD
for all commands by setting it once.

Add a new config attr.tree that allows this.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/config.txt      | 2 ++
 Documentation/config/attr.txt | 5 +++++
 attr.c                        | 7 +++++++
 t/t0003-attributes.sh         | 4 ++++
 4 files changed, 18 insertions(+)
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
index 00000000000..e4f2122b7ab
--- /dev/null
+++ b/Documentation/config/attr.txt
@@ -0,0 +1,5 @@
+attr.tree:
+	A <tree-ish> to read gitattributes from instead of the worktree. See
+	linkgit:gitattributes[5]. This is equivalent to setting the
+	`GIT_ATTR_SOURCE` environment variable, or passing in --attr-source to
+	the Git command.
diff --git a/attr.c b/attr.c
index 71c84fbcf86..bb0d54eb967 100644
--- a/attr.c
+++ b/attr.c
@@ -1205,6 +1205,13 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
+	if (!default_attr_source_tree_object_name) {
+		char *attr_tree;
+
+		if (!git_config_get_string("attr.tree", &attr_tree))
+			default_attr_source_tree_object_name = attr_tree;
+	}
+
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 26e082f05b4..6342187c751 100755
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
-- 
gitgitgadget

