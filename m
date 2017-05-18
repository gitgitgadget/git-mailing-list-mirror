Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0DFF201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbdERXXH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:07 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33786 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754937AbdERXWe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:34 -0400
Received: by mail-pg0-f41.google.com with SMTP id u187so29512228pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rq1jIklYtwWpSvZlD7c2qntX3DWeUQpJJSezpkrjZ7s=;
        b=PIom0luBDxTTDd9x1U/reT0OY4f/f08/Wrwez/JTFIoLz7J7c0U/9rmq/R9B3PDvB3
         OLNJ0jrESuWh+MA6hclusNwJ+gcor4wMwoJCkMEgQilOKFYF5f0g7riAsRfUQq0bBx9C
         316QWu1DpnCl7tkCWt4PNjofqF6OC5iQNdi4cacIvdxDc78hYarKcUKcNSOXVWHsjACj
         42UPIUOlrtRpAWWcipykBs4vDK0ZJbZmnZ1obh574vIOso3O4HXwZmlB6XgHR2Nkc/wj
         nDeqLGn5LYVI42sMxkTckcDKLEDYnA6l8R8GXYbMJtp3e7DP8i/478vc2UbBDj1c4P3C
         8CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rq1jIklYtwWpSvZlD7c2qntX3DWeUQpJJSezpkrjZ7s=;
        b=XmUwZxPseKDQJv4YK8jwO8gI5EVgatBQJYLua6vjM+zD7MsHdIVr0vKUUG+ePp9Zm3
         kPOj4pcxSV11MvCah4xa+2u6sg72DmH0nvLza4b8a9PdNgW/FWRRwE9tjUJUMAwIXMOv
         gCWMIX9DvQ/MVmPXZ3R0NnjXFF0sfEJy/m69QXhQppxd0bSAwamEnpsf4Ut6oz9lSVdo
         H1aD2f9omsdydYgPqSWcnkKkTrJZauLa4P4sbqYiyh2pt7pejCyYt0sTTqRPMeyPwbqD
         lvKNEmm+ez54GKGeEwCQFLMjCKKoW8z+5e8eAko1iLWf6uhpQghAEwNdAVOi4+oKwweq
         R9Tg==
X-Gm-Message-State: AODbwcDumfzuNH2QPLMwqgqdya7jpv/twBzxc0kO1UFZkX9XPcICNF9j
        bbaBUgatucTzOT0D
X-Received: by 10.99.38.5 with SMTP id m5mr7067553pgm.203.1495149753742;
        Thu, 18 May 2017 16:22:33 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:32 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 18/23] repo: add index_state to struct repo
Date:   Thu, 18 May 2017 16:21:29 -0700
Message-Id: <20170518232134.163059-19-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 repo.c | 19 +++++++++++++++++++
 repo.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/repo.c b/repo.c
index d47e98d95..7e5c03ac5 100644
--- a/repo.c
+++ b/repo.c
@@ -2,6 +2,20 @@
 #include "repo.h"
 
 int
+repo_read_index(struct repo *repo, const char *index_file)
+{
+	char *index_path = xstrfmt("%s/index", repo->gitdir);
+	const char *file = index_file ? index_file : index_path;
+
+	repo->index = xcalloc(1, sizeof(struct index_state));
+	if (read_index_from(repo->index, file) < 0)
+		die("failure reading index\n");
+
+	free(index_path);
+	return 0;
+}
+
+int
 repo_init(struct repo *repo, const char *gitdir, const char *worktree)
 {
 	int error = 0;
@@ -39,4 +53,9 @@ repo_clear(struct repo *repo)
 	repo->gitdir = NULL;
 	free(repo->worktree);
 	repo->worktree = NULL;
+
+	if (repo->index) {
+		discard_index(repo->index);
+		free(repo->index);
+	}
 }
diff --git a/repo.h b/repo.h
index 55f2dbec6..15a0bdee9 100644
--- a/repo.h
+++ b/repo.h
@@ -7,8 +7,10 @@ struct repo {
 	char *gitdir;
 	char *worktree;
 	const char *submodule_prefix;
+	struct index_state *index;
 };
 
+extern int repo_read_index(struct repo *repo, const char *index_file);
 extern int repo_init(struct repo *repo, const char *gitdir, const char *worktree);
 extern void repo_clear(struct repo *repo);
 
-- 
2.13.0.303.g4ebf302169-goog

