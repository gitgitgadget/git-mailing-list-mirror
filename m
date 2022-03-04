Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955ABC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiCDSdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbiCDSdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F4E3FDB7
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p9so13898640wra.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9//+k9SfTqwxhT71nQjqhDppNQ3ZvSgxqqfIXNVqlg=;
        b=S+y3+RJ4yznMnbR5swSloyaXQ2V/ZLqBvYvKrVL8qRC4nXmd3IXVMiGL2LgxAUoQj8
         bP7J9umDIDtf5l3InPIQEywr6wVZugzhQ43MSe/1vW23q4bU+GsVjLJVNdmSbH+aK5OX
         qJf8R82mToDYlxsoNS8vgaJ6Vo26zJDyJ4yykTIwCbBB6TKlnC92tNzuAY1qvXQ4GZVJ
         /BMRssaZFfLcfqp0yUY72OfRXuH+MF1iuUt4MLfo762tE0g1dL5WoeChBN68T5jCdYRX
         /+CYn0Gv7P4PUFTHNkYLtizUeQWon+TO8Oyq+w5L6MIbB6sqXSNw7vHkM6MUt1vLC0sJ
         1fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9//+k9SfTqwxhT71nQjqhDppNQ3ZvSgxqqfIXNVqlg=;
        b=N3HqTEHhcCNs1mHoKxYDtIsZHDX/9nzZSFAWd8ep4kMl05Y3leS/zPjcrsX3SEYsiI
         2I1SmA7R7G6ivg8Dd+jik2yB6X0hI7L1luebZ4Jimi1cNqqYysrjtY5cnAo9uElOiIm1
         SnLgZ0YtlN7GzCgTmad/09Wvnuq5wct/goxq0eAn/5IHsqGua6/eiYgl8kFHqs+dZ2WJ
         VGjpJjubjZDKiAVGWOWXJ5t0DKzuNnn/Z93yQefKQS04JSJE4YLFj6TdN3T/4aKS7BV3
         Ja3OiUBnrRJPtc1NgsZubmrDtUg5t5u4HpSHpNqWScO0dU2rTfhbAwrQ/WRBKQQziYG1
         c0Wg==
X-Gm-Message-State: AOAM532NCGddCsG3vhXZidfBi5GAYEKGFrK51RG+RCPuRuJ56I7mSi8x
        bHHQBz+CyUsYVWAgW7XLWYFAkztsSU5f/w==
X-Google-Smtp-Source: ABdhPJwJfBMNFfHITWn3zI3UItUAPWZEWAV9mX57Dh1ELkqrk2i4KbROWY9NxKfEINki94DpwK4nwA==
X-Received: by 2002:adf:f9c6:0:b0:1ef:832d:58fa with SMTP id w6-20020adff9c6000000b001ef832d58famr41330wrr.378.1646418750579;
        Fri, 04 Mar 2022 10:32:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/14] commit-graph: fix memory leak in misused string_list API
Date:   Fri,  4 Mar 2022 19:32:12 +0100
Message-Id: <patch-v2-09.14-3fadb265d13-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
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
2.35.1.1248.gb68c9165ad8

