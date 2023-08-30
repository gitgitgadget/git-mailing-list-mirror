Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A4C83F1D
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjH3S30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343752AbjH3QoY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100F119A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so6641534276.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413861; x=1694018661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtj/MIU+MhrfFYA/6mQ0ZFw5TPY8EoiuJeVt72jrv90=;
        b=2OyjEuaQOwnA3mBz2zVrCNJn0YQnGi+c16AHjL7BiUiGK+P2VJQUYHO8A51h0AIpPa
         WKWkcxFjjwBDmDpFQL/4b0AU1cNrJ5jYpnqPmWRLQXiPhsti9BeeKJjrt8zT8f/rTaYD
         vxDMYCEgeZYQRJd1Mq2Me3y8pALkOEzzHHW2fzGVL8D0tQZlfjUcv7KCHpNp7B+Zz1y8
         oILSm6B+xnXI1joxR6LD0HiQzFmmcs9sNVeYo8fEmZpWaMnPUxheemGxiX0aAdltpWnl
         q5jTgJXFtIpSAuRdQayx1XWaty1f/PpZfgNW4iiEYsE+eIFz0CluzYz88tWpKLjU5N5b
         HriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413861; x=1694018661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtj/MIU+MhrfFYA/6mQ0ZFw5TPY8EoiuJeVt72jrv90=;
        b=ZiV9q+mb7mT7aIjdTReAI6fx4lg7bZQjVcJnwEF1XXmBCeaa5+lx8DTuDJFEUpp0RL
         fOQyG1aXkcc0Ll2rrtwv3LzaFAucj9Ri3LDIMP1FQ35/rPTEUukoyVg1TXysYOf4hPEO
         TE1BHOUQrftLgoSAvAE2lauuzVa2f7Ao8t5mSPOd5XzRbpz0Lm6h2+cJlg257swQcLRB
         F3y4cuaaqOKVYrUTg6ZWbqK973uNnZbJRvyme8ET8NYr7JuXspvkwsrrY5MidkPgi0XF
         lR5XOi8Al6rs2vV+9nEbFcm0njYXe0FmHSebvEeyeQ1E2j5nroJAGL7yx+ZP7B0QGgUH
         EaSA==
X-Gm-Message-State: AOJu0Yz2Ls+LtYvL7+X7tyym/4rytH+adsiR6Rq2bzaQ+O0e9k8gY+TA
        VlZfzvAHc0u9HCO08bg92qPhOIEaP9QFyomkgOHJ5XeuS0uG/wwxmku0SjK71vuyYOShzpE/blW
        NH5DDvbC/xvRprpsFvhoRyAF+iTsgQEMApvXWq6ULMaO4dnOfU7tBAvJ3ZoqI5N1M3Am/CDmrMd
        jT
X-Google-Smtp-Source: AGHT+IHbOxy2NvWAySbVNNaNrV+oZ/luSEhGZ7hUkR5nfBvXrndHQbECOw7K6CT/JvpClIWOHYwqtNzWCTQEIPq9XZp/
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:bc87:0:b0:d73:bcb7:7282 with
 SMTP id e7-20020a25bc87000000b00d73bcb77282mr79407ybk.8.1693413861114; Wed,
 30 Aug 2023 09:44:21 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:51 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <e0c1c1ccec9aa61fc5613aff0519f2a6dd6493fd.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 11/15] commit-graph.c: unconditionally load Bloom filters
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "SZEDER =?utf-8?B?R8OhYm9y?=" <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Taylor Blau <me@ttaylorr.com>

In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,
2023-08-01), we began ignoring the Bloom data ("BDAT") chunk for
commit-graphs whose Bloom filters were computed using a hash version
incompatible with the value of `commitGraph.changedPathVersion`.

Now that the Bloom API has been hardened to discard these incompatible
filters (with the exception of low-level APIs), we can safely load these
Bloom filters unconditionally.

We no longer want to return early from `graph_read_bloom_data()`, and
similarly do not want to set the bloom_settings' `hash_version` field as
a side-effect. The latter is because we want to wait until we know which
Bloom settings we're using (either the defaults, from the GIT_TEST
variables, or from the previous commit-graph layer) before deciding what
hash_version to use.

If we detect an existing BDAT chunk, we'll infer the rest of the
settings (e.g., number of hashes, bits per entry, and maximum number of
changed paths) from the earlier graph layer. The hash_version will be
inferred from the previous layer as well, unless one has already been
specified via configuration.

Once all of that is done, we normalize the value of the hash_version to
either "1" or "2".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-graph.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f7322c4fff..665a3edf78 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -317,12 +317,6 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 	uint32_t hash_version;
 	hash_version = get_be32(chunk_start);
 
-	if (*c->commit_graph_changed_paths_version == -1) {
-		*c->commit_graph_changed_paths_version = hash_version;
-	} else if (hash_version != *c->commit_graph_changed_paths_version) {
-		return 0;
-	}
-
 	g->chunk_bloom_data = chunk_start;
 	g->bloom_filter_settings = xmalloc(sizeof(struct bloom_filter_settings));
 	g->bloom_filter_settings->hash_version = hash_version;
@@ -2408,8 +2402,7 @@ int write_commit_graph(struct object_directory *odb,
 	ctx->write_generation_data = (get_configured_generation_version(r) == 2);
 	ctx->num_generation_data_overflows = 0;
 
-	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version == 2
-		? 2 : 1;
+	bloom_settings.hash_version = r->settings.commit_graph_changed_paths_version;
 	bloom_settings.bits_per_entry = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY",
 						      bloom_settings.bits_per_entry);
 	bloom_settings.num_hashes = git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NUM_HASHES",
@@ -2441,10 +2434,18 @@ int write_commit_graph(struct object_directory *odb,
 		/* We have changed-paths already. Keep them in the next graph */
 		if (g && g->bloom_filter_settings) {
 			ctx->changed_paths = 1;
-			ctx->bloom_settings = g->bloom_filter_settings;
+
+			/* don't propagate the hash_version unless unspecified */
+			if (bloom_settings.hash_version == -1)
+				bloom_settings.hash_version = g->bloom_filter_settings->hash_version;
+			bloom_settings.bits_per_entry = g->bloom_filter_settings->bits_per_entry;
+			bloom_settings.num_hashes = g->bloom_filter_settings->num_hashes;
+			bloom_settings.max_changed_paths = g->bloom_filter_settings->max_changed_paths;
 		}
 	}
 
+	bloom_settings.hash_version = bloom_settings.hash_version == 2 ? 2 : 1;
+
 	if (ctx->split) {
 		struct commit_graph *g = ctx->r->objects->commit_graph;
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

