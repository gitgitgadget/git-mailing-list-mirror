Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7BC1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfFQPCP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 11:02:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36185 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 11:02:14 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so6365239qkl.3
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPOTFtv0CcsqCIi8yZyvoo7+1NTHlGnFxubPk7Jukqk=;
        b=lv8QSAosQqgsts1G9uzpGSYkBexCElccWsdHnaBHbH1QhxIRQegdlJpUTXHxBkL/+6
         4GW6Dj/sCMurRSYXbM3nyTY2gwkiUHUKZW+xD8oV5R4Al13DOwRh+aM+iPze90B65zk8
         P5c3RFJBKReDdoxSBwbe7rCqljVrq+/nXPzLj1aeU+71HIXJNqNkcAfN7T/0w4+IHSOE
         NCy5DRxQuXlspmHUHexnoRpmwddRTm0kY9/JdEVMlxEKDvtnfg/laM44GSdVJP5EjL/V
         AygCJvh9z8EybEMO0CeL38+EAztsCvvLW9JwXQp6gvO8fd6K5A/SPSNUcfelMq43R16j
         JrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPOTFtv0CcsqCIi8yZyvoo7+1NTHlGnFxubPk7Jukqk=;
        b=nT4ObhJZk06ABGdaqyRy0D37IMmE6z0TfNkiOPtCqJAwnSdoOInUT0GyykN2iIJyFG
         WsTZ52rgZc1HDoGXVu7KZWEKI5LE4ktZKUsUL24qoQxXOi/l/kxEISQSAQGu6gUr+M0Z
         q1bXP3mH0QfLNaZYIh3CK++XbkyWK22P3JlMVVh6oNG66iwleVCZK/ZrzRvyQnntttee
         OysgUCNzgxff0EmbIeskgfFDeHtnd7GOZULh/LQr7dEm4G+N9oV+FTd0+42ncqjixv0J
         2fssHR6MbrJNNZr3oqqv1qKtetplZHZ+JaKgxeI5vW/OD8//pVbpH8U1Dyjx32ehdyiQ
         w0Vw==
X-Gm-Message-State: APjAAAWeMqiA7hwqxQ4zby/S0UXHECg8rY8+6e+921Hw94mJKdTQ18Mf
        o2EiUUCPOTVMoPsQ/QF0LYFQ+sMj
X-Google-Smtp-Source: APXvYqyl8RFSKBDpi1FaVNacVCzksVC0Og6rO1qPqR9T6mGT99IzduDjpFIah3L06tlsu0S3A7QQ7g==
X-Received: by 2002:a05:620a:13ec:: with SMTP id h12mr37789963qkl.266.1560783733142;
        Mon, 17 Jun 2019 08:02:13 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:a800:1012:6e6a:2b95:41d:be6b])
        by smtp.gmail.com with ESMTPSA id t8sm8503458qtc.80.2019.06.17.08.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:02:12 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] commit-graph: normalize commit-graph filenames
Date:   Mon, 17 Jun 2019 11:02:07 -0400
Message-Id: <20190617150207.16849-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.430.g4f3aec613b
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing commit-graph files, we append path data to an
object directory, which may be specified by the user via the
'--object-dir' option. If the user supplies a trailing slash,
or some other alternative path format, the resulting path may
be usable for writing to the correct location. However, when
expiring graph files from the <obj-dir>/info/commit-graphs
directory during a write, we need to compare paths with exact
string matches.

Normalize the commit-graph filenames to avoid ambiguity. This
creates extra allocations, but this is a constant multiple of
the number of commit-graph files, which should be a number in
the single digits.

To complete the effectiveness, we need to use the filename
methods when iterating over the info/commit-graphs directory
instead of constructing the paths manually.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

Junio,

I noticed the need for this patch while integrating the
split commit-graph series into VFS for Git, since our
C# code was storing the alternates directory with a trailing
slash, causing some confusion in the expire logic.

This could be added to ds/commit-graph-incremental (and I
could add it to a future revision, if necessary) or could
be a new branch on top of that series.

Thanks,
-Stolee

 commit-graph.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8842f93910..e0f3e8a954 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -43,15 +43,23 @@
 
 char *get_commit_graph_filename(const char *obj_dir)
 {
-	return xstrfmt("%s/info/commit-graph", obj_dir);
+	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
+	char *normalized = xmalloc(strlen(filename) + 1);
+	normalize_path_copy(normalized, filename);
+	free(filename);
+	return normalized;
 }
 
 static char *get_split_graph_filename(const char *obj_dir,
 				      const char *oid_hex)
 {
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph",
-		       obj_dir,
-		       oid_hex);
+	char *filename = xstrfmt("%s/info/commit-graphs/graph-%s.graph",
+				 obj_dir,
+				 oid_hex);
+	char *normalized = xmalloc(strlen(filename) + 1);
+	normalize_path_copy(normalized, filename);
+	free(filename);
+	return normalized;
 }
 
 static char *get_chain_filename(const char *obj_dir)
@@ -1680,7 +1688,6 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 	struct strbuf path = STRBUF_INIT;
 	DIR *dir;
 	struct dirent *de;
-	size_t dirnamelen;
 	timestamp_t expire_time = time(NULL);
 
 	if (ctx->split_opts && ctx->split_opts->expire_time)
@@ -1701,16 +1708,13 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 		return;
 	}
 
-	strbuf_addch(&path, '/');
-	dirnamelen = path.len;
 	while ((de = readdir(dir)) != NULL) {
 		struct stat st;
 		uint32_t i, found = 0;
 
-		strbuf_setlen(&path, dirnamelen);
-		strbuf_addstr(&path, de->d_name);
+		char *filename = get_split_graph_filename(path.buf, de->d_name);
 
-		stat(path.buf, &st);
+		stat(filename, &st);
 
 		if (st.st_mtime > expire_time)
 			continue;
@@ -1719,15 +1723,16 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
 			if (!strcmp(ctx->commit_graph_filenames_after[i],
-				    path.buf)) {
+				    filename)) {
 				found = 1;
 				break;
 			}
 		}
 
 		if (!found)
-			unlink(path.buf);
+			unlink(filename);
 
+		free(filename);
 	}
 }
 
-- 
2.22.0.430.g4f3aec613b

