Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E38781F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbeGRPyE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:04 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42262 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730776AbeGRPyE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:04 -0400
Received: by mail-pl0-f68.google.com with SMTP id z7-v6so411845plo.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=SGro05LNHnahju8vS9Y6ifkUMKeSWYIiyRm640kgVUU=;
        b=c0pt0AFb2m0GSfNX7HJR9hBSo/rYinhvAcmUZCJnMORBPBcPv5/wPthu94Vs2d+yPn
         gDvBgqMo3zFcWTqm1kfnC59+dufdg9EHwiChqm3nG0BgfjaTmrp/zF5WthKTWo2kVYQ4
         sXtkkaGGf2dwDRqXtSH3iVUGyoto6sYFBUlYY16yzqR/wy2mp+2P1ue0j0+1nS7V2Bm4
         wZAOZEE/XLTa9HjWSSTgC/TgZngQ0EpnRIomYHFBW2fsTlRBcU9VYaTELNprD47MrhZq
         qrceEIIXZYLiXkWuiGXjtdaprstdrlWyocdqxpOUvov7LEJtlX+g/9V3jCYyGsBGtdGZ
         2t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=SGro05LNHnahju8vS9Y6ifkUMKeSWYIiyRm640kgVUU=;
        b=WWbcgRbql2tahxnypJ6ElqMLPd6FXRtLLRvxcx07GyEdd0fyh+WhxBO+inXZSDeSKE
         uZYnEluC9ZrekINKXGY4OF+MdUiHhALR72BEoY5sF9sRmlp0yfe7ATA+xqO7QjeoLPOd
         BEG7FD9mYFTZHgOwb9edR5Vm39nq1JECYwgNSk1t7T2a9cxUrGD843v3QQpkpf70Xu7q
         y82kixBR89w5k7yE6WJ5Bm163SiRT9PHrZTWRy0iuoYT9O9RXHOsAxS0bZJF6FWh+ULf
         jK2RcNmUfJUpN6WNV2pCDxGMzon0XquCj/gaihindAmF1aep8kVv0udzm2YqVuaMzs1U
         QJXA==
X-Gm-Message-State: AOUpUlHpT7+KByu/tQCxGXI7tdce1e9bmlXCs+KOmjNwLrX8tDwsPutG
        XB9/vpuknE6gyWpN+mrpkb3+0LAP
X-Google-Smtp-Source: AAOMgpdXy2MhdcEyijAXqitipiTsB1g19EmlkJRL7FYD0jH2iLtjA4x4b6oea9n51N1zTroa8dPeBQ==
X-Received: by 2002:a17:902:bb90:: with SMTP id m16-v6mr6310325pls.50.1531926942370;
        Wed, 18 Jul 2018 08:15:42 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id u71-v6sm7402613pfk.174.2018.07.18.08.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:41 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:41 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:28 GMT
Message-Id: <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/8] commit-graph: not compatible with replace objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Create new method commit_graph_compatible(r) to check if a given
repository r is compatible with the commit-graph feature. Fill the
method with a check to see if replace-objects exist. Test this
interaction succeeds, including ignoring an existing commit-graph and
failing to write a new commit-graph.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          | 17 +++++++++++++++++
 replace-object.c        |  2 +-
 replace-object.h        |  2 ++
 t/t5318-commit-graph.sh | 22 ++++++++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index b0a55ad12..711099858 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -13,6 +13,8 @@
 #include "commit-graph.h"
 #include "object-store.h"
 #include "alloc.h"
+#include "hashmap.h"
+#include "replace-object.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -56,6 +58,15 @@ static struct commit_graph *alloc_commit_graph(void)
 	return g;
 }
 
+static int commit_graph_compatible(struct repository *r)
+{
+	prepare_replace_object(r);
+	if (hashmap_get_size(&r->objects->replace_map->map))
+		return 0;
+
+	return 1;
+}
+
 struct commit_graph *load_commit_graph_one(const char *graph_file)
 {
 	void *graph_map;
@@ -223,6 +234,9 @@ static int prepare_commit_graph(struct repository *r)
 		 */
 		return 0;
 
+	if (!commit_graph_compatible(r))
+		return 0;
+
 	obj_dir = r->objects->objectdir;
 	prepare_commit_graph_one(r, obj_dir);
 	prepare_alt_odb(r);
@@ -693,6 +707,9 @@ void write_commit_graph(const char *obj_dir,
 	int num_extra_edges;
 	struct commit_list *parent;
 
+	if (!commit_graph_compatible(the_repository))
+		return;
+
 	oids.nr = 0;
 	oids.alloc = approximate_object_count() / 4;
 
diff --git a/replace-object.c b/replace-object.c
index 017f02f8e..4d2d84cf4 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -32,7 +32,7 @@ static int register_replace_ref(struct repository *r,
 	return 0;
 }
 
-static void prepare_replace_object(struct repository *r)
+void prepare_replace_object(struct repository *r)
 {
 	if (r->objects->replace_map)
 		return;
diff --git a/replace-object.h b/replace-object.h
index f996de3d6..c7a99fc35 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -10,6 +10,8 @@ struct replace_object {
 	struct object_id replacement;
 };
 
+void prepare_replace_object(struct repository *r);
+
 /*
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4f17d7701..c90626f5d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -259,6 +259,28 @@ test_expect_success 'check that gc computes commit-graph' '
 	test_cmp commit-graph-after-gc $objdir/info/commit-graph
 '
 
+test_expect_success 'replace-objects invalidates commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	test_when_finished rm -rf replace &&
+	git clone full replace &&
+	(
+		cd replace &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph &&
+		git replace HEAD~1 HEAD~2 &&
+		git -c core.commitGraph=false log >expect &&
+		git -c core.commitGraph=true log >actual &&
+		test_cmp expect actual &&
+		git commit-graph write --reachable &&
+		git -c core.commitGraph=false --no-replace-objects log >expect &&
+		git -c core.commitGraph=true --no-replace-objects log >actual &&
+		test_cmp expect actual &&
+		rm -rf .git/objects/info/commit-graph &&
+		git commit-graph write --reachable &&
+		test_path_is_missing .git/objects/info/commit-graph
+	)
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
-- 
gitgitgadget

