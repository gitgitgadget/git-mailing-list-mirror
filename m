Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF97C83F29
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjH3S3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343753AbjH3Qo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90C19A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc448ee4fso78589367b3.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413863; x=1694018663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHuRnI8rdlErjK9WrL45txbbQojHZ2GJn7LZ5ZUyjaE=;
        b=nZmUi9rmUE75u2KKZS8bLKISjhhRCsM13hvWZplX5zDbk1mYZOayfR9zloi/kjDlfh
         ziCPMm+GTXXwmoPZjAq5z/1ThdLcyy0bQqUwTTGI67TC9t9LVSti8sFpsWEd6RjbATNU
         WIMLG80rnDR/CnDtXtbftrvNxi1sgopJKzQtcR1zk5kSeZdBjJE+668Sa9Odk9uyqMEk
         Sm3+FpafOLdhmSAe4boUaXf/7C/mEPu5qfAjxXLeYDmsYr8t4mdtgTg9gRkdmgfMQNhQ
         Whh7B5VImAlrcZ6eumM3GaBNE8P8LsoRQP3xYR1359WmGnyveBFTaNkmw6TP/bQ68Eta
         AuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413863; x=1694018663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHuRnI8rdlErjK9WrL45txbbQojHZ2GJn7LZ5ZUyjaE=;
        b=NwiIg+hX/3ci6AsgoOEtCx/ZnVWWFyKd0RdatAXd6DxH2zyDiPJnXcwywxjrRmq5qg
         frArXgmbDGqNdQnzGpMJGOIBZpEQdNUwGz7inHivPazzHGE2Zm0zh9sRSZ9hu1Rt7Evq
         0gLWib5Ran8QRBb1uCaJbO6+aUJaFj3Yy4a9GonugGSkjNk5u+R1v7luwZr6oTIlAOv2
         CTA1iUyzI3kZzYR8BXScIAowQ21yhm3tnPl1AtVKg/zTlTJjcyYwcccYIHy+axrpyL8p
         NQDTLRrUVL+mPD7oRQUtmjtxzaXGfcSBDpJKrLUxFF+JiYscPF9Awi4PkRlba0qUFcRa
         uAcA==
X-Gm-Message-State: AOJu0Yx0bycMVoTUHP837oIljsfJXhYBUPDtEVT3cw5MSbcgtGTK4/GZ
        QERofFjsUaz4B+FeLUR5BlXUAGbjA7hqOAUEvYZOUuS0QXSX/IwSPlXebI511xgF21LSgWTCURv
        /xe445ta2ytSxHNrsZTdp0c8T4oOtY4ol3HaX23F50wc8HXthBDhg3haA1IQsGHAUaH02VaXNOO
        dO
X-Google-Smtp-Source: AGHT+IHymCuw2hpm06AT5zfvYtrd/QrbcmYpvmaTc3jErYv8t/ddPzHkWMODwwAojcGWIk6TlAkS2XH+ARC3XerTrE8Q
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:bd07:0:b0:586:50cf:e13f with
 SMTP id b7-20020a81bd07000000b0058650cfe13fmr79306ywi.1.1693413862954; Wed,
 30 Aug 2023 09:44:22 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:52 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <4d57f5185400fd44956b596fe8c32cbd1ba185de.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 12/15] commit-graph: drop unnecessary `graph_read_bloom_data_context`
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

The `graph_read_bloom_data_context` struct was introduced in an earlier
commit in order to pass pointers to the commit-graph and changed-path
Bloom filter version when reading the BDAT chunk.

The previous commit no longer writes through the changed_paths_version
pointer, making the surrounding context structure unnecessary. Drop it
and pass a pointer to the commit-graph directly when reading the BDAT
chunk.

Noticed-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit-graph.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 665a3edf78..a8e33c0739 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -304,16 +304,10 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
-struct graph_read_bloom_data_context {
-	struct commit_graph *g;
-	int *commit_graph_changed_paths_version;
-};
-
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
-	struct graph_read_bloom_data_context *c = data;
-	struct commit_graph *g = c->g;
+	struct commit_graph *g = data;
 	uint32_t hash_version;
 	hash_version = get_be32(chunk_start);
 
@@ -405,14 +399,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_changed_paths_version) {
-		struct graph_read_bloom_data_context context = {
-			.g = graph,
-			.commit_graph_changed_paths_version = &s->commit_graph_changed_paths_version
-		};
 		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
 			   &graph->chunk_bloom_indexes);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
-			   graph_read_bloom_data, &context);
+			   graph_read_bloom_data, graph);
 	}
 
 	if (graph->chunk_bloom_indexes && graph->chunk_bloom_data) {
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

