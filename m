Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F565C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiF3Xr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiF3Xr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0625A2CA
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so2263671wmc.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OsPGENTKHs5bzDrHeTEPAeEdPzXOYnlBf1UuGT8M80=;
        b=lqc0KqB79ClorzxaO65M05lTZlv7gQX4JCdWh8F85+8jlPzICRFSkn5vv9FQAkUe9h
         nSaKsnH7Nsg97iacr9/X7BiIy6eGNLgr+O38ALlnllRUy3sMIDLN0aaGYhH5tcmva9E+
         rr5OU0pxvnlzHR3Pn/4ulUNhRg+vphHgwrJx6JEb46bUM1NKsW7ubHJUVms9qX2uTV/5
         Qey7vLAfhiEgh/FCBU+yZb2d+bSwjLRE4EgjOEmnvRvgwwpJS2wLjqNwF3XKpl1yj51d
         gnXKJP5Ih1yYdozo4PpsqfrNxYbhsBew94s72f5yRfEDheMD5xVWc+h3/WlAcxlubc3Q
         pdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OsPGENTKHs5bzDrHeTEPAeEdPzXOYnlBf1UuGT8M80=;
        b=1SQYNcyD51HBb1cPh24PQF/XwbK6DY2qFufinUeDZEtJQLuiYnTpElUWBbKg9tViHU
         pPz3Kf36die8lKXh9QYejxfWreUq11Bym357u99aX5Oiyini464eHgSapTtwYEm14C/q
         lXzxs3AUnmOKfnVqZN583F3KUhW4ADBvXowlsy5tQ9LjaPSQEHbEkx+Y13qQkPy/+iv1
         KVqc6BC/a3AfYBrsbYlwN6n6cH3ki48dnDUSuWXcFqXJOXrIb11ObvowLF3i5ylYt5Vk
         osBxybmwUOD2ueSgTwkNppgkra2LvxzxCiPcgfZLXqMyZKX5ZZ2FsD86VPKGlZTmGiW/
         xIRA==
X-Gm-Message-State: AJIora/TyQ3RSliMn0QauDLhwaTdFoqjwmGuZfaUJHXejYTehRNPWdQu
        Cj31pk/DDj6c12VAkBUPBYfc+rlrQUEEhA==
X-Google-Smtp-Source: AGRyM1tpGP2hk6yWYVmtK8shWz1buH+wCRoRNeCpeKpBGS+ktER1/cs31qRH82CjZx4b4/vofB/lwg==
X-Received: by 2002:a05:600c:3c8a:b0:3a0:4ad8:d3c4 with SMTP id bg10-20020a05600c3c8a00b003a04ad8d3c4mr14801519wmb.43.1656632839119;
        Thu, 30 Jun 2022 16:47:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/9] test-tool {dump,scrap}-cache-tree: fix memory leaks
Date:   Fri,  1 Jul 2022 01:47:03 +0200
Message-Id: <patch-3.9-7a0064860ad-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in two test-tools used by t0090-cache-tree.sh. As a
result we can mark the test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-dump-cache-tree.c  | 7 ++++++-
 t/helper/test-scrap-cache-tree.c | 1 +
 t/t0090-cache-tree.sh            | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 6a3f88f5f5d..0d6d7f1ecbf 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -59,11 +59,16 @@ int cmd__dump_cache_tree(int ac, const char **av)
 {
 	struct index_state istate;
 	struct cache_tree *another = cache_tree();
+	int ret;
+
 	setup_git_directory();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	istate = the_index;
 	istate.cache_tree = another;
 	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
-	return dump_cache_tree(active_cache_tree, another, "");
+	ret = dump_cache_tree(active_cache_tree, another, "");
+	cache_tree_free(&another);
+
+	return ret;
 }
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 393f1604ff9..026c802479d 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -12,6 +12,7 @@ int cmd__scrap_cache_tree(int ac, const char **av)
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
 	if (read_cache() < 0)
 		die("unable to read index file");
+	cache_tree_free(&active_cache_tree);
 	active_cache_tree = NULL;
 	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 90675726484..d8e2fc42e15 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -5,6 +5,8 @@ test_description="Test whether cache-tree is properly updated
 Tests whether various commands properly update and/or rewrite the
 cache-tree extension.
 "
+
+TEST_PASSES_SANITIZE_LEAK=true
  . ./test-lib.sh
 
 cmp_cache_tree () {
-- 
2.37.0.874.g7d3439f13c4

