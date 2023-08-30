Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DCFC83F23
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjH3S3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343744AbjH3QoM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 12:44:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986C19A
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7b9eb73dcdso1294861276.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693413843; x=1694018643; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=40QUFdrrZDF9ZPnRhPDyIilLn4FiUKdNlrwqCPe1dik=;
        b=Y2Ine4hIlUo1EqLEC5Kr6YNWd9uruunTtUi2I7iYHXbgwLzOfyzT+Bd8lqB8MPvK88
         ZPlxMJgIK1eThr2msBOptFSDrBQyT7jC7uDd9Xm3r7rNj3o9FDkR2cD4HYb/M1fvO5/R
         pRiBhC4+8Sn0k3oYaFTT9/AP6HaeyZ54VHcj5IBAkuJ8ngFYhiiNc0qVILuukVhNEzbI
         nzjKOvAZyl36IhamGUe1xjzxpIcH5fw2IgMXLHb0CR19N6PTmXo9JUMffYJ4enDfqPFK
         TdSYEOdxBCpnGYRRlTHH255vn6Bif7hPMK7CE0Nl7CY9DlmNmRE1wwe2Do1ZPBRHEh2W
         oUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413843; x=1694018643;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40QUFdrrZDF9ZPnRhPDyIilLn4FiUKdNlrwqCPe1dik=;
        b=PZDmPgOl8PShxODUh+z61SB9CaXiOwj9VHwhkjwmVyFOSvqcN2xHnW3+14N4lmbNRP
         uFpfsDcp8Lcwy+2PBR61dcxjX6yDFPDZFo2xpzw3QX8sUPhOVYWYjknOPr4eKnPU2G1B
         fCQEh/H/hSYQBKUMJ1eDb8EOG9RZf0ikmLNS2w4HRx3TfUCzPWUwXyXR4W30xdKYiJ6B
         8+CAOQmRGBBloCkRFO6J/+XdwMGuZS4lVAZZwVDrz7xquLI82XJgNahpMgPS7FXLxeP1
         NwNrJcWyFN5DRpXwyBxPi1XhZ+XG5gex7ii4ODvwt7112V1mvTmI/93AUC7hiJwjcDrC
         C3UQ==
X-Gm-Message-State: AOJu0YwE8iy3hBG3pUvFAMj/J1J3vfL/O/CW0kaEtOZBDAbDmwsSD4E4
        uQ78LUq+ozagkkGQV0qArYb1uQcFxKDfynZHA/o1oVOrvdKkIC5/HucRMS//lwXnOKkjPojY8Ia
        MWXvTTTR3yMn8E+VdF3tLuBhqoAriJtQy2WvEi9KeC7Rpsr0RADfT83SnYkanGKszDQ4em+TJCM
        kh
X-Google-Smtp-Source: AGHT+IEAM6BhjpaMkrpZ7pR9Vpni2V4ZHMzvkvFHEoCq3II7dAvRZQGulVopb9Qo6TjhWubqIiM7Twx+m+JOvW/CG95z
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:2899:32d6:b7e3:8e6e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d383:0:b0:d7a:c493:f570 with
 SMTP id e125-20020a25d383000000b00d7ac493f570mr79035ybf.1.1693413843343; Wed,
 30 Aug 2023 09:44:03 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:43:42 -0700
In-Reply-To: <cover.1693413637.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1692654233.git.me@ttaylorr.com> <cover.1693413637.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <0c56f2a9e970b0ba2063c87254cd8e5d24f506de.1693413637.git.jonathantanmy@google.com>
Subject: [PATCH v2 02/15] t/helper/test-read-graph.c: extract `dump_graph_info()`
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

Prepare for the 'read-graph' test helper to perform other tasks besides
dumping high-level information about the commit-graph by extracting its
main routine into a separate function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-read-graph.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 8c7a83f578..3375392f6c 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -5,20 +5,8 @@
 #include "bloom.h"
 #include "setup.h"
 
-int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+static void dump_graph_info(struct commit_graph *graph)
 {
-	struct commit_graph *graph = NULL;
-	struct object_directory *odb;
-
-	setup_git_directory();
-	odb = the_repository->objects->odb;
-
-	prepare_repo_settings(the_repository);
-
-	graph = read_commit_graph_one(the_repository, odb);
-	if (!graph)
-		return 1;
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
@@ -57,6 +45,23 @@ int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
 	if (graph->topo_levels)
 		printf(" topo_levels");
 	printf("\n");
+}
+
+int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
+{
+	struct commit_graph *graph = NULL;
+	struct object_directory *odb;
+
+	setup_git_directory();
+	odb = the_repository->objects->odb;
+
+	prepare_repo_settings(the_repository);
+
+	graph = read_commit_graph_one(the_repository, odb);
+	if (!graph)
+		return 1;
+
+	dump_graph_info(graph);
 
 	UNLEAK(graph);
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

