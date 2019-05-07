Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8147D1F45F
	for <e@80x24.org>; Tue,  7 May 2019 11:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfEGLKi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 07:10:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33954 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfEGLKh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 07:10:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id f7so11425828wrq.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeRI38NTfEfZdl5xjHPCITWpuHwfSn7ieimKFdIBtls=;
        b=AMZJ7q9qopLjEinyO0ojufXkbSU3lI+TP4qaVyYfdA0migUldWpyu/sM2sxir0XbiK
         OVUqWJJhAWCjsVl63d6S7J6YoXAQV6ZXGY0Wob4PdrETW5W3xWwZGEDdwTuv2saIbVNE
         kGgFhn5ecSrWpWkqMADuhV70gCsqt4FP7JVh+fvuq83klTYjpTVsRqQ0TPYnDIYhCkGi
         JNIUoaO0ZTmi9W5tdK5G57gL1cQ4odmNcU/cKat8gaYBnWDljZbBgPp/JVxxOSJ/e7J0
         F952gzxlbsxOT9RzR7Mk7arWH9Y2TCsjjs/r+CGxeINeMJtZQ4cbKGBMcb1Z6SlCj8YK
         BSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeRI38NTfEfZdl5xjHPCITWpuHwfSn7ieimKFdIBtls=;
        b=O2JZRM32PWp/d/8W0YfInifrj+eyIpHtMZAlsPmwZSw/X/lz8KuCK3kgpUG+3Sm+1i
         n+rMLZNHMWHHouRejUur3X5jXG0dgNO4I1RgDmVeK8a1XDdk+JS/cl0qhgKhm1tUMHmy
         m/IyCDow6panNYwVlQG7wYG8vHf11x1GW+t+IoqbIr7zxZiHgBs0rmouCpMZ6zDtKE1/
         GKRh+3HyCyQ8mmUZCCfe5adDUpn0or0umJ2tZuZVke5L306MU1srNfwxRnZ5LPIibv/J
         v1F6QjP7nBr8QMiMqkrBu0ghl2931PRpQZlWHdiX00PEZLXpgIE+mpAPWP4t+b4AVZq8
         WUcw==
X-Gm-Message-State: APjAAAXvp5W5L4l/WU9W/aH5No87R7vIJ/48++DY/kAbz+jUf13nIBDn
        Iz2DXsnLqv/iiShRs7cB9ugIemD8iDE=
X-Google-Smtp-Source: APXvYqwC04QRxeFR+zWxN0PdR3P6AytIsW8ZHK2weZnI0WdI/DxgeimBWgL74KSBFSOAl+5+NqaHIw==
X-Received: by 2002:adf:c788:: with SMTP id l8mr15149848wrg.143.1557227434983;
        Tue, 07 May 2019 04:10:34 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm11246108wre.78.2019.05.07.04.10.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 04:10:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] fsmonitor: force a refresh after the index was discarded
Date:   Tue,  7 May 2019 13:10:21 +0200
Message-Id: <20190507111021.12840-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <pull.165.v2.git.gitgitgadget@gmail.com>
References: <pull.165.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With this change, the `index_state` struct becomes the new home for the
flag that says whether the fsmonitor hook has been run, i.e. it is now
per-index.

It also gets re-set when the index is discarded, fixing the bug
demonstrated by the "test_expect_failure" test added in the preceding
commit. In that case fsmonitor-enabled Git would miss updates under
certain circumstances, see that preceding commit for details.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h                     | 3 ++-
 fsmonitor.c                 | 5 ++---
 read-cache.c                | 1 +
 t/t7519-status-fsmonitor.sh | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index e928fe9d3b..08607ca7f2 100644
--- a/cache.h
+++ b/cache.h
@@ -341,7 +341,8 @@ struct index_state {
 		 initialized : 1,
 		 drop_cache_tree : 1,
 		 updated_workdir : 1,
-		 updated_skipworktree : 1;
+		 updated_skipworktree : 1,
+		 fsmonitor_has_run_once : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	struct object_id oid;
diff --git a/fsmonitor.c b/fsmonitor.c
index 665bd2d425..1dee0aded1 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -129,7 +129,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, const char *n
 
 void refresh_fsmonitor(struct index_state *istate)
 {
-	static int has_run_once = 0;
 	struct strbuf query_result = STRBUF_INIT;
 	int query_success = 0;
 	size_t bol; /* beginning of line */
@@ -137,9 +136,9 @@ void refresh_fsmonitor(struct index_state *istate)
 	char *buf;
 	int i;
 
-	if (!core_fsmonitor || has_run_once)
+	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
 		return;
-	has_run_once = 1;
+	istate->fsmonitor_has_run_once = 1;
 
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 	/*
diff --git a/read-cache.c b/read-cache.c
index d5a74b1861..c66b5c6b26 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2323,6 +2323,7 @@ int discard_index(struct index_state *istate)
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
 	istate->initialized = 0;
+	istate->fsmonitor_has_run_once = 0;
 	FREE_AND_NULL(istate->cache);
 	istate->cache_alloc = 0;
 	discard_split_index(istate);
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index afd8fa7532..81a375fa0f 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -346,7 +346,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 	test_cmp before after
 '
 
-test_expect_failure 'discard_index() also discards fsmonitor info' '
+test_expect_success 'discard_index() also discards fsmonitor info' '
 	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
 	test_might_fail git update-index --refresh &&
 	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
-- 
2.21.0.593.g511ec345e18

