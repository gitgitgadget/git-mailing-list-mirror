Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F8C83F17
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjH3S3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbjH3QoN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4841A3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58d9e327d3aso78599897b3.3
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413846; x=1694018646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uC2JFGNAOhYsPuPpZuh5TqQsTwfLN0uDDymzZBtqK6M=;
        b=5XeLst22qUZbxSoyTLffQmsNbAQIlT5yP1SgXCylOcTJaVMDroFqAeJJio0jt5OJfL
         ej7df7+hzYkOhYQwj9FSeWc5ceyTevC2WirjSe5GYV6ygPMYqZl67s1ueVIzKhh3f52S
         Dh+ZE8Gl3I6qXXobHNXvkfxqIO9eCq9A79DkKRs+YRUwNb8RpIfwPsJVmb1zHQaZpVVv
         9bgxAi2cvIk75uSxSRCjCPISoSdtaMUGZdzY02Ws5Ix63UQVKSh2p8yzKPLvEZYy7fqH
         TGNmmNw4L5vc60hC6oxCssUdhi05Xp2zQcpKYrq8xrFAFtby3FGlXQbxIhWnv2a+NUPG
         j3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413846; x=1694018646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC2JFGNAOhYsPuPpZuh5TqQsTwfLN0uDDymzZBtqK6M=;
        b=YAy6/8eFikU4h4/ofDJ8Q10pSVZj0eWF/1Yp0OjviAr3o4J5sbw6yG/jqzsksHhkzj
         W1n69Ws1cK1Vkvun73VIz5Nh4GX3QNQFF/fZ5E0GTg+wDKOnik49XZ6NFdZ8hDI5AWN9
         uLPK+U+NaHOxZZbcaW6ktrY/24cyjBl5KsDh6M1HgLSEHCG4N+zJNH/zUSRkByh6d50V
         ue7SzUKiBa+Plwrabylfch+wJcMUsK1AX0VC02EK26oAdl6QCVmEEVgai+IatULdxPeq
         jv+lu8Qt94NLuSei80BgzcPFl3HZZxn9wxzijXix46HT4rLBRU87OnEwaAEsC+OwCooS
         +MHw==
X-Gm-Message-State: AOJu0Yzao1hh8H9g6wdzUrvS+9reoLwvp0OmKaKX9feRe3d789Qj3XQo
        VyGw6EKW/UOTeOvZeEORDpX44dqcw88nuJJ5obvWWYCd5FyCQX178OEX8XhxZOU1+I2i+tm7dsU
        heXD3bZlAhtDVqw26+3cb+GZiQt7TxjozqBog71BF46fHzrt4IR4p/AzTO9bY4ZgvorC1zhEoq4
        Gf
X-Google-Smtp-Source: AGHT+IE1r07DKY7gjzbovmL2OvnZgk9MxXGopkVxYaS/ZeawjsA2iRzAMKe80CF4HyxrbEhriU3UUKes3VP9pc7fHPLP
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a785:0:b0:579:e07c:2798 with
 SMTP id e127-20020a81a785000000b00579e07c2798mr82919ywh.2.1693413846697; Wed,
 30 Aug 2023 09:44:06 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:44 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <3a25f90c15b65df29c31b205346d303abd54ce96.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 04/15] t/helper/test-read-graph: implement `bloom-filters` mode
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

Implement a mode of the "read-graph" test helper to dump out the
hexadecimal contents of the Bloom filter(s) contained in a commit-graph.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-read-graph.c | 42 +++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 3375392f6c..899b5f41cc 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -47,10 +47,32 @@ static void dump_graph_info(struct commit_graph *graph)
 	printf("\n");
 }
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_bloom_filters(struct commit_graph *graph)
+{
+	uint32_t i;
+
+	for (i = 0; i < graph->num_commits + graph->num_commits_in_base; i++) {
+		struct bloom_filter filter = { 0 };
+		size_t j;
+
+		if (load_bloom_filter_from_graph(graph, &filter, i) < 0) {
+			fprintf(stderr, "missing Bloom filter for graph "
+				"position %"PRIu32"\n", i);
+			continue;
+		}
+
+		for (j = 0; j < filter.len; j++)
+			printf("%02x", filter.data[j]);
+		if (filter.len)
+			printf("\n");
+	}
+}
+
+int cmd__read_graph(int argc, const char **argv)
 {
 	struct commit_graph *graph = NULL;
 	struct object_directory *odb;
+	int ret = 0;
 
 	setup_git_directory();
 	odb = the_repository->objects->odb;
@@ -58,12 +80,22 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	prepare_repo_settings(the_repository);
 
 	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
+	if (!graph) {
+		ret = 1;
+		goto done;
+	}
 
-	dump_graph_info(graph);
+	if (argc <= 1)
+		dump_graph_info(graph);
+	else if (!strcmp(argv[1], "bloom-filters"))
+		dump_graph_bloom_filters(graph);
+	else {
+		fprintf(stderr, "unknown sub-command: '%s'\n", argv[1]);
+		ret = 1;
+	}
 
+done:
 	UNLEAK(graph);
 
-	return 0;
+	return ret;
 }
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

