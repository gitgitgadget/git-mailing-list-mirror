Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE358CDB467
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 17:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjJKRNt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKRNr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 13:13:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A19C9D
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:13:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so33226f8f.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697044424; x=1697649224; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jP8p/CibwC5H5pEKwg8txpt9pKLJR7/n27kSWKf2ng=;
        b=YoRNkWk5D3zRnsdwyFTsOSzcoLphrMuZR16oBH0PdSvMLzgQMk6KxaoiQhcu5EK59w
         66IIkpgGGjEUkuj9IAKYmK8pGO8K31/WlWilJo9X9Z0afCho4h1kOzXfNxbm/WpI30wm
         AmX4lAEK9ca2IbU2HpREatK3SEqhezEFLuhEzIoNLpmGg1UGw6BkWsluYsTn6WpH33pj
         yly5AQyi0O49QJ/R1EqboL5LDLyxZ7hfu4/tsARLcqxb5vjsE1pZVofnYOjtZuA9ejnb
         DX+f55CYnX3HSuDDLBJH+K3QyZajUxFBh38lwWUbxppPyroXh/QgDpSGrScp1ogbT8gL
         RLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697044424; x=1697649224;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jP8p/CibwC5H5pEKwg8txpt9pKLJR7/n27kSWKf2ng=;
        b=UNp0Di0du/9hBNUH1/w09kCr1SyDuRTA77iCy59xgZxBDzZ8WsVv1gB/qP0cGchH75
         SLDEivd+d1LDg+cYoYKwhIHWjiIX/au3YS3G+cqVjLp03KyyiCVM8AbqCHd5m9b4wFQZ
         Zd1sKTr/hCgKSPmYwadDLaXvfgzdimpdWuZ71UuxD7UZBuiycRqYHEozBzncPXtDFoFf
         XZiOdblUpuSbzhyDam20FWOgbG6e8NIBBKWRVWXtO9BiGESB4+/+pAOwG7HV2ZFTJFit
         YkBlCK4e0zfomAtjHEuPBRw2+Pd0wmxVzEYeqZZqrtnzGCYXKamkxUPc39oNeK8eyhS3
         RI0w==
X-Gm-Message-State: AOJu0YwFhC0bO40OFNWZ+XEgt0TIukZsTJudOSuiG0Cr7HW/sZccWzkZ
        WnUYc1zqkivgJoJk41w9gvK76/toiNM=
X-Google-Smtp-Source: AGHT+IHPF/QFlUmQhy4ipvDvXFoV8fIC+PvvNFldHNBpahvW+HV+UWTucp3FBcKrxhmkZ8Ac9yI5Xw==
X-Received: by 2002:adf:fe82:0:b0:32d:6891:f819 with SMTP id l2-20020adffe82000000b0032d6891f819mr4266508wrr.41.1697044424320;
        Wed, 11 Oct 2023 10:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b004068def185asm17686932wms.28.2023.10.11.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:13:44 -0700 (PDT)
Message-ID: <eaa27c478105606b39917bdadbdcfdce2b1b3521.1697044422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
References: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
        <pull.1577.v4.git.git.1697044422.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Oct 2023 17:13:41 +0000
Subject: [PATCH v4 1/2] attr: read attributes from HEAD when bare repo
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

The motivation for 44451a2e5e (attr: teach "--attr-source=<tree>" global
option to "git" , 2023-05-06), was to make it possible to use
gitattributes with bare repositories.

To make it easier to read gitattributes in bare repositories however,
let's just make HEAD:.gitattributes the default. This is in line with
how mailmap works, 8c473cecfd (mailmap: default mailmap.blob in bare
repositories, 2012-12-13).

Signed-off-by: John Cai <johncai86@gmail.com>
---
 attr.c                  | 12 +++++++++++-
 t/t0003-attributes.sh   | 11 +++++++++++
 t/t5001-archive-attr.sh |  2 +-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 71c84fbcf86..bf2ea1626a6 100644
--- a/attr.c
+++ b/attr.c
@@ -1194,6 +1194,7 @@ static void collect_some_attrs(struct index_state *istate,
 }
 
 static const char *default_attr_source_tree_object_name;
+static int ignore_bad_attr_tree;
 
 void set_git_attr_source(const char *tree_object_name)
 {
@@ -1205,10 +1206,19 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
+	if (!default_attr_source_tree_object_name &&
+	    startup_info->have_repository &&
+	    is_bare_repository()) {
+		default_attr_source_tree_object_name = "HEAD";
+		ignore_bad_attr_tree = 1;
+	}
+
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
 
-	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
+	if (repo_get_oid_treeish(the_repository,
+				 default_attr_source_tree_object_name,
+				 attr_source) && !ignore_bad_attr_tree)
 		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
 }
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 26e082f05b4..5665cdc079f 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -342,6 +342,17 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+
+test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
+	test_when_finished rm -rf test bare_with_gitattribute &&
+	git init test &&
+	test_commit -C test gitattributes .gitattributes "f/path test=val" &&
+	git clone --bare test bare_with_gitattribute &&
+	echo "f/path: test: val" >expect &&
+	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 0ff47a239db..eaf959d8f63 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -138,7 +138,7 @@ test_expect_success 'git archive with worktree attributes, bare' '
 '
 
 test_expect_missing	bare-worktree/ignored
-test_expect_exists	bare-worktree/ignored-by-tree
+test_expect_missing	bare-worktree/ignored-by-tree
 test_expect_exists	bare-worktree/ignored-by-worktree
 
 test_expect_success 'export-subst' '
-- 
gitgitgadget

