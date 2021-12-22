Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B1C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbhLVOVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245713AbhLVOVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:21:13 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF60C061748
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c66so1689776wma.5
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a6pLplMAAQeTlcrzPDl3fCgT4av+qlYwa5dP/iJQKp0=;
        b=B+cb3fuXmybX3IoSp7ZJP8jI/LFAHyx659vo+UrWi5DrwowmiOQZMpskfi5dDA3Z+x
         VweALsceeGLGbxA+ufbclPEEVBw+VqO+Xq6ro5JBSByuJBdvhmYIFaa3ag7/UoKboTLJ
         1uZaBZLIq9yvNh3AS4gnCdiQoqoEWMjMNPtPyvskmFxT/NMOAR3QA0yC1dSxdMw49jbG
         EkcfzRmXScmopCyAJNm9EpOuDKqwcQbmA5l6itVMeiS3MKOOvzxfkC2eXzxYI+N7s0tD
         e1JY7u343r9n7TLp2YF9Q+oAZ64000XmNzxO7XdhYbT+t1cc0mhOFzQXrC8jeyO6+KS2
         KUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a6pLplMAAQeTlcrzPDl3fCgT4av+qlYwa5dP/iJQKp0=;
        b=Y2p/SMRCRq/SjsnmBQwyV9hOwwsVkY9fNnWUvbwMJ5132+C683pTw+6zjwLgLm0zGZ
         qbTxh5hMeNX2tBfY4N4uuXQxJInrXY7HUfAFakf0PQfhN7S19pRsrmrZEVUiRvhiABrL
         d3DwS9T2bHlddEqAXil6lB/Fas1v/RcyFy46/LjGvMUC52k/wK5FUD/QX8f/lhu7j6wM
         9ugM6VY7SAW1kWcIebnvcX+WIjOr6VIcoRGkOAw52NHZCInjH5D/4GjIZRvPNdD5KxvO
         EM9VDskzt/T6JAts4MTdeDbkeVXHLN/efWVWGCmFOm4KgNLEiwhaRQKW6qwAOPaQGz1N
         xsXg==
X-Gm-Message-State: AOAM532bHHrw1ylMNth4ZsKMem6DUKBg3jo1Ntavf1BDbDLWbqRnLOWx
        QLeWoYLAHItjhjwiP4HttcJ/Yavwn+A=
X-Google-Smtp-Source: ABdhPJyp4lZTv5ttJIqkd94HUg4IZNldwSqvrj3Nelbo3EcTgvxn02gYOE7h/vV7/yNzl79pnJcGkA==
X-Received: by 2002:a05:600c:a0e:: with SMTP id z14mr1071628wmp.43.1640182862274;
        Wed, 22 Dec 2021 06:21:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm1967991wrz.97.2021.12.22.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:21:01 -0800 (PST)
Message-Id: <3efffad814c7183ebe5538c145c4fd263e5a9bca.1640182856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
        <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:20:56 +0000
Subject: [PATCH v4 5/5] test-read-cache: remove --table, --expand options
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
