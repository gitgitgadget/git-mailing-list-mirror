Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB58C433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhLHTni (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239706AbhLHTnf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B3FC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:40:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so2566016wmb.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a6pLplMAAQeTlcrzPDl3fCgT4av+qlYwa5dP/iJQKp0=;
        b=Cc8KsF1Cq5swjaqILZ6iEdjDUfJq0xtgGGgwlJT0gvIXSmzlJXYvhD9Sb0G0cSVWyF
         YEIj334WOd1fFOe8t6isGIhcdkbrDGdRivh/oVhA07mxZdsuodwL/WNLnjhl5nBvtM3C
         Qmestem0IzyK4SSig1wUtIEZSJo17KbXBbncBdJGQIh1wHc8hNrxtLG/Lq8n/cvlUsnt
         04eG9jIfXuqtGnF7qo8tkI/VcxtdboAe1WH98dN/lu7F1QSiz4EzaWGtJeXjLotGX940
         ptUfooOd0iAMhvg4Z/TcfBhSgS5CkecYqoE1vL+aikpZBHb4yeDqhEnvHHxcB2yzix+c
         s1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a6pLplMAAQeTlcrzPDl3fCgT4av+qlYwa5dP/iJQKp0=;
        b=R+D+J3ymcLMLw/U+lViI7IG4tDHco1qLCeVUyF5pnyTUEs/nZarQn3cpYyJ1IRKRO3
         HdylFtfBTNJ0QruLCZqTAB2M1j1lrQnHWa9sJM0ih02nUtDeB+lXlBGko4ndfZTMo5C0
         EZhu+5SRY4f/R4YVjmuXFHibIN+1C9vKThCoU+CiBPYrhJ3880XKKde2d7EVwjUjPoXX
         MTuQXw3uXMwhG168NT1iEaiBWTf5BJN0rNwY4nKZBDQZYVBn/c7P236KZiZZ1/e95Ipa
         FUgeoQtI8U/SImRsn7ODnYrNnTB/IcS0uJ3nvoHVZVMWBfu4oPyW/OO7Fde+wzre37o/
         Gsbg==
X-Gm-Message-State: AOAM530RnDLRYX/3E6ZLinH8NQ9ime4N/TZ7KZmcncTi/PHxTFIVgUB5
        OuZ++HRSe1HWEYdH2/HvSXzcpT47lPI=
X-Google-Smtp-Source: ABdhPJyjwuQHzXstd3+LpYlmnr4NSNRh4N+7d7U+wRkiVlst0IUYHi2sJ4iPSKvUSTGAA50vF0kGmA==
X-Received: by 2002:a1c:7f43:: with SMTP id a64mr801918wmd.133.1638992401184;
        Wed, 08 Dec 2021 11:40:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18sm3556881wrs.48.2021.12.08.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:40:00 -0800 (PST)
Message-Id: <f31a24eeb9b2a7e0aca5bd02a02ac95232337d81.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 19:39:55 +0000
Subject: [PATCH v2 5/5] test-read-cache: remove --table, --expand options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This commit effectively reverts 2782db3 (test-tool: don't force full
index, 2021-03-30) and e2df6c3 (test-read-cache: print cache entries
with --table, 2021-03-30) to remove the --table and --expand options
from 'test-tool read-cache'. The previous changes already removed these
options from the test suite in favor of 'git ls-files --sparse'.

The initial thought of creating these options was to allow for tests to
see additional information with every cache entry. In particular, the
object type is still not mirrored in 'git ls-files'. Since sparse
directory entries always end with a slash, the object type is not
critical to verify the sparse index is enabled. It was thought that it
would be helpful to have additional information, such as flags, but that
was not needed for the FS Monitor integration and hasn't been needed
since.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/helper/test-read-cache.c | 64 ++++++--------------------------------
 1 file changed, 10 insertions(+), 54 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 0d9f08931a1..b736ef16421 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,83 +1,39 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
-#include "blob.h"
-#include "commit.h"
-#include "tree.h"
-#include "sparse-index.h"
-
-static void print_cache_entry(struct cache_entry *ce)
-{
-	const char *type;
-	printf("%06o ", ce->ce_mode & 0177777);
-
-	if (S_ISSPARSEDIR(ce->ce_mode))
-		type = tree_type;
-	else if (S_ISGITLINK(ce->ce_mode))
-		type = commit_type;
-	else
-		type = blob_type;
-
-	printf("%s %s\t%s\n",
-	       type,
-	       oid_to_hex(&ce->oid),
-	       ce->name);
-}
-
-static void print_cache(struct index_state *istate)
-{
-	int i;
-	for (i = 0; i < istate->cache_nr; i++)
-		print_cache_entry(istate->cache[i]);
-}
 
 int cmd__read_cache(int argc, const char **argv)
 {
-	struct repository *r = the_repository;
 	int i, cnt = 1;
 	const char *name = NULL;
-	int table = 0, expand = 0;
 
 	initialize_the_repository();
 
-	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
-		if (skip_prefix(*argv, "--print-and-refresh=", &name))
-			continue;
-		if (!strcmp(*argv, "--table"))
-			table = 1;
-		else if (!strcmp(*argv, "--expand"))
-			expand = 1;
+	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
+		argc--;
+		argv++;
 	}
 
-	if (argc == 1)
-		cnt = strtol(argv[0], NULL, 0);
+	if (argc == 2)
+		cnt = strtol(argv[1], NULL, 0);
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 
-	prepare_repo_settings(r);
-	r->settings.command_requires_full_index = 0;
-
 	for (i = 0; i < cnt; i++) {
-		repo_read_index(r);
-
-		if (expand)
-			ensure_full_index(r->index);
-
+		read_cache();
 		if (name) {
 			int pos;
 
-			refresh_index(r->index, REFRESH_QUIET,
+			refresh_index(&the_index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos = index_name_pos(r->index, name, strlen(name));
+			pos = index_name_pos(&the_index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
-			       ce_uptodate(r->index->cache[pos]) ? "" : " not");
+			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
-		if (table)
-			print_cache(r->index);
-		discard_index(r->index);
+		discard_cache();
 	}
 	return 0;
 }
-- 
gitgitgadget
