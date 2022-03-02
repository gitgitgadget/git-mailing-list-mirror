Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02DC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiCBRLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243675AbiCBRLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0396EC681C
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i83-20020a1c3b56000000b00386f2897400so275495wma.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/xDviJ1M29vy1LjHsVAMaCCqMy+H2Pt9WxlSYbD0E0=;
        b=D+ifcwGLYI9JXAJycQM/FfWymz7qWqApU7uIFkGxCouh71TxjMfj+7BBSHSHELfv4K
         BrvEnneCMWMDpi1CrO6EMVDsP/bDm1XVl5/YSHMkthFhup5k/twLqr88eQTdNtYAzQp2
         oeX1mT/3qoAysTbYUFjLGGAL2cc4ESCL1rcLfKxGIcNk0VVVc9Pm1w/1ekdq+4I54pS6
         G9QdMbUZ6ybIm4Hm8kRakA1+xR/9o58rvcHDrRyA0Ot4vma4/IMD4KQYKvhGC2kGIZB7
         lF+ZtMO4W9g3ZtS4dMnaBdsRb6HVGsVU9wiQUFo60+MvjTRvzCYpDbV2OYiGXsh7thsY
         8jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/xDviJ1M29vy1LjHsVAMaCCqMy+H2Pt9WxlSYbD0E0=;
        b=iaU85rAr2zLaCeGCF4h/q4/Zav8UnHh3jpcuA/pqh1EPDTdkBPTUANSyG7gFNuzLdy
         QxSnHpfAHnUYK17hhCIqkHOrUtS9ABrJsIIVt0yjKtwtmnAQkaM2Tn7emWbZbvyOWHwd
         4CTounG/dOt94KNGnsLo9O7xjgcz5Fb3OSKiYgr9yDpmX4De5SrJgPKmiO7YHlo/oOKC
         FjUWhUIIVjPliB5UT13HYxK0TT4bffA3FDkNIliND0M35o8ol6p6esBYX0BzdNJFRxUG
         rLyXTmfzUnp+yo8EKeK4dKhXb9uC/HaskNqkZBQb1iyWLMO6gdmXamWyzfDyWcBas25z
         slJA==
X-Gm-Message-State: AOAM532ixhjWlUweUFiG7kY9lY57Hl6ZmSm8xKcwAnDNwMdIjLeseh8D
        vYFVijjkoUe6hO+3w25AVdFwbz/lExoaaQ==
X-Google-Smtp-Source: ABdhPJyjyAovKRJn1BUf3zyITKT518HtPcKEFWn7gnxG3bQ4W1fy76RwwL/S5CVbZqGmdV3A2lXu0w==
X-Received: by 2002:a1c:6a14:0:b0:383:a58c:3635 with SMTP id f20-20020a1c6a14000000b00383a58c3635mr594185wmc.129.1646241032194;
        Wed, 02 Mar 2022 09:10:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/14] commit-graph: fix memory leak in misused string_list API
Date:   Wed,  2 Mar 2022 18:10:15 +0100
Message-Id: <patch-09.14-b5512deb26f-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When this code was migrated to the string_list API in
d88b14b3fd6 (commit-graph: use string-list API for input, 2018-06-27)
it was made to use used both STRING_LIST_INIT_NODUP and a
strbuf_detach() pattern.

Those should not be used together if string_list_clear() is expected
to free the memory, instead we need to either use STRING_LIST_INIT_DUP
with a string_list_append_nodup(), or a STRING_LIST_INIT_NODUP and
manually fiddle with the "strdup_strings" member before calling
string_list_clear(). Let's do the former.

Since "strdup_strings = 1" is set now other code might be broken by
relying on "pack_indexes" not to duplicate it strings, but that
doesn't happen. When we pass this down to write_commit_graph() that
code uses the "struct string_list" without modifying it. Let's add a
"const" to the variable to have the compiler enforce that assumption.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 6 +++---
 commit-graph.c         | 4 ++--
 commit-graph.h         | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 4247fbde95a..51c4040ea6c 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -192,7 +192,7 @@ static int git_commit_graph_write_config(const char *var, const char *value,
 
 static int graph_write(int argc, const char **argv)
 {
-	struct string_list pack_indexes = STRING_LIST_INIT_NODUP;
+	struct string_list pack_indexes = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 	struct oidset commits = OIDSET_INIT;
 	struct object_directory *odb = NULL;
@@ -273,8 +273,8 @@ static int graph_write(int argc, const char **argv)
 
 	if (opts.stdin_packs) {
 		while (strbuf_getline(&buf, stdin) != EOF)
-			string_list_append(&pack_indexes,
-					   strbuf_detach(&buf, NULL));
+			string_list_append_nodup(&pack_indexes,
+						 strbuf_detach(&buf, NULL));
 	} else if (opts.stdin_commits) {
 		oidset_init(&commits, 0);
 		if (opts.progress)
diff --git a/commit-graph.c b/commit-graph.c
index 265c010122e..d0c94600bab 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1679,7 +1679,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 }
 
 static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
-				struct string_list *pack_indexes)
+				const struct string_list *pack_indexes)
 {
 	uint32_t i;
 	struct strbuf progress_title = STRBUF_INIT;
@@ -2259,7 +2259,7 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 }
 
 int write_commit_graph(struct object_directory *odb,
-		       struct string_list *pack_indexes,
+		       const struct string_list *const pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_opts *opts)
diff --git a/commit-graph.h b/commit-graph.h
index 04a94e18302..2e3ac35237e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -142,7 +142,7 @@ int write_commit_graph_reachable(struct object_directory *odb,
 				 enum commit_graph_write_flags flags,
 				 const struct commit_graph_opts *opts);
 int write_commit_graph(struct object_directory *odb,
-		       struct string_list *pack_indexes,
+		       const struct string_list *pack_indexes,
 		       struct oidset *commits,
 		       enum commit_graph_write_flags flags,
 		       const struct commit_graph_opts *opts);
-- 
2.35.1.1228.g56895c6ee86

